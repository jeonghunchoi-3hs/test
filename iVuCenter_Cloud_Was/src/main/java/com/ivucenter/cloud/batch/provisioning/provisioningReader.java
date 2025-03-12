package com.ivucenter.cloud.batch.provisioning;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.annotation.BeforeStep;
import org.springframework.batch.item.ExecutionContext;
import org.springframework.batch.item.ItemReader;
import org.springframework.batch.item.NonTransientResourceException;
import org.springframework.batch.item.ParseException;
import org.springframework.batch.item.UnexpectedInputException;

import com.ivucenter.cloud.batch.entity.BatchProvisioningVO;

import lombok.Setter;

/**
 * 사용하려고 만들었으나 사용하지 않음. 혹시몰라서 남겨둠 
 * @author Administrator
 *
 */
public class provisioningReader implements ItemReader<List<BatchProvisioningVO>> {	
	
	private final String batchSelectListProvisioningQueue = "com.ivucenter.cloud.batch.provisioning.BatchProvisioningDAO.batchSelectListProvisioningQueue";
	
	@Setter
    private SqlSessionFactory sqlSessionFactory;    
    
    @Setter
	private Map<String, Object> parameterValues;
	
	private SqlSessionTemplate sqlSessionTemplate;
    private StepExecution stepExecution;    
    private String applyDatetime;
    private String provisioningStatus;
    private String provisioningSeq;
    
	@Override
	public List<BatchProvisioningVO> read() throws Exception, UnexpectedInputException, ParseException, NonTransientResourceException {
		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.BATCH);
		
		JobExecution jobExecution = stepExecution.getJobExecution();
		ExecutionContext jobContext = jobExecution.getExecutionContext();
		
		
		this.applyDatetime 		= (String) this.parameterValues.get("applyDatetime");
        this.provisioningStatus = (String) this.parameterValues.get("provisioningStatus");
        this.provisioningSeq 	= (String) jobContext.get("provisioningSeq");
        
		Map<String, String> map =  new HashMap<>();
		map.put("applyDatetime", applyDatetime);
		map.put("provisioningStatus", provisioningStatus);
		map.put("provisioningSeq", provisioningSeq);
		
		List<BatchProvisioningVO> provisioningList = sqlSessionTemplate.selectList(batchSelectListProvisioningQueue);
		return provisioningList;
	}
	
	@BeforeStep
	public void beforeStep(final StepExecution stepExecution) {
		this.stepExecution = stepExecution;
	}

}
