package com.ivucenter.cloud.batch.metering;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.item.ItemReader;
import org.springframework.batch.item.NonTransientResourceException;
import org.springframework.batch.item.ParseException;
import org.springframework.batch.item.UnexpectedInputException;
import org.springframework.beans.factory.annotation.Autowired;

import com.ivucenter.cloud.api.AbstractFactory;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.ProjectIF;
import com.ivucenter.cloud.api.openstack.object.Links_;
import com.ivucenter.cloud.api.openstack.object.Project;
import com.ivucenter.cloud.api.vRealize.interfaces.vraAbstractFactory;
import com.ivucenter.cloud.api.vRealize.interfaces.vraProjectIF;
import com.ivucenter.cloud.api.vRealize.object.vraProjectObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SyncProjectReader implements ItemReader<Project> {

    private static final Logger logger = LoggerFactory.getLogger(SyncProjectReader.class);

	private List<Project> projectList = null;

	@Autowired
	private OssCloudService ossCloudService;

	@Override
	public Project read() throws Exception, UnexpectedInputException, ParseException, NonTransientResourceException {

		initialize();

		if (this.projectList.isEmpty()) {
			this.projectList = null;
			return null;
		}

		return this.projectList.remove(0);
	}

	private void initialize() {

		if(null != this.projectList) { return ; }
		this.projectList = new ArrayList<>();

		List<CustomOssCloudVO> lists = ossCloudService.getCloudList();
		for (CustomOssCloudVO list : lists) {

			if(list.getCloudType().equals("openstack")) {

				ProjectIF projectIf = AbstractFactory.getProject(list);	//프로젝트 정보
				try {
					this.projectList.addAll(projectIf.getProjects());
				} catch (InvaildOpenStackException | NotSupportGatewayException | NotConnectGatewayException e) {
					log.error(e.getMessage());
				}
			} else if(list.getCloudType().equals("vmware")) {
				vraProjectIF projectIF = vraAbstractFactory.getProject(list);
				try {
					List<Project> projects = new ArrayList<Project>();
					List<vraProjectObject> projectList = projectIF.getProjects().getContent();
					for(vraProjectObject project : projectList) {
						Project obj = new Project();
						Links_ link = new Links_();
						link.setSelf(project.getLinks().getSelf().getHref());
						obj.setDescription(project.getDescription());
						obj.setDomainId("");
						obj.setIsDomain(false);
						obj.setEnabled(true);
						obj.setId(project.getId());
						obj.setLinks(link);
						obj.setName(project.getName());
						obj.setParentId(project.getZones().get(0).getZoneId());
						projects.add(obj);
					}
					this.projectList.addAll(projects);

				} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
					// TODO Auto-generated catch block
					logger.error("SyncProjectReader Exception");
				}
			}
		}
	}
}
