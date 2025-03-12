package com.ivucenter.cloud.portal.oss.project;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.cmm.customer.CmmCustomerService;
import com.ivucenter.cloud.portal.oss.loadbalancer.CustomOssLbVO;
import com.ivucenter.cloud.portal.oss.loadbalancer.OssLbService;
import com.ivucenter.cloud.portal.oss.nas.CustomOssNasVO;
import com.ivucenter.cloud.portal.oss.nas.OssNasService;
import com.ivucenter.cloud.portal.oss.publicip.CustomOssIpVO;
import com.ivucenter.cloud.portal.oss.publicip.OssIpService;
import com.ivucenter.cloud.portal.req.project.ReqProjectService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/oss/project")
public class MngOssProjectController {

	@Autowired
	private ReqProjectService reqProjectService;
	@Autowired
	private OssProjectDAO dao;

	@Autowired
	private OssProjectService service;

	@Autowired
	private CmmCustomerService cmmCustomerService;

	@Autowired
	private OssNasService nasService;

	@Autowired
	private OssLbService ossLbService;

	@Autowired
	private OssIpService ossIpService;

	@Autowired
	private OssCloudService ossCloudService;

//	@Autowired	private OssBackupService ossBackupService;

//	@Autowired	private OssMcaService ossMcaService;
//	@Autowired	private OssScmService ossScmService;
//	@Autowired	private OssSecurityService ossSecurityService;
//	@Autowired	private CmmFileService cmmFileService;

	/**
	 *	PAGE
	 */
	@RequestMapping(value="/")
	public String MngOssProject() {
		log.debug("MngOssProjectController:MngOssProject()");
		return "mng/oss/project/ossProjectList";
	}

	@RequestMapping(value="/write")
	public String MngOssProjectWrite(Model model, CustomOssProjectVO req) {
		Assert.notNull(req.getProjectId(), "");

		model.addAttribute("customerlist", cmmCustomerService.listAll());
		model.addAttribute("projectId", req.getProjectId());
		return "mng/oss/project/ossProjectWrite";
	}

	@RequestMapping(value="/view")
	public String MngOssProjectView(Model model, CustomOssProjectVO req) {

		model.addAttribute("projectId", req.getProjectId());
		model.addAttribute("projectName", req.getProjectName());

		//NAS
		CustomOssNasVO nasVo = new CustomOssNasVO();
		nasVo.setProjectId(req.getProjectId());
		nasVo.setSearchKind("");
		nasVo.setKeyword("");
		List<CustomOssNasVO> getNasList = nasService.getNasList(nasVo);
		model.addAttribute("getNasList", getNasList);

		//로드밸런스
		CustomOssLbVO lbVo =  new CustomOssLbVO();
		lbVo.setProjectId(req.getProjectId());
		lbVo.setSearchKind("");
		lbVo.setKeyword("");
		List<CustomOssLbVO> getLbList = ossLbService.getLbList(lbVo);
		model.addAttribute("getLbList", getLbList);

		//ip
		CustomOssIpVO ipVo =  new CustomOssIpVO();
		ipVo.setProjectId(req.getProjectId());
		ipVo.setSearchKind("");
		ipVo.setKeyword("");
		List<CustomOssIpVO> getIpList = ossIpService.getIpList(ipVo);
		model.addAttribute("getIpList", getIpList);

		//backup
//		CustomOssBackupVO bakVo = new CustomOssBackupVO();
//		bakVo.setProjectId(req.getProjectId());
//		bakVo.setSearchKind("");
//		bakVo .setKeyword("");
//		List<CustomOssBackupVO> getBakList = ossBackupService.getBakList(bakVo);
//		model.addAttribute("getBakList", getBakList);


//		//mca(대외계)
//		CustomOssMcaVO mcaVo = new CustomOssMcaVO();
//		mcaVo.setProjectId(req.getProjectId());
//		mcaVo.setSearchKind("");
//		mcaVo.setKeyword("");
//		List<CustomOssMcaVO> getMcaList = ossMcaService.getMcaList(mcaVo);
//		model.addAttribute("getMcaList", getMcaList);
//
//		//scm(형상관리)
//		CustomOssScmVO scmVo = new CustomOssScmVO();
//		scmVo.setProjectId(req.getProjectId());
//		scmVo.setSearchKind("");
//		scmVo.setKeyword("");
//		List<CustomOssScmVO> getScmList = ossScmService.getScmList(scmVo);
//		model.addAttribute("getScmList", getScmList);
//
//		//scr(보안관제)
//		CustomOssSecurityVO scrVo = new CustomOssSecurityVO();
//		scrVo.setProjectId(req.getProjectId());
//		scrVo.setSearchKind("");
//		scrVo.setKeyword("");
//		List<CustomOssSecurityVO> getScrList = ossSecurityService.getScrList(scrVo);
//		model.addAttribute("getScrList", getScrList);

		return "mng/oss/project/ossProjectView";
	}


