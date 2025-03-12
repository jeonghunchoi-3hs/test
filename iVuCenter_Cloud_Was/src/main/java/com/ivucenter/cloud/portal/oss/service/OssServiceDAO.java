package com.ivucenter.cloud.portal.oss.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

@Repository
public class OssServiceDAO {

	private final String GBN = "com.ivucenter.cloud.portal.oss.service.OssServiceDAO.";

    @Autowired
    private SqlSession sqlSession;

    public List<CustomOssServiceVO> list(CustomOssServiceVO req) {
    	Assert.notNull(req.getProjectId(), "");
        return sqlSession.selectList(GBN+"list", req);
    }

	public List<CustomOssServiceVO> listTot(CustomOssServiceVO req) {
		Assert.notNull(req.getProjectId(), "");
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req);
	}

	public List<CustomOssServiceVO> serviceDetailList(CustomOssServiceVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
        return sqlSession.selectList(GBN+"serviceDetailList", req);
    }

	public List<CustomOssServiceVO> serviceDetailListTot(CustomOssServiceVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		req.setLength(0);
		return sqlSession.selectList(GBN+"serviceDetailList", req);
	}

	 public List<CustomOssServiceVO> viewExcel(CustomOssServiceVO req) {
		 Assert.notNull(req.getProjectId(), "");
		req.setLength(0);
		return sqlSession.selectList(GBN+"serviceDetailList", req);
	}

	public List<CustomOssServiceVO> mbrServiceDetailList(CustomOssServiceVO req) {
		Assert.notNull(req.getProjectId(), "");
        return sqlSession.selectList(GBN+"mbrServiceDetailList", req);
    }

	public List<CustomOssServiceVO> mbrServiceDetailListTot(CustomOssServiceVO req) {
		Assert.notNull(req.getProjectId(), "");
		req.setLength(0);
		return sqlSession.selectList(GBN+"mbrServiceDetailList", req);
	}

	public CustomOssServiceVO detail(CustomOssServiceVO req) {
		Assert.notNull(req.getVmUuid(), "");
		return (CustomOssServiceVO) sqlSession.selectOne(GBN+"detail", req);
	}

    public int update(CustomOssServiceVO req) {
    	return (int)sqlSession.update(GBN+"update", req);
    }
    public int vmHistoryInsert(CustomOssServiceVO req) {
    	return (int)sqlSession.update(GBN+"vmHistoryInsert", req);
    }

    public CustomOssServiceVO serviceDetailInfo(CustomOssServiceVO req) {
    	Assert.notNull(req.getProjectId(), "");
    	Assert.notNull(req.getServiceId(), "");
		return (CustomOssServiceVO) sqlSession.selectOne(GBN+"serviceDetailInfo", req);
	}
    public CustomOssServiceVO mbrServiceDetailInfo(CustomOssServiceVO req) {
    	Assert.notNull(req.getProjectId(), "");
    	Assert.notNull(req.getServiceId(), "");
		return (CustomOssServiceVO) sqlSession.selectOne(GBN+"mbrServiceDetailInfo", req);
	}

    public List<CustomOssServiceVO> getServiceList(CustomOssServiceVO req) {
		return sqlSession.selectList(GBN+"getServiceList", req);
	}
}
