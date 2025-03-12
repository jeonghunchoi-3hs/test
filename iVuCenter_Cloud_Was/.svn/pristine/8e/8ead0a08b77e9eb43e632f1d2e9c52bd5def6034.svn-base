package com.ivucenter.cloud.portal.oss.persistentvolume;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;

@Repository
public class OssPvDAO {

	private final String GBN = "com.ivucenter.cloud.portal.oss.persistentvolume.OssPvDAO.";

    @Autowired
    private SqlSession sqlSession;

    public List<CustomOssPvVO> list(CustomOssPvVO req) {
    	Assert.notNull(req.getUserId(), "");
    	return sqlSession.selectList(GBN+"list", req);
    }

    public List<CustomOssPvVO> listTot(CustomOssPvVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"list", req);
    }


    public List<CustomOssPvVO> nasList(CustomOssPvVO req) {
    	Assert.notNull(req.getProjectBoxId(), "");
    	return sqlSession.selectList(GBN+"nasList", req);
    }

    public List<CustomOssPvVO> nasListTot(CustomOssPvVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		req.setLength(0);
		return sqlSession.selectList(GBN+"nasList", req);
	}

    public List<CustomOssPvVO> pvDetachList(CustomOssPvVO req) {
    	Assert.notNull(req.getProjectId(), "");
    	return sqlSession.selectList(GBN+"pvDetachList", req);
    }

    public List<CustomOssPvVO> pvDetachListTot(CustomOssPvVO req) {
    	Assert.notNull(req.getProjectId(), "");
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"pvDetachList", req);
    }

	public String insertOssNasApp(CustomOssPvVO req) {
		return sqlSession.insert(GBN+"insertOssNasApp", req)+"";
	}

	public String pvcStatusUpdate(CustomOssPvVO req) {
		return sqlSession.update(GBN+"pvcStatusUpdate", req)+"";
	}

	public String pvcPathUpdate(CustomOssPvVO req) {
		return sqlSession.update(GBN+"pvcPathUpdate", req)+"";
	}

	public String updateAppPvc(CustomOssPvVO req) {
		return sqlSession.update(GBN+"updateAppPvc", req)+"";
	}

	public String deleteNasApp(CustomOssPvVO req) {
		return sqlSession.delete(GBN+"deleteNasApp", req)+"";
	}

}
