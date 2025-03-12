package com.ivucenter.cloud.portal.alarms.sms.template;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class SmsTemplateDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.sms.template.SmsTemplateDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomSmsTemplateVO> list(CustomSmsTemplateVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 
    public List<CustomSmsTemplateVO> listTot(CustomSmsTemplateVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"list", req);
    } 

	public CustomSmsTemplateVO detail(CustomSmsTemplateVO req) {
		return (CustomSmsTemplateVO) sqlSession.selectOne(GBN+"detail", req);
	}
    
    public int update(CustomSmsTemplateVO req) {
    	return (int)sqlSession.update(GBN+"update", req);
    }

}
