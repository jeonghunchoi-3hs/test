package com.ivucenter.cloud.batch.sendKepco;

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

import com.ivucenter.cloud.portal.alarms.withkepco.CustomWithKepcoVO;

import lombok.Setter;

public class SendKepcoTaklet implements Tasklet{	

    private final String selectMailQueueList  = "com.ivucenter.cloud.portal.alarms.withkepco.WithKepcoDAO.selectSendKepcoList";
	
//	@Autowired
//    private SqlSession sqlSession;
	
//	@Autowired
//	CommonSendKepcoService sendKepcoService;
    
    @Autowired
    private SendKepcoService sendKepcoService;
	
    @Setter
    private SqlSessionFactory sqlSessionFactory;    

    @Setter
	private Map<String, Object> parameterValues;
	    		
    private SqlSessionTemplate sqlSessionTemplate;
    
	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
		
		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);		
		List<CustomWithKepcoVO> sendKepcoQueueList = this.sqlSessionTemplate.selectList(selectMailQueueList);
				
//		sendKepcoService.sendKepco(sendKepcoQueueList);
		
		for(CustomWithKepcoVO dbKepcoVo : sendKepcoQueueList) {
			if( ! checkData(dbKepcoVo)) {
				dbKepcoVo.setStep("0");				
				sendKepcoService.deleteSendKepcoQueue(dbKepcoVo);				
				sendKepcoService.storeSendKepcoQueueHistory(dbKepcoVo, "405");
				continue;
			}
									
			sendKepcoService.openThread(dbKepcoVo);
			
			Thread.sleep(100); // 다 수의 스레드 생성 지연
		}
		
		return RepeatStatus.FINISHED;
	}
	
	private boolean checkData(CustomWithKepcoVO withKepcoQueue) {		
		// 하나라도 null 이면 false 리턴
		return (checkNull(withKepcoQueue.getSignType()) || 
				checkNull(withKepcoQueue.getPayerId()) || 
				checkNull(withKepcoQueue.getAlarmSeq()) || 
				checkNull(withKepcoQueue.getApprovalNo()) ||
				checkNull(withKepcoQueue.getSystemName()) || 
				checkNull(withKepcoQueue.getRegDatetime()) || 
				checkNull(withKepcoQueue.getWriterName()) || 
				checkNull(withKepcoQueue.getWriterId()) ) ? false : true;			
	}
	
	private boolean checkNull(String data) {
		return (data == null || 
				data.trim().isEmpty() || 
				data.equals("(NULL)")) ? true : false;			
	}
}
