package com.ivucenter.cloud.portal.mng.req.work;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.portal.req.catalogue.CustomReqOrderVO;

@Repository
public class MngReqWorkDAO {

	private final String GBN = "com.ivucenter.cloud.portal.mng.req.work.MngReqWorkDAO.";
	
    @Autowired
    private SqlSession sqlSession;

	public List<CustomMngReqWorkVO> getReqWorkList(CustomMngReqWorkVO req) {
		return sqlSession.selectList(GBN + "getReqWorkList",req);
	}	
	public List<CustomReqOrderVO> getReqWorkListTot(CustomMngReqWorkVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN + "getReqWorkList",req);
	}
	
	public CustomMngReqWorkVO getReqWorkView(CustomMngReqWorkVO req) {
		return sqlSession.selectOne(GBN + "getReqWorkView",req);
	}
	
	public List<CustomReqOrderVO> getVmList(CustomMngReqWorkVO req) {
		return sqlSession.selectList(GBN + "getVmList",req);
	}
	
	public CustomMngReqWorkVO getReqLoadWorkView(CustomMngReqWorkVO req) {
		return sqlSession.selectOne(GBN + "getReqLoadWorkView",req);
	}
	
	public CustomMngReqWorkVO getReqSnapWorkView(CustomMngReqWorkVO req) {
		return sqlSession.selectOne(GBN + "getReqSnapWorkView",req);
	}
	
	public CustomMngReqWorkVO getReqWorkchk(String orderProductSeq) {
		return sqlSession.selectOne(GBN + "getReqWorkchk",orderProductSeq);
	}
		
	public int setWorkComplete(CustomMngReqWorkVO req) {
		return (int)sqlSession.update(GBN+"setWorkComplete", req);
	}
	public int setWorkChkOk(CustomMngReqWorkVO req) {
		return (int)sqlSession.update(GBN + "setWorkChkOk",req);
	}
	public int setWorkReadUpdate(CustomMngReqWorkVO setOssnas) {
		return (int)sqlSession.update(GBN + "setWorkReadUpdate",setOssnas);
	}
	public List<CustomMngReqWorkVO> workUserId(String requestSeq) {
		return sqlSession.selectList(GBN + "workUserId",requestSeq);
	}	
	public List<CustomMngReqWorkVO> getOrderWorkList(CustomMngReqWorkVO req) {
		return sqlSession.selectList(GBN + "getOrderWorkList",req);
	}
		

	public CustomReqOrderVO orderNasSelect(CustomMngReqWorkVO req) {
		return sqlSession.selectOne(GBN + "orderNasSelect",req);
	}
	public int setOssNasInsert(CustomMngOssVo nasValue) {
		return (int)sqlSession.insert(GBN+"setOssNasInsert", nasValue);
	}
	public int setOssNasUpdate(CustomMngOssVo setOssnas) {
		return (int)sqlSession.update(GBN + "setOssNasUpdate",setOssnas);
	}
	public int setOssNasChgUpdate(CustomMngOssVo setOssnas) {
		return (int)sqlSession.update(GBN + "setOssNasChgUpdate",setOssnas);
	}
	public int setOssNasHistoryInsert(CustomMngOssVo setOssnas) {
		return (int)sqlSession.update(GBN + "setOssNasHistoryInsert",setOssnas);
	}

	
	public CustomReqOrderVO orderLbSelect(CustomMngReqWorkVO req) {
		return sqlSession.selectOne(GBN + "orderLbSelect",req);
	}
	public CustomReqOrderVO orderSnSelect(CustomMngReqWorkVO req) {
		return sqlSession.selectOne(GBN + "orderSnSelect",req);
	}
	public int setOssLbInsert(CustomMngOssVo lbValue) {
		return (int)sqlSession.insert(GBN+"setOssLbInsert", lbValue);
	}
	public int setOssSnInsert(CustomMngOssVo lbValue) {
		return (int)sqlSession.insert(GBN+"setOssSnInsert", lbValue);
	}
	public int setOssLbUpdate(CustomMngOssVo setOsslb) {
		return (int)sqlSession.update(GBN + "setOssLbUpdate",setOsslb);
	}
	public int setOssSnUpdate(CustomMngReqWorkVO setOssSn) {
		return (int)sqlSession.update(GBN + "setOssSnUpdate",setOssSn);
	}
	
	public List<CustomReqOrderVO> orderLbVmSelect(CustomMngReqWorkVO req) {
		return sqlSession.selectList(GBN + "orderLbVmSelect",req);
	}
	public int setOssLbVmInsert(CustomMngOssVo lbVmValue) {
		return (int)sqlSession.insert(GBN+"setOssLbVmInsert", lbVmValue);
	}
	

	public CustomReqOrderVO orderIpSelect(CustomMngReqWorkVO req) {
		return sqlSession.selectOne(GBN + "orderIpSelect",req);
	}
	public int setOssIpInsert(CustomMngOssVo ipValue) {
		return (int)sqlSession.insert(GBN+"setOssIpInsert", ipValue);
	}
	public int setOssIpUpdate(CustomMngOssVo setOssip) {
		return (int)sqlSession.update(GBN + "setOssIpUpdate",setOssip);
	}
	
	public CustomReqOrderVO orderServiceSelect(CustomMngReqWorkVO req) {
		return sqlSession.selectOne(GBN + "orderServiceSelect",req);
	}	
	public int setOssServiceInsert(CustomMngOssVo bakValue) {
		return (int)sqlSession.insert(GBN+"setOssServiceInsert", bakValue);
	}
	public int setOssServiceUpdate(CustomMngOssVo setOssback) {
		return (int)sqlSession.update(GBN + "setOssServiceUpdate",setOssback);
	}
	public int setOssServiceVmUpdate(CustomMngReqWorkVO req) {
		return (int)sqlSession.insert(GBN+"setOssServiceVmUpdate", req);
	}
	public int setReqServiceInsert(CustomMngReqWorkVO req) {
		return (int)sqlSession.insert(GBN+"setReqServiceInsert", req);
	}
}
