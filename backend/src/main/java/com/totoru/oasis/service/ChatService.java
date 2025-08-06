package com.totoru.oasis.service;

import com.totoru.oasis.repository.ChatRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ChatService {

    private final WebClient webClient;
    private final ChatRepository chatRepository;

    @Value("${openai.api.key}")
    private String openaiApiKey;

    public static final Map<String, String> presetAnswers = Map.of(
            "배송은 얼마나 걸리나요?", "주말, 공휴일 제외 평균 1~3일 이내에 배송됩니다.",
            "교환/반품은 어떻게 하나요?", "상품 수령일 기준 7일 이내 신청 시 가능합니다.",
            "비회원도 주문할 수 있나요?", "비회원은 주문이 불가능합니다. 로그인 후 이용해주세요.",
            "결제수단은 무엇이 있나요?", "현재 토스페이를 이용한 결제를 지원하고 있으며, 다른 결제 방법은 현재 지원하고 있지 않습니다."
    );

    public String replyTo(String userInput) {
        String answer;

        // FAQ 매핑 체크
        if (presetAnswers.containsKey(userInput.trim())) {
            answer = presetAnswers.get(userInput.trim());
        } else {
            String systemPrompt = "너는 오아시스 마켓의 AI 상담원이야. 오아시스마켓과 무관하d거나 구현되지 않은 기능은 '지원하지 않습니다.'라고 답해.";
            var messages = List.of(
                    Map.of("role", "system", "content", systemPrompt),
                    Map.of("role", "user", "content", userInput)
            );

            var chatRequest = Map.of(
                    "model", "gpt-4o",
                    "messages", messages
            );

            answer = webClient.post()
                    .uri("https://api.openai.com/v1/chat/completions")
                    .header("Authorization", "Bearer " + openaiApiKey)
                    .header("Content-Type", "application/json")
                    .bodyValue(chatRequest)
                    .retrieve()
                    .bodyToMono(Map.class)
                    .map(response -> {
                        var choices = (List<?>) response.get("choices");
                        if (choices != null && !choices.isEmpty()) {
                            var message = (Map<?, ?>) ((Map<?, ?>) choices.get(0)).get("message");
                            return message != null ? (String) message.get("content") : "GPT 응답이 없습니다.";
                        }
                        return "GPT 응답이 없습니다.";
                    })
                    .block();

        }
        return answer;
    }
}
