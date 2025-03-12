package com.ivucenter.cloud.portal.oss.vm;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.nutanix.NutanixObject;
import com.ivucenter.cloud.api.nutanix.NutanixPowerState;
import com.ivucenter.cloud.api.nutanix.NutanixUtils;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.ServerIF;
import com.ivucenter.cloud.api.openstack.interfaces.VolumeIF;
import com.ivucenter.cloud.api.openstack.object.Server;
import com.ivucenter.cloud.api.openstack.object.Volume;
import com.ivucenter.cloud.api.openstack.object.VolumeAttachment;
import com.ivucenter.cloud.api.openstack.object.VolumnAttached;
import com.ivucenter.cloud.api.vRealize.interfaces.vraAbstractFactory;
import com.ivucenter.cloud.api.vRealize.interfaces.vraServerIF;
import com.ivucenter.cloud.api.vRealize.object.vraContent;
import com.ivucenter.cloud.api.vRealize.object.vraDisks;
import com.ivucenter.cloud.api.vRealize.object.vraJsonObject;
import com.ivucenter.cloud.api.vRealize.object.vraServer;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.productUsageStatus.vm.CustomProductUsageStatusVmVO;
import com.ivucenter.cloud.portal.productUsageStatus.vm.ProductUsageStatusVmDAO;

import lombok.extern.slf4j.Slf4j;

/**
 *
 * @author 박진우
 *
 */
@Slf4j
@Service
public class OssVmService {

	private static final Logger logger = LoggerFactory.getLogger(OssVmService.class);

	@Autowired
	private OssVmDAO dao;

	@Autowired
	private ProductUsageStatusVmDAO productUsageStatusVmDAO;

	@Autowired
	private OssCloudService ossCloudService;

	final String[] aPower = { "NOSTATE", "RUNNING", "", "PAUSED", "SHUTDOWN", "", "CRASHED", "SUSPENDED" };

	public String list(CustomOssVmVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		Assert.notNull(req.getProjectName(), "");

		List<CustomOssVmVO> lists = dao.projectList(req);
		int recordsTotal = dao.projectListTot(req).size();
		int recordsFiltered = recordsTotal;

		List<CustomOssVmVO> list = new LinkedList<CustomOssVmVO>();
		String sError = "";

		try {
			// project server
			for (CustomOssVmVO vo : lists) {
				CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(vo.getCloudId());
				if (cloudVo.getCloudType().equals("openstack")) {
					ServerIF serverIF = AbstractFactory.getServerIF(req.getProjectName(), cloudVo);
					List<Server> serverlists = serverIF.getServers();

					for (Server obj : serverlists) {
						if (vo.getVmUuid().equals(obj.getId())) {
							for (String sKey : obj.getAddresses().keySet()) {
								if (sKey.equals("backup-net")) {
									vo.setBackUpIpAddr(obj.getAddresses().get(sKey).get(0).getAddr());
								} else {
									vo.setIpAddr(obj.getAddresses().get(sKey).get(0).getAddr());
								}

							}
							vo.setStatus(obj.getStatus());
							vo.setPower(aPower[obj.getOS_EXT_STS_power_state()]);
							break;
						}
					}
					list.add(vo);

				} else if (cloudVo.getCloudType().equals("vmware")) {
					vraServerIF serverIF = vraAbstractFactory.getServerIF(cloudVo);
					vraServer vraServer = new vraServer();
					vraServer = serverIF.getDepInfo(vo.getVmUuid());
					List<vraContent> contents = vraServer.getContent();
					for (vraContent content : contents) {
						if (content.getType().equals("Cloud.vSphere.Machine")) {
							vo.setStatus(content.getSyncStatus());
							vo.setPower(content.getProperties().getPowerState());
							// vo.setIpAddr(content.getProperties().getAddress());

							for (int i = 0; i < content.getProperties().getNetworks().size(); i++) {
								if (content.getProperties().getNetworks().get(i).getName().equals("OA-Backup")) {
									vo.setBackUpIpAddr(content.getProperties().getNetworks().get(i).getAddress());
								} else {
									vo.setIpAddr(content.getProperties().getNetworks().get(i).getAddress()); // 수정 필요 chlwjdgns
								}
							}
							list.add(vo);
						}
					}
				} else if (cloudVo.getCloudType().equals("openShift")) {
					list.add(vo);
				} else if (cloudVo.getCloudType().equals("nutanix")) {

					NutanixObject vmdetail = NutanixUtils.getVmDetail(cloudVo, vo.getVmUuid());

					String fixed_ips = (String) vmdetail.getArray("vm_nics", null).get(0).getValue("ip_address");

					JsonArray variables = vmdetail.getJson().getAsJsonArray("vm_nics").get(0).getAsJsonObject()
							.getAsJsonArray("ip_addresses");
					for (int i = 0; i < variables.size(); i++) {
						String temp_ip = variables.get(i).toString().replaceAll("\\\"", "");
						if (!fixed_ips.equals(temp_ip)) {
							fixed_ips = temp_ip;
							break;
						}
					}

					vo.setStatus((String) vmdetail.getValue("power_state"));
					vo.setPower("on");
					vo.setIpAddr(fixed_ips);

//					vo.setIpAddr(vo.getFixedIps().toString());

					list.add(vo);

				}
			}
		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
			log.error(e.getMessage());
			sError = e.getMessage();
		} catch (Exception e) {
			log.error(e.getMessage());
			sError = e.getMessage();
		}

		try {
			JsonObject jsonResponse = new JsonObject();
			Gson gson = new Gson();

			jsonResponse.addProperty("draw", req.getDraw());
			jsonResponse.addProperty("error", sError);
			jsonResponse.addProperty("recordsTotal", recordsTotal);
			jsonResponse.addProperty("recordsFiltered", recordsFiltered);
			CustomProductUsageStatusVmVO CustomProductUsageStatusVmVO = new CustomProductUsageStatusVmVO();
			jsonResponse.add("totalData", gson.toJsonTree(productUsageStatusVmDAO.total(CustomProductUsageStatusVmVO)));
			jsonResponse.add("data", gson.toJsonTree(list));
//	        log.debug(gson.toJsonTree(list).toString());
			return jsonResponse.toString();
		} catch (JsonIOException e) {
			log.error(e.getMessage());
		}
		return "";
	}

