package com.ivucenter.cloud.portal.bss.product;

import com.ivucenter.cloud.entity.BssProductVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomBssProductVO extends BssProductVO{

	private String searchKind; // searchAll,sProductName,sProductCategoryName
	private String keyword = "";

	private String productKind; // categoryVm, categoryOs, categoryDisk,
								// categoryService, categoryAdditional

	private String cloudKind = "";	// ALL (cloudId로 대체 필요)

	private String searchValue; // item_name

	private String cloudId;
	private String cloudName;
	private String cloudType;
	private String codeValue;
	private String codeValue1;
	private String codeValue2;
	private String codeValue3;

	private String id;
	private String name;

	//상품카테고리 이름
	private String productCategoryName;
	private String itemName;
	private String quantity;
	private String unit;


	private String delFlagName;

	private String diskDiskGb;

	private String nasGb;
	private String publicipEa;
	private String loadbalancerEa;
	private String scmEa;
	private String backupGb;
	private String securityEa;
	private String mcaEa;

	private String envEa;

	private String serviceEa;
	private String serviceType;
	private String serviceGroupType;

	//item 금액
	private String cpuHourlyPrice;
	private String cpuMonthlyPrice;
	private String cpuQuantity;
	private String memHourlyPrice;
	private String memMonthlyPrice;
	private String memQuantity;

	private String diskHourlyPrice;
	private String diskMonthlyPrice;
	private String diskQuantity;

	private String vmDiskQuantity;
	private String vmDiskHourlyPrice;
	private String vmDiskMonthlyPrice;
	private String nasQuantity;
	private String nasHourlyPrice;
	private String nasMonthlyPrice;
	private String loadbalancerQuantity;
	private String loadbalancerHourlyPrice;
	private String loadbalancerMonthlyPrice;
	private String publicipQuantity;
	private String publicipHourlyPrice;
	private String publicipMonthlyPrice;


	private String serviceQuantity;
	private String serviceHourlyPrice;
	private String serviceMonthlyPrice;

	private String serviceAccountQuantity;
	private String serviceAccountHourlyPrice;
	private String serviceAccountMonthlyPrice;

	private String serviceSecurityQuantity;
	private String serviceSecurityHourlyPrice;
	private String serviceSecurityMonthlyPrice;

	private String serviceBackupQuantity;
	private String serviceBackupHourlyPrice;
	private String serviceBackupMonthlyPrice;

	private String serviceSwQuantity;
	private String serviceSwHourlyPrice;
	private String serviceSwMonthlyPrice;

	private String serviceDiskQuantity;
	private String serviceDiskHourlyPrice;
	private String serviceDiskMonthlyPrice;


	private String backupQuantity;
	private String backupHourlyPrice;
	private String backupMonthlyPrice;
	private String scmQuantity;
	private String scmHourlyPrice;
	private String scmMonthlyPrice;
	private String securityQuantity;
	private String securityHourlyPrice;
	private String securityMonthlyPrice;
	private String mcaQuantity;
	private String mcaHourlyPrice;
	private String mcaMonthlyPrice;

	private String applyDate;
	private String userName;

	private String sanDiskHourlyPrice;
	private String sanDiskMonthlyPrice;
	private String sanDiskQuantity;
	private String sataDiskHourlyPrice;
	private String sataDiskMonthlyPrice;
	private String sataDiskQuantity;
	private String sasDiskHourlyPrice;
	private String sasDiskMonthlyPrice;
	private String sasDiskQuantity;

	private String vmimglinHourlyPrice;
	private String vmimglinMonthlyPrice;
	private String vmimglinQuantity;
	private String vmimgwinHourlyPrice;
	private String vmimgwinMonthlyPrice;
	private String vmimgwinQuantity;
	private String vmimgwebHourlyPrice;
	private String vmimgwebMonthlyPrice;
	private String vmimgwebQuantity;
	private String vmimgwasHourlyPrice;
	private String vmimgwasMonthlyPrice;
	private String vmimgwasQuantity;
	private String vmimgwdbHourlyPrice;
	private String vmimgwdbMonthlyPrice;
	private String vmimgwdbQuantity;
	private String vmimgwdevHourlyPrice;
	private String vmimgwdevMonthlyPrice;
	private String vmimgwdevQuantity;
	private String diskTypeName;
	private String imageTypeName;
	private String quantityHourly;
	private String quantityMonthly;

}
