package com.ivucenter.cloud.portal.bss.productOs;

import java.util.List;

public interface MngBssProductOsService {
	
	// 이미지 리스트 조회
	String list(CustomBssProductOsVO req);
	// 이미지 상세정보 조회
	CustomBssProductOsVO detail(String productSeq);
	// 상품,가상서버 상세정보
	CustomBssProductOsVO productView(String productSeq);
	// 상품,가상서버 상세정보
	CustomBssProductOsVO osView(String productSeq);
	//상품관리 vo담는 리스트
	CustomBssProductOsVO view(String productSeq);
	// 이미지 상세정보 값 삭제
	String delete(String productSeq);
	// 상품의 이미지 값 삭제
	String productDelete(String productSeq);
	
	//os 팝업
	List<CustomBssProductOsVO> osPopList(CustomBssProductOsVO req);
	//상품 업데이트
	String productUpdate(CustomBssProductOsVO req);	
	//vm 업데이트
	String vmUpdate(CustomBssProductOsVO req);	
	//os 업데이트
	String osUpdate(CustomBssProductOsVO req);
	//상품 카테고리 종류
//	List<CustomBssProductOsVO> pcList(String parentCodeId);
	
	//상품 등록
	String productInsert(CustomBssProductOsVO req);
	//vm 등록
	String vmInsert(CustomBssProductOsVO req);
	//os 등록
	String osInsert(CustomBssProductOsVO req);
	
	CustomBssProductOsVO productSeqReturn(CustomBssProductOsVO req);
	

}
