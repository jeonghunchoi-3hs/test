package com.ivucenter.cloud.batch.billing;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.ivucenter.cloud.batch.entity.BatchBillChargeResourceDetailVO;
import com.ivucenter.cloud.batch.entity.BatchBillChargeResourceVO;
import com.ivucenter.cloud.batch.entity.BatchBillPolicyItemPriceVO;
import com.ivucenter.cloud.batch.entity.BatchMeteringMeasureVO;
import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j	
@Service("commonBillService")
public class CommonBillService {	
	
	/********************************************
	 * generateChargeVmResourceDetail
	 * @param item
	 * @param measures
	 * @return List<BatchBillChargeVmResourceDetailVO>
	 * 		해당 자원에 대하여 기본적인 변동분을 작성한다.
	 ********************************************/
	public List<BatchBillChargeResourceDetailVO> generateChargeVmResourceDetail(BatchBillChargeResourceVO item, List<BatchMeteringMeasureVO> measures) {
		log.debug("===============> generateChargeVmResourceDetail");
		
		List<BatchBillChargeResourceDetailVO> details = new ArrayList<BatchBillChargeResourceDetailVO>();

		
		Date billStartDatetime = item.getChargeStartDatetime();
		Date billEndDatetime = item.getChargeEndDatetime();

		double originMeteringValue = 0d;
		double currentMeteringValue = 0d;
		Date chargeStartDatetime = billStartDatetime;
		Date chargeEndDatetime = billStartDatetime;

		for (BatchMeteringMeasureVO measure : measures) {
			BatchBillChargeResourceDetailVO detail = new BatchBillChargeResourceDetailVO();
			
			detail.setBillYyyymm(item.getBillYyyymm());
			detail.setCloudId(item.getCloudId());
			detail.setCustomerId(item.getCustomerId());
			detail.setProjectId(item.getProjectId());
			detail.setResourceId(item.getResourceId());
			detail.setResourceItem(item.getResourceItem());
			detail.setAmount(0);
			detail.setHourlyFlag(item.getHourlyFlag());
			detail.setServiceType(item.getServiceType());
			detail.setVolumeType(item.getVolumeType());

			if (!measure.getMeteringDatetime().before(item.getChargeStartDatetime()) 
					&& measure.getMeteringDatetime().before(item.getChargeEndDatetime())) {

				currentMeteringValue = measure.getMeteringValue();
				chargeEndDatetime = measure.getMeteringDatetime();
				
				if (originMeteringValue != currentMeteringValue) {
					if (originMeteringValue != 0) {
						detail.setMeasureValue(originMeteringValue);
						detail.setChargeStartDatetime(chargeStartDatetime);
						detail.setChargeEndDatetime(chargeEndDatetime);

						
						details.add(detail);
						
						chargeStartDatetime = chargeEndDatetime;
					}
					
					originMeteringValue = currentMeteringValue;
				}
			}
		}

		if (chargeStartDatetime.before(billEndDatetime)) {
			BatchBillChargeResourceDetailVO detail = new BatchBillChargeResourceDetailVO();
			
			detail.setBillYyyymm(item.getBillYyyymm());
			detail.setCloudId(item.getCloudId());
			detail.setCustomerId(item.getCustomerId());
			detail.setProjectId(item.getProjectId());
			detail.setResourceId(item.getResourceId());
			detail.setResourceItem(item.getResourceItem());
			detail.setAmount(0);
			detail.setHourlyFlag(item.getHourlyFlag());
			
			detail.setMeasureValue(currentMeteringValue);
			detail.setChargeStartDatetime(chargeStartDatetime);
			detail.setChargeEndDatetime(billEndDatetime);
			detail.setServiceType(item.getServiceType());
			detail.setVolumeType(item.getVolumeType());
			
			details.add(detail);
		}
		
		return details;
	}
	
	
	