	public CustomOssVmVO detail(CustomOssVmVO req) {
		Assert.notNull(req.getCloudId(), "");
		Assert.notNull(req.getProjectName(), "");
		Assert.notNull(req.getVmUuid(), "");

		CustomOssVmVO res = dao.detail(req);

		ArrayList<String> array = new ArrayList<String>();

		try {
			// project server
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
			res.setCloudName(cloudVo.getCloudName());
			if (cloudVo.getCloudType().equals("openstack")) {
				ServerIF serverIF = AbstractFactory.getServerIF(req.getProjectName(), cloudVo);
				Server server = serverIF.getServer(req.getVmUuid());

				int listSize = server.getAddresses().keySet().size();
				int cnt = 0;
				for (String sKey : server.getAddresses().keySet()) {
					cnt++;
					if (res.getIpAddr() == null) {
						if (cnt == listSize && res.getIpAddr() == null) {
							res.setIpAddr(server.getAddresses().get(sKey).get(0).getAddr());
						} else if (cnt != listSize && res.getIpAddr() == null && sKey.lastIndexOf("_mgt_net") > 0) {
							res.setIpAddr(server.getAddresses().get(sKey).get(0).getAddr());
						} else {
							array.add(server.getAddresses().get(sKey).get(0).getAddr());
						}
					} else {
						array.add(server.getAddresses().get(sKey).get(0).getAddr());
					}
				}

				int size = 0;
				VolumeIF volumeIF = AbstractFactory.getVolumeIF(req.getProjectName(), cloudVo);
				List<VolumnAttached> attachList = server.getOs_extended_volumes_volumes_attached();
				for (int i = 0; i < attachList.size(); i++) {
					Volume obj = volumeIF.getVolume(attachList.get(i).getId());

					for (VolumeAttachment attach : obj.getAttachments()) {
						if (req.getVmUuid().equals(attach.getServer_id())) {
							size = size + obj.getSize();
						}
					}
				}

				res.setBlockSize(size);
				res.setAddrList(array);
				res.setStatus(server.getStatus());
				res.setPower(aPower[server.getOS_EXT_STS_power_state()]);
			} else if (cloudVo.getCloudType().equals("vmware")) {
				vraServerIF serverIF = vraAbstractFactory.getServerIF(cloudVo);
				vraServer vraServer = new vraServer();

				vraServer = serverIF.getDepInfo(req.getVmUuid());
				List<vraContent> contents = vraServer.getContent();
				for (vraContent content : contents) {
					if (content.getType().equals("Cloud.vSphere.Machine")) {
						long size = 0;
						List<vraDisks> disks = content.getProperties().getStorage().getDisks();
						for (vraDisks disk : disks) {
							size += Long.parseLong(disk.getCapacityGb());
						}
						res.setIpAddr(content.getProperties().getNetworks().get(0).getAddress());
						res.setCloudName(cloudVo.getCloudName());
						res.setBlockSize((int) size);
						res.setStatus(content.getProperties().getPowerState());
					}
				}
			} else if (cloudVo.getCloudType().equals("nutanix")) {

				NutanixObject vmdetail;
				try {
					vmdetail = NutanixUtils.getVmDetail(cloudVo, res.getVmUuid());
					res.setIpAddr((String) vmdetail.getArray("vm_nics", null).get(0).getValue("ip_address"));
					res.setCloudName(cloudVo.getCloudName());
					res.setBlockSize(0);
					res.setPower("on");
					res.setStatus((String) vmdetail.getValue("power_state"));

				} catch (Exception e) {
					logger.error("getVmDetail Exception");
				}

			}

			return res;

		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
			log.error(e.getMessage());
			res.setError(e.getMessage());
		}

		return res;
	}

