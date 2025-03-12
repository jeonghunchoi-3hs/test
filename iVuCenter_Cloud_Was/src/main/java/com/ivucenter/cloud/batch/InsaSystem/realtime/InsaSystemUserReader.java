package com.ivucenter.cloud.batch.InsaSystem.realtime;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemReader;
import org.springframework.batch.item.NonTransientResourceException;
import org.springframework.batch.item.ParseException;
import org.springframework.batch.item.UnexpectedInputException;

import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class InsaSystemUserReader implements ItemReader<CustomCmmUserVO> {	
	
	private final String batchJoinedUsers = "com.ivucenter.cloud.batch.resources.BatchInsaSystemDAO.selectListJoinedUser";
	private final String batchUsersInfo = "com.ivucenter.cloud.batch.resources.BatchInsaSystemDAO.selectListInsaUser";

	private List<CustomCmmUserVO> joinedList = null;
	private List<CustomCmmUserVO> userInfoList = null;
		
	// Cloud Potal DB
	@Setter
	private SqlSessionFactory sqlSessionFactory;
    
    private SqlSessionTemplate sqlSessionTemplate;
    
    // KEPCO Insa DB
    @Setter
    private SqlSessionFactory sqlSessionFactory3;
    
    private SqlSessionTemplate sqlSessionTemplate3;
	
    @Setter
	private Map<String, Object> parameterValues;
	
	@Override
	public CustomCmmUserVO read() throws Exception, UnexpectedInputException, ParseException, NonTransientResourceException {
		
		initialize();
		
		if (userInfoList.isEmpty()) {
			this.userInfoList = null;
			return null;			
		}		
		
		return this.userInfoList.remove(0);
	}	
	
	private void initialize() throws Exception {
		
		if(null != this.userInfoList) { return ; }				
		this.joinedList = new ArrayList<CustomCmmUserVO>();
		this.userInfoList = new ArrayList<CustomCmmUserVO>();
		
		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.SIMPLE);
		joinedList = this.sqlSessionTemplate.selectList(batchJoinedUsers);
		log.debug("joinedList", joinedList.toString());
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("joinedList", joinedList);
		
		this.sqlSessionTemplate3 = new SqlSessionTemplate(this.sqlSessionFactory3, ExecutorType.SIMPLE);
		userInfoList = this.sqlSessionTemplate3.selectList(batchUsersInfo, param);
		log.debug("joinedList", userInfoList.toString());
	}
}
