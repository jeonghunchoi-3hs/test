package com.ivucenter.cloud.portal.excel;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.charge.bill.ChargeBillDAO;
import com.ivucenter.cloud.portal.charge.bill.ChargeBillService;
import com.ivucenter.cloud.portal.charge.bill.CustomChargeBillVO;

@Controller
@RequestMapping(value="/mng/excel")
public class MngExcelController {

	@Autowired
	ChargeBillService billService;
	
	@Autowired
	private ChargeBillDAO dao;
	
	//private ExcelService service;
	
	// 청구서 Excel down
	@RequestMapping(value="/salesExcelDown")
	public ModelAndView salesExcelDown(Map<String, Object> modelMap, CustomChargeBillVO req) throws Exception {
		List<CustomChargeBillVO> excelList = dao.salesListTot(req);
		modelMap.put("excelList", excelList);
	    CustomChargeBillVO billVo = dao.salesTotalAmount(req);
        if(billVo !=null){
        	modelMap.put("totalAmount", billVo.getAmount());
        }else{
        	modelMap.put("totalAmount", "0");
        }
		return new ModelAndView("salesExcelView", modelMap);
		
	}

}
