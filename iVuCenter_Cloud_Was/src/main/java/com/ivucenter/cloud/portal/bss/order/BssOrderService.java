package com.ivucenter.cloud.portal.bss.order;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateFormatUtils;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqOrderVO;
import com.ivucenter.cloud.portal.req.catalogue.ReqCatalogueService;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;
import com.ivucenter.cloud.portal.req.product.ReqProductService;
import com.ivucenter.cloud.portal.util.CodeUtil;
import com.ivucenter.cloud.portal.util.JsonUtil;

@Service
public class BssOrderService{

	@Autowired
	private BssOrderDAO dao;

	@Autowired
	private ReqCatalogueService reqCatalogueService;

	@Autowired
	private AlarmsTemplateService alarmsTemplateService;

//	@Autowired	private ApprovalService approvalService;

	@Autowired
	private ReqProductService reqProductService;

	public CustomReqOrderVO directChangeOrder(CustomReqOrderVO req) {
		String sSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		req.setOrderNo(sSeq);
		req.setOrderProductSeq(sSeq);
		req.setOrderSummary(setSummaryByChangeOrder(req));
		req.setHiddenUserIdApprove(req.getHiddenUserIdApprove());
		req.setHiddenUserIdReview(req.getHiddenUserIdReview());
		return insertChangeOrder(req);
	}

	private String setSummaryByChangeOrder(CustomReqOrderVO req) {
		StringBuffer sb = new StringBuffer();
		sb.append("<table>");
		sb.append("	<colgroup>");
		sb.append("		<col width='30%'>");
		sb.append("		<col width='70%'>");
		sb.append("	</colgroup>");
		sb.append("	<tbody>");
		sb.append("		<tr>");
		sb.append("			<td class='left'>"+(req.getRequestType().equals("REQTYPE_CHANGE")?"변경희망":"해지희망")+" 일시</td>");
		sb.append("			<td>"+(req.getOnDemandFlag().equals("Y")?"승인 완료 후 변경":req.getApplyDatetime())+"</td>");
		sb.append("		</tr>");
		sb.append("		<tr>");
		sb.append("			<td class='left'>프로젝트</td>");
		sb.append("			<td>"+req.getProjectName()+"</td>");
		sb.append("		</tr>");
		sb.append("		<tr>");
		sb.append("			<td class='left'>호스트명(한글)</td>");
		sb.append("			<td>"+req.getHostnameAlias()+"</td>");
		sb.append("		</tr>");
		sb.append("		<tr>");
		sb.append("			<td class='left'>호스트명(영문)</td>");
		sb.append("			<td>"+req.getHostname()+"</td>");
		sb.append("		</tr>");
		if(req.getRequestType().equals("REQTYPE_CHANGE")){
			if(
					req.getBeforeVcpus() != null
					&& req.getVcpus() != null
					&& !req.getBeforeVcpus().equals(req.getVcpus())
					){
				sb.append("		<tr>");
				sb.append("			<td class='left'>CPU</td>");
				sb.append("			<td>"+req.getBeforeVcpus()+" 에서 "+req.getVcpus()+" 으로 변경</td>");
				sb.append("		</tr>");
			}
			if(
					req.getBeforeMemGb() != null
					&& req.getMemGb() != null
					&& !req.getBeforeMemGb().equals(req.getMemGb())
					){
				sb.append("		<tr>");
				sb.append("			<td class='left'>MEM</td>");
				sb.append("			<td>"+req.getBeforeMemGb()+" 에서 "+req.getMemGb()+" 으로 변경</td>");
				sb.append("		</tr>");
			}
			if(
					req.getBeforeDiskGb() != null
					&& req.getDiskGb() != null
					&& !req.getBeforeDiskGb().equals(req.getDiskGb())
					){
				sb.append("		<tr>");
				sb.append("			<td class='left'>DISK</td>");
				sb.append("			<td>"+req.getBeforeDiskGb()+" 에서 "+req.getDiskGb()+" 으로 변경</td>");
				sb.append("		</tr>");
			}
		}
		sb.append("	</tbody>");
		sb.append("</table>");
		return sb.toString();
	}

