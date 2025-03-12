package com.ivucenter.cloud.batch.metering;

import java.util.Date;
import java.util.HashMap;
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
import com.ivucenter.cloud.api.openstack.interfaces.FlavorIF;
import com.ivucenter.cloud.api.openstack.object.Flavor;
import com.ivucenter.cloud.api.openstack.object.Server;
import com.ivucenter.cloud.api.vRealize.interfaces.vraAbstractFactory;
import com.ivucenter.cloud.api.vRealize.interfaces.vraFlavorIF;
import com.ivucenter.cloud.api.vRealize.interfaces.vraServerIF;
import com.ivucenter.cloud.api.vRealize.object.vraFlavor;
import com.ivucenter.cloud.batch.entity.BatchOssProjectVO;
import com.ivucenter.cloud.batch.entity.BatchOssVmVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SyncDeletedVmWriter implements ItemWriter<Server> {

	private final String selectProjectById 	= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectProjectById";
	private final String selectVmById 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectVmById";
	private final String insertOssVm 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertOssVm";
	private final String updateOssVm 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.updateOssVm";
//	private final String insertBillChargeVm = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.insertBillChargeVm";

    @Setter
	private SqlSessionFactory sqlSessionFactory;

    @Setter
	private Map<String, Object> parameterValues;

	private SqlSessionTemplate sqlSessionTemplate;

	@Autowired
	private OssCloudService ossCloudService;

	class InCloudList {
    	private List<CustomOssCloudVO> list = null;
    	public void setCloudList(List<CustomOssCloudVO> inList) { this.list = inList; }
    	public CustomOssCloudVO getCloudVo(String cloudId) {
    		for(CustomOssCloudVO vo : this.list) {
    			if(vo.getCloudId().equals(cloudId)) { return vo; }
    		}
			return null;
    	}
    }
    private InCloudList inCloudList = null;


	@Override
	public void write(List<? extends Server> items) throws Exception {

		this.inCloudList = new InCloudList();
		this.inCloudList.setCloudList(ossCloudService.getCloudList());

		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);
		this.sqlSessionTemplate.clearCache();

        for (Server item : items) {
        	//포탈에 등록되어진 프로젝트가 존재하는 서버들에 한해서 동기화를 하도록 한다.
        	BatchOssProjectVO paramProjectVO = new BatchOssProjectVO();
        	String projectId = item.getTenant_id();
        	paramProjectVO.setProjectId(projectId);
        	BatchOssProjectVO project = this.sqlSessionTemplate.selectOne(selectProjectById, paramProjectVO);

        	if (project != null) { 	//포탈에 프로젝트가 등록되어 있다면
        		//가상서버 정보 등록
        		setOssVm(item , this.inCloudList.getCloudVo(project.getCloudId()));
        	} else {
            	log.debug("[SKIPPED] " + item.toString());
        	}
        	//sqlSessionTemplate.insert(insertBillChargeVm, item);
        }
	}

	/***************************************************
	 * setOssVm : 가상서버 정보를 등록한다.
	 * @param server
	 * @throws Exception
	 ***************************************************/
	private void setOssVm(Server server, CustomOssCloudVO cloudVo) throws Exception {
    	String serverId = server.getId();
    	String serverName = server.getName();
		String projectId = server.getTenant_id();
		Date createdDatetime = new Date();	//created=2017-06-08T10:26:52Z
		Date deletedDatetime = new Date();

		BatchOssVmVO paramVmVO = new BatchOssVmVO();
		paramVmVO.setVmUuid(serverId);
		BatchOssVmVO selectVm = this.sqlSessionTemplate.selectOne(selectVmById, paramVmVO);

		////////////////////////////////////
		///// flavor 정보 가져오기
		////////////////////////////////////
		int vcpus = 0;
		int memGb = 0;
		int diskGb = 0;
		if(cloudVo.getCloudType().equals("openstack")) {
			createdDatetime = DateUtils.convertUtcToDate(server.getCreated());
			deletedDatetime = DateUtils.convertUtcToDate(server.getUpdated());
			FlavorIF flavorIf = AbstractFactory.getFlavorIF(cloudVo);
			Flavor flavor = null;
			try {
				flavor = flavorIf.getFlavor(server.getFlavor().getId());
			} catch (InvaildOpenStackException | NotSupportGatewayException | NotConnectGatewayException e) {}
			if (flavor != null) {
				vcpus = flavor.getVcpus();
				memGb = flavor.getRam()/1024;
			}
		} else if(cloudVo.getCloudType().equals("vmware")) {
			createdDatetime = DateUtils.convertStringToDate(server.getCreated(), "Asia/Seoul", "yyyy-MM-dd'T'HH:mm:ss");
			deletedDatetime = DateUtils.convertStringToDate(server.getUpdated(), "Asia/Seoul", "yyyy-MM-dd'T'HH:mm:ss");
			vraServerIF serverIF = vraAbstractFactory.getServerIF(cloudVo);
			vraFlavorIF flavorIF = vraAbstractFactory.getFlavorIF(cloudVo);
			List<vraFlavor> flavors = flavorIF.getFlavors().getContent();
			Map<String, vraFlavor> flavorMap = new HashMap<String, vraFlavor>();
			for(vraFlavor flavor : flavors) {
				flavorMap.putAll(flavor.getMapping());
			}
			vraFlavor flavor = flavorMap.get(server.getFlavor().getId());
			vcpus += Integer.parseInt(flavor.getCpuCount());
			memGb += Integer.parseInt(flavor.getMemoryInMB()) / 1024;
		}

		//////////////////////////////////
		/////가상서버 정보 등록 및 수정
		//////////////////////////////////

		if (selectVm == null) {	// 서버가 기존에 존재하지 않다면
			insertVm(serverId, serverName, projectId, vcpus, memGb, diskGb, createdDatetime, deletedDatetime);
		} else {
    		//기존에 서버가 존재한다면 생성일자를 등록되어 있지 않다면 변경한다.
    		if (selectVm.getDeleteDatetime() == null) {
    			updateVm(selectVm, serverName, vcpus, memGb, diskGb, createdDatetime, deletedDatetime);
    		}
		}
	}

	/***************************************************
	 * insertVm : 가상서버를 신규로 등록한다.
	 ***************************************************/
	private void insertVm(String serverId, String serverName, String projectId, int vcpus, int memGb, int diskGb, Date createdDatetime, Date deletedDatetime) {
		//기존에 서버가 존재하지 않다면 신규로 등록한다.
		BatchOssVmVO insertVm = new BatchOssVmVO();

		insertVm.setVmUuid(serverId);
		insertVm.setProjectId(projectId);
		insertVm.setHostname(serverName);
		insertVm.setHostnameAlias(serverName);
		insertVm.setVcpus(vcpus);
		insertVm.setMemGb(memGb);
		insertVm.setDiskGb(diskGb);
		insertVm.setVmProductSeq(null);
		insertVm.setOsProductSeq(null);
		insertVm.setDescription(null);
		insertVm.setCreateDatetime(createdDatetime);
		insertVm.setExpireDatetime(deletedDatetime);
		insertVm.setDeleteDatetime(deletedDatetime);
		insertVm.setRegDatetime(new Date());
		insertVm.setRegUserId("SYNC_BATCH");
		insertVm.setModDatetime(null);
		insertVm.setModUserId(null);
		insertVm.setDelFlag("Y");
		insertVm.setHourlyFlag("N");

		this.sqlSessionTemplate.insert(insertOssVm, insertVm);
	}


	/***************************************************
	 * updateVm : 가상서버 정보를 수정한다.
	 ***************************************************/
	private void updateVm(BatchOssVmVO selectVm, String serverName, int vcpus, int memGb, int diskGb, Date createdDatetime, Date deletedDatetime) {
		BatchOssVmVO updateVm = selectVm;

		//생성일자
		if (selectVm.getCreateDatetime() == null) updateVm.setCreateDatetime(createdDatetime);

		//해지일자, 삭제일자, 삭제여부
		if (selectVm.getExpireDatetime() == null) updateVm.setExpireDatetime(deletedDatetime);
		if (selectVm.getDeleteDatetime() == null) updateVm.setDeleteDatetime(deletedDatetime);
		if (selectVm.getDelFlag() == null || "N".equals(selectVm.getDelFlag())) updateVm.setDelFlag("Y");

		updateVm.setHostname(serverName);
		updateVm.setVcpus(vcpus);
		updateVm.setMemGb(memGb);
		updateVm.setDiskGb(diskGb);

		this.sqlSessionTemplate.update(updateOssVm, updateVm);
	}

}
