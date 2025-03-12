package com.ivucenter.cloud.portal.oss.network;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;

@Controller
@RequestMapping(value="/mng/oss/network")
public class MngOssNetworkController {

	@Autowired
	private OssNetworkService service;

	@Autowired
	private OssCloudService cloudService;


	/**
	 * page
	 */
	@RequestMapping(value="/", method = RequestMethod.GET , produces="application/text; charset=utf8")
	public String CmmNetwork(Model model) {

		return "mng/oss/network/ossNetwork-list";
	}

	@RequestMapping(value="/detail", method = RequestMethod.GET , produces="application/text; charset=utf8")
	public String ossNetworkDetail(Model model, CustomOssNetworkVO req) {

		model.addAttribute("networkId", req.getNetworkId());
		CustomOssNetworkVO getSubnetView = service.detail(req);
		model.addAttribute("getSubnetView", getSubnetView);

		return "mng/oss/network/ossNetwork-view";
	}

	/**
	 *	ACTION
	 */
	@RequestMapping(value="/list", method = RequestMethod.GET , produces="application/text; charset=utf8")
	public ResponseEntity<Object> MngOssNetworkList(CustomOssNetworkVO req){
//		log.debug("MngOssNetworkController:MngOssNetworkList()");
		String res = service.list(req);


		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


	@RequestMapping(value = "/excel")
	public ModelAndView MngCmmNetworkExcel(CustomOssNetworkVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "cmmNetwork");
		map.addAttribute("excel_title", "정책관리_네트워크정책관리");
		map.addAttribute("excel_list", service.excel(req));

		return new ModelAndView("operationExcelView", map);
	}

	@RequestMapping(value = "/detailExcel")
	public ModelAndView MngCmmNetworkDetailExcel(CustomOssNetworkVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "cmmNetworkDetail");
		map.addAttribute("excel_title", "정책관리_네트워크정책관리 IP주소 이용현황");
		map.addAttribute("excel_list", service.detailExcel(req));

		return new ModelAndView("operationExcelView", map);
	}

	@RequestMapping(value = "/portList", produces="application/json;charset=UTF-8")
	public ResponseEntity<Object> portList(CustomOssNetworkVO req, Model model) {
		String res = service.portList(req);

		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


	@RequestMapping(value = "/networkAliasUpdate")
	public ResponseEntity<String> networkAliasUpdate(CustomOssNetworkVO req, Model model) {
		String res = "";
		try {
			res = service.networkAliasUpdate(req);

			return new ResponseEntity<String>(res, HttpStatus.OK);
		} catch (Exception e) {
			res = e.getMessage();
		}
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	@RequestMapping(value = "/networkInfoDetail", produces="application/json;charset=UTF-8")
	public ResponseEntity<Object> mngOssNetworkDetail(CustomOssNetworkVO req, Model model) {
		CustomOssNetworkVO res = service.detail(req);

		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/update")
	public ResponseEntity<String> MngOssNetworkUpdate(CustomOssNetworkVO req, Model model) {
		String res = "";
		try {
			res = service.update(req);

			return new ResponseEntity<String>(res, HttpStatus.OK);
		} catch (Exception e) {
			res = e.getMessage();
		}
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


//	@RequestMapping(value="/mngPortList", method = RequestMethod.GET)
//	public ResponseEntity<Object> MngOssPortList(Model model, CustomOssNetworkVO req){
//
//		String res = service.getPortList(req);
//
//		model.addAttribute("networkId", req.getNetworkId());
//
//
//		if(res.equals("")){
//			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
//		}
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}

//	@RequestMapping(value = "/ruleNetList", method = RequestMethod.GET)
//	public  ResponseEntity<Object>  MngProjectNetworkRuleList(Model model, CustomOssNetworkVO req) {
//
//			List<CustomOssSubnetVO> ruleList = service.getRuleList(req);
//
//			HashMap<String, Object> map = new HashMap<>();
//			map.put("ruleList", ruleList);
//
//			return new ResponseEntity<Object>(map, HttpStatus.OK);
//	}


//	@RequestMapping(value = "/info")
//	public ResponseEntity<CustomOssNetworkVO> MngOssNetworkInfo(CustomOssNetworkVO req) {
//		CustomOssNetworkVO res = service.info(req);
//
//		return new ResponseEntity<CustomOssNetworkVO>(res, HttpStatus.OK);
//	}



//	@RequestMapping(value = "/insert")
//	public ResponseEntity<String> MngOssNetworkInsert(CustomOssNetworkVO req) {
//		String res = service.insert(req);
//
//		return new ResponseEntity<String>(res, HttpStatus.OK);
//	}

//	@RequestMapping(value = "/update")
//	public ResponseEntity<String> MngOssNetworkUpdate(CustomOssNetworkVO req) {
//		String res = service.update(req);
//
//		return new ResponseEntity<String>(res, HttpStatus.OK);
//	}

	@RequestMapping(value = "/virtualIpsUpdate")
	public ResponseEntity<String> virtualIpsUpdate(CustomOssNetworkVO req, Model model) {
		String res = "";
		try {
			res = service.virtualIpsUpdate(req);

			return new ResponseEntity<String>(res, HttpStatus.OK);
		} catch (Exception e) {
			res = e.getMessage();
		}
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

}
