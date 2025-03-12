package com.ivucenter.cloud.portal.oss.filestorage;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;

@Repository
public class OssFsDAO {

	private final String GBN = "com.ivucenter.cloud.portal.oss.filestorage.OssFsDAO.";

    @Autowired
    private SqlSession sqlSession;

    public List<CustomOssFsVO> list(CustomOssFsVO req) {
    	Assert.notNull(req.getUserId(), "");
    	return sqlSession.selectList(GBN+"list", req);
    }

    public List<CustomOssFsVO> listTot(CustomOssFsVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"list", req);
    }


    public List<CustomOssFsVO> fsList(CustomOssFsVO req) {
    	Assert.notNull(req.getProjectBoxId(), "");
    	return sqlSession.selectList(GBN+"fsList", req);
    }

    public List<CustomOssFsVO> fsListTot(CustomOssFsVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		req.setLength(0);
		return sqlSession.selectList(GBN+"fsList", req);
	}

    public List<CustomOssFsVO> pvDetachList(CustomOssFsVO req) {
    	Assert.notNull(req.getProjectId(), "");
    	return sqlSession.selectList(GBN+"pvDetachList", req);
    }

    public List<CustomOssFsVO> pvDetachListTot(CustomOssFsVO req) {
    	Assert.notNull(req.getProjectId(), "");
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"pvDetachList", req);
    }

	public String insertOssNasApp(CustomOssFsVO req) {
		return sqlSession.insert(GBN+"insertOssNasApp", req)+"";
	}

	public String pvcStatusUpdate(CustomOssFsVO req) {
		return sqlSession.update(GBN+"pvcStatusUpdate", req)+"";
	}

	public String pvcPathUpdate(CustomOssFsVO req) {
		return sqlSession.update(GBN+"pvcPathUpdate", req)+"";
	}

	public String updateAppPvc(CustomOssFsVO req) {
		return sqlSession.update(GBN+"updateAppPvc", req)+"";
	}

	public String deleteNasApp(CustomOssFsVO req) {
		return sqlSession.delete(GBN+"deleteNasApp", req)+"";
	}

}
