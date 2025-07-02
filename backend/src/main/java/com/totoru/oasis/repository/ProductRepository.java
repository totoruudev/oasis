package com.totoru.oasis.repository;


import com.totoru.oasis.entity.Category;

import com.totoru.oasis.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {

    List<Product> findByCategory(Category category);
    List<Product> findTop8ByOrderByCreatedAtDesc();
    List<Product> findTop8ByOrderByViewsDesc();
    List<Product> findByCategoryAndActiveTrueOrderByCreatedAtDesc(Category category);
    List<Product> findAllByActiveTrueOrderByCreatedAtDesc();
    @Query("SELECT DISTINCT p.category FROM Product p")
    List<String> findDistinctCategories();
    List<Product> findByCategory_NameInAndActiveTrueOrderByCreatedAtDesc(List<String> categoryNames);

}
