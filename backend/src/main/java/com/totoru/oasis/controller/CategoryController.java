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

    // [1-1] 추천 카테고리 조회 (이름 기준)
    @GetMapping("/recommend")
    public List<Category> getRecommendedCategories() {
        // 추천 카테고리 이름 하드코딩 (DB에서 바뀔 일 없으니)
        List<String> recommend = List.of("농산", "축산", "수산", "간편식", "간식", "정기구독");
        return categoryService.findAllCategories().stream()
                .filter(cat -> recommend.contains(cat.getName()))
                .toList();
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