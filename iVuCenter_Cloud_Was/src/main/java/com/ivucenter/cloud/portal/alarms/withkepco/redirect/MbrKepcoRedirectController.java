package com.ivucenter.cloud.portal.alarms.withkepco.redirect;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.alarms.withkepco.CustomWithKepcoVO;
import com.ivucenter.cloud.portal.alarms.withkepco.WithKepcoService;
import com.ivucenter.cloud.portal.login.LoginService;
import com.ivucenter.cloud.portal.util.DateUtils;


@Controller
@RequestMapping(value="/mbr/alarms/kepco")
public class MbrKepcoRedirectController {
	
	@Autowired
	private WithKepcoService withKepcoService;
	
	@Autowired
	private LoginService loginService;
	
	@RequestMapping(value="/redirect/{alarmSeq}")
	public String redirect(HttpServletRequest request, @PathVariable String alarmSeq) {
		
		// alter table alarm_kepco_queue add column redirect_url varchar(255);
		// alter table alarm_kepco_queue_history add column redirect_url varchar(255);
		// seq 가 없을 경우 오류
		CustomWithKepcoVO kepcoVo = withKepcoService.detail(alarmSeq);
		if(null == kepcoVo ) { return "redirect:/mbr"; }
		
		// 일주일 지났을 경우 오류
		Date regDate = DateUtils.convertStringToDate(kepcoVo.getRegDatetime(), "Asia/Seoul", "yyyy-MM-dd HH:mm:ss");
		
		long diff = DateUtils.diffDays(regDate, new Date());
		if ( 7 < diff) { return "redirect:/mbr"; }
		
		String userId = kepcoVo.getPayerId();
		boolean isSession = loginService.mailSession(request, userId);
		
		if( isSession && !StringUtils.isEmpty(kepcoVo.getRedirectUrl()) ) {			 
			return "redirect:" + kepcoVo.getRedirectUrl();
		}
		
		return "redirect:/mbr";
	}

}
