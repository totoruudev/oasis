package com.totoru.oasis.controller;

import com.totoru.oasis.entity.Event;
import com.totoru.oasis.repository.EventRepository;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/event")
@CrossOrigin(origins = "http://localhost:3000", allowCredentials = "true")
public class EventController {
    private final EventRepository eventRepository;

    @GetMapping
    public List<Event> getAllEvents() {
        return eventRepository.findAll();
    }

    @GetMapping("/carousel")
    public List<CarouselImage> getCarouselImages() {
        System.out.println(">>> [EventController] /api/event/carousel 요청 옴");
        return eventRepository.findByActiveTrueOrderBySortOrderAsc()
                .stream()
                .map(e -> new CarouselImage(
                        "/images/products/" + e.getBannerImg(),
                        e.getTitle(),
                        e.getLinkUrl()
                ))
                .toList();
    }

    @GetMapping("/{id}")
    public Event getEventDetail(@PathVariable Long id) {
        return eventRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("이벤트 없음"));
    }

    @Data
    @AllArgsConstructor
    public static class CarouselImage {
        private String url;
        private String title;
        private String linkUrl;
    }
}
