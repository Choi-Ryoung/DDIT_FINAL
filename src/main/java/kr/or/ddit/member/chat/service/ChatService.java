package kr.or.ddit.member.chat.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.member.chat.vo.ChatRoomVO;
import kr.or.ddit.member.chat.vo.ChatVO;

public interface ChatService {

	public List<ChatRoomVO> selectChatList();
	public ChatRoomVO selectChatRoom(Map<String, String> map);
	public ChatRoomVO getChatRoom(Map<String, String> map);
	public int chat(ChatVO chat);
	public List<ChatVO> chatLog(int roomNo);

}
