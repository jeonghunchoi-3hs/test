package com.ivucenter.cloud.portal.excel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.charge.bill.ChargeBillService;
import com.ivucenter.cloud.portal.charge.bill.CustomChargeBillVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mbr/excel")
public class MbrExcelController{
	
	@Autowired
	private ChargeBillService billService;
	
	// private ExcelService service;
	
	// 청구서 Excel down
	@RequestMapping(value="/billExcelDown")
	public ModelAndView billExcelDown(Map<String, Object> modelMap, 
									  Workbook workbook,
									  HttpServletRequest req, 
									  HttpServletResponse res) throws Exception {
		
		CustomChargeBillVO vo = new CustomChargeBillVO();
		
		vo.setBillYyyymm(req.getParameter("billYyyymm"));
		vo.setCustomerId(req.getParameter("customerId"));
		
		log.debug(req.getParameter("billYyyymm")+" / " +req.getParameter("customerId"));
		
		List<CustomChargeBillVO> excelList = billService.view(vo);
		
		modelMap.put("excelList", excelList);
		
		return new ModelAndView("excelView", modelMap);
		
	}

}
