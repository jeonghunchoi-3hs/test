package com.ivucenter.cloud.portal.bill.invoice.customer;

import java.util.LinkedList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

@Service
public class BillInvoiceCustomerService {

    private static final Logger logger = LoggerFactory.getLogger(BillInvoiceCustomerService.class);

	@Autowired
	BillInvoiceCustomerDAO dao;

	public String list(CustomBillInvoiceCustomerVO req) {

    	List<CustomBillInvoiceCustomerVO> lists = dao.list(req);
    	int recordsTotal = dao.listTot(req).size();
    	int recordsFiltered = recordsTotal;

		List<CustomBillInvoiceCustomerVO> list = new LinkedList<CustomBillInvoiceCustomerVO>();
		for(CustomBillInvoiceCustomerVO vo : lists){
			vo.setUserPhone(vo.getUserPhoneDec());
			vo.setUserTel(vo.getUserTelDec());
			list.add(vo);
		}

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {

            logger.error("JSON 처리 중 오류 발생");

	    }
		return "";
	}

	public List<CustomBillInvoiceCustomerVO> excel(CustomBillInvoiceCustomerVO req) {
		return dao.listTot(req);
	}

}
