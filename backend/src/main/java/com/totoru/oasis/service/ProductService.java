package com.totoru.oasis.service;

import com.totoru.oasis.entity.Product;
import com.totoru.oasis.repository.OrderItemRepository;
import com.totoru.oasis.repository.ProductRepository;
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

    private final String uploadDir = "/uploads";

    public Product save(Product product) {
        return productRepository.save(product);
    }

    public List<Product> findAll() {
        return productRepository.findAll();
    }

    public Optional<Product> findById(Long id) {
        return productRepository.findById(id);
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
    // 🔥 섹션별 상품(섹션 타이틀 -> 상품목록) 리턴
    // ------------------------------
    public Map<String, Object> getSectionedProducts() {
        System.out.println("💬 섹션 요청 시작");

        Map<String, List<String>> sectionCategoryMap = Map.ofEntries(
                Map.entry("특가로 만나는 건강한 신상품", List.of("채소", "과일", "수산", "축산", "국", "반찬", "간편식", "빵", "잼", "쌀", "견과", "양념", "면", "간식", "음료", "생활", "주방", "브랜드상품")),
                Map.entry("우수 상품 추천", List.of("농산", "수산", "축산", "반찬", "간편식", "제철 음식", "산지직송")),
                Map.entry("신선하게 자라난 농산물", List.of("GAP", "우리땅과일", "수입과일", "친환경채소", "우리땅채소", "샐러드채소", "즙용채소", "간편채소", "버섯", "건나물", "쌀", "잡곡", "견과", "선식")),
                Map.entry("농장에서 식탁까지 신선축산", List.of("유정란", "알류", "무항생제한우", "무항생제한돈", "한우", "한돈", "제주돼지", "닭", "오리", "소고기", "유기농소고기", "육가공", "족발", "양념육")),
                Map.entry("내 몸은 내가 챙긴다! 건강/음료", List.of("건강즙", "생수", "커피", "식혜", "음료", "영양제", "천연과즙", "액상", "엑기스", "홍삼", "인삼", "죽염", "흑마늘", "환", "곡물", "차류")),
                Map.entry("바다향 가득 품은 수산물", List.of("새벽수산", "일반생선", "연어", "참치", "오징어", "알류", "새우", "조개", "멸치", "액젓", "젓갈", "김", "해조", "건어물", "어묵", "가공")),
                Map.entry("요즘 인기있는 간식", List.of("과자", "빵", "떡", "한과", "엿", "두유", "유제품", "선식", "사탕", "젤리", "초콜릿", "시리얼")),
                Map.entry("더 건강하게! 더 맛있게! 양념", List.of("파스타", "면", "밀가루", "분말", "오일", "참기름", "케찹", "잼", "소금", "설탕", "향신료", "된장", "장류", "참깨", "고춧가루", "식초", "조청", "꿀", "소스", "드레싱", "육수"))
        );

        Map<String, Object> result = new LinkedHashMap<>();

        sectionCategoryMap.forEach((sectionTitle, categories) -> {
            System.out.println("\n🔍 섹션명: " + sectionTitle);
            System.out.println("📦 대상 카테고리: " + categories);

            List<Product> products = productRepository.findActiveByValidCategoryNames(categories);
            System.out.println("✅ 전체 상품 개수: " + products.size());

            List<Product> sectionProducts = products.stream()
                    .limit(4)
                    .peek(p -> System.out.println("🧾 상품명: " + p.getName() + " | 카테고리: " +
                            (p.getCategory() != null ? "'" + p.getCategory().getName() + "'" : "NULL")))
                    .collect(Collectors.toList());

            System.out.println("🎯 최종 노출 상품 수 (limit 4): " + sectionProducts.size());

            result.put(sectionTitle, Map.of("products", sectionProducts));
        });

        System.out.println("\n🎉 섹션 요청 완료");
        return result;
    }



}
