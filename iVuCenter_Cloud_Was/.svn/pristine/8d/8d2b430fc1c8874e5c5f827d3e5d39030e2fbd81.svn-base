package com.ivucenter.cloud.batch.human;

import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import lombok.Setter;

public class JobContextTasklet implements Tasklet {
	
    @Setter
	private SqlSessionFactory sqlSessionFactory;

    @Setter
	private Map<String, Object> parameterValues;

	/* local variable */
//	private SqlSessionTemplate sqlSessionTemplate;
//	private long runtime;
//    private String inputFile;


	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext context) throws Exception {
//		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);
//        this.runtime = (long) this.parameterValues.get("runtime");


        String inputFile = "file:C:/eclipse/workspace/사원정보샘플.txt";
        //String inputFile = "classpath:/files/사원정보샘플.txt";

        
        /******************************************/
        // Step Parameter
        /******************************************/
        context.getStepContext().getStepExecution().getJobExecution().getExecutionContext().put("inputFile", inputFile);
        
		return RepeatStatus.FINISHED;
	}

}
