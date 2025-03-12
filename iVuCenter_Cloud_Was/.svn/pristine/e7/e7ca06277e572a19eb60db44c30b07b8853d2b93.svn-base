package com.ivucenter.cloud.portal.monitoring.status;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.portal.oss.vm.CustomOssVmVO;

@Repository
public class MonitoringRealtimeStatusDAO {

	private final String GBN = "hq.itrm.kepco.monitoring.status.MonitoringEventDAO.";

	// Mybatis ITRM Session
    @Autowired
    @Resource(name="sqlSession2")
    private SqlSession sqlSession;

    public List<CustomMonitoringStatusVO> list(Map req) {
        return sqlSession.selectList(GBN+"list", req);
    }

	public int listTot(Map req) {
		//req.setLength(0);
		return sqlSession.selectList(GBN+"list", req).size();
	}

	public List<CustomMonitoringStatusVO> getCpuUsaged(CustomOssVmVO req) {
		return sqlSession.selectList(GBN+"getCpuUsaged", req);
	}

	public List<CustomMonitoringStatusVO> getMemUsaged(CustomOssVmVO req) {
		return sqlSession.selectList(GBN+"getMemUsaged", req);
	}

	public List<CustomMonitoringStatusVO> getDiskUsaged(CustomOssVmVO req) {
		return sqlSession.selectList(GBN+"getDiskUsaged", req);
	}

	public List<CustomMonitoringStatusVO> getNetworkUsaged(CustomOssVmVO req) {
		return sqlSession.selectList(GBN+"getNetworkUsaged", req);
	}

	public List<CustomMonitoringStatusVO> getCpuTopX(Map req) {
		return sqlSession.selectList(GBN+"getCpuTopX", req);
	}

	public List<CustomMonitoringStatusVO> getMemTopX(Map req) {
		return sqlSession.selectList(GBN+"getMemTopX", req);
	}
}