	public String update(CustomOssVmVO req) {
		return dao.update(req) + "";
	}

	public String vmHistoryInsert(CustomOssVmVO req) {
		return dao.vmHistoryInsert(req) + "";
	}

	public List<CustomOssVmVO> vmListProjectUser(CustomOssVmVO req) {
		return dao.vmListProjectUser(req);
	}

	public CustomOssVmVO vmDetailByHostname(CustomOssVmVO req) {
		return dao.vmDetailByHostaname(req);
	}

	public CustomOssVmVO detailSum(CustomOssVmVO req) {
		return dao.detailSum(req);
	}

	public String action(CustomOssVmVO req) throws Exception {
		Assert.notNull(req.getCloudId(), "");
		Assert.notNull(req.getProjectName(), "");
		Assert.notNull(req.getVmUuid(), "");
		Assert.notNull(req.getAction(), "");
		String sError = "";

		try {
			// project server
			CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(req.getCloudId());
			if (cloudVo.getCloudType().equals("openstack")) {
				ServerIF serverIF = AbstractFactory.getServerIF(req.getProjectName(), cloudVo);
				serverIF.actionServer(req.getVmUuid(), req.getAction());
				return "1";
			} else if (cloudVo.getCloudType().equals("vmware")) {
				vraServerIF serverIF = vraAbstractFactory.getServerIF(cloudVo);
				vraServer depInfo = serverIF.getDepInfo(req.getVmUuid());
				List<vraContent> contents = depInfo.getContent();
				for (vraContent content : contents) {
					if (content.getType().equals("Cloud.vSphere.Machine")) {
						vraJsonObject vraJsonObject = serverIF.actionServer(content.getId(), req.getAction());
						return "1";
						/*
						 * vraJsonObject Tracker = serverIF.tracker(vraJsonObject.getId());
						 * while(!Tracker.getStatus().equals("FINISHED")) { Tracker =
						 * serverIF.tracker(vraJsonObject.getId()); }
						 * if(Tracker.getMessage().equals("success")) { return "1"; } else { return
						 * Tracker.getMessage(); }
						 */
					}
				}
			} else if (cloudVo.getCloudType().equals("nutanix")) {

				if (req.getAction().equals("start")) {
					NutanixUtils.updateVmPowerState(cloudVo, req.getVmUuid(), req.getHostUuid(), NutanixPowerState.ON);
				} else if (req.getAction().equals("stop")) {
					NutanixUtils.updateVmPowerState(cloudVo, req.getVmUuid(), req.getHostUuid(), NutanixPowerState.OFF);
				} else if (req.getAction().equals("reboot")) {
					NutanixUtils.updateVmPowerState(cloudVo, req.getVmUuid(), req.getHostUuid(),
							NutanixPowerState.RESET);
				}
				return "1";
			}

		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
			log.error(e.getMessage());
			sError = e.getMessage();
		}
		return sError;
	}

