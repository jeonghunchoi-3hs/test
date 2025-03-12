package com.ivucenter.cloud.portal.bbs.download;

import java.util.List;

import com.ivucenter.cloud.entity.BbsDownloadVO;
import com.ivucenter.cloud.portal.cmm.file.CustomCmmFileVO;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomBbsDownloadVO extends BbsDownloadVO{

	// 리스트 검색	
	private String searchKind;
	private String keyword = "";
	
	private String category;
	

	// 등록페이지 select Box	
	private String codeKeyId = CodeUtil.CMM_CODE_DOWNLOAD;
	private String codeName;

	
	// 다운로드 파일 정보	
	private String 	fileId;
	private String fileName;
	private String filePath;
	private int fileSize;

	private List<CustomCmmFileVO> fileList;	

	public String getCategory() {
		if (this.category == null) return "";
		if (this.category.equals("manual")) return "매뉴얼";
		if (this.category.equals("policy")) return "약관";
		if (this.category.equals("archive")) return "일반자료";
		return "";
	}
}
