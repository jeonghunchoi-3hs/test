package com.ivucenter.cloud.batch.resources.month;

import java.sql.Timestamp;
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

import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ResourcesMonthMainApp {
	
	public static void main( String[] args ) {
		String[] config = {
			"file:WebContent/WEB-INF/spring/application-context.xml",								
			"file:WebContent/WEB-INF/spring/batch/spring-batch-context.xml",			
			"classpath:com/ivucenter/cloud/batch/resources/month/resourcesMonth-job-config.xml"
		};

		ApplicationContext context = new ClassPathXmlApplicationContext(config);
		JobLauncher jobLauncher = (JobLauncher) context.getBean("jobLauncher");
		Job job = (Job) context.getBean("resourcesMonthJob");
		
		long runtime = new Timestamp(System.currentTimeMillis()).getTime();
		
		//현재 날짜
		String resourcesDate = DateUtils.convertDateToString(new Date(), "Asia/Seoul", "yyyy-MM");
	
		try {
			
            Map<String, JobParameter> parameters = new HashMap<String, JobParameter>(); 
            parameters.put("runtime", new JobParameter(runtime));
            parameters.put("resourcesDate", new JobParameter(resourcesDate));            
            
            log.debug("resourcesDate=" + resourcesDate);
            
            JobExecution execution = jobLauncher.run(job, new JobParameters(parameters));
        		
            log.info("Exit Status : " + execution.getStatus());
		} catch (JobExecutionAlreadyRunningException e) {
            log.debug("[QuartzJobExecutor] " + "Job could not be executed : "+ e.getMessage());
		} catch (JobRestartException e) {
            log.debug("[QuartzJobExecutor] " + "Job could not be executed : "+ e.getMessage());
		} catch (JobInstanceAlreadyCompleteException e) {
            log.debug("[QuartzJobExecutor] " + "Job could not be executed : "+ e.getMessage());
		} catch (JobParametersInvalidException e) {
            log.debug("[QuartzJobExecutor] " + "Job could not be executed : "+ e.getMessage());
		}
		
		log.info("Finished Execution of Batch Job");
	}
}
