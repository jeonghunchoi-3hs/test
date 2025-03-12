package com.ivucenter.cloud.portal.oss.security;

//@Controller
//@RequestMapping(value="/mbr/oss/security")
//public class MbrOssSecurityController {
//
//	
//	@Autowired
//	OssSecurityService ossSecurityService;
//	
//	
//	//리스트 
//	@RequestMapping(value = "/list", method = RequestMethod.GET)
//	public ResponseEntity<Object> getScrList(HttpServletRequest request,HttpServletResponse response,CustomOssSecurityVO req){
//		String res = "";		
//		int recordsTotal;
//		int recordsFiltered;
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
//	    	log.error(e.getMessage());
//	    }		
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}
//}
