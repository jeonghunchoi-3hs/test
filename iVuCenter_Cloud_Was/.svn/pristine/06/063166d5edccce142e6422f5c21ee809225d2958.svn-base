package com.ivucenter.cloud.batch.billing;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchBillInvoiceProjectVO;
import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.Setter;

public class InsertBillInvoiceProjectWriter implements ItemWriter<BatchBillInvoiceProjectVO> {

	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
	private final String insertBillInvoiceProject 	= batchBillingDAO + "insertBillInvoiceProject";

	@Setter
	private SqlSessionFactory sqlSessionFactory;
    
	@Setter
	private Map<String, Object> parameterValues;
	
	private SqlSessionTemplate sqlSessionTemplate;
	private String billYM;
    private Date baseBillStartDate;
    private Date baseBillEndDate;
    
	@Override
	public void write(List<? extends BatchBillInvoiceProjectVO> items) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);
		
		 this.billYM = (String) this.parameterValues.get("billYM");

	        baseBillEndDate = DateUtils.convertStringToDate(billYM + "01", "Asia/Seoul", "yyyyMMdd");
	        baseBillStartDate = DateUtils.addMonths(baseBillEndDate, -1);
	        baseBillEndDate = DateUtils.addDays(baseBillEndDate, -1);
        
        for (BatchBillInvoiceProjectVO item : items) {
        	
        	if( item.getProjectName().equals("demo") 
        	 || item.getProjectName().equals("service") 
        	 || item.getProjectName().equals("services") ) {
        		continue;
        	}
			
        	item.setBillYyyymm(billYM); 
			item.setBillStartDatetime(baseBillStartDate);
			item.setBillEndDatetime(baseBillEndDate);
			
			this.sqlSessionTemplate.insert(insertBillInvoiceProject, item);
        }		
	}

}
