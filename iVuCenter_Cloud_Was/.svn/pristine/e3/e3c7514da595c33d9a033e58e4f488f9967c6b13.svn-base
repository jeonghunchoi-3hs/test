package com.ivucenter.cloud.batch.sendKepco;

import java.sql.Timestamp;
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

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SendKepcoApp {
	
	public static void main( String[] args ) {
		String[] config = {
				"file:WebContent/WEB-INF/spring/application-context.xml",
				"classpath:mybatis-context.xml", 
				"file:WebContent/WEB-INF/spring/batch/spring-batch-context.xml",
				"file:src/main/java/com/ivucenter/cloud/batch/sendKepco/sendKepco-job-config.xml"				
		};
		
		try(ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(config)) {
			JobLauncher jobLauncher = (JobLauncher) context.getBean("jobLauncher");
			Job job = (Job) context.getBean("sendKepcoJob");
			
			long runtime = new Timestamp(System.currentTimeMillis()).getTime();
        
            Map<String, JobParameter> parameters = new HashMap<String, JobParameter>();
            parameters.put("runtime", new JobParameter(runtime));
            
            JobExecution execution = jobLauncher.run(job, new JobParameters(parameters));
        		
            log.info("[SpringBatchJobLauncher] Exit Status : " + execution.getStatus());
            
		} catch (JobExecutionAlreadyRunningException | JobRestartException |
				 JobInstanceAlreadyCompleteException | JobParametersInvalidException  e) {
            log.info("[QuartzJobExecutor] " + "Job could not be executed : "+ e.getMessage());
		}
		
		log.info("Finished Execution of Batch Job");
	}
}
