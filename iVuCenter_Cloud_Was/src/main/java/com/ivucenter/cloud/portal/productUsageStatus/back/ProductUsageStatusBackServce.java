package com.ivucenter.cloud.portal.productUsageStatus.back;

//@Service
//public class ProductUsageStatusBackServce {
//
//
//	@Autowired
//	ProductUsageStatusBackDAO dao;
//
//
//	/**
//	 * 형상관리서비스 목록조회
//	 * @param req
//	 * @return
//	 */
//	public String list(CustomProductUsageStatusBackVO req){
//		List<CustomProductUsageStatusBackVO> lists = dao.list(req);
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
//	        jsonResponse.add("totalData", gson.toJsonTree(dao.getTotalGb(req)));
//
//	        return jsonResponse.toString();
//	    } catch (JsonIOException e) {
//	    }
//		return "";
//	}
//
//	public void excel(CustomProductUsageStatusBackVO req, ModelMap map) {
//		try{
//			map.addAttribute("excel_gbn", "back");
//			map.addAttribute("excel_title", "상품사용현황_백업서비스");
//			map.addAttribute("excel_list", dao.list(req));
//		}catch(Exception e){
//			log.error(e.getMessage());
//		}
//	}
//
//}
