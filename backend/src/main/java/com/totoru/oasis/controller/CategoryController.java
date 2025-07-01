package com.totoru.oasis.controller;

import com.totoru.oasis.entity.Category;
import com.totoru.oasis.entity.SubCategory;
import com.totoru.oasis.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/categories")
@CrossOrigin(origins = "http://localhost:3000", allowCredentials = "true")
public class CategoryController {
    private final CategoryService categoryService;

    // [1] 전체 카테고리 조회
    @GetMapping
    public List<Category> getCategories() {
        return categoryService.findAllCategories();
    }

    // [2] 카테고리명으로 단일 카테고리 조회
    @GetMapping("/name/{name}")
    public Category getCategoryByName(@PathVariable String name) {
        Optional<Category> result = categoryService.findCategoryByName(name);
        return result.orElseThrow(() -> new RuntimeException("카테고리 없음: " + name));
    }

    // [3] 특정 카테고리의 서브카테고리 전체 조회
    @GetMapping("/{categoryId}/subcategories")
    public List<SubCategory> getSubCategories(@PathVariable Long categoryId) {
        return categoryService.findSubCategoriesByCategoryId(categoryId);
    }
}