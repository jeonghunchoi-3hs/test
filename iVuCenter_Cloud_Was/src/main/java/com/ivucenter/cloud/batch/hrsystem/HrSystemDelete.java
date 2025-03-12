package com.ivucenter.cloud.batch.hrsystem;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchHrSystemVO;

import lombok.Setter;

public class HrSystemDelete implements ItemWriter<BatchHrSystemVO> {
	
	private final String batchHrSystemDAO = "com.ivucenter.cloud.batch.resources.BatchHrSystemDAO.";
	
	private final String deleteHrSystem 	= batchHrSystemDAO + "deleteHrSystem";	
		
    @Setter
	private SqlSessionFactory sqlSessionFactory;

    @Setter
	private Map<String, Object> parameterValues;

	private SqlSessionTemplate sqlSessionTemplate;	
	
	@Override
	public void write(List<? extends BatchHrSystemVO> items) throws Exception {
				
		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.BATCH);
		
		this.sqlSessionTemplate.delete(deleteHrSystem);
	}

}
