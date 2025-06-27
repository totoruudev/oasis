package com.totoru.oasis.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BannerGenerationService {

    private final OpenAiClient openAiClient; // 이미지 생성 담당 서비스 (이미 구현되어 있다고 가정)

    public String generateImage(String prompt) {
        try {
            // 실제 이미지 생성 로직
            return openAiClient.generateImage(prompt);
        } catch (Exception e) {
            throw new RuntimeException("배너 이미지 생성 실패: " + e.getMessage(), e);
        }
    }
}
