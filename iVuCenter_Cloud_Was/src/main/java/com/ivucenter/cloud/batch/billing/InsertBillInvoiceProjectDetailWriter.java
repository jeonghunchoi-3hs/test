package com.ivucenter.cloud.batch.billing;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchBillInvoiceProjectDetailVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class InsertBillInvoiceProjectDetailWriter implements ItemWriter<BatchBillInvoiceProjectDetailVO> {	

	private final String insertBillInvoiceProjectDetail = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.insertBillInvoiceProjectDetail";

    @Setter
	private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
	
	private SqlSessionTemplate sqlSessionTemplate;
//	private String billYM;
//    private Date baseBillStartDate;
//    private Date baseBillEndDate;

	@Override
	public void write(List<? extends BatchBillInvoiceProjectDetailVO> items) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);
		
//        this.billYM = (String) this.parameterValues.get("billYM");
//        this.baseBillStartDate = (Date) this.parameterValues.get("baseBillStartDate");
//        this.baseBillEndDate = (Date) this.parameterValues.get("baseBillEndDate");

        
        for (BatchBillInvoiceProjectDetailVO item : items) {
			item.setInvoiceItem(InvoiceTemplate.VIRTUAL_MACHINE.getCode());
			item.setInvoiceItemSub("*");
			item.setInvoiceItemName(InvoiceTemplate.VIRTUAL_MACHINE.getLabel());
			item.setInvoiceItemDepth(InvoiceTemplate.VIRTUAL_MACHINE.getDepth());

			log.debug(item.toString());
			//sqlSessionTemplate.insert(insertBillInvoiceProjectDetail, item);
        }
		
	}

}
