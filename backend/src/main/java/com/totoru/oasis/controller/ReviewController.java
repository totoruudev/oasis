package com.totoru.oasis.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.totoru.oasis.entity.Product;
import com.totoru.oasis.entity.Review;
import com.totoru.oasis.entity.User;
import com.totoru.oasis.repository.ProductRepository;
import com.totoru.oasis.repository.ReviewRepository;
import com.totoru.oasis.repository.UserRepository;
import com.totoru.oasis.service.OpenAiClient;
import com.totoru.oasis.service.ProductService;
import com.totoru.oasis.service.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/reviews")
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000", allowCredentials = "true")
public class ReviewController {

    private final ReviewService reviewService;
    private final ProductService productService;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final ReviewRepository reviewRepository;
    private final OpenAiClient openAiClient;
    private final ObjectMapper objectMapper = new ObjectMapper();

    // DTO
    public record ReviewDto(
            Long id,
            String content,
            int rating,
            String username,
            String imagePath,
            Long productId,
            Long orderId,
            String product,
            LocalDateTime createdAt
    ) {}

    // 상품별 리뷰 조회
    @GetMapping("/product/{productId}")
    public ResponseEntity<List<ReviewDto>> getReviews(@PathVariable("productId") Long productId) {
        List<ReviewDto> dtoList = reviewService.getReviewsByProductId(productId).stream()
                .map(r -> new ReviewDto(
                        r.getId(), r.getContent(), r.getRating(), r.getUsername(),
                        r.getImagePath() != null ? r.getImagePath().toString() : null,
                        r.getProduct().getId(), r.getOrderId(),
                        r.getProduct().getName(), r.getCreatedAt()
                )).toList();
        return ResponseEntity.ok(dtoList);
    }

    // 리뷰 등록 (인증 필요)
    @PostMapping(value = "/{productId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> createReview(
            @PathVariable Long productId,
            @RequestPart("review") String reviewJson,
            @RequestPart(value = "image", required = false) MultipartFile image
    ) {
        // 인증 체크
        User loginUser = getLoginUser();
        if (loginUser == null)
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");

        try {
            Review review = objectMapper.readValue(reviewJson, Review.class);

            // 상품
            Product product = productService.findById(productId)
                    .orElseThrow(() -> new RuntimeException("상품 없음"));
            review.setProduct(product);

            // 유저 정보
            review.setUserId(loginUser.getId());
            review.setUsername(loginUser.getUsername());

            // 이미지
            if (image != null && !image.isEmpty()) {
                String imagePath = reviewService.storeFile(image);
                review.setImagePath(imagePath);
            }

            Review saved = reviewService.createReview(review);
            return ResponseEntity.ok(saved);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body("리뷰 등록 실패: " + e.getMessage());
        }
    }

    // 리뷰 수정 (인증 필요)
    @PutMapping(value = "/update/{reviewId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> updateReview(
            @PathVariable Long reviewId,
            @RequestPart("review") String reviewJson,
            @RequestPart(value = "image", required = false) MultipartFile image
    ) {
        User loginUser = getLoginUser();
        if (loginUser == null)
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");

        try {
            Review reviewData = objectMapper.readValue(reviewJson, Review.class);

            String imagePath = reviewData.getImagePath(); // 기존 경로 유지
            if (image != null && !image.isEmpty()) {
                imagePath = reviewService.storeFile(image);
            }

            // 권한 체크 등은 reviewService에서 해도 되고 여기서 해도 됨
            Review updated = reviewService.updateReview(
                    reviewId,
                    reviewData.getContent(),
                    reviewData.getRating(),
                    loginUser.getId(),
                    imagePath
            );
            return ResponseEntity.ok(updated);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body("리뷰 수정 실패: " + e.getMessage());
        }
    }

    // 리뷰 삭제 (인증 필요)
    @DeleteMapping("/{reviewId}")
    public ResponseEntity<?> deleteReview(@PathVariable Long reviewId) {
        User loginUser = getLoginUser();
        if (loginUser == null)
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");

        reviewService.deleteReview(reviewId, loginUser.getId());
        return ResponseEntity.ok("삭제 완료");
    }

