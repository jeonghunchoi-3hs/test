package com.ivucenter.cloud.portal.cmm.cloud;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

@Repository
public class OssCloudDAO  {

	private final String GBN = "com.ivucenter.cloud.portal.cmm.cloud.OssCloudDAO.";

	@Autowired
	private SqlSession sqlSession;

	public int listTot(CustomOssCloudVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req).size();
	}
	public List<CustomOssCloudVO> list(CustomOssCloudVO req) {

		return sqlSession.selectList(GBN + "list", req);
	}

	public List<CustomOssCloudVO> getCloudList() {
		return sqlSession.selectList(GBN + "getCloudList");
	}
	
	public List<CustomOssCloudVO> getVmwareCloudList() {
		return sqlSession.selectList(GBN + "getVmwareCloudList");
	}
	
	public CustomOssCloudVO detail(CustomOssCloudVO req) {
		Assert.notNull(req.getCloudId(), "");
		return (CustomOssCloudVO) sqlSession.selectOne(GBN+"detail", req.getCloudId());
	}
	
  	public CustomOssCloudVO detail(String cloudId) {
  		Assert.notNull(cloudId, "");
  		return sqlSession.selectOne(GBN + "detail",cloudId);
  	}

  	 public int insert(CustomOssCloudVO req) {
     	return (int)sqlSession.insert(GBN+"insert", req);
     }
  	 public int update(CustomOssCloudVO req) {
  		 return (int)sqlSession.update(GBN+"update", req);
  	 }
  	
  	public int delete(CustomOssCloudVO req) {
  		Assert.notNull(req.getCloudId(), "");
		Assert.notNull(req.getModUserId(), "");
		return (int)sqlSession.delete(GBN+"delete", req);
	}
  	
  	public CustomOssCloudVO getCloudroles() {
		return sqlSession.selectOne(GBN + "getCloudroles");
	}
  	
	public CustomOssCloudVO rownumCloudDetail(String rownum) {
  		return sqlSession.selectOne(GBN + "rownumCloudDetail",rownum);
  	}
	
	public List<CustomOssCloudVO> getOssProjectCloudListByReqProjectSeq(String reqProjectSeq) {
		return sqlSession.selectList(GBN + "getOssProjectCloudListByReqProjectSeq", reqProjectSeq);
	}
	
	public List<CustomOssCloudVO> getReqProjectCloudListByReqProjectSeq(String reqProjectSeq) {
		return sqlSession.selectList(GBN + "getReqProjectCloudListByReqProjectSeq", reqProjectSeq);
	}
	
	public List<CustomOssCloudVO> getOssProjectByProjectBoxId(String reqProjectSeq) {
		return sqlSession.selectList(GBN + "getOssProjectByProjectBoxId", reqProjectSeq);
	}
	
	public List<CustomOssCloudVO> getReqProjectCloudListByReqProjectSeqReApprove(String reqProjectSeq) {
		return sqlSession.selectList(GBN + "getReqProjectCloudListByReqProjectSeqReApprove", reqProjectSeq);
	}
	
	public List<CustomOssCloudVO> getCloud() {
		return sqlSession.selectList(GBN + "getCloudList");
	}
	
	public List<CustomOssCloudVO> getCloudProjectList(CustomOssCloudVO req) {
		return sqlSession.selectList(GBN + "getCloudProjectList", req);
	}
	
	public List<CustomOssCloudVO> getCloudSubnetList(String cloudId) {
		return sqlSession.selectList(GBN + "getCloudSubnetList", cloudId);
	}
}