	/********************************************
	 * generateMonthlyChargeVmResourceDetail
	 * @param details
	 * @return List<BatchBillChargeVmResourceDetailVO
	 * 		Monthly 형식으로 수정한다.
	 ********************************************/
	public  List<BatchBillChargeResourceDetailVO> generateMonthlyChargeVmResourceDetail(List<BatchBillChargeResourceDetailVO> details) {
		log.debug("===============> generateMonthlyChargeVmResourceDetail");
		
		List<BatchBillChargeResourceDetailVO> monthlyDetails = new ArrayList<BatchBillChargeResourceDetailVO>();

		Date chargeStartDatetime = null;
		Date chargeEndDatetime = null;
		for (BatchBillChargeResourceDetailVO detail : details) {
			chargeStartDatetime = DateUtils.truncate(detail.getChargeStartDatetime(), Calendar.DAY_OF_MONTH);
			chargeEndDatetime = DateUtils.truncate(detail.getChargeEndDatetime(), Calendar.DAY_OF_MONTH);
			
			detail.setChargeStartDatetime(chargeStartDatetime);
			detail.setChargeEndDatetime(chargeEndDatetime);
			
			if (!detail.getChargeStartDatetime().equals(detail.getChargeEndDatetime())) {
				monthlyDetails.add(detail);
			}
			
			chargeStartDatetime = chargeEndDatetime;
		}
		
		return monthlyDetails;
	};
	
	
	
	public BatchBillChargeResourceDetailVO getChargeResourceDetail(int year, int month, BatchBillChargeResourceDetailVO detail, BatchBillPolicyItemPriceVO itemPrice) {
		try {
			int quantity = itemPrice.getQuantity();
		double hourlyPrice = itemPrice.getHourlyPrice();
		double monthlyPrice = itemPrice.getMonthlyPrice();
		long duration = 0l;
		double price = 0d;
		int amount = 0;

		
			
		
		/* calculate amount */
		if("Y".equals(detail.getHourlyFlag())) {	// 시간단위
			duration = DateUtils.diffHours(detail.getChargeStartDatetime(), detail.getChargeEndDatetime());
			price = hourlyPrice;
			
			amount = (int) (((double)detail.getMeasureValue() / (double)quantity) * (double)duration * (double)price);
		} else {	// 월단위
			duration = DateUtils.diffDays(detail.getChargeStartDatetime(), detail.getChargeEndDatetime());
			long lastDayOfMonth = DateUtils.lastDayOfMonth(year, month);
			
			price = monthlyPrice;
			
			amount = (int) (((double)detail.getMeasureValue() / (double)quantity) * (((double)duration / (double)lastDayOfMonth) * price));
			log.debug("(double)detail.getMeasureValue()=" + (double)detail.getMeasureValue() + 
					", (double)quantity=" + (double)quantity +
					", (double)duration=" + (double)duration +
					", (double)lastDayOfMonth=" + (double)lastDayOfMonth +
					", year=" + year + ", month=" + month + 
					", price=" + price);
		}
		
		detail.setHourlyFlag(detail.getHourlyFlag());
		detail.setDuration((int) duration);
		detail.setPrice(price);
		detail.setAmount(amount);
		detail.setVolumeType(detail.getVolumeType());
		detail.setImageItemId(detail.getImageItemId());
		} catch (Exception e) {
			log.debug("dddddddddddddddddddd:" + e.getMessage());
		}
		return detail;
	}
	
	public BatchBillChargeResourceDetailVO getChargeResourceDetailSub(int year, int month, BatchBillChargeResourceDetailVO detail, BatchBillPolicyItemPriceVO itemPrice) {
		int quantity = itemPrice.getQuantity();
		double hourlyPrice = itemPrice.getHourlyPrice();
		double monthlyPrice = itemPrice.getMonthlyPrice();
		long duration = 0l;
		double price = 0d;
		int amount = 0;

		/* calculate amount */
		if("Y".equals(detail.getHourlyFlag())) {	// 시간단위
			duration = DateUtils.diffHours(detail.getChargeStartDatetime(), detail.getChargeEndDatetime());
			price = hourlyPrice;
			
			amount = (int) (((double)detail.getMeasureValue() / (double)quantity) * (double)duration * (double)price);
		} else {	// 월단위
			duration = DateUtils.diffDays(detail.getChargeStartDatetime(), detail.getChargeEndDatetime());
			long lastDayOfMonth = DateUtils.lastDayOfMonth(year, month);
			
			price = monthlyPrice;
			
			amount = (int) (((double)detail.getMeasureValue() / (double)quantity) * (((double)duration / (double)lastDayOfMonth) * price));
			log.debug("(double)detail.getMeasureValue()=" + (double)detail.getMeasureValue() + 
					", (double)quantity=" + (double)quantity +
					", (double)duration=" + (double)duration +
					", (double)lastDayOfMonth=" + (double)lastDayOfMonth +
					", year=" + year + ", month=" + month + 
					", price=" + price);
		}
		
		detail.setAmountSub(amount);
		
		return detail;
	}
	
}
