package com.ivucenter.cloud.batch.metering;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Autowired;

import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.VolumeIF;
import com.ivucenter.cloud.api.openstack.object.Volume;
import com.ivucenter.cloud.batch.entity.BatchOssDiskVO;
import com.ivucenter.cloud.batch.entity.BatchOssProductVO;
import com.ivucenter.cloud.batch.entity.BatchOssProjectVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SyncBlockDiskWriter implements ItemWriter<BatchOssDiskVO> {

	private final String selectProjectById 	= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectProjectById";
	private final String selectOssDiskById 	= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectOssDiskById";
	private final String selectItemByImageId= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectItemByImageId";
	private final String insertOssDisk 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertOssDisk";
	private final String updateOssDisk 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.updateOssDisk";
	private final String selectOssDiskList 	= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectOssDiskList";

    @Setter
	private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
	
	private SqlSessionTemplate sqlSessionTemplate = null;

	@Autowired
	private OssCloudService ossCloudService;

	@Override
	public void write(List<? extends BatchOssDiskVO> items) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);
		List<BatchOssDiskVO> OssDisks = this.sqlSessionTemplate.selectList(selectOssDiskList);
		ArrayList<String> list = new ArrayList<String>();
		for (BatchOssDiskVO item : items) {
        	//프로젝트가 존재하는 서버들에 대해 관리하도록 한다.
        	BatchOssProjectVO paramProjectVO = new BatchOssProjectVO();
        	paramProjectVO.setProjectId(item.getProjectId());
        	BatchOssProjectVO project = this.sqlSessionTemplate.selectOne(selectProjectById, paramProjectVO);
        	list.add(item.getDiskId());
        	if (project != null) { 	//해당 서버의 프로젝트가 등록되어 있다면
        		//기존 디스크에 등록되어 있지 않다면 신규로 등록
        		BatchOssDiskVO paramDiskVO = new BatchOssDiskVO();
        		paramDiskVO.setDiskId(item.getDiskId());
        		BatchOssDiskVO selectDiskVO = this.sqlSessionTemplate.selectOne(selectOssDiskById, paramDiskVO);
        		if (selectDiskVO == null) {		//디스크가 기존에 등록되어 있지 않다면
        			insertOssDisById(item);
        		} else {	//디스크가 기존에 등록되어 있다면
        			updateOssDiskById(item, selectDiskVO);
        		}
        	} else {	//회원사에 등록되어 있지 않은 프로젝트는 제외
            	log.debug("[SKIPPED (PROJECT NOT FOUND)] " + item.toString());
        	}
        }
		for (BatchOssDiskVO ossdisk : OssDisks) {
			if(!list.contains(ossdisk.getDiskId())) {
				ossdisk.setDelFlag("Y");
    			this.sqlSessionTemplate.update(updateOssDisk, ossdisk);
			}
		}
	}
	private void insertOssDisById(BatchOssDiskVO item) throws Exception {
		BatchOssDiskVO insertDiskVO = new BatchOssDiskVO();
		insertDiskVO.setCloudId(item.getCloudId());
		insertDiskVO.setDiskId(item.getDiskId());
		insertDiskVO.setProjectId(item.getProjectId());
		insertDiskVO.setVmUuid(item.getVmUuid());
		insertDiskVO.setDiskAlias(item.getDiskAlias());
		insertDiskVO.setSizeGb(item.getSizeGb());
		insertDiskVO.setDevice(item.getDevice());
		insertDiskVO.setCreateDatetime(item.getCreateDatetime());
		insertDiskVO.setExpireDatetime(item.getDeleteDatetime());	//해지일자=삭제일자
		insertDiskVO.setDeleteDatetime(item.getDeleteDatetime());
		insertDiskVO.setRegDatetime(new Date());
		insertDiskVO.setRegUserId("SYSTEM_SYNC");
		insertDiskVO.setModDatetime(null);
		insertDiskVO.setModUserId(null);
		insertDiskVO.setDelFlag((item.getDeleteDatetime() == null) ? "N":"Y");
		insertDiskVO.setHourlyFlag("N");
		insertDiskVO.setDescription(null);
		insertDiskVO.setVolumeType(item.getVolumeType());
		// 운영체제의 빌링을 위해 Image의 Item_id를 추가
		if (item.getImageId() != null ) {
			insertDiskVO.setImageId(item.getImageId());
			BatchOssProductVO paramProductVO = new BatchOssProductVO();
    		paramProductVO.setVmImageId(item.getImageId());
    		BatchOssProductVO osProduct = this.sqlSessionTemplate.selectOne(selectItemByImageId, paramProductVO);

    		if (osProduct != null) {
    			insertDiskVO.setImageItemId(osProduct.getItemId());
    		}
		}
		this.sqlSessionTemplate.insert(insertOssDisk, insertDiskVO);
	}

	private void updateOssDiskById(BatchOssDiskVO item, BatchOssDiskVO selectDiskVO) throws Exception {
		BatchOssDiskVO updateDiskVO = selectDiskVO;

		//오픈스택은 삭제상태이지만 포탈은 삭제되지 않는 상태인 경우에는 삭제처리를 한다.
		if ("1".equals(item.getApiDeletedStatus()) && "N".equals(selectDiskVO.getDelFlag())) {
			//해지일자가 없다면 삭제일자로 저장
    		if (updateDiskVO.getExpireDatetime() == null) updateDiskVO.setExpireDatetime(item.getDeleteDatetime());
    		updateDiskVO.setDeleteDatetime(item.getDeleteDatetime());	//삭제일자
    		updateDiskVO.setDelFlag("Y");	//삭제
		}
		updateDiskVO.setCloudId(item.getCloudId());
		updateDiskVO.setProjectId(item.getProjectId());
		updateDiskVO.setVmUuid(item.getVmUuid());
		updateDiskVO.setSizeGb(item.getSizeGb());
		updateDiskVO.setDevice(item.getDevice());
		updateDiskVO.setDiskAlias(item.getDiskAlias());
		updateDiskVO.setVolumeType(item.getVolumeType());

		// 운영체제의 빌링을 위해 Image의 Item_id를 추가
		if (item.getImageId() != null ) {
			updateDiskVO.setImageId(item.getImageId());
			BatchOssProductVO paramProductVO = new BatchOssProductVO();
    		paramProductVO.setVmImageId(item.getImageId());
    		BatchOssProductVO osProduct = this.sqlSessionTemplate.selectOne(selectItemByImageId, paramProductVO);

    		if (osProduct != null) {
    			updateDiskVO.setImageItemId(osProduct.getItemId());
    		}
		}

		this.sqlSessionTemplate.update(updateOssDisk, updateDiskVO);
	}

	private void updateOssDisk() throws Exception {
		List<BatchOssDiskVO> OssDisks = this.sqlSessionTemplate.selectList(selectOssDiskList);
		List<CustomOssCloudVO> cloudList = ossCloudService.getCloudList();
	    for (CustomOssCloudVO cloudVo : cloudList) {
	    	String projectName = "admin";
	    	VolumeIF volumeIF = AbstractFactory.getVolumeIF(projectName, cloudVo);
	        List<Volume> volumes = volumeIF.getAllVolumes("");

	        for (BatchOssDiskVO ossdisk : OssDisks) {
	        	int i = 0;
	        	for (Volume volume : volumes) {
	        		if (ossdisk.getDiskId().equals(volume.getId())){
	        			break;
	        		}//같은 디스크를 찾지 못하면  삭제 처리
	        		if (i++ == volumes.size() -1) {
	        			ossdisk.setDelFlag("Y");
	        			ossdisk.setCloudId(cloudVo.getCloudId());
	        			this.sqlSessionTemplate.update(updateOssDisk, ossdisk);
	        		}
	        	} // end of volume
	        } // end of ossdisk
	    } // end of cloudlist
	}
}
