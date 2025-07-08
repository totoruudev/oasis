package com.totoru.oasis.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CartItemDto {
    private Long id;
    private String productName;
    private int price;
    private int quantity;
    private int percent;
    private String thumbnailimg;
    private Long productId;
}