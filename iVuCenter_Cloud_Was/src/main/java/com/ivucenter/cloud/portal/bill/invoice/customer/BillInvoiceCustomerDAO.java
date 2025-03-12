package com.ivucenter.cloud.portal.bill.invoice.customer;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BillInvoiceCustomerDAO {
	private final String GBN = "com.ivucenter.cloud.portal.bill.invoice.customer.BillInvoiceCustomerDAO.";
	
    @Autowired
    private SqlSession sqlSession;
	
    public List<CustomBillInvoiceCustomerVO> list(CustomBillInvoiceCustomerVO req){
    	return sqlSession.selectList(GBN+"list", req);
    }
    public List<CustomBillInvoiceCustomerVO> listTot(CustomBillInvoiceCustomerVO req){
    	req.setLength(0);
    	return sqlSession.selectList(GBN+"list", req);
    }
}
