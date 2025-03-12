package com.ivucenter.cloud.portal.bss.catalog;

import java.util.List;

public interface BssCatalogService {

	//카테고리 관리 리스트
	String list(CustomBssCatalogVO req);
	//카탈로그 업데이트
	String catalogUpdate(CustomBssCatalogVO req);
	//카탈로그 상세
	CustomBssCatalogVO catalogDetail(String catalogSeq);
	//카테고리 가상서버 리스트
	List<CustomBssCatalogVO> getCatalogueProductList(CustomBssCatalogVO catal);
	//카테고리 운영체제 리스트
	List<CustomBssCatalogVO> getCatalogueProductOsList(CustomBssCatalogVO catal);

	//카테고리 블록디스크 리스트
	List<CustomBssCatalogVO> getCatalogueProductDiskList(CustomBssCatalogVO catal);
	//카테고리 NAS 리스트
	List<CustomBssCatalogVO> getCatalogueProductNasList(CustomBssCatalogVO catal);
	//카테고리 공인IP 리스트
	List<CustomBssCatalogVO> getCatalogueProductPublicIpList(CustomBssCatalogVO catal);
	//카테고리 로드밸런서 리스트
	List<CustomBssCatalogVO> getCatalogueProductLbList(CustomBssCatalogVO catal);

	List<CustomBssCatalogVO> getCatalogueProductServiceList(CustomBssCatalogVO catal);
	//카테고리 형상관리 리스트
//	List<CustomBssCatalogVO> getCatalogueProductScmList(CustomBssCatalogVO catal);
	//카테고리 백업 리스트
//	List<CustomBssCatalogVO> getCatalogueProductBackupList(CustomBssCatalogVO catal);
	//카테고리 보안관제 리스트
//	List<CustomBssCatalogVO> getCatalogueProductSercurityList(CustomBssCatalogVO catal);
	//카테고리 대외계 리스트
//	List<CustomBssCatalogVO> getCatalogueProductMcaList(CustomBssCatalogVO catal);


	//DataTable 용
	//카테고리상세 상품 리스트
	String catalogueProductList(CustomBssCatalogVO req);
	String updateDisplayOrder(CustomBssCatalogVO req);
	//카탈로그 상품별 Count
	int getDisplayOrderCount(CustomBssCatalogVO req);

	//카테고리 가상서버 상세
	CustomBssCatalogVO productView(CustomBssCatalogVO req);
	//카테고리 os 상세
	CustomBssCatalogVO osView(CustomBssCatalogVO req);
	//카테고리 상세
	CustomBssCatalogVO detail(String catalogSeq);
	//가상서버 상세 수정 업데이트
	String update(CustomBssCatalogVO req);
	//os 상세 수정 업데이트
	String osUpdate(CustomBssCatalogVO req);

	//상품 등록
	String productInsert(CustomBssCatalogVO req);
	String osInsert(CustomBssCatalogVO req);
	String appInsert(CustomBssCatalogVO req);
	String diskInsert(CustomBssCatalogVO req);
	String nasInsert(CustomBssCatalogVO req);
	String ipInsert(CustomBssCatalogVO req);
	String lbInsert(CustomBssCatalogVO req);
	String envInsert(CustomBssCatalogVO req);
	String serviceInsert(CustomBssCatalogVO req);

//	String scmInsert(CustomBssCatalogVO req);
//	String bkInsert(CustomBssCatalogVO req);
//	String serInsert(CustomBssCatalogVO req);
//	String mcaInsert(CustomBssCatalogVO req);

	//가상머신 팝업
	List<CustomBssCatalogVO> productPopList(CustomBssCatalogVO req);
	//os 팝업
	List<CustomBssCatalogVO> osPopList(CustomBssCatalogVO req);
	//template 팝업
	List<CustomBssCatalogVO> templatePopList(CustomBssCatalogVO req);
	//서비스 팝업
	List<CustomBssCatalogVO> servicePopList(CustomBssCatalogVO req);
	//os 팝업
	List<CustomBssCatalogVO> diskPopList(CustomBssCatalogVO req);
	//os 팝업
	List<CustomBssCatalogVO> nasPopList(CustomBssCatalogVO req);
	//os 팝업
	List<CustomBssCatalogVO> ipPopList(CustomBssCatalogVO req);
	//os 팝업
	List<CustomBssCatalogVO> lbPopList(CustomBssCatalogVO req);

	List<CustomBssCatalogVO> envPopList(CustomBssCatalogVO req);

//	List<CustomBssCatalogVO> scmPopList(CustomBssCatalogVO req);
//	List<CustomBssCatalogVO> bkPopList(CustomBssCatalogVO req);
//	List<CustomBssCatalogVO> serPopList(CustomBssCatalogVO req);
//	List<CustomBssCatalogVO> mcaPopList(CustomBssCatalogVO req);

	//카탈로그 등록 관련 전 카탈로그 정보 체크
	List<CustomBssCatalogVO> getOldCataloginfo(String applyDate);
	//카탈로그 등록 관련 전 카탈로그 정보 체크
	List<CustomBssCatalogVO> getCopyCataloginfo(String catalogSeq);

	String productDisplayUpdate(CustomBssCatalogVO req);

	String productDelchk(CustomBssCatalogVO req);


	//2017.12.13 박진우 작업
	String insert(CustomBssCatalogVO req);
	String catalogNewInsert(CustomBssCatalogVO req);

	String delete(CustomBssCatalogVO req);
	String catalogProductDelete(CustomBssCatalogVO req);

	List<CustomBssCatalogVO> excel(CustomBssCatalogVO req);
	List<CustomBssCatalogVO> catalogueProductExcel(CustomBssCatalogVO req);
}
