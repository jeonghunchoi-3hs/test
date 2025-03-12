package com.ivucenter.cloud.portal.cmm.cloud;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OssCloudService {
	
	@Autowired
	private OssCloudDAO dao;

	public String list(CustomOssCloudVO req) {

    	List<CustomOssCloudVO> lists = dao.list(req);
    	int recordsTotal = dao.listTot(req);
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
	    	log.error(e.getMessage());	        
	    }
		return "";
	}
	
	public CustomOssCloudVO detail(CustomOssCloudVO req) {
		Assert.notNull(req.getCloudId(), "");
		return dao.detail(req);
	}

	public List<CustomOssCloudVO> getCloudList(){
		return dao.getCloudList();
	}
	
	
	public CustomOssCloudVO getCloudInfo(String cloudId){
		Assert.notNull(cloudId, "");
		return dao.detail(cloudId);
	}

//	public Map<String, CustomOssCloudVO> getCloudInfo() {
//		if(cloudInfo == null) {
//			cloudInfo = new HashMap<String,CustomOssCloudVO>();
//			List<CustomOssCloudVO> lists = dao.getCloudList();
//			for (CustomOssCloudVO list : lists) {
//	        	cloudInfo.put(list.getCloudId(), list);
//	        }
//			return cloudInfo;
//		}
//		return new HashMap<String,CustomOssCloudVO>();
//	}

	public String insert(CustomOssCloudVO req) {
		return dao.insert(req)+"";
	}
	public String update(CustomOssCloudVO req) {
		return dao.update(req)+"";
	}
	
	public String delete(CustomOssCloudVO req) {
		Assert.notNull(req.getCloudId(), "");
		Assert.notNull(req.getModUserId(), "");
		return dao.delete(req)+"";
	}
	
	public List<CustomOssCloudVO> getVmwareCloudList(){
		return dao.getVmwareCloudList();
	}
	
	public CustomOssCloudVO getCloudroles(){
		return dao.getCloudroles();
	}
	
	public CustomOssCloudVO rownumCloudDetail(String rownum){
		return dao.rownumCloudDetail(rownum);
	}
	
	public List<CustomOssCloudVO> getOssProjectCloudListByReqProjectSeq(String reqProjectSeq){
		return dao.getOssProjectCloudListByReqProjectSeq(reqProjectSeq);
	}
	
	public List<CustomOssCloudVO> getReqProjectCloudListByReqProjectSeq(String reqProjectSeq){
		return dao.getReqProjectCloudListByReqProjectSeq(reqProjectSeq);
	}
	
	public List<CustomOssCloudVO> getOssProjectByProjectBoxId(String reqProjectSeq){
		return dao.getOssProjectByProjectBoxId(reqProjectSeq);
	}
	
	public List<CustomOssCloudVO> getReqProjectCloudListByReqProjectSeqReApprove(String reqProjectSeq){
		return dao.getReqProjectCloudListByReqProjectSeqReApprove(reqProjectSeq);
	}
	
	
	public List<CustomOssCloudVO> getCloudprojectList(CustomOssCloudVO req){
		return dao.getCloudProjectList(req);
	}
	
	public List<CustomOssCloudVO> getCloudSubnetList(String cloudId){
		return dao.getCloudSubnetList(cloudId);
	}
	

}
