package com.ivucenter.cloud.api.openstack;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpMethod;

import com.ivucenter.cloud.api.common.utils.JsonUtils;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.api.openstack.connector.RestResponse;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AlarmIF;
import com.ivucenter.cloud.api.openstack.object.Alarm;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OpenStackAlarm extends OpenStackShared implements AlarmIF {

	private String projectName;
	private String API_ALARMS_SERVER;

	public OpenStackAlarm(String projectName,CustomOssCloudVO cloudVo) {
		this.projectName = projectName;
		super.cloudVo = cloudVo;
		this.API_ALARMS_SERVER = cloudVo.getApiAlarmServer();
	}

	@Override
	public List<Alarm> getAlarms() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));

		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_ALARMS_SERVER + "/alarms", headers);
		return JsonUtils.getJsonAlarmDatas(output.getMessage());
	}

	@Override
	public Alarm getAlarm(String alarm_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.GET, API_ALARMS_SERVER+"/alarms/"+alarm_id, headers);

		return JsonUtils.getJsonAlarmData(output.getMessage());
	}

	@Override
	public Alarm createAlarm(Alarm alarm) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));
		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(alarm);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.POST, API_ALARMS_SERVER+"/alarms", headers, contentType, payLoad);
		return JsonUtils.getJsonAlarmData(output.getMessage());
	}

	@Override
	public Alarm updateAlarm(Alarm alarm) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		String alarm_id = alarm.getAlarm_id();
		alarm.setAlarm_id(null);

		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));
		String contentType = "application/json";
		String payLoad = JsonUtils.getJsonFormatString(alarm);
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.PUT, API_ALARMS_SERVER+"/alarms/"+alarm_id, headers, contentType, payLoad);
		return JsonUtils.getJsonAlarmData(output.getMessage());
	}

	@Override
	public boolean deleteAlarm(String alarm_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put("X-Auth-Token", getProjectToken(projectName, super.cloudVo));
		RestResponse output = OpenStackRestConnector.doRequest(HttpMethod.DELETE, API_ALARMS_SERVER+"/alarms/"+alarm_id, headers, true);
		if (output.getStatusCode() == 204)
			return true;
		return false;
	}

	/*
	public static void main(String[] args) {
		try {
			AlarmIF alarmIF = AbstractFactory.getAlarmIF("newProject1");

			List<Alarm> alarms = alarmIF.getAlarms();
			for (Alarm obj : alarms) {
				log.debug(obj.getName() + " : " + obj.getAlarm_id() );
//				alarmIF.deleteAlarm(obj.getAlarm_id());
			}

//			String instance_id = "7a55804a-5b2b-4a88-8afe-0ac1a7cb98d3";
//			Alarm alarmCpu = new Alarm();
//			alarmCpu.setDefaultCpuUtil(instance_id);
//
//			Alarm obj1 = alarmIF.createAlarm(alarmCpu);
//
//			Alarm alarmMem = new Alarm();
//			alarmMem.setDefaultMemUtil(instance_id);
//
//			Alarm obj2 = alarmIF.createAlarm(alarmMem);
//			log.debug(obj2.getName()+" : "+obj2.getAlarm_id());

//			String alarm_id = "c6e573d1-d9e4-4b40-a748-cb364a30f552";
//			Alarm obj2 = alarmIF.getAlarm(alarm_id);
//			log.debug(obj2.getName()+" : "+obj2.getAlarm_id());
//			obj2.setEnabled(false);
//
//			Alarm obj3 = alarmIF.updateAlarm(obj2);
//			log.debug(obj3.getName()+" : "+obj3.getId()+" : "+obj3.getDescription());
//			boolean del = alarmIF.deleteAlarm(alarm_id);
//			log.debug("delete : " + del);

		} catch (Exception e) {
		}
	}
	*/

}
