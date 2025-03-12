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
import com.ivucenter.cloud.batch.entity.BatchOssServiceVO;

import lombok.Setter;

public class MeasureServiceWriter implements ItemWriter<BatchOssServiceVO> {
		
	private final String METRIC_ITEM = "service";
	
	private final String selectMetricByResourceId 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectMetricByResourceId";
	private final String insertMeteringMetric 			= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertMeteringMetric";
	private final String insertMeteringMeasureService 	= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertMeteringMeasureService";
		
    @Setter
    private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
	
	/* local variables */
	private SqlSessionTemplate sqlSessionTemplate;
//    private Date meteringStartDatetime;
    private Date meteringEndDatetime;
//    private Date baseBillEndDate;
    
	
	@Override
	public void write(List<? extends BatchOssServiceVO> items) throws Exception {
		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.BATCH);
//        this.meteringStartDatetime = (Date) this.parameterValues.get("meteringStartDatetime");
        this.meteringEndDatetime = (Date) this.parameterValues.get("meteringEndDatetime");
		
		for (BatchOssServiceVO item : items) {
			String resourceId = item.getServiceId();
			String metricId = null;
			
			
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
			insertMeasureVO.setMeteringValue(item.getServiceEa());
			insertMeasureVO.setRegDatetime(new Date());
			insertMeasureVO.setServiceType(item.getServiceType());
			
			this.sqlSessionTemplate.insert(insertMeteringMeasureService, insertMeasureVO);
		}
	}
	
}
