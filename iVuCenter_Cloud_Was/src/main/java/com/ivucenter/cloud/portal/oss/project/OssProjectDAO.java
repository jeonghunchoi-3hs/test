package com.ivucenter.cloud.portal.oss.project;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

import com.ivucenter.cloud.batch.entity.BatchOssProjectVO;
import com.ivucenter.cloud.portal.req.customer.CustomReqCustomerVO;

//@Slf4j
@Repository
public class OssProjectDAO {

	private final String GBN = "com.ivucenter.cloud.portal.oss.project.OssProjectDAO.";

    @Autowired
    private SqlSession sqlSession;

    public List<CustomOssProjectVO> list(CustomOssProjectVO req) {
        return sqlSession.selectList(GBN+"list", req);
    }
    public int listTotCnt(CustomOssProjectVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"list", req).size();
    }

    public List<CustomOssProjectVO> mbrList(CustomOssProjectVO req) {
    	Assert.notNull(req.getUserId(), "");
    	return sqlSession.selectList(GBN+"mbrList", req);
    }

    public int mbrListTotCnt(CustomOssProjectVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"mbrList", req).size();
    }

    public List<CustomOssProjectVO> mbrAppList(CustomOssProjectVO req) {
    	Assert.notNull(req.getUserId(), "");
    	return sqlSession.selectList(GBN+"mbrAppList", req);
    }

    public int mbrAppListTotCnt(CustomOssProjectVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"mbrAppList", req).size();
    }

    public List<CustomOssProjectVO> mbrNasAppList(CustomOssProjectVO req) {
    	Assert.notNull(req.getUserId(), "");
    	return sqlSession.selectList(GBN+"mbrNasAppList", req);
    }

    public int mbrNasAppListTotCnt(CustomOssProjectVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"mbrNasAppList", req).size();
    }

    public List<CustomOssProjectVO> mbrFsList(CustomOssProjectVO req) {
    	Assert.notNull(req.getUserId(), "");
    	return sqlSession.selectList(GBN+"mbrFsList", req);
    }

    public int mbrFsListTotCnt(CustomOssProjectVO req) {
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"mbrFsList", req).size();
    }

	public List<CustomOssProjectVO> projectServiceList(CustomOssProjectVO req) {
		return sqlSession.selectList(GBN+"projectServiceList", req);
	}
	public int projectServiceListTotalCnt(CustomOssProjectVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"projectServiceList", req).size();
	}

	public List<CustomOssProjectVO> mbrProjectServiceList(CustomOssProjectVO req) {
		return sqlSession.selectList(GBN+"mbrProjectServiceList", req);
	}
	public int mbrProjectServiceListTotal(CustomOssProjectVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"mbrProjectServiceList", req).size();
	}

	public CustomOssProjectVO boxDetail(CustomOssProjectVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		return (CustomOssProjectVO) sqlSession.selectOne(GBN+"boxDetail", req);
	}

	public CustomOssProjectVO detail(CustomOssProjectVO req) {
		Assert.notNull(req.getProjectId(), "");
		return (CustomOssProjectVO) sqlSession.selectOne(GBN+"detail", req);
	}

	public CustomOssProjectVO projectVmInfo(CustomOssProjectVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		return (CustomOssProjectVO) sqlSession.selectOne(GBN+"projectVmInfo", req);
	}
	public CustomOssProjectVO projectServiceInfo(CustomOssProjectVO req) {
		Assert.notNull(req.getProjectId(), "");
		return (CustomOssProjectVO) sqlSession.selectOne(GBN+"projectServiceInfo", req);
	}

	public CustomOssProjectVO projectNasInfo(CustomOssProjectVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		return (CustomOssProjectVO) sqlSession.selectOne(GBN+"projectNasInfo", req);
	}

	public int delete(CustomOssProjectVO req) {
		Assert.notNull(req.getProjectId(), "");
		return (int)sqlSession.update(GBN+"delete", req);
	}

	public int insert(CustomOssProjectVO req) {
    	return (int)sqlSession.insert(GBN+"insert", req);
    }

	public int boxInsert(CustomOssProjectVO req) {
    	return (int)sqlSession.insert(GBN+"boxInsert", req);
    }

	public int insertManager(CustomReqCustomerVO vo) {
    	return (int)sqlSession.insert(GBN+"insertManager", vo);
    }

	public int update(CustomOssProjectVO req){
		return (int)sqlSession.update(GBN+"update", req);
	}

	public int insertProvisioning(CustomOssProjectVO req) {
		return (int)sqlSession.insert(GBN+"insertProvisioning", req);
	}

	public int projectNameChk(CustomOssProjectVO req){
		Assert.notNull(req.getProjectName(), "");
		return sqlSession.selectOne(GBN+"projectNameChk", req);
	}

	public int projectNameNextChk(CustomOssProjectVO req){
		Assert.notNull(req.getProjectName(), "");
		return sqlSession.selectOne(GBN+"projectNameNextChk", req);
	}

	public int projectBoxIdChk(CustomOssProjectVO req){
		return sqlSession.selectOne(GBN+"projectBoxIdChk", req);
	}

	public BatchOssProjectVO selectProjectById(BatchOssProjectVO req){
		return sqlSession.selectOne(GBN+"selectProjectById", req);
	}

	public CustomOssProjectVO getOssProjectName(CustomOssProjectVO req) {
		return sqlSession.selectOne(GBN+"getOssProjectName", req);

	}

	public CustomOssProjectVO getOssProjectIdByCloudId(CustomOssProjectVO req) {
		return sqlSession.selectOne(GBN+"getOssProjectIdByCloudId", req);

	}

	public CustomOssProjectVO projectBoxByProgramSeq(CustomOssProjectVO req){
		return sqlSession.selectOne(GBN+"projectBoxByProgramSeq", req);
	}

}
