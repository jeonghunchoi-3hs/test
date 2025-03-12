package com.ivucenter.cloud.portal.oss.scaleOut;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.formula.functions.Now;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.api.openshift.object.OpsApiOptionService;
import com.ivucenter.cloud.api.openshift.object.OpsApiOptionVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.mng.req.work.CustomMngOssVo;
import com.ivucenter.cloud.portal.mng.req.work.MngReqWorkService;

import io.fabric8.kubernetes.api.model.autoscaling.v2.HorizontalPodAutoscaler;


@Controller
@RequestMapping(value="/mng/oss/scaleOut")
public class MngScaleOutController {

	private final Log LOG = LogFactory.getLog(MngScaleOutController.class);

	@Autowired
	private ScaleOutService service;

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	private OpsApiOptionService opsApiOptionService;

	@Autowired
	private MngReqWorkService mngReqWorkService;

	@RequestMapping(value="/")
	public String MngBbsFaqList() {
		return "mng/oss/scaleOut/scaleOutList";
	}

	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> ScaleOutList(CustomScaleOutVO req){

		String res = service.list(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/excel")
	public ModelAndView MngOssScaleOutExcel(CustomScaleOutVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "scaleOut");
		map.addAttribute("excel_title", "정책관리_Scale_out관리");
		map.addAttribute("excel_list", service.excel(req));

		return new ModelAndView("operationExcelView", map);
	}

	@RequestMapping(value="/view")
	public String ScaleOutView(Model model, CustomScaleOutVO req) {
		try{
			CustomScaleOutVO res = service.detail(req);
			if(res != null) {
				res.setManagerTel(res.getManagerTelDec());
			}
			model.addAttribute("scaleOutdetail", res);

			return "mng/oss/scaleOut/scaleOutView";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}


	@RequestMapping(value="/write")
	public String ScaleOutWrite(Model model, CustomScaleOutVO req) {
	try{
			CustomScaleOutVO res = service.detail(req);
			if(res != null) {
				res.setManagerTel(res.getManagerTelDec());
			}
			model.addAttribute("scaleOutdetail", res);

			return "mng/oss/scaleOut/scaleOutWrite";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}


	@RequestMapping(value = "/update")
	public ResponseEntity<String> MngBssScaleOutUpdate(CustomScaleOutVO req, Model model){

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
		opsApiOptionVO.setHpaIncrePod(Integer.parseInt(req.getHpaIncrePod()));
		opsApiOptionVO.setHpaDivision(req.getHpaDivision());

		HorizontalPodAutoscaler HorizontalPodAutoscaler = opsApiOptionService.updatePodAutoscalerV2(cloudVo, opsApiOptionVO);

		req.setUserId(userSession.getUsername());
		res = service.update(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	@RequestMapping(value = "/delete")
	public ResponseEntity<String> MngBssDcaleOutDelete(CustomScaleOutVO req, Model model) {
		String res = "";

		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
		OpsApiOptionVO opsApiOptionVO = new OpsApiOptionVO();

		opsApiOptionVO.setNameSpace(req.getNameSpace());
		opsApiOptionVO.setAppName(req.getAppName());
		opsApiOptionVO.setScaleOutName(req.getScaleOutName());

		Boolean response = opsApiOptionService.deletePodAutoscalerV2(cloudVo, opsApiOptionVO);

		if(response != true) {
			res = "0";
			return new ResponseEntity<String>(res, HttpStatus.OK);
		}
//		opsApiOptionService.deletePodAutoscalerV2(cloudVo, opsApiOptionVO);

		CustomMngOssVo setOssService = new CustomMngOssVo();

		// 현재 날짜 및 시간 가져오기
        Date currentDate = new Date();

        // 원하는 형식으로 날짜 및 시간 포맷팅
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss.SSS");
        String formattedDateTime = dateFormat.format(currentDate);

		setOssService.setExpireDatetime(formattedDateTime);

		setOssService.setServiceId(req.getServiceId());
		setOssService.setModUserId(userSession.getUsername());
		setOssService.setDelFlag("Y");
		mngReqWorkService.setOssServiceUpdate(setOssService);

		req.setModUserId(userSession.getUsername());
		res = service.delete(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}



}
