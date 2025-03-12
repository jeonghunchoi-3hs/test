package com.ivucenter.cloud.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OssScaleOutVO extends DataTableVO {
	
	
	private String searchKind;
	private String keyword = "";
	private String scaleOutUid;
	private String scaleOutName;
	private String hpaDivision;
	private String appUid;
	private int hpaMin;
	private int hpaMax;
	private int hpaContinue;
	private int hpaMinPod;
	private int hpaMaxPod;
	private String hpaIncrePod;
	private String hourlyFlag;
	private Date regDatetime;
	private String regUserId;
	private Date modDatetime;
	private String modUserId;
	private String delFlag;  
	
}
