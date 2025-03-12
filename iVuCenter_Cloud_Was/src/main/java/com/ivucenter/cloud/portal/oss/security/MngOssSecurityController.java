package com.ivucenter.cloud.portal.oss.security;

//@Controller
//@RequestMapping(value="/mng/oss/security")
//public class MngOssSecurityController {
//
//
//	@Autowired
//	OssSecurityService ossSecurityService;
//
//	@RequestMapping(value="/")
//	public String MngOssScr() {
//		log.debug("MngOssSecurityController:MngOssScr()");
//		return "mng/oss/security/scrList";
//	}
//
//	//리스트
//	@RequestMapping(value = "/scrList")
//	public String scrList() {
//		return "mng/oss/security/scrList";
//	}
//
//	//리스트
//	@RequestMapping(value = "/scrList", method = RequestMethod.GET)
//	public ResponseEntity<Object> getScrList(CustomOssSecurityVO req){
//		String res = "";
//		int recordsTotal;
//		int recordsFiltered;
//
//		log.debug("getSearchKind : "+req.getSearchKind());
//		log.debug("getKeyword : "+req.getKeyword());
//
//		List<CustomOssSecurityVO> getScrList = ossSecurityService.getScrList(req);
//
//		recordsTotal = getScrList.size();
//		recordsFiltered = recordsTotal;
//		try {
//	        JsonObject jsonResponse = new JsonObject();
//	        Gson gson = new Gson();
//
//	        jsonResponse.addProperty("draw", req.getDraw());
//	        jsonResponse.addProperty("recordsTotal", recordsTotal);
//	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
//	        jsonResponse.add("data", gson.toJsonTree(getScrList));
//
//	        res = jsonResponse.toString();
//	    } catch (JsonIOException e) {
//	    }
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}
//}
