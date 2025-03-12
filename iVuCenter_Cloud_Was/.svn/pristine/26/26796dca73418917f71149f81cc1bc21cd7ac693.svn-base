package com.ivucenter.cloud.batch.metering;

import java.util.Date;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JobContextTasklet implements Tasklet {	

    @Setter
    private SqlSessionFactory sqlSessionFactory;

    @Setter
	private Map<String, Object> parameterValues;	

	/* local variable */
    private Date meteringDay;
    private Date meteringStartDatetime;
    private Date meteringEndDatetime;
    

	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        this.meteringDay = (Date) this.parameterValues.get("meteringDay");
		log.debug("meteringDay=" + meteringDay);
        
        
        //미터링 시작일시, 종료일시
        this.meteringStartDatetime = this.meteringDay;
        this.meteringEndDatetime = DateUtils.addHours(meteringStartDatetime, 1);
        
        /******************************************/
        // Step Parameter
        /******************************************/
        chunkContext.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("meteringStartDatetime", meteringStartDatetime);
        chunkContext.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("meteringEndDatetime", meteringEndDatetime);
       
		return RepeatStatus.FINISHED;
	}

}
