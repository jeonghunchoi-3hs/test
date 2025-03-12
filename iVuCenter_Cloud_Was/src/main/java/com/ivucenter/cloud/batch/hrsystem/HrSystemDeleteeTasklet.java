package com.ivucenter.cloud.batch.hrsystem;

import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import lombok.Setter;

public class HrSystemDeleteeTasklet implements Tasklet {	

	private final String batchHrSystemDAO = "com.ivucenter.cloud.batch.resources.BatchHrSystemDAO.";	
	private final String deleteHrSystem 	= batchHrSystemDAO + "deleteHrSystem";	
	
	@Setter
	private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
	
	/* local variable */
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext context) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.BATCH);		
      
		deleteHrSystem();
		return RepeatStatus.FINISHED;
	}
	
	private void deleteHrSystem() {				
		this.sqlSessionTemplate.insert(deleteHrSystem);
	}	
	
}
