package com.totoru.oasis.controller;

import com.totoru.oasis.dto.OrderResponse;
import com.totoru.oasis.dto.ProductDto;
import com.totoru.oasis.entity.*;
import com.totoru.oasis.repository.*;
import com.totoru.oasis.service.ImageService;
import com.totoru.oasis.service.OrderService;
import com.totoru.oasis.service.ProductService;
import jakarta.persistence.EntityNotFoundException;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
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

    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final ProductService productService;
    private final OrderRepository orderRepository;
    private final OrderService orderService;
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


    // ✅ 사용자 전체 목록
    @GetMapping("/users")
    public Page<User> getUsers(
            @PageableDefault(size = 10, sort = "id", direction = Sort.Direction.DESC) Pageable pageable
    ) {
        return userRepository.findAll(pageable);
    }

    // ✅ 주문 전체 목록
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

    // ✅ 상품 전체 목록
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
    @GetMapping("/images/products/{filename:.+}")
    public ResponseEntity<Resource> serveAdminProductImage(@PathVariable String filename) {
        try {
            // ※ 실제 이미지 저장 경로에 맞게 바꿔주세요!
            Path imagePath = Paths.get("/images/products").resolve(filename); // 예: "C:/oasis/uploads/products"
            Resource resource = new UrlResource(imagePath.toUri());
            if (resource.exists() && resource.isReadable()) {
                // 이미지 확장자에 따라 contentType 다르게 하고 싶으면 별도 처리
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + filename + "\"")
                        .contentType(MediaType.IMAGE_JPEG)
                        .body(resource);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
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


    // ✅ 사용자 삭제 (관리자용)
    @DeleteMapping("/users/{id}")
    public ResponseEntity<?> deleteUserByAdmin(@PathVariable Long id) {
        if (!userRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        userRepository.deleteById(id);
        return ResponseEntity.ok("삭제 완료");
    }

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
