package com.ivucenter.cloud.portal.alarms.template.reservedword;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class TemplateReservedWordDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.alarms.template.reservedword.TemplateReservedWordDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomTemplateReservedWordVO> list(CustomTemplateReservedWordVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 
}
