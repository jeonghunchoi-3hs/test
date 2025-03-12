package com.ivucenter.cloud.portal.alarms.template.reservedword;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TemplateReservedWordService{
	
	@Autowired
	private TemplateReservedWordDAO dao;
	
	public List<CustomTemplateReservedWordVO> list(CustomTemplateReservedWordVO req) {
		return dao.list(req);
	}
	
}
