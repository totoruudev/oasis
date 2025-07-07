package com.totoru.oasis.controller;

import com.totoru.oasis.dto.ProductDto;
import com.totoru.oasis.service.ProductService;
import lombok.RequiredArgsConstructor;
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
}
