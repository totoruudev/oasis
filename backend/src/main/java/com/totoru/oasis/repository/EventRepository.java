package com.totoru.oasis.repository;

import com.totoru.oasis.entity.Event;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EventRepository extends JpaRepository<Event, Long> {
    List<Event> findByActiveTrueOrderBySortOrderAsc();
}
