package com.ivucenter.cloud.batch.metering.cicdApplication;

import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Autowired;

import com.ivucenter.cloud.api.openshift.object.OpsApiOptionService;
import com.ivucenter.cloud.batch.entity.BatchCicdPipelineVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.oss.application.CustomOssAppVO;
import com.ivucenter.cloud.portal.oss.application.OssAppService;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;
import com.ivucenter.cloud.portal.util.CodeUtil;

import io.fabric8.kubernetes.api.model.ObjectMeta;
import io.fabric8.kubernetes.api.model.ServiceList;
import io.fabric8.openshift.api.model.BuildList;
import io.fabric8.openshift.api.model.DeploymentConfig;
import io.fabric8.openshift.api.model.DeploymentConfigList;
import io.fabric8.openshift.api.model.RouteList;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SyncOpenShiftAppWriter implements ItemWriter<BatchCicdPipelineVO> {

	private final String batchOpenshiftAppDAO = "com.ivucenter.cloud.portal.oss.App.OssAppDAO.";
	private final String updateCicdPipelineStatus = batchOpenshiftAppDAO + "updateCicdPipelineStatus";
	private final String insertOssApp = batchOpenshiftAppDAO + "insertOssApp";
	private final String deleteOssApp = batchOpenshiftAppDAO + "deleteOssApp";
	private final String updateOssAppVersion = batchOpenshiftAppDAO + "updateOssAppVersion";

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	private OpsApiOptionService opsApiOptionService;

	@Autowired
	private OssAppService ossAppService;

    @Setter
	private Map<String, Object> parameterValues;

	@Setter
	private SqlSessionFactory sqlSessionFactory;
	@Setter
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public void write(List<? extends BatchCicdPipelineVO> items) throws Exception {

	    this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);

	    CustomReqProductVO res = new CustomReqProductVO();

	    for (BatchCicdPipelineVO item : items) {
	        try {
	            // 상태 진행 중으로 설정
	            item.setSyncAppStatus(CodeUtil.CMM_CODE_SYNC_APP_ONGOING);
	            item.setModUserId("BATCH_SYSTEM");
	            this.sqlSessionTemplate.update(updateCicdPipelineStatus, item);

	            CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(item.getCloudId());
	            CustomOssAppVO customOssAppVO = new CustomOssAppVO();

	            // 환경에 따른 네임스페이스 설정
	            String appNameSpace = item.getEnvType().equals("DEV")
	                ? item.getProjectName().toLowerCase() + CodeUtil.CREATE_PAAS_DEV_ENV
	                : item.getProjectName().toLowerCase() + CodeUtil.CREATE_PAAS_PORD_ENV;

	            customOssAppVO.setProjectId(item.getProjectId());
	            customOssAppVO.setAppName(item.getAppName());
	            customOssAppVO.setAppNameSpace(appNameSpace);
	            customOssAppVO.setAppUid(item.getAppUid());

	            // 신규 어플리케이션 조회 및 등록
	            DeploymentConfig dc = opsApiOptionService.getDeploymentConfig(cloudVo, appNameSpace, item.getAppName().toLowerCase());
	            if (dc != null) {
	                // 새로운 DeploymentConfig가 존재하는 경우

	                ObjectMeta meta = dc.getMetadata();
	                res.setProjectId(item.getProjectId());
	                res.setAppUid(meta.getUid());
	                res.setApiVersion(dc.getApiVersion());
	                res.setKind(dc.getKind());
	                res.setAppName(meta.getName());
	                res.setAppNameSpace(meta.getNamespace());
//	                String timestamp = LocalDateTime.parse(meta.getCreationTimestamp()).plusHours(9).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
//	                res.setCreateDatetime(LocalDateTime.parse(meta.getCreationTimestamp()).plusHours(9).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))); // 시간 변경
	                res.setCreateDatetime(OffsetDateTime.parse(meta.getCreationTimestamp()).plusHours(9).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
	                res.setOrderProductSeq(item.getOrderProductSeq());
	                res.setTemplateProductSeq(item.getTemplateProductSeq());
	                res.setTemplateCatalogSeq(item.getTemplateCatalogSeq());
	                res.setOsProductSeq(item.getOsProductSeq());
	                res.setImageId(item.getImageId());
	                res.setAppVersion(meta.getLabels().get("app-version").toString());
	                // 리소스 정보 설정
	                res.setPod(dc.getSpec().getReplicas().toString());
//	                res.setCpuReq(Integer.parseInt(dc.getSpec().getTemplate().getSpec().getContainers().get(0).getResources().getRequests().get("cpu").toString()));
	                res.setCpuLimit(Integer.parseInt(dc.getSpec().getTemplate().getSpec().getContainers().get(0).getResources().getLimits().get("cpu").toString()));
//	                res.setMemReq(Integer.parseInt(dc.getSpec().getTemplate().getSpec().getContainers().get(0).getResources().getRequests().get("memory").toString().replaceAll("[^0-9]", "")));
	                res.setMemLimit(Integer.parseInt(dc.getSpec().getTemplate().getSpec().getContainers().get(0).getResources().getLimits().get("memory").toString().replaceAll("[^0-9]", "")));
	                res.setVolume(dc.getSpec().getTemplate().getSpec().getVolumes().size());

	                // 서비스, 라우트, 빌드, 설정 개수 설정
	                ServiceList getServiceList = opsApiOptionService.getService(cloudVo, meta.getNamespace(), meta.getName());
	                RouteList getRouteList = opsApiOptionService.getRouteList(cloudVo, meta.getNamespace());
	                BuildList getBuildList = opsApiOptionService.getBuild(cloudVo, meta.getNamespace(), meta.getName());
	                DeploymentConfigList getConfigList = opsApiOptionService.getDeploymentConfigList(cloudVo, meta.getNamespace());

	                int servicesCnt = getServiceList != null ? getServiceList.getItems().size() : 0;
	                int buildsCnt = getBuildList != null ? getBuildList.getItems().size() : 0;
	                int routesCnt = 0;
	                int configsCnt = 0;

	                for (int rCnt = 0; rCnt < (getRouteList != null ? getRouteList.getItems().size() : 0); rCnt++) {
	                    String tempAppStr = getRouteList.getItems().get(rCnt).getMetadata().getLabels().get("application");
	                    String tempApp = getRouteList.getItems().get(rCnt).getMetadata().getLabels().get("app");

	                    if (meta.getName().equals(tempAppStr) || meta.getName().equals(tempApp)) {
	                        routesCnt++;
	                    }
	                }

	                for (int dCnt = 0; dCnt < (getConfigList != null ? getConfigList.getItems().size() : 0); dCnt++) {
	                    String tempAppStr = getConfigList.getItems().get(dCnt).getMetadata().getLabels().get("application");
	                    String tempApp = getConfigList.getItems().get(dCnt).getMetadata().getLabels().get("app");

	                    if (meta.getName().equals(tempAppStr) || meta.getName().equals(tempApp)) {
	                        configsCnt++;
	                    }
	                }

	                res.setServiceCnt(servicesCnt);
	                res.setRoutesCnt(routesCnt);
	                res.setBuildsCnt(buildsCnt);
	                res.setDeploymentConfigCnt(configsCnt);
	                res.setRegUserId("BATCH_SYSTEM");

	                // 상태 성공으로 업데이트 및 어플리케이션 등록
	                item.setSyncAppStatus(CodeUtil.CMM_CODE_SYNC_APP_SUCCESS);
	                item.setModUserId("BATCH_SYSTEM");
	                item.setAppUid(res.getAppUid());

	                this.sqlSessionTemplate.update(updateCicdPipelineStatus, item);
//	                this.sqlSessionTemplate.insert(insertOssApp, res);

                    CustomOssAppVO existingApp = ossAppService.getDetailOssApp(customOssAppVO);
	                // 재배포 로직: 기존 어플리케이션 삭제
	                if (CodeUtil.CMM_CODE_CICD_REQTYPE_REDEPLOY.equals(item.getCicdRequestType())) {
	                    // DEV
	                    if(item.getEnvType().equals("DEV")) {
	    	                this.sqlSessionTemplate.insert(insertOssApp, res);

	                    	if (existingApp != null && existingApp.getAppUid() != null) {
	                    		res.setAppUid(existingApp.getAppUid());
	                    		this.sqlSessionTemplate.update(deleteOssApp, res); //개발 삭제 // del
	                    	}

	                    }else if(item.getEnvType().equals("PROD")) {  //PROD
	                    	res.setAppUid(existingApp.getAppUid());
	                    	log.info("appVersion : {}", res.getAppVersion());
                    		this.sqlSessionTemplate.update(updateOssAppVersion, res); //버전 업데이트
	                    }

	                }else if(CodeUtil.CMM_CODE_CICD_REQTYPE_NEW_DEPLOY.equals(item.getCicdRequestType())) {
		                this.sqlSessionTemplate.insert(insertOssApp, res);
	                }

	            } else {
	                throw new Exception("DeploymentConfig not found for app: " + item.getAppName());
	            }

	        } catch (Exception e) {
	            item.setSyncAppStatus(CodeUtil.CMM_CODE_SYNC_APP_FAIL);
	            item.setModUserId("BATCH_SYSTEM");
	            this.sqlSessionTemplate.update(updateCicdPipelineStatus, item);
	            e.printStackTrace();
	        }
	    }
	}
}
