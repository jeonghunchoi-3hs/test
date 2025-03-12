package com.ivucenter.cloud.batch.logincheck;

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
import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@DisallowConcurrentExecution
public class LogincheckJobLauncherDetails extends QuartzJobBean{
    
    private static final String SPRING_BATCH_JOB_NAME = "logincheckJob";
     
    @Override
    protected void executeInternal(JobExecutionContext context){
        
    	log.debug("---------------------LogincheckJobLauncherDetails------------------------"); 
        String jobName = context.getJobDetail().getKey().getName();
        String current = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());
        log.info("[" + current + "] " + "Quartz job started: "+ jobName);

        ApplicationContext applicationContext = ApplicationContextUtil.getApplicationContext();
        JobLocator jobLocator = (JobLocator) applicationContext.getBean("jobRegistry");
        JobLauncher jobLauncher = (JobLauncher) applicationContext.getBean("jobLauncher");
        
		long runtime = new Timestamp(System.currentTimeMillis()).getTime();
		Date startDate = DateUtils.addYears(new Date(), -1);
		
		//현재 날짜
		String standardDate = DateUtils.convertDateToString(startDate, "Asia/Seoul", "yyyy-MM-dd HH:mm:ss");

		
        try {
            Map<String, JobParameter> parameters = new HashMap<String, JobParameter>();  
            parameters.put("runtime", new JobParameter(runtime));
            parameters.put("standardDate", new JobParameter(standardDate));         
            
            log.debug("standardDate=" + standardDate);
			
			JobExecution execution = jobLauncher.run(jobLocator.getJob(SPRING_BATCH_JOB_NAME), new JobParameters(parameters));
			
			log.info("[SpringBatchJobLauncher] " + "Exit Status : " + execution.getStatus());
		} catch (JobExecutionAlreadyRunningException|JobRestartException|JobInstanceAlreadyCompleteException|
				 JobParametersInvalidException |NoSuchJobException e) {
            log.error("[QuartzJobExecutor] " + "Job could not be executed : "+ e.getMessage());
        }

		log.debug("[QuartzJobExecutor] " + "Quartz job end");
   }
}