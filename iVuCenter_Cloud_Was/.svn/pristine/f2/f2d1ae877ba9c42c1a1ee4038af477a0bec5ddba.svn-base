package com.ivucenter.cloud.portal.oss.mca;

//@Controller
//@RequestMapping(value="/mng/oss/mca")
//public class MngOssMcaController {
//
//	@Autowired
//	OssMcaService ossMcaService;
//
//	@RequestMapping(value="/")
//	public String MngOssMca() {
//		log.debug("MngOssMcaController:MngOssMca()");
//		return "mng/oss/mca/mcaList";
//	}
//
//	//리스트
//	@RequestMapping(value = "/mcaList")
//	public String mcaList(){
//		return "mng/oss/mca/mcaList";
//	}
//
//	//리스트
//	@RequestMapping(value = "/mcaList", method = RequestMethod.GET)
//	public ResponseEntity<Object> getMcaList(CustomOssMcaVO req){
//		String res = "";
//		int recordsTotal;
//		int recordsFiltered;
//
//		log.debug("getSearchKind : "+req.getSearchKind());
//		log.debug("getKeyword : "+req.getKeyword());
//
//		List<CustomOssMcaVO> getMcaList = ossMcaService.getMcaList(req);
//
//		recordsTotal = getMcaList.size();
//		recordsFiltered = recordsTotal;
//		try {
//	        JsonObject jsonResponse = new JsonObject();
//	        Gson gson = new Gson();
//
//	        jsonResponse.addProperty("draw", req.getDraw());
//	        jsonResponse.addProperty("recordsTotal", recordsTotal);
//	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
//	        jsonResponse.add("data", gson.toJsonTree(getMcaList));
//
//	        res = jsonResponse.toString();
//	    } catch (JsonIOException e) {
//	        logger.error("JSON 처리 중 오류 발생");
//	    }
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}
//}
