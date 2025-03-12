package com.ivucenter.cloud.batch;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
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
		"file:src/main/java/com/ivucenter/cloud/batch/resources/day/resourcesday-job-config.xml" })
@TestPropertySource({"file:src/test/resources/application.properties"})
public class ResourceDayTest {
	
	@Autowired
	private ApplicationContext context;

	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	@Test
	public void ResourceDayJob() {
		JobLauncher jobLauncher = (JobLauncher) context.getBean("jobLauncher");
		Job job = (Job) context.getBean("resourcesDayJob");
		
		long runtime = new Timestamp(System.currentTimeMillis()).getTime();
		
		//현재 날짜
		String resourcesDate = DateUtils.convertDateToString(new Date(), "Asia/Seoul", "yyyy-MM-dd");
	
		try {
			
            Map<String, JobParameter> parameters = new HashMap<String, JobParameter>(); 
            parameters.put("runtime", new JobParameter(runtime));
            parameters.put("resourcesDate", new JobParameter(resourcesDate));            
            
            log.info("resourcesDate=" + resourcesDate);
            
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
