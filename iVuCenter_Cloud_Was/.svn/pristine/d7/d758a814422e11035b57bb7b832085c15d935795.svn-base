package com.ivucenter.cloud.portal.oss.network;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ivucenter.cloud.portal.oss.subnet.CustomOssSubnetVO;

@Repository
public class OssNetworkDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.oss.network.OssNetworkDAO.";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomOssNetworkVO> list(CustomOssNetworkVO req) {
        return sqlSession.selectList(GBN+"list", req);
    }
    
    public List<CustomOssNetworkVO> listTot(CustomOssNetworkVO req) {
    	req.setLength(0);
        return sqlSession.selectList(GBN+"list", req);
    }
    
    
    public List<CustomOssNetworkVO> portList(CustomOssNetworkVO req) {
        return sqlSession.selectList(GBN+"portList", req);
    }
    
    public List<CustomOssNetworkVO> portListTot(CustomOssNetworkVO req) {
    	req.setLength(0);
        return sqlSession.selectList(GBN+"portList", req);
    }
    
    
	public CustomOssNetworkVO detail(CustomOssNetworkVO req) {
		return (CustomOssNetworkVO) sqlSession.selectOne(GBN+"detail", req);
	}

	public String getNetworkAlias(String networkId) {
		String sRet = (String) sqlSession.selectOne(GBN+"getNetworkAlias", networkId);
		
		return StringUtils.isNotEmpty(sRet)?sRet:"";
	}

	public int insert(CustomOssNetworkVO req) {
		return (int)sqlSession.insert(GBN+"insert", req);
	}
	
    public int update(CustomOssNetworkVO req) {
    	return (int)sqlSession.update(GBN+"update", req);
    }
    
    public int networkAliasUpdate(CustomOssNetworkVO req) {
    	return (int)sqlSession.update(GBN+"networkAliasUpdate", req);
    }

	public int delete(CustomOssNetworkVO req) {
		return (int)sqlSession.update(GBN+"delete", req);
	}

	public CustomOssNetworkVO detailByNetworkName(CustomOssNetworkVO req) {
		return (CustomOssNetworkVO) sqlSession.selectOne(GBN+"detailByNetworkName", req);
	}
	
	public CustomOssNetworkVO getNetworkInfo(CustomOssNetworkVO req) {
		return (CustomOssNetworkVO) sqlSession.selectOne(GBN+"getNetworkInfo", req);
	}
	
	public List<CustomOssSubnetVO> ruleNetList(CustomOssNetworkVO req) {
		return sqlSession.selectList(GBN+"ruleNetList", req);
	}

	public List<CustomOssNetworkVO> getPortList(CustomOssNetworkVO req) {
		return sqlSession.selectList(GBN+"getPortList", req);
	}
	
	public int virtualIpsUpdate(CustomOssNetworkVO req) {
    	return (int)sqlSession.update(GBN+"virtualIpsUpdate", req);
    }
}
