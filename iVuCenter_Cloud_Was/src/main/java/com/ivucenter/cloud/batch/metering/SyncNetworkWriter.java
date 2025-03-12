package com.ivucenter.cloud.batch.metering;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Autowired;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.NetworkIF;
import com.ivucenter.cloud.api.openstack.interfaces.PortIF;
import com.ivucenter.cloud.api.openstack.interfaces.SubnetIF;
import com.ivucenter.cloud.api.openstack.object.FixedIPS;
import com.ivucenter.cloud.api.openstack.object.Network;
import com.ivucenter.cloud.api.openstack.object.Port;
import com.ivucenter.cloud.api.openstack.object.Subnet;
import com.ivucenter.cloud.api.openstack.object.SubnetAllocationPool;
import com.ivucenter.cloud.api.vRealize.interfaces.vraAbstractFactory;
import com.ivucenter.cloud.api.vRealize.interfaces.vraNetworkIF;
import com.ivucenter.cloud.api.vRealize.interfaces.vraServerIF;
import com.ivucenter.cloud.api.vRealize.object.vraComputeNetwork;
import com.ivucenter.cloud.api.vRealize.object.vraContent;
import com.ivucenter.cloud.api.vRealize.object.vraFabricNetworkVsphere;
import com.ivucenter.cloud.api.vRealize.object.vraNetwork;
import com.ivucenter.cloud.api.vRealize.object.vraNetworkInterfaces;
import com.ivucenter.cloud.api.vRealize.object.vraNetworks;
import com.ivucenter.cloud.api.vRealize.object.vraServer;
import com.ivucenter.cloud.batch.entity.BatchOssNetworkVO;
import com.ivucenter.cloud.batch.entity.BatchOssPortVO;
import com.ivucenter.cloud.batch.entity.BatchOssProjectVO;
import com.ivucenter.cloud.batch.entity.BatchOssSubnetVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SyncNetworkWriter implements ItemWriter<BatchOssProjectVO> {

	private final String selectOssNetworkById 	= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectOssNetworkById";
	private final String selectOssSubnetById 	= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectOssSubnetById";
	private final String selectOssPortById 	    = "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectOssPortById";
	private final String updateOssNetwork 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.updateOssNetwork";
	private final String insertOssNetwork 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertOssNetwork";
	private final String updateOssSubnet 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.updateOssSubnet";
	private final String insertOssSubnet 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertOssSubnet";
	private final String updateOssPort 			= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.updateOssPort";
	private final String insertOssPort 			= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertOssPort";
	private final String updateOssPortWithNoDevice = "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.updateOssPortWithNoDevice";

    @Setter
	private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
    
    @Autowired
	private OssCloudService ossCloudService;

	private SqlSessionTemplate sqlSessionTemplate = null;
	@Override
	public void write(List<? extends BatchOssProjectVO> items) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);
		for (BatchOssProjectVO item : items) {
			String projectName = item.getProjectName();
			if (projectName.equals("admin") && item.getCloudType().equals("openstack")) {
				CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(item.getCloudId());
				setNetworks(projectName, cloudVo);
        		setSubnets(projectName, cloudVo);
        		setPorts(cloudVo);
        		break;
			}
		}
		List<CustomOssCloudVO> lists = ossCloudService.getCloudList();
		for (CustomOssCloudVO list : lists) {
			if(list.getCloudType().equals("vmware")) {
				setVraNetworks(list);
				setVraPorts(list);
				setVraSubnets(list);
			}
		}
	}
	
	private void setVraNetworks(CustomOssCloudVO cloudVo) throws Exception {
		List<vraNetwork> networks = null;
		vraNetworkIF networkIF = vraAbstractFactory.getNetworkIF(cloudVo);
		try {
			networks = networkIF.getNetworks();
		} catch (InvaildOpenStackException | NotSupportGatewayException | NotConnectGatewayException e) {
			log.info(e.getMessage());
		}
		
		if (networks != null) {
			for(vraNetwork network : networks) {
				if(!network.getName().equals("OA-Backup")) {
					String projectId = cloudVo.getApiAlarmServer();
					String networkId = network.getName();
					String networkName = network.getName();
					BatchOssNetworkVO paramNetworkVO = new BatchOssNetworkVO();
					paramNetworkVO.setNetworkId(networkId);
					BatchOssNetworkVO selectNetworkVO = this.sqlSessionTemplate.selectOne(selectOssNetworkById, paramNetworkVO);
					if (selectNetworkVO != null) {
						BatchOssNetworkVO updateNetworkVO = selectNetworkVO;
						updateNetworkVO.setNetworkName(networkName);
						updateNetworkVO.setProjectId(projectId);
						updateNetworkVO.setCloudId(cloudVo.getCloudId());
						this.sqlSessionTemplate.update(updateOssNetwork, updateNetworkVO);
					} else {
						BatchOssNetworkVO insertNetworkVO = new BatchOssNetworkVO();
	
						insertNetworkVO.setNetworkId(networkId);
						insertNetworkVO.setNetworkName(networkName);
						insertNetworkVO.setNetworkAlias(networkName);
						insertNetworkVO.setProjectId(projectId);
						insertNetworkVO.setRegDatetime(new Date());
						insertNetworkVO.setRegUserId("SYSTEM_SYNC");
						insertNetworkVO.setModDatetime(null);
						insertNetworkVO.setModUserId(null);
						insertNetworkVO.setDeleteFlag("N");
						insertNetworkVO.setWorkKind(null);
						insertNetworkVO.setWorkNetKind(null);
						insertNetworkVO.setCloudId(cloudVo.getCloudId());	
						this.sqlSessionTemplate.insert(insertOssNetwork, insertNetworkVO);
					}
				}
			}
		}
	}

	private void setNetworks(String projectName, CustomOssCloudVO cloudVo) throws Exception {

		List<Network> networks = null;
		NetworkIF networkIf = AbstractFactory.getNetworkIF(projectName, cloudVo);
		try {
			networks = networkIf.getNetworks();
		} catch (InvaildOpenStackException | NotSupportGatewayException | NotConnectGatewayException e) {
			log.info(e.getMessage());
		}

		if (networks != null) {
			for (Network network : networks) {
				//오픈스택에서 프로젝트의 네트워크 정보를 읽어온다.
				String projectId = network.getProject_id();
				String networkId = network.getId();
				String networkName = network.getName();
	
				//포탈DB에서 기존 네트워크 등록 상태 확인
				BatchOssNetworkVO paramNetworkVO = new BatchOssNetworkVO();
				paramNetworkVO.setNetworkId(networkId);
	
				BatchOssNetworkVO selectNetworkVO = this.sqlSessionTemplate.selectOne(selectOssNetworkById, paramNetworkVO);
				if (selectNetworkVO != null) {
					BatchOssNetworkVO updateNetworkVO = selectNetworkVO;
					updateNetworkVO.setNetworkName(networkName);
					updateNetworkVO.setProjectId(projectId);
					updateNetworkVO.setCloudId(cloudVo.getCloudId());
					this.sqlSessionTemplate.update(updateOssNetwork, updateNetworkVO);
				} else {
					BatchOssNetworkVO insertNetworkVO = new BatchOssNetworkVO();
	
					insertNetworkVO.setNetworkId(networkId);
					insertNetworkVO.setNetworkName(networkName);
					insertNetworkVO.setNetworkAlias(networkName);
					insertNetworkVO.setProjectId(projectId);
					insertNetworkVO.setRegDatetime(new Date());
					insertNetworkVO.setRegUserId("SYSTEM_SYNC");
					insertNetworkVO.setModDatetime(null);
					insertNetworkVO.setModUserId(null);
					insertNetworkVO.setDeleteFlag("N");
					insertNetworkVO.setWorkKind(null);
					insertNetworkVO.setWorkNetKind(null);
					insertNetworkVO.setCloudId(cloudVo.getCloudId());	
					this.sqlSessionTemplate.insert(insertOssNetwork, insertNetworkVO);
				}
			}
		}
	}
	
	private void setVraSubnets(CustomOssCloudVO cloudVo) throws Exception {
		vraNetworkIF networkIF = vraAbstractFactory.getNetworkIF(cloudVo);
		List<vraFabricNetworkVsphere> FabricNetworks = networkIF.getFabricNetworksVsphere().getContent();
		
		for(vraFabricNetworkVsphere fabricNetwork : FabricNetworks) {
			if(fabricNetwork.getCidr() != null) {
				String subnetId = fabricNetwork.getId();
				BatchOssSubnetVO paramSubnetVO = new BatchOssSubnetVO();
				paramSubnetVO.setSubnetId(subnetId);
				
				BatchOssSubnetVO selectSubnetVO = this.sqlSessionTemplate.selectOne(selectOssSubnetById, paramSubnetVO);
				if (selectSubnetVO != null) {
					BatchOssSubnetVO updateSubnetVO = selectSubnetVO;
					updateSubnetVO.setSubnetName(fabricNetwork.getName());
					updateSubnetVO.setNetworkId(fabricNetwork.getName());
	
	
					updateSubnetVO.setAllocationPools("");
					updateSubnetVO.setSubnetCidr(fabricNetwork.getCidr());
					updateSubnetVO.setEnableDhcp(true);
					updateSubnetVO.setGatewayIp(fabricNetwork.getDefaultGateway());
					if(fabricNetwork.getDnsServerAddresses().length != 0) {
						updateSubnetVO.setDnsNameservers(fabricNetwork.getDnsServerAddresses()[0]);
					}
					this.sqlSessionTemplate.update(updateOssSubnet, updateSubnetVO);
				} else {
					BatchOssSubnetVO insertSubnetVO = new BatchOssSubnetVO();
	
					insertSubnetVO.setSubnetId(subnetId);
					insertSubnetVO.setSubnetName(fabricNetwork.getName());
					insertSubnetVO.setNetworkId(fabricNetwork.getName());
	
					insertSubnetVO.setAllocationPools("");
					insertSubnetVO.setSubnetCidr(fabricNetwork.getCidr());
					insertSubnetVO.setEnableDhcp(true);
					insertSubnetVO.setGatewayIp(fabricNetwork.getDefaultGateway());
					if(fabricNetwork.getDnsServerAddresses().length != 0) {
						insertSubnetVO.setDnsNameservers(fabricNetwork.getDnsServerAddresses()[0]);
					}
	
					insertSubnetVO.setRegDatetime(new Date());
					insertSubnetVO.setRegUserId("SYSTEM_SYNC");
					insertSubnetVO.setModDatetime(null);
					insertSubnetVO.setModUserId(null);
					insertSubnetVO.setDeleteFlag("N");
	
					this.sqlSessionTemplate.insert(insertOssSubnet, insertSubnetVO);
				}
			}
		}
	}
	private void setSubnets(String projectName, CustomOssCloudVO cloudVo) throws Exception {
	    
		List<Subnet> subnets = null;
		SubnetIF subnetIf = AbstractFactory.getSubnetIF(projectName, cloudVo);
		try {
			subnets = subnetIf.getSubnets();
		} catch (InvaildOpenStackException | NotSupportGatewayException | NotConnectGatewayException e) {
			log.error(e.getMessage());
		}

		if (subnets != null) {
			for (Subnet tmpsubnet : subnets) {
				//오픈스택에서 네트워크  Subnet 정보를 읽어온다.
				String subnetId = tmpsubnet.getId();
	
				//포탈DB에서 기존 서브넷 등록 상태 확인
				BatchOssSubnetVO paramSubnetVO = new BatchOssSubnetVO();
				paramSubnetVO.setSubnetId(subnetId);
	
				BatchOssSubnetVO selectSubnetVO = this.sqlSessionTemplate.selectOne(selectOssSubnetById, paramSubnetVO);
				if (selectSubnetVO != null) {
					BatchOssSubnetVO updateSubnetVO = selectSubnetVO;
					updateSubnetVO.setSubnetName(tmpsubnet.getName());
					updateSubnetVO.setNetworkId(tmpsubnet.getNetwork_id());
	
					List<SubnetAllocationPool> subnetAllocationPools =  tmpsubnet.getAllocation_pools();
					StringBuffer subnetAllocationPoolStr = new StringBuffer();
					int i = 0;
					for (SubnetAllocationPool subnetAllocationPool : subnetAllocationPools) {
						subnetAllocationPoolStr.append(subnetAllocationPool.getStart() + "-" + subnetAllocationPool.getEnd());
						if ( i++ != subnetAllocationPools.size() - 1) {
							subnetAllocationPoolStr.append(",");
						}
					}
	
					updateSubnetVO.setAllocationPools(subnetAllocationPoolStr.toString());
					updateSubnetVO.setSubnetCidr(tmpsubnet.getCidr());
					updateSubnetVO.setEnableDhcp(tmpsubnet.isEnable_dhcp());
					updateSubnetVO.setGatewayIp(tmpsubnet.getGateway_ip());
					updateSubnetVO.setDnsNameservers(tmpsubnet.getDns_nameservers().toString());
					this.sqlSessionTemplate.update(updateOssSubnet, updateSubnetVO);
				} else {
					BatchOssSubnetVO insertSubnetVO = new BatchOssSubnetVO();
	
					insertSubnetVO.setSubnetId(subnetId);
					insertSubnetVO.setSubnetName(tmpsubnet.getName());
					insertSubnetVO.setNetworkId(tmpsubnet.getNetwork_id());
	
					List<SubnetAllocationPool> subnetAllocationPools =  tmpsubnet.getAllocation_pools();
					StringBuffer subnetAllocationPoolStr = new StringBuffer();
					int i = 0;
					for (SubnetAllocationPool subnetAllocationPool : subnetAllocationPools) {
						subnetAllocationPoolStr.append(subnetAllocationPool.getStart() + "-" + subnetAllocationPool.getEnd());
						if ( i++ != subnetAllocationPools.size() - 1) {
							subnetAllocationPoolStr.append(",");
						}
					}
	
					insertSubnetVO.setAllocationPools(subnetAllocationPoolStr.toString());
					insertSubnetVO.setSubnetCidr(tmpsubnet.getCidr());
					insertSubnetVO.setEnableDhcp(tmpsubnet.isEnable_dhcp());
					insertSubnetVO.setGatewayIp(tmpsubnet.getGateway_ip());
					insertSubnetVO.setDnsNameservers(tmpsubnet.getDns_nameservers().toString());
	
					insertSubnetVO.setRegDatetime(new Date());
					insertSubnetVO.setRegUserId("SYSTEM_SYNC");
					insertSubnetVO.setModDatetime(null);
					insertSubnetVO.setModUserId(null);
					insertSubnetVO.setDeleteFlag("N");
	
					this.sqlSessionTemplate.insert(insertOssSubnet, insertSubnetVO);
				}
			}
		}
	}
	
	private void setVraPorts(CustomOssCloudVO cloudVo) throws Exception {
		vraServerIF vraServerIF = vraAbstractFactory.getServerIF(cloudVo);
		vraNetworkIF networkIF = vraAbstractFactory.getNetworkIF(cloudVo);
		List<vraContent> deploys = vraServerIF.getServers("").getContent();
		for(vraContent deploy : deploys) {
			vraServer depInfo = vraServerIF.getDepInfo(deploy.getId());
			List<vraContent> contents = depInfo.getContent();
			for(vraContent content : contents) {
				if(content.getType().equals("Cloud.vSphere.Machine")) {
					List<vraNetworks> networkList = content.getProperties().getNetworks();
					for(vraNetworks network : networkList) {
						String portId = network.getName();
						String networkAry[] = network.getId().split("/");
						String networkId = networkAry[3];
						
						
						
						vraComputeNetwork vmInfo = networkIF.getComputeNetworks(network.getNetwork());
						
						BatchOssPortVO paramPortVO = new BatchOssPortVO();
						String subnetId = null;
						vraNetworkInterfaces networkInterfaces = null;
	                       if(vmInfo !=null) {
	                    	   
	                    	   String subnetAry[] = networkIF.getComputeNetworks(network.getNetwork()).getSubnetLink().split("/");
	                    	   subnetId = subnetAry[3];
	                    	   networkInterfaces = networkIF.getNetworks(content.getId(), networkId);
	                    	   paramPortVO.setPortId(portId);
	                    	   
	                       }
                       BatchOssPortVO selectPortVO = this.sqlSessionTemplate.selectOne(selectOssPortById, paramPortVO);
						
						if (selectPortVO != null) {
							BatchOssPortVO updatePortVO = selectPortVO;
							updatePortVO.setNetworkId(portId);
							updatePortVO.setPortName(portId);
							updatePortVO.setMacAddress(network.getMac_address());
							updatePortVO.setProjectId(deploy.getProjectId());
							updatePortVO.setDeviceId(deploy.getId());
							updatePortVO.setFixedIps(network.getAddress());
							updatePortVO.setStatus("ACTIVE");
							updatePortVO.setSubnetId(subnetId);
							this.sqlSessionTemplate.update(updateOssPort, updatePortVO);
						} else {
							BatchOssPortVO insertPortVO = new BatchOssPortVO();
							
							insertPortVO.setPortName(portId);
							insertPortVO.setFixedIps(network.getAddress());
							insertPortVO.setMacAddress(network.getMac_address());
							insertPortVO.setProjectId(deploy.getProjectId());
							insertPortVO.setNetworkId(portId);
							insertPortVO.setDeviceId(deploy.getId());
							insertPortVO.setStatus("ACTIVE");
							insertPortVO.setRegDatetime(new Date());
							insertPortVO.setRegUserId("SYSTEM_SYNC");
							insertPortVO.setModDatetime(null);
							insertPortVO.setModUserId(null);
							insertPortVO.setDeleteFlag("N");
							
							if(networkInterfaces != null) {
								insertPortVO.setDeviceOwner(networkInterfaces.getOwner());
								insertPortVO.setBindingHostId(networkInterfaces.getExternalRegionId());
							}
							insertPortVO.setPortId(networkId);
							insertPortVO.setSubnetId(subnetId);
							
							this.sqlSessionTemplate.insert(insertOssPort, insertPortVO);
						}
					}
				}
			}
		}
	}
	private void setPorts(CustomOssCloudVO cloudVo) throws Exception {

		List<Port> portss = null;
		PortIF portIf = AbstractFactory.getPortIF(cloudVo);
		try {
			portss = portIf.getPorts();
		} catch (InvaildOpenStackException | NotSupportGatewayException | NotConnectGatewayException e) {
			log.error(e.getMessage());
		}

		if (portss != null) {
			for (Port tmpport : portss) {
				//오픈스택에서 네트워크 포트 정보를 읽어온다.
				String portId = tmpport.getId();
	
				//포탈DB에서 기존 포트 등록 상태 확인
				BatchOssPortVO paramPortVO = new BatchOssPortVO();
				paramPortVO.setPortId(portId);
	
				String ipAddress = null;
				String subnetId = null;
				BatchOssPortVO selectPortVO = this.sqlSessionTemplate.selectOne(selectOssPortById, paramPortVO);
				if (selectPortVO != null) {
					BatchOssPortVO updatePortVO = selectPortVO;
					updatePortVO.setPortName(tmpport.getName());
	
					List<FixedIPS> tmpIPs = tmpport.getFixed_ips();
					if (tmpIPs != null && tmpIPs.size() > 0  ) {
						updatePortVO.setFixedIps(tmpIPs.get(0).getIp_address());
						updatePortVO.setSubnetId(tmpIPs.get(0).getSubnet_id());
					}
	
					updatePortVO.setMacAddress(tmpport.getMac_address());
					updatePortVO.setProjectId(tmpport.getProject_id());
					updatePortVO.setNetworkId(tmpport.getNetwork_id());
					updatePortVO.setDeviceId(tmpport.getDevice_id());
					updatePortVO.setDeviceOwner(tmpport.getDevice_owner());
					updatePortVO.setBindingHostId(tmpport.getBinding_host_id());
					updatePortVO.setStatus(tmpport.getStatus());
	
					this.sqlSessionTemplate.update(updateOssPort, updatePortVO);
				} else {
	
					//포탈DB에서 기존 IP 주소로 등록 상태 확인
					List<FixedIPS> tmpIPs = tmpport.getFixed_ips();
					if (tmpIPs != null && tmpIPs.size() > 0  ) {
						ipAddress = tmpIPs.get(0).getIp_address();
						subnetId = tmpIPs.get(0).getSubnet_id();
					}
	
					BatchOssPortVO insertPortVO = new BatchOssPortVO();
	
					insertPortVO.setPortId(tmpport.getId());
	
					insertPortVO.setPortName(tmpport.getName());
	
					insertPortVO.setFixedIps(ipAddress);
					insertPortVO.setSubnetId(subnetId);
	
					insertPortVO.setMacAddress(tmpport.getMac_address());
					insertPortVO.setProjectId(tmpport.getProject_id());
					insertPortVO.setNetworkId(tmpport.getNetwork_id());
					insertPortVO.setDeviceId(tmpport.getDevice_id());
					insertPortVO.setDeviceOwner(tmpport.getDevice_owner());
					insertPortVO.setBindingHostId(tmpport.getBinding_host_id());
					insertPortVO.setStatus(tmpport.getStatus());
	
					insertPortVO.setRegDatetime(new Date());
					insertPortVO.setRegUserId("SYSTEM_SYNC");
					insertPortVO.setModDatetime(null);
					insertPortVO.setModUserId(null);
					insertPortVO.setDeleteFlag("N");
	
					this.sqlSessionTemplate.insert(insertOssPort, insertPortVO);
				}
			}
		}
		this.sqlSessionTemplate.update(updateOssPortWithNoDevice);
	}
}
