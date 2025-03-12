package com.ivucenter.cloud.portal.mygoods.vm;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MygoodsVmDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.mygoods.vm.MygoodsVmDAO.";
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<CustomMygoodsVmVO> list(CustomMygoodsVmVO req){
		return sqlSession.selectList(GBN+"list", req);
	}
	
	public int listTot(CustomMygoodsVmVO req) {
		return (int)sqlSession.selectOne(GBN+"listTot", req);
	}
	
	public CustomMygoodsVmVO detail(CustomMygoodsVmVO req){
		return (CustomMygoodsVmVO)sqlSession.selectOne(GBN+"detail", req);
	}

	public int insert(CustomMygoodsVmVO req){
		return (int)sqlSession.insert(GBN+"insert", req);
	}

	public int update(CustomMygoodsVmVO req){
		return (int)sqlSession.update(GBN+"update", req);
	}
	
	public int delete(CustomMygoodsVmVO req){
		return (int)sqlSession.delete(GBN+"delete", req);
	}

}
