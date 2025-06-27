package com.totoru.oasis.service;

import com.totoru.oasis.entity.ChatMessage;
import com.totoru.oasis.entity.ChatRoom;
import com.totoru.oasis.entity.User;
import com.totoru.oasis.repository.ChatMessageRepository;
import com.totoru.oasis.repository.ChatRoomRepository;
import com.totoru.oasis.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ChattingMessageService {

    private final ChatMessageRepository chatMsgRepo;
    private final ChatRoomRepository chatRoomRepo;
    private final UserRepository userRepo;

    public List<ChatMessage> getMessages(Long roomId) {
        return chatMsgRepo.findByRoomIdOrderByTimestampAsc(roomId);
    }

    public ChatMessage sendMessage(Long roomId, Long senderId, String content) {
        ChatRoom room = chatRoomRepo.findById(roomId).orElseThrow();
        User sender = userRepo.findById(senderId).orElseThrow();

        ChatMessage message = new ChatMessage();
        message.setRoom(room);
        message.setSender(sender);
        message.setContent(content);
        return chatMsgRepo.save(message);
    }

    @Transactional
    public void deleteMessagesByRoomId(Long roomId) {
        chatMsgRepo.deleteMessagesByRoomId(roomId); // JPQL 직접 삭제
    }


}
