package com.ivucenter.cloud.batch.hrsystem;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchHrSystemVO;
import com.ivucenter.cloud.entity.CmmUserVO;

import lombok.Setter;

public class CmmUserRetirementWriter implements ItemWriter<CmmUserVO> {
	
	private final String batchHrSystemDAO = "com.ivucenter.cloud.batch.resources.BatchHrSystemDAO.";	
	private final String selectListHrSystem 	= batchHrSystemDAO + "selectListHrSystem";	
	private final String updateCmmUserRetirement 	= batchHrSystemDAO + "updateCmmUserRetirement";
		
    @Setter
	private SqlSessionFactory sqlSessionFactory;

    @Setter
	private Map<String, Object> parameterValues;

	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public void write(List<? extends CmmUserVO> items) throws Exception {
				
		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.SIMPLE);
				
		for (CmmUserVO item : items) {
			
			BatchHrSystemVO vo = new BatchHrSystemVO();
			vo.setUserId(item.getUserId());
			
			BatchHrSystemVO result = this.sqlSessionTemplate.selectOne(selectListHrSystem, vo);
			
			if(result == null){
				CmmUserVO userVo = new CmmUserVO();
				userVo.setUserId(item.getUserId());
				userVo.setDelFlag("Y");
				userVo.setModUserId("BATCH_SYSTEM");				
				this.sqlSessionTemplate.update(updateCmmUserRetirement, userVo);
			}			
		}
	}
}
