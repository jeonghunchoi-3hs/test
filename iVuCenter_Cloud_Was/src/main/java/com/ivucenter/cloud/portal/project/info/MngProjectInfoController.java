package com.ivucenter.cloud.portal.project.info;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.cmm.file.CmmFileService;
import com.ivucenter.cloud.portal.cmm.file.CustomCmmFileVO;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.project.ReqProjectService;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/project/info")
public class MngProjectInfoController {

	@Autowired
	private CmmFileService cmmFileService;

	@Autowired
	private ReqProjectService reqProjectService;

    @Autowired
	private OssCloudService ossCloudService;

	/**
	 *	PAGE
	 */

	@RequestMapping(value="/")
	public String MngProjectInfo(Model model) {
		log.debug("MngProjectInfoController:MngProjectInfo()");


		return "mng/project/info/projectInfo_list";
	}

	@RequestMapping(value="/view", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public String MngProjectInfoView(Model model, CustomOssProjectVO req) {

		Assert.notNull(req.getReqProjectSeq(), 	"req.getReqProjectSeq()");
		Assert.notNull(req.getProjectBoxId(), 	"req.getProjectBoxId()");

		req.setProjectBoxId(req.getProjectBoxId());

		System.out.println(req.getProjectBoxId());
		model.addAttribute("req", req);

		CustomCmmFileVO vo = new CustomCmmFileVO();
		vo.setProgramName(CodeUtil.FILE_PROGRAM_NAME4);
		vo.setProgramSeq(req.getReqProjectSeq());
		model.addAttribute("file", cmmFileService.list(vo));
		model.addAttribute("downloadNo", req.getReqProjectSeq());

		List<CustomOssProjectVO> cloudProjectInfo = reqProjectService.cloudProjectInfo(req);

		log.debug("callback In Run ############### ");
		for( int i =0; i<cloudProjectInfo.size(); ++i) {
			CustomOssProjectVO customOssProjectVO = new CustomOssProjectVO();
			customOssProjectVO = (CustomOssProjectVO) cloudProjectInfo.get( i);

			if( "Y".equals( customOssProjectVO.getQuotaYn())) {
				log.debug(customOssProjectVO.getCloudName());
			}
		}
		log.debug("callback Run ###############");


		model.addAttribute("cloudProjectInfo",cloudProjectInfo);


		List<CustomOssCloudVO> reqProjectCloudList = ossCloudService.getOssProjectByProjectBoxId(req.getProjectBoxId());

		model.addAttribute("reqProjectCloudList", reqProjectCloudList);


		CustomReqCustomerVO customReqCustomerVO = new CustomReqCustomerVO();
		customReqCustomerVO.setProjectBoxId(req.getProjectBoxId());
		List<CustomReqCustomerVO> managerList = reqProjectService.managerList(customReqCustomerVO);
		for(CustomReqCustomerVO vo1 : managerList) {
			vo1.setUserPhone(vo1.getUserPhoneDec());
			vo1.setUserMail(vo1.getUserMailDec());
			vo1.setUserTel(vo1.getUserTelDec());
    	}
		model.addAttribute("managerList", managerList);

		return "mng/project/info/projectInfo_view";
	}

	@RequestMapping(value="/write")
	public String MngProjectInfoWrite(Model model, CustomOssProjectVO req) {

		Assert.notNull(req.getProjectId(), "req.getProjectId()");
		model.addAttribute("req", req);

		return "mng/project/info/projectInfo_write";
	}
}
