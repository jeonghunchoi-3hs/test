package com.ivucenter.cloud.batch.metering.cicdApplication;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobParameter;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersInvalidException;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.repository.JobExecutionAlreadyRunningException;
import org.springframework.batch.core.repository.JobInstanceAlreadyCompleteException;
import org.springframework.batch.core.repository.JobRestartException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.ivucenter.cloud.batch.common.ApplicationContextUtil;
import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MainCicdApplicationApp {

	public static void main( String[] args ) {
		String[] config = {
			"file:WebContent/WEB-INF/spring/application-context.xml",
			"file:WebContent/WEB-INF/spring/batch/spring-batch-context.xml",
			"classpath:com/ivucenter/cloud/batch/metering/cicdApplication/application-job-config.xml"
		};

		try(ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(config)) {

			JobLauncher jobLauncher = (JobLauncher) context.getBean("jobLauncher");
			Job job = (Job) context.getBean("applicationRealtimeJob");

			long runtime = new Timestamp(System.currentTimeMillis()).getTime();

			// 1분마다 데이터를 수집
//			Date applicationMinute = DateUtils.truncate(DateUtils.addMinutes(new Date(), -1), Calendar.MINUTE);	//1분 전
			Date applicationMinute = DateUtils.truncate(DateUtils.addDays(new Date(), -14), Calendar.MILLISECOND);	//1시간전
			String syncAppStatus = "SYNC_APP_READY";


            Map<String, JobParameter> parameters = new HashMap<String, JobParameter>();
            parameters.put("runtime", new JobParameter(runtime));
            log.info("runtime = {}" + runtime);
//            parameters.put("applicationDay", new JobParameter(applicationDay));
//            log.debug("applicationDay=" + applicationDay);
            parameters.put("applicationMinute", new JobParameter(applicationMinute));
            log.info("applicationMinute = {}" + applicationMinute);

    		// 현재 시간
    		String applyDatetime = DateUtils.convertDateToString(new Date(), "Asia/Seoul", "yyyy-MM-dd HH:mm");
			parameters.put("applyDatetime", new JobParameter(applyDatetime));
			log.info("applyDatetime = {}" + applyDatetime);

			parameters.put("syncAppStatus", new JobParameter(syncAppStatus));
			log.info("syncAppStatus = {}" + syncAppStatus);

            JobExecution execution = jobLauncher.run(job, new JobParameters(parameters));
            log.info("Exit Status : " + execution.getStatus());

		} catch (JobExecutionAlreadyRunningException | JobRestartException |
				 JobInstanceAlreadyCompleteException | JobParametersInvalidException  e) {
            log.info("MainCicdApplicationApp" + e.getMessage());
		}
		log.info("Finished Execution of Batch Job");
	}
}
