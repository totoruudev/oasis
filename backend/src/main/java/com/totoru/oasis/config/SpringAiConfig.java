package com.totoru.oasis.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.ExchangeStrategies;
import org.springframework.web.reactive.function.client.WebClient;

@Configuration
public class SpringAiConfig {
    @Bean
    public WebClient webClient() {
        // 10MB로 제한 확대
        int maxSize = 10 * 1024 * 1024;
        ExchangeStrategies strategies = ExchangeStrategies.builder()
                .codecs(configurer -> configurer
                        .defaultCodecs()
                        .maxInMemorySize(maxSize))
                .build();
        return WebClient.builder()
                .exchangeStrategies(strategies)
                .build();
    }
}