package com.ivucenter.cloud.batch.sample;

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
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MainApp {
	
	public static void main( String[] args ) {
		String[] config = {
			"classpath:/WEB-INF/spring/application-context.xml",
			"classpath:/WEB-INF/spring/batch/spring-batch-context.xml",
			"classpath:com/ivucenter/cloud/batch/sample/sample-job-config.xml"			
		};
		
		ApplicationContext context = new ClassPathXmlApplicationContext(config);
		JobLauncher jobLauncher = (JobLauncher) context.getBean("jobLauncher");
		Job job = (Job) context.getBean("sampleJob");
		
		long runtime = new Timestamp(System.currentTimeMillis()).getTime();
        
		try {
            Map<String, JobParameter> parameters = new HashMap<String, JobParameter>();
            parameters.put("runtime", new JobParameter(runtime));
            
            JobExecution execution = jobLauncher.run(job, new JobParameters(parameters));
        		
            log.info("Exit Status : " + execution.getStatus());
		}catch (JobExecutionAlreadyRunningException e) {
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
