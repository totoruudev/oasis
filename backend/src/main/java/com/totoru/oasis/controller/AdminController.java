package com.totoru.oasis.controller;

import com.totoru.oasis.dto.*;
import com.totoru.oasis.entity.Category;
import com.totoru.oasis.entity.SubCategory;
import com.totoru.oasis.entity.User;
import com.totoru.oasis.repository.*;
import com.totoru.oasis.service.*;
import jakarta.persistence.EntityNotFoundException;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000", allowCredentials = "true")
public class AdminController {

    private final UserService userService;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final ProductService productService;
    private final OrderRepository orderRepository;
    private final OrderService orderService;
    private final CategoryService categoryService;
    private final CategoryRepository categoryRepository;
    private final SubCategoryRepository subCategoryRepository;
    private final ImageService imageService;

    public record AdminReviewDto(
            Long id,
            String content,
            int rating,
            String username,
            String productName,
            String imagePath,
            LocalDateTime createdAt
    ) {}

    // 💻 관리자 페이지 메인 화면
    @GetMapping("/summary")
    public ResponseEntity<Map<String, Object>> getAdminSummary() {
        Map<String, Object> summary = new HashMap<>();

        // 통계 수치
        summary.put("userCount", userRepository.count());
        summary.put("productCount", productRepository.count());
        summary.put("orderCount", orderRepository.count());


        // 최근 주문 5개
        List<Map<String, Object>> recentOrders = orderRepository.findTop5ByOrderByCreatedAtDesc()
                .stream()
                .map(order -> {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", order.getId());
                    map.put("totalAmount", order.getTotalAmount());
                    String username;
                    try {
                        User user = order.getUser();
                        username = (user != null) ? user.getUsername() : "비회원";
                    } catch (EntityNotFoundException e) {
                        username = "삭제된 사용자";
                    }
                    map.put("username", username);
                    return map;
                })
                .collect(Collectors.toList());

        summary.put("recentOrders", recentOrders);

        return ResponseEntity.ok(summary);
    }

    // 😀 회원 관리
    // 전체/검색/페이지네이션
    @GetMapping("/users")
    public ResponseEntity<?> list(
            @RequestParam(defaultValue = "") String search,
            @RequestParam(defaultValue = "1") int page
    ) {
        int pageSize = 10;
        return ResponseEntity.ok(userService.getUserList(search, page, pageSize));
    }

    // 상세
    @GetMapping("/users/{id}")
    public ResponseEntity<UserDto> getUserDetail(@PathVariable Long id) {
        return userService.getUserDetail(id)
                .map(user -> ResponseEntity.ok(UserDto.from(user)))
                .orElseThrow(() -> new EntityNotFoundException("해당 회원을 찾을 수 없습니다: id=" + id));
    }

    // 삭제
    @DeleteMapping("/users/{id}")
    public ResponseEntity<?> delete(@PathVariable Long id) {
        userService.adminDeleteUser(id);
        return ResponseEntity.ok("삭제 완료");
    }


    // 🚚 주문 전체 목록
    @GetMapping("/orders")
    public Page<OrderResponse> getPagedOrders(
            @PageableDefault(sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable
    ) {
        return orderRepository.findAll(pageable)
                .map(order -> {
                    String username;
                    try {
                        username = (order.getUser() != null) ? order.getUser().getUsername() : "비회원";
                    } catch (EntityNotFoundException e) {
                        username = "삭제된 사용자";
                    }

                    return new OrderResponse(
                            order.getId(),
                            username,
                            order.getTotalAmount(),
                            order.getStatus(),
                            order.getCreatedAt()
                    );
                });
    }

    @PatchMapping("/orders/{orderId}/status")
    public ResponseEntity<?> updateOrderStatusByAdmin(
            @PathVariable Long orderId,
            @RequestBody Map<String, String> body
    ) {
        String status = body.get("status");
        orderService.updateOrderStatus(orderId, status);
        return ResponseEntity.ok("상태 변경 완료");
    }

    // 🎁 상품 관리
    @GetMapping("/products")
    public Page<ProductDto> getPagedProducts(
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) Long subCategoryId,
            @PageableDefault(size = 10, sort = "id", direction = Sort.Direction.DESC) Pageable pageable
    ) {
        return productService.getProductList(pageable, categoryId, subCategoryId);
    }

    @GetMapping("/categories")
    public List<Category> getAdminCategories() {
        return categoryRepository.findAll();
    }

    // === 2. 관리자 전용 서브카테고리 전체 조회 (categoryId 필요) ===
    @GetMapping("/subcategories")
    public List<SubCategory> getAdminSubCategories(@RequestParam Long categoryId) {
        return subCategoryRepository.findByCategoryId(categoryId);
    }

