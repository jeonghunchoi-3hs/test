package com.ivucenter.cloud.batch.metering.cicdApplication;

import java.util.Date;
import java.util.Map;

import org.apache.commons.lang.time.DateFormatUtils;
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
//    private Date applicationDay;
    private String applyDatetime;
    private String syncAppStatus;
    private Date applicationMinute;
    private Date applicationStartDatetime;
    private Date applicationEndDatetime;

	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
//        this.applicationDay = (Date) this.parameterValues.get("applicationDay");
        this.applicationMinute = (Date) this.parameterValues.get("applicationMinute");

		// 현재 시간
        Date time = DateUtils.addMinutes(new Date(), -1);
		this.applyDatetime = DateUtils.convertDateToString(time, "Asia/Seoul", "yyyy-MM-dd HH:mm");

        //미터링 시작일시, 종료일시
        this.applicationStartDatetime = this.applicationMinute;
//        this.applicationEndDatetime = DateUtils.addHours(applicationStartDatetime, 1);
        this.applicationEndDatetime = DateUtils.addMinutes(applicationStartDatetime, 1);

        this.syncAppStatus = (String) this.parameterValues.get("syncAppStatus");
        /******************************************/
        // Step Parameter
        /******************************************/
        log.info("applicationStartDatetime {}", applicationStartDatetime);
        log.info("applicationEndDatetime {}", applicationEndDatetime);
        chunkContext.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("applyDatetime", applyDatetime);
//        chunkContext.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("applicationMinute", applicationMinute);
        chunkContext.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("applicationStartDatetime", applicationStartDatetime);
        chunkContext.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("applicationEndDatetime", applicationEndDatetime);
        chunkContext.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("syncAppStatus", syncAppStatus);

		return RepeatStatus.FINISHED;
	}

}
