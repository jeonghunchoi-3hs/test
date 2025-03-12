package com.ivucenter.cloud.batch.billing;

import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import lombok.Setter;

public class EndJobTasklet implements Tasklet {	
    
	@Setter
	private SqlSessionFactory sqlSessionFactory;

	@Setter
	private Map<String, Object> parameterValues;

	/* local variable */
//	private SqlSessionTemplate sqlSessionTemplate;
//    private String billYM;

	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
//		sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);
//		
//        this.billYM = (String) this.parameterValues.get("billYM");
		
		return RepeatStatus.FINISHED;
	}
}
