package com.ivucenter.cloud.batch.billing;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.Setter;



public class SelectMultiCloudInfoTasklet implements Tasklet {	

	private final String selectMultiCloudDetail = "com.ivucenter.cloud.portal.cmm.cloud.OssCloudDAO.list";
    
	@Setter
	private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;

	/* local variable */
	private SqlSessionTemplate sqlSessionTemplate;
    private String billYM;
//    private String procUserId;
    private String procUserName;
    private String runForce;
    private Date baseBillStartDate;
    private Date baseBillEndDate;
    private Date createDatetime;
    private String multiCloudStrList = "";


	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext context) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);
		
		// DB에서 Cloud 종류 불러오기
		CustomOssCloudVO vo = new CustomOssCloudVO();
		List<CustomOssCloudVO> result = this.sqlSessionTemplate.selectList(selectMultiCloudDetail, vo);      
		
		for(int i = 0; i < result.size(); i++) {
			if( i == 0 ) {
				this.multiCloudStrList += result.get(i).getCloudId();
			} else {
				this.multiCloudStrList += ",";
				this.multiCloudStrList += result.get(i).getCloudId();
			}
		}
        /******************************************/
        // Step Parameter
        /******************************************/
		context.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("multiCloudStrList", multiCloudStrList);
		context.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("billYM", billYM);
        context.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("procUserName", procUserName);
        context.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("runForce", runForce);
        context.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("baseBillStartDate", baseBillStartDate);
        context.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("baseBillEndDate", baseBillEndDate);
        context.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("createDatetime", createDatetime);
        
        
		return RepeatStatus.FINISHED;
	}

}
