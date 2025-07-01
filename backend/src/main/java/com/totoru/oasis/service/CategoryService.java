package com.totoru.oasis.service;

import com.totoru.oasis.entity.Category;
import com.totoru.oasis.entity.SubCategory;
import com.totoru.oasis.repository.CategoryRepository;
import com.totoru.oasis.repository.SubCategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CategoryService {
    private final CategoryRepository categoryRepository;
    private final SubCategoryRepository subCategoryRepository;

    // 모든 카테고리 조회
    public List<Category> findAllCategories() {
        return categoryRepository.findAll();
    }

    // 카테고리명으로 카테고리 조회
    public Optional<Category> findCategoryByName(String name) {
        return categoryRepository.findByName(name);
    }

    // 카테고리 id로 서브카테고리 목록 조회
    public List<SubCategory> findSubCategoriesByCategoryId(Long categoryId) {
        return subCategoryRepository.findByCategoryId(categoryId);
    }
}
