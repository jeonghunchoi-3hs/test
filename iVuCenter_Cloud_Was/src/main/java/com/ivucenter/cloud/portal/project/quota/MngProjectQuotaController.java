package com.ivucenter.cloud.portal.project.quota;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.api.common.batch.BatchProcessor;
import com.ivucenter.cloud.api.openstack.OpenStackUsage;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.object.OpenStackComplexQuota;
import com.ivucenter.cloud.entity.OssAvailabilityVO;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.oss.project.CustomOssProjectVO;
import com.ivucenter.cloud.portal.oss.project.OssProjectService;

@Controller
@RequestMapping(value="/mng/project/quota")
public class MngProjectQuotaController {

    private static final Logger logger = LoggerFactory.getLogger(MngProjectQuotaController.class);

	@Autowired
	private ProjectQuotaService service;

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	private OssProjectService projectService;
	/**
	 *	PAGE
	 */
	@RequestMapping(value="/")
	public String MngProjectQuota(Model model) {
		return "mng/project/quota/projectQuota_list";
	}

	@RequestMapping(value="/cloudView")
	public String MngProjectQuotaCloudView(Model model, CustomQuotaVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		Assert.notNull(req.getProjectName(), "");
		Assert.notNull(req.getReqProjectSeq(), "");
		CustomOssProjectVO project = new CustomOssProjectVO();
		project.setProjectBoxId(req.getProjectBoxId());
		CustomOssProjectVO res = projectService.boxDetail(project);

		res.setManagerPhone(res.getManagerPhoneDec());
		res.setManagerTel(res.getManagerTelDec());

		model.addAttribute("req", req);
		model.addAttribute("detail",res);
		return "mng/project/quota/projectQuota_cloud_view";
	}

	@RequestMapping(value="/view")
	public String MngProjectQuotaView(Model model, CustomQuotaVO req) {
		Assert.notNull(req.getProjectId(), "");
		Assert.notNull(req.getProjectName(), "");
		Assert.notNull(req.getReqProjectSeq(), "");
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
		model.addAttribute("cloud",cloudVo);
		model.addAttribute("req", req);
		return "mng/project/quota/projectQuota_view";
	}

	@RequestMapping(value="/viewPass")
	public String MngProjectQuotaViewPass(Model model, CustomQuotaVO req) {
		Assert.notNull(req.getProjectId(), "");
		Assert.notNull(req.getProjectName(), "");
		Assert.notNull(req.getReqProjectSeq(), "");
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
		model.addAttribute("cloud",cloudVo);
		model.addAttribute("req", req);
		return "mng/project/quota/projectQuota_view_pass";
	}


	@RequestMapping(value="/write")
	public String MngProjectQuotaWrite(Model model, CustomQuotaVO req) {
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
		model.addAttribute("cloud",cloudVo);
		model.addAttribute("req", req);
		return "mng/project/quota/projectQuota_write";
	}

	@RequestMapping(value="/writePass")
	public String MngProjectQuotaWritePass(Model model, CustomQuotaVO req) {
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
		model.addAttribute("cloud",cloudVo);
		model.addAttribute("req", req);
		return "mng/project/quota/projectQuota_write_pass";
	}

