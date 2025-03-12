package com.ivucenter.cloud.portal.charge.bill;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChargeBillDAO {
	private final String GBN = "com.ivucenter.cloud.portal.charge.bill.ChargeBillDAO.";
	
    @Autowired
    private SqlSession sqlSession;
	
    public List<CustomChargeBillVO> list(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"list", req);
	}
    public List<CustomChargeBillVO> listMng(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"listMng", req);
    }
    
    
    
    public List<CustomChargeBillVO> listMngProject(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"listMngProject", req);
    }
    public List<CustomChargeBillVO> listMngProjectTot(CustomChargeBillVO req){
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"listMngProject", req);
    }
    
    
    
    
    
    public List<CustomChargeBillVO> getProjectBillList(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"getProjectBillList", req);
    }
    
    public CustomChargeBillVO getBillDate(CustomChargeBillVO req){
    	return sqlSession.selectOne(GBN+"getBillDate", req);
    }
    public CustomChargeBillVO getUserCustomerId(CustomChargeBillVO req){
    	return sqlSession.selectOne(GBN+"getUserCustomerId", req);
    }

    public int listTot(CustomChargeBillVO req){
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"list", req).size();
    }
    public List<CustomChargeBillVO> listMngTot(CustomChargeBillVO req){
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"listMng", req);
    }
    public int getProjectBillListTot(CustomChargeBillVO req){
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"getProjectBillList", req).size();
    }
    
    public List<CustomChargeBillVO> view(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"view", req);
    }
    public List<CustomChargeBillVO> projectBillView(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"projectBillView", req);
    }

    public CustomChargeBillVO getCustomerId(CustomChargeBillVO req){
    	return sqlSession.selectOne(GBN+"getCustomerId", req);
    }

    public List<CustomChargeBillVO> projectList(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"projectList", req);
    }
    public List<CustomChargeBillVO> invoiceProjectList(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"invoiceProjectList", req);
    }
    public List<CustomChargeBillVO> invoiceProjectBillDetailList(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"invoiceProjectBillDetailList", req);
    }
    public List<CustomChargeBillVO> billDetailList(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"billDetailList", req);
    }
    public List<CustomChargeBillVO> billCustomerDetailList(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"billCustomerDetailList", req);
    }
    public List<CustomChargeBillVO> vmCustomerResource(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"vmCustomerResource", req);
    }
    public List<CustomChargeBillVO> resourceDetail(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"vmResource", req);
    }
    public List<CustomChargeBillVO> resourceDetail2(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"resourceDetail", req);
    }
    public List<CustomChargeBillVO> resourceCustomerDetail(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"resourceCustomerDetail", req);
    }
    public List<CustomChargeBillVO> dcAdDetail(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"dcAdDetail", req);
    }
    public List<CustomChargeBillVO> salesList(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"salesList", req);
    }
    public CustomChargeBillVO salesView(CustomChargeBillVO req){
    	return sqlSession.selectOne(GBN+"salesView", req);
    }
    public List<CustomChargeBillVO> salesViewExcel(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"salesView", req);
    }
    public List<CustomChargeBillVO> salesExcelList(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"salesExcelList", req);
    }
    public CustomChargeBillVO salesTotalAmount(CustomChargeBillVO req){
    	return sqlSession.selectOne(GBN+"salesTotalAmount", req);
    }
    public List<CustomChargeBillVO> salesListTot(CustomChargeBillVO req){
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"salesList", req);
    }
    public List<CustomChargeBillVO> calculateList(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"calculateList", req);
    }
    public int calculateListTot(CustomChargeBillVO req){
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"calculateList", req).size();
    }
    public List<CustomChargeBillVO> calculateDetailList(CustomChargeBillVO req){
    	return sqlSession.selectList(GBN+"calculateDetailList", req);
    }
    public int calculateDetailListTot(CustomChargeBillVO req){
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"calculateDetailList", req).size();
    }
    public String updateConfirmFlag(CustomChargeBillVO req){
    	return sqlSession.update(GBN+"updateConfirmFlag", req)+"";
    }

    public int getStepAuth(CustomChargeBillVO req){
    	return sqlSession.selectOne(GBN+"getStepAuth", req);
    }
}
