package com.ivucenter.cloud.portal.oss.application;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.oss.service.CustomOssServiceVO;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqCatalogueVO;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqOrderVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;

@Repository
public class OssAppDAO {

private final String GBN = "com.ivucenter.cloud.portal.oss.App.OssAppDAO.";

    @Autowired
    private SqlSession sqlSession;

    public List<CustomOssAppVO> projectList(CustomOssAppVO req) {
    	Assert.notNull(req.getProjectBoxId(), "");
        return sqlSession.selectList(GBN+"appProjectlist", req);
    }

	public List<CustomOssAppVO> projectListTot(CustomOssAppVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		req.setLength(0);
		return sqlSession.selectList(GBN+"appProjectlist", req);
	}

	public CustomOssAppVO appResouceTotal(CustomOssAppVO req) {
    	Assert.notNull(req.getProjectBoxId(), "");
    	return sqlSession.selectOne(GBN+"appResouceTotal", req);
    }

	public List<CustomOssAppVO> appList(CustomOssAppVO req) {
    	Assert.notNull(req.getProjectBoxId(), "");
        return sqlSession.selectList(GBN+"appProjectlist", req);
    }

	public List<CustomOssAppVO> appListTot(CustomOssAppVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		req.setLength(0);
		return sqlSession.selectList(GBN+"appProjectlist", req);
	}

	public List<CustomOssAppVO> pvAppList(CustomOssAppVO req) {
		Assert.notNull(req.getProjectId(), "");
        return sqlSession.selectList(GBN+"pvAppList", req);
    }

	public List<CustomOssAppVO> pvAppListTot(CustomOssAppVO req) {
		Assert.notNull(req.getProjectId(), "");
		req.setLength(0);
		return sqlSession.selectList(GBN+"pvAppList", req);
	}

    public CustomOssAppVO appDetail(CustomOssAppVO req) {
    	Assert.notNull(req.getAppUid(), "");
    	return sqlSession.selectOne(GBN+"appDetail", req);
    }

	public CustomOssAppVO returnVoInfo( CustomOssAppVO req) {
		Assert.notNull(req.getAppUid(), "");
		return sqlSession.selectOne(GBN+"returnVoInfo", req);
	}

    public CustomOssAppVO ossAppByAppUid(CustomOssAppVO req) {
        return sqlSession.selectOne(GBN+"ossAppByAppUid", req);
    }

    public CustomOssAppVO getDetailOssApp(CustomOssAppVO req) {
    	return sqlSession.selectOne(GBN+"getDetailOssApp", req);
    }

    public int insertAutoscaler(CustomOssAppVO req) {
    	return (int)sqlSession.insert(GBN+"insertAutoscaler", req);
    }

    public int insertScaleOut(CustomOssAppVO req) {
    	return sqlSession.insert(GBN+"insertScaleOut", req);
    }

	public CustomOssAppVO scaleOutDetail(CustomOssAppVO req) {
		return (CustomOssAppVO) sqlSession.selectOne(GBN+"scaleOutDetail", req);
	}

	public int scaleOutUpdate(CustomOssAppVO req) {
		return sqlSession.update(GBN+"scaleOutUpdate", req);
	}

	public List<CustomReqProductVO> projectEnvList(CustomReqProductVO req) {
    	Assert.notNull(req.getUserId(), "");
    	return sqlSession.selectList(GBN+"projectEnvList", req);
    }

	 public List<CustomReqProductVO> envViewExcel(CustomReqProductVO req) {
		return sqlSession.selectList(GBN+"projectEnvList", req);
	}

	public int projectEnvListTotCnt(CustomReqProductVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"projectEnvList", req).size();
	}

	public CustomReqProductVO mbrEnvDetailInfo(CustomReqProductVO req) {
    	Assert.notNull(req.getCicdProjectId(), "");
		return (CustomReqProductVO) sqlSession.selectOne(GBN+"mbrEnvDetailInfo", req);
	}

	public List<CustomReqProductVO> mbrEnvUserList(String cicdProjectId) {
		return sqlSession.selectList(GBN+"mbrEnvUserList", cicdProjectId);
	}

    public List<CustomReqProductVO> mbrDevCicdPipelineList(CustomReqProductVO req) {
    	Assert.notNull(req.getUserId(), "");
    	return sqlSession.selectList(GBN+"mbrDevCicdPipelineList", req);
    }

    public int mbrDevCicdPipelineListTotCnt(CustomReqProductVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"mbrDevCicdPipelineList", req).size();
    }

    public List<CustomReqProductVO> mbrPrdCicdPipelineList(CustomReqProductVO req) {
    	Assert.notNull(req.getUserId(), "");
    	return sqlSession.selectList(GBN+"mbrPrdCicdPipelineList", req);
    }

    public int mbrPrdCicdPipelineListTotCnt(CustomReqProductVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"mbrPrdCicdPipelineList", req).size();
    }

    public List<CustomReqProductVO> mbrPrdList(CustomReqProductVO req) {
    	Assert.notNull(req.getUserId(), "");
    	return sqlSession.selectList(GBN+"mbrPrdList", req);
    }

    public int mbrPrdListTotCnt(CustomReqProductVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"mbrPrdList", req).size();
    }

    public int devAppIdChk(CustomReqProductVO req){
    	return sqlSession.selectOne(GBN+"devAppIdChk", req);
    }

    public int devUsersNameCheck(CustomReqProductVO req){
    	return sqlSession.selectOne(GBN+"devUsersNameCheck", req);
    }

    public int devUsersMailCheck(CustomReqProductVO req){
    	return sqlSession.selectOne(GBN+"devUsersMailCheck", req);
    }

    public CustomReqProductVO getPrdPipeLineDetail(CustomReqProductVO req) {
    	return sqlSession.selectOne(GBN + "getPrdPipeLineDetail",req);
    }

    public CustomReqProductVO getPrdPipeLineVersion(CustomReqProductVO req) {
    	return sqlSession.selectOne(GBN + "getPrdPipeLineVersion",req);
    }

    public CustomReqProductVO getDevPipeLineDetail(CustomReqProductVO req) {
    	return sqlSession.selectOne(GBN + "getDevPipeLineDetail",req);
    }

    public CustomReqProductVO getDevPipeLineVersion(CustomReqProductVO req) {
    	return sqlSession.selectOne(GBN + "getDevPipeLineVersion",req);
    }

    public CustomReqProductVO detailBssOrderProductEnv(CustomReqProductVO req) {
    	return sqlSession.selectOne(GBN + "detailBssOrderProductEnv", req);
    }

    public CustomReqProductVO cicdProjectUserInfo(CustomReqProductVO req) {
    	return sqlSession.selectOne(GBN + "cicdProjectUserInfo", req);
    }

    public CustomReqProductVO cicdGourpProjectInfo(CustomReqProductVO req) {
    	return sqlSession.selectOne(GBN + "cicdGourpProjectInfo", req);
    }

}
