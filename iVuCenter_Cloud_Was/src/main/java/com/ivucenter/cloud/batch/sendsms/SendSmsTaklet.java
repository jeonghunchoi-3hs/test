package com.ivucenter.cloud.batch.sendsms;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;

import com.ivucenter.cloud.portal.alarms.sms.queue.CustomSmsQueueVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SendSmsTaklet implements Tasklet {

    private final String selectSmsQueueList = "com.ivucenter.cloud.portal.sms.queue.SmsQueueDAO.list";
    
	@Autowired
	private CommonSendSmsService sendSmsService;
	
    @Setter
    private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
	
   	/* local variable */
	private String mailFrom;
	private String mailSmtpHost;
    
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);

		this.mailFrom = (String) this.parameterValues.get("mailFrom");
		this.mailSmtpHost = (String) this.parameterValues.get("mailSmtpHost");
        
		log.debug("mailFrom:{}, mailSmtpHost:{}", this.mailFrom, this.mailSmtpHost);

		List<CustomSmsQueueVO> smsQueueList = this.sqlSessionTemplate.selectList(selectSmsQueueList);
		sendSmsService.sendSmsSocket(smsQueueList);
//		for (SmsQueueVO smsQueuevo : smsQueueList) {
//			sendSmsService.sendSmsDB(smsQueuevo);			
//		}		
		
		return RepeatStatus.FINISHED;
	}

}
