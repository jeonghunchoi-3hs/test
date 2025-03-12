package com.ivucenter.cloud.batch.hrsystem;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchHrSystemVO;
import com.ivucenter.cloud.entity.CmmUserVO;
import com.ivucenter.cloud.portal.util.TokenGenerator;

import lombok.Setter;

public class HrSystemUserWriter implements ItemWriter<BatchHrSystemVO> {

	private final String batchHrSystemDAO = "com.ivucenter.cloud.batch.resources.BatchHrSystemDAO.";
	private final String selectListCmmUser 	= batchHrSystemDAO + "selectListCmmUser";	
//	private final String insertHrSystem 	= batchHrSystemDAO + "insertHrSystem";
	private final String insertCmmUser 		= batchHrSystemDAO + "insertCmmUser";
	private final String updateCmmUser 		= batchHrSystemDAO + "updateCmmUser";
		
    @Setter
	private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
	
	private SqlSessionTemplate sqlSessionTemplate;	
	
	@Override
	public void write(List<? extends BatchHrSystemVO> items) throws Exception {	
	
		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.BATCH);
				
		for (BatchHrSystemVO item : items) {			
			
			CmmUserVO vo = new CmmUserVO();
			
			vo.setUserId(item.getUserId());
			vo.setCustomerId("C05COSM");
			vo.setUserName(item.getUserName());
			vo.setUserPhone(item.getUserPhone());
			vo.setUserTel(item.getUserTel());
			vo.setUserMail(item.getUserMail());			
			vo.setRegUserId("BATCH_SYSTEM");
			vo.setDelFlag("N");
			
			CmmUserVO result =  sqlSessionTemplate.selectOne(selectListCmmUser, vo);
			
			if(result == null){
				vo.setUserPassword(TokenGenerator.generate(item.getUserId() , item.getUserId()));
				vo.setSmsRecvFlag("Y");
				vo.setPwdInitFlag("Y");
				vo.setUserAuthority("0000000000000001");
				//vo.setUserStatus("USER_USING");
				this.sqlSessionTemplate.insert(insertCmmUser, vo);
			}else{				
				this.sqlSessionTemplate.update(updateCmmUser, vo);
			}
		}
	}

}
