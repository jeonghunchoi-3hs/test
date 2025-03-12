package com.ivucenter.cloud.portal.cmm.company;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CmmCompanyDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.cmm.company.CmmCompanyDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomCmmCompanyVO> list(CustomCmmCompanyVO req) {
        return sqlSession.selectList(GBN+"list", req);
    }
    
    public List<CustomCmmCompanyVO> listTot(CustomCmmCompanyVO req) {
    	req.setLength(0);
        return sqlSession.selectList(GBN+"list", req);
    }

    public List<CustomCmmCompanyVO> affilateList(CustomCmmCompanyVO req) {
        return sqlSession.selectList(GBN+"affilateList", req);
    }
    
    public List<CustomCmmCompanyVO> affilateListTot(CustomCmmCompanyVO req) {
    	req.setLength(0);
        return sqlSession.selectList(GBN+"affilateList", req);
    }

    public List<CustomCmmCompanyVO> companylist(CustomCmmCompanyVO req) {
        return sqlSession.selectList(GBN+"companylist", req);
    }
    
    public String insert(CustomCmmCompanyVO req) {
    	return (int)sqlSession.insert(GBN+"insert", req)+"";
	}

	public String update(CustomCmmCompanyVO req) {
		return (int)sqlSession.update(GBN+"update", req)+"";
	}

	public CustomCmmCompanyVO detail(CustomCmmCompanyVO req) {
		return (CustomCmmCompanyVO) sqlSession.selectOne(GBN+"detail", req);
	}
}
