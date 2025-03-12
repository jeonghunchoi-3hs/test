package com.ivucenter.cloud.api.openstack.interfaces;

import java.util.List;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.Member;

public interface MemberIF {
	
	public Member createMember(String pool_id, Member member) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Member getMember(String pool_id, String member_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public Member updateMember(String pool_id, Member member) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean deleteMember(String pool_id, String member_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public List<Member> getMembers(String pool_id) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
	public boolean isExist(String pool_id, String name) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException;
}