	public String catalogueVmlist(CustomOssVmVO req) {
		Assert.notNull(req.getProjectId(), "");
		Assert.notNull(req.getProjectBoxId(), "");
		List<CustomOssVmVO> lists = dao.list(req);
		int recordsTotal = dao.listTot(req).size();

		int recordsFiltered = recordsTotal;
		String sError = "";
		try {
			JsonObject jsonResponse = new JsonObject();
			Gson gson = new Gson();

			jsonResponse.addProperty("draw", req.getDraw());
			jsonResponse.addProperty("error", sError);
			jsonResponse.addProperty("recordsTotal", recordsTotal);
			jsonResponse.addProperty("recordsFiltered", recordsFiltered);
			jsonResponse.add("data", gson.toJsonTree(lists));

			return jsonResponse.toString();
		} catch (JsonIOException e) {
			log.error(e.getMessage());
		}
		return "";
	}

	public String catalogueNutanixVmlist(CustomOssVmVO req) {
		Assert.notNull(req.getProjectBoxId(), "");
		List<CustomOssVmVO> lists = dao.nutanixList(req);
		int recordsTotal = dao.nutanixListTot(req).size();

		int recordsFiltered = recordsTotal;
		String sError = "";
		try {
			JsonObject jsonResponse = new JsonObject();
			Gson gson = new Gson();

			jsonResponse.addProperty("draw", req.getDraw());
			jsonResponse.addProperty("error", sError);
			jsonResponse.addProperty("recordsTotal", recordsTotal);
			jsonResponse.addProperty("recordsFiltered", recordsFiltered);
			jsonResponse.add("data", gson.toJsonTree(lists));

			return jsonResponse.toString();
		} catch (JsonIOException e) {
			log.error(e.getMessage());
		}
		return "";
	}

	public List<CustomOssVmVO> excel(CustomOssVmVO req) {
		Assert.notNull(req.getProjectId(), "");
		Assert.notNull(req.getProjectName(), "");

		List<CustomOssVmVO> lists = dao.projectList(req);
		int recordsTotal = dao.projectListTot(req).size();
		int recordsFiltered = recordsTotal;

		List<CustomOssVmVO> list = new LinkedList<CustomOssVmVO>();
		String sError = "";

		try {
			// project server
			for (CustomOssVmVO vo : lists) {
				CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(vo.getCloudId());
				if (cloudVo.getCloudType().equals("openstack")) {
					ServerIF serverIF = AbstractFactory.getServerIF(req.getProjectName(), cloudVo);
					List<Server> serverlists = serverIF.getServers();

					for (Server obj : serverlists) {
						if (vo.getVmUuid().equals(obj.getId())) {
							for (String sKey : obj.getAddresses().keySet()) {
								if (sKey.equals("backup-net")) {
									vo.setBackUpIpAddr(obj.getAddresses().get(sKey).get(0).getAddr());
								} else {
									vo.setIpAddr(obj.getAddresses().get(sKey).get(0).getAddr());
								}

							}
							vo.setStatus(obj.getStatus());
							vo.setPower(aPower[obj.getOS_EXT_STS_power_state()]);
							break;
						}
					}
					list.add(vo);

				} else if (cloudVo.getCloudType().equals("vmware")) {
					vraServerIF serverIF = vraAbstractFactory.getServerIF(cloudVo);
					vraServer vraServer = new vraServer();
					vraServer = serverIF.getDepInfo(vo.getVmUuid());
					List<vraContent> contents = vraServer.getContent();
					for (vraContent content : contents) {
						if (content.getType().equals("Cloud.vSphere.Machine")) {
							vo.setStatus(content.getSyncStatus());
							vo.setPower(content.getProperties().getPowerState());
							vo.setIpAddr(content.getProperties().getAddress());
							list.add(vo);
						}
					}
				}
			}
		} catch (NotConnectGatewayException | NotSupportGatewayException | InvaildOpenStackException e) {
			log.error(e.getMessage());
			sError = e.getMessage();
		} catch (Exception e) {
			log.error(e.getMessage());
			sError = e.getMessage();
		}
		return list;
	}
}
