package com.ivucenter.cloud.batch.metering;

import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.beans.factory.annotation.Autowired;

import com.ivucenter.cloud.api.openstack.object.Project;
import com.ivucenter.cloud.batch.entity.BatchOssProjectVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.Setter;

public class SyncProjectProcessor implements ItemProcessor<Project, BatchOssProjectVO> {
		
	private final String selectProjectById 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectProjectById";
	private final String updateOssProject 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.updateOssProject";

    @Setter
	private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
    
    @Autowired
	private OssCloudService ossCloudService;
	
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	@Override
	public BatchOssProjectVO process(Project item) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);

		BatchOssProjectVO returnProjectVO = null;
		
		String projectId = item.getId();
		String projectName = item.getName();
		
    	//프로젝트 존재 여부 확인
    	BatchOssProjectVO paramProjectVO = new BatchOssProjectVO();
    	paramProjectVO.setProjectId(projectId);
    	
    	BatchOssProjectVO selectProjectVO = this.sqlSessionTemplate.selectOne(selectProjectById, paramProjectVO);
    	if (selectProjectVO != null) {
    		//프로젝트 이름 갱신
    		BatchOssProjectVO updateProjectVO = selectProjectVO;
    		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(updateProjectVO.getCloudId());
    		updateProjectVO.setCloudName(cloudVo.getCloudId());
    		updateProjectVO.setCloudType(cloudVo.getCloudType());
    		updateProjectVO.setProjectName(projectName);
    		
    		this.sqlSessionTemplate.update(updateOssProject, updateProjectVO);
    		
    		//일치하는 프로젝트가 존재하면 리턴값을 발생시켜 네트워크 작업을 수행한다.
    		returnProjectVO = updateProjectVO;
    	}
    	
		return returnProjectVO;
	}

}
