package com.totoru.oasis.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class User {
    @EqualsAndHashCode.Include
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String username;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String tel;

    @Column(nullable = false)
    private String address;

    @Column(unique = true)
    private String email;

    @Column(nullable = false)
    private String profileImg;

    @Column(nullable = false)
    @Builder.Default
    private boolean social = false;

    @Column(nullable = false)
    @Builder.Default
    private String role = "USER"; // 기본값

    private LocalDateTime createdAt;

    @PrePersist
    public void onPrePersist() {
        if (this.role == null) this.role = "USER";
        if (this.createdAt == null) this.createdAt = LocalDateTime.now();
    }

}
