package com.ivucenter.cloud.portal.productUsageStatus.sec;

//@Service
//public class ProductUsageStatusSecService {
//	
//	
//	@Autowired
//	private ProductUsageStatusSecDAO dao;
//	
//	
//	/**
//	 * 보안관제서비스 목록조회
//	 * @param req
//	 * @return
//	 */
//	public String list(CustomProductUsageStatusSecVO req){
//		List<CustomProductUsageStatusSecVO> lists = dao.list(req);
//		
//		int recordsTotal = dao.total(req);
//    	int recordsFiltered = recordsTotal;
//	    
//	    try {
//	        JsonObject jsonResponse = new JsonObject();
//	        Gson gson = new Gson();
//	        
//	        jsonResponse.addProperty("draw", req.getDraw());
//	        jsonResponse.addProperty("recordsTotal", recordsTotal);
//	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
//	        jsonResponse.add("data", gson.toJsonTree(lists));
//	         
//	        return jsonResponse.toString();
//	    } catch (JsonIOException e) {
//	    	log.error(e.getMessage());
//	    }
//		return "";
//	}
//
//	public void excel(CustomProductUsageStatusSecVO req, ModelMap map) {
//		try{
//			map.addAttribute("excel_gbn", "sec");
//			map.addAttribute("excel_title", "상품사용현황_보안관제서비스");
//			map.addAttribute("excel_list", dao.list(req));
//		}catch(Exception e){
//			log.error(e.getMessage());
//		}
//	}
//}
