package com.ivucenter.cloud.portal.mng.req.work;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.openshift.object.OpsApiOptionService;
import com.ivucenter.cloud.api.openshift.object.OpsApiOptionVO;
import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.oss.application.CustomOssAppVO;
import com.ivucenter.cloud.portal.oss.application.OssAppService;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqOrderVO;
import com.ivucenter.cloud.portal.util.CodeUtil;

import io.fabric8.kubernetes.api.model.autoscaling.v2.HorizontalPodAutoscaler;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("mngReqWorkService")
public class MngReqWorkServiceImpl implements MngReqWorkService{

	@Resource(name="mngReqWorkDAO")
	private MngReqWorkDAO mngReqWorkDAO;

	@Autowired
	private CmmUserService cmmUserService;

	@Autowired
	private AlarmsTemplateService alarmsTemplateService;

	@Autowired
	private OssAppService ossAppService;

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	private OpsApiOptionService opsApiOptionService;


	@Override
	public List<CustomReqOrderVO> excel(CustomMngReqWorkVO req) {
		return mngReqWorkDAO.getReqWorkListTot(req);
	}

	/* req_work */
	@Override
	public String getReqWorkList(CustomMngReqWorkVO req) {
		List<CustomMngReqWorkVO> getReqWorkList = mngReqWorkDAO.getReqWorkList(req);
		int recordsTotal = mngReqWorkDAO.getReqWorkListTot(req).size();
		int recordsFiltered = recordsTotal;

		try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(getReqWorkList));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	        log.error(e.getMessage());
	    }
		return "";
	}
	@Override
	public CustomMngReqWorkVO getReqWorkView(CustomMngReqWorkVO req) {
		return mngReqWorkDAO.getReqWorkView(req);
	}

	@Override
	public CustomMngReqWorkVO getReqLoadWorkView(CustomMngReqWorkVO req) {
		return mngReqWorkDAO.getReqLoadWorkView(req);
	}

	@Override
	public CustomMngReqWorkVO getReqSnapWorkView(CustomMngReqWorkVO req) {
		return mngReqWorkDAO.getReqSnapWorkView(req);
	}

	@Override
	public List<CustomReqOrderVO> getVmList(CustomMngReqWorkVO req) {
		return mngReqWorkDAO.getVmList(req);
	}

	@Override
	public CustomMngReqWorkVO getReqWorkchk(String orderProductSeq) {
		return mngReqWorkDAO.getReqWorkchk(orderProductSeq);
	}
	@Override
	public String setWorkComplete(CustomMngReqWorkVO req) {
		return mngReqWorkDAO.setWorkComplete(req)+"";
	}
	@Override
	public String setWorkChkOk(CustomMngReqWorkVO req) {
		try {
			mngReqWorkDAO.setWorkChkOk(req);

			String productCategoryName = "";

			if(req.getProductCategory().equals("PRODCATE_LOADBALANCER")){
				productCategoryName = "서비스 로드분산";
			}else if(req.getProductCategory().equals("PRODCATE_NAS")){
				productCategoryName = "NAS";
			}else if(req.getProductCategory().equals("PRODCATE_PUBLICIP")){
				productCategoryName = "공인IP";
			} else if(req.getProductCategory().equals("PRODCATE_SERVICE")){
			    productCategoryName = "서비스";
		    } else if(req.getProductCategory().equals("ITEMCATE_LOADBALANCER")) {
		    	productCategoryName = "로드밸런스";
		    }
//			else if(req.getProductCategory().equals("PRODCATE_SCM")){
//				productCategoryName = "형상관리 서비스";
//			}else if(req.getProductCategory().equals("PRODCATE_SECURITY")){
//				productCategoryName = "보안관제 서비스";
//			}else if(req.getProductCategory().equals("PRODCATE_BACKUP")){
//				productCategoryName = "백업 서비스";
//			}else if(req.getProductCategory().equals("PRODCATE_MCA")){
//				productCategoryName = "대외계 서비스";
//			}

			// 작업자 권한을 가진 사용자들 모두에게 알람가도록 되어있음 협의후 변경예정

			Map<String,String> keywordMap = new HashMap<>();
			keywordMap.put("[[상품명]]", productCategoryName);
			keywordMap.put("[[적용일자]]", req.getChargeStartDatetime());

			List<CustomCmmUserVO> worklist = cmmUserService.worklist();
			for(CustomCmmUserVO userInfo : worklist){
				alarmsTemplateService.alarms(36, userInfo.getUserId(), keywordMap);
//				alarmsTemplateService.alarms("36", userInfo.getUserId(), productCategoryName, "");
			}
			return "1";
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		return "0";
	}
	@Override
	public String setWorkReadUpdate(CustomMngReqWorkVO setOssnas) {
		return mngReqWorkDAO.setWorkReadUpdate(setOssnas)+"";
	}

	/* order */
	@Override
	public List<CustomMngReqWorkVO> workUserId(String requestSeq) {
		return mngReqWorkDAO.workUserId(requestSeq);
	}
	@Override
	public List<CustomMngReqWorkVO> getOrderWorkList(CustomMngReqWorkVO req){
		return mngReqWorkDAO.getOrderWorkList(req);
	}

	/* NAS */
	@Override
	public CustomReqOrderVO orderNasSelect(CustomMngReqWorkVO req) {
		return mngReqWorkDAO.orderNasSelect(req);
	}
	@Override
	public String setOssNasInsert(CustomMngOssVo nasValue) {
		return mngReqWorkDAO.setOssNasInsert(nasValue)+"";
	}
	@Override
	public String setOssNasUpdate(CustomMngOssVo setOssnas) {
		return mngReqWorkDAO.setOssNasUpdate(setOssnas)+"";
	}
	@Override
	public String setOssNasChgUpdate(CustomMngOssVo setOssnas) {
		return mngReqWorkDAO.setOssNasChgUpdate(setOssnas)+"";
	}
	@Override
	public String setOssNasHistoryInsert(CustomMngOssVo setOssnas) {
		return mngReqWorkDAO.setOssNasHistoryInsert(setOssnas)+"";
	}


	/* LoadBalancer */
	@Override
	public CustomReqOrderVO orderLbSelect(CustomMngReqWorkVO req) {
		return mngReqWorkDAO.orderLbSelect(req);
	}
	@Override
	public CustomReqOrderVO orderSnSelect(CustomMngReqWorkVO req) {
		return mngReqWorkDAO.orderSnSelect(req);
	}
	@Override
	public String setOssLbInsert(CustomMngOssVo lbValue) {
		return mngReqWorkDAO.setOssLbInsert(lbValue)+"";
	}
	@Override
	public String setOssSnInsert(CustomMngOssVo lbValue) {
		return mngReqWorkDAO.setOssSnInsert(lbValue)+"";
	}
	@Override
	public String setOssLbUpdate(CustomMngOssVo setOsslb) {
		return mngReqWorkDAO.setOssLbUpdate(setOsslb)+"";
	}
	@Override
	public String setOssSnUpdate(CustomMngReqWorkVO setOssSn) {
		return mngReqWorkDAO.setOssSnUpdate(setOssSn)+"";
	}
	@Override
	public List<CustomReqOrderVO> orderLbVmSelect(CustomMngReqWorkVO req) {
		log.debug("=== orderLbVmSelect Service ===");
		return mngReqWorkDAO.orderLbVmSelect(req);
	}
	@Override
	public String setOssLbVmInsert(CustomMngOssVo lbVmValue) {
		log.debug("=== setOssLbVmInsert Service ===");
		return mngReqWorkDAO.setOssLbVmInsert(lbVmValue)+"";
	}

	/* public ip */
	@Override
	public CustomReqOrderVO orderIpSelect(CustomMngReqWorkVO req) {
		return mngReqWorkDAO.orderIpSelect(req);
	}
	@Override
	public String setOssIpInsert(CustomMngOssVo ipValue) {
		return mngReqWorkDAO.setOssIpInsert(ipValue)+"";
	}
	@Override
	public String setOssIpUpdate(CustomMngOssVo setOssip) {
		return mngReqWorkDAO.setOssIpUpdate(setOssip)+"";
	}

	/* Service */
	@Override
	public CustomReqOrderVO orderServiceSelect(CustomMngReqWorkVO req) {
		return mngReqWorkDAO.orderServiceSelect(req);
	}
	@Override
	public String setReqServiceInsert(CustomMngReqWorkVO req) {
		return mngReqWorkDAO.setReqServiceInsert(req)+"";
	}
	@Override
	public String setOssServiceInsert(CustomMngOssVo bakValue) {
		return mngReqWorkDAO.setOssServiceInsert(bakValue)+"";
	}
	@Override
	public String setOssServiceUpdate(CustomMngOssVo setOssback) {
		return mngReqWorkDAO.setOssServiceUpdate(setOssback)+"";
	}
	@Override
	public String setOssServiceVmUpdate(CustomMngReqWorkVO req) {
		return mngReqWorkDAO.setOssServiceVmUpdate(req)+"";
	}

	@Override
	public String setOssScailOutInsert(CustomMngReqWorkVO req) {

		try {
			if(req.getServiceType().equals("ASCL")) {

				UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

				CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());

				OpsApiOptionVO opsApiOptionVO = new OpsApiOptionVO();

				opsApiOptionVO.setAppName(req.getAppName());
				opsApiOptionVO.setScaleOutName(req.getScaleOutName());

				opsApiOptionVO.setHpaDivision(req.getHpaDivision());
				opsApiOptionVO.setHpaMin(Integer.parseInt(req.getHpaMin()));
				opsApiOptionVO.setHpaMax(Integer.parseInt(req.getHpaMax()));
				opsApiOptionVO.setHpaContinue(Integer.parseInt(req.getHpaContinue())); // 지속시간
				opsApiOptionVO.setHpaMinPod(Integer.parseInt(req.getHpaMinPod()));
				opsApiOptionVO.setHpaMaxPod(Integer.parseInt(req.getHpaMaxPod()));
				opsApiOptionVO.setHpaIncrePod(Integer.parseInt(req.getHpaIncrePod()));

				String namespace = "";

				if ("DEV".equals(req.getEnvType())) {
					namespace = req.getProjectName() + CodeUtil.CREATE_PAAS_DEV_ENV;
				} else {
					namespace = req.getProjectName() + CodeUtil.CREATE_PAAS_PORD_ENV;
				}

				opsApiOptionVO.setNameSpace(namespace);

				HorizontalPodAutoscaler HorizontalPodAutoscaler = opsApiOptionService.createHorizontalPodAutoscaler(cloudVo, opsApiOptionVO);
//				io.fabric8.kubernetes.api.model.autoscaling.v2beta2.HorizontalPodAutoscaler HorizontalPodAutoscaler = opsApiOptionService.createPodAutoscalerV2(cloudVo, opsApiOptionVO);

	           	 CustomOssAppVO customOssAppVO = new CustomOssAppVO();
	            	 customOssAppVO.setScaleOutUid(HorizontalPodAutoscaler.getMetadata().getUid());
	            	 customOssAppVO.setScaleOutName(req.getScaleOutName());
	            	 customOssAppVO.setProjectId(req.getProjectId());
	            	 customOssAppVO.setAppUid(req.getAppUid());
	            	 customOssAppVO.setHpaDivision(req.getHpaDivision());

	            	 customOssAppVO.setHpaMin(Integer.parseInt(req.getHpaMin()));
	            	 customOssAppVO.setHpaMax(Integer.parseInt(req.getHpaMax()));
	            	 customOssAppVO.setHpaContinue(Integer.parseInt(req.getHpaContinue()));
	            	 customOssAppVO.setHpaMinPod(Integer.parseInt(req.getHpaMinPod()));
	            	 customOssAppVO.setHpaMaxPod(Integer.parseInt(req.getHpaMaxPod()));
	            	 customOssAppVO.setHpaIncrePod(Integer.parseInt(req.getHpaIncrePod()));
	            	 customOssAppVO.setRegUserId(userSession.getUsername());
	            	 customOssAppVO.setServiceId(req.getServiceId());
	           	 return ossAppService.insertScaleOut(customOssAppVO);
			}
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return "0";
	}




}
