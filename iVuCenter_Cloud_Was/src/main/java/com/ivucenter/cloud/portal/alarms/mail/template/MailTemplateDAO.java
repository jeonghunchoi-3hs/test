package com.ivucenter.cloud.portal.alarms.mail.template;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class MailTemplateDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.mail.template.MailTemplateDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomMailTemplateVO> list(CustomMailTemplateVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 

    public List<CustomMailTemplateVO> listTot(CustomMailTemplateVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"list", req);
    } 

	public CustomMailTemplateVO detail(CustomMailTemplateVO req) {
		return (CustomMailTemplateVO) sqlSession.selectOne(GBN+"detail", req);
	}
    
    public int update(CustomMailTemplateVO req) {
    	return (int)sqlSession.update(GBN+"update", req);
    }

}
