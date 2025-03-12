package com.ivucenter.cloud.batch.logincheck;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.entity.CmmUserVO;
import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.Setter;


public class LogincheckWriter implements ItemWriter<CmmUserVO> {
		
	private final String loginCheckDAO = "com.ivucenter.cloud.batch.BatchLoginCheckDAO.";	
	private final String updateUseStatus 	= loginCheckDAO + "updateUseStatus";
		
	/* local variable */    
    private String parameterDate;
	
    @Setter
	private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
	
	private SqlSessionTemplate sqlSessionTemplate;	

	@Override
	public void write(List<? extends CmmUserVO> items) throws Exception {
				
		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.BATCH);
		this.parameterDate = (String) this.parameterValues.get("standardDate");
		
		Date longinDate;
		Date standardDate = DateUtils.convertStringToDate(this.parameterDate, "Asia/Seoul", "yyyy-MM-dd HH:mm:ss");
		
		for (CmmUserVO item : items) {	        	
			
			if( (item.getLastLoginDatetime() != null) && 
			    (item.getLastLoginDatetime().length() > 0) ) {
				longinDate = DateUtils.convertStringToDate(item.getLastLoginDatetime(), "Asia/Seoul", "yyyy-MM-dd HH:mm:ss");
				if( standardDate.compareTo(longinDate) > 0 ){
					this.sqlSessionTemplate.update(updateUseStatus, item);
				}
			}
		}
	}	

}
