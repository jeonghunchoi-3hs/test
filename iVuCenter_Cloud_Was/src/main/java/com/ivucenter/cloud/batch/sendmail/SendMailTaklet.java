package com.ivucenter.cloud.batch.sendmail;

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

import com.ivucenter.cloud.entity.MailQueueVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@Slf4j
public class SendMailTaklet implements Tasklet {	

    private final String selectMailQueueList = "com.ivucenter.cloud.portal.mail.queue.MailQueueDAO.selectMailQueueList";
    	
    @Setter
    private SqlSessionFactory sqlSessionFactory;    

    @Setter
	private Map<String, Object> parameterValues;	

    @Autowired
	CommonSendMailService sendMailService;
	
   	/* local variable */
	private String mailFrom;
	private String mailSmtpHost;
    
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
		sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);

		this.mailFrom = (String) this.parameterValues.get("mailFrom");
		this.mailSmtpHost = (String) this.parameterValues.get("mailSmtpHost");
        log.debug("step param : mailFrom :" + this.mailFrom );
        log.debug("step param : mailSmtpHost :" + this.mailSmtpHost );

		List<MailQueueVO> mailQueues = sqlSessionTemplate.selectList(selectMailQueueList);
		for (MailQueueVO mailQueue : mailQueues) {
			sendMailService.sendEmail(mailQueue);
		}		
		Thread.sleep(3000);
		return RepeatStatus.FINISHED;
	}

}
