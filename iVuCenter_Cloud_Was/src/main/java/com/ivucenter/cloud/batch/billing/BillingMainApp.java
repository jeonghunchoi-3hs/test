package com.ivucenter.cloud.batch.billing;

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
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class BillingMainApp {
		
	public static void main( String[] args ) {
		String[] config = {			
			"file:WebContent/WEB-INF/spring/application-context.xml",								
			"file:WebContent/WEB-INF/spring/batch/spring-batch-context.xml",
			"classpath:com/ivucenter/cloud/batch/billing/billing-job-config.xml"
		};
		
		try(ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(config)) {
			JobLauncher jobLauncher = (JobLauncher) context.getBean("jobLauncher");
			Job job = (Job) context.getBean("billingJob");
			
			long runtime = new Timestamp(System.currentTimeMillis()).getTime();
			
			Date billYyyyMm = DateUtils.addMonths(new Date(), +1);	        
			String billYM = DateUtils.convertDateToString(billYyyyMm, "Asia/Seoul", "yyyyMM");
			//String billYM = "201906";
			String procUserId = "BATCH_SYSTEM";
			String runForce = "Y";
        	
            Map<String, JobParameter> parameters = new HashMap<String, JobParameter>();
            parameters.put("runtime", new JobParameter(runtime));
            parameters.put("billYM", new JobParameter(billYM));
            parameters.put("procUserId", new JobParameter(procUserId));
            parameters.put("runForce", new JobParameter(runForce));
            
            JobExecution execution = jobLauncher.run(job, new JobParameters(parameters));
            
            log.info("[SpringBatchJobLauncher] Exit Status : " + execution.getStatus());
            
		} catch (JobExecutionAlreadyRunningException | JobRestartException |
				 JobInstanceAlreadyCompleteException | JobParametersInvalidException  e) {
            log.info("[QuartzJobExecutor] Job could not be executed : "+ e.getMessage());
		}
		
		log.info("Finished Execution of Batch Job");
	}	

}
