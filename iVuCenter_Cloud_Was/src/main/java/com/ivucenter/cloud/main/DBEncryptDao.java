package com.ivucenter.cloud.main;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.entity.HrsystemTemporaryVO;
import com.ivucenter.cloud.portal.alarms.mail.history.CustomMailQueueHistoryVO;
import com.ivucenter.cloud.portal.alarms.mail.queue.CustomMailQueueVO;
import com.ivucenter.cloud.portal.alarms.sms.history.CustomSmsQueueHistoryVO;
import com.ivucenter.cloud.portal.alarms.sms.queue.CustomSmsQueueVO;
import com.ivucenter.cloud.portal.alarms.withnh.CustomNhwithVO;
import com.ivucenter.cloud.portal.cmm.customer.CustomCmmCustomerVO;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;

@Repository
public class DBEncryptDao {
	
	private final String GBN = "com.ivucenter.cloud.main.DBEncryptDao.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomCmmCustomerVO> cmmCustomerList() {
        return sqlSession.selectList(GBN+"cmmCustomerList");
    }

	public void cmmCustomerUpdate(CustomCmmCustomerVO vo) {
		sqlSession.update(GBN+"cmmCustomerUpdate", vo);
	}

	public List<CustomCmmUserVO> cmmUserList() {
		return sqlSession.selectList(GBN+"cmmUserList");
	}

	public void cmmUserUpdate(CustomCmmUserVO vo) {
		sqlSession.update(GBN+"cmmUserUpdate", vo);
	}

	public List<HrsystemTemporaryVO> hrsystemTemporaryList() {
		return sqlSession.selectList(GBN+"hrsystemTemporaryList");
	}
	public void hrsystemTemporaryUpdate(HrsystemTemporaryVO vo) {
		sqlSession.update(GBN+"hrsystemTemporaryUpdate", vo);
	}

	public List<CustomMailQueueVO> MailQueueVOList() {
		return sqlSession.selectList(GBN+"MailQueueVOList");
	}

	public void MailQueueVOUpdate(CustomMailQueueVO vo) {
		sqlSession.update(GBN+"MailQueueVOUpdate", vo);
	}

	public List<CustomMailQueueHistoryVO> MailQueueHistorList() {
		return sqlSession.selectList(GBN+"MailQueueHistorList");
	}

	public void MailQueueHistorUpdate(CustomMailQueueHistoryVO vo) {
		sqlSession.update(GBN+"MailQueueHistorUpdate", vo);
	}

	public List<CustomNhwithVO> NhwithQueueHistoryList() {
		return sqlSession.selectList(GBN+"NhwithQueueHistoryList");
	}

	public void NhwithQueueHistoryUpdate(CustomNhwithVO vo) {
		sqlSession.update(GBN+"NhwithQueueHistoryUpdate", vo);
	}

	public List<CustomSmsQueueVO> SmsQueueList() {
		return sqlSession.selectList(GBN+"SmsQueueList");
	}

	public void SmsQueueUpdate(CustomSmsQueueVO vo) {
		sqlSession.update(GBN+"SmsQueueUpdate", vo);
	}

	public List<CustomSmsQueueHistoryVO> SmsQueueHistoryList() {
		return sqlSession.selectList(GBN+"SmsQueueHistoryList");
	}

	public void SmsQueueHistoryUpdate(CustomSmsQueueHistoryVO vo) {
		sqlSession.update(GBN+"SmsQueueHistoryUpdate", vo);
	} 
	
	public void cmmCustomerUpdateDec(CustomCmmCustomerVO vo) {
		sqlSession.update(GBN+"cmmCustomerUpdateDec", vo);
	}
	public void cmmUserUpdateDec(CustomCmmUserVO vo) {
		sqlSession.update(GBN+"cmmUserUpdateDec", vo);
	}
	public void hrsystemTemporaryUpdateDec(HrsystemTemporaryVO vo) {
		sqlSession.update(GBN+"hrsystemTemporaryUpdateDec", vo);
	}
	public void MailQueueVOUpdateDec(CustomMailQueueVO vo) {
		sqlSession.update(GBN+"MailQueueVOUpdateDec", vo);
	}
	public void MailQueueHistorUpdateDec(CustomMailQueueHistoryVO vo) {
		sqlSession.update(GBN+"MailQueueHistorUpdateDec", vo);
	}
	public void NhwithQueueHistoryUpdateDec(CustomNhwithVO vo) {
		sqlSession.update(GBN+"NhwithQueueHistoryUpdateDec", vo);
	}
	public void SmsQueueUpdateDec(CustomSmsQueueVO vo) {
		sqlSession.update(GBN+"SmsQueueUpdateDec", vo);
	}
	public void SmsQueueHistoryUpdateDec(CustomSmsQueueHistoryVO vo) {
		sqlSession.update(GBN+"SmsQueueHistoryUpdateDec", vo);
	} 

}
