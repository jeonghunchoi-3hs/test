package com.ivucenter.cloud.portal.oss.backup;

//@Controller
//@RequestMapping(value="/mbr/oss/backup")
//public class MbrOssBackupController {
//
//	@Autowired
//	OssBackupService ossBackupService;
//
//	//리스트
//	@RequestMapping(value = "/list", method = RequestMethod.GET , produces="text/plain;charset=UTF-8")
//	public ResponseEntity<Object> getBackupList(CustomOssBackupVO req){
//		log.debug("MbrOssBackupController:getBackupList()");
//		String res = "";
//		int recordsTotal;
//		int recordsFiltered;
//
//		List<CustomOssBackupVO> getBakList = ossBackupService.getBakList(req);
//
//		recordsTotal = getBakList.size();
//		recordsFiltered = recordsTotal;
//		try {
//	        JsonObject jsonResponse = new JsonObject();
//	        Gson gson = new Gson();
//
//	        jsonResponse.addProperty("draw", req.getDraw());
//	        jsonResponse.addProperty("recordsTotal", recordsTotal);
//	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
//	        jsonResponse.add("data", gson.toJsonTree(getBakList));
//
//	        res = jsonResponse.toString();
//	    } catch (JsonIOException e) {
//	        logger.error("JSON 처리 중 오류 발생");
//	    }
//		return new ResponseEntity<Object>(res, HttpStatus.OK);
//	}
//
//
//	//리스트
////	@RequestMapping(value = "/serviceList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
////	public ResponseEntity<Object> getServiceList(CustomOssBackupVO req){
////		String res = "";
////		int recordsTotal;
////		int recordsFiltered;
////
////		List<CustomOssBackupVO> getServiceList = ossBackupService.getServiceList(req);
////
////		recordsTotal = getServiceList.size();
////		recordsFiltered = recordsTotal;
////		try {
////	        JsonObject jsonResponse = new JsonObject();
////	        Gson gson = new Gson();
////
////	        jsonResponse.addProperty("draw", req.getDraw());
////	        jsonResponse.addProperty("recordsTotal", recordsTotal);
////	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
////	        jsonResponse.add("data", gson.toJsonTree(getServiceList));
////
////	        res = jsonResponse.toString();
////	    } catch (JsonIOException e) {
////	        logger.error("JSON 처리 중 오류 발생");
////	    }
////		return new ResponseEntity<Object>(res, HttpStatus.OK);
////	}
//
//}
