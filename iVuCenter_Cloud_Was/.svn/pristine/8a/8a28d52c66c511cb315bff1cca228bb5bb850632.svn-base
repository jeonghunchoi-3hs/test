package com.ivucenter.cloud.portal.oss.scaleOut;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class ScaleOutDAO {

	private final String GBN = "com.ivucenter.cloud.portal.oss.scaleOut.ScaleOutDAO.";

    @Autowired
    private SqlSession sqlSession;

	public int listTot(CustomScaleOutVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req).size();
	}

    public List<CustomScaleOutVO> list(CustomScaleOutVO req) {
        return sqlSession.selectList(GBN+"list", req);
    }

    public List<CustomScaleOutVO> excel(CustomScaleOutVO req) {
    	return sqlSession.selectList(GBN+"list", req);
    }

	public CustomScaleOutVO detail(CustomScaleOutVO req) {
		return (CustomScaleOutVO) sqlSession.selectOne(GBN+"detail", req);
	}

    public int update(CustomScaleOutVO req) {
    	return sqlSession.update(GBN+"update", req);
    }

    public int delete(CustomScaleOutVO req) {
    	return sqlSession.update(GBN+"delete", req);
    }

}