	private CustomReqOrderVO insertChangeOrder(CustomReqOrderVO req) {
		String cloudId = dao.getCloudId(req);
		req.setCloudId(cloudId);
		dao.insertBssOrder(req);
		dao.insertBssOrderProduct(req);
		if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_VM)){
			dao.insertBssOrderProductVm(req);
			CustomReqOrderVO serviceSeq = dao.serviceSeq(req.getVmUuid());

			if(serviceSeq != null) {
				CustomReqOrderVO reqOrder = new CustomReqOrderVO();
				String sSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
				// order_product_seq값에 +1해서 추가
				long sSeqLong = Long.parseLong(sSeq);
				sSeqLong += 1;
				String newSeq = String.valueOf(sSeqLong);
				reqOrder.setOrderNo(req.getOrderNo());
//				reqOrder.setOrderProductSeq(sSeq);
				reqOrder.setOrderProductSeq(newSeq);
				reqOrder.setOrderSummary(setSummaryByChangeOrder(req));
				reqOrder.setRequestType(CodeUtil.CMM_CODE_REQTYPE_EXPR);
				reqOrder.setProductCategory(CodeUtil.CMM_CODE_PRODCATE_SERVICE);
				reqOrder.setHourlyFlag("Y");
				reqOrder.setAmount(req.getAmount());
				reqOrder.setCloudId(req.getCloudId());
				reqOrder.setWorkUserId(req.getRegUserId());
				reqOrder.setServiceId(req.getServiceId());

				reqOrder.setAnsibleStatus(req.getAnsibleStatus());
				reqOrder.setAnsibleStatusMessage(req.getAnsibleStatusMessage());

				serviceSeq.setOrderProductSeq(newSeq);
				serviceSeq.setVmUuid(req.getVmUuid());
				dao.insertBssOrderProduct(reqOrder);
				dao.insertBssOrderProductService(serviceSeq);
			}

		}else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_DISK)){
			dao.insertBssOrderProductDisk(req);
		}else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_NAS)){
			req.setDefaultNetworkId(req.getVmNetworkList());
			req.setDefaultNetworkIp(req.getVmIpList());
			dao.insertBssOrderProductNas(req);

//			List<Map<String, Object>> vmList = req.getReceiverVmList(); // 지정된 결재자 정보
//
//			for(int i =0; i< req.getReceiverVmList().size(); ++i) {
//				HashMap<String, Object> vmInfo = (HashMap<String, Object>) vmList.get(i);
//				String vmUuid = (String) vmInfo.get("id");
//				req.setVmUuid(vmUuid);
//				dao.insertBssOrderProductNasVm(req);
//			}
			
			String vmUuidList = req.getVmUuidList();
			
			if (vmUuidList != null && !vmUuidList.isEmpty()) {
				String[] arr = vmUuidList.split(",");
				for (String vmUuid : arr) {
					req.setVmUuid(vmUuid);
					dao.insertBssOrderProductNasVm(req);
				}
			}
		}else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_PUBLICIP)){
			dao.insertBssOrderProductIp(req);
		}else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_SERVICE)){
		    dao.insertBssOrderProductService(req);
		}else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_APP)) {
		    dao.insertBssOrderProductApp(req);
		}

