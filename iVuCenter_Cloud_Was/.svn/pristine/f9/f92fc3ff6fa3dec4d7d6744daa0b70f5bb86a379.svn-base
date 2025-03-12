package com.ivucenter.cloud.portal.cmm.network;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CmmNetworkDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.cmm.network.CmmNetworkDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomCmmNetworkVO> list(CustomCmmNetworkVO req) {
    	   return sqlSession.selectList(GBN+"list", req);
	}

	public List<CustomCmmNetworkVO> listTot(CustomCmmNetworkVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req);
	}
    
	public CustomCmmNetworkVO detail(CustomCmmNetworkVO req) {
		return (CustomCmmNetworkVO) sqlSession.selectOne(GBN+"detail", req);
	}

	public int insert(CustomCmmNetworkVO req) {
		return (int)sqlSession.insert(GBN+"insert", req);
	}
	
    public int update(CustomCmmNetworkVO req) {
    	return (int)sqlSession.update(GBN+"update", req);
    }

	public int delete(CustomCmmNetworkVO req) {
		return (int)sqlSession.update(GBN+"delete", req);
	}

	public List<CustomCmmNetworkVO> customerlist(CustomCmmNetworkVO req) {
		return sqlSession.selectList(GBN+"customerlist", req);
	}
	public int customerlistTot(CustomCmmNetworkVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"customerlist", req).size();
	}

	public List<CustomCmmNetworkVO> customerPopList(CustomCmmNetworkVO req) {
		return sqlSession.selectList(GBN+"customerPopList", req);
	}

	public int customerPopListTot(CustomCmmNetworkVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"customerPopList", req).size();
	}

	public int customerChk(CustomCmmNetworkVO req) {
		return sqlSession.selectOne(GBN+"customerChk", req);
	}
	
	public String customerInsert(CustomCmmNetworkVO req) {
		return (int)sqlSession.insert(GBN+"customerInsert", req)+"";
	}

	public String customerDelete(CustomCmmNetworkVO req) {
		return (int)sqlSession.delete(GBN+"customerDelete", req)+"";
	}

	public List<CustomCmmNetworkVO> listAffiliateName(CustomCmmNetworkVO req) {
		return sqlSession.selectList(GBN+"listAffiliateName", req);
	}
}
