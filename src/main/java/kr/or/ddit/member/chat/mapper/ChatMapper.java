package kr.or.ddit.member.chat.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.member.chat.vo.ChatRoomVO;
import kr.or.ddit.member.chat.vo.ChatVO;

public interface ChatMapper {

	public List<ChatRoomVO> selectChatList();
	public ChatRoomVO selectChatRoom(Map<String, String> map);
	public ChatRoomVO getChatRoom(Map<String, String> map);
	public int chat(ChatVO chat);
	public List<ChatVO> chatLog(int roomNo);
}
