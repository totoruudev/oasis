package com.totoru.oasis.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private Category category;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sub_category_id")
    private SubCategory subCategory;

    private int price;

    @Column(columnDefinition = "TEXT")
    private String description;

    private String thumbnailimg;

    private String detailimg;

    private int percent;

    private LocalDateTime createdAt;

    @PrePersist
    public void onCreate() {
        this.createdAt = LocalDateTime.now();
    }

    @OneToMany(mappedBy = "product")
    @JsonIgnore
    private List<OrderItem> orderItems;

    @Column(nullable = false, columnDefinition = "BOOLEAN DEFAULT TRUE")
    @Builder.Default
    private boolean active = true;

    @Column(nullable = false)
    @Builder.Default
    private int views = 0;

    @Column(name = "review_audio_path")
    private String reviewAudioPath;

    public String getThumbnailimgPath() {
        if (thumbnailimg == null) return null;
        return "/images/products/" + thumbnailimg;
    }

    public String getDetailimgPath() {
        if (detailimg == null) return null;
        return "/images/products/" + detailimg;
    }

}
