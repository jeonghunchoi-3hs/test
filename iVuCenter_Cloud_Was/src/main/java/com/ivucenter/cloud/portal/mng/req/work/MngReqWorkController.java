package com.ivucenter.cloud.portal.mng.req.work;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.api.ansible.AnsibleConstants;
import com.ivucenter.cloud.api.ansible.AnsibleObject;
import com.ivucenter.cloud.api.ansible.AnsibleUtils;
import com.ivucenter.cloud.api.common.utils.SystemCalculatorInfo;
import com.ivucenter.cloud.api.nutanix.NutanixObject;
import com.ivucenter.cloud.api.nutanix.NutanixUtils;
import com.ivucenter.cloud.api.openshift.object.OpsApiOptionService;
import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.bss.order.BssOrderService;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.oss.application.OssAppService;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqOrderVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/req/work")
public class MngReqWorkController {

	@Autowired
	private MngReqWorkService mngReqWorkService;

	@Autowired
	private BssOrderService bssOrderService;

	@Autowired
	private AlarmsTemplateService alarmsTemplateService;

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	private OpsApiOptionService opsApiOptionService;

	@Autowired
	private OssAppService ossAppService;

	SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();

	@RequestMapping(value="/")
	public String mngReqWorkList(HttpServletRequest request , Model model) {

		String myWorkYn =  request.getParameter("myWorkYn");
		model.addAttribute("myWorkYn", myWorkYn);

		return "mng/req/work/workList";
	}

	//작업 리스트
	@RequestMapping(value = "/workList")
	public String workList(){
		return "mng/req/work/workList";
	}

