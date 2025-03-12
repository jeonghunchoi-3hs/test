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
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class InsertBillChargeVmResourceDetailCpuProcessor implements ItemProcessor<BatchBillChargeResourceVO, List<BatchBillChargeResourceDetailVO>> {
	
	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
	private final String selectListMeteringMeasureCpu 	= batchBillingDAO + "selectListMeteringMeasureCpu";

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
//    private String multiCloudStrList;
    
	@Override
	public List<BatchBillChargeResourceDetailVO> process(BatchBillChargeResourceVO item) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);
		
//        this.billYM = (String) this.parameterValues.get("billYM");
//        this.baseBillStartDate = (Date) this.parameterValues.get("baseBillStartDate");
//        this.baseBillEndDate = (Date) this.parameterValues.get("baseBillEndDate");
//        this.multiCloudStrList = (String) this.parameterValues.get("multiCloudStrList");
		
        /* 미터링 정보 수집 */
		List<BatchMeteringMeasureVO> measures = this.sqlSessionTemplate.selectList(selectListMeteringMeasureCpu, item);
			
		/* 변동분 계산 */
		List<BatchBillChargeResourceDetailVO> details = commonBillService.generateChargeVmResourceDetail(item, measures);

		/* 월단위 변동분 수정 */
		if ("N".equals(item.getHourlyFlag())) {
		
			details = commonBillService.generateMonthlyChargeVmResourceDetail(details);
		}
		
		details.forEach(a -> log.debug(a.toString()));
		
		return details;
	}
}
