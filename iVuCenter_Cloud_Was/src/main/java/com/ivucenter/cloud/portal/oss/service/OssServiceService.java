package com.ivucenter.cloud.portal.oss.service;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.ServerIF;
import com.ivucenter.cloud.api.openstack.interfaces.VolumeIF;
import com.ivucenter.cloud.api.openstack.object.Server;
import com.ivucenter.cloud.api.openstack.object.Volume;
import com.ivucenter.cloud.api.openstack.object.VolumeAttachment;
import com.ivucenter.cloud.api.openstack.object.VolumnAttached;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;
/**
 * 
 * @author 
 *
 */
@Slf4j
@Service
public class OssServiceService{
	
	@Autowired
	private OssServiceDAO dao;
	
	@Autowired
	private OssCloudService ossCloudService;
	
	final String [] aPower = {
			"NOSTATE"
			,"RUNNING"
			,""
			,"PAUSED"
			,"SHUTDOWN"
			,""
			,"CRASHED"
			,"SUSPENDED"
	};
	
	public String list(CustomOssServiceVO req) {
		Assert.notNull(req.getCloudId(), "");
		Assert.notNull(req.getProjectId(), "");		
		Assert.notNull(req.getProjectName(), "");
		
		List<CustomOssServiceVO> lists = dao.list(req);
		int recordsTotal = dao.listTot(req).size();
		int recordsFiltered = recordsTotal;
	    
		List<CustomOssServiceVO> list = new LinkedList<CustomOssServiceVO>();
		String sError = "";

		try {
			// project server
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
			ServerIF serverIF = AbstractFactory.getServerIF(req.getProjectName(),cloudVo);
			List<Server> serverlists = serverIF.getServers();
			for (CustomOssServiceVO vo : lists) {
				for (Server obj : serverlists) {
					if(vo.getVmUuid().equals(obj.getId())){
						for(String sKey : obj.getAddresses().keySet()){
							if(sKey.lastIndexOf("_mgt_net") > 0){
								vo.setIpAddr(obj.getAddresses().get(sKey).get(0).getAddr());
								break;
							}else{
								vo.setIpAddr(obj.getAddresses().get(sKey).get(0).getAddr());
							}
						}
						vo.setStatus(obj.getStatus());
						vo.setPower(aPower[obj.getOS_EXT_STS_power_state()]);
						break;
					}
				}
				list.add(vo);
			}			
		} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
			log.error(e.getMessage());
			sError = e.getMessage();
	    } catch (Exception e) {
	    	log.error(e.getMessage());
	    	sError = e.getMessage();
		}

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();
	        
	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("error", sError);
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        log.debug( gson.toJsonTree(list).toString());
	        jsonResponse.add("data", gson.toJsonTree(list));
	        
	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}

	
	public CustomOssServiceVO serviceDetailInfo(CustomOssServiceVO req) {
		CustomOssServiceVO res = dao.serviceDetailInfo(req);
		return res;
	}
	public CustomOssServiceVO mbrServiceDetailInfo(CustomOssServiceVO req) {
		CustomOssServiceVO res = dao.mbrServiceDetailInfo(req);
		return res;
	}
	
	public List<CustomOssServiceVO> viewExcel(CustomOssServiceVO req) {
		List<CustomOssServiceVO> res = dao.viewExcel(req);
		return res;
	}
	
	public List<CustomOssServiceVO> mbrServiceViewExcel(CustomOssServiceVO req) {
		List<CustomOssServiceVO> res = dao.mbrServiceDetailListTot(req);
		return res;
	}
	
	public CustomOssServiceVO detail(CustomOssServiceVO req) {
		Assert.notNull(req.getCloudId(), "");				
		Assert.notNull(req.getProjectName(), "");
		Assert.notNull(req.getVmUuid(), "");
		
		CustomOssServiceVO res = dao.detail(req);
		ArrayList<String> array = new ArrayList<String>();
		
		try {
			// project server
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
			ServerIF serverIF = AbstractFactory.getServerIF(req.getProjectName(),cloudVo);
			Server server = serverIF.getServer(req.getVmUuid());
			
			int listSize = server.getAddresses().keySet().size();
			int cnt = 0;
			for(String sKey : server.getAddresses().keySet()){
				cnt++;
				if(res.getIpAddr() == null){
					if (cnt == listSize && res.getIpAddr() == null){
						res.setIpAddr(server.getAddresses().get(sKey).get(0).getAddr());
					}else if (cnt != listSize && res.getIpAddr() == null && sKey.lastIndexOf("_mgt_net") > 0){
						res.setIpAddr(server.getAddresses().get(sKey).get(0).getAddr());
					} else {
						array.add(server.getAddresses().get(sKey).get(0).getAddr());
					}
				}else{
					array.add(server.getAddresses().get(sKey).get(0).getAddr());
				}
			}
			
			int size = 0;
			VolumeIF volumeIF = AbstractFactory.getVolumeIF(req.getProjectName(),cloudVo);
			List<VolumnAttached> attachList = server.getOs_extended_volumes_volumes_attached();
			for(int i = 0 ; i < attachList.size(); i++){
				Volume obj = volumeIF.getVolume(attachList.get(i).getId());
				
				for(VolumeAttachment attach : obj.getAttachments()){
					if(req.getVmUuid().equals(attach.getServer_id())){
						size = size + obj.getSize();
					}
				}			
			}
			
			res.setBlockSize(size);
			res.setAddrList(array);
			res.setStatus(server.getStatus());
			res.setPower(aPower[server.getOS_EXT_STS_power_state()]);

			return res;
			
		} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
			log.error(e.getMessage());
			res.setError(e.getMessage());
		} 
		return res;
	}


	public String update(CustomOssServiceVO req) {
		return dao.update(req)+"";
	}
	public String vmHistoryInsert(CustomOssServiceVO req) {
		return dao.vmHistoryInsert(req)+"";
	}


	public String action(CustomOssServiceVO req) {
		String sError = "";

		try {
			// project server
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
			ServerIF serverIF = AbstractFactory.getServerIF(req.getProjectName(),cloudVo);
			serverIF.actionServer(req.getVmUuid(), req.getAction());
			return "1";
		} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
			log.error(e.getMessage());
			sError = e.getMessage();
		} 
		return sError;
	}


	public String catalogueVmlist(CustomOssServiceVO req) {
		List<CustomOssServiceVO> lists = dao.list(req);
		int recordsTotal = dao.listTot(req).size();
		
//		int recordsTotal = lists.size();
		int recordsFiltered = recordsTotal;
		String sError = "";
	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();
	        
	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("error", sError);
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));
	        
	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	        log.error(e.getMessage());
	    }
		return "";
	}


	public List<CustomOssServiceVO> excel(CustomOssServiceVO req) {
		List<CustomOssServiceVO> list = new LinkedList<CustomOssServiceVO>();

		try {
			List<CustomOssServiceVO> lists = dao.listTot(req);
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
			ServerIF serverIF = AbstractFactory.getServerIF(req.getProjectName(),cloudVo);
			List<Server> serverlists = serverIF.getServers();
			for (CustomOssServiceVO vo : lists) {
				for (Server obj : serverlists) {
					if(vo.getVmUuid().equals(obj.getId())){
						for(String sKey : obj.getAddresses().keySet()){
							if(sKey.lastIndexOf("_mgt_net") > 0){
								vo.setIpAddr(obj.getAddresses().get(sKey).get(0).getAddr());
								break;
							}else{
								vo.setIpAddr(obj.getAddresses().get(sKey).get(0).getAddr());
							}
						}
						vo.setStatus(obj.getStatus());
						vo.setPower(aPower[obj.getOS_EXT_STS_power_state()]);
						break;
					}
				}
				list.add(vo);
			}
		
		} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
			log.error(e.getMessage());
	    } catch (Exception e) {
	    	log.error(e.getMessage());
		}
		return list;
	}	
	
	// 프로젝트 서비스 상세	
	public String serviceDetail(CustomOssServiceVO req) {
		List<CustomOssServiceVO> lists = dao.serviceDetailList(req);
		int recordsTotal = dao.serviceDetailListTot(req).size();
		
//		int recordsTotal = lists.size();
		int recordsFiltered = recordsTotal;
		String sError = "";
	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();
	        
	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("error", sError);
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));
	        
	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}
	
	public List<CustomOssServiceVO> getServiceList(CustomOssServiceVO req) {
		return dao.getServiceList(req);
	}
	
	
	// 프로젝트 서비스 상세	
	public String mbrServiceDetail(CustomOssServiceVO req) {
		List<CustomOssServiceVO> lists = dao.mbrServiceDetailList(req);
		int recordsTotal = dao.mbrServiceDetailListTot(req).size();
		
		int recordsFiltered = recordsTotal;
		String sError = "";
	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();
	        
	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("error", sError);
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));
	        
	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}	
}
