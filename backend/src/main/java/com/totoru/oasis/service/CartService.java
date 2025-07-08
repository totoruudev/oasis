package com.totoru.oasis.service;

import com.totoru.oasis.dto.CartItemDto;
import com.totoru.oasis.entity.CartItem;
import com.totoru.oasis.repository.CartRepository;
import org.springframework.transaction.annotation.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CartService {

    private final CartRepository cartRepository;

    public CartItemDto toDto(CartItem entity) {
        if (entity == null) return null;
        return CartItemDto.builder()
                .id(entity.getId())
                .productName(entity.getProductName())
                .price(entity.getPrice())
                .quantity(entity.getQuantity())
                .percent(entity.getPercent())
                .thumbnailimg(entity.getThumbnailimg())
                .productId(entity.getProductId())
                .build();
    }

    // DTO → Entity
    public CartItem toEntity(CartItemDto dto, String sessionId, String userId) {
        if (dto == null) return null;
        return CartItem.builder()
                .id(dto.getId())
                .productName(dto.getProductName())
                .price(dto.getPrice())
                .quantity(dto.getQuantity())
                .percent(dto.getPercent())
                .thumbnailimg(dto.getThumbnailimg())
                .productId(dto.getProductId())
                .sessionId(sessionId)
                .userId(userId)
                .build();
    }

    public CartItemDto addItem(String sessionId, String userId, CartItemDto dto) {
        CartItem item = toEntity(dto, sessionId, userId);
        CartItem saved;

        if (userId != null) {
            // 👉 회원일 경우: userId로 조회
            CartItem existing = cartRepository.findByUserIdAndProductId(userId, item.getProductId()).orElse(null);
            if (existing != null) {
                existing.setQuantity(existing.getQuantity() + item.getQuantity());
                saved = cartRepository.save(existing);
                return toDto(saved);
            }

            // 새 항목이면 userId 설정
            item.setUserId(userId);

        } else {
            // 👉 비회원일 경우: sessionId로 조회
            CartItem existing = cartRepository.findBySessionIdAndProductId(sessionId, item.getProductId()).orElse(null);
            if (existing != null) {
                existing.setQuantity(existing.getQuantity() + item.getQuantity());
                saved = cartRepository.save(existing);
                return toDto(saved);
            }

            // 새 항목이면 sessionId 설정
            item.setSessionId(sessionId);
        }

        saved = cartRepository.save(item);
        return toDto(saved);
    }

    public List<CartItemDto> getItems(String sessionId, String userId) {
        List<CartItem> entities = (userId != null)
                ? cartRepository.findAllByUserId(userId)
                : cartRepository.findAllBySessionId(sessionId);
        return entities.stream().map(this::toDto).collect(Collectors.toList());
    }

    public CartItemDto updateQuantity(String sessionId, String userId, Long productId, int quantity) {
        CartItem item = (userId != null)
                ? cartRepository.findByUserIdAndProductId(userId, productId).orElseThrow()
                : cartRepository.findBySessionIdAndProductId(sessionId, productId).orElseThrow();

        item.setQuantity(quantity);
        return toDto(cartRepository.save(item));
    }

    @Transactional
    public void removeItem(String sessionId, String userId, Long productId) {
        if (userId != null) {
            cartRepository.deleteByUserIdAndProductId(userId, productId);
        } else {
            cartRepository.deleteBySessionIdAndProductId(sessionId, productId);
        }
    }
}
