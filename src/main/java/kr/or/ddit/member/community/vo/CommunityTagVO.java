package kr.or.ddit.member.community.vo;

import lombok.Data;

@Data
public class CommunityTagVO {
    private int comntPstNo;
    private String comntTag;
    private String tagTitle;
    private String tagContent;
    // 추가적으로 필요한 다른 속성들을 계속해서 정의할 수 있습니다.
}
