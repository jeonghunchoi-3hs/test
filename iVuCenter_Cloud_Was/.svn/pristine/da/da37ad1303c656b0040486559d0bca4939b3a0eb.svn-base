package com.ivucenter.cloud.portal.alarms.mail.redirect;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.alarms.mail.queue.CustomMailQueueVO;
import com.ivucenter.cloud.portal.alarms.mail.queue.MailQueueService;
import com.ivucenter.cloud.portal.login.LoginService;
import com.ivucenter.cloud.portal.util.DateUtils;

@Controller
@RequestMapping(value="/mng/alarms/mail")
public class MngMailRedirectController {

	@Autowired
	private MailQueueService mailQueueService;
	
	@Autowired
	private LoginService loginService;
	
	@RequestMapping(value="/redirect/{seq}")
	public String redirect(HttpServletRequest request, @PathVariable String seq) {
		
		// alter table mail_queue add column redirect_url varchar(255);
		// alter table mail_queue_history add column redirect_url varchar(255);
		// seq 가 없을 경우 오류
		CustomMailQueueVO mailVo = mailQueueService.detail(seq);
		if(null == mailVo ) { return "redirect:/mng/login"; }
		
		// 일주일 지났을 경우 오류
		Date regDate = DateUtils.convertStringToDate(mailVo.getRegDatetime(), "Asia/Seoul", "yyyy-MM-dd HH:mm:ss");
		long diff = DateUtils.diffDays(regDate, new Date());		
		if ( 7 < diff) { return "redirect:/mng/login"; }
		
		String userId = mailVo.getReceiverId();
		boolean isSession = loginService.mailSession(request, userId);
		
		if( isSession && !StringUtils.isEmpty(mailVo.getRedirectUrl()) ) {			 
			return "redirect:" + mailVo.getRedirectUrl();
		}
		
		return "redirect:/mng/login";
	}
}
