package com.ivucenter.cloud.batch.billing;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum InvoiceTemplate {
			CLOUD_PRODUCT		("A000", "클라우드 상품", 1),
			BASIC_PRODUCT		("AA00", "기본 상품", 2),
			VIRTUAL_MACHINE		("AAA0", "가상 서버", 3),
			ADDITIONAL_PRODUCT	("AE00", "부가 상품", 2),
			BLOCK_STORAGE		("AEA0", "블록디스크", 3),
			NAS_STORAGE			("AEB0", "NAS", 3),
			LOADBALANCER_STORAGE("AEC0", "서비스 로드분산", 3),
			PUBLICIP_STORAGE	("AED0", "공인IP", 3),				
			SERVICE				("AI00", "서비스", 2),
//			BACKUP_SERVICE		("AIA0", "백업 서비스", 3),
//			MCA_SERVICE			("AIB0", "대외계 서비스", 3),	
//			SCM_SERVICE			("AIC0", "형상관리 서비스", 3),	
//			SECURITY_SERVICE	("AID0", "보안관제 서비스", 3),
			
			SERVICE_SERVICE		("SVS0", "서비스", 3),						
			
			DISCOUNT_SUM		("E000", "요금할인", 1),
			PROJECT_DISCOUNT	("EA00", "프로젝트 할인", 2),
			WON_TRIM_DISCOUNT	("EL00", "10원미만 절사 할인", 2),
			ADJUST_SUM			("I000", "보정", 1),
			ADJUST_ITEM			("IA00", "보정명칭", 2),
			VAT_SUM				("L000", "부가가치세(세금)", 1),
			VAT_ITEM			("LA00", "부가가치세", 2),
			TOTAL_AMOUNT		("0000", "총 청구금액", 0);
		
		private String code;
		private String label;
		private int depth;
}
