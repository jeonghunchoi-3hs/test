package com.ivucenter.cloud.batch.InsaSystem.realtime;

import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JobContextTasklet  implements Tasklet{
	
	private final String deleteUserTmp		= "com.ivucenter.cloud.batch.resources.BatchInsaSystemDAO.deleteUserTmp";
	
    @Setter
    private SqlSessionFactory sqlSessionFactory;    

    private SqlSessionTemplate sqlSessionTemplate;
    
    @Setter
	private Map<String, Object> parameterValues;
	
	/* local variable */    
    private String standardDate;    
    
	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
				
        this.standardDate = (String) this.parameterValues.get("standardDate");        
        log.debug("standardDate=" + standardDate);
        		
        /******************************************/
        // Step Parameter
        /******************************************/
        chunkContext.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("applyDatetime", standardDate);
        
        this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);        
        this.sqlSessionTemplate.delete(deleteUserTmp);
       
		return RepeatStatus.FINISHED;
	}
}
