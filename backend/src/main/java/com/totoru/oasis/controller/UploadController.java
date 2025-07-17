package com.totoru.oasis.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.Map;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000", allowCredentials = "true")
public class UploadController {

    @Value("${file.upload-dir}")
    private String uploadDir;

    @PostMapping("/upload")
    public ResponseEntity<?> uploadFile(@RequestParam("file") MultipartFile file) {
        try {
            System.out.println("업로드 경로: " + uploadDir);
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            File dest = new File(dir, fileName);
            file.transferTo(dest);

            // 파일명만 프론트로 반환!
            return ResponseEntity.ok(Map.of("filename", fileName));
            // or, 필요하다면 둘 다 주기
            // return ResponseEntity.ok(Map.of("filename", fileName, "path", "/uploads/" + fileName));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("업로드 실패: " + e.getMessage());
        }
    }

}
