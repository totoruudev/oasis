package com.totoru.oasis.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class Event {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String description;

    // 메인 캐러셀 이미지 경로 (파일명 or URL)
    private String bannerImg;

    // 클릭 시 이동할 URL (이벤트 상세, 상품 등)
    private String linkUrl;

    private LocalDateTime startAt;
    private LocalDateTime endAt;

    // 정렬 순서 (null 가능)
    private Integer sortOrder;

    @Column(nullable = false)
    @Builder.Default
    private boolean active = true;
}
