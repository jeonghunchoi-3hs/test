package com.ivucenter.cloud.batch.billing;

import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.ivucenter.cloud.batch.entity.BatchBillMasterVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class EndBillMasterTasklet implements Tasklet {
	
	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
	private final String selectOneBillMaster 	= batchBillingDAO + "selectOneBillMaster";
	private final String updateBillMaster 		= batchBillingDAO + "updateBillMaster";
    
	@Setter
	private SqlSessionFactory sqlSessionFactory;

    @Setter
	private Map<String, Object> parameterValues;

	/* local variable */
	private SqlSessionTemplate sqlSessionTemplate;
	private String billYM;
	private String multiCloudStrList;

	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext context) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);

        this.billYM = (String) this.parameterValues.get("billYM");
        this.multiCloudStrList = (String) this.parameterValues.get("multiCloudStrList");

        // 기존 확정 상태인지 확인
        // 신규 등록 혹은 업데이트
        String[] arrCloud = multiCloudStrList.split(",");
        for( int i = 0 ; i< arrCloud.length; i++) {
        	String tmpCloudId = arrCloud[i];
        	
        	BatchBillMasterVO chkBillMasterVO = new BatchBillMasterVO();
            chkBillMasterVO.setBillYyyymm(billYM);
            chkBillMasterVO.setCloudId(tmpCloudId);
            BatchBillMasterVO rstBatchBillMasterVO = this.sqlSessionTemplate.selectOne(selectOneBillMaster, chkBillMasterVO);
        	if (rstBatchBillMasterVO == null) {
                log.info("BatchBillMasterVO is null..!!");
            	contribution.setExitStatus(ExitStatus.FAILED);
            } else {
            	updateBillMaster(rstBatchBillMasterVO, "BILLPROCSTAT_COMPLETE");
            }
        }        

		return RepeatStatus.FINISHED;
	}
	
	private void updateBillMaster(BatchBillMasterVO batchBillMasterVO, String billProcStat) {
		batchBillMasterVO.setBillProcStat(billProcStat);
		batchBillMasterVO.setConfirnFlag("N");
		log.debug(batchBillMasterVO.toString());
		
		this.sqlSessionTemplate.insert(updateBillMaster, batchBillMasterVO);
	}
}
