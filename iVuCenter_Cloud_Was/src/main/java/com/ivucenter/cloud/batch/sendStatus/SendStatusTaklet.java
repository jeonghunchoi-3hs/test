package com.ivucenter.cloud.batch.sendStatus;

import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;

import com.ivucenter.cloud.portal.alarms.template.AlarmsTemplateService;
import com.ivucenter.cloud.portal.home.PotalHomeService;

import lombok.Setter;

public class SendStatusTaklet implements Tasklet{
	
private final String selectMailQueueList  = "com.ivucenter.cloud.portal.alarms.withkepco.WithKepcoDAO.selectSendKepcoList";
	

    @Autowired
    private PotalHomeService potalHomeService;
	
	@Setter
    private SqlSessionFactory sqlSessionFactory;    

    @Setter
	private Map<String, Object> parameterValues;
	    		
    private SqlSessionTemplate sqlSessionTemplate;
    
    @Autowired
	private AlarmsTemplateService alarmsTemplateService;
    
    @Autowired
    private SendStatusService sendStatusService;
	
	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
		
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);		
		
		String result = alarmsTemplateService.mail(70, "18109816", sendStatusService.getContent());
		
		return RepeatStatus.FINISHED;
	}
	
}
