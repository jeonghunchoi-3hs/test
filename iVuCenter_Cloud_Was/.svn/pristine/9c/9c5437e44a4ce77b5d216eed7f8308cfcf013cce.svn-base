package com.ivucenter.cloud.batch.metering.cicdApplication;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemReader;
import org.springframework.batch.item.NonTransientResourceException;
import org.springframework.batch.item.ParseException;
import org.springframework.batch.item.UnexpectedInputException;

import com.ivucenter.cloud.batch.entity.BatchCicdPipelineVO;

import lombok.Setter;

public class SyncOpenShiftAppReader implements ItemReader<BatchCicdPipelineVO> {

//	private final String batchDeleteOssAvailability = "com.ivucenter.cloud.portal.oss.availability.OssAvailabilityDAO.batchDeleteOssAvailability";

	private final String batchSelectListCicdPipeline = "com.ivucenter.cloud.portal.oss.App.OssAppDAO.batchSelectListCicdPipeline";

    @Setter
    private SqlSessionFactory sqlSessionFactory;

	private SqlSessionTemplate sqlSessionTemplate;

    @Setter
	private Map<String, Object> parameterValues;

	private List<BatchCicdPipelineVO> cicdPipelineList = null;

	private int index = 0;
    private String applyDatetime;
    private String syncAppStatus;
//	@Autowired
//	private OssCloudService ossCloudService;

	@Override
	public BatchCicdPipelineVO read() throws Exception, UnexpectedInputException, ParseException, NonTransientResourceException {

		this.sqlSessionTemplate = new SqlSessionTemplate(this.sqlSessionFactory, ExecutorType.SIMPLE);

		this.applyDatetime 		= (String) this.parameterValues.get("applyDatetime");
        this.syncAppStatus = (String) this.parameterValues.get("syncAppStatus");

		Map<String, String> map =  new HashMap<>();
		map.put("applyDatetime", applyDatetime);
		map.put("syncAppStatus", syncAppStatus);

		this.cicdPipelineList = sqlSessionTemplate.selectList(batchSelectListCicdPipeline, map);

		if (cicdPipelineList == null || cicdPipelineList.isEmpty()) {
			return null;
		}
		return cicdPipelineList.get(index);
	}

}
