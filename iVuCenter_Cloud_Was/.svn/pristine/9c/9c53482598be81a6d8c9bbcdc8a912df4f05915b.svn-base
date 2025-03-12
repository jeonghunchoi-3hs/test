package com.ivucenter.cloud.portal.project.quota;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

import com.ivucenter.cloud.api.openstack.OpenStackUsage;
import com.ivucenter.cloud.api.openstack.object.OpenStackComplexQuota;
import com.ivucenter.cloud.entity.OssAvailabilityVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;


@Repository
public class ProjectQuotaDAO {
	
	private final String GBN = "com.ivucenter.cloud.portal.project.quota.ProjectQuotaDAO";
	private final String GBN2 = "com.ivucenter.cloud.portal.oss.availability.OssAvailabilityDAO";
	
    @Autowired
    private SqlSession sqlSession;
    
    public List<CustomQuotaVO> getQuotaList(CustomQuotaVO req) {
        return sqlSession.selectList(GBN+".QuotaList", req);
    } 
	public int listTot(CustomQuotaVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+".QuotaList", req).size();
	}
	
	public List<CustomQuotaVO> listTotExcel(CustomQuotaVO req) {
		req.setLength(0);
		return sqlSession.selectList(GBN+".QuotaList", req);
	}
	
	public CustomQuotaVO getDetail(OpenStackComplexQuota req) {
		Assert.notNull(req.getProjectId(), "");
		return sqlSession.selectOne(GBN+".getDetail", req);
	}
	
	public CustomQuotaVO getQuota(CustomQuotaVO req){
		Assert.notNull(req.getProjectId(), "");
		return sqlSession.selectOne(GBN+".getQuota",req);		
	}
	public int batchDeleteOssAvailability(CustomOssCloudVO req) {
		return (int)sqlSession.delete(GBN2+".batchDeleteOssAvailability",req);
	
	}
	public int batchInsertOssAvailability(OssAvailabilityVO availVO) {
		return (int)sqlSession.insert(GBN2+".batchInsertOssAvailability",availVO);
	}

	public List<OpenStackUsage> openshftOssOpenshiftAvailability(CustomOssCloudVO req){
		return sqlSession.selectList(GBN2+".openshftOssOpenshiftAvailability",req);		
	}
	public List<OpenStackUsage> openshftOssNutanixAvailability(CustomOssCloudVO req){
		return sqlSession.selectList(GBN2+".openshftOssNutanixAvailability",req);		
	}

}