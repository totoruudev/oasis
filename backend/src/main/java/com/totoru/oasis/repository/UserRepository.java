package com.totoru.oasis.repository;

import com.totoru.oasis.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
    void deleteByUsername(String username);
    Optional<User> findByRole(String role);
    List<User> findAllByOrderByIdDesc();
    Optional<User> findByEmail(String email);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);

    @Query("SELECT u FROM User u WHERE " +
            "(:keyword = '' OR u.name LIKE %:keyword% OR u.username LIKE %:keyword% OR u.email LIKE %:keyword%)")
    Page<User> findByKeyword(@Param("keyword") String keyword, Pageable pageable);
}
