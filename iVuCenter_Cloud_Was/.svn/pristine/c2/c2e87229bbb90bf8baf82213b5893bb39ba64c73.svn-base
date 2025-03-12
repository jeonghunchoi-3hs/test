package com.ivucenter.cloud.portal.cmm.cloud;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/mbr/cmm/cloud")
public class MbrOssCloudController {

	@Autowired
	private OssCloudService service;

	// 클라우드 검색
	@RequestMapping(value = "/cloudSelect")
	public ResponseEntity<Object> customerSearch(HttpServletRequest request) {
		
		List<CustomOssCloudVO> getCloudList = service.getCloudList();
		return new ResponseEntity<Object>(getCloudList, HttpStatus.OK);
	}
}
