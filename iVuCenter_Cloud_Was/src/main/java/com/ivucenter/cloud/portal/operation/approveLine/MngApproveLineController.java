package com.ivucenter.cloud.portal.operation.approveLine;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.cmm.code.CmmCodeService;
import com.ivucenter.cloud.portal.cmm.code.CustomCmmCodeVO;

@Controller
@RequestMapping(value="/mng/operation/approveLine")
public class MngApproveLineController {
	
	
	@Autowired
	private ApproveLineService service;
	
	@Autowired
	private OssCloudService cloudService;
	
	@Autowired
	private CmmCodeService codeService;
	
	
	/**
	 *	PAGE 
	 */
	@RequestMapping(value="/")
	public String MngApproveLineList(Model model){
		
		List<CustomOssCloudVO> getCloudList = cloudService.getCloudList();
		model.addAttribute("getCloudList", getCloudList);
		
		
		List<CustomCmmCodeVO> approveLineType = codeService.getCmmCode("APPROVE_LINE_TYPE");

		model.addAttribute("approveLineType", approveLineType);
		
		return "mng/operation/approveLine/operationApproveLine-list";
	}
	
	
	/**
	 *	ACTION 
	 */
	@RequestMapping(value="/list", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngApproveLineList(CustomApproveLineVO req, Model model){
		return new ResponseEntity<Object>(service.list(req), HttpStatus.OK);
	}
	
	
	/**
	 * 등록
	 */
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public ResponseEntity<String> MngApproveLineInsert(CustomApproveLineVO req) {
		String res = service.insert(req);
		
		List<CustomApproveLineVO> getApproveLineList = service.getApproveLineList(req);

		for(CustomApproveLineVO vo : getApproveLineList){
			service.approveLineUpdate(vo);
		}
		
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	/**
	 * 삭제
	 */
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public ResponseEntity<String> MngApproveLineDelete(CustomApproveLineVO req) {
		String res = service.delete(req);
		
		List<CustomApproveLineVO> getApproveLineList = service.getApproveLineList(req);

		for(CustomApproveLineVO vo : getApproveLineList){
			service.approveLineUpdate(vo);
		}
		
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/stepMaxValue", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> stepMaxValue(CustomApproveLineVO req ) {


		CustomApproveLineVO res = service.stepMaxValue(req);
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
	
}
