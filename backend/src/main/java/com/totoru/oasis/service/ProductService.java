package com.totoru.oasis.service;

import com.totoru.oasis.dto.ProductDto;
import com.totoru.oasis.entity.Product;
import com.totoru.oasis.entity.SubCategory;
import com.totoru.oasis.repository.OrderItemRepository;
import com.totoru.oasis.repository.ProductRepository;
import com.totoru.oasis.repository.SubCategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;
    private final OrderItemRepository orderItemRepository;
    private final SubCategoryRepository subCategoryRepository;

    private final String uploadDir = "/uploads";

    public Product save(Product product) {
        return productRepository.save(product);
    }

    public List<ProductDto> findAll() {
        return productRepository.findAll()
                .stream()
                .map(ProductDto::from)
                .collect(Collectors.toList());
    }

    public List<SubCategory> getAllSubCategories() {
        return subCategoryRepository.findAll();
    }

    public Optional<ProductDto> findById(Long id) {
        return productRepository.findById(id)
                .map(ProductDto::from);
    }

    public Optional<Product> update(Long id, Product updatedProduct) {
        return productRepository.findById(id).map(product -> {
            product.setName(updatedProduct.getName());
            product.setPrice(updatedProduct.getPrice());
            product.setDescription(updatedProduct.getDescription());
            product.setThumbnailimg(updatedProduct.getThumbnailimg());
            product.setDetailimg(updatedProduct.getDetailimg());
            product.setPercent(updatedProduct.getPercent());
            product.setCategory(updatedProduct.getCategory());
            return productRepository.save(product);
        });
    }

    @Transactional
    public void delete(Long id) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("상품을 찾을 수 없습니다."));

        boolean hasOrderItem = orderItemRepository.existsByProduct(product);
        if (hasOrderItem) {
            product.setActive(false);
            productRepository.save(product);
        } else {
            productRepository.delete(product);
        }
    }

    @Transactional
    public void updateReviewAudioPath(Long productId, String audioPath) {
        productRepository.findById(productId).ifPresent(product -> {
            product.setReviewAudioPath(audioPath);
            productRepository.save(product);
        });
    }

    private String storeFile(MultipartFile file) {
        String filename = UUID.randomUUID().toString().replace("-", "") + "_" + file.getOriginalFilename();
        File dest = new File(uploadDir, filename);

        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdirs();
        }

        try {
            file.transferTo(dest);
            return "/uploads/" + filename;
        } catch (IOException e) {
            throw new RuntimeException("파일 저장 실패: " + e.getMessage());
        }
    }

    public Product saveWithImages(Product product, MultipartFile thumbnail, MultipartFile detail) {
        if (thumbnail != null && !thumbnail.isEmpty()) {
            product.setThumbnailimg(storeFile(thumbnail));
        }
        if (detail != null && !detail.isEmpty()) {
            product.setDetailimg(storeFile(detail));
        }
        return productRepository.save(product);
    }

    public Product updateWithImages(Long id, Product updatedProduct, MultipartFile thumbnail, MultipartFile detail) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("상품을 찾을 수 없습니다."));

        product.setName(updatedProduct.getName());
        product.setPrice(updatedProduct.getPrice());
        product.setCategory(updatedProduct.getCategory());
        product.setDescription(updatedProduct.getDescription());
        product.setPercent(updatedProduct.getPercent());

        if (thumbnail != null && !thumbnail.isEmpty()) {
            product.setThumbnailimg(storeFile(thumbnail));
        }
        if (detail != null && !detail.isEmpty()) {
            product.setDetailimg(storeFile(detail));
        }

        return productRepository.save(product);
    }

    // ------------------------------
    // 섹션별 상품(섹션 타이틀 -> 상품목록) 리턴 (DTO 변환)
    // ------------------------------
    public Map<String, Object> getSectionedProducts() {
        // 섹션별로 서브카테고리 id를 사용
        Map<String, List<Long>> sectionSubCategoryIdMap = Map.ofEntries(
                Map.entry("신선하게 자라난 농산물", List.of(1L,2L,3L,4L,5L,6L,7L,8L,9L,10L,11L,12L,13L,14L)),
                Map.entry("농장에서 식탁까지 신선축산", List.of(15L,16L,17L,18L,19L,20L,21L,22L,23L,24L,25L,26L,27L,28L)),
                Map.entry("바다향 가득 품은 수산물", List.of(29L,30L,31L,32L,33L,34L,35L,36L,37L,38L,39L,40L,41L,42L,43L)),
                Map.entry("요즘 인기있는 간식", List.of(44L,45L,46L,47L,48L,49L,50L,51L,52L,53L,54L,55L))
        );

        Map<String, Object> result = new LinkedHashMap<>();

        sectionSubCategoryIdMap.forEach((sectionTitle, subCategoryIds) -> {
            List<Product> products = productRepository.findActiveBySubCategoryIds(subCategoryIds);
            List<ProductDto> sectionProducts = products.stream()
                    .limit(4)
                    .map(ProductDto::from)
                    .collect(Collectors.toList());
            result.put(sectionTitle, Map.of("products", sectionProducts));
        });

        return result;
    }
}