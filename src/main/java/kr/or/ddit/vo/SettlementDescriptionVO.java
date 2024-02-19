package kr.or.ddit.vo;

import lombok.Data;

@Data
public class SettlementDescriptionVO {
	private int settlementNo;
	private String prMbrId;
	private String settlementYmd;
	private String settlementTpCd;
	private String settlementItem;
	private int settlementCo;
	private String settlementNm;
}
