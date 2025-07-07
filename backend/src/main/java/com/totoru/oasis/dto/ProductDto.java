package com.totoru.oasis.dto;

import com.totoru.oasis.entity.Product;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductDto {
    private Long id;
    private String name;

    // category 정보 확장 (id, name)
    private Long categoryId;
    private String categoryName;

    // subCategory 정보 확장 (id, name)
    private Long subCategoryId;
    private String subCategoryName;

    private int price;
    private int percent;
    private String description;
    private String thumbnailimg;
    private String detailimg;
    private boolean active;
    private int views;

    public static ProductDto from(Product p) {
        return ProductDto.builder()
                .id(p.getId())
                .name(p.getName())
                .categoryId(p.getCategory() != null ? p.getCategory().getId() : null)
                .categoryName(p.getCategory() != null ? p.getCategory().getName() : null)
                .subCategoryId(p.getSubCategory() != null ? p.getSubCategory().getId() : null)
                .subCategoryName(p.getSubCategory() != null ? p.getSubCategory().getName() : null)
                .price(p.getPrice())
                .percent(p.getPercent())
                .description(p.getDescription())
                .thumbnailimg(p.getThumbnailimg())
                .detailimg(p.getDetailimg())
                .active(p.isActive())
                .views(p.getViews())
                .build();
    }
}
