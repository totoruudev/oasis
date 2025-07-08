package com.totoru.oasis.controller;

import com.totoru.oasis.dto.ProductDto;
import com.totoru.oasis.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/products")
public class ProductController {

    private final ProductService productService;

    // [섹션별 상품리스트]
    @GetMapping("/sections")
    public Map<String, Object> getSectionedProducts() {
        return productService.getSectionedProducts();
    }

    // [서브카테고리별 상품리스트]
    @GetMapping("/subcategory/{id}")
    public List<ProductDto> getProductsBySubCategory(@PathVariable("id") Long subCategoryId) {
        return productService.getProductsBySubCategory(subCategoryId);
    }

    // [전체 상품 리스트 조회]
    @GetMapping("")
    public List<ProductDto> getAllProducts() {
        return productService.getAllActiveProducts();
    }


    // [상품 상세 조회]
    @GetMapping("/{id}")
    public ProductDto getProductById(@PathVariable("id") Long id) {
        return productService.getProductById(id);
    }

    // [카테고리별 상품 리스트 (페이징)]
    @GetMapping("/category/{categoryId}")
    public Page<ProductDto> getProductsByCategory(
            @PathVariable Long categoryId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size
    ) {
        // page: 1-based를 0-based로 변환
        PageRequest pageable = PageRequest.of(page - 1, size, Sort.by("id").ascending());
        return productService.getProductsByCategory(categoryId, pageable);
    }
}
