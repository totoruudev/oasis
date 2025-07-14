package com.totoru.oasis.service;

import com.totoru.oasis.dto.UserDto;
import com.totoru.oasis.entity.User;
import com.totoru.oasis.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    // 회원가입
    public User join(User user) {
        // 1. 필수값 검증
        if (isEmpty(user.getUsername()))
            throw new IllegalArgumentException("아이디를 입력하세요.");
        if (isEmpty(user.getEmail()))
            throw new IllegalArgumentException("이메일을 입력하세요.");
        if (isEmpty(user.getPassword()))
            throw new IllegalArgumentException("비밀번호를 입력하세요.");

        // 2. 중복 체크
        if (userRepository.existsByUsername(user.getUsername()))
            throw new IllegalArgumentException("이미 존재하는 아이디입니다.");
        if (userRepository.existsByEmail(user.getEmail()))
            throw new IllegalArgumentException("이미 가입된 이메일입니다.");

        // 3. 비밀번호 암호화
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        // 4. 필드의 기본값 처리 (엔티티 빌더에 디폴트 있으면 생략 가능)
        if (user.getRole() == null || user.getRole().isBlank())
            user.setRole("USER");
        if (user.getTel() == null)
            user.setTel("");
        if (user.getAddress() == null)
            user.setAddress("");
        if (user.getName() == null)
            user.setName("");
        if (user.getProfileImg() == null)
            user.setProfileImg("");
        // social: boolean은 이미 false가 디폴트

        // 5. 저장
        return userRepository.save(user);
    }

    // 로그인
    public User login(String username, String password) {
        return userRepository.findByUsername(username)
                .filter(u -> passwordEncoder.matches(password, u.getPassword()))
                .orElse(null);
    }

    // ID로 사용자 조회
    public User getUserById(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    public User getUserByStringId(String userId) {
        try {
            Long id = Long.parseLong(userId);
            return userRepository.findById(id).orElse(null);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    // 전체 사용자 조회
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    // 회원탈퇴 (해당 유저의 모든 채팅방 삭제 후)
    @Transactional
    public void deleteUserById(Long userId) {
        userRepository.deleteById(userId);
    }

    // 이메일로 사용자 찾거나, 없으면 생성(소셜 로그인용)
    public User findOrCreateUserByEmail(String email, String name) {
        return userRepository.findByEmail(email)
                .orElseGet(() -> {
                    User newUser = User.builder()
                            .username(name)
                            .email(email)
                            .name(name)
                            .tel("")
                            .address("")
                            .password("") // 소셜로그인엔 비번X
                            .role("USER")
                            .social(true)
                            .build();
                    return userRepository.save(newUser);
                });
    }

    // username으로 조회
    public Optional<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    // 문자열이 null 또는 빈 문자열인지 검사
    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }

    // 관리자용: 검색 + 페이지네이션
    public Map<String, Object> getUserList(String keyword, int page, int pageSize) {
        Page<User> userPage = userRepository.findByKeyword(
                keyword,
                PageRequest.of(page - 1, pageSize, Sort.by(Sort.Direction.DESC, "id"))
        );
        List<UserDto> userDtos = userPage.getContent().stream()
                .map(UserDto::from)
                .toList();
        int totalPage = userPage.getTotalPages();

        return Map.of(
                "users", userDtos,
                "totalPage", totalPage
        );
    }



    // 상세
    public Optional<User> getUserDetail(Long id) {
        return userRepository.findById(id);
    }

    // 삭제(회원 탈퇴)
    @Transactional
    public void adminDeleteUser(Long id) {
        userRepository.deleteById(id);
    }
}
