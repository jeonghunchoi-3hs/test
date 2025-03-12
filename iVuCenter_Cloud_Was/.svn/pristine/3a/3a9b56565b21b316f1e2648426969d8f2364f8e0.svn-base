package com.ivucenter.cloud.portal.req.customer;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("reqCustomerService")
public class ReqCustomerServiceImpl implements ReqCustomerService{

    private static final Logger logger = LoggerFactory.getLogger(ReqCustomerServiceImpl.class);

	@Resource(name="reqCustomerDAO")
	private ReqCustomerDAO reqCustomerDAO;


	@Override
	public List<CustomReqCustomerVO> getCompanyList() {
		log.debug("=== getCompanyList Service ===");
		return reqCustomerDAO.getCompanyList();
	}

	@Override
	public void setCustomerForminsert(CustomReqCustomerVO customervo) {
		log.debug("=== getCompanyList Service ===");
		reqCustomerDAO.setCustomerForminsert(customervo);
	}

	@Override
	public List<CustomReqCustomerVO> getApprovalModelSteplist() {
		log.debug("=== getApprovalModelSteplist Service ===");
		return reqCustomerDAO.getApprovalModelSteplist();
	}

	@Override
	public void setSrApprovalStepinsert(CustomReqCustomerVO appmodelstep) {
		log.debug("=== setSrApprovalStepinsert Service ===");
		reqCustomerDAO.setSrApprovalStepinsert(appmodelstep);
	}

	@Override
	public List<CustomReqCustomerVO> getApprovalModelMemberlist() {
		log.debug("=== getApprovalModelMemberlist Service ===");
		return reqCustomerDAO.getApprovalModelMemberlist();
	}

	@Override
	public void setSrApprovalMemberinsert(CustomReqCustomerVO appmember) {
		log.debug("=== setSrApprovalMemberinsert Service ===");
		reqCustomerDAO.setSrApprovalMemberinsert(appmember);
	}

	@Override
	public String getCustomefIdcheck(String customerId) {
		log.debug("=== getCustomefIdcheck Service ===");
		return reqCustomerDAO.getCustomefIdcheck(customerId);
	}

	@Override
	public String getCustomerNamecheck(String customerName) {
		log.debug("=== getCustomerNamecheck Service ===");
		return reqCustomerDAO.getCustomerNamecheck(customerName);
	}

	@Override
	public boolean getCustomerNameajaxcheck(String customerName) {
		log.debug("=== getCustomerNamecheck Service ===");
		return reqCustomerDAO.getCustomerNameajaxcheck(customerName);
	}

	@Override
	public int setCustomerFormchk(CustomReqCustomerVO customervo) {
		log.debug("=== setCustomerFormchk Service ===");
		return reqCustomerDAO.setCustomerFormchk(customervo);
	}

	@Override
	public CustomReqCustomerVO getCompanySelectList(CustomReqCustomerVO customervo) {
		return reqCustomerDAO.getCompanySelectList(customervo);
	}
	//pho
	@Override
	public String list(CustomReqCustomerVO req) {
	    int recordsTotal;
	    int recordsFiltered;

    	List<CustomReqCustomerVO> lists = reqCustomerDAO.list(req);
	    recordsTotal = reqCustomerDAO.listTot(req);
	    recordsFiltered = recordsTotal;

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

	@Override
	public 	CustomReqCustomerVO detail(String requestSeq){
		return reqCustomerDAO.detail(requestSeq);
	}

	@Override
	public String insert(CustomReqCustomerVO req) {
		return reqCustomerDAO.insert(req)+"";
	}
	@Override
	public String rejectedUpdate(CustomReqCustomerVO req) {
		return reqCustomerDAO.rejectedUpdate(req)+"";
	}
	@Override
	public String newUpdate(CustomReqCustomerVO req) {
		return reqCustomerDAO.newUpdate(req)+"";
	}

	@Override
	public String update(CustomReqCustomerVO req) {
		return reqCustomerDAO.update(req)+"";
	}

	@Override
	public String exprUpdate(CustomReqCustomerVO req) {
		return reqCustomerDAO.exprUpdate(req)+"";
	}

	@Override
	public String stepUpdate(CustomReqCustomerVO req) {
		return reqCustomerDAO.stepUpdate(req)+"";
	}

	@Override
	public List<CustomReqCustomerVO> approvalList(String requestSeq) {
		return reqCustomerDAO.approvalList(requestSeq);
	}
	@Override
	public List<CustomReqCustomerVO> approvalUserId(String requestSeq) {
		return reqCustomerDAO.approvalUserId(requestSeq);
	}
}
