package com.ivucenter.cloud.portal.cmm.code;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.portal.bss.product.CustomBssProductVO;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqCatalogueVO;

@Repository
public class CmmCodeDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.cmm.code.CmmCodeDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomCmmCodeVO> list(CustomCmmCodeVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 
    
    public List<CustomCmmCodeVO> getBlockDisk(CustomReqCatalogueVO req) {
        return sqlSession.selectList(GBN+"getBlockDisk", req);
    } 
    
	public CustomCmmCodeVO detail(CustomCmmCodeVO req) {
		return (CustomCmmCodeVO) sqlSession.selectOne(GBN+"detail", req);
	}
    
    public int insert(CustomCmmCodeVO req) {
    	return (int)sqlSession.insert(GBN+"insert", req);
    }

    public int update(CustomCmmCodeVO req) {
    	return (int)sqlSession.update(GBN+"update", req);
    }

	public int delete(CustomCmmCodeVO req) {
		return (int)sqlSession.delete(GBN+"delete", req);
	}

	public List<CustomCmmCodeVO> getSharedNetwork() {
		 return sqlSession.selectList(GBN+"getSharedNetwork");
	}
	
	public List<CustomCmmCodeVO> getLoadProtocol() {
		 return sqlSession.selectList(GBN+"getLoadProtocol");
	}
	
	public List<CustomCmmCodeVO> getLoadMethod() {
		 return sqlSession.selectList(GBN+"getLoadMethod");
	}
	
	public List<CustomCmmCodeVO> getLoadMonitorType() {
		 return sqlSession.selectList(GBN+"getLoadMonitorType");
	}	
	
	public List<CustomCmmCodeVO> getCmmCode(String codeKeyId) {
		return sqlSession.selectList(GBN+"getCmmCode", codeKeyId);
	}	
	
	public List<CustomCmmCodeVO> getCmmCodeByList(List<String> codeKeyList){
		return sqlSession.selectList(GBN+"getCmmCodeByList", codeKeyList);
	}
	
	public List<CustomCmmCodeVO> getBlockDisk(CustomBssProductVO req){
		return sqlSession.selectList(GBN+"getBlockDisk", req);
	}
}
