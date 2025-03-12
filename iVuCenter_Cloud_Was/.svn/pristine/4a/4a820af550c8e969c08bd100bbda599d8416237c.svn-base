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
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.Setter;



public class JobContextTasklet implements Tasklet {	

	private final String selectUserDetail 	="com.ivucenter.cloud.portal.cmm.user.CmmUserDAO.detail";
	private final String selectMultiCloudDetail = "com.ivucenter.cloud.portal.cmm.cloud.OssCloudDAO.list";
	
    @Setter
	private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
	

	/* local variable */
	private SqlSessionTemplate sqlSessionTemplate;
    private String billYM;
    private String procUserId;
    private String procUserName;
    private String runForce;
    private Date baseBillStartDate;
    private Date baseBillEndDate;
    private Date createDatetime;
    private String multiCloudStrList = "";


	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext context) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);
		
        this.billYM = (String) this.parameterValues.get("billYM");
        this.procUserId = (String) this.parameterValues.get("procUserId");
        this.runForce = (String) this.parameterValues.get("runForce");

        if ("BATCH_SYSTEM".equals(procUserId)) {
        	procUserName = "BATCH_SYSTEM";
        } else {
        	// DB에서 사용자 이름 불러오기
        	CustomCmmUserVO vo = new CustomCmmUserVO();        	
        	vo.setUserId(procUserId);
        	CustomCmmUserVO result = (CustomCmmUserVO) this.sqlSessionTemplate.selectOne(selectUserDetail, vo);
        	procUserName = result.getUserName();
        }
        
        // DB에서 Cloud 종류 불러오기
 		CustomOssCloudVO vo = new CustomOssCloudVO();
 		List<CustomOssCloudVO> result = this.sqlSessionTemplate.selectList(selectMultiCloudDetail, vo);      
 		
 		for(int i = 0; i < result.size(); i++) {
 			if( i == 0 ) {
 				multiCloudStrList += result.get(i).getCloudId();
 			} else {
 				multiCloudStrList += ",";
 				multiCloudStrList += result.get(i).getCloudId();
 			}
 		}
     		
        // 빌링기준일
        baseBillEndDate = DateUtils.convertStringToDate(billYM + "01", "Asia/Seoul", "yyyyMMdd");
        baseBillStartDate = DateUtils.addMonths(baseBillEndDate, -1);        
        createDatetime = DateUtils.convertStringToDate(billYM.substring(0, 4)+"-"+billYM.substring(4, 6)+"-"+ "01 00:00:00" , "Asia/Seoul", "yyyy-MM-dd HH:mm:ss");
        		
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
