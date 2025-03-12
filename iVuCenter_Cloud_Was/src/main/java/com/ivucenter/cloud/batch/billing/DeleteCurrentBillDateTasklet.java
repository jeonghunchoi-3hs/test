package com.ivucenter.cloud.batch.billing;

import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.ivucenter.cloud.batch.entity.BatchBillChargeResourceDetailVO;
import com.ivucenter.cloud.batch.entity.BatchBillChargeResourceVO;
import com.ivucenter.cloud.batch.entity.BatchBillChargeVmVO;
import com.ivucenter.cloud.batch.entity.BatchBillInvoiceCustomerDetailVO;
import com.ivucenter.cloud.batch.entity.BatchBillInvoiceCustomerVO;
import com.ivucenter.cloud.batch.entity.BatchBillInvoiceProjectDetailVO;
import com.ivucenter.cloud.batch.entity.BatchBillInvoiceProjectVO;

import lombok.Setter;

public class DeleteCurrentBillDateTasklet implements Tasklet {

	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";

	private final String deleteBillInvoiceCustomer 						= batchBillingDAO + "deleteBillInvoiceCustomer";
	private final String deleteBillInvoiceCustomerDetail 				= batchBillingDAO + "deleteBillInvoiceCustomerDetail";
	private final String deleteBillInvoiceProject 						= batchBillingDAO + "deleteBillInvoiceProject";
	private final String deleteBillInvoiceProjectDetail 				= batchBillingDAO + "deleteBillInvoiceProjectDetail";
	private final String deleteBillChargeVm 							= batchBillingDAO + "deleteBillChargeVm";
	private final String deleteBillChargeVmResource 					= batchBillingDAO + "deleteBillChargeVmResource";
	private final String deleteBillChargeVmResourceDetail 				= batchBillingDAO + "deleteBillChargeVmResourceDetail";
	private final String deleteBillChargeDisk 							= batchBillingDAO + "deleteBillChargeDisk";
	private final String deleteBillChargeDiskResource 					= batchBillingDAO + "deleteBillChargeDiskResource";
	private final String deleteBillChargeDiskResourceDetail 			= batchBillingDAO + "deleteBillChargeDiskResourceDetail";
    
	@Setter
	private SqlSessionFactory sqlSessionFactory;

	@Setter
	private Map<String, Object> parameterValues;

	/* local variable */
	private SqlSessionTemplate sqlSessionTemplate;
	private String billYM;

	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext context) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);

        this.billYM = (String) this.parameterValues.get("billYM");

        deleteBillInvoiceCustomer(billYM);
        deleteBillInvoiceCustomerDetail(billYM);
        deleteBillInvoiceProject(billYM);
        deleteBillInvoiceProjectDetail(billYM);
        deleteBillChargeVm(billYM);
        deleteBillChargeVmResource(billYM);
        deleteBillChargeVmResourceDetail(billYM);
        deleteBillChargeDisk(billYM);
        deleteBillChargeDiskResource(billYM);
        deleteBillChargeDiskResourceDetail(billYM);
		return RepeatStatus.FINISHED;
	}

	private void deleteBillInvoiceCustomer(String billYyyymm) {
		BatchBillInvoiceCustomerVO paramVO = new BatchBillInvoiceCustomerVO();
		paramVO.setBillYyyymm(billYyyymm);

		this.sqlSessionTemplate.insert(deleteBillInvoiceCustomer, paramVO);
	}

	private void deleteBillInvoiceCustomerDetail(String billYyyymm) {
		BatchBillInvoiceCustomerDetailVO paramVO = new BatchBillInvoiceCustomerDetailVO();
		paramVO.setBillYyyymm(billYyyymm);

		this.sqlSessionTemplate.insert(deleteBillInvoiceCustomerDetail, paramVO);
	}

	private void deleteBillInvoiceProject(String billYyyymm) {
		BatchBillInvoiceProjectVO paramVO = new BatchBillInvoiceProjectVO();
		paramVO.setBillYyyymm(billYyyymm);

		this.sqlSessionTemplate.insert(deleteBillInvoiceProject, paramVO);
	}

	private void deleteBillInvoiceProjectDetail(String billYyyymm) {
		BatchBillInvoiceProjectDetailVO paramVO = new BatchBillInvoiceProjectDetailVO();
		paramVO.setBillYyyymm(billYyyymm);

		this.sqlSessionTemplate.insert(deleteBillInvoiceProjectDetail, paramVO);
	}

	private void deleteBillChargeVm(String billYyyymm) {
		BatchBillChargeVmVO paramVO = new BatchBillChargeVmVO();
		paramVO.setBillYyyymm(billYyyymm);

		this.sqlSessionTemplate.insert(deleteBillChargeVm, paramVO);
	}

	private void deleteBillChargeVmResource(String billYyyymm) {
		BatchBillChargeResourceVO paramVO = new BatchBillChargeResourceVO();
		paramVO.setBillYyyymm(billYyyymm);

		this.sqlSessionTemplate.insert(deleteBillChargeVmResource, paramVO);
	}

	private void deleteBillChargeVmResourceDetail(String billYyyymm) {
		BatchBillChargeResourceDetailVO paramVO = new BatchBillChargeResourceDetailVO();
		paramVO.setBillYyyymm(billYyyymm);

		this.sqlSessionTemplate.insert(deleteBillChargeVmResourceDetail, paramVO);
	}

	private void deleteBillChargeDisk(String billYyyymm) {
		BatchBillChargeResourceDetailVO paramVO = new BatchBillChargeResourceDetailVO();
		paramVO.setBillYyyymm(billYyyymm);

		this.sqlSessionTemplate.insert(deleteBillChargeDisk, paramVO);
	}

	private void deleteBillChargeDiskResource(String billYyyymm) {
		BatchBillChargeResourceDetailVO paramVO = new BatchBillChargeResourceDetailVO();
		paramVO.setBillYyyymm(billYyyymm);

		this.sqlSessionTemplate.insert(deleteBillChargeDiskResource, paramVO);
	}

	private void deleteBillChargeDiskResourceDetail(String billYyyymm) {
		BatchBillChargeResourceDetailVO paramVO = new BatchBillChargeResourceDetailVO();
		paramVO.setBillYyyymm(billYyyymm);

		this.sqlSessionTemplate.insert(deleteBillChargeDiskResourceDetail, paramVO);
	}
}
