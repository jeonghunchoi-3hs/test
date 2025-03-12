package com.ivucenter.cloud.batch.entity;

import com.ivucenter.cloud.entity.BillInvoiceCustomerDetailVO;

public class BatchBillInvoiceCustomerDetailVO extends BillInvoiceCustomerDetailVO {
	private int vatRate;

	public int getVatRate() {
		return vatRate;
	}
	public void setVatRate(int vatRate) {
		this.vatRate = vatRate;
	}
	
}
