package com.ivucenter.cloud.batch.billing;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.beans.factory.annotation.Autowired;

import com.ivucenter.cloud.batch.entity.BatchBillChargeResourceDetailVO;
import com.ivucenter.cloud.batch.entity.BatchBillChargeResourceVO;
import com.ivucenter.cloud.batch.entity.BatchMeteringMeasureVO;

import lombok.Setter;

public class InsertBillChargeVmResourceDetailMemProcessor implements ItemProcessor<BatchBillChargeResourceVO, List<BatchBillChargeResourceDetailVO>> {
	
	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
	private final String selectListMeteringMeasureMem 	= batchBillingDAO + "selectListMeteringMeasureMem";
	
	@Autowired
	private CommonBillService commonBillService;

    @Setter
	private SqlSessionFactory sqlSessionFactory;
        
    @Setter
	private Map<String, Object> parameterValues;
	
	private SqlSessionTemplate sqlSessionTemplate;
//	private String billYM;
//    private Date baseBillStartDate;
//    private Date baseBillEndDate;
    
	@Override
	public List<BatchBillChargeResourceDetailVO> process(BatchBillChargeResourceVO item) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);
		
//        this.billYM = (String) this.parameterValues.get("billYM");
//        this.baseBillStartDate = (Date) this.parameterValues.get("baseBillStartDate");
//        this.baseBillEndDate = (Date) this.parameterValues.get("baseBillEndDate");

		List<BatchMeteringMeasureVO> measures = this.sqlSessionTemplate.selectList(selectListMeteringMeasureMem, item);
			
		List<BatchBillChargeResourceDetailVO> details = commonBillService.generateChargeVmResourceDetail(item, measures);

		if ("N".equals(item.getHourlyFlag())) {		
			details = commonBillService.generateMonthlyChargeVmResourceDetail(details);
		}
		
		return details;
	}
}
