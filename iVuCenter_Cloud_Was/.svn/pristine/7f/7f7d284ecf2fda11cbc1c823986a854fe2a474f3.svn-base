package com.ivucenter.cloud.portal.oss.disk;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

@Repository
public class OssDiskDAO {

	private final String GBN = "com.ivucenter.cloud.portal.oss.disk.OssDiskDAO.";

    @Autowired
    private SqlSession sqlSession;

    public List<CustomOssDiskVO> list(CustomOssDiskVO req) {
    	Assert.notNull(req.getProjectBoxId(), "");
    	return sqlSession.selectList(GBN+"list", req);
	}

	public List<CustomOssDiskVO> listTot(CustomOssDiskVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req);
	}

	public CustomOssDiskVO detail(CustomOssDiskVO req) {
		Assert.notNull(req.getDiskId(), "");
		return (CustomOssDiskVO) sqlSession.selectOne(GBN+"detail", req);
	}

	public String updateAlias(CustomOssDiskVO req) {
		Assert.notNull(req.getDiskId(), "");
		return (int)sqlSession.update(GBN+"updateAlias", req)+"";
	}

	public List<CustomOssDiskVO> snapshotDiskList(CustomOssDiskVO req) {
    	Assert.notNull(req.getProjectId(), "");
    	return sqlSession.selectList(GBN+"snapshotDiskList", req);
	}

	public List<CustomOssDiskVO> snapshotDiskListTot(CustomOssDiskVO req) {
		Assert.notNull(req.getProjectId(), "");
		req.setLength(0);
		return sqlSession.selectList(GBN+"snapshotDiskList", req);
	}

	/*
	public String getNetworkAlias(String networkId) {
		String sRet = (String) sqlSession.selectOne(GBN+"getNetworkAlias", networkId);

		return StringUtils.isNotEmpty(sRet)?sRet:"";
	}

	public int insert(CustomOssDiskVO req) {
		return (int)sqlSession.insert(GBN+"insert", req);
	}

    public int update(CustomOssDiskVO req) {
    	return (int)sqlSession.update(GBN+"update", req);
    }

	public int delete(CustomOssDiskVO req) {
		return (int)sqlSession.update(GBN+"delete", req);
	}
*/





}
