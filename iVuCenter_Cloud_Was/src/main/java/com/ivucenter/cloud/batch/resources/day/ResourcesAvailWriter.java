package com.ivucenter.cloud.batch.resources.day;

import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.api.openstack.OpenStackUsage;
import com.ivucenter.cloud.entity.OssAvailabilityVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ResourcesAvailWriter implements ItemWriter<OpenStackUsage> {
	private final String batchInsertOssAvailabilityHistory = "com.ivucenter.cloud.portal.oss.availability.OssAvailabilityDAO.batchInsertOssAvailabilityHistory";

    /* sqlSessionFactory */
	private SqlSessionFactory sqlSessionFactory;
    public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
        this.sqlSessionFactory = sqlSessionFactory;
    }


	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public void write(List<? extends OpenStackUsage> items) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);
		
		
        for (OpenStackUsage item : items) {
        	OssAvailabilityVO availVO = new OssAvailabilityVO();
        	
        	availVO.setProjectId(item.getProjectId());
        	availVO.setCloudId(item.getCloudId());
        	availVO.setVmTotal(item.getVmTotal());
        	availVO.setVmUsed(item.getVmUsed());
        	availVO.setVmAvail(item.getVmAvail());
        	
        	availVO.setVCpuTotal(item.getVCpuTotal());
        	availVO.setVCpuUsed(item.getVCpuUsed());
        	availVO.setVCpuAvail(item.getVCpuAvail());
        	
        	availVO.setMemTotal(item.getMemTotal());
        	availVO.setMemUsed(item.getMemUsed());
        	availVO.setMemAvail(item.getMemAvail());
        	
        	availVO.setDiskTotal(item.getDiskTotal());
        	availVO.setDiskUsed(item.getDiskUsed());
        	availVO.setDiskAvail(item.getDiskAvail());

        	availVO.setCollDatetime(new java.util.Date());
        	
        	log.debug(availVO.toString());
        	
        	this.sqlSessionTemplate.insert(batchInsertOssAvailabilityHistory, availVO);
        }
		
	}
}
