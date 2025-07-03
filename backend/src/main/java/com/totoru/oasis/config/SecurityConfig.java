package com.totoru.oasis.config;

import com.totoru.oasis.service.CustomUserDetailsService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final CustomUserDetailsService customUserDetailsService;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                // CORS (React 연동시 기본 허용)
                .cors(Customizer.withDefaults())

                // CSRF(REST API, 세션기반이면 disable 추천)
                .csrf(csrf -> csrf.disable())

                // 세션 정책: 세션(STATELESS X, 즉 기본값 유지)
                .sessionManagement(session -> session
                        .sessionCreationPolicy(
                                // STATELESS 아니고 기본값(=IF_REQUIRED)로 하면 세션 유지
                                org.springframework.security.config.http.SessionCreationPolicy.IF_REQUIRED
                        )
                )

                // 권한 설정
//                .authorizeHttpRequests(auth -> auth
//                        // [정적 리소스]
//                        .requestMatchers(
//                                "/", "/index.html",
//                                "/images/**", "/data/**", "/uploads/**",
//                                "/static/**", "/css/**", "/js/**").permitAll()
//                        // [회원가입, 로그인 등 인증 없이 허용해야 할 엔드포인트]
//                        .requestMatchers(
//                                "/api/users/join", "/api/users/login", "/api/users/check-*", "/api/users/check/*", "/api/users/check*",
//                                "/api/email/send", "/api/email/verify",
//                                "/api/event/**",
//                                "/api/products/**", "/api/products/sections",
//                                "/api/categories", "/api/categories/**",
//                                "/api/subcategories", "/api/subcategories/**",
//                                "/api/notices/**",
//                                "/api/banner/**",
//                                "/api/board/list",
//                                "/api/board/detail/{id}",
//                                "/api/chatting/**",
//                                "/api/datarooms/**",
//                                "/api/notices/",
//                                "/api/notices/latest",
//                                "/api/notices/{id}"
//                        ).permitAll()
//                        // [그 외 나머지는 인증 필요]
//                        .anyRequest().authenticated()
//                )
                .authorizeHttpRequests(auth -> auth
                        .anyRequest().permitAll()
                )


                // 폼 로그인/로그아웃은 REST API에서 직접 구현하므로 비활성화
                .formLogin(form -> form.disable())
                .logout(logout -> logout.disable())
        ;

        return http.build();
    }

    @Bean
    public CorsFilter corsFilter() {
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowCredentials(true); // 쿠키/세션 허용
        config.addAllowedOrigin("http://localhost:3000"); // 프론트 주소만 명확히
        config.addAllowedHeader("*");
        config.addAllowedMethod("*");

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);
        return new CorsFilter(source);
    }
}
