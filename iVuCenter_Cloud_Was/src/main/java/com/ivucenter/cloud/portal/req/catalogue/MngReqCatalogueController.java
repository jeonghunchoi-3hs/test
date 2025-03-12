package com.ivucenter.cloud.portal.req.catalogue;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.portal.cmm.code.CmmCodeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/req/catalogue")
public class MngReqCatalogueController {
	
	@Autowired
	private ReqCatalogueService reqCatalogueService;
	
	@Autowired
	CmmCodeService service;
	
	//프로젝트 검색
	@RequestMapping(value = "/projectPopList", method = RequestMethod.GET)
	public ResponseEntity<Object> getprojectPopList(HttpServletRequest request){			
			log.debug("MngReqCatalogueController:getprojectPopList()");
			HashMap<String, Object> map = new HashMap<>();
			map.put("userId", request.getUserPrincipal().getName());
			String searchValue =  request.getParameter("searchValue");
			CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();			
			//projectvo.setSearchKey(searchKey);
			projectvo.setSearchValue(searchValue);
			projectvo.setRegUserId("");
			
			List<CustomReqCatalogueVO> getProjectList = reqCatalogueService.getProjectList(projectvo);			
		
			for(int i=0;i<getProjectList.size();i++){		
				String lowProjectName = getProjectList.get(i).getProjectName().toLowerCase();
				getProjectList.get(i).setLowProjectName(lowProjectName);
			}			

			map.put("getProjectList", getProjectList);
			//model.addAttribute("searchKey", searchKey);
			map.put("searchValue", searchValue);
			return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

}
