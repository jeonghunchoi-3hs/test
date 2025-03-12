package com.ivucenter.cloud.portal.oss.subnet;

import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
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
import com.ivucenter.cloud.api.openstack.interfaces.SubnetIF;
import com.ivucenter.cloud.api.openstack.object.HostRoute;
import com.ivucenter.cloud.api.openstack.object.Subnet;
import com.ivucenter.cloud.api.openstack.object.SubnetAllocationPool;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author 박진우
 *
 */
@Slf4j
@Service
public class OssSubnetService{
	
	@Autowired
	private OssCloudService ossCloudService;
	
	public String list(CustomOssSubnetVO req) {
		
		Assert.notNull(req.getCloudId(), "");		
		Assert.notNull(req.getProjectName(), "");
		Assert.notNull(req.getNetworkId(), "");
		
		int recordsTotal = 0;
		int recordsFiltered = 0;
		List<CustomOssSubnetVO> list = new LinkedList<CustomOssSubnetVO>();
		String sError = "";
		
		try {
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
			SubnetIF subnetIF = AbstractFactory.getSubnetIF(req.getProjectName(),cloudVo);
			List<Subnet> lists = subnetIF.getSubnets(req.getNetworkId());
		    recordsTotal = lists.size();
		    recordsFiltered = recordsTotal;
			
			for (Subnet subnet : lists){
				list.add(mappingApiToPotal(subnet));
			}
			
		} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
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
	        jsonResponse.add("data", gson.toJsonTree(list));
	        
	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	log.error(e.getMessage());
	    }
		return "";
	}
		
	public CustomOssSubnetVO detail(CustomOssSubnetVO req) {
		
		Assert.notNull(req.getCloudId(), "");
		Assert.notNull(req.getProjectName(), "");
		Assert.notNull(req.getSubnetId(), "");
		
		String sError = "";		
		try {
			// subnet list
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());			
			SubnetIF subnetIF = AbstractFactory.getSubnetIF(req.getProjectName(),cloudVo);
			Subnet lists = subnetIF.getSubnet(req.getSubnetId());
			
			return mappingApiToPotal(lists);
			
		} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
			log.error(e.getMessage());
			sError = e.getMessage();
		} 
		req.setError(sError);
		return req;
	}
	
	public CustomOssSubnetVO detail2(CustomOssSubnetVO req) {
		
		Assert.notNull(req.getCloudId(), "");
		Assert.notNull(req.getProjectName(), "");
		Assert.notNull(req.getSubnetId(), "");
		
		String sError = "";
		
		try {
			// subnet list
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
			SubnetIF subnetIF = AbstractFactory.getSubnetIF(req.getProjectName(),cloudVo);
			Subnet lists = subnetIF.getSubnet(req.getSubnetId());
			
			return mappingApiToPotal2(lists);
			
		} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
			log.error(e.getMessage());
			sError = e.getMessage();
		} 
		req.setError(sError);
		return req;
	}
	
	
	public String insert(CustomOssSubnetVO req) {
		
		Assert.notNull(req.getCloudId(), "");
		Assert.notNull(req.getProjectName(), "");
		
		String sError = "";
		
		try {
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
			SubnetIF subnetIF = AbstractFactory.getSubnetIF(req.getProjectName(),cloudVo);
			subnetIF.createSubnet(mappingPotalToApi(req));
			
			return "1";
			
		} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
			log.error(e.getMessage());
			sError = e.getMessage();
		} 
		return sError;
	}
	
	public String update(CustomOssSubnetVO req) {
		
		Assert.notNull(req.getCloudId(), "");
		Assert.notNull(req.getProjectName(), "");
		
		String sError = "";		
		try {
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
			SubnetIF subnetIF = AbstractFactory.getSubnetIF(req.getProjectName(),cloudVo);
			subnetIF.updateSubnet(mappingPotalToApi(req));
			
			return "1";			
		} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
			log.error(e.getMessage());
			sError = e.getMessage();
		} 
		return sError;
	}

	public String delete(CustomOssSubnetVO req) {
		
		Assert.notNull(req.getCloudId(), "");
		Assert.notNull(req.getProjectName(), "");
		
		String sError = "";
		
		try {
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
			SubnetIF subnetIF = AbstractFactory.getSubnetIF(req.getProjectName(),cloudVo);
			subnetIF.deleteSubnet(req.getSubnetId());
			
			return "1";
			
		} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
			log.error(e.getMessage());
			sError = e.getMessage();
		} 
		return sError;
	}

	/// internal functions	
	// api 응답 데이터 변환
	private CustomOssSubnetVO mappingApiToPotal(Subnet subnet){
		
		CustomOssSubnetVO vo = new CustomOssSubnetVO();
		vo.setSubnetName(subnet.getName().toLowerCase());
		vo.setSubnetId(subnet.getId());
		vo.setCidr(subnet.getCidr());
		vo.setIpVersion(subnet.getIp_version());
		vo.setGatewayIp(subnet.getGateway_ip());
		vo.setEnableDhcp(subnet.isEnable_dhcp());

		String sDnsNameservers = "";
		for(String obj :subnet.getDns_nameservers()){
			sDnsNameservers += obj+"\n";
		}
		vo.setDnsNameservers(StringUtils.replaceChars(sDnsNameservers, "[]", null));
		
		String sAllocationPools = "";
		for(SubnetAllocationPool obj :subnet.getAllocation_pools()){
			sAllocationPools += obj.getStart()+","+obj.getEnd()+"\n";
		}
		vo.setAllocationPools(sAllocationPools);
		
		String sHostRoutes = "";
		for(HostRoute obj :subnet.getHost_routes()){
			sHostRoutes += obj.getDestination()+","+obj.getNexthop()+"\n";
		}
		vo.setHostRoutes(sHostRoutes);
		
		return vo;
	}
	
	// api 응답 데이터 변환
	private CustomOssSubnetVO mappingApiToPotal2(Subnet subnet){
		
		CustomOssSubnetVO vo = new CustomOssSubnetVO();
		vo.setSubnetName(subnet.getName().toLowerCase());
		vo.setSubnetId(subnet.getId());
		vo.setCidr(subnet.getCidr());
		vo.setIpVersion(subnet.getIp_version());
		vo.setGatewayIp(subnet.getGateway_ip());
		vo.setEnableDhcp(subnet.isEnable_dhcp());

		String sDnsNameservers = "";
		for(String obj :subnet.getDns_nameservers()){
			sDnsNameservers += "<li>"+obj+"</li>";
		}
		vo.setDnsNameservers(StringUtils.replaceChars(sDnsNameservers, "[]", null));
		
		String sAllocationPools = "";
		for(SubnetAllocationPool obj :subnet.getAllocation_pools()){
			sAllocationPools += "<li>"+obj.getStart()+" ~ "+obj.getEnd()+"</li>";
		}
		
		vo.setAllocationPools(sAllocationPools);
		
		String sHostRoutes = "";
		for(HostRoute obj :subnet.getHost_routes()){
			sHostRoutes += "<li>"+obj.getDestination()+","+obj.getNexthop()+"</li>";
		}
		vo.setHostRoutes(sHostRoutes);
		
		return vo;
	}
	
	// insert | update 시 변환
	private Subnet mappingPotalToApi(CustomOssSubnetVO req){
		Subnet subnet = new Subnet();
		
		subnet.setNetwork_id(req.getNetworkId());
		subnet.setName(req.getSubnetName());
		subnet.setId(req.getSubnetId());
		subnet.setCidr(req.getCidr());
		subnet.setIp_version(req.getIpVersion());
		
		if(StringUtils.isNotEmpty(req.getGatewayIpBak())){
			if(!req.getGatewayIp().equals(req.getGatewayIpBak())){
				subnet.setGateway_ip(req.getGatewayIp());
			}	
		}
		subnet.setEnable_dhcp(req.getEnableDhcp());

		if(!req.getDnsNameservers().equals("")){
			List<String> sDns_nameservers = new LinkedList<String>();
			for(String str : req.getDnsNameservers().split("\n")){
				sDns_nameservers.add(str);
			}
			subnet.setDns_nameservers(sDns_nameservers);	
		}

		if(!req.getAllocationPools().equals("")){
			List<SubnetAllocationPool> sAllocationPools = new LinkedList<SubnetAllocationPool>();
			for(String str : req.getAllocationPools().split("\n")){
				SubnetAllocationPool vo1 = new SubnetAllocationPool();
				if(str.split(",").length == 2){
					vo1.setStart(str.split(",")[0]);
					vo1.setEnd(str.split(",")[1]);
					sAllocationPools.add(vo1);	
				}
			}
			subnet.setAllocation_pools(sAllocationPools);			
		}

		if(!req.getHostRoutes().equals("")){
			List<HostRoute> sHostRoutes = new LinkedList<HostRoute>();
			for(String str : req.getHostRoutes().split("\n")){
				HostRoute vo2 = new HostRoute();
				if(str.split(",").length == 2){
					vo2.setDestination(str.split(",")[0]);
					vo2.setNexthop(str.split(",")[1]);
					sHostRoutes.add(vo2);	
				}
			}
			subnet.setHost_routes(sHostRoutes);			
		}
		
		return subnet;
	}	
}
