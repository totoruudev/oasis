package com.totoru.oasis.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.ExchangeStrategies;
import org.springframework.web.reactive.function.client.WebClient;

@Configuration
public class WebClientConfig {

    @Value("${OPENAI_API_KEY}")
    private String openaiApiKey;

    @Bean
    public WebClient webClient() {

        int maxSize = 10 * 1024 * 1024;
        ExchangeStrategies strategies = ExchangeStrategies.builder()
                .codecs(configurer -> configurer
                        .defaultCodecs()
                        .maxInMemorySize(maxSize))
                .build();
        return WebClient.builder()
                .baseUrl("https://api.openai.com/v1")
                .defaultHeader("Authorization", "Bearer " + openaiApiKey)  // ✅ 필수
                .defaultHeader("Content-Type", "application/json")         // ✅ 필수
                .exchangeStrategies(strategies)
                .build();
    }
}