//		else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_BACKUP)){
//			dao.insertBssOrderProductBack(req);
//		}else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_MCA)){
//			dao.insertBssOrderProductMca(req);
//		}else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_SCM)){
//			dao.insertBssOrderProductScm(req);
//		}else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_SECURITY)){
//			dao.insertBssOrderProductSec(req);
//		}
		step(req);
		req.setErrorMsg("1");
		return req;
	}

	private void step(CustomReqOrderVO req){

		String tmpApprovalStepList = req.getApprovalStepListString();

//		JSONArray jsonArray = new JSONArray(tmpApprovalStepList);
//		List list = new ArrayList<>();
//
//		for (int i=0; i<jsonArray.length(); i++) {
//			jsonArray.getJSONObject(i);
//		    list.add( JsonUtil.toMap(jsonArray.getJSONObject(i)) );
//		}

		req.setApprovalStepList(tmpApprovalStepList);

		//1차 승인 예정자
		String currentUserIdReview = "";
        String hiddenUserIdReview = req.getHiddenUserIdReview();
        //2차 승인 예정자
		String hiddenUserIdApprove = req.getHiddenUserIdApprove();
		/* 200617 수정
		Date requestSeqdate = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String orderProductSeq = dateFormat.format(requestSeqdate);
		String orderNo = dateFormat.format(requestSeqdate);

		req.setOrderProductSeq(orderProductSeq);
		req.setOrderNo(orderNo);
		*/
		req.setRequestType("REQTYPE_NEW");

		//log.debug("ordervo.getParameter() : " + request.getParameter("defaultNetworkAlias"));
		//log.debug("ordervo.getDefaultNetworkAlias() : " + ordervo.getDefaultNetworkAlias());
		//log.debug("ordervo.getNetworkAlias() : " + ordervo.getNetworkAlias());

		String orderSummary = "";
		orderSummary ="<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
		orderSummary = orderSummary +"<tr><td class='left'>서비스시작일시</td><td>"+req.getApplyDatetime()+"</td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>프로젝트</td><td>"+req.getProjectName()+" </td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>네트워크 ZONE</td><td>"+req.getDefaultNetworkAlias()+" </td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>HOST</td><td>"+req.getHostname()+"</td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>HOST ALIAS</td><td>"+req.getHostnameAlias()+"</td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>CPU</td><td>"+req.getVcpus()+" vCPU</td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>MEM</td><td>"+req.getMemGb()+" GB</td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>DISK</td><td>"+req.getDiskGb()+" GB </td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>비고</td><td>"+req.getDescription()+" </td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>아이디</td><td>appuser</td></tr>";
		orderSummary = orderSummary +"<tr><td class='left'>패스워드</td><td>kepco123/456</td></tr>";
		orderSummary = orderSummary +"<tr><td colspan='2' class='tar f18 fc-red'>"+req.getAmount()+" <span class='f12 fc66'>원</span></td></tr>";
		orderSummary = orderSummary +"</tbody></table>";
		req.setOrderSummary(orderSummary);
		// 지정된 결재자 정보
		List<Map<String, Object>> stepList = req.getApprovalStepList();

		// 결재라인 정보
		List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplist2();

		int tmpStep = 0;
		boolean tmpStartFlag = false;
		if(req.getSelectApprv().equals("Y") && req.getApprvPass().equals("Y")) {
			for(CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
				UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
				paramStepInfo.setRequestSeq(req.getOrderNo());
				paramStepInfo.setStepId(customerVO.getStepId());
				paramStepInfo.setModelId(customerVO.getModelId());
				paramStepInfo.setStepName(customerVO.getStepName());
				paramStepInfo.setStepLevel(customerVO.getStepLevel());
				paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
				paramStepInfo.setRightStepId(customerVO.getRightStepId());



				if(tmpStep < 5) {
					paramStepInfo.setApprvUserId(userSession.getUsername());
					paramStepInfo.setApprvUserName(userSession.getNickname());
					paramStepInfo.setApprvScheduleUserId(userSession.getUsername());
					paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
				} else {
					if(tmpStep == 5) {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_UNASSIGNED);
					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					}
				}
				tmpStep++;
				reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

				if(tmpStep < 3) { tmpStep++; }
			}
		} else {
			for(CustomReqCustomerVO customerVO : getApprovalModelSteplist){
				HashMap<String, Object> stepInfo = (HashMap<String, Object>) stepList.get(tmpStep);

				CustomReqCustomerVO appmodelstep = new CustomReqCustomerVO();
				appmodelstep.setRequestSeq(req.getOrderNo());
				appmodelstep.setStepId(customerVO.getStepId());
				appmodelstep.setModelId(customerVO.getModelId());
				appmodelstep.setStepName(customerVO.getStepName());
				appmodelstep.setStepLevel(customerVO.getStepLevel());
				appmodelstep.setLeftStepId(customerVO.getLeftStepId());
				appmodelstep.setRightStepId(customerVO.getRightStepId());


				if( appmodelstep.getStepLevel().equals("1") ) {
					if(stepInfo.get("userId").equals("") || stepInfo.get("userId") == null ) {
						tmpStartFlag = true;
						appmodelstep.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
					} else {
						appmodelstep.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
						appmodelstep.setApprvScheduleUserId((String)stepInfo.get("userId"));
						hiddenUserIdReview = (String)stepInfo.get("userId");
						currentUserIdReview = (String)stepInfo.get("userId");
					}

				} else if( appmodelstep.getStepLevel().equals("2") ) {
					if( tmpStartFlag ) {
						appmodelstep.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
						appmodelstep.setApprvScheduleUserId((String)stepInfo.get("userId"));
					} else {
						appmodelstep.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						appmodelstep.setApprvScheduleUserId((String)stepInfo.get("userId"));
						hiddenUserIdReview = (String)stepInfo.get("userId");
					}

				} else if(appmodelstep.getStepLevel().equals("3")){
					appmodelstep.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					appmodelstep.setApprvScheduleUserId((String)stepInfo.get("userId"));

				} else if(appmodelstep.getStepLevel().equals("4")){
					appmodelstep.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					appmodelstep.setApprvScheduleUserId((String)stepInfo.get("userId"));

				} else {
					appmodelstep.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
				}
				reqCatalogueService.setSrApprovalStepinsert2(appmodelstep);

				if(tmpStep < 3) { tmpStep++; }
			}
		}

		CustomReqProductVO reqProductVo = reqProductService.orderUserInfo(req.getOrderNo());
		Map<String,String> keywordMap = new HashMap<>();
		keywordMap.put("[[신청자명]]", reqProductVo.getUserName());
		keywordMap.put("[[서버명]]", orderSummary);
		keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo="+req.getOrderNo());
		keywordMap.put("[[LURL]]", "http://k-cloud.kepco.co.kr/mbr");

		// 신청자에게 알림
		alarmsTemplateService.alarms(30, req.getOrderUserId(), keywordMap);
		// 결재자에게 요청
		alarmsTemplateService.alarms(33, currentUserIdReview, keywordMap);
		// 한전 연계 시스템 전송
		Map<String, String> alarmkepcoMap = new HashMap<>();
		alarmkepcoMap.put("gbn", "30");
		alarmkepcoMap.put("requestSeq", req.getOrderNo());
		alarmkepcoMap.put("regUserId", req.getOrderUserId());		// 자원 신청자
		alarmkepcoMap.put("apprvNextUserId", currentUserIdReview);	// 다음 결재자
		alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo="+req.getOrderNo());
		alarmsTemplateService.alarmsKepco(alarmkepcoMap);
	}

//	private CustomReqOrderVO selectByOrderProductSeq(String orderProductSeq){
//		return dao.selectByOrderProductSeq(orderProductSeq);
//	}

}
