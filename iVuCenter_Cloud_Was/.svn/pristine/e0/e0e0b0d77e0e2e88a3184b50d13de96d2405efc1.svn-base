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
		"file:src/main/java/com/ivucenter/cloud/batch/billing/billing-job-config.xml" })
@TestPropertySource({"file:src/test/resources/application.properties"})
public class BillingsTest {
	
	@Autowired
	private ApplicationContext context;

	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
//	@Autowired	private JobLauncherTestUtils jobLauncherTestUtils;


	@Test
	public void billingJob() {
        
//		// jobLauncherTestUtils 테스트 
//		try {
//			
//			long runtime = new Timestamp(System.currentTimeMillis()).getTime();
//			String billYM = "201906";
//			Map<String, JobParameter> parameters = new HashMap<String, JobParameter>();
//			parameters.put("runtime", new JobParameter(runtime));
//			parameters.put("billYM", new JobParameter(billYM));
//
//			commonAssertions(jobLauncherTestUtils.launchStep("initBillMasterStep", new JobParameters(parameters)));
//		} catch (Exception e1) {
//			e1.printStackTrace();
//		}
		
		JobLauncher jobLauncher = (JobLauncher) context.getBean("jobLauncher");
		Job job = (Job) context.getBean("billingJob"); 
		long runtime = new Timestamp(System.currentTimeMillis()).getTime();

		Date billYyyyMm = DateUtils.addMonths(new Date(), +1);

		String billYM = "201906";
		String procUserId = "BATCH_SYSTEM";
		String runForce = "Y";
		log.debug(billYM);
		log.debug(procUserId);
		log.debug(runForce);

		try {

			Map<String, JobParameter> parameters = new HashMap<String, JobParameter>();
			parameters.put("runtime", new JobParameter(runtime));
			parameters.put("billYM", new JobParameter(billYM));
			parameters.put("procUserId", new JobParameter(procUserId));
			parameters.put("runForce", new JobParameter(runForce));

			JobExecution execution = jobLauncher.run(job, new JobParameters(parameters));
			
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
	}

//	private void commonAssertions(JobExecution jobExecution) {
//        assertNotNull(jobExecution);
// 
//        BatchStatus batchStatus = jobExecution.getStatus();
//        assertEquals(BatchStatus.COMPLETED, batchStatus);
//        assertFalse(batchStatus.isUnsuccessful());
// 
//        ExitStatus exitStatus = jobExecution.getExitStatus();
//        assertEquals("COMPLETED", exitStatus.getExitCode());
//        assertEquals("", exitStatus.getExitDescription());
// 
//        List<Throwable> failureExceptions = jobExecution.getFailureExceptions();
//        assertNotNull(failureExceptions);
//        assertTrue(failureExceptions.isEmpty());
//    }
}