	/**
	 *	ACTION
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngOssProjectList(CustomOssProjectVO req){
		String res = service.list(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/mngNasAppList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngOssProjectAppList(CustomOssProjectVO req){
		String res = service.mbrNasAppList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/mngFsList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> mngFsList(CustomOssProjectVO req){
		String res = service.mbrFsList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/mngProjectInfoExcel")
	public ModelAndView mngProjectInfoExcel(CustomOssProjectVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "projectInfo");
		map.addAttribute("excel_title", "기본정보");
		map.addAttribute("excel_list", service.excel(req));

		return new ModelAndView("ossProjectExcelView", map);
	}



	@RequestMapping(value="/projectServiceList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> projectServiceList(CustomOssProjectVO req){
		String res = service.projectServiceList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/detail")
	public ResponseEntity<Object> MngOssProjectBoxDetail(CustomOssProjectVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		CustomOssProjectVO res = service.boxDetail(req);
		if(res == null) {
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}

		res.setManagerPhone(res.getManagerPhoneDec());
		res.setManagerTel(res.getManagerTelDec());

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/projectDetail")
	public ResponseEntity<Object> MngOssProjectDetail(CustomOssProjectVO req) {
		Assert.notNull(req.getProjectId(), "");
		CustomOssProjectVO res = service.detail(req);
		if(res == null) {
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}

		res.setManagerPhone(res.getManagerPhoneDec());
		res.setManagerTel(res.getManagerTelDec());

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/projectVmInfo")
	public ResponseEntity<Object> projectVmInfo(CustomOssProjectVO req) {
		CustomOssProjectVO res = service.projectVmInfo(req);
		if(res == null) {
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}

		res.setManagerPhone(res.getManagerPhoneDec());

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/projectNasInfo")
	public ResponseEntity<Object> projectNasInfo(CustomOssProjectVO req) {
		CustomOssProjectVO res = service.projectNasInfo(req);
		if(res == null) {
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}

		res.setManagerPhone(res.getManagerPhoneDec());

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/projectServiceInfo")
	public ResponseEntity<Object> projectServiceInfo(CustomOssProjectVO req) {
		CustomOssProjectVO res = service.projectServiceInfo(req);
		if(res == null) {
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}

		res.setManagerPhone(res.getManagerPhoneDec());

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/serviceExcel")
	public ModelAndView mngOssProject(CustomOssProjectVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "service");
		map.addAttribute("excel_title", "서비스_상품관리");
		map.addAttribute("excel_list", service.serviceExcel(req));

		return new ModelAndView("ossProjectExcelView", map);
	}

	@RequestMapping(value = "/insert")
	public ResponseEntity<String> MngOssProjectInsert(CustomOssProjectVO req) throws NotSupportGatewayException {
		String res = service.insertProvisioning(req);
		/*req.setProjectBoxId(UUID.randomUUID().toString());
		String projectId = req.getProjectId();
		String res = "";
		if(StringUtils.isNotEmpty(projectId)){
			res = service.update(req);
		}else{
			String sRet = dao.boxInsert(req)+"";
			List<CustomOssCloudVO> getCloudList = ossCloudService.getCloudList();
			for(CustomOssCloudVO cloud : getCloudList) {
				req.setCloudId(cloud.getCloudId());
				res = service.insert(req);
			}
	    }
		reqProjectService.reqProjectStatusUpdate04(req.getProjectBoxId());

		List<CustomReqCustomerVO> managerList = reqProjectService.reqManagerList(req.getReqProjectSeq());
		for(CustomReqCustomerVO vo : managerList) {

				vo.setProjectId(req.getProjectBoxId());
				res = service.insertManager(vo);
		}*/
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/projectNameChk")
	public ResponseEntity<Object> projectNameChk(CustomOssProjectVO req) {

		int chkVal = service.projectNameChk(req);

		return new ResponseEntity<Object>(chkVal, HttpStatus.OK);
	}
	@RequestMapping(value = "/projectNameNextChk")
	public ResponseEntity<Object> projectNameNextChk(CustomOssProjectVO req) {

		int chkVal = service.projectNameNextChk(req);

		return new ResponseEntity<Object>(chkVal, HttpStatus.OK);
	}
	@RequestMapping(value = "/vmExcel")
	public ModelAndView MngOssProjectExcel(CustomOssProjectVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "vm");
		map.addAttribute("excel_title", "프로젝트_가상서버 관리");
		map.addAttribute("excel_list", service.excel(req));

		return new ModelAndView("ossProjectExcelView", map);
	}

	@RequestMapping(value = "/networkExcel")
	public ModelAndView MngOssProjectNetworkExcel(CustomOssProjectVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "network");
		map.addAttribute("excel_title", "프로젝트_네트워크 관리");
		map.addAttribute("excel_list", service.excel(req));

		return new ModelAndView("ossProjectExcelView", map);
	}

	@RequestMapping(value = "/diskExcel")
	public ModelAndView MngOssProjectDiskExcel(CustomOssProjectVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "disk");
		map.addAttribute("excel_title", "프로젝트_블록디스크 관리");
		map.addAttribute("excel_list", service.excel(req));

		return new ModelAndView("ossProjectExcelView", map);
	}
}
