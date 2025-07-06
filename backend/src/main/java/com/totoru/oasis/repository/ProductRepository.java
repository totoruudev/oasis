package com.totoru.oasis.repository;


import com.totoru.oasis.entity.Category;
import com.totoru.oasis.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {

//    List<Product> findByCategory(Category category);

    List<Product> findTop8ByOrderByCreatedAtDesc();

    List<Product> findTop8ByOrderByViewsDesc();

    List<Product> findByCategoryAndActiveTrueOrderByCreatedAtDesc(Category category);

    List<Product> findAllByActiveTrueOrderByCreatedAtDesc();

    @Query("SELECT DISTINCT p.category FROM Product p")
    List<Category> findDistinctCategoryEntities();

//    @Query("SELECT p FROM Product p WHERE p.active = true AND p.subCategory IS NOT NULL AND p.subCategory.name IN :names ORDER BY p.createdAt DESC")
//    List<Product> findActiveByValidSubCategoryNames(@Param("names") List<String> names);

    @Query("SELECT p FROM Product p " +
            "WHERE p.active = true AND " +
            "(p.category.name IN :names OR p.subCategory.name IN :names)")
    List<Product> findActiveByValidCategoryOrSubCategoryNames(@Param("names") List<String> names);



}