    // === 3. 관리자 이미지 서빙 ===
    @Value("${file.upload-dir}")
    private String uploadDir;

    @Value("${file.legacy-dir}")
    private String legacyDir;

    @GetMapping("/images/products/{filename:.+}")
    public ResponseEntity<Resource> serveProductImage(@PathVariable String filename) {
        // 현재 작업 폴더 기준 상대경로
        Path uploadPath = Paths.get(uploadDir, filename);
        Path legacyPath = Paths.get(legacyDir, filename);

        try {
            Resource resource = new UrlResource(uploadPath.toUri());
            if (resource.exists() && resource.isReadable()) {
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + filename + "\"")
                        .contentType(MediaType.IMAGE_JPEG)
                        .body(resource);
            }
            resource = new UrlResource(legacyPath.toUri());
            if (resource.exists() && resource.isReadable()) {
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + filename + "\"")
                        .contentType(MediaType.IMAGE_JPEG)
                        .body(resource);
            }
        } catch (Exception ignored) {}
        return ResponseEntity.notFound().build();
    }

    @PostMapping("/categories")
    public ResponseEntity<Category> createCategory(@RequestBody CategoryDto dto) {
        return ResponseEntity.ok(categoryService.createCategory(dto));
    }

    @PostMapping("/categories/sub")
    public ResponseEntity<SubCategory> createSubCategory(@RequestBody SubCategoryDto dto) {
        return ResponseEntity.ok(categoryService.createSubCategory(dto));
    }

    @GetMapping
    public ResponseEntity<List<Category>> listCategories() {
        return ResponseEntity.ok(categoryService.getAllCategories());
    }

    @GetMapping("/products/{id}")
    public ResponseEntity<ProductDto> getProductById(@PathVariable Long id) {
        // 상품 서비스에서 ProductDto 반환
        ProductDto product = productService.getProductById(id);
        if (product == null) {
            throw new EntityNotFoundException("상품이 존재하지 않습니다. id=" + id);
        }
        return ResponseEntity.ok(product);
    }

    @PostMapping("/products")
    public ResponseEntity<ProductDto> createProduct(@RequestBody ProductDto dto) {
        ProductDto saved = productService.createProduct(dto);
        return ResponseEntity.ok(saved);
    }

    @PutMapping("/products/{id}")
    public ResponseEntity<ProductDto> updateProduct(@PathVariable Long id, @RequestBody ProductDto dto) {
        ProductDto updated = productService.updateProduct(id, dto);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/products/{id}")
    public ResponseEntity<Void> deleteProduct(@PathVariable Long id) {
        productService.deleteProduct(id);
        return ResponseEntity.noContent().build();
    }

    // 🤖 AI 이미지
    // 1. 이미지 생성 (텍스트 → 이미지)
    @PostMapping(value = "/images/generate", produces = MediaType.IMAGE_PNG_VALUE)
    public ResponseEntity<byte[]> generateImage(@RequestBody GenerateImageRequestDto request) {
        String base64Image = imageService.generateImage(request.getPrompt());
        // Base64 → 이미지 디코딩
        byte[] imageBytes = Base64.getDecoder().decode(base64Image);
        return ResponseEntity
                .ok()
                .contentType(MediaType.IMAGE_PNG)
                .body(imageBytes);
    }

    // 2. 이미지 편집 (마스크)
    @PostMapping(value = "/images/edit", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.IMAGE_PNG_VALUE)
    public ResponseEntity<byte[]> editImage(
            @RequestPart("image") MultipartFile image,
            @RequestPart("mask") MultipartFile mask,
            @RequestPart("prompt") String prompt) throws Exception {
        byte[] imageBytes = image.getBytes();
        byte[] maskBytes = mask.getBytes();
        String base64Image = imageService.editImage(imageBytes, maskBytes, prompt);

        byte[] decodedImage = Base64.getDecoder().decode(base64Image);
        return ResponseEntity.ok()
                .contentType(MediaType.IMAGE_PNG)
                .body(decodedImage);
    }

    // 3. 이미지 변형 (Variation)
    @PostMapping(value = "/images/variation", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.IMAGE_PNG_VALUE)
    public ResponseEntity<byte[]> variationImage(@RequestPart("image") MultipartFile image) throws Exception {
        byte[] imageBytes = image.getBytes();
        String base64Image = imageService.variationImage(imageBytes);
        byte[] decodedImage = Base64.getDecoder().decode(base64Image);
        return ResponseEntity.ok()
                .contentType(MediaType.IMAGE_PNG)
                .body(decodedImage);
    }

    // DTO
    @Data
    static class GenerateImageRequestDto {
        private String prompt;
    }

    @Data
    @AllArgsConstructor
    static class ImageResponseDto {
        private String base64Image; // b64_json 문자열 (base64 encoded png)
    }

}
