package com.ivucenter.cloud.batch.sendmail;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.quartz.DisallowConcurrentExecution;
import org.quartz.JobExecutionContext;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobParameter;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersInvalidException;
import org.springframework.batch.core.configuration.JobLocator;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.launch.NoSuchJobException;
import org.springframework.batch.core.repository.JobExecutionAlreadyRunningException;
import org.springframework.batch.core.repository.JobInstanceAlreadyCompleteException;
import org.springframework.batch.core.repository.JobRestartException;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.ivucenter.cloud.batch.common.ApplicationContextUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@DisallowConcurrentExecution
public class SendMailJobLauncherDetails extends QuartzJobBean{
    
    private static final String SPRING_BATCH_JOB_NAME = "sendMailJob";
     
    @Override
    protected void executeInternal(JobExecutionContext context){
        
    	log.debug("---------------------SendMailJobLauncherDetails------------------------"); 
        String jobName = context.getJobDetail().getKey().getName();
        String current = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());
        log.info("[" + current + "] " + "Quartz job started: "+ jobName);

        ApplicationContext applicationContext = ApplicationContextUtil.getApplicationContext();
        JobLocator jobLocator = (JobLocator) applicationContext.getBean("jobRegistry");
        JobLauncher jobLauncher = (JobLauncher) applicationContext.getBean("jobLauncher");
        
		long runtime = new Timestamp(System.currentTimeMillis()).getTime();		
		
        try {
            Map<String, JobParameter> parameters = new HashMap<String, JobParameter>();
            parameters.put("runtime", new JobParameter(runtime));
           
			JobExecution execution = jobLauncher.run(jobLocator.getJob(SPRING_BATCH_JOB_NAME), new JobParameters(parameters));
			
			log.info("[SpringBatchJobLauncher] " + "Exit Status : " + execution.getStatus());
		} catch (JobExecutionAlreadyRunningException|JobRestartException|JobInstanceAlreadyCompleteException|
				 JobParametersInvalidException |NoSuchJobException e) {
            log.error("[QuartzJobExecutor] " + "Job could not be executed : "+ e.getMessage());
		}

		log.debug("[QuartzJobExecutor] " + "Quartz job end");
   }
}