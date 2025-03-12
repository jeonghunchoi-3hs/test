package com.ivucenter.cloud.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ivucenter.cloud.entity.HrsystemTemporaryVO;
import com.ivucenter.cloud.portal.alarms.mail.history.CustomMailQueueHistoryVO;
import com.ivucenter.cloud.portal.alarms.mail.queue.CustomMailQueueVO;
import com.ivucenter.cloud.portal.alarms.sms.history.CustomSmsQueueHistoryVO;
import com.ivucenter.cloud.portal.alarms.sms.queue.CustomSmsQueueVO;
import com.ivucenter.cloud.portal.alarms.withnh.CustomNhwithVO;
import com.ivucenter.cloud.portal.cmm.customer.CustomCmmCustomerVO;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DBEncryptService {

	@Autowired
	DBEncryptDao dao;
	
	public void DBEncryptCmmCustomer(){
		List<CustomCmmCustomerVO> lists = dao.cmmCustomerList();
		
		for(CustomCmmCustomerVO vo: lists){
			dao.cmmCustomerUpdate(vo);
		}
		log.debug("DBEncryptCmmCustomer 완료");
	}

	public void DBEncryptCmmUser() {
		List<CustomCmmUserVO> lists = dao.cmmUserList();
		
		for(CustomCmmUserVO vo: lists){
			dao.cmmUserUpdate(vo);
		}
		log.debug("DBEncryptCmmUser 완료");
	}

	public void DBEncryptHrsystemTemporary() {
		List<HrsystemTemporaryVO> lists = dao.hrsystemTemporaryList();
		
		for(HrsystemTemporaryVO vo: lists){
			dao.hrsystemTemporaryUpdate(vo);
		}
		log.debug("DBEncryptHrsystemTemporary 완료");
	}

	public void DBEncryptMailQueue() {
		List<CustomMailQueueVO> lists = dao.MailQueueVOList();
		
		for(CustomMailQueueVO vo: lists){
			dao.MailQueueVOUpdate(vo);
		}
		log.debug("DBEncryptMailQueue 완료");
	}

	public void DBEncryptMailQueueHistory() {
		List<CustomMailQueueHistoryVO> lists = dao.MailQueueHistorList();
		
		for(CustomMailQueueHistoryVO vo: lists){
			dao.MailQueueHistorUpdate(vo);
		}
		log.debug("DBEncryptMailQueueHistory 완료");
	}

	public void DBEncryptNhwithQueueHistory() {
		List<CustomNhwithVO> lists = dao.NhwithQueueHistoryList();
		
		for(CustomNhwithVO vo: lists){
			dao.NhwithQueueHistoryUpdate(vo);
		}
		log.debug("DBEncryptNhwithQueueHistory 완료");
	}

	public void DBEncryptSmsQueue() {
		List<CustomSmsQueueVO> lists = dao.SmsQueueList();
		
		for(CustomSmsQueueVO vo: lists){
			dao.SmsQueueUpdate(vo);
		}
		log.debug("DBEncryptSmsQueue 완료");
	}

	public void DBEncryptSmsQueueHistory() {
		List<CustomSmsQueueHistoryVO> lists = dao.SmsQueueHistoryList();
		
		for(CustomSmsQueueHistoryVO vo: lists){
			dao.SmsQueueHistoryUpdate(vo);
		}
		log.debug("DBEncryptSmsQueueHistory 완료");
	}
	
	public void DBEncryptDecCmmCustomer(){
		List<CustomCmmCustomerVO> lists = dao.cmmCustomerList();
		
		for(CustomCmmCustomerVO vo: lists){
			dao.cmmCustomerUpdateDec(vo);
		}
		log.debug("DBEncryptDecCmmCustomer 완료");
	}

	public void DBEncryptDecCmmUser() {
		List<CustomCmmUserVO> lists = dao.cmmUserList();
		
		for(CustomCmmUserVO vo: lists){
			dao.cmmUserUpdateDec(vo);
		}
		log.debug("DBEncryptDecCmmUser 완료");
	}

	public void DBEncryptDecHrsystemTemporary() {
		List<HrsystemTemporaryVO> lists = dao.hrsystemTemporaryList();
		
		for(HrsystemTemporaryVO vo: lists){
			dao.hrsystemTemporaryUpdateDec(vo);
		}
		log.debug("DBEncryptDecHrsystemTemporary 완료");
	}

	public void DBEncryptDecMailQueue() {
		List<CustomMailQueueVO> lists = dao.MailQueueVOList();
		
		for(CustomMailQueueVO vo: lists){
			dao.MailQueueVOUpdateDec(vo);
		}
		log.debug("DBEncryptDecMailQueue 완료");
	}

	public void DBEncryptDecMailQueueHistory() {
		List<CustomMailQueueHistoryVO> lists = dao.MailQueueHistorList();
		
		for(CustomMailQueueHistoryVO vo: lists){
			dao.MailQueueHistorUpdateDec(vo);
		}
		log.debug("DBEncryptDecMailQueueHistory 완료");
	}

	public void DBEncryptDecNhwithQueueHistory() {
		List<CustomNhwithVO> lists = dao.NhwithQueueHistoryList();
		
		for(CustomNhwithVO vo: lists){
			dao.NhwithQueueHistoryUpdateDec(vo);
		}
		log.debug("DBEncryptDecNhwithQueueHistory 완료");
	}

	public void DBEncryptDecSmsQueue() {
		List<CustomSmsQueueVO> lists = dao.SmsQueueList();
		
		for(CustomSmsQueueVO vo: lists){
			dao.SmsQueueUpdateDec(vo);
		}
		log.debug("DBEncryptDecSmsQueue 완료");
	}

	public void DBEncryptDecSmsQueueHistory() {
		List<CustomSmsQueueHistoryVO> lists = dao.SmsQueueHistoryList();
		
		for(CustomSmsQueueHistoryVO vo: lists){
			dao.SmsQueueHistoryUpdateDec(vo);
		}
		log.debug("DBEncryptDecSmsQueueHistory 완료");
	}	
}
