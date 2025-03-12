package com.ivucenter.cloud.portal.productUsageStatus.mca;

//@Service
//public class ProductUsageStatusMcaService {
//	
//	@Autowired
//	private ProductUsageStatusMcaDAO dao;
//	
//	
//	/**
//	 * 형상관리서비스 목록조회
//	 * @param req
//	 * @return
//	 */
//	public String list(CustomProductUsageStatusMcaVO req){
//		List<CustomProductUsageStatusMcaVO> lists = dao.list(req);
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
//	        log.error(e.getMessage());
//	    }
//		return "";
//	}
//	
//	public void excel(CustomProductUsageStatusMcaVO req, ModelMap map) {
//		try{
//			map.addAttribute("excel_gbn", "mca");
//			map.addAttribute("excel_title", "상품사용현황_대외계서비스");
//			map.addAttribute("excel_list", dao.list(req));
//		}catch(Exception e){
//			log.error(e.getMessage());
//		}
//	}
//}
