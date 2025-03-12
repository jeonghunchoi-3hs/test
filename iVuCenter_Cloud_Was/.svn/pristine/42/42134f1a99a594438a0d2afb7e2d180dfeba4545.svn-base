package com.ivucenter.cloud.batch.resources.day;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchResourcesVO;

import lombok.Setter;


public class ResourcesDayWriter implements ItemWriter<BatchResourcesVO> {
	
	private final String batchResourcesDAO 		= "com.ivucenter.cloud.batch.resources.BatchResourcesDAO.";	
	private final String insertResourcesDay 	= batchResourcesDAO + "insertResourcesDay";
	private final String selectListResourcesDay = batchResourcesDAO + "selectListResourcesDay";
	private final String updateResourcesDay 	= batchResourcesDAO + "updateResourcesDay";
		
	/* local variable */    
    private String resourcesDate;
	
    @Setter
	private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
	
	private SqlSessionTemplate sqlSessionTemplate;	

	@Override
	public void write(List<? extends BatchResourcesVO> items) throws Exception {
				
		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.BATCH);
		this.resourcesDate = (String) this.parameterValues.get("resourcesDate");
		
		for (BatchResourcesVO item : items) {	        	
			item.setResourcesDate(resourcesDate);
	       	item.setRegUserId("BATCH_SYSTEM");        	
	       	
	       	BatchResourcesVO vo = this.sqlSessionTemplate.selectOne(selectListResourcesDay, item);
	       	
	       	if(vo == null){
	       		this.sqlSessionTemplate.insert(insertResourcesDay, item);
	       	}else{
	       		this.sqlSessionTemplate.update(updateResourcesDay, item);
	       	}
		} 
	}
	

}
