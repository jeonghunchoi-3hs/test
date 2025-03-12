package com.ivucenter.cloud.batch.provisioning;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.annotation.BeforeStep;
import org.springframework.batch.item.ExecutionContext;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchProvisioningVO;

import lombok.Setter;


public class ProvisioningStartWriter implements ItemWriter<BatchProvisioningVO> {	

	private final String batchProvisioningDAO = "com.ivucenter.cloud.batch.provisioning.BatchProvisioningDAO.";	
	private final String updateProvisioning 	= batchProvisioningDAO + "updateProvisioning";
		
	/* local variable */    
//    private String applyDatetime;
//    private String provisioningStatus;
	
    @Setter
	private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;	
	
	private SqlSessionTemplate sqlSessionTemplate;	
    private StepExecution stepExecution;
    
	@Override
	public void write(List<? extends BatchProvisioningVO> items) throws Exception {
		//SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);
		//this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.BATCH);
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);

		String provisioningSeq = ""; 
		for (BatchProvisioningVO item : items) {
	        	
	       	item.setProvisioningStatus("PROVISIONING_ONGOING");
	       	item.setRegUserId("BATCH_SYSTEM");        	
	       	this.sqlSessionTemplate.update(updateProvisioning, item);
	       	provisioningSeq += "'" + item.getProvisioningSeq() + "',";
	       	
		}
		//provisioningSeq = provisioningSeq.substring(0, provisioningSeq.length() );
			        
	    this.parameterValues.put("provisioningStatus","PROVISIONING_ONGOING");
	    
	    ExecutionContext stepContext = this.stepExecution.getExecutionContext();
	    String provisioningSeqList = "";
	    if( stepContext.get("provisioningSeq") == null ) {
	    	provisioningSeq = provisioningSeq.substring(0, provisioningSeq.length()-1);
	    	provisioningSeqList = provisioningSeq;
	    } else {
	    	provisioningSeq = ", " + provisioningSeq.substring(0, provisioningSeq.length()-1);
	    	provisioningSeqList = (String) stepContext.get("provisioningSeq") + provisioningSeq;
	    }
	    stepContext.remove("provisioningSeq");
	    stepContext.put("provisioningSeq", provisioningSeqList);
	}
	
	@BeforeStep
	public void beforeStep(final StepExecution stepExecution) {
		this.stepExecution = stepExecution;
	}
	

}
