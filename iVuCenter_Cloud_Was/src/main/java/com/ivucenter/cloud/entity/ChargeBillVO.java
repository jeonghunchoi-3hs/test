package com.ivucenter.cloud.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChargeBillVO extends DataTableVO{
	
	// bil_master
	private String billYyyymm;
	private String cloudId;
	private String billProcStat;
	private String procUserName;
	private String procDatetime;
	private String confirnFlag;
	private String comfirmUserName;
	private String confirmDatetime; 
	
	// bill_invoice_customer
	private String customerId;
	private String customerName;
	private String vatRate;
	
	// bill_invoice_customer_detail
	private String invoiceItem;
	private String invoiceItemSub;
	private String invoiceItemName;
	private String invoiceItemDepth;
	private String amount;
	private String billStartDatetime;
	private String billEndDatetime;
	
	private String projectId;
	private String projectAlias;
	private String projectName;
	
	// bill_charge_vm
	private String vmUuid;
	private String hostname;
	private String hostnameAlias;
	private String chargeResourceStatus;
	private String hourlyFlag;
	private String createDatetime;
	private String expireDatetime;
	private String chargeStartDatetime;
	private String chargeEndDatetime;

	// bill_charge_vm_resource
	private String resourceId;
	private String resourceItem;
	
	// *_resource_detail
	private String duration;
	private String measureValue;
	private String price;
	
	//bill_charge_*
	private String diskId;
	private String nasId;
	private String loadbalancerId;
	private String publicipId;
	private String backupId;
	private String scmId;
	private String mcaId;
	private String securityId;
}
