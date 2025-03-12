package com.ivucenter.cloud.batch.metering;

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
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MainMeteringApp {
	

	public static void main( String[] args ) {
		String[] config = {			
			"file:WebContent/WEB-INF/spring/application-context.xml",								
			"file:WebContent/WEB-INF/spring/batch/spring-batch-context.xml",			
			"classpath:com/ivucenter/cloud/batch/metering/metering-job-config.xml"			
		};
		
		try(ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(config)) {

			JobLauncher jobLauncher = (JobLauncher) context.getBean("jobLauncher");
			Job job = (Job) context.getBean("meteringJob");
			
			long runtime = new Timestamp(System.currentTimeMillis()).getTime();
			
			//1시간마다 데이터를 수집하도록 한다.
			Date meteringDay = DateUtils.truncate(DateUtils.addHours(new Date(), -1), Calendar.HOUR_OF_DAY);	//1시간전
			//Date meteringDay= DateUtils.convertStringToDate("2017-07-27 16:00:00", "Asia/Seoul", "yyyy-MM-dd HH:mm:ss");
	        
            Map<String, JobParameter> parameters = new HashMap<String, JobParameter>();
            parameters.put("runtime", new JobParameter(runtime));
            parameters.put("meteringDay", new JobParameter(meteringDay));
            log.debug("meteringDay=" + meteringDay);
            
            JobExecution execution = jobLauncher.run(job, new JobParameters(parameters));
        		
            log.info("[SpringBatchJobLauncher] Exit Status : " + execution.getStatus());			

		} catch (JobExecutionAlreadyRunningException|JobRestartException|
				 JobInstanceAlreadyCompleteException|JobParametersInvalidException e) {
			log.info("MainMeteringApp" + e.getMessage());
		}
		
		log.info("Finished Execution of Batch Job");
	}
}
