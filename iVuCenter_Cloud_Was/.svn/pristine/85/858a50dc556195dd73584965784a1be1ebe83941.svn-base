package com.ivucenter.cloud.batch.billing;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateUtils;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchBillChargeDiskVO;

import lombok.Setter;


public class InsertBillChargeDiskWriter implements ItemWriter<BatchBillChargeDiskVO> {

	private final String batchBillingDAO = "com.ivucenter.cloud.batch.billing.BatchBillingDAO.";
	
	private final String insertBillChargeDisk 	= batchBillingDAO + "insertBillChargeDisk";
    
	@Setter
	private SqlSessionFactory sqlSessionFactory;

	@Setter
	private Map<String, Object> parameterValues;

	private SqlSessionTemplate sqlSessionTemplate;
//	private String billYM;
    private Date baseBillStartDate;
    private Date baseBillEndDate;

	@Override
	public void write(List<? extends BatchBillChargeDiskVO> items) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);
		
//        this.billYM = (String) this.parameterValues.get("billYM");
        this.baseBillStartDate = (Date) this.parameterValues.get("baseBillStartDate");
        this.baseBillEndDate = (Date) this.parameterValues.get("baseBillEndDate");

        for (BatchBillChargeDiskVO item : items) {
        	
        	if (item.getChargeStartDatetime().before(baseBillStartDate)) {
        		item.setChargeStartDatetime(baseBillStartDate);
        	}
        	
        	if (item.getChargeEndDatetime() == null || item.getChargeEndDatetime().after(baseBillEndDate)) {
        		item.setChargeEndDatetime(baseBillEndDate);
        	}
        	
    		Date fixedEndDate = item.getChargeEndDatetime(); 

    		// 시간단위, 월단위
        	if ("Y".equals(item.getHourlyFlag())) {		// 시간단위
        		// 시작 시간 변경
        		item.setChargeStartDatetime(DateUtils.truncate(item.getChargeStartDatetime(), Calendar.HOUR_OF_DAY));

        		// 종료 시간 변경
        		fixedEndDate = DateUtils.truncate(fixedEndDate, Calendar.HOUR_OF_DAY);
        		if (!item.getChargeEndDatetime().equals(fixedEndDate)) {
        			item.setChargeEndDatetime(DateUtils.addHours(fixedEndDate, 1));
        		}
        	} else {		// 월단위
        		// 시작 일자 변경
        		item.setChargeStartDatetime(DateUtils.truncate(item.getChargeStartDatetime(), Calendar.DAY_OF_MONTH));
        		
        		// 종료 일자 변경
        		fixedEndDate = DateUtils.truncate(fixedEndDate, Calendar.DAY_OF_MONTH);
        		if (!item.getChargeEndDatetime().equals(fixedEndDate)) {
        			item.setChargeEndDatetime(DateUtils.addDays(fixedEndDate, 1));
        		}
        	}
        	
        	this.sqlSessionTemplate.insert(insertBillChargeDisk, item);
        }		
	}
}
