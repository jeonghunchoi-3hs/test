package com.ivucenter.cloud.portal.alarms.withkepco;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WithKepcoService {

    private static final Logger logger = LoggerFactory.getLogger(WithKepcoService.class);

//	@Autowired 	private MailQueueHistoryService service;

	@Autowired
	private WithKepcoDAO dao;

	public void alarmsKepco(Map<String, String> paramMap) {
		Assert.notNull(paramMap.get("gbn"), "gbn이 없습니다.");
		Assert.notNull(paramMap.get("requestSeq"), "requestSeq가 없습니다.");
		Assert.notNull(paramMap.get("regUserId"), "regUserId가 없습니다.");
		Assert.notNull(paramMap.get("regUserName"), "regUserName이 없습니다.");
		Assert.notNull(paramMap.get("url"), "url이 없습니다. ");
		boolean isApprvUser = paramMap.containsKey("apprvNowUserId") || paramMap.containsKey("apprvNextUserId");
		Assert.isTrue(isApprvUser, "apprvNowUserId 또는 apprvNextUserId 이 없습니다.");

		final String seq = DateFormatUtils.format(new Date(), "yyyyMMddHH") + RandomStringUtils.randomNumeric(5);

		String redirectUrl = paramMap.get("url");
		paramMap.put("redirectUrl", redirectUrl);
		boolean isMng = StringUtils.contains(redirectUrl, "/mng");
		if(isMng) {
			paramMap.put("url", "http://k-cloud.kepco.co.kr/mng/alarms/kepco/redirect/" + seq);
		} else {
			paramMap.put("url", "http://k-cloud.kepco.co.kr/mbr/alarms/kepco/redirect/" + seq);
		}

		CustomWithKepcoVO queueVO = new CustomWithKepcoVO();
		queueVO.setAlarmSeq(seq);
		queueVO.setApprovalNo(paramMap.get("requestSeq"));			// 프로젝트결재:req_project_seq, 자원 결재: order_no
		queueVO.setWriterId(paramMap.get("regUserId"));				// 기안자 사번
		queueVO.setWriterName(paramMap.get("regUserName"));			// 기안자 이름
		queueVO.setContentUrl(paramMap.get("url")); 				// 클라우드 시스템 URL 사용자/관리자 구분 필요 // "http://K-cloud.kepco.co.kr/mbr"
		queueVO.setSystemName("K-Cloud");				// 시스템 이름 (E-CLOUD)
		queueVO.setRedirectUrl(paramMap.get("redirectUrl"));

		int gbn = Integer.parseInt(paramMap.get("gbn"));
		String title = (gbn < 30 ) ? "클라우드 프로젝트" : "클라우드 자원";
		switch(gbn) {
			case 20: // 프로젝트 신청
			case 30: // 자원 신청
				title += " 신청";
				queueVO.setTitle(title);
				queueVO.setSignType("S"); 		// S: 결재 시작/중간 , E: 결재 종료/반송
				queueVO.setStatus("0");			// 0; 진행 , 1: 완료, 9: 회수
				queueVO.setPayerId(paramMap.get("apprvNextUserId"));// 결재자 사번
				break;
			case 23: // 프로젝트 승인 요청
			case 33: // 자원 승인 요청
				if(paramMap.containsKey("apprvNowUserId")) {
					String tmp = title + " 승인 완료";
					queueVO.setTitle(tmp);
					queueVO.setSignType("E");
					queueVO.setStatus("0");
					queueVO.setPayerId(paramMap.get("apprvNowUserId"));	// 결재자 사번
					if(paramMap.containsKey("apprvNextUserId")) {
						dao.alarmWithKepcoQueueInsert(queueVO);
					}
				}
				if(paramMap.containsKey("apprvNextUserId")) {
					title += " 승인 요청";
					queueVO.setTitle(title);
					queueVO.setSignType("S");
					queueVO.setStatus("0");
					queueVO.setPayerId(paramMap.get("apprvNextUserId"));// 결재자 사번
				}
				break;
			case 21: // 프로젝트 승인 완료
			case 31: // 자원 승인 완료
				title += " 승인 완료";
				queueVO.setTitle(title);
				queueVO.setSignType("E");
				queueVO.setStatus("1");
				queueVO.setPayerId(paramMap.get("apprvNowUserId"));	// 결재자 사번
				break;
			case 22: // 프로젝트 승인 반려
			case 32: // 자원 승인 반려
				if(paramMap.containsKey("apprvNextUserId")) {
					String tmp = title + " 승인 완료";
					queueVO.setTitle(tmp);
					queueVO.setSignType("E");
					queueVO.setStatus("0");
					queueVO.setPayerId(paramMap.get("apprvNextUserId"));	// 결재자 사번
					dao.alarmWithKepcoQueueInsert(queueVO);
				}
				title += " 승인 반려";
				queueVO.setTitle(title);
				queueVO.setSignType("E");
				queueVO.setStatus("9");
				queueVO.setPayerId(paramMap.get("apprvNowUserId"));	// 결재자 사번
				break;
			case 24: // 프로젝트 결재자 지정
			case 34: // 자원 결재자 지정
				title += " 결재자 지정";
				queueVO.setTitle(title);
				queueVO.setSignType("S");
				queueVO.setStatus("0");
				queueVO.setPayerId(paramMap.get("apprvNowUserId"));	// 결재자 사번
				break;
			case 25: // 프로젝트 결재자 지정완료
			case 35: // 자원 결재자 지정완료
				title += " 결재자 지정완료";
				queueVO.setTitle(title);
				queueVO.setSignType("E");
				queueVO.setStatus("0");
				queueVO.setPayerId(paramMap.get("apprvNowUserId"));
				break;
			default :
				log.debug("No case alarmKepco gbn : " + String.valueOf(gbn));
				return ;
		}
		if(!queueVO.getPayerId().equals("")) {
			dao.alarmWithKepcoQueueInsert(queueVO);
		}
	}

	public String list(CustomWithKepcoVO req) {

    	List<CustomWithKepcoVO> lists = dao.list(req);
    	int recordsTotal = dao.listTot(req).size();
    	int recordsFiltered = recordsTotal;

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
            logger.error("JSON 처리 중 오류 발생");
	    }
		return "";
	}

	public CustomWithKepcoVO detail(String alarmSeq) {
		return dao.detail(alarmSeq);
	}

	public List<CustomWithKepcoVO> excel(CustomWithKepcoVO req){
		return dao.list(req);
	}
}
