package com.totoru.oasis.repository;

import com.totoru.oasis.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {

    // 서브카테고리ID 리스트로 활성 상품 조회
    @Query("SELECT p FROM Product p WHERE p.active = true AND p.subCategory.id IN :subCategoryIds")
    List<Product> findActiveBySubCategoryIds(@Param("subCategoryIds") List<Long> subCategoryIds);

    // 단일 서브카테고리ID로 활성 상품 조회
    List<Product> findBySubCategoryIdAndActiveTrue(Long subCategoryId);

    // 전체 활성 상품 최신순
    List<Product> findAllByActiveTrueOrderByCreatedAtDesc();
}
