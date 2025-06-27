package com.totoru.oasis.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.totoru.oasis.entity.Board;

public interface BoardRepository extends JpaRepository<Board, Long> {
}
