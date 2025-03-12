package com.ivucenter.cloud.batch.hrsystem;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersInvalidException;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.repository.JobExecutionAlreadyRunningException;
import org.springframework.batch.core.repository.JobInstanceAlreadyCompleteException;
import org.springframework.batch.core.repository.JobRestartException;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class HrSystemMainApp {	
	
	public static void main( String[] args ) {
		String[] config = {
				"file:WebContent/WEB-INF/spring/application-context.xml",								
				"file:WebContent/WEB-INF/spring/batch/spring-batch-context.xml",				
				"file:src/main/java/com/ivucenter/cloud/batch/hrsystem/hrsystem-job-config.xml"
		};
		
		try(ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(config)) {
			JobLauncher jobLauncher = (JobLauncher) context.getBean("jobLauncher");
			Job job = (Job) context.getBean("hrSystemJob");
				
			JobExecution execution = jobLauncher.run(job, new JobParameters());
			
			log.info("[SpringBatchJobLauncher] Exit Status : " + execution.getStatus());
			
		} catch (JobExecutionAlreadyRunningException|JobRestartException|
				 JobInstanceAlreadyCompleteException|JobParametersInvalidException e) {
            log.debug("[QuartzJobExecutor] " + "Job could not be executed : "+ e.getMessage());
		} 
		
		log.info("Finished Execution of Batch Job");
	}
}
