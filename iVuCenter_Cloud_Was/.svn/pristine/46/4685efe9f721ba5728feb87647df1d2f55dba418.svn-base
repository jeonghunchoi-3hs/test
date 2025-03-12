package com.ivucenter.cloud.portal.bss.product;

import java.util.List;

public interface MngBssProductService {

	//상품 관리 리스트
	String list(CustomBssProductVO req);
	//상품 관리 리스트
	List<CustomBssProductVO> bssProductList(CustomBssProductVO req);
	//	상품정보 상세
	CustomBssProductVO detail(String productSeq);
	// 상품,가상서버 상세정보
	CustomBssProductVO productView(String productSeq);
	//상품,가상서버 상세정보
	CustomBssProductVO osView(String productSeq);
	//상품,가상서버 상세정보
	CustomBssProductVO diskView(String productSeq);
	//상품,가상서버 상세정보
	CustomBssProductVO nasView(String productSeq);
	//상품,가상서버 상세정보
	CustomBssProductVO ipView(String productSeq);
	//상품,가상서버 상세정보
	CustomBssProductVO lbView(String productSeq);
	//상품,가상서버 상세정보
//	CustomBssProductVO scmView(String productSeq);
	//상품,가상서버 상세정보
//	CustomBssProductVO bkView(String productSeq);
	//상품,가상서버 상세정보
	CustomBssProductVO serviceView(String productSeq);

	CustomBssProductVO appView(String productSeq);
	//상품,가상서버 상세정보
//	CustomBssProductVO serView(String productSeq);
	//상품,가상서버 상세정보
//	CustomBssProductVO mcaView(String productSeq);
	//상품관리 vo담는 리스트
	CustomBssProductVO view(String productSeq);
	//상품 가격정보
	CustomBssProductVO getItemPriceInfo(CustomBssProductVO req);

	//상품 가격정보 (신규20200716 코드성 데이터 case문 제거)
	List<CustomBssProductVO> getItemsPriceInfo(CustomBssProductVO req);

	//os 팝업
	List<CustomBssProductVO> osPopList(CustomBssProductVO req);
	//상품 업데이트
	String productUpdate(CustomBssProductVO req);
	//vm 업데이트
	String vmUpdate(CustomBssProductVO req);
	//os 업데이트
	String osUpdate(CustomBssProductVO req);
	//os 업데이트
	String diskUpdate(CustomBssProductVO req);
	//os 업데이트
	String nasUpdate(CustomBssProductVO req);
	//os 업데이트
	String ipUpdate(CustomBssProductVO req);
	//os 업데이트
	String lbUpdate(CustomBssProductVO req);
	//os 업데이트
//	String scmUpdate(CustomBssProductVO req);
	//os 업데이트
//	String bkUpdate(CustomBssProductVO req);
	//os 업데이트
//	String serUpdate(CustomBssProductVO req);
	//os 업데이트
//	String mcaUpdate(CustomBssProductVO req);
	//service 업데이트
	String serviceUpdate(CustomBssProductVO req);
	//상품 카테고리 종류
//	List<CustomBssProductVO> pcList(String parentCodeId);
	//이미지 type
//	List<CustomBssProductVO> getItemImageType(String parentCodeId);

//	List<CustomBssProductVO> getCmmCode(CustomBssProductVO req);

	CustomBssProductVO getProductImageType(CustomBssProductVO req);

	CustomBssProductVO getProductDiskType(CustomBssProductVO req);


	String productDelete(CustomBssProductVO req);

	String vmDelete(CustomBssProductVO req);

	String diskDelete(CustomBssProductVO req);

	String seviceDelete(CustomBssProductVO req);

	String osDelete(CustomBssProductVO req);



	//서비스 상품 등록
	String serviceInsert(CustomBssProductVO req);

	String productInsert(CustomBssProductVO req);
	//vm 등록
	String vmInsert(CustomBssProductVO req);
	//os 등록
	String osInsert(CustomBssProductVO req);
	//os 등록
	String diskInsert(CustomBssProductVO req);
	//os 등록
	String nasInsert(CustomBssProductVO req);
	//os 등록
	String ipInsert(CustomBssProductVO req);
	//os 등록
	String lbInsert(CustomBssProductVO req);
	//template 등록
	String templateInsert(CustomBssProductVO req);
	//os 등록
//	String scmInsert(CustomBssProductVO req);
	//os 등록
//	String bkInsert(CustomBssProductVO req);
	//os 등록
//	String serInsert(CustomBssProductVO req);
	//os 등록
//	String mcaInsert(CustomBssProductVO req);
	public String containerInsert(CustomBssProductVO req);

	public String envInsert(CustomBssProductVO req);


	int pageNum(CustomBssProductVO req);
	List<CustomBssProductVO> excel(CustomBssProductVO req);

}
