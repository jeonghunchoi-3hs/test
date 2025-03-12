package com.ivucenter.cloud.portal.home;

import java.util.List;

import com.ivucenter.cloud.portal.oss.disk.CustomStorageVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomMbrHomeVO {

	private String serviceTypeApache;
	private String serviceTypeTomcat;
	private String serviceTypeJboss;
	private String serviceTypeMariadb;
	private String serviceTypePostgresql;
	private String serviceTypeCubrid;

	private String amountAccount;
    private String amountSecurity;
    private String amountBackup;
    private String amountSw;
    private String amountDisk;
    private String zoneName;
    private String zoneDisplayName;
    private String projectBoxId;

	private String runningCnt;
	private String rejectCnt;
	private String endCnt;

	private String loginUserId;
	private String serverCnt;
	private String vcpus;
	private String memGb;
	private String diskGb;

	private String osDisk;
	private String dataDisk;

	private String billYyyymm;
	private String resourceType;
	private String resultValue;


	private String nasGb;
	private String loadbalancerCnt;
	private String backupGb;
	private String publicipCnt;
	private String mcaCnt;
	private String scmCnt;
	private String securityCnt;

	private String projectId;
	private String projectName;
	private String projectAlias;
	private String networkId;
	private String networkName;
	private String networkAlias;
	private String apprvProcessingCnt;

	private String workProcessingCnt;
	private String apprvCompletedCnt;
	private String apprvRejectedCnt;
	private String orderDatetime;
	private String orderCount;
	private String amount;
	private String orderNo;
	private String orderUserId;
	private String orderUserName;
	private String apprvState;
	private String apprvStateName;
	private String customerId;
	private String customerName;
	private String rolechk;

	private int m01;
	private int m02;
	private int m03;
	private int m04;
	private int m05;
	private int m06;
	private int m07;
	private int m08;
	private int m09;
	private int m10;
	private int m11;
	private int m12;
	private String searchMonth01;
	private String searchMonth02;
	private String searchMonth03;
	private String searchMonth04;
	private String searchMonth05;
	private String searchMonth06;
	private String searchMonth07;
	private String searchMonth08;
	private String searchMonth09;
	private String searchMonth10;
	private String searchMonth11;
	private String searchMonth12;
	private String group;
	private String invoiceItem;
	private String customerCnt;
	private String projectCnt;

	private String qnaNo;
	private String noticeNo;
	private String noticeType;
	private String title;
	private String content;
	private String month;
	private String replyCnt;
	private String regName;
	private String regDatetime;

	// cloud 사용량
	private int vmTotal;
	private int vmUsed;
	private int vmAvail;
	private int vcpuTotal;
	private int vcpuUsed;
	private int vcpuAvail;
	private int memTotal;
	private int memUsed;
	private int memAvail;
	private int diskTotal;
	private int diskUsed;
	private int diskAvail;
	private int nasTotal;
	private int nasUsed;
	private int nasAvail;
	private String collDatetime;


	// cloud service 건수
	private String vmCnt;
	private String vcpusCnt;
	private String memCnt;
	private String diskCnt;
	private String sizeCnt;
	private String nasCnt;
	private String lbCnt;
	private String ipCnt;
	private String backCnt;
	private String secCnt;

	// cloud amount
	private String totAmount;
	private String vmAmount;
	private String diskAmount;
	private String nasAmount;
	private String ipAmount;
	private String backAmount;
	private String mcaAmount;
	private String lbAmount;
	private String secAmount;
	private String scmAmount;
	private String disAmount;
	private String adjAmount;

	// my job count
	private String myGoodCount;
	private String myWorkCount;
	private String myBillCount;

	private String completedCount;
	private String rejectedCount;
	private String processingCount;

	private String applyCount;
	private String workingCount;


	private String projectReqCount;
	private String projecApproveCount;
    private String productReqCount;
    private String productApproveCount;

	private String serviceTypeAccount;
    private String serviceTypeSecurity;
    private String serviceTypeBackup;
    private String serviceTypeSw;
    private String serviceTypeDisk;
	private String serviceTypeAutoscale;
	private String serviceTypeApplicationRedistribution;

	private String serviceTypeOracle;
	private String serviceTypeLoadbalancer;
	private String serviceTypeSnapshot;

	private String serviceTypeAscl;
	private String serviceTypeCtntrmnl;

    private String myCnt;

	private String companyCnt;
    private String vcpuCnt;
    private String osDiskCnt;
    private String osDiskSizeGb;
    private String dataDiskCnt;
    private String dataDiskSizeGb;
    private String hiwareServiceCnt;
    private String tivoliServiceCnt;
    private String backupServiceCnt;
    private String swServiceCnt;
    private String diskServiceCnt;

    private Double vmAvr;
	private Double vcpuAvr;
    private Double memAvr;
    private Double diskAvr;

    private String cloudName;
    private String cloudType;
    private String cloudId;

    private int project;
    private int lProject;

    private int lVmUsed;

    private String regMonth;
    private String viewPoint;

    private List<CustomStorageVO> storageList;
    private int userCount;
}
