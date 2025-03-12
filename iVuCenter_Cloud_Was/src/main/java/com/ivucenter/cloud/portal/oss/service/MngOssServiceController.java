package com.ivucenter.cloud.portal.oss.service;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.api.common.batch.BatchProcessor;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.OpenStackComplexQuota;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.project.quota.CustomQuotaVO;
import com.ivucenter.cloud.portal.util.TokenGenerator;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/oss/service")
public class MngOssServiceController{

    private static final Logger logger = LoggerFactory.getLogger(MngOssServiceController.class);

	@Autowired
	private CmmUserService cmmUserService;

	@Autowired
	private OssServiceService service;

	@Autowired
	private OssCloudService ossCloudService;

	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MngOssVmList(CustomOssServiceVO req , ModelMap model) {
		String res = service.list(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	@RequestMapping(value="/serviceDetail", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> projectServiceDetail(CustomOssServiceVO req , ModelMap model) {
		String res = service.serviceDetail(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	@RequestMapping(value = "/projectVmInfo", method = RequestMethod.GET)
	public ResponseEntity<Object> projectManagerApproveCheck(HttpServletRequest request, ModelMap model) {
		String projectId = request.getParameter("projectId");
		String cloudId = request.getParameter("cloudId");
		Assert.notNull(projectId, "");
		Assert.notNull(cloudId, "");

		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(cloudId);

		CustomQuotaVO vo = new CustomQuotaVO();
		OpenStackComplexQuota vo2 = new OpenStackComplexQuota();
		try {
			 vo2 = (OpenStackComplexQuota)BatchProcessor.getQuota(projectId, cloudVo);
			 vo.setNetwork(vo2.getNetwork());
			 vo.setRam(vo2.getRam());
			 vo.setCores(vo2.getCores());
			 vo.setVolumes(vo2.getVolumes());
			 vo.setInstances(vo2.getInstances());
			 vo.setProjectName(vo2.getProjectName());

	 	} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
		 vo.setErrorMsg(e.getMessage());
	 	}

		model.addAttribute("ram", vo.getRam());
		model.addAttribute("cores", vo.getCores());
		model.addAttribute("volumes", vo.getVolumes());
		model.addAttribute("instances", vo.getInstances());
		return new ResponseEntity<Object>(model, HttpStatus.OK);
	}

	@RequestMapping(value="/catalogueVmlist", method = RequestMethod.GET)
	public ResponseEntity<String> MngOsscatalogueVmList(CustomOssServiceVO req) {

		String res = service.catalogueVmlist(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/detail")
	public ResponseEntity<CustomOssServiceVO> MngOssVmDetail(CustomOssServiceVO req) {

		CustomOssServiceVO res = service.detail(req);
		return new ResponseEntity<CustomOssServiceVO>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/update")
	public ResponseEntity<String> MngOssVmUpdate(CustomOssServiceVO req, Principal principal) {
		String res = "";
		try {
			req.setModUserId(principal.getName());
			res = service.update(req);

			return new ResponseEntity<String>(res, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	@RequestMapping(value = "/passWordCheck")
	public ResponseEntity<String> MngOssVmPassWordCheck(CustomOssServiceVO req, Principal principal) {
		String res = "";
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

	   String insertPassWord =TokenGenerator.generate(userSession.getUsername(), req.getPassWord());

        String sessionPassword =  userSession.getPassword();

        req.setUserId(userSession.getUsername());
		req.setUserName(userSession.getNickname());
		req.setIp(getIp());

       if(insertPassWord.equals(sessionPassword)){
			res = service.vmHistoryInsert(req);
       }else{
    	   res = "2";
       }
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	@RequestMapping(value = "/action")
	public ResponseEntity<String> MngOssVmAction(CustomOssServiceVO req) {
		String res = service.action(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/actionUserHistory")
	public ResponseEntity<String> MngOssVmActionUserHistory(CustomCmmUserVO req) {
		String res = "1";
		req.setUserPassword(TokenGenerator.generate(req.getUserId(),req.getUserPassword()));
		req.setUserId(req.getUserId());
		req.setProjectId(req.getProjectId());
		req.setProjectName(req.getProjectName());
		req.setVmUuid(req.getVmUuid());
		req.setAction(req.getAction());
		req.setDescription(req.getDescription());

		try {
			InetAddress local;
			local = InetAddress.getLocalHost();
			req.setIp(local.getHostAddress());
		} catch (UnknownHostException e) {
            logger.error("UnknownHostException");
		}

		String sPw = req.getUserPassword();

		CustomCmmUserVO userIf = cmmUserService.loginChk(req);
		if(userIf.getUserPassword().equals(sPw)) {
			cmmUserService.insertUserdescription(req);
             res = "0";
			return new ResponseEntity<String>(res, HttpStatus.OK);
		}

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	private String getIp() {
		String ret = "";

		try {
			InetAddress local = null;
			local = InetAddress.getLocalHost();
			if(null!=local) { ret = local.getHostAddress(); }

		} catch (UnknownHostException e) {
			log.error(e.getMessage());
		}
		return ret;
	}

	@RequestMapping(value = "/excel")
	public ModelAndView MngOssVmExcel(CustomOssServiceVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "vm");
		map.addAttribute("excel_title", "프로젝트_가상서버 목록");
		map.addAttribute("excel_list", service.excel(req));

		return new ModelAndView("productExcelView", map);
	}

	@RequestMapping(value = "/serviceDetailInfo")
	public ResponseEntity<CustomOssServiceVO> MngServiceDetailInfo(CustomOssServiceVO req) {
		CustomOssServiceVO res = service.serviceDetailInfo(req);
		return new ResponseEntity<CustomOssServiceVO>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/viewExcel")
	public ModelAndView MngOssserviceViewExcel(CustomOssServiceVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "serviceView");
		map.addAttribute("excel_title", "서비스_상세");
		map.addAttribute("excel_list", service.viewExcel(req));
		return new ModelAndView("productExcelView", map);
	}


}
