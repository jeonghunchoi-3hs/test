package com.ivucenter.cloud.portal.productUsageStatus.scm;

//@Repository
//public class ProductUsageStatusScmDAO {
//	
//	private final String GBN = "com.ivucenter.cloud.portal.productUsageStatus.scm.ProductUsageStatusScmDAO.";
//	
//    @Autowired
//    private SqlSession sqlSession;
//    
//    /**
//     * 형상관리서비스 목록조회
//     * @param req
//     * @return
//     */
//    public List<CustomProductUsageStatusScmVO> list(CustomProductUsageStatusScmVO req) {
//        return sqlSession.selectList(GBN+"list", req);
//    }
//    
//    public int total(CustomProductUsageStatusScmVO req){
//    	req.setLength(0);
//    	return sqlSession.selectList(GBN+"list", req).size();
//    }
//
//}
