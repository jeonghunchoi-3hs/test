package com.ivucenter.cloud.portal.bss.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.req.catalogue.CustomReqOrderVO;

@Controller
@RequestMapping(value="/mbr/bss/order")
public class MbrBssOrderController{
	
	
	@Autowired
	private BssOrderService service;
	
	/**
	 *	ACTION 
	 */
	@RequestMapping(value = "/changeOrder")
	public ResponseEntity<CustomReqOrderVO> MbrBssBasketChangeOrder(CustomReqOrderVO req) {
		CustomReqOrderVO res = service.directChangeOrder(req);
		return new ResponseEntity<CustomReqOrderVO>(res, HttpStatus.OK);
	}

}
