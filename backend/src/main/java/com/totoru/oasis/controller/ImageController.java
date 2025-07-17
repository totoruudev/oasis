//package com.totoru.oasis.controller;
//
//import com.totoru.oasis.service.ImageService;
//import lombok.AllArgsConstructor;
//import lombok.Data;
//import lombok.RequiredArgsConstructor;
//import org.springframework.http.MediaType;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//import org.springframework.web.multipart.MultipartFile;
//
//import java.util.Base64;
//
//@RestController
//@RequestMapping("/api/images")
//
//@RequiredArgsConstructor
//public class ImageController {
//
//    private final ImageService imageService;
//
//    // 1. 이미지 생성 (텍스트 → 이미지)
//    @PostMapping(value = "/generate", produces = MediaType.IMAGE_PNG_VALUE)
//    public ResponseEntity<byte[]> generateImage(@RequestBody GenerateImageRequestDto request) {
//        String base64Image = imageService.generateImage(request.getPrompt());
//        // Base64 → 이미지 디코딩
//        byte[] imageBytes = Base64.getDecoder().decode(base64Image);
//        return ResponseEntity
//                .ok()
//                .contentType(MediaType.IMAGE_PNG)
//                .body(imageBytes);
//    }
//
//    // 2. 이미지 편집 (마스크)
//    @PostMapping(value = "/edit", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.IMAGE_PNG_VALUE)
//    public ResponseEntity<byte[]> editImage(
//            @RequestPart("image") MultipartFile image,
//            @RequestPart("mask") MultipartFile mask,
//            @RequestPart("prompt") String prompt) throws Exception {
//        byte[] imageBytes = image.getBytes();
//        byte[] maskBytes = mask.getBytes();
//        String base64Image = imageService.editImage(imageBytes, maskBytes, prompt);
//
//        byte[] decodedImage = Base64.getDecoder().decode(base64Image);
//        return ResponseEntity.ok()
//                .contentType(MediaType.IMAGE_PNG)
//                .body(decodedImage);
//    }
//
//    // 3. 이미지 변형 (Variation)
//    @PostMapping(value = "/variation", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.IMAGE_PNG_VALUE)
//    public ResponseEntity<byte[]> variationImage(@RequestPart("image") MultipartFile image) throws Exception {
//        byte[] imageBytes = image.getBytes();
//        String base64Image = imageService.variationImage(imageBytes);
//        byte[] decodedImage = Base64.getDecoder().decode(base64Image);
//        return ResponseEntity.ok()
//                .contentType(MediaType.IMAGE_PNG)
//                .body(decodedImage);
//    }
//
//    // DTO
//    @Data
//    static class GenerateImageRequestDto {
//        private String prompt;
//    }
//
//    @Data
//    @AllArgsConstructor
//    static class ImageResponseDto {
//        private String base64Image; // b64_json 문자열 (base64 encoded png)
//    }
//}
//
