package com.ivucenter.cloud.batch.InsaSystem.realtime;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class InsaSystemUserWriter implements ItemWriter<CustomCmmUserVO> {

	private final String insertUserTmp	= "com.ivucenter.cloud.batch.resources.BatchInsaSystemDAO.insertUserTmp";

	@Setter
	private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
	
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public void write(List<? extends CustomCmmUserVO> items) throws Exception {
		
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);
				
		for (CustomCmmUserVO item : items) { // kepco 사용자 정보			
			if(item != null){
				log.debug("BATCH INSA USER :" + item.toString());
				
				item.setUserMail(item.getUserMail()+"@kepco.co.kr");
				item.setUserMail(item.getUserMailEnc());
				item.setUserPhone(item.getUserPhoneEnc());
				item.setUserTel(item.getUserTelEnc());
				item.setUserTelEx(item.getUserTelExEnc());
				
				// 회원가입한 사용자의 정보만 업데이트 (insert 없음)
				this.sqlSessionTemplate.update(insertUserTmp, item);
			}
		}
	}
}