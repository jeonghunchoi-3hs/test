package com.ivucenter.cloud.portal.alarms.event;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * @author 박진우
 */
@Service
public class EventAlarmService{

	@Autowired
	EventAlarmDAO dao;

	public void insertHistory(CustomEventAlarmVO req) {
		dao.insertHistory(req);
	}

	public int cnt(CustomEventAlarmVO req) {
		return dao.cnt(req);
	}

	public void update(CustomEventAlarmVO req) {
		dao.update(req);
	}

	public void insert(CustomEventAlarmVO req) {
		dao.insert(req);
	}

}
