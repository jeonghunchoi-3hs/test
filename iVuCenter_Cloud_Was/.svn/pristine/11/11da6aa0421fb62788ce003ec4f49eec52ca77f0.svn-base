package com.ivucenter.cloud.portal.oss.loadbalancer;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.portal.oss.vm.CustomOssVmVO;


@Repository
public class OssLbDAO {

	private final String GBN = "com.ivucenter.cloud.portal.oss.loadbalancer.OssLbDAO.";
	
    @Autowired
    private SqlSession sqlSession;

	public List<CustomOssLbVO> getLbList(CustomOssLbVO req) {
		return sqlSession.selectList(GBN+"getLbList", req);
	}
	public int getLbListTot(CustomOssLbVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"getLbList", req).size();
	}
	
	public List<CustomOssLbVO> getLb(CustomOssLbVO req) {
		return sqlSession.selectList(GBN+"getLb", req);
	}
	
	public List<CustomOssVmVO> getVmList(CustomOssLbVO req) {
		return sqlSession.selectList(GBN+"getVmList", req);
	}
	
	public int deleteVm(CustomOssLbVO req) {
		return (int)sqlSession.update(GBN+"deleteVm", req);
	}

//	public int getLbListTot(CustomOssLbVO req) {
//		req.setLength(0);
//		return sqlSession.selectList(GBN+"getLbList", req).size();
//	}
	
//	public int setLbEditOk(CustomOssLbVO req) {
//		return sqlSession.update(GBN+"setLbEditOk", req);
//	}

//	public CustomOssLbVO lbDetail(CustomOssLbVO req) {
//		return sqlSession.selectOne(GBN+"lbDetail", req);
//	}
}
