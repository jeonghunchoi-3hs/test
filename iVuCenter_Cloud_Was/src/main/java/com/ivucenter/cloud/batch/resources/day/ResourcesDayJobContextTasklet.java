package com.ivucenter.cloud.batch.resources.day;

import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@Slf4j
public class ResourcesDayJobContextTasklet implements Tasklet {	

    @Setter
    private SqlSessionFactory sqlSessionFactory;    

    @Setter
	private Map<String, Object> parameterValues;	

	/* local variable */    
    private String resourcesDate;    
    

	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        this.resourcesDate = (String) this.parameterValues.get("resourcesDate");    
		log.debug("resourcesDate=" + resourcesDate);
        
        /******************************************/
        // Step Parameter
        /******************************************/
        chunkContext.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("resourcesDate", resourcesDate);
       
		return RepeatStatus.FINISHED;
	}

}
