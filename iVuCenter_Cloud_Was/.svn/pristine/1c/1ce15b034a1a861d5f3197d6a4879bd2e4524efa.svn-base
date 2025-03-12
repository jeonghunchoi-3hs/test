package com.ivucenter.cloud.batch.sendmail;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import lombok.Setter;

public class DeleteMailQueueTasklet implements Tasklet {    

    private final String deleteQuery = "com.ivucenter.cloud.portal.mail.queue.MailQueueDAO.batchDelete";
    
    @Setter
    private SqlSessionFactory sqlSessionFactory;
    
    private SqlSessionTemplate sqlSessionTemplate; 

//    private String message;
    
	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);
        
        this.sqlSessionTemplate.delete(deleteQuery);
        
		return RepeatStatus.FINISHED;
	}

}
