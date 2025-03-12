package com.ivucenter.cloud.portal.cmm.aop;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import com.ivucenter.cloud.portal.login.UserSession;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Aspect
@Component
public class UserHistoryAspect {

    private static final Logger logger = LoggerFactory.getLogger(UserHistoryAspect.class);

	@Autowired
	UserHistoryServiceImpl userHistoryService;

	@After("execution(* com.ivucenter.cloud.portal..*Controller.*(..))"
			+ "execution(* com.ivucenter.cloud.portal..*Service.*(..))")
	public void afterAdvice(JoinPoint joinPoint) {

		String className = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		String taskName = className + "." + methodName;

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if( (null != auth) &&(auth.getPrincipal() instanceof UserDetails) ) {

			UserSession userSession = (UserSession) auth.getPrincipal();

			UserHistoryVO req = new UserHistoryVO();
			req.setUserId(userSession.getUsername());
			req.setUserName(userSession.getNickname());
			req.setUserRole(userSession.getRoles());
			req.setMethodName(methodName);
			req.setTaskName(taskName);
			req.setIp(getIp());

			//userHistoryService.insertUserHistory(req);
			//log.debug("Aspect after : " +methodName);
		}
	}

	private String getIp() {
		String ret = "";

		try {
			InetAddress local = null;
			local = InetAddress.getLocalHost();
			if(null!=local) { ret = local.getHostAddress(); }

		} catch (UnknownHostException e) {
            logger.error("getIp Exception");
		}
		return ret;
	}
}
