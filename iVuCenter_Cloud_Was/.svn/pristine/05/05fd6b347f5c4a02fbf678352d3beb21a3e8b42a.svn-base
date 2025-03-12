package com.ivucenter.cloud.portal.project.loadbalancer;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.time.DateFormatUtils;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.oss.loadbalancer.CustomOssLbVO;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqOrderVO;
import com.ivucenter.cloud.portal.req.catalogue.ReqCatalogueService;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;
import com.ivucenter.cloud.portal.req.product.ReqProductService;
import com.ivucenter.cloud.portal.util.CodeUtil;
import com.ivucenter.cloud.portal.util.JsonUtil;

@Controller
@RequestMapping(value="/mng/project/lb")
public class MngProjectLbController {

	@Autowired
	private ReqCatalogueService reqCatalogueService;

	@Autowired
	private AlarmsTemplateService alarmsTemplateService;

	@Autowired
	private ReqProductService reqProductService;

	@RequestMapping(value="/")
	public String MngProjectLb(Model model) {
		return "mng/project/lb/projectLb_list";
	}

	@RequestMapping(value="/view")
	public String MngProjectLbWrite(Model model, CustomOssLbVO req) {
		model.addAttribute("req", req);
		return "mng/project/lb/projectLb_view";
	}

	@RequestMapping(value="/detail")
	public String MngProjectLbDetail(Model model, CustomOssLbVO req) {
		model.addAttribute("req", req);
		return "mng/project/lb/projectLb_detail";
	}

