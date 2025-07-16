package com.totoru.oasis.service;

import com.totoru.oasis.dto.ProductDto;
import com.totoru.oasis.entity.Category;
import com.totoru.oasis.entity.Product;
import com.totoru.oasis.entity.SubCategory;
import com.totoru.oasis.repository.CategoryRepository;
import com.totoru.oasis.repository.ProductRepository;
import com.totoru.oasis.repository.SubCategoryRepository;
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
    private final CategoryRepository categoryRepository;
    private final SubCategoryRepository subCategoryRepository;

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
    /** 상품 등록 **/
    @Transactional
    public ProductDto createProduct(ProductDto dto) {
        Category category = categoryRepository.findById(dto.getCategoryId())
                .orElseThrow(() -> new IllegalArgumentException("카테고리 없음"));
        SubCategory subCategory = subCategoryRepository.findById(dto.getSubCategoryId())
                .orElseThrow(() -> new IllegalArgumentException("서브카테고리 없음"));

        Product product = Product.builder()
                .name(dto.getName())
                .category(category)
                .subCategory(subCategory)
                .price(dto.getPrice())
                .percent(dto.getPercent())
                .description(dto.getDescription() != null ? dto.getDescription() : "")
                .thumbnailimg(dto.getThumbnailimg())
                .detailimg(dto.getDetailimg())
                .active(dto.getActive() != null ? dto.getActive() : true)
                .views(0)
                .build();

        Product saved = productRepository.save(product);
        return ProductDto.from(saved);
    }

    /** 상품 수정 **/
    @Transactional
    public ProductDto updateProduct(Long id, ProductDto dto) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("상품 없음"));
        // 카테고리/서브카테고리 변경
        if (dto.getCategoryId() != null) {
            Category category = categoryRepository.findById(dto.getCategoryId())
                    .orElseThrow(() -> new IllegalArgumentException("카테고리 없음"));
            product.setCategory(category);
        }
        if (dto.getSubCategoryId() != null) {
            SubCategory subCategory = subCategoryRepository.findById(dto.getSubCategoryId())
                    .orElseThrow(() -> new IllegalArgumentException("서브카테고리 없음"));
            product.setSubCategory(subCategory);
        }
        // 그 외 필드 변경
        if (dto.getName() != null) product.setName(dto.getName());
        product.setPrice(dto.getPrice());
        product.setPercent(dto.getPercent());
        if (dto.getDescription() != null) product.setDescription(dto.getDescription());
        if (dto.getThumbnailimg() != null) product.setThumbnailimg(dto.getThumbnailimg());
        if (dto.getDetailimg() != null) product.setDetailimg(dto.getDetailimg());
        if (dto.getActive() != null) product.setActive(dto.getActive());

        return ProductDto.from(productRepository.save(product));
    }

    /** 상품 삭제 (soft delete) **/
    @Transactional
    public void deleteProduct(Long id) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("상품 없음"));
        product.setActive(false); // 소프트 딜리트
        productRepository.save(product);
    }

    public Page<ProductDto> getProductList(Pageable pageable, Long categoryId, Long subCategoryId) {
        if (categoryId != null && subCategoryId != null) {
            return productRepository.findByCategoryIdAndSubCategoryIdAndActiveTrue(categoryId, subCategoryId, pageable)
                    .map(ProductDto::from);
        } else if (categoryId != null) {
            return productRepository.findByCategoryIdAndActiveTrue(categoryId, pageable)
                    .map(ProductDto::from);
        } else {
            return productRepository.findByActiveTrue(pageable)
                    .map(ProductDto::from);
        }
    }
}