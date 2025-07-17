package com.totoru.oasis.config;

import com.totoru.oasis.service.CustomUserDetailsService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.List;

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
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                // ✅ CORS 설정을 CorsConfigurationSource Bean을 사용하도록 수정
                .cors(cors -> cors.configurationSource(corsConfigurationSource()))

                // CSRF 비활성화
                .csrf(csrf -> csrf.disable())

                // 세션 정책: IF_REQUIRED
                .sessionManagement(session -> session
                        .sessionCreationPolicy(org.springframework.security.config.http.SessionCreationPolicy.IF_REQUIRED)
                )

                // 권한 설정
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(
                                "/", "/index.html",
                                "/images/**", "/data/**", "/uploads/**",
                                "/static/**", "/css/**", "/js/**",
                                "/api/images/**", "/api/data/**", "/api/uploads/**",
                                "/api/static/**", "/api/css/**", "/api/js/**"
                        ).permitAll()
                        .requestMatchers(
                                "/api/users/join", "/api/users/login", "/api/users/check-*", "/api/users/check/*", "/api/users/check*",
                                "/api/email/send", "/api/email/verify",
                                "/api/event/**",
                                "/api/products/sections",
                                "/api/products/{id}", "/api/products/category/{categoryId}",
                                "/api/products/subcategory", "/api/products/subcategory/{id}",
                                "/api/categories/**",
                                "/api/chat"
                        ).permitAll()

                        .requestMatchers(
                                "/api/admin/**", "/api/admin/images/**",
                                "/api/upload/**", "/api/admin/users/**"
                        ).hasRole("ADMIN")

                        .anyRequest().authenticated()
                )

                // 폼 로그인/로그아웃 비활성화
                .formLogin(form -> form.disable())
                .logout(logout -> logout.disable());

        return http.build();
    }

    // CorsFilter Bean 대신 CorsConfigurationSource Bean을 등록
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowCredentials(true);
        config.addAllowedOriginPattern("*");
        config.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS"));
        config.setAllowedHeaders(List.of("*"));

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);
        return source;
    }


}
