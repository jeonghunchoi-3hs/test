package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Project;

public interface ProjectIF {

	public Project createProject(Project project) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Project getProject(String project_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Project updateProject(Project project) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean deleteProject(String project_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Project> getProjects() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean isExist(String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Project> getUsersByProject(String user_id)throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
