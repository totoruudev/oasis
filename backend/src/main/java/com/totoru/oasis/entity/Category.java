package com.totoru.oasis.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String name;

    @Column(nullable = true)
    private String icon;

    public String getIcon() {
        if (icon == null) return null;
        return "/images/products/recommend_icon/" + icon;
    }

    @OneToMany(mappedBy = "category")
    @JsonIgnore
    private List<SubCategory> subCategories;
}
