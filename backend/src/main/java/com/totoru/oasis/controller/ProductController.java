package com.totoru.oasis.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.totoru.oasis.dto.ProductDto;
import com.totoru.oasis.entity.Category;
import com.totoru.oasis.entity.Product;
import com.totoru.oasis.repository.CategoryRepository;
import com.totoru.oasis.repository.ProductRepository;
import com.totoru.oasis.repository.SubCategoryRepository;
import com.totoru.oasis.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/products")
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000", allowCredentials = "true")
public class ProductController {

    private final ProductService productService;
    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final SubCategoryRepository subCategoryRepository;

    // 1. 섹션별 상품(메인)
    @GetMapping("/sections")
    public ResponseEntity<?> getProductSections() {
        return ResponseEntity.ok(productService.getSectionedProducts());
    }

    // 2. 상품 등록 (응답: ProductDto)
    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<ProductDto> createProduct(
            @RequestPart("product") String productJson,
            @RequestPart(value = "thumbnailFile", required = false) MultipartFile thumbnail,
            @RequestPart(value = "detailFile", required = false) MultipartFile detail
    ) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            Product product = objectMapper.readValue(productJson, Product.class);
            Product saved = productService.saveWithImages(product, thumbnail, detail);
            return ResponseEntity.ok(ProductDto.from(saved));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    // 3. 상품 수정 (응답: ProductDto)
    @PutMapping(value = "/{id}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<ProductDto> updateProduct(
            @PathVariable Long id,
            @RequestPart("product") String productJson,
            @RequestPart(value = "thumbnailFile", required = false) MultipartFile thumbnail,
            @RequestPart(value = "detailFile", required = false) MultipartFile detail
    ) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            Product product = objectMapper.readValue(productJson, Product.class);
            Product updated = productService.updateWithImages(id, product, thumbnail, detail);
            return ResponseEntity.ok(ProductDto.from(updated));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    // 4. 상품 리스트 (카테고리별/전체)
    @GetMapping
    public ResponseEntity<List<ProductDto>> list(@RequestParam(required = false) String category) {
        List<Product> products;
        if (category != null && !category.isEmpty()) {
            Optional<Category> cate = categoryRepository.findByName(category);
            products = cate.map(value -> productRepository.findByCategoryAndActiveTrueOrderByCreatedAtDesc(value))
                    .orElse(Collections.emptyList());
        } else {
            products = productRepository.findAllByActiveTrueOrderByCreatedAtDesc();
        }
        List<ProductDto> result = products.stream()
                .map(ProductDto::from)
                .collect(Collectors.toList());
        return ResponseEntity.ok(result);
    }

    // 5. 최신 상품 8개
    @GetMapping("/latest")
    public ResponseEntity<List<ProductDto>> latestProducts() {
        List<ProductDto> latest = productRepository.findTop8ByOrderByCreatedAtDesc()
                .stream().map(ProductDto::from).collect(Collectors.toList());
        return ResponseEntity.ok(latest);
    }

    // 6. 인기 상품 8개
    @GetMapping("/popular")
    public ResponseEntity<List<ProductDto>> getPopularProducts() {
        List<ProductDto> popular = productRepository.findTop8ByOrderByViewsDesc()
                .stream().map(ProductDto::from).collect(Collectors.toList());
        return ResponseEntity.ok(popular);
    }

    // 7. 카테고리 이름만 중복 없이 (이 부분은 그대로)
    @GetMapping("/categories")
    public ResponseEntity<List<Category>> getCategories() {
        return ResponseEntity.ok(productRepository.findDistinctCategoryEntities());
    }

    // 8. 상품 상세 (Dto 반환, 조회수 up)
    @GetMapping("/{id:\\d+}")
    public ResponseEntity<ProductDto> detail(@PathVariable("id") Long id) {
        Optional<Product> optionalProduct = productRepository.findById(id);
        if (optionalProduct.isPresent()) {
            Product product = optionalProduct.get();
            product.setViews(product.getViews() + 1);
            productService.save(product);
            return ResponseEntity.ok(ProductDto.from(product));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // 9. 상품 삭제
    @DeleteMapping("/{id:\\d+}")
    public ResponseEntity<Void> delete(@PathVariable("id") Long id) {
        productService.delete(id);
        return ResponseEntity.ok().build();
    }

    // 10. 서브카테고리 전체 조회 (동일)
    @GetMapping("/subcategories")
    public ResponseEntity<?> getSubCategories() {
        return ResponseEntity.ok(productService.getAllSubCategories());
    }
}