package com.totoru.oasis.dto;

import com.totoru.oasis.entity.User;

public record UserDto(
        Long id,
        String username,
        String name,
        String email,
        String tel,
        String address,
        String role,
        String createdAt
) {
    public static UserDto from(User u) {
        return new UserDto(
                u.getId(),
                u.getUsername(),
                u.getName(),
                u.getEmail(),
                u.getTel(),
                u.getAddress(),
                u.getRole(),
                u.getCreatedAt() == null ? null : u.getCreatedAt().toString()
        );
    }
}