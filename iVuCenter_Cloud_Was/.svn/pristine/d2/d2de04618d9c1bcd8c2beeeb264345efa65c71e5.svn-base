package com.ivucenter.cloud.batch.metering;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

import com.ivucenter.cloud.batch.entity.BatchMeteringMeasureVO;
import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MeasureDateDeleteTasklet implements Tasklet {

	private final String batchMeteringDAO = "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.";

	private final String deleteMeasureData 				= batchMeteringDAO + "deleteMeasureData";
	private final String selectMeasureDataRegDatetime 	= batchMeteringDAO + "selectMeasureDataRegDatetime";

    @Setter
	private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;

	/* local variable */
	private SqlSessionTemplate sqlSessionTemplate;
//	private String billYM;
//	private final int limit = 100;
	private Date regDatetime;

	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext context) throws Exception {

		this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);

		regDatetime = DateUtils.addMonths(new Date(), -3);

		BatchMeteringMeasureVO vo = new BatchMeteringMeasureVO();
		vo.setRegDatetime(regDatetime);
		vo.setLimit(1);
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		vo.setRegDateTimeToString(transFormat.format(vo.getRegDatetime()));
		selectMeteringMeasureVcpu(vo);
		selectMeteringMeasureMem(vo);
		selectMeteringMeasureDisk(vo);
		//selectMeteringMeasurePublicip();
		//selectMeteringMeasureNas();
		//selectMeteringMeasureLoadbalancer();
		return RepeatStatus.FINISHED;
	}

	private void selectMeteringMeasureVcpu(BatchMeteringMeasureVO vo) {

		vo.setTableName("metering_measure_vcpu");
//        vo.setLimit(limit);
		BatchMeteringMeasureVO result = this.sqlSessionTemplate.selectOne(selectMeasureDataRegDatetime, vo);
		if(result != null){
			log.debug("[{}] metric:{}, date:{}, regDate: {}",
					vo.getTableName(), result.getMetricId(),
					result.getMeteringDatetime().toString(), result.getRegDatetime().toString());
			deleteMeteringMeasureData(vo);
			selectMeteringMeasureVcpu(vo); // 재귀함수
		}
	}

	private void selectMeteringMeasureMem(BatchMeteringMeasureVO vo) {

		vo.setTableName("metering_measure_mem");
//        vo.setLimit(limit);
        BatchMeteringMeasureVO result = this.sqlSessionTemplate.selectOne(selectMeasureDataRegDatetime, vo);
		if(result != null){
			log.debug("[{}] metric:{}, date:{}, regDate: {}",
					vo.getTableName(), result.getMetricId(),
					result.getMeteringDatetime().toString(), result.getRegDatetime().toString());
			deleteMeteringMeasureData(vo);
			selectMeteringMeasureMem(vo); // 재귀함수
		}
	}

	private void selectMeteringMeasureDisk(BatchMeteringMeasureVO vo) {

		vo.setTableName("metering_measure_disk");
//        vo.setLimit(limit);
		BatchMeteringMeasureVO result = this.sqlSessionTemplate.selectOne(selectMeasureDataRegDatetime, vo);
		if(result != null){
			log.debug("[{}] metric:{}, date:{}, regDate: {}",
					vo.getTableName(), result.getMetricId(),
					result.getMeteringDatetime().toString(), result.getRegDatetime().toString());
			deleteMeteringMeasureData(vo);
			selectMeteringMeasureDisk(vo); // 재귀함수
		}
	}

	private void deleteMeteringMeasureData(BatchMeteringMeasureVO parameter) {
		this.sqlSessionTemplate.delete(deleteMeasureData, parameter);
	}

//	private void selectMeteringMeasurePublicip() {
//
//		BatchMeteringMeasureVO vo = new BatchMeteringMeasureVO();
//		vo.setTableName("metering_measure_publicip");
//        vo.setLimit(limit);
//        vo.setRegDatetime(regDatetime);
//
//		BatchMeteringMeasureVO result = sqlSessionTemplate.selectOne(selectMeasureDataRegDatetime, vo);
//
//		if(result != null){
//			deleteMeteringMeasureData(vo);
//			selectMeteringMeasurePublicip();
//		}
//	}

//	private void selectMeteringMeasureNas() {
//
//		BatchMeteringMeasureVO vo = new BatchMeteringMeasureVO();
//		vo.setTableName("metering_measure_nas");
//        vo.setLimit(limit);
//        vo.setRegDatetime(regDatetime);
//
//		BatchMeteringMeasureVO result = sqlSessionTemplate.selectOne(selectMeasureDataRegDatetime, vo);
//
//		if(result != null){
//			deleteMeteringMeasureData(vo);
//			selectMeteringMeasureNas();
//		}
//	}

//	private void selectMeteringMeasureLoadbalancer() {
//
//		BatchMeteringMeasureVO vo = new BatchMeteringMeasureVO();
//		vo.setTableName("metering_measure_loadbalancer");
//        vo.setLimit(limit);
//        vo.setRegDatetime(regDatetime);
//
//		BatchMeteringMeasureVO result = sqlSessionTemplate.selectOne(selectMeasureDataRegDatetime, vo);
//
//		if(result != null){
//			deleteMeteringMeasureData(vo);
//			selectMeteringMeasureLoadbalancer();
//		}
//	}
}
