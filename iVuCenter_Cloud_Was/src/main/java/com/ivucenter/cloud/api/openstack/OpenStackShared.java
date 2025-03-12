package com.ivucenter.cloud.api.openstack;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Token;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

public class OpenStackShared {

	protected CustomOssCloudVO cloudVo;

//	protected String ADMIN_DOMAIN;
//	protected String ADMIN_PROJECT;
//	protected String ADMIN_USERNAME;
//	protected String ADMIN_PASSWORD;
//	protected String PROJECT_USERNAME;
//	protected String PROJECT_PASSWORD;

	protected String current_project;
	protected String current_project_id;
	protected String current_user;
	protected String current_user_id;

	public String getProjectName() 	{ return this.current_project; }
	public String getProjectId() 	{ return this.current_project_id; }
	public String getUserName() 	{ return this.current_user; }
	public String getUserId() 		{ return this.current_user_id; }

	protected String currentInfo() {
		String returnStr = "\r\n==================================================\r\n";
		returnStr = returnStr + "Current proj nm : "+current_project + "\r\n";
		returnStr = returnStr + "Current proj id : "+current_project_id + "\r\n";
		returnStr = returnStr + "Current user nm : "+current_user + "\r\n";
		returnStr = returnStr + "Current user id : "+current_user_id + "\r\n";
		returnStr = returnStr + "==================================================\r\n";
		return returnStr;
	}

	public String getAdminToken(CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		Token token = OpenStackTokenManager.getAdminToken(cloudVo);
		this.current_project   	= token.getProject().getName();
		this.current_project_id = token.getProject().getId();
		this.current_user 		= token.getUser().getName();
		this.current_user_id 	= token.getUser().getId();

		return token.getSubjectToken();
	}

	public String getAdminToken(String project_name,CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		Token token = OpenStackTokenManager.getAdminToken(cloudVo, project_name);

		 this.current_project = token.getProject().getName();
		 this.current_project_id = token.getProject().getId();
		 this.current_user = token.getUser().getName();
		 this.current_user_id = token.getUser().getId();

		 return token.getSubjectToken();
	}

	public String getProjectToken(String project_name,CustomOssCloudVO cloudVo)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {

		Token token = OpenStackTokenManager.getProjectToken(cloudVo, project_name);

		 this.current_project = token.getProject().getName();
		 this.current_project_id = token.getProject().getId();
		 this.current_user = token.getUser().getName();
		 this.current_user_id =	token.getUser().getId();

		return token.getSubjectToken();
	}
}
