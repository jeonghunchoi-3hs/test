package com.ivucenter.cloud.batch.provisioning;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.batch.core.Job;
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
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class provisioningApp {

	public static void main(String[] args) {

		String[] config = { "file:WebContent/WEB-INF/spring/application-context.xml",
				"file:WebContent/WEB-INF/spring/batch/spring-batch-context.xml",
				"file:src/main/java/com/ivucenter/cloud/batch/provisioning/provisioning-job-config.xml" };

		try (ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(config)) {

			JobLauncher jobLauncher = (JobLauncher) context.getBean("jobLauncher");
			Job job = (Job) context.getBean("provisioningJob");

//			long runtime = new Timestamp(System.currentTimeMillis()).getTime();

			// 현재 시간
			String applyDatetime = DateUtils.convertDateToString(new Date(), "Asia/Seoul", "yyyy-MM-dd HH:mm");
			String provisioningStatus = "PROVISIONING_READY";
			String provisioningSeq = "";

			Map<String, JobParameter> parameters = new HashMap<String, JobParameter>();
			parameters.put("applyDatetime", new JobParameter(applyDatetime));
			parameters.put("provisioningStatus", new JobParameter(provisioningStatus));
			parameters.put("provisioningSeq", new JobParameter(provisioningSeq));

			log.debug("applyDatetime=" + applyDatetime + ", provisioningStatus=" + provisioningStatus);

			JobExecution execution = jobLauncher.run(job, new JobParameters(parameters));

			log.info("Exit Status : " + execution.getStatus());

		} catch (JobExecutionAlreadyRunningException | JobRestartException | JobInstanceAlreadyCompleteException
				| JobParametersInvalidException e) {
			log.info("[QuartzJobExecutor] " + "Job could not be executed : " + e.getMessage());
		}

		log.info("Finished Execution of Batch Job");
	} // end of Main()

	public static void nowRun() {

		try (ClassPathXmlApplicationContext applicationContext = (ClassPathXmlApplicationContext) com.ivucenter.cloud.batch.common.ApplicationContextUtil
				.getApplicationContext()) {

			JobLocator jobLocator = (JobLocator) applicationContext.getBean("jobRegistry");
			JobLauncher jobLauncher = (JobLauncher) applicationContext.getBean("jobLauncher");

//			long runtime = new Timestamp(System.currentTimeMillis()).getTime();

			// Job parameter Setting
			String applyDatetime = DateUtils.convertDateToString(new Date(), "Asia/Seoul", "yyyy-MM-dd HH:mm");
			String provisioningStatus = "PROVISIONING_READY";
			String provisioningSeq = "";

			Map<String, JobParameter> parameters = new HashMap<String, JobParameter>();
			parameters.put("applyDatetime", new JobParameter(applyDatetime));
			parameters.put("provisioningStatus", new JobParameter(provisioningStatus));
			parameters.put("provisioningSeq", new JobParameter(provisioningSeq));

			log.debug("applyDatetime=" + applyDatetime + ", provisioningStatus=" + provisioningStatus);

			JobExecution execution = jobLauncher.run(jobLocator.getJob("provisioningJob"),
					new JobParameters(parameters));

			log.info("[SpringBatchJobLauncher] Exit Status : " + execution.getStatus());

		} catch (JobExecutionAlreadyRunningException | JobRestartException | JobInstanceAlreadyCompleteException
				| JobParametersInvalidException | NoSuchJobException e) {
			log.info("[QuartzJobExecutor] " + "Job could not be executed : " + e.getMessage());
		}
	}
}
