var GlbZipcode = "";
var GlbAddress1 = "";
var GlbAddress2 = "";

/**
 * 주소검색을 수행할 팝업 페이지를 호출합니다.
 * 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
 */
function goPopZipcode(){
	var pop = window.open("zipcode","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}

/**
 * 조회하는 우편번호 필드명을 정의한다.
 * @param a
 * @param b
 * @param c
 */
function setZipCode(a, b, c) {
	GlbZipcode = a;	// 우편번호
	GlbAddress1 = b;	// 주소1
	GlbAddress2 = c;	// 주소2
}

/**
 * 
 * @param roadFullAddr		도로명주소 전체(포멧)
 * @param roadAddrPart1		도로명주소
 * @param addrDetail			고객입력 상세주소
 * @param roadAddrPart2		참고주소
 * @param engAddr				영문 도로명주소
 * @param jibunAddr				지번 주소 
 * @param zipNo						우편번호
 * @param admCd					행정구역코드
 * @param rnMgtSn				도로명코드
 * @param bdMgtSn				건물관리번호
 */
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn){
	$("#"+GlbZipcode).val(zipNo);
    $("#"+GlbAddress1).val(roadAddrPart1);
    $("#"+GlbAddress2).val(addrDetail);
}