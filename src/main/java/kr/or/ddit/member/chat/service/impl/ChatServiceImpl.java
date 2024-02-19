package kr.or.ddit.member.chat.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.member.chat.mapper.ChatMapper;
import kr.or.ddit.member.chat.service.ChatService;
import kr.or.ddit.member.chat.vo.ChatRoomVO;
import kr.or.ddit.member.chat.vo.ChatVO;

@Service
public class ChatServiceImpl implements ChatService {

	@Inject
	private ChatMapper chatMapper;
	
	@Override
	public List<ChatRoomVO> selectChatList() {
		return chatMapper.selectChatList();
	}


	@Override
	public ChatRoomVO getChatRoom(Map<String, String> map) {
		return chatMapper.getChatRoom(map);
	}

	@Override
	public ChatRoomVO selectChatRoom(Map<String, String> map) {
		return chatMapper.selectChatRoom(map);
	}


	@Override
	public int chat(ChatVO chat) {
		return chatMapper.chat(chat);
	}


	@Override
	public List<ChatVO> chatLog(int roomNo) {
		return chatMapper.chatLog(roomNo);
	}



	
	
}
