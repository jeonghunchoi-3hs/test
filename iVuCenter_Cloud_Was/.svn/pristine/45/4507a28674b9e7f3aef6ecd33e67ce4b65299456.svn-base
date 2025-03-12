package com.ivucenter.cloud.batch.hrsystem;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchHrSystemVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class HrSystemWriter implements ItemWriter<BatchHrSystemVO> {

	private final String batchHrSystemDAO = "com.ivucenter.cloud.batch.resources.BatchHrSystemDAO.";
//	private final String deleteHrSystem 	= batchHrSystemDAO + "deleteHrSystem";	
	private final String insertHrSystem 	= batchHrSystemDAO + "insertHrSystem";
	
//	private final String selectListResourcesDay = batchHrSystemDAO + "selectListResourcesDay";
//	private final String updateResourcesDay 	= batchHrSystemDAO + "updateResourcesDay";
	
    @Setter
	private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
	
	private SqlSessionTemplate sqlSessionTemplate;	
	
	@Override
	public void write(List<? extends BatchHrSystemVO> items) throws Exception {
				
		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.BATCH);
		
		
		for (BatchHrSystemVO item : items) {
			
			log.debug(item.toString());
			
			if(item.getDeptCode().equals("A12410")){
				item.setRegUserId("BATCH_SYSTEM");
				this.sqlSessionTemplate.insert(insertHrSystem, item);
			}			
		}
	}

}
