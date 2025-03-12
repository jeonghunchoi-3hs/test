package com.ivucenter.cloud.portal.oss.backup;

//@Controller
//@RequestMapping(value="/mng/oss/backup")
//public class MngOssBackupController {
//
//	@Autowired
//	OssBackupService ossBackupService;
//
//	@RequestMapping(value="/")
//	public String MngOssBackup() {
//		log.debug("MngOssBackupController:MngOssBackup()");
//		return "mng/oss/backup/bakList";
//	}
//
//	//리스트
//	@RequestMapping(value = "/bakList")
//	public String bakList(){
//		return "mng/oss/backup/bakList";
//	}
//
//	//리스트
//	@RequestMapping(value = "/bakList", method = RequestMethod.GET)
//	public ResponseEntity<Object> getBackupList(CustomOssBackupVO req){
//		String res = "";
//		int recordsTotal;
//		int recordsFiltered;
//
//		log.debug("getSearchKind : "+req.getSearchKind());
//		log.debug("getKeyword : "+req.getKeyword());
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
//}
