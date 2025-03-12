package com.ivucenter.cloud.portal.oss.scm;

//@Controller
//@RequestMapping(value="/mng/oss/scm")
//public class MngOssScmController {
//
//	
//	@Autowired
//	private OssScmService ossScmService;
//	
//	@RequestMapping(value="/")
//	public String MngOssScm() {			
//		return "mng/oss/scm/scmList";
//	}
//	
//	//리스트
//	@RequestMapping(value = "/scmList")
//	public String scmList() {
//		return "mng/oss/scm/scmList";
//	}
//	
//	//리스트 
//	@RequestMapping(value = "/mcaList", method = RequestMethod.GET)
//	public ResponseEntity<Object> getScmList(CustomOssScmVO req){
//		String res = "";		
//		int recordsTotal;
//		int recordsFiltered;
//		
//		log.debug("getSearchKind : "+req.getSearchKind());
//		log.debug("getKeyword : "+req.getKeyword());
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
//	        log.error(e.getMessage());
//	    }		
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}
//}
