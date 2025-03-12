package com.ivucenter.cloud.batch.provisioning;

import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@Slf4j
public class JobContextTasklet implements Tasklet {	

    @Setter
    private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
	
	/* local variable */    
    private String applyDatetime;
    private String provisioningStatus;
    private String provisioningSeq;
    

	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        this.applyDatetime = (String) this.parameterValues.get("applyDatetime");
        this.provisioningStatus = (String) this.parameterValues.get("provisioningStatus");
        this.provisioningSeq = (String) this.parameterValues.get("provisioningSeq");
		log.debug("applyDatetime=" + applyDatetime+", provisioningStatus="+provisioningStatus);
        
        /******************************************/
        // Step Parameter
        /******************************************/
        chunkContext.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("applyDatetime", applyDatetime);
        chunkContext.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("provisioningStatus", provisioningStatus);
        chunkContext.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("provisioningSeq", provisioningSeq);
        
       
		return RepeatStatus.FINISHED;
	}

}
