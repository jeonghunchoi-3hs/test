package com.ivucenter.cloud.portal.application.env;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.api.common.utils.SystemCalculatorInfo;
import com.ivucenter.cloud.api.gitlab.GitlabObject;
import com.ivucenter.cloud.api.gitlab.GitlabUtils;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.oss.application.OssAppService;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.oss.service.CustomOssServiceVO;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqOrderVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping(value="/mbr/application/env")
public class mbrEnvAppController {

	@Autowired
	OssAppService service;

	@RequestMapping(value="/envList")
	public String MngProjectService(Model model) {

		return "mbr/application/env/projectEnv_list";
	}

	@RequestMapping(value="/envView")
	public String MngProjectServiceView(Model model, CustomOssProjectVO req) {
		model.addAttribute("req", req);
		return "mbr/application/env/projectEnv_view";
	}

	@RequestMapping(value="/")
	public String mbrAppEnvList() {
		return "mbr/application/env/prodEnv_List";
	}

	@RequestMapping(value = "/devAppIdChk")
	public ResponseEntity<Object> devAppIdChk(CustomReqProductVO req) {
		int chkPortVal = service.devAppIdChk(req);
		return new ResponseEntity<Object>(chkPortVal, HttpStatus.OK);
	}

	@RequestMapping(value = "/devUsersNameCheck", method = RequestMethod.POST)
	public ResponseEntity<Object> devUsersNameCheck(@RequestBody List<String> nameList) {

		CustomReqProductVO req = new CustomReqProductVO();
		req.setNameList(nameList);

		int chkNameVal = service.devUsersNameCheck(req);
		return new ResponseEntity<Object>(chkNameVal, HttpStatus.OK);
	}

	@RequestMapping(value = "/devUsersMailCheck", method = RequestMethod.POST)
	public ResponseEntity<Object> devUsersMailCheck(@RequestBody List<String> emailList) {
		CustomReqProductVO req = new CustomReqProductVO();

		// 암호화
		List<String> encEmailList = new ArrayList<String>();
		String encEmail = "";
		for(String email : emailList) {
			encEmail = req.getEnc(email);
			log.info("enEmail 확인 : {}", encEmail);
			encEmailList.add(encEmail);
		}
		req.setEmailList(encEmailList);

		int chkEmailVal = service.devUsersMailCheck(req);
		return new ResponseEntity<Object>(chkEmailVal, HttpStatus.OK);
	}

