package com.ivucenter.cloud.portal.oss.vm;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

@Repository
public class OssVmDAO {

	private final String GBN = "com.ivucenter.cloud.portal.oss.vm.OssVmDAO.";

    @Autowired
    private SqlSession sqlSession;

    public List<CustomOssVmVO> list(CustomOssVmVO req) {
    	Assert.notNull(req.getProjectId(), "");
    	Assert.notNull(req.getProjectBoxId(), "");
        return sqlSession.selectList(GBN+"viewlist", req);
    }

	public List<CustomOssVmVO> listTot(CustomOssVmVO req) {
		Assert.notNull(req.getProjectId(), "");
		Assert.notNull(req.getProjectBoxId(), "");
		req.setLength(0);
		return sqlSession.selectList(GBN+"viewlist", req);
	}

	public List<CustomOssVmVO> projectList(CustomOssVmVO req) {
    	Assert.notNull(req.getProjectBoxId(), "");
        return sqlSession.selectList(GBN+"viewProjectlist", req);
    }

	public List<CustomOssVmVO> projectListTot(CustomOssVmVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		req.setLength(0);
		return sqlSession.selectList(GBN+"viewProjectlist", req);
	}

	public CustomOssVmVO detail(CustomOssVmVO req) {
		Assert.notNull(req.getVmUuid(), "");
		return (CustomOssVmVO) sqlSession.selectOne(GBN+"detail", req);
	}

    public int update(CustomOssVmVO req) {
    	Assert.notNull(req.getVmUuid(), "");
    	return (int)sqlSession.update(GBN+"update", req);
    }

    public int vmHistoryInsert(CustomOssVmVO req) {
    	return (int)sqlSession.update(GBN+"vmHistoryInsert", req);
    }

    public List<CustomOssVmVO> vmListProjectUser(CustomOssVmVO req) {
    	Assert.notNull(req.getUserId(), "");
        return sqlSession.selectList(GBN+"vmListProjectByUser", req);
    }

    public CustomOssVmVO vmDetailByHostaname(CustomOssVmVO req) {
    	Assert.notNull(req.getHostname(), "");
        return sqlSession.selectOne(GBN+"detailByHostname", req);
    }
    public CustomOssVmVO detailSum(CustomOssVmVO req) {
    	return sqlSession.selectOne(GBN+"detailSum", req);
    }

    public List<CustomOssVmVO> nutanixList(CustomOssVmVO req) {
    	Assert.notNull(req.getProjectBoxId(), "");
        return sqlSession.selectList(GBN+"nutanixViewlist", req);
    }

	public List<CustomOssVmVO> nutanixListTot(CustomOssVmVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		req.setLength(0);
		return sqlSession.selectList(GBN+"nutanixViewlist", req);
	}

}
