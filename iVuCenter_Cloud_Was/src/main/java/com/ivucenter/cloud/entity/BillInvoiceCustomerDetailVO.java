package com.ivucenter.cloud.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BillInvoiceCustomerDetailVO extends DataTableVO{
	
	private String billYyyymm;
	private String cloudId;
	private String customerId;
	private String invoiceItem;
	private String invoiceItemSub;
	private String invoiceItemName;
	private int invoiceItemDepth;
	private int amount;		
	
}