	@RequestMapping(value="/mbrDevCicdPipelineList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrDevCicdPipelineList(CustomReqProductVO req){
		String res = service.mbrDevCicdPipelineList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/mbrPrdCicdPipelineList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrPrdCicdPipelineList(CustomReqProductVO req){
		String res = service.mbrPrdCicdPipelineList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/projectEnvList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrUserOssProjectEnvList(CustomReqProductVO req){
		String res = service.projectEnvList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/envViewExcel")
	public ModelAndView MbrEnvViewExcel(CustomReqProductVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "envView");
		map.addAttribute("excel_title", "개발환경_상세");
		map.addAttribute("excel_list", service.envViewExcel(req));
		return new ModelAndView("productExcelView", map);
	}

	@RequestMapping(value = "/mbrEnvDetailInfo")
	public ResponseEntity<CustomReqProductVO> mbrEnvDetailInfo(CustomReqProductVO req) {
		CustomReqProductVO res = service.mbrEnvDetailInfo(req);
		return new ResponseEntity<CustomReqProductVO>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/mbrEnvUserList", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Object> mbrEnvUserList(CustomReqProductVO req) {

		String cicdProjectId= req.getCicdProjectId();
		List<CustomReqProductVO> res = service.mbrEnvUserList(cicdProjectId);

		for(CustomReqProductVO vo : res) {
			String decUserEmail = vo.getUserEmailDec();
			vo.setUserEmail(decUserEmail);
		}

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value="/mbrPrdList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MbrPrdList(CustomReqProductVO req){
		String res = service.mbrPrdList(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}



	@RequestMapping(value = "/reDeployDev")
	public ResponseEntity<Object> reDeployDev(CustomReqProductVO req) {

		SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();

		CustomOssCloudVO cloudVo = new CustomOssCloudVO();

		CustomReqProductVO res = service.detailBssOrderProductEnv(req);
		CustomReqProductVO projectUserInfo = service.cicdProjectUserInfo(req);
		CustomReqProductVO gourpProjectInfo = service.cicdGourpProjectInfo(req);

		String orderUserId = res.getOrderUserId();
		String orderProductSeq = res.getOrderProductSeq();


		// 개발 배포 처리
		try {

			GitlabObject tag = null;
			try {
				 tag = GitlabUtils.selectTag(systemCalculatorInfo, res.getCicdProjectId(), "stage." + res.getAppName());
			} catch (Exception e) {

			}

            if(tag !=null) {
            	GitlabUtils.deleteTag(systemCalculatorInfo, res.getCicdProjectId(), "stage." + res.getAppName());
            	// 삭제한 태그 정보 데이터베이스에서도 삭제
            	CustomReqProductVO deleteTagInfo = new CustomReqProductVO();
            	deleteTagInfo.setBranchTagId("stage." + res.getAppName());
            	deleteTagInfo.setCicdProjectId(res.getCicdProjectId());
            	//this.sqlSessionTemplate.delete(deleteCicdBranchTag, deleteTagInfo);
            }

			//새로운 스테이징 브랜치 태그 생성
			GitlabUtils.createTag(systemCalculatorInfo, res.getCicdProjectId(), "stage." + res.getAppName(), "staging",	"Batch Release version");

			// 생성된 태그 정보 데이터베이스에 삽입
			CustomReqProductVO insertTagInfo = new CustomReqProductVO();
			insertTagInfo.setBranchTagId("stage." + res.getAppName());
			insertTagInfo.setBranchName("staging");
			insertTagInfo.setCicdProjectId(res.getCicdProjectId());
			insertTagInfo.setProjectId(res.getProjectId());
			insertTagInfo.setAppName(res.getAppName());

			insertTagInfo.setName("stage." + res.getAppName());
			insertTagInfo.setRegUserId(orderUserId);
			insertTagInfo.setModUserId(orderUserId);
			//this.sqlSessionTemplate.insert(insertCicdBranchTag, insertTagInfo);


			// 3. 스테이징 파이프라인 트리거
			Map<String, String> variables = new HashMap<>();
			variables.put("DEPLOY_TARGET_NAME", "staging");
			variables.put("GL_USER_NAME", projectUserInfo.getName());
			variables.put("GL_PASSWORD", projectUserInfo.getPasswordDec());
			variables.put("OPENSHIFT_SERVER", "https://api.oaocp4.kepco.co.kr:6443");
			variables.put("OPENSHIFT_USERNAME", cloudVo.getAdminUsername());
			variables.put("OPENSHIFT_PASSWORD", cloudVo.getAdminPassword());
			variables.put("OPENSHIFT_TEMPLATE", "kepco-eap74-jdk11-basic-s2i");


			variables.put("SOURCE_REPOSITORY_URL", "https://gitlabsvr.kepco.co.kr/"+gourpProjectInfo.getCicdGroupPath()+"/"+gourpProjectInfo.getCicdProjectName()+".git");
			variables.put("CONTEXT_DIR", res.getDeploysDirectory());

			variables.put("ENV_PROJECT", res.getProjectName()+"-dev"); // 오픈 쉬프트 프로젝트 ID
			variables.put("ENV_APPLICATION_NAME", res.getAppName());
			variables.put("ENV_APPLICATION_VERSION", "v1");
			variables.put("ENV_NUMBER_OF_INSTANCES", "1");
			variables.put("ENV_URL_OF_APPLICATION", res.getDomainUrl());
			variables.put("ENV_SOURCE_REPOSITORY_URL", "https://gitlabsvr.kepco.co.kr/"+gourpProjectInfo.getCicdGroupPath()+"/"+gourpProjectInfo.getCicdProjectName()+".git");
			variables.put("ENV_SOURCE_REPOSITORY_REF", "staging");
			variables.put("ENV_CONTEXT_DIR",res.getDeploysDirectory());
			variables.put("ENV_CPU_LIMIT", Integer.toString(res.getCpuLimit()));
			variables.put("ENV_MEMORY_LIMIT", res.getMemLimit()+"Gi");


			GitlabObject pipeline = GitlabUtils.triggerPipeline(systemCalculatorInfo, res.getCicdProjectId(), "stage." + res.getAppName(), variables);
			String pipelineId = pipeline.getValue("id").toString();

			// 파이프라인 정보 데이터베이스에 저장
			CustomReqProductVO pipelineInfoVO = new CustomReqProductVO();
			pipelineInfoVO.setPipelineId(pipelineId);
			pipelineInfoVO.setCicdProjectId(res.getCicdProjectId());
			pipelineInfoVO.setProjectId(res.getProjectId());
			pipelineInfoVO.setRef("stage." + res.getAppName());
			pipelineInfoVO.setAppName(res.getAppName());
			pipelineInfoVO.setCicdRequestType("CICD_REQTYPE_NEW_DEPLOY");
			pipelineInfoVO.setSyncAppStatus("SYNC_APP_READY");
			pipelineInfoVO.setOrderProductSeq(orderProductSeq);

			pipelineInfoVO.setRegUserId(orderUserId);
			//this.sqlSessionTemplate.insert(insertCicdPipeline, pipelineInfoVO);

			int chkPortVal = 1;

		    return new ResponseEntity<Object>(chkPortVal, HttpStatus.OK);
		} catch (Exception e) {
			int chkPortVal = 0;
			return new ResponseEntity<Object>(chkPortVal, HttpStatus.OK);

		}
	}




	@RequestMapping(value = "/reDeployProd")
	public ResponseEntity<Object> reDeployProd(CustomReqProductVO req) {

		SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();

		CustomOssCloudVO cloudVo = new CustomOssCloudVO();
			try {
				CustomReqProductVO res = service.detailBssOrderProductEnv(req);
				CustomReqProductVO projectUserInfo = service.cicdProjectUserInfo(req);
				CustomReqProductVO gourpProjectInfo = service.cicdGourpProjectInfo(req);

				String orderUserId = res.getOrderUserId();
				String orderProductSeq = res.getOrderProductSeq();


				GitlabObject tag = null;
				try {
					 tag = GitlabUtils.selectTag(systemCalculatorInfo, res.getCicdProjectId(), "copy." + res.getAppName());
				} catch (Exception e) {

				}

		        if(tag !=null) {
		        	GitlabUtils.deleteTag(systemCalculatorInfo, res.getCicdProjectId(), "copy." + res.getAppName());
		        	// 삭제한 태그 정보 데이터베이스에서도 삭제
		        	CustomReqProductVO deleteTagInfo = new CustomReqProductVO();
		        	deleteTagInfo.setBranchTagId("copy." + res.getAppName());
		        	deleteTagInfo.setCicdProjectId(res.getCicdProjectId());
		        //	this.sqlSessionTemplate.delete(deleteCicdBranchTag, deleteTagInfo);
		        }

		        GitlabUtils.createTag(systemCalculatorInfo, res.getCicdProjectId(), "copy." + res.getAppName(), "main",	"Batch Release version");

		        // 스테이징 브랜치를 메인 브랜치로 복사 copy pipeline 수행
				Map<String, String> copyVariables = new HashMap<>();
				copyVariables.put("DEPLOY_TARGET_NAME", "copy");
				copyVariables.put("GL_USER_NAME", systemCalculatorInfo.getGitlabusername());
				copyVariables.put("GL_PASSWORD", systemCalculatorInfo.getGitlabpassword());
				copyVariables.put("GL_PAT", systemCalculatorInfo.getGitlabtoken());
				copyVariables.put("GL_GRPNAME", gourpProjectInfo.getCicdGroupPath());
				copyVariables.put("GL_REPONAME", gourpProjectInfo.getCicdProjectName());
				copyVariables.put("GL_SERVER", "gitlabsvr.kepco.co.kr");

				GitlabUtils.triggerPipeline(systemCalculatorInfo, res.getCicdProjectId(), "copy." + res.getAppName(), copyVariables);

				GitlabObject prodTag = null;
				try {
					prodTag = GitlabUtils.selectTag(systemCalculatorInfo, res.getCicdProjectId(), "prod." + res.getAppName());
				} catch (Exception e) {

				}

		        if(prodTag !=null) {
		        	GitlabUtils.deleteTag(systemCalculatorInfo, res.getCicdProjectId(), "prod." + res.getAppName());
		        	// 삭제한 태그 정보 데이터베이스에서도 삭제
		        	CustomReqProductVO deleteTagInfo = new CustomReqProductVO();
		        	deleteTagInfo.setBranchTagId("prod." + res.getAppName());
		        	deleteTagInfo.setCicdProjectId(res.getCicdProjectId());
		        	//this.sqlSessionTemplate.delete(deleteCicdBranchTag, deleteTagInfo);
		        }

		        GitlabUtils.createTag(systemCalculatorInfo, res.getCicdProjectId(), "prod." + res.getAppName(), "main",	"Batch Release version");


				// 생성된 태그 정보 데이터베이스에 삽입
				CustomReqProductVO insertTagInfo = new CustomReqProductVO();
				insertTagInfo.setBranchTagId("prod." + res.getAppName());
				insertTagInfo.setBranchName("main");
				insertTagInfo.setCicdProjectId(res.getCicdProjectId());
				insertTagInfo.setName("prod." + res.getAppName());
				insertTagInfo.setRegUserId(orderUserId);
				insertTagInfo.setModUserId(orderUserId);
				//this.sqlSessionTemplate.insert("insertCicdBranchTag", insertTagInfo);

				// 3. 스테이징 파이프라인 트리거
				Map<String, String> variables = new HashMap<>();
				variables.put("DEPLOY_TARGET_NAME", "production");

				variables.put("GL_USER_NAME", projectUserInfo.getName());
				variables.put("GL_PASSWORD", projectUserInfo.getPasswordDec());


				variables.put("OPENSHIFT_SERVER", "https://api.oaocp4.kepco.co.kr:6443");
				variables.put("OPENSHIFT_USERNAME", cloudVo.getAdminUsername());
				variables.put("OPENSHIFT_PASSWORD", cloudVo.getAdminPassword());
				variables.put("OPENSHIFT_TEMPLATE", res.getImageId());
				variables.put("SOURCE_REPOSITORY_URL", "https://gitlabsvr.kepco.co.kr/"+gourpProjectInfo.getCicdGroupPath()+"/"+gourpProjectInfo.getCicdProjectName()+".git");
				variables.put("CONTEXT_DIR", res.getDeploysDirectory());

				variables.put("ENV_PROJECT", res.getProjectName()+"-prod"); // 오픈 쉬프트 프로젝트 ID
				variables.put("ENV_APPLICATION_NAME", res.getAppName());
				variables.put("ENV_APPLICATION_VERSION", "v1");
				variables.put("ENV_NUMBER_OF_INSTANCES", "1");
				variables.put("ENV_URL_OF_APPLICATION", res.getDomainUrl());
				variables.put("ENV_SOURCE_REPOSITORY_URL", "https://gitlabsvr.kepco.co.kr/"+gourpProjectInfo.getCicdGroupPath()+"/"+gourpProjectInfo.getCicdProjectName()+".git");
				variables.put("ENV_SOURCE_REPOSITORY_REF", "main");
				variables.put("ENV_CONTEXT_DIR", res.getDeploysDirectory());
				variables.put("ENV_CPU_LIMIT", Integer.toString(res.getCpuLimit()));
				variables.put("ENV_MEMORY_LIMIT", res.getMemLimit()+"Gi");

				GitlabObject pipeline = GitlabUtils.triggerPipeline(systemCalculatorInfo, res.getCicdProjectId(), "prod." + res.getAppName(), variables);
				String pipelineId = pipeline.getValue("id").toString();

				// 파이프라인 정보 데이터베이스에 저장
				CustomReqProductVO pipelineInfoVO = new CustomReqProductVO();
				pipelineInfoVO.setPipelineId(pipelineId);
				pipelineInfoVO.setCicdProjectId(res.getCicdProjectId());
				pipelineInfoVO.setRef("prod." + res.getAppName());
				pipelineInfoVO.setAppName(res.getAppName());
				pipelineInfoVO.setCicdRequestType("CICD_REQTYPE_NEW_DEPLOY");
				pipelineInfoVO.setSyncAppStatus("SYNC_APP_READY");
				pipelineInfoVO.setRegUserId(orderUserId);
				pipelineInfoVO.setOrderProductSeq(orderProductSeq);


				//this.sqlSessionTemplate.insert("insertCicdPipeline", pipelineInfoVO);

				res.setOrderUserId(orderUserId);
				res.setErrorStatus("PROVISIONING_SUCCESS");

				int chkPortVal = 1;

			    return new ResponseEntity<Object>(chkPortVal, HttpStatus.OK);
			} catch (Exception e) {
				int chkPortVal = 0;
				return new ResponseEntity<Object>(chkPortVal, HttpStatus.OK);

			}

	}
}
