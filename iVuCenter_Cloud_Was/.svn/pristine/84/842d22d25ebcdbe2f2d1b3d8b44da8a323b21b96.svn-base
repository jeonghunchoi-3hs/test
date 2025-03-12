package com.ivucenter.cloud.portal.bss.basket;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ivucenter.cloud.portal.req.catalogue.CustomReqBasketCountVO;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqBasketVO;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqCatalogueVO;
import com.ivucenter.cloud.portal.req.catalogue.ReqCatalogueService;

@Controller
@RequestMapping(value="/mbr/bss/basket")
public class MbrBssBasketController{

	@Autowired
	private BssBasketService service;

	@Autowired
	private ReqCatalogueService reqCatalogueService;

	/**
	 *	ACTION
	 */
	@RequestMapping(value = "/changeBasket")
	public ResponseEntity<CustomReqBasketVO> MbrBssBasketChangeBasket(CustomReqBasketVO req,HttpServletRequest request) {
		CustomReqCatalogueVO ordervo = new CustomReqCatalogueVO();
		CustomReqBasketCountVO customReqBasketCountVO = new CustomReqBasketCountVO();
		ordervo.setUserId(request.getUserPrincipal().getName());
		ordervo.setProjectId(req.getProjectId());
		ordervo.setProjectBoxId(req.getProjectBoxId());
		customReqBasketCountVO = reqCatalogueService.checkProject(ordervo);
		int vmCount = Integer.parseInt(customReqBasketCountVO.getVmCount());
		int DiskCount = Integer.parseInt(customReqBasketCountVO.getDiskCount());
		int ServiceCount = Integer.parseInt(customReqBasketCountVO.getServiceCount());

		String vmUuid = req.getVmUuid();

		if(vmCount + DiskCount + ServiceCount > 0) {
			req.setErrorMsg("2");
			return new ResponseEntity<CustomReqBasketVO>(req, HttpStatus.OK);
		}

		int ctCount = reqCatalogueService.checkContainerTerminal(vmUuid);
		if(ctCount > 0) {
			req.setErrorMsg("3");
			return new ResponseEntity<CustomReqBasketVO>(req, HttpStatus.OK);
		}

		CustomReqBasketVO res = service.changeBasket(req);
		return new ResponseEntity<CustomReqBasketVO>(res, HttpStatus.OK);
	}

}