	@RequestMapping(value = "/catalogueLoadBalancer")
	public ResponseEntity<Object> catalogueLoadBalancer(HttpServletRequest request, Model model,CustomReqOrderVO ordervo ){
			String res = "1";
			ordervo.setOrderUserId(request.getUserPrincipal().getName());
			model.addAttribute("ordervo", ordervo);

			String orderProductSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
			String orderNo         = orderProductSeq;


			ordervo.setOrderProductSeq(orderProductSeq);
			ordervo.setOrderNo(orderNo);
			ordervo.setProductCategory("ITEMCATE_LOADBALANCER");
			ordervo.setHourlyFlag("N");
			String applyDatetime = "";

			if(ordervo.getOnDemandFlag().equals("N")){
				applyDatetime =	ordervo.getApplyDatetime();
			}

			String tmpApprovalStepList = request.getParameter("approvalStepListString");

//			JSONArray jsonArray = new JSONArray(tmpApprovalStepList);
//			List list = new ArrayList<>();
//
//			for (int i=0; i<jsonArray.length(); i++) {
//				jsonArray.getJSONObject(i);
//			    list.add( JsonUtil.toMap(jsonArray.getJSONObject(i)) );
//			}

			ordervo.setApprovalStepList(tmpApprovalStepList);

			String orderSummary = "";
			orderSummary = "<hr />";
			orderSummary = orderSummary + "<table><colgroup><col width='30%'><col width='70%'></colgroup><tbody>";
			//orderSummary = orderSummary +"<tr><td class='left'>서비스시작일시</td><td>"+applyDatetime+"</td></tr>";
			orderSummary = orderSummary + "<tr><td class='left'>신청자원</td><td>로드밸런스";
			if(ordervo.getRequestType().equals("REQTYPE_EXPR")) {
				orderSummary = orderSummary + " 삭제";
			} else if(ordervo.getRequestType().equals("REQTYPE_CHANGE")) {
				orderSummary = orderSummary + " 가상서버 추가";
			}
			orderSummary = orderSummary + "</td></tr>";
			orderSummary = orderSummary + "<tr><td class='left'>로드밸런스명</td><td>" + ordervo.getLoadbalancerName() + " </td></tr>";
			orderSummary = orderSummary + "<tr><td class='left'>IP</td><td>" + ordervo.getIp() + " </td></tr>";
			orderSummary = orderSummary + "<tr><td class='left'>포트</td><td>" + ordervo.getPort() + " </td></tr>";
			orderSummary = orderSummary + "<tr><td class='left'>Method</td><td>" + ordervo.getMethod() + " </td></tr>";
			orderSummary = orderSummary + "<tr><td class='left'>protocol</td><td>" + ordervo.getProtocol() + " </td></tr>";
			if(ordervo.getDescription() != null){
				orderSummary = orderSummary +"<tr><td class='left'>요청사항</td><td>"+ordervo.getDescription()+" </td></tr>";
			}

			orderSummary = orderSummary +"</tbody></table>";
			ordervo.setOrderSummary(orderSummary);

			String setOrder = reqCatalogueService.setOrder(ordervo);
			reqCatalogueService.setOrderProduct(ordervo);

			reqCatalogueService.setOrderProductLb(ordervo);
			reqCatalogueService.setOrderProductLbVm(ordervo);


			//1차 승인 예정자
	        String hiddenUserIdReview = request.getParameter("hiddenUserIdReview");
	        //2차 승인 예정자
			String hiddenUserIdApprove = request.getParameter("hiddenUserIdApprove");
			// 2020.05.25(장중일) - 신규 결재라인 등록 부분
			// 지정된 결재자 정보
			List<Map<String, Object>> stepList = ordervo.getApprovalStepList();
			// 결재라인 정보
			List<CustomReqCustomerVO> getApprovalModelSteplist = reqCatalogueService.getApprovalModelSteplist2();

			int tmpStep = 0;
			boolean tmpStartFlag = false;
			if(ordervo.getSelectApprv().equals("Y") && ordervo.getApprvPass().equals("Y")) {
				for(CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
					UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
					CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
					paramStepInfo.setRequestSeq(ordervo.getOrderNo());
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
			}else {
				for(CustomReqCustomerVO customerVO : getApprovalModelSteplist) {
					HashMap<String, Object> stepInfo = (HashMap<String, Object>) stepList.get(tmpStep);

					CustomReqCustomerVO paramStepInfo = new CustomReqCustomerVO();
					paramStepInfo.setRequestSeq(ordervo.getOrderNo());
					paramStepInfo.setStepId(customerVO.getStepId());
					paramStepInfo.setModelId(customerVO.getModelId());
					paramStepInfo.setStepName(customerVO.getStepName());
					paramStepInfo.setStepLevel(customerVO.getStepLevel());
					paramStepInfo.setLeftStepId(customerVO.getLeftStepId());
					paramStepInfo.setRightStepId(customerVO.getRightStepId());

					if( paramStepInfo.getStepLevel().equals("1") ) {
						if(stepInfo.get("userId").equals("") || stepInfo.get("userId") == null ) {
							tmpStartFlag = true;
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_COMPLETED);
						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
							hiddenUserIdReview = (String)stepInfo.get("userId");
						}

					} else if( paramStepInfo.getStepLevel().equals("2") ) {
						if( tmpStartFlag ) {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_PROCESSING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
						} else {
							paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
							paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));
							hiddenUserIdReview = (String)stepInfo.get("userId");
						}

					} else if(paramStepInfo.getStepLevel().equals("3")){
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));

					} else if(paramStepInfo.getStepLevel().equals("4")){
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
						paramStepInfo.setApprvScheduleUserId((String)stepInfo.get("userId"));

					} else {
						paramStepInfo.setApprvState(CodeUtil.CMM_CODE_APPRV_WAITING);
					}
					reqCatalogueService.setSrApprovalStepinsert2(paramStepInfo);

					if(tmpStep < 3) { tmpStep++; }
				}
				CustomReqProductVO reqProductVo = reqProductService.orderUserInfo(ordervo.getOrderNo());
				Map<String,String> keywordMap = new HashMap<>();
				keywordMap.put("[[신청자명]]", reqProductVo.getUserName());
				keywordMap.put("[[서버명]]", orderSummary);
				keywordMap.put("[[URL]]", "http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo="+ordervo.getOrderNo());
				keywordMap.put("[[LURL]]", "http://k-cloud.kepco.co.kr/mbr");
				// 신청자에게 알림
				alarmsTemplateService.alarms(30, ordervo.getOrderUserId(), keywordMap);
				// 결재자에게 요청
				alarmsTemplateService.alarms(33, hiddenUserIdReview, keywordMap);
				// 한전 연계 시스템 전송
				Map<String, String> alarmkepcoMap = new HashMap<>();
				alarmkepcoMap.put("gbn", "30");
				alarmkepcoMap.put("requestSeq", ordervo.getOrderNo());
				alarmkepcoMap.put("regUserId", ordervo.getOrderUserId());	// 자원 신청자
				alarmkepcoMap.put("apprvNextUserId", hiddenUserIdReview);	// 다음 결재자
				alarmkepcoMap.put("url", "http://k-cloud.kepco.co.kr/mbr/req/catalogue/bssOrderApproveView?orderNo="+orderNo);
				alarmsTemplateService.alarmsKepco(alarmkepcoMap);
			}

			res = setOrder;

			return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


}
