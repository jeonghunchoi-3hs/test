package com.ivucenter.cloud.batch.sample;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemReader;
import org.springframework.batch.item.NonTransientResourceException;
import org.springframework.batch.item.ParseException;
import org.springframework.batch.item.UnexpectedInputException;
import org.springframework.beans.factory.annotation.Autowired;

import com.ivucenter.cloud.api.common.batch.BatchProcessor;
import com.ivucenter.cloud.api.openstack.OpenStackUsage;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

//@Slf4j
public class SampleReader implements ItemReader<OpenStackUsage> {
	
	private final String batchDeleteOssAvailability = "com.ivucenter.cloud.portal.oss.availability.OssAvailabilityDAO.batchDeleteOssAvailability";

    /* sessionFactory */
    private SqlSessionFactory sqlSessionFactory;
    public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
        this.sqlSessionFactory = sqlSessionFactory;
    }
    
	@Autowired
	private OssCloudService ossCloudService;

	private SqlSessionTemplate sqlSessionTemplate;

	private List<OpenStackUsage> openStackUsage = null;

	@Override
	public OpenStackUsage read() throws Exception, UnexpectedInputException, ParseException, NonTransientResourceException {
		
		initialize();
		
		if (this.openStackUsage.isEmpty()) {
			this.openStackUsage = null;
			return null;
		}

		return this.openStackUsage.remove(0);		
	}

	private void initialize() throws Exception {
		
		if(null != this.openStackUsage) { return ; }		
		this.openStackUsage = new ArrayList<>();		
		
		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.BATCH);		
		List<CustomOssCloudVO> lists = ossCloudService.getCloudList();
		for (CustomOssCloudVO cloudVo : lists) {
			this.openStackUsage.addAll(BatchProcessor.getCloudUsage(cloudVo));
			if (this.openStackUsage.size() > 0) {
				this.sqlSessionTemplate.delete(batchDeleteOssAvailability, cloudVo.getCloudId());
			}
		}
	}
}
