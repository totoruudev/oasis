package com.totoru.oasis.service;

import com.totoru.oasis.dto.ProductDto;
import com.totoru.oasis.entity.Product;
import com.totoru.oasis.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;

    // [1] 섹션별 서브카테고리 매핑
    private static final Map<String, List<Long>> SECTION_SUBCATEGORY_MAP = Map.of(
            "신선하게 자라난 농산물", Arrays.asList(1L,2L,3L,4L,5L,6L,7L,8L,9L,10L,11L,12L,13L,14L),
            "농장에서 식탁까지 신선축산", Arrays.asList(15L,16L,17L,18L,19L,20L,21L,22L,23L,24L,25L,26L,27L,28L),
            "바다향 가득 품은 수산물", Arrays.asList(29L,30L,31L,32L,33L,34L,35L,36L,37L,38L,39L,40L,41L,42L,43L),
            "요즘 인기있는 간식", Arrays.asList(44L,45L,46L,47L,48L,49L,50L,51L,52L,53L,54L,55L)
    );

    // [2] 섹션별 상품 리스트 반환 (프론트 구조와 맞춤)
    public Map<String, Object> getSectionedProducts() {
        Map<String, Object> result = new LinkedHashMap<>();

        for (Map.Entry<String, List<Long>> entry : SECTION_SUBCATEGORY_MAP.entrySet()) {
            String sectionTitle = entry.getKey();
            List<Long> subCategoryIds = entry.getValue();
            List<ProductDto> sectionProducts = productRepository.findActiveBySubCategoryIds(subCategoryIds)
                    .stream()
                    .map(ProductDto::from)
                    .collect(Collectors.toList());
            result.put(sectionTitle, Map.of("products", sectionProducts));
        }
        return result;
    }

    // [3] 서브카테고리별 상품 (단일)
    public List<ProductDto> getProductsBySubCategory(Long subCategoryId) {
        return productRepository.findBySubCategoryIdAndActiveTrue(subCategoryId)
                .stream()
                .map(ProductDto::from)
                .collect(Collectors.toList());
    }

    // [4] 전체 상품 최신순
    public List<ProductDto> getAllActiveProducts() {
        return productRepository.findAllByActiveTrueOrderByCreatedAtDesc()
                .stream()
                .map(ProductDto::from)
                .collect(Collectors.toList());
    }

    // [상품 상세 조회]
    @Transactional(readOnly = true)
    public ProductDto getProductById(Long id) {
        Product product = productRepository.findByIdAndActiveTrue(id)
                .orElseThrow(() -> new NoSuchElementException("해당 상품을 찾을 수 없습니다."));
        return ProductDto.from(product);
    }

    // 카테고리별 상품(페이징, id순)
    public Page<ProductDto> getProductsByCategory(Long categoryId, Pageable pageable) {
        Page<Product> page = productRepository.findByCategoryIdAndActiveTrue(categoryId, pageable);
        return page.map(ProductDto::from);
    }
}
