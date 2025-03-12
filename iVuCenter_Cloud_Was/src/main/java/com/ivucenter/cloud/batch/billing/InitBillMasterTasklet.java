package com.ivucenter.cloud.batch.billing;

import java.util.Date;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.ivucenter.cloud.batch.entity.BatchBillMasterVO;
import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class InitBillMasterTasklet implements Tasklet {	

	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
	private final String selectOneBillMaster 	= batchBillingDAO + "selectOneBillMaster";
	private final String insertBillMaster 		= batchBillingDAO + "insertBillMaster";
	private final String updateBillMaster 		= batchBillingDAO + "updateBillMaster";
    
	@Setter
	private SqlSessionFactory sqlSessionFactory;

	@Setter
	private Map<String, Object> parameterValues;

	/* local variable */
	private SqlSessionTemplate sqlSessionTemplate;
	private String billYM;
	private String procUserName;
	private String multiCloudStrList; 

	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext context) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);
		
        this.billYM = (String) this.parameterValues.get("billYM");
        this.procUserName = (String) this.parameterValues.get("procUserName");
        this.multiCloudStrList = (String) this.parameterValues.get("multiCloudStrList");

        // 기존 확정 상태인지 확인
        String[] arrCloud = multiCloudStrList.split(",");
        for( int i = 0 ; i< arrCloud.length; i++) {
        	String tmpCloudId = arrCloud[i];
        	
        	BatchBillMasterVO chkBillMasterVO = new BatchBillMasterVO();
            chkBillMasterVO.setBillYyyymm(billYM);
            chkBillMasterVO.setCloudId(tmpCloudId);
            BatchBillMasterVO rstBatchBillMasterVO = sqlSessionTemplate.selectOne(selectOneBillMaster, chkBillMasterVO);
            
            // 신규 등록 혹은 업데이트
            if (rstBatchBillMasterVO == null) {
            	insertBillMaster(billYM, tmpCloudId, "BILLPROCSTAT_PROCESS", procUserName, new Date());
            } else {
            	updateBillMaster(rstBatchBillMasterVO, "BILLPROCSTAT_PROCESS", procUserName, new Date());
            }
            
            // 보정을 위해 3개월의 추가 레코드를 미리 만들어 둔다.
            insertNextBillMaster(billYM, 1, "BILLPROCSTAT_NA", procUserName, new Date());
            insertNextBillMaster(billYM, 2, "BILLPROCSTAT_NA", procUserName, new Date());
            insertNextBillMaster(billYM, 3, "BILLPROCSTAT_NA", procUserName, new Date());
        }
		return RepeatStatus.FINISHED;
	}


	private void insertBillMaster(String billYyyymm, String cloudId, String billProcStat, String procUserName, Date procDatetime) {
		BatchBillMasterVO batchBillMasterVO = new BatchBillMasterVO();
		
		batchBillMasterVO.setBillYyyymm(billYyyymm);
		batchBillMasterVO.setCloudId(cloudId);
		batchBillMasterVO.setBillProcStat(billProcStat);
		batchBillMasterVO.setProcUserName(procUserName);
		batchBillMasterVO.setProcDatetime(procDatetime);
		batchBillMasterVO.setConfirnFlag("N");
		batchBillMasterVO.setComfirmUserName(null);
		batchBillMasterVO.setConfirmDatetime(null);
		
		log.debug(batchBillMasterVO.toString());
		
		sqlSessionTemplate.insert(insertBillMaster, batchBillMasterVO);
	}
	
	private void updateBillMaster(BatchBillMasterVO batchBillMasterVO, String billProcStat, String procUserName, Date procDatetime) {
		batchBillMasterVO.setBillProcStat(billProcStat);
		batchBillMasterVO.setProcUserName(procUserName);
		batchBillMasterVO.setProcDatetime(procDatetime);
		
		log.debug(batchBillMasterVO.toString());
		
		sqlSessionTemplate.insert(updateBillMaster, batchBillMasterVO);
	}
	
	private void insertNextBillMaster(String billYyyymm, int nextMonth, String billProcStat, String procUserName, Date procDatetime) {
		Date dateBillYM = DateUtils.convertStringToDate(billYyyymm + "01", "Asia/Seoul", "yyyyMMdd");
		Date nextDateBillYM = DateUtils.addMonths(dateBillYM, nextMonth);
		String billYM = DateUtils.convertDateToString(nextDateBillYM, "Asia/Seoul", "yyyyMM");

		log.debug("billYM=" + billYM);
		
		String[] arrCloud = multiCloudStrList.split(",");
        for( int i = 0 ; i< arrCloud.length; i++) {
        	String tmpCloudId = arrCloud[i];
        	
        	BatchBillMasterVO paramVO = new BatchBillMasterVO();
            paramVO.setBillYyyymm(billYM);
            paramVO.setCloudId(tmpCloudId);
            BatchBillMasterVO resultBatchBillMasterVO = sqlSessionTemplate.selectOne(selectOneBillMaster, paramVO);
            
            if (resultBatchBillMasterVO == null) {
            	insertBillMaster(billYM, tmpCloudId, billProcStat, procUserName, procDatetime);
            }
        }
        
	}
}
