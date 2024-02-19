package kr.or.ddit.member.mentoring.vo;

import lombok.Data;

@Data
public class SettlementDescriptionVO {
	private int settlementNo;
	private String prMbrId;
	private String settlementDt;
	private String settlementTpCd;
	private String settlementItem;
	private int settlementCo;
	private String settlementNm;
	private String settlementHp;
	private String settlementMail;
	private String settlementYn;
	private String menNcnm;
	private String prMbrNcnm;
}
