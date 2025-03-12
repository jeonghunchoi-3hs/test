package com.ivucenter.cloud.batch.InsaSystem;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import lombok.Setter;

public class InsaSystemClearTasklet implements Tasklet {
	
		
	private final String updateInsaDeptSetNull 	= "com.ivucenter.cloud.batch.resources.BatchInsaSystemDAO.updateInsaDeptSetNull";
	private final String deleteInsaDeptNotUse 	= "com.ivucenter.cloud.batch.resources.BatchInsaSystemDAO.deleteInsaDeptNotUse";
	
	@Setter
	private SqlSessionFactory sqlSessionFactory;
	
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext context) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.SIMPLE);		
      	
		this.sqlSessionTemplate.update(updateInsaDeptSetNull);
		this.sqlSessionTemplate.delete(deleteInsaDeptNotUse);
		
		return RepeatStatus.FINISHED;
	}
	

}
