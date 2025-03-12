package com.ivucenter.cloud.portal.oss.application;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ivucenter.cloud.api.openshift.object.OpsApiOptionService;
import com.ivucenter.cloud.api.openshift.object.OpsApiOptionVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.login.UserSession;

import io.fabric8.kubernetes.api.model.autoscaling.v2.HorizontalPodAutoscaler;
import io.fabric8.kubernetes.api.model.autoscaling.v2.HorizontalPodAutoscalerCondition;

@Controller
@RequestMapping(value="/mbr/oss/app")
public class MbrOssAppController {

	@Autowired
	private OssAppService service;

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	private OpsApiOptionService opsApiOptionService;
	/**
	 *	ACTION
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrOssDiskList(CustomOssAppVO req){
		String res = service.list(req);
		//log.debug(res);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


	@RequestMapping(value="/catalogueList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> catalogueList(CustomOssAppVO req){
		String res = service.list(req);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/catalogueAppList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> MbrOsscatalogueAppList(CustomOssAppVO req) {
		String res = service.catalogueApplist(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/pvAppList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrOssPvAppList(CustomOssAppVO req){
		String res = service.pvAppList(req);
		//log.debug(res);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/scaleOutWrite")
	public String ScaleOutWrite(Model model, CustomOssAppVO req) {
	try{
		CustomOssAppVO res = service.scaleOutDetail(req);
//			if(res != null) {
//				res.setManagerTel(res.getManagerTelDec());
//			}
			model.addAttribute("scaleOutdetail", res);

			return "mbr/application/management/scaleOutWrite";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}

	@RequestMapping(value = "/scaleOutUpdate")
	public ResponseEntity<String> MbrBssScaleOutUpdate(CustomOssAppVO req, Model model){

		String res = "";

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
		OpsApiOptionVO opsApiOptionVO = new OpsApiOptionVO();

		opsApiOptionVO.setNameSpace(req.getNameSpace());
		opsApiOptionVO.setAppName(req.getAppName());
		opsApiOptionVO.setScaleOutName(req.getScaleOutName());
		opsApiOptionVO.setHpaMin(req.getHpaMin());
		opsApiOptionVO.setHpaMax(req.getHpaMax());
		opsApiOptionVO.setHpaContinue(req.getHpaContinue());
		opsApiOptionVO.setHpaMinPod(req.getHpaMinPod());
		opsApiOptionVO.setHpaMaxPod(req.getHpaMaxPod());
		opsApiOptionVO.setHpaIncrePod(req.getHpaIncrePod());
		opsApiOptionVO.setHpaDivision(req.getHpaDivision());

		System.out.println(opsApiOptionVO.getNameSpace());
		HorizontalPodAutoscaler horizontalPodAutoscaler = opsApiOptionService.updatePodAutoscalerV2(cloudVo, opsApiOptionVO);

		if(horizontalPodAutoscaler != null && horizontalPodAutoscaler.getStatus() != null) {
			List<HorizontalPodAutoscalerCondition> conditions = horizontalPodAutoscaler.getStatus().getConditions();

			if(conditions != null) {
				for(HorizontalPodAutoscalerCondition condition : conditions ) {
//	                System.out.println("Condition Type: " + condition.getType());
//	                System.out.println("Status: " + condition.getStatus());
//	                System.out.println("Message: " + condition.getMessage());
//	                System.out.println("Reason: " + condition.getReason());
					if(condition.getStatus().equals("True")){
						req.setUserId(userSession.getUsername());
						res = service.scaleOutUpdate(req);
						return new ResponseEntity<String>(res, HttpStatus.OK);
					}else if(condition.getStatus().equals("False")) {
						// 업데이트 실패
						res = "0";
					}
				}
			} else {
				// HPA status not found
				res = "0";
			}
		}else {
			// HPA Object is null
			res = "0";
		}

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
}