	//작업 리스트
	@RequestMapping(value = "/worklist", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> getWorkList(CustomMngReqWorkVO req){
		String res = mngReqWorkService.getReqWorkList(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/excel")
	public ModelAndView MngReqWorkExcel(CustomMngReqWorkVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "work");
		map.addAttribute("excel_title", "작업승인처리_작업신청관리");
		map.addAttribute("excel_list", mngReqWorkService.excel(req));
		return new ModelAndView("productExcelView", map);
	}

	//bss_order_product_service service_name update
	@RequestMapping(value = "/serviceUpdate")
	public ResponseEntity<Object> serviceUpdate(CustomMngReqWorkVO req){
		String res = "";
		res = mngReqWorkService.setReqServiceInsert(req);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


	//oss_service 테이블 vm_uuid update
	@RequestMapping(value = "/ossServiceVmUpdate")
	public ResponseEntity<Object> ossServiceVmUpdate(CustomMngReqWorkVO req){
		String res = "";

		res = mngReqWorkService.setOssServiceVmUpdate(req);

	    return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	//작업 완료 처리
	@RequestMapping(value = "/workComplete")
	public ResponseEntity<Object> workComplete(CustomMngReqWorkVO req){
		String res = "";

		try {
			res = mngReqWorkService.setWorkChkOk(req);
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		Date idDate = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");

		if(req.getProductCategory().equals("PRODCATE_SERVICE")){

			if(req.getRequestType().equals("REQTYPE_EXPR")) {
				CustomMngOssVo setOssService = new CustomMngOssVo();
				setOssService.setServiceId(req.getOldId());
				setOssService.setExpireDatetime(req.getChargeStartDatetime());
				setOssService.setModUserId(req.getModUserId());
				setOssService.setDelFlag("Y");
				res = mngReqWorkService.setOssServiceUpdate(setOssService);

			}else if(req.getRequestType().equals("REQTYPE_NEW")){
				String serviceId = dateFormat.format(idDate);
				CustomReqOrderVO orderServiceSelect = mngReqWorkService.orderServiceSelect(req);
				CustomMngOssVo serviceValue = new CustomMngOssVo();

				serviceValue.setServiceId(serviceId);
				serviceValue.setServiceType(orderServiceSelect.getServiceType());
				serviceValue.setProjectId(orderServiceSelect.getProjectId());
				serviceValue.setVmUuid(orderServiceSelect.getVmUuid());
				serviceValue.setServiceEa(orderServiceSelect.getServiceEa());
				serviceValue.setDescription(orderServiceSelect.getDescription());
				serviceValue.setCreateDatetime(req.getChargeStartDatetime());
				serviceValue.setRegUserId(req.getModUserId());
				serviceValue.setServiceProductSeq(orderServiceSelect.getServiceProductSeq());
				serviceValue.setServiceCatalogSeq(orderServiceSelect.getServiceCatalogSeq());
				serviceValue.setReqServiceProductSeq(orderServiceSelect.getOrderProductSeq());
				serviceValue.setServiceName(orderServiceSelect.getServiceName());
				serviceValue.setAppUuid(orderServiceSelect.getAppUuid());

				serviceValue.setHpaDivision(orderServiceSelect.getHpaDivision());
				serviceValue.setHpaMax(orderServiceSelect.getHpaMax());
				serviceValue.setHpaContinue(orderServiceSelect.getHpaContinue());
				serviceValue.setHpaMinPod(orderServiceSelect.getHpaMinPod());
				serviceValue.setHpaMaxPod(orderServiceSelect.getHpaMaxPod());
				serviceValue.setHpaIncrePod(orderServiceSelect.getHpaIncrePod());

				res = mngReqWorkService.setOssServiceInsert(serviceValue);

				if(orderServiceSelect.getServiceType().equals("ASCL")) {
					req.setServiceId(serviceId);
					mngReqWorkService.setOssScailOutInsert(req);
				}

				String productCategoryName = "";
				switch(serviceValue.getServiceType()) {
				case "01": productCategoryName = "계정관리 서비스"; break;
				case "02": productCategoryName = "보안관제 서비스"; break;
				case "03": productCategoryName = "백업 서비스"; break;
				case "04": productCategoryName = "SW설치 서비스"; break;
				case "05": productCategoryName = "디스크관리 서비스"; break;
				}

				Map<String,String> keywordMap = new HashMap<>();
				keywordMap.put("[[상품명]]", productCategoryName);
				keywordMap.put("[[적용일자]]", dateFormat.format(idDate));
				keywordMap.put("[[서버명]]", "");
				alarmsTemplateService.alarms(37, serviceValue.getRegUserId(), keywordMap);
//				alarmsTemplateService.alarms("37", customReqOrderVO.getOrderUserId(), productCategoryName, req.getChargeStartDatetime());

				//서비스는 VM 입력이 없음 우선 주석으로 처리함
//				List<CustomReqOrderVO> orderBackupVmSelect = mngReqWorkService.orderBackupVmSelect(req);
//				for (int i = 0; i < orderBackupVmSelect.size(); i++) {
//
//					CustomMngOssVo BackupVmValue = new CustomMngOssVo();
//
//					BackupVmValue.setBackupId(backupId);
//					BackupVmValue.setVmUuid(orderBackupVmSelect.get(i).getVmUuid());
//
//					res = mngReqWorkService.setOssBackupVmInsert(BackupVmValue);
//				}
			}
		}else if(req.getProductCategory().equals("ITEMCATE_LOADBALANCER")){
			if(req.getRequestType().equals("REQTYPE_EXPR")){
				List<CustomReqOrderVO> orderLbVmSelect = mngReqWorkService.orderLbVmSelect(req);
				for (int i = 0; i < orderLbVmSelect.size(); i++) {
					CustomMngOssVo LbVmValue = new CustomMngOssVo();
					LbVmValue.setLoadbalancerId(req.getOldId());
					LbVmValue.setDelFlag("Y");
					LbVmValue.setVmUuid(orderLbVmSelect.get(i).getVmUuid());
					res = mngReqWorkService.setOssLbUpdate(LbVmValue);
				}
			}else if(req.getRequestType().equals("REQTYPE_NEW")){

				String loadbalancerId = dateFormat.format(idDate);
				CustomReqOrderVO orderLbSelect = mngReqWorkService.orderLbSelect(req);
				CustomMngOssVo LbValue = new CustomMngOssVo();
				LbValue.setLoadbalancerId(loadbalancerId);
				LbValue.setProjectId(orderLbSelect.getProjectId());
				LbValue.setNetworkId(orderLbSelect.getDefaultNetworkId());
				LbValue.setLoadbalancerName(orderLbSelect.getLoadbalancerName());
				LbValue.setDescription(orderLbSelect.getDescription());
				LbValue.setHourlyFlag(orderLbSelect.getHourlyFlag());
				LbValue.setProtocol(orderLbSelect.getProtocol());
				LbValue.setMethod(orderLbSelect.getMethod());
				LbValue.setMonitorType(orderLbSelect.getMonitorType());
				LbValue.setLoadbalancerEa(orderLbSelect.getLoadbalancerEa());
				LbValue.setCreateDatetime(req.getChargeStartDatetime());
				LbValue.setRegUserId(req.getModUserId());
				LbValue.setLoadbalancerProductSeq(orderLbSelect.getLoadbalancerProductSeq());
				LbValue.setLoadbalancerCatalogSeq(orderLbSelect.getLoadbalancerCatalogSeq());
				LbValue.setIp(orderLbSelect.getIp());
				LbValue.setPort(orderLbSelect.getPort());
				//log.debug("orderProductSeq : "+req.getOrderProductSeq());
				res = mngReqWorkService.setOssLbInsert(LbValue);
				//vm 입력
				List<CustomReqOrderVO> orderLbVmSelect = mngReqWorkService.orderLbVmSelect(req);
				for (int i = 0; i < orderLbVmSelect.size(); i++) {
					//log.debug("orderLbVmSelect.size() : "+orderLbVmSelect.size());

					CustomMngOssVo LbVmValue = new CustomMngOssVo();
					LbVmValue.setLoadbalancerId(loadbalancerId);
					LbVmValue.setVmUuid(orderLbVmSelect.get(i).getVmUuid());
					res = mngReqWorkService.setOssLbVmInsert(LbVmValue);
				}
			}else if(req.getRequestType().equals("REQTYPE_CHANGE")){
				List<CustomReqOrderVO> orderLbVmSelect = mngReqWorkService.orderLbVmSelect(req);
				for (int i = 0; i < orderLbVmSelect.size(); i++) {
					CustomMngOssVo LbVmValue = new CustomMngOssVo();
					LbVmValue.setLoadbalancerId(req.getOldId());
					LbVmValue.setVmUuid(orderLbVmSelect.get(i).getVmUuid());
					res = mngReqWorkService.setOssLbVmInsert(LbVmValue);
				}
			}
		}else if(req.getProductCategory().equals("ITEMCATE_SNAPSHOT")){
			if(req.getRequestType().equals("REQTYPE_NEW")){
				String snapshotId = dateFormat.format(idDate);
				CustomReqOrderVO orderSnSelect = mngReqWorkService.orderSnSelect(req);
				CustomMngOssVo SnValue = new CustomMngOssVo();
				SnValue.setSnapshotId(snapshotId);
				SnValue.setProjectId(orderSnSelect.getProjectId());
				SnValue.setSnapshotName(orderSnSelect.getSnapshotName());
				SnValue.setDescription(orderSnSelect.getDescription());
				SnValue.setHourlyFlag(orderSnSelect.getHourlyFlag());
				SnValue.setCreateDatetime(req.getChargeStartDatetime());
				SnValue.setRegUserId(req.getModUserId());
				SnValue.setVmUuid(orderSnSelect.getVmUuid());
				SnValue.setDiskId(orderSnSelect.getDiskId());
				SnValue.setSnapshotProductSeq(orderSnSelect.getSnapshotProductSeq());
				SnValue.setSnapshotCatalogSeq(orderSnSelect.getSnapshotCatalogSeq());
				res = mngReqWorkService.setOssSnInsert(SnValue);
			} else if(req.getRequestType().equals("REQTYPE_EXPR")) {
				res = mngReqWorkService.setOssSnUpdate(req);
			}

		}
//		else if(req.getProductCategory().equals("PRODCATE_MCA")){
//			if(req.getRequestType().equals("REQTYPE_EXPR")){
//				CustomMngOssVo setOssmca = new CustomMngOssVo();
//				setOssmca.setMcaId(req.getOldId());
//				setOssmca.setExpireDatetime(req.getChargeStartDatetime());
//				setOssmca.setModUserId(req.getModUserId());
//				setOssmca.setDelFlag("Y");
//				res = mngReqWorkService.setOssMcaUpdate(setOssmca);
//
//			}else if(req.getRequestType().equals("REQTYPE_NEW")){
//				String mcaId = dateFormat.format(idDate);
//				CustomReqOrderVO orderMcaSelect = mngReqWorkService.orderMcaSelect(req);
//				CustomMngOssVo McaValue = new CustomMngOssVo();
//				McaValue.setMcaId(mcaId);
//				McaValue.setProjectId(orderMcaSelect.getProjectId());
//				McaValue.setMcaEa(orderMcaSelect.getMcaEa());
//				McaValue.setDescription(orderMcaSelect.getDescription());
//				McaValue.setCreateDatetime(req.getChargeStartDatetime());
//				McaValue.setRegUserId(req.getModUserId());
//				McaValue.setMcaCatalogSeq(orderMcaSelect.getMcaCatalogSeq());
//				McaValue.setMcaProductSeq(orderMcaSelect.getMcaProductSeq());
//
//				res = mngReqWorkService.setOssMcaInsert(McaValue);
//			}
//		}
		else if(req.getProductCategory().equals("PRODCATE_NAS")){
			if(req.getRequestType().equals("REQTYPE_EXPR")){
				CustomMngOssVo setOssnas = new CustomMngOssVo();
				setOssnas.setNasId(req.getOldId());
				setOssnas.setNasGb(req.getNasGb());
				setOssnas.setExpireDatetime(req.getChargeStartDatetime());
				setOssnas.setModUserId(req.getModUserId());
				setOssnas.setDelFlag("Y");
				res = mngReqWorkService.setOssNasUpdate(setOssnas);

				setOssnas.setRequestType(req.getRequestType());
				setOssnas.setApplyDate(req.getChargeStartDatetime());
				setOssnas.setRegUserId(req.getModUserId());

				res = mngReqWorkService.setOssNasHistoryInsert(setOssnas);

			}else if(req.getRequestType().equals("REQTYPE_CHANGE")){
				CustomMngOssVo setOssnas = new CustomMngOssVo();
				setOssnas.setNasId(req.getOldId());
				setOssnas.setNasGb(req.getNasGb());
				setOssnas.setExpireDatetime(req.getChargeStartDatetime());
				setOssnas.setModUserId(req.getModUserId());

				res = mngReqWorkService.setOssNasChgUpdate(setOssnas);

				setOssnas.setRequestType(req.getRequestType());
				setOssnas.setApplyDate(req.getChargeStartDatetime());
				setOssnas.setRegUserId(req.getModUserId());

				res = mngReqWorkService.setOssNasHistoryInsert(setOssnas);

			}else if(req.getRequestType().equals("REQTYPE_NEW")){
				String nasId = dateFormat.format(idDate);

				CustomReqOrderVO orderNasSelect = mngReqWorkService.orderNasSelect(req);
				CustomMngOssVo nasValue = new CustomMngOssVo();

				nasValue.setNasId(nasId);
				nasValue.setProjectId(orderNasSelect.getProjectId());
				nasValue.setNasName(orderNasSelect.getNasName());
				nasValue.setNasGb(orderNasSelect.getNasGb());
				nasValue.setDescription(orderNasSelect.getDescription());
				nasValue.setCreateDatetime(req.getChargeStartDatetime());
				nasValue.setRegUserId(req.getModUserId());
				nasValue.setHourlyFlag(orderNasSelect.getHourlyFlag());
				nasValue.setVmUuid(orderNasSelect.getVmUuid());
				nasValue.setNasCatalogSeq(orderNasSelect.getNasCatalogSeq());
				nasValue.setNasProductSeq(orderNasSelect.getNasProductSeq());
				nasValue.setVmName(orderNasSelect.getVmName());

				res = mngReqWorkService.setOssNasInsert(nasValue);

				CustomMngOssVo setOssnas = new CustomMngOssVo();
				setOssnas.setNasId(nasId);
				setOssnas.setNasGb(orderNasSelect.getNasGb());
				setOssnas.setModUserId(req.getModUserId());
				setOssnas.setRequestType(req.getRequestType());
				setOssnas.setApplyDate(req.getChargeStartDatetime());
				setOssnas.setRegUserId(req.getModUserId());

				res = mngReqWorkService.setOssNasHistoryInsert(setOssnas);
			}
		}else if(req.getProductCategory().equals("PRODCATE_PUBLICIP")){
			if(req.getRequestType().equals("REQTYPE_EXPR")){
				CustomMngOssVo setOssip = new CustomMngOssVo();
				setOssip.setPublicipId(req.getOldId());
				setOssip.setExpireDatetime(req.getChargeStartDatetime());
				setOssip.setModUserId(req.getModUserId());
				setOssip.setDelFlag("Y");
				res = mngReqWorkService.setOssIpUpdate(setOssip);

			}else if(req.getRequestType().equals("REQTYPE_NEW")){
				String publicipId = dateFormat.format(idDate);

				CustomReqOrderVO orderIpSelect = mngReqWorkService.orderIpSelect(req);

				CustomMngOssVo ipValue = new CustomMngOssVo();
				ipValue.setPublicipId(publicipId);
				ipValue.setProjectId(orderIpSelect.getProjectId());
				ipValue.setVmUuid(orderIpSelect.getVmUuid());
				ipValue.setHourlyFlag(orderIpSelect.getHourlyFlag());
				ipValue.setDescription(orderIpSelect.getDescription());
				ipValue.setPublicipEa(orderIpSelect.getPublicipEa());
				ipValue.setCreateDatetime(req.getChargeStartDatetime());
				ipValue.setRegUserId(req.getModUserId());
				ipValue.setPublicipCatalogSeq(orderIpSelect.getPublicipCatalogSeq());
				ipValue.setPublicipProductSeq(orderIpSelect.getPublicipProductSeq());

				res = mngReqWorkService.setOssIpInsert(ipValue);
			}
		}
//		else if(req.getProductCategory().equals("PRODCATE_SCM")){
//			if(req.getRequestType().equals("REQTYPE_EXPR")){
//				CustomMngOssVo setOssscm = new CustomMngOssVo();
//				setOssscm.setScmId(req.getOldId());
//				setOssscm.setExpireDatetime(req.getChargeStartDatetime());
//				setOssscm.setModUserId(req.getModUserId());
//				setOssscm.setDelFlag("Y");
//				res = mngReqWorkService.setOssScmUpdate(setOssscm);
//
//			}else if(req.getRequestType().equals("REQTYPE_NEW")){
//				String scmId = dateFormat.format(idDate);
//
//				CustomReqOrderVO orderScmSelect = mngReqWorkService.orderScmSelect(req);
//
//				CustomMngOssVo scmValue = new CustomMngOssVo();
//				scmValue.setScmId(scmId);
//				scmValue.setProjectId(orderScmSelect.getProjectId());
//				scmValue.setScmEa(orderScmSelect.getScmEa());
//				scmValue.setDescription(orderScmSelect.getDescription());
//				scmValue.setCreateDatetime(req.getChargeStartDatetime());
//				scmValue.setRegUserId(req.getModUserId());
//				scmValue.setScmCatalogSeq(orderScmSelect.getScmCatalogSeq());
//				scmValue.setScmProductSeq(orderScmSelect.getScmProductSeq());
//
//				res = mngReqWorkService.setOssScmInsert(scmValue);
//			}
//		}
//		else if(req.getProductCategory().equals("PRODCATE_SECURITY")){
//			if(req.getRequestType().equals("REQTYPE_EXPR")){
//				CustomMngOssVo setOssscr = new CustomMngOssVo();
//				setOssscr.setSecurityId(req.getOldId());
//				setOssscr.setExpireDatetime(req.getChargeStartDatetime());
//				setOssscr.setModUserId(req.getModUserId());
//				setOssscr.setDelFlag("Y");
//				res = mngReqWorkService.setOssScrUpdate(setOssscr);
//
//			}else if(req.getRequestType().equals("REQTYPE_NEW")){
//				String securityId = dateFormat.format(idDate);
//
//				CustomReqOrderVO orderScrSelect = mngReqWorkService.orderScrSelect(req);
//
//				CustomMngOssVo scrValue = new CustomMngOssVo();
//				scrValue.setSecurityId(securityId);
//				scrValue.setProjectId(orderScrSelect.getProjectId());
//				scrValue.setDescription(orderScrSelect.getDescription());
//				scrValue.setCreateDatetime(req.getChargeStartDatetime());
//				scrValue.setRegUserId(req.getModUserId());
//				scrValue.setSecurityEa(orderScrSelect.getSecurityEa());
//				scrValue.setSecurityCatalogSeq(orderScrSelect.getSecurityCatalogSeq());
//				scrValue.setSecurityProductSeq(orderScrSelect.getSecurityProductSeq());
//
//				res = mngReqWorkService.setOssScrInsert(scrValue);
//			}
//		}

//		CustomReqOrderVO customReqOrderVO = bssOrderService.selectByOrderProductSeq(req.getOrderProductSeq());
//		String productCategoryName = "";
//		if(req.getProductCategory().equals("PRODCATE_NAS")){
//			productCategoryName = "NAS";
//		}else if(req.getProductCategory().equals("PRODCATE_PUBLICIP")){
//			productCategoryName = "공인IP";
//		}else if(req.getProductCategory().equals("PRODCATE_LOADBALANCER")){
//			productCategoryName = "서비스 로드분산";
//		}
//		else if(req.getProductCategory().equals("PRODCATE_BACKUP")){
//			productCategoryName = "백업 서비스";
//		}else if(req.getProductCategory().equals("PRODCATE_MCA")){
//			productCategoryName = "대외계 서비스";
//		}else if(req.getProductCategory().equals("PRODCATE_SCM")){
//			productCategoryName = "형상관리 서비스";
//		}else if(req.getProductCategory().equals("PRODCATE_SECURITY")){
//			productCategoryName = "보안관제 서비스";
//		}

		res = mngReqWorkService.setWorkComplete(req);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	//작업 확인 처리
	@RequestMapping(value = "/workChkOk")
	public ResponseEntity<Object> workChkOk(CustomMngReqWorkVO req){
		String res = "";
		res = mngReqWorkService.setWorkChkOk(req);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	//작업 내용
	@RequestMapping(value = "/workView")
	public String workView(HttpServletRequest request, Model model,ModelMap modelMap,CustomMngReqWorkVO req) throws Exception{


		SimpleDateFormat sdf = new SimpleDateFormat("HH");
		String time = sdf.format(new Date(System.currentTimeMillis() + (1000*60*60)));

		/* 세션과 작업자가 같으면 업데이트 */
		String userId = request.getUserPrincipal().getName();
		if(userId.equals(req.getWorkUserId())) { mngReqWorkService.setWorkReadUpdate(req); }

		CustomMngReqWorkVO getReqWorkView = mngReqWorkService.getReqWorkView(req);

		getReqWorkView.setProjectManagerTel(getReqWorkView.getProjectManagerTelDec());

		getReqWorkView.setTime(time);
		model.addAttribute("getReqWorkView", getReqWorkView);


		return "mng/req/work/workView";
	}

	//작업 내용
		@RequestMapping(value = "/loadWorkView")
		public String loadWorkView(HttpServletRequest request, Model model,ModelMap modelMap,CustomMngReqWorkVO req){

			SimpleDateFormat sdf = new SimpleDateFormat("HH");
			String time = sdf.format(new Date(System.currentTimeMillis() + (1000*60*60)));

			/* 세션과 작업자가 같으면 업데이트 */
			String userId = request.getUserPrincipal().getName();
			if(userId.equals(req.getWorkUserId())) { mngReqWorkService.setWorkReadUpdate(req); }

			CustomMngReqWorkVO getReqWorkView = mngReqWorkService.getReqLoadWorkView(req);

			getReqWorkView.setProjectManagerTel(getReqWorkView.getProjectManagerTelDec());

			getReqWorkView.setTime(time);

			List<CustomReqOrderVO> getVmList = mngReqWorkService.getVmList(getReqWorkView);

			model.addAttribute("getReqWorkView", getReqWorkView);
			model.addAttribute("getVmList", getVmList);
			return "mng/req/work/loadWorkView";
		}

		@RequestMapping(value = "/SnapWorkView")
		public String SnapWorkView(HttpServletRequest request, Model model,ModelMap modelMap,CustomMngReqWorkVO req){

			SimpleDateFormat sdf = new SimpleDateFormat("HH");
			String time = sdf.format(new Date(System.currentTimeMillis() + (1000*60*60)));

			/* 세션과 작업자가 같으면 업데이트 */
			String userId = request.getUserPrincipal().getName();
			if(userId.equals(req.getWorkUserId())) { mngReqWorkService.setWorkReadUpdate(req); }

			CustomMngReqWorkVO getReqWorkView = mngReqWorkService.getReqSnapWorkView(req);

			getReqWorkView.setProjectManagerTel(getReqWorkView.getProjectManagerTelDec());

			getReqWorkView.setTime(time);


			model.addAttribute("getReqWorkView", getReqWorkView);
			return "mng/req/work/snapWorkView";
		}


		@RequestMapping(value = "/ansibleProjectList", method = RequestMethod.GET)
		public ResponseEntity<Object> ansibleProjectList(CustomMngReqWorkVO req) throws Exception {

			List<CustomMngReqWorkVO> ansibleProjectList = new ArrayList();

			AnsibleObject ansibleProjects = AnsibleUtils.getProjects(systemCalculatorInfo);
			for (AnsibleObject aobj : ansibleProjects.getProjects()) {
				CustomMngReqWorkVO ansibleProject = new CustomMngReqWorkVO();

				ansibleProject.setAnProjectId(Integer.toString((int) aobj.getValue("id")));
				ansibleProject.setAnProjectName((String) aobj.getValue("name"));

				ansibleProjectList.add(ansibleProject);
			}
			return new ResponseEntity<Object>(ansibleProjectList, HttpStatus.OK);
		}



		@RequestMapping(value = "/ansibleTemplateList", method = RequestMethod.GET)
		public ResponseEntity<Object> ansibleTemplatetList(CustomMngReqWorkVO req) throws Exception {

			List<CustomMngReqWorkVO> ansibleTemplateList = new ArrayList();

			AnsibleObject ansibleTemplates = AnsibleUtils.getJobTemplates(systemCalculatorInfo);
 		    for (AnsibleObject aobj : ansibleTemplates.getJobTemplates()) {
				CustomMngReqWorkVO ansibleTemplate = new CustomMngReqWorkVO();

				log.debug("id : "+aobj.getValue("id"));
				log.debug("type : "+aobj.getValue("type"));
				log.debug("name : "+aobj.getValue("name"));
				log.debug("job_type : "+aobj.getValue("job_type"));
				log.debug("inventory : "+aobj.getValue("inventory"));
				log.debug("project : "+aobj.getValue("project"));
				log.debug("playbook : "+aobj.getValue("playbook"));

				ansibleTemplate.setAnTemplateId(Integer.toString((int)aobj.getValue("id")));
				ansibleTemplate.setAnTemplateName((String) aobj.getValue("name"));

				ansibleTemplateList.add(ansibleTemplate);
			}
			return new ResponseEntity<Object>(ansibleTemplateList, HttpStatus.OK);
		}


		@RequestMapping(value = "/ansibleInventoryList", method = RequestMethod.GET)
		public ResponseEntity<Object> ansibleInventoryList(CustomMngReqWorkVO req) throws Exception {

			List<CustomMngReqWorkVO> ansibleInventoryList = new ArrayList();
			AnsibleObject ansibleInventorys = AnsibleUtils.getInventorys(systemCalculatorInfo);
			for (AnsibleObject aobj : ansibleInventorys.getInventorys()) {
				CustomMngReqWorkVO ansibleInventory = new CustomMngReqWorkVO();

				log.debug("id : "+aobj.getValue("id"));
				log.debug("type : "+aobj.getValue("type"));
				log.debug("name : "+aobj.getValue("name"));
				log.debug("job_type : "+aobj.getValue("job_type"));
				log.debug("inventory : "+aobj.getValue("inventory"));
				log.debug("project : "+aobj.getValue("project"));
				log.debug("playbook : "+aobj.getValue("playbook"));

				ansibleInventory.setAnInventoryId(Integer.toString((int)aobj.getValue("id")));
				ansibleInventory.setAnInventoryName((String) aobj.getValue("name"));
				ansibleInventoryList.add(ansibleInventory);
			}
			return new ResponseEntity<Object>(ansibleInventoryList, HttpStatus.OK);
		}


		@RequestMapping(value = "/launchTemplate")
		public ResponseEntity<Object> launchTemplate(CustomMngReqWorkVO req) {
			String res = "";

				CustomOssCloudVO cloudVoInfo = ossCloudService.getCloudInfo(req.getCloudId());
				try {

					if(req.getCloudType().equals("nutanix")){
						NutanixObject vmdetail = NutanixUtils.getVmDetail(cloudVoInfo, req.getVmUuid());
						req.setFixedIps((String) vmdetail.getArray("vm_nics", null).get(0).getValue("ip_address"));
						AnsibleObject ansibleAddHost = AnsibleUtils.addHost(systemCalculatorInfo, req.getFixedIps(), Integer.parseInt(req.getAnInventoryId()));
						AnsibleObject ansibleLaunchTemplate = AnsibleUtils.launchTemplates(systemCalculatorInfo, req.getAnTemplateId());

					}else {
						CustomOssCloudVO anCloudVo = new CustomOssCloudVO();
						anCloudVo.setApiGatewayServer(AnsibleConstants.ANSIBLE_HOST);
						anCloudVo.setAdminUsername(AnsibleConstants.ANSIBLE_USERNAME);
						anCloudVo.setAdminPassword(AnsibleConstants.ANSIBLE_PASSWORD);
					    AnsibleObject ansibleAddHost = AnsibleUtils.addHost(systemCalculatorInfo, req.getFixedIps(), Integer.parseInt(req.getAnInventoryId()));

					    String hostId = ansibleAddHost.getValue("id").toString();

						AnsibleObject ansibleLaunchTemplate = AnsibleUtils.launchTemplates(systemCalculatorInfo, req.getAnTemplateId());

						Thread.sleep(100000);

						AnsibleObject ansibleAddHost1 = AnsibleUtils.deleteHost(systemCalculatorInfo, hostId);


					}
					res = "1";
				} catch (Exception e) {
					res = "0";
				    return new ResponseEntity<Object>(res, HttpStatus.OK);
				}
		    return new ResponseEntity<Object>(res, HttpStatus.OK);
		}

//		@RequestMapping(value = "/openshiftPodAutoscalerCreate")
//		public ResponseEntity<Object> openshiftPodAutoscalerCreate(CustomMngReqWorkVO req) {
//
//			UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//
//			String res = "";
//				CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
//	             try {
//	            	 HorizontalPodAutoscaler HorizontalPodAutoscaler = opsApiOptionService.createHorizontalPodAutoscaler(cloudVo, req.getProjectName().toLowerCase(), req.getAutoscalerName(), req.getAppName() , req.getMinReplicas(), req.getMaxReplicas());
//
//	            	 CustomOssAppVO customOssAppVO = new CustomOssAppVO();
//		            	 customOssAppVO.setAutoscalerUuid(HorizontalPodAutoscaler.getMetadata().getUid());
//		            	 customOssAppVO.setAutoscalerName(req.getAutoscalerName());
//		            	 customOssAppVO.setCloudId(req.getCloudId());
//		            	 customOssAppVO.setProjectId(req.getProjectId());
//		            	 customOssAppVO.setAppUid(req.getAppUid());
//		            	 customOssAppVO.setRegUserId(userSession.getUsername());
//	            	 res = ossAppService.insertAutoscaler(customOssAppVO);
//
//	             } catch (Exception e) {
//				    return new ResponseEntity<Object>(res, HttpStatus.OK);
//				}
//		    return new ResponseEntity<Object>(res, HttpStatus.OK);
//		}

}
