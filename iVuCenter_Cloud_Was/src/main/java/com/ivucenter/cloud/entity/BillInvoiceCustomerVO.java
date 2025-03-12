package com.ivucenter.cloud.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BillInvoiceCustomerVO extends DataTableVO{
	
	private String billYyyymm;
	private String cloudId;
	private String customerId;
	private String customerName;
	private int vatRate;
	private Date billStartDatetime;
	private Date billEndDatetime;
	
	
}
