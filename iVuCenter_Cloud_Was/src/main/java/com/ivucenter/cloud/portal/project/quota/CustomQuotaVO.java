package com.ivucenter.cloud.portal.project.quota;

import com.ivucenter.cloud.api.openstack.object.OpenStackComplexQuota;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CustomQuotaVO extends OpenStackComplexQuota{

	private String searchKind;
	private String keyword = "";
	
	private String upCompanyName;
	private String customerName;
	private String projectAlias;
	private String projectName2;
	private String deptName;
	private String deptName2;
	private String deptCode;
	private String reqProjectSeq;
	private String vmTotal;
	private String vcpuTotal;
	private String memTotal;
	private String vmAvail;
	private String diskTotal;
	private String vcpuAvail;
	private String memAvail;
	private String diskAvail;




	
	private String customerId;
	
//
//
//	public String getCloudName() {
//		return cloudName;
//	}
//
//	public void setCloudName(String cloudName) {
//		this.cloudName = cloudName;
//	}
//
//	public String getMemTotal() {
//		return memTotal;
//	}
//
//	public void setMemTotal(String memTotal) {
//		this.memTotal = memTotal;
//	}
//	public String getVmTotal() {
//		return vmTotal;
//	}
//
//	public void setVmTotal(String vmTotal) {
//		this.vmTotal = vmTotal;
//	}
//
//	public String getVcpuTotal() {
//		return vcpuTotal;
//	}
//
//	public void setVcpuTotal(String vcpuTotal) {
//		this.vcpuTotal = vcpuTotal;
//	}
//
//	public String getDiskTotal() {
//		return diskTotal;
//	}
//
//	public void setDiskTotal(String diskTotal) {
//		this.diskTotal = diskTotal;
//	}
//
//	public String getReqProjectSeq() {
//		return reqProjectSeq;
//	}
//
//	public void setReqProjectSeq(String reqProjectSeq) {
//		this.reqProjectSeq = reqProjectSeq;
//	}
//	public String getDeptName() {
//		return deptName;
//	}
//
//	public void setDeptName(String deptName) {
//		this.deptName = deptName;
//	}
//
//	public String getDeptCode() {
//		return deptCode;
//	}
//
//	public void setDeptCode(String deptCode) {
//		this.deptCode = deptCode;
//	}
//	public String getKeyword() {
//		return keyword;
//	}
//
//	public void setKeyword(String keyword) {
//		this.keyword = keyword;
//	}
//
//	public String getSearchKind() {
//		return searchKind;
//	}
//
//	public void setSearchKind(String searchKind) {
//		this.searchKind = searchKind;
//	}
//
//	public String getCustomerId() {
//		return customerId;
//	}

//	public void setCustomerId(String customerId) {
//		this.customerId = customerId;
//	}
//	public String getStartDt() {
//		return startDt;
//	}
//	public void setStartDt(String startDt) {
//		this.startDt = startDt;
//	}
//	public String getEndDt() {
//		return endDt;
//	}
//	public void setEndDt(String endDt) {
//		this.endDt = endDt;
//	}
//	public String getUpCompanyName() {
//		return upCompanyName;
//	}
//
//	public void setUpCompanyName(String upCompanyName) {
//		this.upCompanyName = upCompanyName;
//	}
//
//	public String getCustomerName() {
//		return customerName;
//	}
//
//	public void setCustomerName(String customerName) {
//		this.customerName = customerName;
//	}

//	@JsonIgnore
//	public String getOrderDir(){
//		return getOrder().get(0).get("dir");
//	}
//	@JsonIgnore
//	public int getOrderColumnNo(){
//		try {
//			return Integer.parseInt(getOrder().get(0).get("column"));
//		} catch (Exception e) {
//			return 0;
//		}
//	}
//	@JsonIgnore
//	public String getOrderColumn(){
//		return CamelUtil.UnderScoreCase(getColumns().get(getOrderColumnNo()).get("data"));
//	}
//	@JsonIgnore
//	public String getOrderColumnCamel(){
//		return CamelUtil.CamelCase(getColumns().get(getOrderColumnNo()).get("data"));
//	}

//	public void setColumns(List<Map<String, String>> columns) {
//		this.columns = columns;
//	}
//	public List<Map<String, String>> getColumns() {
//		return columns;
//	}
//	public List<Map<String, String>> getOrder() {
//		return order;
//	}
//	public void setOrder(List<Map<String, String>> order) {
//		this.order = order;
//	}
//
//	public int getDraw() {
//		return draw;
//	}
//	public void setDraw(int draw) {
//		this.draw = draw;
//	}
//	public int getStart() {
//		return start;
//	}
//	public void setStart(int start) {
//		this.start = start;
//	}
//	public int getLength() {
//		return length;
//	}
//	public void setLength(int length) {
//		this.length = length;
//	}


	/**
	 * @return the errorStatus
	 */
//	public String getErrorStatus() {
//		return errorStatus;
//	}
	/**
	 * @param errorStatus the errorStatus to set
	 */
//	public void setErrorStatus(String errorStatus) {
//		this.errorStatus = errorStatus;
//	}

}
