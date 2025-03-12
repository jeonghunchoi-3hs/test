package com.ivucenter.cloud.batch;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.batch.core.BatchStatus;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobParameter;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersInvalidException;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.repository.JobExecutionAlreadyRunningException;
import org.springframework.batch.core.repository.JobInstanceAlreadyCompleteException;
import org.springframework.batch.core.repository.JobRestartException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { 
		"file:WebContent/WEB-INF/spring/application-context.xml",
		"classpath:mybatis-context.xml", 
		"file:WebContent/WEB-INF/spring/batch/spring-batch-context.xml",
		"file:src/main/java/com/ivucenter/cloud/batch/metering/metering-job-config.xml" })
@TestPropertySource({"file:src/test/resources/application.properties"})
public class MeteringTest {
	
	@Autowired
	private ApplicationContext context;

//	@Autowired	private SqlSessionFactory sqlSessionFactory;
	
//	@Autowired	private OpenStackInfo openStackInfo;

	

	@Test
	public void meteringJob() {
		JobLauncher jobLauncher = (JobLauncher) context.getBean("jobLauncher");
		Job job = (Job) context.getBean("meteringJob");

		long runtime = new Timestamp(System.currentTimeMillis()).getTime();

		// 1시간마다 데이터를 수집하도록 한다.
		Date meteringDay = DateUtils.truncate(DateUtils.addHours(new Date(), -1), Calendar.HOUR_OF_DAY); // 1시간전
		// Date meteringDay= DateUtils.convertStringToDate("2017-07-27 16:00:00", "Asia/Seoul", "yyyy-MM-dd HH:mm:ss");
		
		try {
			Map<String, JobParameter> parameters = new HashMap<String, JobParameter>();
            parameters.put("runtime", new JobParameter(runtime));
            parameters.put("meteringDay", new JobParameter(meteringDay));
            log.info("meteringDay=" + meteringDay);
            
            JobExecution execution = jobLauncher.run(job, new JobParameters(parameters));
        		
            log.info("Exit Status : " + execution.getStatus());
            
            assertEquals(BatchStatus.COMPLETED, execution.getStatus());
            
		}  catch (JobExecutionAlreadyRunningException e) {            
            fail("[JobExecutor] " + "Job could not be executed : "+ e.getMessage());
		} catch (JobRestartException e) {
            fail("[JobExecutor] " + "Job could not be executed : "+ e.getMessage());
		} catch (JobInstanceAlreadyCompleteException e) {
            fail("[JobExecutor] " + "Job could not be executed : "+ e.getMessage());
		} catch (JobParametersInvalidException e) {
            fail("[JobExecutor] " + "Job could not be executed : "+ e.getMessage());
		}
		
		log.info("Finished Execution of Batch Job");
	}
}
