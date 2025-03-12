package com.ivucenter.cloud.portal.productUsageStatus.back;

//@Repository
//public class ProductUsageStatusBackDAO {
//	
//	private final String GBN = "com.ivucenter.cloud.portal.productUsageStatus.back.ProductUsageStatusBackDAO.";
//	
//	@Autowired
//    private SqlSession sqlSession;
//	
//	/**
//     * 백업서비스 목록조회
//     * @param req
//     * @return
//     */
//    public List<CustomProductUsageStatusBackVO> list(CustomProductUsageStatusBackVO req) {
//        return sqlSession.selectList(GBN+"list", req);
//    }
//    
//    public int total(CustomProductUsageStatusBackVO req){
//    	req.setLength(0);
//    	return sqlSession.selectList(GBN+"list", req).size();
//    }
//    
//    public CustomProductUsageStatusBackVO getTotalGb(CustomProductUsageStatusBackVO req){
//    	return sqlSession.selectOne(GBN+"getTotalGb", req);
//    }
//
//}
