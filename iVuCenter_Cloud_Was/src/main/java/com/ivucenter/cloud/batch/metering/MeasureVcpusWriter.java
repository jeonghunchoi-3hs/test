package com.ivucenter.cloud.batch.metering;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Autowired;

import com.ivucenter.cloud.batch.entity.BatchOssVmVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MeasureVcpusWriter implements ItemWriter<Map<String, Object>> {

	private final String OssVmCloudId = "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.OssVmCloudId";

	@Autowired
	CommonService commonService;

    @Setter
    private SqlSessionFactory sqlSessionFactory;
    
    @Setter
	private Map<String, Object> parameterValues;
	
	/* local variables */
	private SqlSessionTemplate sqlSessionTemplate;
    private Date meteringStartDatetime;
    private Date meteringEndDatetime;

	@Override
	public void write(List<? extends Map<String, Object>> items) throws Exception {

		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.BATCH);
        this.meteringStartDatetime = (Date) this.parameterValues.get("meteringStartDatetime");
        this.meteringEndDatetime = (Date) this.parameterValues.get("meteringEndDatetime");

        log.debug("[MeasureVcpusWriter:Param] meteringStartDatetime : {}", meteringStartDatetime);
        log.debug("[MeasureVcpusWriter:Param] meteringEndDatetime : {}", meteringEndDatetime);

		if(items == null){
			log.info("[MeasureVcpusWriter] items is null");
			return ;
		}

		for (Map<String, Object> metricMap : items) {
			metricMap.forEach((key, value) -> {
				String serverId = key;
				String metricId = null;
				if(value instanceof Map<?,?> ) {
					metricId = ((Map<String,String>) value).get("vcpus");
				};

				if (metricId != null && ! metricId.isEmpty()) {
					BatchOssVmVO vo = new BatchOssVmVO();
					vo.setVmUuid(serverId);
			        BatchOssVmVO result = sqlSessionTemplate.selectOne(OssVmCloudId, vo);

			        // vcpu metric 저장하기
					commonService.setMetringMetric(serverId, "vcpus", metricId);

					//vcpu measure 저장하기
					commonService.setMeteringMeasure(serverId, "vcpus", metricId, meteringStartDatetime, meteringEndDatetime, result);
				}

			});
//			for (Map.Entry<String, Object> entry : metricMap.entrySet()) {
//				String serverId = entry.getKey();
//				String metricId = ((Map<String, String>) entry.getValue()).get("vcpus");
//
//				BatchOssVmVO vo = new BatchOssVmVO();
//				vo.setVmUuid(serverId);
//
//		        BatchOssVmVO result = sqlSessionTemplate.selectOne(OssVmCloudId, vo);
//
//				if (metricId != null) {
//					//vcpu metric 저장하기
//					commonService.setMetringMetric(serverId, "vcpus", metricId);
//
//					//vcpu measure 저장하기
//					commonService.setMeteringMeasure("vcpus", metricId, meteringStartDatetime, meteringEndDatetime ,result.getCloudId());
//				}
//			}
		}
	}

}