    // 특정 주문-상품-유저 조합 리뷰 중복 확인 (구매자 인증 X)
    @GetMapping("/check")
    public ResponseEntity<?> checkReview(
            @RequestParam Long orderId,
            @RequestParam Long productId,
            @RequestParam Long userId
    ) {
        return reviewService.findByOrderIdAndProductIdAndUserId(orderId, productId, userId)
                .map(ResponseEntity::ok).orElse(ResponseEntity.noContent().build());
    }

    // 마이 리뷰(내가 쓴 리뷰) - 인증 필요!
    @GetMapping("/my")
    public ResponseEntity<?> getMyReviews(
            @PageableDefault(size = 5, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable) {

        User loginUser = getLoginUser();
        if (loginUser == null)
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");

        Page<ReviewDto> dtoPage = reviewRepository.findByUserId(loginUser.getId(), pageable)
                .map(r -> new ReviewDto(
                        r.getId(), r.getContent(), r.getRating(), r.getUsername(),
                        r.getImagePath(), r.getProduct().getId(), r.getOrderId(),
                        r.getProduct().getName(), r.getCreatedAt()
                ));

        return ResponseEntity.ok(dtoPage);
    }

    // 리뷰 단건 조회
    @GetMapping("/{reviewId}")
    public ResponseEntity<ReviewDto> getReviewById(@PathVariable Long reviewId) {
        Optional<Review> optionalReview = reviewRepository.findById(reviewId);

        if (optionalReview.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Review review = optionalReview.get();

        ReviewDto dto = new ReviewDto(
                review.getId(),
                review.getContent(),
                review.getRating(),
                review.getUsername(),
                review.getImagePath(),
                review.getProduct().getId(),
                review.getOrderId(),
                review.getProduct().getName(),
                review.getCreatedAt()
        );

        return ResponseEntity.ok(dto);
    }

    // 오픈AI 활용: 리뷰 요약 및 TTS (관리자/운영자 기능)
    @PostMapping("/audio-summary/{productId}")
    public ResponseEntity<?> generateAudioSummary(@PathVariable Long productId) {
        List<Review> reviews = reviewRepository.findAllByProductId(productId);

        if (reviews.isEmpty()) {
            return ResponseEntity
                    .badRequest()
                    .body("리뷰가 존재하지 않습니다.");
        }

        String reviewTexts = reviews.stream()
                .map(Review::getContent)
                .collect(Collectors.joining("\n- "));

        String prompt = """
        너는 쇼핑몰 운영자야. 아래는 어떤 상품에 대한 고객 리뷰들이야. 
        문장을 연결해서 하나의 자연스러운 후기 요약문으로 만들어 줘. 
        제품에 대한 긍정적인 포인트 위주로 1~2문장으로 정리해 줘. 
        이모지나 인사말은 빼줘.

        리뷰 목록:
        """ + reviewTexts;

        String summary = openAiClient.generateText(prompt);
        String audioUrl = openAiClient.generateTTS(summary);

        Product product = productRepository.findById(productId).orElseThrow();
        product.setReviewAudioPath(audioUrl);
        productRepository.save(product);

        return ResponseEntity.ok(Map.of("summary", summary, "audioUrl", audioUrl));
    }

    @GetMapping("/{productId}/audio-summary")
    public ResponseEntity<Map<String, String>> getAudioSummary(@PathVariable Long productId) {
        Product product = productRepository.findById(productId).orElse(null);
        if (product == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        String path = product.getReviewAudioPath();
        if (path == null || path.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        }

        return ResponseEntity.ok(Map.of("audioUrl", path));
    }

    // ======== 🔑 인증 유저 조회 유틸 ========
    private User getLoginUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null
                || !authentication.isAuthenticated()
                || authentication.getPrincipal().equals("anonymousUser")) {
            return null;
        }

        String username = authentication.getName();
        return userRepository.findByUsername(username).orElse(null);
    }
}
