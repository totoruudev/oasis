package com.totoru.oasis.controller;

import com.totoru.oasis.dto.CartItemDto;
import com.totoru.oasis.repository.CartRepository;
import com.totoru.oasis.service.CartService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@RestController
@RequestMapping("/api/cart")
@RequiredArgsConstructor

public class CartController {

    private final CartService cartService;
    private final CartRepository cartRepository;

    @PostMapping
    public ResponseEntity<CartItemDto> addToCart(@RequestBody CartItemDto dto, HttpSession session, Principal principal) {
        String sessionId = session.getId();
        String userId = (session.getAttribute("userId") != null) ? session.getAttribute("userId").toString() : null;

        return ResponseEntity.ok(cartService.addItem(sessionId, userId, dto));
    }

    @GetMapping
    public ResponseEntity<List<CartItemDto>> getCart(HttpSession session, Principal principal) {
        String sessionId = session.getId();
        String userId = (session.getAttribute("userId") != null) ? session.getAttribute("userId").toString() : null;

        return ResponseEntity.ok(cartService.getItems(sessionId, userId));
    }

    @PutMapping("/{productId}")
    public ResponseEntity<CartItemDto> updateQuantity(
            @PathVariable("productId") Long productId,
            @RequestBody CartItemDto dto,
            HttpSession session,
            Principal principal
    ) {
        String sessionId = session.getId();
        String userId = (session.getAttribute("userId") != null) ? session.getAttribute("userId").toString() : null;

        return ResponseEntity.ok(cartService.updateQuantity(sessionId, userId, productId, dto.getQuantity()));
    }

    @DeleteMapping("/{productId}")
    public ResponseEntity<Void> delete(
            @PathVariable("productId") Long productId,
            HttpSession session,
            Principal principal
    ) {
        String sessionId = session.getId();
        String userId = (session.getAttribute("userId") != null) ? session.getAttribute("userId").toString() : null;

        cartService.removeItem(sessionId, userId, productId);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/clear")
    public ResponseEntity<?> clearCart(HttpSession session) {
        String sessionId = session.getId();
        Object userIdObj = session.getAttribute("userId");

        if (userIdObj != null) {
            String userId = String.valueOf(userIdObj);
            cartRepository.findAllByUserId(userId).forEach(cartRepository::delete);
        } else {
            cartRepository.findAllBySessionId(sessionId).forEach(cartRepository::delete);
        }

        return ResponseEntity.ok().build();
    }
}
