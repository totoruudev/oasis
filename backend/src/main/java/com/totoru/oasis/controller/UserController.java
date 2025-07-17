package com.totoru.oasis.controller;

import com.totoru.oasis.dto.UserDto;
import com.totoru.oasis.entity.User;
import com.totoru.oasis.repository.UserRepository;
import com.totoru.oasis.service.UserService;
import com.totoru.oasis.storage.VerifiedEmailStorage;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/users")

@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final UserRepository userRepository;
    private final VerifiedEmailStorage verifiedEmailStorage;

    // 회원가입
    @PostMapping("/join")
    public ResponseEntity<?> join(@RequestBody User user) {
        try {
            if (!verifiedEmailStorage.isVerified(user.getEmail())) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("이메일 인증이 필요합니다.");
            }
            verifiedEmailStorage.remove(user.getEmail());
            userService.join(user);
            return ResponseEntity.ok("회원가입 완료");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("message", e.getMessage()));
        }
    }

    // 로그인 (세션 + SecurityContext 동시 등록)
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> credentials, HttpSession session) {
        System.out.println("로그인 시도: " + credentials.get("username"));

        User user = userService.login(credentials.get("username"), credentials.get("password"));
        if (user != null) {
            // 세션에 일부 정보 저장 (선택)
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());

            System.out.println("세션 저장 userId: " + session.getAttribute("userId"));
            System.out.println("세션 저장 username: " + session.getAttribute("username"));

            // SecurityContextHolder에 인증정보 등록
            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(
                            user.getUsername(), // principal(주체)은 username (String)
                            null,
                            List.of(new SimpleGrantedAuthority("ROLE_" + user.getRole()))
                    );
            SecurityContextHolder.getContext().setAuthentication(authentication);
            session.setAttribute(
                    HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY,
                    SecurityContextHolder.getContext()
            );

            System.out.println("SecurityContextHolder: " + SecurityContextHolder.getContext().getAuthentication());

            // user 전체 리턴 X (보안상), 최소한의 정보만 리턴 추천
            return ResponseEntity.ok(Map.of(
                    "userId", user.getId(),
                    "username", user.getUsername(),
                    "role", user.getRole(),
                    "name", user.getName()
            ));
        } else {
            System.out.println("로그인 실패 (아이디/비번 틀림)");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
        }
    }

    // 로그아웃
    @PostMapping("/logout")
    public ResponseEntity<?> logout(HttpSession session) {
        session.invalidate();
        SecurityContextHolder.clearContext();
        return ResponseEntity.ok("Logged out");
    }

    // 내 정보 조회 (SecurityContextHolder 기반)
    @GetMapping("/my")
    public ResponseEntity<?> getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        System.out.println("현재 인증 정보: " + authentication);

        if (authentication == null || !authentication.isAuthenticated()
                || authentication.getPrincipal().equals("anonymousUser")) {
            System.out.println("인증 안됨(로그인 필요)");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }
        String username = authentication.getName();
        System.out.println("인증된 username: " + username);

        User user = userRepository.findByUsername(username).orElse(null);
        if (user == null) {
            System.out.println("DB에 사용자 없음");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }
        Map<String, Object> result = new HashMap<>();
        result.put("userId", user.getId());
        result.put("username", user.getUsername());
        result.put("name", user.getName());
        result.put("email", user.getEmail());
        result.put("tel", user.getTel());
        result.put("address", user.getAddress());
        result.put("role", user.getRole());
        result.put("createdAt", user.getCreatedAt() != null ? user.getCreatedAt().toString() : "가입일 없음");

        return ResponseEntity.ok(result);
    }

    // 내 정보 수정 (SecurityContextHolder 기반)
    @PutMapping("/my")
    public ResponseEntity<?> updateUserInfo(@RequestBody User updated) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()
                || authentication.getPrincipal().equals("anonymousUser")) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }
        String username = authentication.getName();
        User loginUser = userRepository.findByUsername(username).orElse(null);
        if (loginUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }
        loginUser.setName(updated.getName());
        loginUser.setTel(updated.getTel());
        loginUser.setAddress(updated.getAddress());

        if (updated.getEmail() != null && !updated.getEmail().equals(loginUser.getEmail())) {
            if (!verifiedEmailStorage.isVerified(updated.getEmail())) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("이메일 인증이 필요합니다.");
            }
            loginUser.setEmail(updated.getEmail());
            verifiedEmailStorage.remove(updated.getEmail());
        }
        userRepository.save(loginUser);
        return ResponseEntity.ok("updated");
    }

    // 내 계정 삭제 (SecurityContextHolder 기반)
    @DeleteMapping("/my")
    public ResponseEntity<?> deleteCurrentUser(HttpSession session) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()
                || authentication.getPrincipal().equals("anonymousUser")) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }
        String username = authentication.getName();
        User loginUser = userRepository.findByUsername(username).orElse(null);
        if (loginUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }
        userService.deleteUserById(loginUser.getId());
        session.invalidate();
        SecurityContextHolder.clearContext();
        return ResponseEntity.ok("회원 탈퇴 완료");
    }

    // 전체 유저 리스트 (어드민 용)
//    @GetMapping("/users")
//    public List<User> getAllUsers() {
//        return userRepository.findAll();
//    }

    // 유저 삭제 (어드민 용)
//    @DeleteMapping("/users/{id}")
//    public ResponseEntity<?> deleteUser(@PathVariable("id") Long id) {
//        userRepository.deleteById(id);
//        return ResponseEntity.ok("삭제 완료");
//    }

    // 소셜 회원 여부 확인
    @GetMapping("/check-social")
    public ResponseEntity<?> checkSocial(@RequestParam String email) {
        Optional<User> user = userRepository.findByEmail(email);
        return ResponseEntity.ok(Map.of("social", user.map(User::isSocial).orElse(false)));
    }

    // 중복 username 체크
    @GetMapping("/check-username")
    public ResponseEntity<?> checkUsername(@RequestParam String username) {
        boolean exists = userRepository.existsByUsername(username);
        return ResponseEntity.ok(Map.of("available", !exists));
    }

    // 중복 email 체크
    @GetMapping("/check-email")
    public ResponseEntity<?> checkEmail(@RequestParam String email) {
        boolean exists = userRepository.existsByEmail(email);
        return ResponseEntity.ok(Map.of("available", !exists));
    }


}
