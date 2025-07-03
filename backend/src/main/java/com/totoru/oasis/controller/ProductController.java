package com.totoru.oasis.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.totoru.oasis.entity.Product;
import com.totoru.oasis.entity.Category;
import com.totoru.oasis.repository.CategoryRepository;
import com.totoru.oasis.repository.ProductRepository;
import com.totoru.oasis.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/products")
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000", allowCredentials = "true")
public class ProductController {

    private final ProductService productService;
    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;

    // 1. 섹션별 상품(메인에서 여러 섹션 단위로 조회)
    @GetMapping("/sections")
    public ResponseEntity<?> getProductSections() {
        return ResponseEntity.ok(productService.getSectionedProducts());
    }

    // 2. 상품 등록
    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<Product> createProduct(
            @RequestPart("product") String productJson,
            @RequestPart(value = "thumbnailFile", required = false) MultipartFile thumbnail,
            @RequestPart(value = "detailFile", required = false) MultipartFile detail
    ) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            Product product = objectMapper.readValue(productJson, Product.class);
            Product saved = productService.saveWithImages(product, thumbnail, detail);
            return ResponseEntity.ok(saved);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    // 3. 상품 수정
    @PutMapping(value = "/{id}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<Product> updateProduct(
            @PathVariable Long id,
            @RequestPart("product") String productJson,
            @RequestPart(value = "thumbnailFile", required = false) MultipartFile thumbnail,
            @RequestPart(value = "detailFile", required = false) MultipartFile detail
    ) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            Product product = objectMapper.readValue(productJson, Product.class);
            Product updated = productService.updateWithImages(id, product, thumbnail, detail);
            return ResponseEntity.ok(updated);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    // 4. 상품 리스트 (카테고리별/전체)
    @GetMapping
    public ResponseEntity<List<Product>> list(@RequestParam(required = false) String category) {
        if (category != null && !category.isEmpty()) {
            Optional<Category> cate = categoryRepository.findByName(category);
            if (cate.isPresent()) {
                return ResponseEntity.ok(productRepository.findByCategoryAndActiveTrueOrderByCreatedAtDesc(cate.get()));
            } else {
                return ResponseEntity.ok(Collections.emptyList());
            }
        } else {
            return ResponseEntity.ok(productRepository.findAllByActiveTrueOrderByCreatedAtDesc());
        }
    }

    // 5. 최신 상품 8개
    @GetMapping("/latest")
    public ResponseEntity<List<Product>> latestProducts() {
        List<Product> latest = productRepository.findTop8ByOrderByCreatedAtDesc();
        return ResponseEntity.ok(latest);
    }

    // 6. 인기 상품 8개
    @GetMapping("/popular")
    public ResponseEntity<List<Product>> getPopularProducts() {
        List<Product> popular = productRepository.findTop8ByOrderByViewsDesc();
        return ResponseEntity.ok(popular);
    }

    // 7. 카테고리 이름만 중복 없이
    @GetMapping("/categories")
    public ResponseEntity<List<Category>> getCategories() {
        return ResponseEntity.ok(productRepository.findDistinctCategoryEntities());
    }


    // 8. 상품 상세(숫자만 허용)
    @GetMapping("/{id:\\d+}")
    public ResponseEntity<Product> detail(@PathVariable("id") Long id) {
        Optional<Product> optionalProduct = productService.findById(id);
        if (optionalProduct.isPresent()) {
            Product product = optionalProduct.get();
            product.setViews(product.getViews() + 1);
            productService.save(product);
            return ResponseEntity.ok(product);
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
}
