package com.ivucenter.cloud.portal.bbs.notice;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class BbsNoticeDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.bbs.notice.BbsNoticeDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
	public List<CustomBbsNoticeVO> listTot(CustomBbsNoticeVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+"list", req);
	}
    
    public List<CustomBbsNoticeVO> list(CustomBbsNoticeVO req) {
        return sqlSession.selectList(GBN+"list", req);
    } 

	public CustomBbsNoticeVO detail(CustomBbsNoticeVO req) {
		return (CustomBbsNoticeVO) sqlSession.selectOne(GBN+"detail", req);
	}

	public CustomBbsNoticeVO getCurrentNotice(CustomBbsNoticeVO req) {
		return (CustomBbsNoticeVO) sqlSession.selectOne(GBN+"getCurrentNotice", req);
	}
    
    public int insert(CustomBbsNoticeVO req) {
    	return (int)sqlSession.insert(GBN+"insert", req);
    }

    public int update(CustomBbsNoticeVO req) {
    	return (int)sqlSession.update(GBN+"update", req);
    }

	public int delete(CustomBbsNoticeVO req) {
		return (int)sqlSession.update(GBN+"delete", req);
	}

	public void updateHitCount(CustomBbsNoticeVO req) {
		sqlSession.update(GBN+"updateHitCount", req);
	}
	public List<CustomBbsNoticeVO> getNoticeBbscodeList(String codeKeyId) {
		return sqlSession.selectList(GBN + "bbsCodeList",codeKeyId);
	}
	public List<CustomBbsNoticeVO> getApprovalModelStepList(String modeLid) {
		return sqlSession.selectList(GBN + "getApprovalModelStepList",modeLid);
	}
	 public List<CustomBbsNoticeVO> bbsCodeList(String codeKeyId) {
	        return sqlSession.selectList(GBN+"bbsCodeList", codeKeyId);
	 } 
}
