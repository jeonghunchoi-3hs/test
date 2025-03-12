package com.ivucenter.cloud.portal.oss.scm;

//@Controller
//@RequestMapping(value="/mbr/oss/scm")
//public class MbrOssScmController {
//
//
//	@Autowired
//	OssScmService ossScmService;
//
//	//리스트
//	@RequestMapping(value = "/list", method = RequestMethod.GET)
//	public ResponseEntity<Object> getScmList(CustomOssScmVO req){
//		log.debug("MbrOssScmController:getScmList()");
//		String res = "";
//		int recordsTotal;
//		int recordsFiltered;
//
//		List<CustomOssScmVO> getScmList = ossScmService.getScmList(req);
//
//		recordsTotal = getScmList.size();
//		recordsFiltered = recordsTotal;
//		try {
//	        JsonObject jsonResponse = new JsonObject();
//	        Gson gson = new Gson();
//
//	        jsonResponse.addProperty("draw", req.getDraw());
//	        jsonResponse.addProperty("recordsTotal", recordsTotal);
//	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
//	        jsonResponse.add("data", gson.toJsonTree(getScmList));
//
//	        res = jsonResponse.toString();
//	    } catch (JsonIOException e) {
//	    }
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}
//}
