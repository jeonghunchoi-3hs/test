package com.ivucenter.cloud.batch.metering;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;

import com.ivucenter.cloud.batch.entity.BatchMeteringMeasureVO;
import com.ivucenter.cloud.batch.entity.BatchMeteringMeticVO;
import com.ivucenter.cloud.batch.entity.BatchOssDiskVO;

import lombok.Setter;

public class MeasureDiskWriter implements ItemWriter<BatchOssDiskVO> {	
	
	private final String selectMetricByResourceId 	= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectMetricByResourceId";
	private final String insertMeteringMetric 	= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertMeteringMetric";
	private final String insertMeteringMeasureDisk 	= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertMeteringMeasureDisk";
		
    @Setter
    private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
	
	/* local variables */
	private SqlSessionTemplate sqlSessionTemplate;
//    private Date meteringStartDatetime;
    private Date meteringEndDatetime;
    private final String METRIC_ITEM = "volume.size";

	@Override
	public void write(List<? extends BatchOssDiskVO> items) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.BATCH);
//        this.meteringStartDatetime = (Date) this.parameterValues.get("meteringStartDatetime");
        this.meteringEndDatetime = (Date) this.parameterValues.get("meteringEndDatetime");
		
		for (BatchOssDiskVO item : items) {
			String resourceId = item.getDiskId();
			String metricId = null;
			
			//volume.size MetricID 생성
			BatchMeteringMeticVO paramMeticVO = new BatchMeteringMeticVO();
			paramMeticVO.setResourceId(resourceId);
			paramMeticVO.setMetricItem(this.METRIC_ITEM);
			
			BatchMeteringMeticVO selectMeticVO = this.sqlSessionTemplate.selectOne(selectMetricByResourceId, paramMeticVO);
			if (selectMeticVO == null) {
				metricId = UUID.randomUUID().toString();
				
				BatchMeteringMeticVO insertMetricVO = new BatchMeteringMeticVO();
				insertMetricVO.setMetricId(UUID.randomUUID().toString());
				insertMetricVO.setMetricItem(this.METRIC_ITEM);
				insertMetricVO.setResourceId(resourceId);
				insertMetricVO.setRegDatetime(new Date());
				
				this.sqlSessionTemplate.insert(insertMeteringMetric, insertMetricVO);
			} else {
				metricId = selectMeticVO.getMetricId();
			}
			
			BatchMeteringMeasureVO insertMeasureVO = new BatchMeteringMeasureVO();
			insertMeasureVO.setMetricId(metricId);
			insertMeasureVO.setMeteringDatetime(meteringEndDatetime);
			insertMeasureVO.setMeteringValue(item.getSizeGb());
			insertMeasureVO.setRegDatetime(new Date());
			
			this.sqlSessionTemplate.insert(insertMeteringMeasureDisk, insertMeasureVO);
		}
	}
	
}
