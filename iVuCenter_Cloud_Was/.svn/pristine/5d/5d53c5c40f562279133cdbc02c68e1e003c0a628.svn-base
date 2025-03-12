package com.ivucenter.cloud.batch.metering;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.MetricIF;
import com.ivucenter.cloud.api.openstack.object.Measure;
import com.ivucenter.cloud.batch.entity.BatchMeteringMeasureVO;
import com.ivucenter.cloud.batch.entity.BatchMeteringMeticVO;
import com.ivucenter.cloud.batch.entity.BatchOssVmVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.util.DateUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("commonService")
public class CommonService {

	private final String selectMetricById 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectMetricById";
	private final String selectCloudById 		= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectCloudById";
	private final String insertMeteringMetric 	= "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertMeteringMetric";
	private final String insertMeteringMeasureVcpu = "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertMeteringMeasureVcpu";
	private final String insertMeteringMeasureMem = "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.insertMeteringMeasureMem";
	private final String selectVmInfo = "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.OssVmCloudId";
	private final String selectMetricByResourceId = "com.ivucenter.cloud.batch.metering.BatchMeteringDAO.selectMetricByResourceId";
	
	@Autowired
	private SqlSessionFactory  sqlSessionFactory;

	private SqlSessionTemplate sqlSessionTemplate = null;

	public void setMetringMetric(String serverId, String metricItem, String metricId) {

		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.BATCH);

		BatchMeteringMeticVO paramMetricVO = new BatchMeteringMeticVO();
		paramMetricVO.setMetricId(metricId);
		paramMetricVO.setResourceId(serverId);
		paramMetricVO.setMetricItem(metricItem);


		this.sqlSessionFactory.openSession().selectOne(selectMetricById, paramMetricVO);
		BatchMeteringMeticVO selectMetricVO = sqlSessionFactory.openSession().selectOne(selectMetricByResourceId, paramMetricVO);

		if (selectMetricVO == null) {
			BatchMeteringMeticVO insertMetricVO = new BatchMeteringMeticVO();
			insertMetricVO.setMetricId(metricId);
			insertMetricVO.setMetricItem(metricItem);
			insertMetricVO.setResourceId(serverId);
			insertMetricVO.setRegDatetime(new Date());

			sqlSessionFactory.openSession().insert(insertMeteringMetric, insertMetricVO);

		}
	}


	public void setMeteringMeasure(String serverId, String metricItem, String metricId, Date startDate, Date endDate, BatchOssVmVO result) {

		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.BATCH);

        String startGmt = DateUtils.convertDateToString(startDate, " Greenwitch", "yyyy-MM-dd'T'HH:mm:ss");
        String stopGmt = DateUtils.convertDateToString(endDate, " Greenwitch", "yyyy-MM-dd'T'HH:mm:ss");

		CustomOssCloudVO cloudVo = new CustomOssCloudVO();
		cloudVo.setCloudId(result.getCloudId());

		cloudVo = this.sqlSessionFactory.openSession().selectOne(selectCloudById, cloudVo);
        
        if(result.getCloudType().equals("openstack")) {
        	MetricIF metricIF = AbstractFactory.getMetricIF(cloudVo);
    		String measureOption = "granularity=300" + "&refresh=true" + "&start=" + startGmt + "&stop=" + stopGmt + "&aggregation=max";

    		List<Measure> vcpuMeasures = null;
            try {
            	vcpuMeasures = metricIF.getMeasures(metricId, measureOption);
            } catch(NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
            	log.info(e.getMessage());
            }

            if(vcpuMeasures != null){
            	for (Measure measure : vcpuMeasures) {
            		BatchMeteringMeasureVO insertMeasureVO = new BatchMeteringMeasureVO();
            		insertMeasureVO.setMetricId(metricId);
            		insertMeasureVO.setMeteringDatetime(DateUtils.convertStringToDate(measure.getTime(), "Greenwitch", "yyyy-MM-dd'T'HH:mm:ss"));
            		insertMeasureVO.setRegDatetime(new Date());

            		if ("vcpus".equals(metricItem)) {
            			insertMeasureVO.setMeteringValue(measure.getValue());
            			this.sqlSessionFactory.openSession().insert(insertMeteringMeasureVcpu, insertMeasureVO);

            		} else if ("memory".equals(metricItem)) {
            			insertMeasureVO.setMeteringValue(measure.getValue() / 1024);
            			this.sqlSessionFactory.openSession().insert(insertMeteringMeasureMem, insertMeasureVO);
            		}
            	}
            }
        
        }else if(result.getCloudType().equals("vmware")) {        	
        	
	        	BatchOssVmVO batchOssVmVO = new BatchOssVmVO();
	        	batchOssVmVO = this.sqlSessionFactory.openSession().selectOne(selectVmInfo, serverId);

        		BatchMeteringMeasureVO insertMeasureVO = new BatchMeteringMeasureVO();
        		insertMeasureVO.setMetricId(metricId);
        		insertMeasureVO.setMeteringDatetime(new Date());
        		insertMeasureVO.setRegDatetime(new Date());

        		if ("vcpus".equals(metricItem)) {
        			insertMeasureVO.setMeteringValue(batchOssVmVO.getVcpus());
        			this.sqlSessionFactory.openSession().insert(insertMeteringMeasureVcpu, insertMeasureVO);

        		} else if ("memory".equals(metricItem)) {
        			insertMeasureVO.setMeteringValue(batchOssVmVO.getMemGb());
        			this.sqlSessionFactory.openSession().insert(insertMeteringMeasureMem, insertMeasureVO);
        		}
        	}
        }
	}
