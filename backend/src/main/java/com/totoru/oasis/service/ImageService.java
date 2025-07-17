package com.totoru.oasis.service;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.ai.openai.OpenAiImageModel;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ImageService {
    private final OpenAiImageModel imageModel;
    private final WebClient webClient;
//    private final String OPENAI_API_KEY = System.getenv("OPENAI_API_KEY");

    @Value("${OPENAI_API_KEY}")
    private String openaiApiKey;

//    @PostConstruct
//    public void checkKey() {
//        System.out.println("OpenAI Key(앞 8자리): " + (openaiApiKey != null ? openaiApiKey.substring(0,8) : "NULL"));
//    }

    // 1. 이미지 생성 : POST -> https://api.openai.com/v1/images/generations
    public String generateImage(String prompt) {
        Map<String, Object> request = Map.of(
                "prompt", prompt,
                "n", 1,
                "size", "1024x1024",
                "response_format", "b64_json"
        );

        Map<String, Object> response = webClient.post()
                .uri("https://api.openai.com/v1/images/generations")
                .header("Authorization", "Bearer " + openaiApiKey)
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(request)
                .retrieve()
                .bodyToMono(Map.class)
                .block();

        var data = (List<Map<String, String>>) response.get("data");
        return data.get(0).get("b64_json");
    }

    // 2. 이미지 편집 (마스크) : POST -> https://api.openai.com/v1/images/edits
    public String editImage(byte[] imageBytes, byte[] maskBytes, String prompt) {
        MultiValueMap<String, Object> multipartData = new LinkedMultiValueMap<>();

        multipartData.add("image", new ByteArrayResource(imageBytes) {
            @Override
            public String getFilename() {
                return "image.png";
            }
        });
        multipartData.add("mask", new ByteArrayResource(maskBytes) {
            @Override
            public String getFilename() {
                return "mask.png";
            }
        });
        multipartData.add("prompt", prompt);
        multipartData.add("n", "1");
        multipartData.add("size", "1024x1024");
        multipartData.add("response_format", "b64_json");

        return webClient.post()
                .uri("https://api.openai.com/v1/images/edits")
                .header("Authorization", "Bearer " + openaiApiKey)
                .contentType(MediaType.MULTIPART_FORM_DATA)
                .body(BodyInserters.fromMultipartData(multipartData))
                .retrieve()
                .bodyToMono(Map.class)
                .map(response -> {
                    var data = (java.util.List<Map<String, String>>) response.get("data");
                    if (data != null && !data.isEmpty()) {
                        return data.get(0).get("b64_json");
                    }
                    throw new RuntimeException("No image edit result");
                })
                .block();
    }

    // 3. 이미지 변형 : POST -> https://api.openai.com/v1/images/variations
    public String variationImage(byte[] imageBytes) {
        MultiValueMap<String, Object> multipartData = new LinkedMultiValueMap<>();

        multipartData.add("image", new ByteArrayResource(imageBytes) {
            @Override
            public String getFilename() {
                return "image.png";
            }
        });
        multipartData.add("n", "1");
        multipartData.add("size", "1024x1024");
        multipartData.add("response_format", "b64_json");

        return webClient.post()
                .uri("https://api.openai.com/v1/images/variations")
                .header("Authorization", "Bearer " + openaiApiKey)
                .contentType(MediaType.MULTIPART_FORM_DATA)
                .body(BodyInserters.fromMultipartData(multipartData))
                .retrieve()
                .bodyToMono(Map.class)
                .map(response -> {
                    var data = (java.util.List<Map<String, String>>) response.get("data");
                    if (data != null && !data.isEmpty()) {
                        return data.get(0).get("b64_json");
                    }
                    throw new RuntimeException("No image variation result");
                })
                .block();
    }

}