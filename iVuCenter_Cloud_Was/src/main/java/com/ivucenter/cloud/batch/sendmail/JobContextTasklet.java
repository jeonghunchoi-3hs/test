package com.ivucenter.cloud.batch.sendmail;

import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import lombok.Setter;

public class JobContextTasklet implements Tasklet {
	
//    private final String queryString = "com.ivu.spring.mybatis.dao.BbsFaqTestDao.delete";
    
    @Setter
    private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
	
	/* local variable */
	private String mailFrom;
    private String mailSmtpHost;
    

	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        //SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);
        //this.meteringDate = (Date) this.parameterValues.get("meteringDate");
        //sqlSessionTemplate.delete(queryString);
        
        
		//메일 발신자 정보
		mailFrom = "K-Cloud@kepco.co.kr";
		
		//메일 발송 시스템
		mailSmtpHost = "127.0.0.1";
		
        
        /******************************************/
        // Step Parameter
        /******************************************/
        chunkContext.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("mailFrom", mailFrom);
        chunkContext.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("mailSmtpHost", mailSmtpHost);
        
		return RepeatStatus.FINISHED;
	}

}
