package com.ivucenter.cloud.portal.bss.batch;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BssBatchDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.bss.batch.BssBatchDAO.";
	
    @Autowired
    private SqlSession sqlSession;
	
    public List<CustomBssBatchVO> bssBatchList(CustomBssBatchVO batchVo) {
		return sqlSession.selectList(GBN + "bssBatchList",batchVo);
	}
    public CustomBssBatchVO bssBatchDetail(CustomBssBatchVO batchVo) {
    	return sqlSession.selectOne(GBN + "bssBatchDetail",batchVo);
    }
    
    public int bssBatchListTot(CustomBssBatchVO req){
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"bssBatchList", req).size();
    }
    
	public String bssBatchInsert(CustomBssBatchVO batchVo) {
		return sqlSession.insert(GBN + "bssBatchInsert", batchVo)+"";
	}

	public String bssBatchUpdate(CustomBssBatchVO batchVo) {
		return sqlSession.update(GBN + "bssBatchUpdate", batchVo)+"";
	}

	public String bssBatchDelete(CustomBssBatchVO batchVo) {
		return sqlSession.delete(GBN + "bssBatchUpdate", batchVo)+"";
	}

}
