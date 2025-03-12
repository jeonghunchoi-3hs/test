package com.ivucenter.cloud.portal.bss.basket;

import java.util.Date;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ivucenter.cloud.portal.req.catalogue.CustomReqBasketVO;
import com.ivucenter.cloud.portal.util.CodeUtil;

@Service
public class BssBasketService{
	
	@Autowired
	private BssBasketDAO dao;
	
	public CustomReqBasketVO changeBasket(CustomReqBasketVO req) {
		String sSeq = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss");
		req.setBasketSeq(sSeq);
		req.setBasketSummary(setSummaryByChangeBasket(req));
		return insertChangeBasket(req);
	}
	
	public static String setSummaryByChangeBasket(CustomReqBasketVO req) {
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
	
	public CustomReqBasketVO insertChangeBasket(CustomReqBasketVO req) {
		// bss_order
		dao.insertBssBasket(req);
		if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_VM)){
			dao.insertBssBasketVm(req);			
		}else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_DISK)){
			dao.insertBssBasketDisk(req);
		}else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_NAS)){
			dao.insertBssBasketNas(req);			
		}else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_PUBLICIP)){
			dao.insertBssBasketIp(req);
		}else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_SERVICE)){
			dao.insertBssBasketService(req);	
		}
//		else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_BACKUP)){
//			dao.insertBssBasketBack(req);	
//		}else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_MCA)){
//			dao.insertBssBasketMca(req);	
//		}else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_SCM)){
//			dao.insertBssBasketScm(req);	
//		}else if(req.getProductCategory().equals(CodeUtil.CMM_CODE_PRODCATE_SECURITY)){
//			dao.insertBssBasketSec(req);				
//		}
		
		req.setErrorMsg("1");
		return req;
	}
}
