package com.ivucenter.cloud.api.ansible;

import org.apache.poi.util.SystemOutLogger;

import com.ivucenter.cloud.api.common.utils.SystemCalculatorInfo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SuppressWarnings("unused")
public class AnsibleTest {

	static boolean logDetail = true;

	public static void main(String[] args) throws Exception {
		SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();


//		getProjects(cloudVo);

//		getJobTemplates(cloudVo);

//		getInventorys(cloudVo);

		String hostname = "192.168.70.46";
		int inventory = 1;
//		addHost(systemCalculatorInfo, hostname, inventory);

		String template_id = "8";
//		launchTemplates(cloudVo, template_id);


		systemCalculatorInfo.setAnsiblehost("https://100.1.221.220");
		systemCalculatorInfo.setAnsiblepassword("");
		systemCalculatorInfo.setAnsibleusername("admin");

		getHosts(systemCalculatorInfo);


	}

	private static void getProjects(SystemCalculatorInfo systemCalculatorInfo) throws Exception {
		AnsibleObject ansibleObject = AnsibleUtils.getProjects(systemCalculatorInfo);
		for (AnsibleObject aobj : ansibleObject.getProjects()) {
			log.debug("id : "+aobj.getValue("id"));
			log.debug("type : "+aobj.getValue("type"));
			log.debug("name : "+aobj.getValue("name"));
		}
	}

	private static void getJobTemplates(SystemCalculatorInfo systemCalculatorInfo) throws Exception {
		AnsibleObject ansibleObject = AnsibleUtils.getJobTemplates(systemCalculatorInfo);
		for (AnsibleObject aobj : ansibleObject.getJobTemplates()) {
			log.debug("id : "+aobj.getValue("id"));
			log.debug("type : "+aobj.getValue("type"));
			log.debug("name : "+aobj.getValue("name"));
			log.debug("job_type : "+aobj.getValue("job_type"));
			log.debug("inventory : "+aobj.getValue("inventory"));
			log.debug("project : "+aobj.getValue("project"));
			log.debug("playbook : "+aobj.getValue("playbook"));
		}
	}



	private static void getHosts(SystemCalculatorInfo systemCalculatorInfo) throws Exception {
		AnsibleObject ansibleObject = AnsibleUtils.getHosts(systemCalculatorInfo);
		for (AnsibleObject aobj : ansibleObject.getJobTemplates()) {
			log.debug("id : "+aobj.getValue("id"));
			log.debug("type : "+aobj.getValue("type"));
			log.debug("name : "+aobj.getValue("name"));
			log.debug("job_type : "+aobj.getValue("job_type"));
			log.debug("inventory : "+aobj.getValue("inventory"));
			log.debug("project : "+aobj.getValue("project"));
			log.debug("playbook : "+aobj.getValue("playbook"));
		}
	}



	private static void getInventorys(SystemCalculatorInfo systemCalculatorInfo) throws Exception {
		AnsibleObject ansibleObject = AnsibleUtils.getInventorys(systemCalculatorInfo);
		for (AnsibleObject aobj : ansibleObject.getJobTemplates()) {
			log.debug("id : "+aobj.getValue("id"));
			log.debug("type : "+aobj.getValue("type"));
			log.debug("name : "+aobj.getValue("name"));
			log.debug("job_type : "+aobj.getValue("job_type"));
			log.debug("inventory : "+aobj.getValue("inventory"));
			log.debug("project : "+aobj.getValue("project"));
			log.debug("playbook : "+aobj.getValue("playbook"));
		}
	}

	private static void launchTemplates(SystemCalculatorInfo systemCalculatorInfo, String template_id) throws Exception {
		AnsibleObject ansibleObject = AnsibleUtils.launchTemplates(systemCalculatorInfo, template_id);
		log.debug("job : "+ansibleObject.getValue("job"));
		log.debug("id : "+ansibleObject.getValue("id"));
		log.debug("type : "+ansibleObject.getValue("type"));
	}

	private static void addHost(SystemCalculatorInfo systemCalculatorInfo, String hostname, int inventory) throws Exception {
		AnsibleObject ansibleObject = AnsibleUtils.addHost(systemCalculatorInfo, hostname, inventory);
		log.debug("job : "+ansibleObject.getValue("job"));
		log.debug("id : "+ansibleObject.getValue("id"));
		log.debug("type : "+ansibleObject.getValue("type"));
	}
}
