package com.ivucenter.cloud.batch.billing;

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
import org.springframework.batch.core.configuration.JobLocator;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.ivucenter.cloud.batch.common.ApplicationContextUtil;
import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@DisallowConcurrentExecution
public class BillingJobLauncherDetails extends QuartzJobBean{    
    
    private static final String SPRING_BATCH_JOB_NAME = "billingJob";
     
    @Override
    protected void executeInternal(JobExecutionContext context){
         
        String jobName = context.getJobDetail().getKey().getName();
        String current = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());
        log.info("[" + current + "] " + "Quartz job started: "+ jobName);

        ApplicationContext applicationContext = ApplicationContextUtil.getApplicationContext();
        JobLocator jobLocator = (JobLocator) applicationContext.getBean("jobRegistry");
        JobLauncher jobLauncher = (JobLauncher) applicationContext.getBean("jobLauncher");
        
		long runtime = new Timestamp(System.currentTimeMillis()).getTime();
		
		Date billYyyyMm = DateUtils.addMonths(new Date(), +1);
		String billYM = DateUtils.convertDateToString(billYyyyMm, "Asia/Seoul", "yyyyMM");
		String procUserId = "BATCH_SYSTEM";
		String runForce = "Y";        

        try {
            Map<String, JobParameter> parameters = new HashMap<String, JobParameter>();
            parameters.put("runtime", new JobParameter(runtime));
            parameters.put("billYM", new JobParameter(billYM));
            parameters.put("procUserId", new JobParameter(procUserId));
            parameters.put("runForce", new JobParameter(runForce));
			
			JobExecution execution = jobLauncher.run(jobLocator.getJob(SPRING_BATCH_JOB_NAME), new JobParameters(parameters));
			
			log.info("[SpringBatchJobLauncher] " + "Exit Status : " + execution.getStatus());
		} catch (Exception e) {
            log.error("[QuartzJobExecutor] " + "Job could not be executed : "+ e.getMessage());
		}

		log.debug("[QuartzJobExecutor] " + "Quartz job end");
   }
}