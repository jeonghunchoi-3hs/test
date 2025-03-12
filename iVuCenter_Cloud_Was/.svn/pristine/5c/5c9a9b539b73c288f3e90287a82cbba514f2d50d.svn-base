package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Alarm;

public interface AlarmIF {
	
	public Alarm createAlarm(Alarm alarm) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Alarm getAlarm(String alarm_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Alarm updateAlarm(Alarm alarm) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean deleteAlarm(String alarm_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Alarm> getAlarms() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
