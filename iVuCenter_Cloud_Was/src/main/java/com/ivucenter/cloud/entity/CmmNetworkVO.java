package com.ivucenter.cloud.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CmmNetworkVO extends DataTableVO {
	public String networkId;
	public String customerHeard;
	public String aClass;
	public String affiliateName;
	public String bClass;
	public String workKind;
	public String workNetKind;
	public String cClass;
	public String cidr;
	public Date regDatetime;
	public String regUserId;
	public Date modDatetime;
	public String modUserId;
	public String useFlag;
	public String companyId;


}