	/**
	 * action
	 */
	@RequestMapping(value = "/detail")
	public ResponseEntity<Object> MngProjectQuotaDetail(CustomQuotaVO req) {

		OpenStackComplexQuota res = service.detail(req);
		CustomQuotaVO vo = service.getDetaildb(req);
		HashMap<String, Object> map = new HashMap<>();
		map.put("data", res);
		map.put("detail", vo);
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(map, HttpStatus.OK);

	}
	@RequestMapping(value = "/cloudDetail",produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngProjectQuotaCloudDetail(CustomQuotaVO req) {

		String res = service.cloudDetail(req);

		return new ResponseEntity<Object>(res, HttpStatus.OK);

	}
	@RequestMapping(value = "/update")
	public ResponseEntity<OpenStackComplexQuota> MngProjectQuotaDiskUpdate(OpenStackComplexQuota req) {


		OpenStackComplexQuota res = service.update(req);
		return new ResponseEntity<OpenStackComplexQuota>(res, HttpStatus.OK);
	}
	@RequestMapping(value = "/updatePass")
	public ResponseEntity<OpenStackComplexQuota> MngProjectQuotaDiskUpdatePass(OpenStackComplexQuota req) {
		OpenStackComplexQuota res = service.update(req);

		return new ResponseEntity<OpenStackComplexQuota>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/list" , produces="application/text; charset=utf8")
	public ResponseEntity<Object> MngProjectQuotaList(CustomQuotaVO req) {

		 String res = service.list(req);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/mngProjectQuotaListExcel")
	public ModelAndView mngProjectQuotaListExcel(CustomQuotaVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "mngProjectQuotaListExcel");
		map.addAttribute("excel_title", "자원배분 정책");
		map.addAttribute("excel_list", service.excel(req));

		return new ModelAndView("ossProjectExcelView", map);
	}

	@RequestMapping(value = "/getQuota")
	public ResponseEntity<Object> MngProjectQuotaGetQuota(CustomQuotaVO req){

		CustomQuotaVO res = service.getQuota(req);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


	/**
	 *  동기화
	 */
	@RequestMapping(value = "/QuotaSynchronize")
	public ResponseEntity<String> QuotaSynchronize(CustomQuotaVO req) {
		String res = "";

		try {
			List<CustomOssCloudVO> cloudVo = ossCloudService.getCloudList();
			for(CustomOssCloudVO cloud : cloudVo) {
				if(cloud.getCloudType().equals("openstack")) {
					List<OpenStackUsage> openStackUsage = new ArrayList<>();
					openStackUsage = BatchProcessor.getCloudUsage(cloud);
					if (openStackUsage.size() > 0) {
						res = service.batchDeleteOssAvailability(cloud);

						for (OpenStackUsage item : openStackUsage) {
				        	OssAvailabilityVO availVO = new OssAvailabilityVO();

				        	availVO.setProjectId(item.getProjectId());

				        	availVO.setCloudId(cloud.getCloudId());
				        	availVO.setVmTotal(item.getVmTotal());
				        	availVO.setVmUsed(item.getVmUsed());
				        	availVO.setVmAvail(item.getVmAvail());

				        	availVO.setVCpuTotal(item.getVCpuTotal());
				        	availVO.setVCpuUsed(item.getVCpuUsed());
				        	availVO.setVCpuAvail(item.getVCpuAvail());

				        	availVO.setMemTotal(item.getMemTotal());
				        	availVO.setMemUsed(item.getMemUsed());
				        	availVO.setMemAvail(item.getMemAvail());

				        	availVO.setDiskTotal(item.getDiskTotal());
				        	availVO.setDiskUsed(item.getDiskUsed());
				        	availVO.setDiskAvail(item.getDiskAvail());

				        	availVO.setCollDatetime(new java.util.Date());

				        	res = service.batchInsertOssAvailability(availVO);
				        }
					}
				} else if(cloud.getCloudType().equals("vmware")) {
					List<OpenStackUsage> openStackUsage = new ArrayList<>();
					openStackUsage = BatchProcessor.vraGetCloudUsage(cloud);

					if (openStackUsage.size() > 0) {
						res = service.batchDeleteOssAvailability(cloud);

						for (OpenStackUsage item : openStackUsage) {
				        	OssAvailabilityVO availVO = new OssAvailabilityVO();

				        	availVO.setProjectId(item.getProjectId());

				        	availVO.setCloudId(cloud.getCloudId());
				        	availVO.setVmTotal(item.getVmTotal());
				        	availVO.setVmUsed(item.getVmUsed());
				        	availVO.setVmAvail(item.getVmAvail());

				        	availVO.setVCpuTotal(item.getVCpuTotal());
				        	availVO.setVCpuUsed(item.getVCpuUsed());
				        	availVO.setVCpuAvail(item.getVCpuAvail());

				        	availVO.setMemTotal(item.getMemTotal());
				        	availVO.setMemUsed(item.getMemUsed());
				        	availVO.setMemAvail(item.getMemAvail());

				        	availVO.setDiskTotal(item.getDiskTotal());
				        	availVO.setDiskUsed(item.getDiskUsed());
				        	availVO.setDiskAvail(item.getDiskAvail());

				        	availVO.setCollDatetime(new java.util.Date());

				        	res = service.batchInsertOssAvailability(availVO);
				        }
					}
				} else if(cloud.getCloudType().equals("nutanix")) {
					List<OpenStackUsage> openStackUsage = new ArrayList<>();
					openStackUsage = service.openshftOssNutanixAvailability(cloud);

					if (openStackUsage.size() > 0) {
						res = service.batchDeleteOssAvailability(cloud);

						for (OpenStackUsage item : openStackUsage) {
				        	OssAvailabilityVO availVO = new OssAvailabilityVO();

				        	availVO.setProjectId(item.getProjectId());

				        	availVO.setCloudId(cloud.getCloudId());
				        	availVO.setVmTotal(item.getVmTotal());
				        	availVO.setVmUsed(item.getVmUsed());
				        	availVO.setVmAvail(item.getVmAvail());

				        	availVO.setVCpuTotal(item.getVCpuTotal());
				        	availVO.setVCpuUsed(item.getVCpuUsed());
				        	availVO.setVCpuAvail(item.getVCpuAvail());

				        	availVO.setMemTotal(item.getMemTotal());
				        	availVO.setMemUsed(item.getMemUsed());
				        	availVO.setMemAvail(item.getMemAvail());

				        	availVO.setDiskTotal(item.getDiskTotal());
				        	availVO.setDiskUsed(item.getDiskUsed());
				        	availVO.setDiskAvail(item.getDiskAvail());

				        	availVO.setCollDatetime(new java.util.Date());

				        	res = service.batchInsertOssAvailability(availVO);
				        }
					}
				}else if(cloud.getCloudType().equals("openshift")) {
					List<OpenStackUsage> openStackUsage = new ArrayList<>();
					openStackUsage = service.openshftOssOpenshiftAvailability(cloud);

					if (openStackUsage.size() > 0) {
						res = service.batchDeleteOssAvailability(cloud);

						for (OpenStackUsage item : openStackUsage) {
				        	OssAvailabilityVO availVO = new OssAvailabilityVO();

				        	availVO.setProjectId(item.getProjectId());

				        	availVO.setCloudId(cloud.getCloudId());
				        	availVO.setVmTotal(item.getVmTotal());
				        	availVO.setVmUsed(item.getVmUsed());
				        	availVO.setVmAvail(item.getVmAvail());

				        	availVO.setVCpuTotal(item.getVCpuTotal());
				        	availVO.setVCpuUsed(item.getVCpuUsed());
				        	availVO.setVCpuAvail(item.getVCpuAvail());

				        	availVO.setMemTotal(item.getMemTotal());
				        	availVO.setMemUsed(item.getMemUsed());
				        	availVO.setMemAvail(item.getMemAvail());

				        	availVO.setDiskTotal(item.getDiskTotal());
				        	availVO.setDiskUsed(item.getDiskUsed());
				        	availVO.setDiskAvail(item.getDiskAvail());

				        	availVO.setCollDatetime(new java.util.Date());

				        	res = service.batchInsertOssAvailability(availVO);
				        }
					}
				}

			}
		} catch (NotConnectGatewayException e) {
			logger.error("NotConnectGatewayException");
		} catch (NotSupportGatewayException e) {
			logger.error("NotSupportGatewayException");
		} catch (InvaildOpenStackException e) {
			logger.error("InvaildOpenStackException");
		}

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}




}
