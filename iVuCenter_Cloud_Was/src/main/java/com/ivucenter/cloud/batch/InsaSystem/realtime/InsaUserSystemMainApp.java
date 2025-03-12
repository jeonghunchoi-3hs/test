package com.ivucenter.cloud.batch.InsaSystem.realtime;

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
public class InsaUserSystemMainApp {
	public static void main( String[] args ) {
		String[] config = {
			"file:WebContent/WEB-INF/spring/application-context.xml",								
			"file:WebContent/WEB-INF/spring/batch/spring-batch-context.xml",
			"classpath:com/ivucenter/cloud/batch/InsaSystem/realtime/InsaUserSystem-job-config.xml"
		};

		ApplicationContext context = new ClassPathXmlApplicationContext(config);
		JobLauncher jobLauncher = (JobLauncher) context.getBean("jobLauncher");
		Job job = (Job) context.getBean("InsaUserSystemJob");
		
		long runtime = new Timestamp(System.currentTimeMillis()).getTime();
		
		Date startDate = DateUtils.addYears(new Date(), -1);
		
		//기준 날짜
		String standardDate = DateUtils.convertDateToString(startDate, "Asia/Seoul", "yyyy-MM-dd HH:mm:ss");
		
		try {
			
            Map<String, JobParameter> parameters = new HashMap<String, JobParameter>(); 
            parameters.put("runtime", new JobParameter(runtime));
            parameters.put("standardDate", new JobParameter(standardDate));            
            
            log.debug("standardDate=" + standardDate);
            
            JobExecution execution = jobLauncher.run(job, new JobParameters(parameters));
        		
            log.info("Exit Status : " + execution.getStatus());

		} catch (JobExecutionAlreadyRunningException e) {
            log.debug("[LogincheckMainApp] "+ e.getMessage());
		} catch (JobRestartException e) {
            log.debug("[LogincheckMainApp] "+ e.getMessage());
		} catch (JobInstanceAlreadyCompleteException e) {
            log.debug("[LogincheckMainApp] "+ e.getMessage());
		} catch (JobParametersInvalidException e) {
            log.debug("[LogincheckMainApp] "+ e.getMessage());
		}
		
		log.info("Finished Execution of Batch Job");
	}

}
