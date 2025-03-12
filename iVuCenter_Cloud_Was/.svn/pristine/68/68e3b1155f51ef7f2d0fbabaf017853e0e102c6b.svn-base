package com.ivucenter.cloud.portal.oss.network;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

/**
 * @author 박진우
 * 참고사항 openSteak 네트워크 중 Shared(공유) 항목은
 * admin 권한의 계정으로 접근한 경우에만 제어가 됨.
 * admin 권한으로 제어를 하게 되면 project에 속한게 아니게 되므로 기능을 제한 처리함.
 */
@Service
public class OssNetworkService{

    private static final Logger logger = LoggerFactory.getLogger(OssNetworkService.class);

	@Autowired
	OssNetworkDAO dao;

	/**
	 * 네트워크를 OSS_NETWORK DB기준으로 목록조회
	 * @param req
	 * @return
	 */
	public String list(CustomOssNetworkVO req) {

		List<CustomOssNetworkVO> listDB = dao.list(req);
		int recordsTotal = dao.listTot(req).size();
		int recordsFiltered = recordsTotal;
		String sError = "";

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(listDB));
	        jsonResponse.addProperty("error", sError);

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
            logger.error("JSON 처리 중 오류 발생");
	    }
		return "";
	}


	public Object excel(CustomOssNetworkVO req) {
		return dao.listTot(req);
	}
	public Object detailExcel(CustomOssNetworkVO req) {
		return dao.portListTot(req);
	}


	/**
	 * @param req
	 * @return
	 */
	public String portList(CustomOssNetworkVO req) {

		List<CustomOssNetworkVO> listDB = dao.portList(req);
		int recordsTotal = dao.portListTot(req).size();
		int recordsFiltered = recordsTotal;
		String sError = "";

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(listDB));
	        jsonResponse.addProperty("error", sError);

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	logger.error("JSON 처리 중 오류 발생");
	    }
		return "";
	}



	public CustomOssNetworkVO detail(CustomOssNetworkVO req) {
		return dao.detail(req);
	}

	public String update(CustomOssNetworkVO req) {
		return dao.update(req)+"";
	}
	public String networkAliasUpdate(CustomOssNetworkVO req) {
		return dao.networkAliasUpdate(req)+"";
	}

	public String virtualIpsUpdate(CustomOssNetworkVO req) {
		return dao.virtualIpsUpdate(req)+"";
	}

	public List<CustomOssNetworkVO> getPortList(CustomOssNetworkVO req) {
		return dao.getPortList(req) ;
	}


//	public CustomOssNetworkVO info(CustomOssNetworkVO req) {
//		CustomOssNetworkVO res  = dao.getNetworkInfo(req);
//		NetworkIF networkIF = AbstractFactory.getNetworkIF(req.getProjectName());
//
//		try {
//			List<Network> lists = networkIF.getNetworks();
//			for (Network network : lists){
//				log.debug(">>>>>>"+network.getId());
//				log.debug(">>>>>>"+res.getNetworkId());
//				if(network.getId().equals(res.getNetworkId())){
//					res.setShared(network.getShared());
//					res.setRouterExternal(network.getRouter_external());
//					res.setStatus(network.getStatus());
//					res.setAdminStateUp(network.getAdmin_state_up());
//				}
//			}
//		} catch (NotConnectGatewayException e) {
//
//		} catch (NotSupportGatewayException e) {
//
//		} catch (InvaildOpenStackException e) {
//
//	    }
//		return res;
//	}
//


	/**
	 * 네트워크 목록을 오픈스택 기준으로 목록조회
	 * @param req
	 * @return
	 */
//	public String listByOpenSteak(CustomOssNetworkVO req) {
//
//		int recordsTotal = 0;
//		int recordsFiltered = 0;
//		List<CustomOssNetworkVO> list = new LinkedList<CustomOssNetworkVO>();
//		String sError = "";
//
//		try {
//			NetworkIF networkIF = AbstractFactory.getNetworkIF(req.getProjectName());
//			// network list
////			ID : network.getId()
////			이름 : network.getName()
////			관련 서브넷 : network.getSubnets()
////			공유 : network.getShared()
////			외부 : network.getRouter_external
////			상태 : network.getStatus()
////			관리자 상태 : network.getAdmin_state_up()
//
//			List<Network> lists = networkIF.getNetworks();
//
//			for (Network network : lists){
//				CustomOssNetworkVO vo = mappingNetwork(network);
//
//				SubnetIF subnetIF = AbstractFactory.getSubnetIF(req.getProjectName());
//				List<Subnet> subnets = subnetIF.getSubnets(vo.getNetworkId());
//
//				List<String> subnetList = new ArrayList<String>();
//				for (Subnet subnet : subnets) {
//					subnetList.add("<b>"+subnet.getName()+"</b>  "+subnet.getCidr());
//				}
//				vo.setSubnets(subnetList);
//
//				// list search
//				if(
//					((network.getShared() == false) && (network.getRouter_external() == false))
//					&&
//					(
//						(req.getSearchKind() == null)
//						|| (req.getSearchKind().equals("subnet_name")
//							&& network.getName().toLowerCase().contains(req.getKeyword().toLowerCase()))
//						|| (req.getSearchKind().equals("subnet_alias")
//							&& vo.getNetworkAlias().toLowerCase().contains(req.getKeyword().toLowerCase()))
//						||(req.getSearchKind().equals(""))
//					)
//				){
//					list.add(vo);
//		        }
//			}
//
//			recordsTotal = list.size();
//			recordsFiltered = recordsTotal;
//
//		} catch (NotConnectGatewayException e) {
//			sError = e.getMessage();
//		} catch (NotSupportGatewayException e) {
//			sError = e.getMessage();
//		} catch (InvaildOpenStackException e) {
//			sError = e.getMessage();
//	    }
//
//	    try {
//	        JsonObject jsonResponse = new JsonObject();
//	        Gson gson = new Gson();
//
//	        jsonResponse.addProperty("draw", req.getDraw());
//	        jsonResponse.addProperty("recordsTotal", recordsTotal);
//	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
//	        jsonResponse.add("data", gson.toJsonTree(list));
//	        jsonResponse.addProperty("error", sError);
//
//	        return jsonResponse.toString();
//	    } catch (JsonIOException e) {
//	    }
//		return "";
//	}

	/**
	 * 서브 네트워크 목록을 오픈스택 기준으로 목록조회
	 * @param req
	 * @return
	 */
//	public String subnetListByOpenSteak(CustomOssNetworkVO req) {
//
//		int recordsTotal = 0;
//		int recordsFiltered = 0;
//		//List<CustomOssSubNetworkVO> list = new LinkedList<CustomOssSubNetworkVO>();
//		String sError = "";
//		List<Subnet> subnets = new LinkedList<Subnet>();
//		try {
//			//NetworkIF networkIF = AbstractFactory.getNetworkIF(req.getProjectName());
//			// network list
////			ID : network.getId()
////			이름 : network.getName()
////			관련 서브넷 : network.getSubnets()
////			공유 : network.getShared()
////			외부 : network.getRouter_external
////			상태 : network.getStatus()
////			관리자 상태 : network.getAdmin_state_up()
//
//			//List<Network> lists = networkIF.getNetworks();
//
//			//for (Network network : lists){
//				//CustomOssNetworkVO vo = mappingNetwork(network);
//
//				SubnetIF subnetIF = AbstractFactory.getSubnetIF(req.getProjectName());
//			    subnets = subnetIF.getSubnets(req.getNetworkId());
//
//				//List<String> subnetList = new ArrayList<String>();
//				/*for (Subnet subnet : subnets) {
//					subnetList.add("<b>"+subnet.getName()+"</b>  "+subnet.getCidr());
//				}
//				vo.setSubnets(subnetList);
//
//				// list search
//				if(
//					((network.getShared() == false) && (network.getRouter_external() == false))
//					&&
//					(
//						(req.getSearchKind() == null)
//						|| (req.getSearchKind().equals("subnet_name")
//							&& network.getName().toLowerCase().contains(req.getKeyword().toLowerCase()))
//						|| (req.getSearchKind().equals("subnet_alias")
//							&& vo.getNetworkAlias().toLowerCase().contains(req.getKeyword().toLowerCase()))
//						||(req.getSearchKind().equals(""))
//					)
//				){
//					list.add(vo);
//		        }*/
//			//}
//
//			recordsTotal = subnets.size();
//			recordsFiltered = recordsTotal;
//
//		} catch (NotConnectGatewayException e) {
//			logger.error("NotConnectGatewayException");
//			sError = e.getMessage();
//		} catch (NotSupportGatewayException e) {
//			logger.error("NotSupportGatewayException");
//			sError = e.getMessage();
//		} catch (InvaildOpenStackException e) {
//			logger.error("InvaildOpenStackException");
//			sError = e.getMessage();
//	    }
//
//	    try {
//	        JsonObject jsonResponse = new JsonObject();
//	        Gson gson = new Gson();
//
//	        jsonResponse.addProperty("draw", req.getDraw());
//	        jsonResponse.addProperty("recordsTotal", recordsTotal);
//	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
//	        jsonResponse.add("data", gson.toJsonTree(subnets));
//	        jsonResponse.addProperty("error", sError);
//
//	        return jsonResponse.toString();
//	    } catch (JsonIOException e) {
//	        logger.error("JSON 처리 중 오류 발생");
//	    }
//		return "";
//	}

//	public List<CustomOssSubnetVO> getRuleList(CustomOssNetworkVO req){
//		return dao.ruleNetList(req);
//
//	}
//
//	public Network actInsert(CustomOssNetworkVO req) throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException{
//		NetworkIF networkIF = AbstractFactory.getNetworkIF(req.getProjectName());
//
//		// network create
//		Network new_network = new Network();
//		new_network.setName(req.getNetworkName().toLowerCase());
//		new_network.setAdmin_state_up(req.getAdminStateUp());  // 관리자상태
//		new_network.setProject_id(req.getProjectId());
//		new_network.setTenant_id(req.getProjectId());
////		new_network.setShared(req.getShared());
//		return networkIF.createNetwork(new_network);
//	}


//	public String insert(CustomOssNetworkVO req) {
//		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
//		req.setRegUserId(userId);
//
//		String sError = "";
//
//		if(dao.detailByNetworkName(req) !=null){
//			JsonObject jsonResponse = new JsonObject();
//	        jsonResponse.addProperty("message", "이미 등록된 네트워크명입니다.<br>다른 네트워크명으로 등록해주십시오.");
//	        return jsonResponse.toString();
//		}
//
//		try {
//			Network obj1 = actInsert(req);
//			JsonObject jsonResponse = new JsonObject();
//	        jsonResponse.addProperty("networkId", obj1.getId());
//			req.setNetworkId(obj1.getId());
//			req.setNetworkName(obj1.getName());
//			sError = dao.insert(req)+"";
//
//
//	        jsonResponse.addProperty("success", sError);
//	        return jsonResponse.toString();
//
//		} catch (NotConnectGatewayException e) {
//			logger.error("NotConnectGatewayException");
//			sError = e.getMessage();
//		} catch (NotSupportGatewayException e) {
//			logger.error("NotSupportGatewayException");
//			sError = e.getMessage();
//		} catch (InvaildOpenStackException e) {
//			logger.error("InvaildOpenStackException");
//			sError = e.getMessage();
//		}
//
//	    try {
//	        JsonObject jsonResponse = new JsonObject();
//	        jsonResponse.addProperty("error", sError);
//	        return jsonResponse.toString();
//	    } catch (JsonIOException e) {
//	        logger.error("JSON 처리 중 오류 발생");
//	    }
//		return "";
//	}




//	public CustomOssNetworkVO mappingNetwork (Network network){
//
//		CustomOssNetworkVO vo = new CustomOssNetworkVO();
//		vo.setNetworkAlias(dao.getNetworkAlias(network.getId()));
//		vo.setNetworkId(network.getId());
//		vo.setNetworkName(network.getName());
//		vo.setShared(network.getShared());
//		vo.setRouterExternal(network.getRouter_external());
//		vo.setStatus(network.getStatus());
//		vo.setAdminStateUp(network.getAdmin_state_up());
//
//		return vo;
//	}
//
//	public String update(CustomOssNetworkVO req) {
//
//		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
//		req.setModUserId(userId);
//
//		int iRet = 0;
//		if(dao.detail(req) != null){
//			iRet = updateOssNetwork(req);
//		}else{
//			iRet = dao.insert(req);
//		}
//
//		if(iRet > 0){
//			return updateNetworkIF(req);
//		}else{
//			return iRet+"";
//		}
//	}
//
//	public int updateOssNetwork(CustomOssNetworkVO req) {
//		return dao.update(req);
//	}
//
//	public String updateNetworkIF(CustomOssNetworkVO req) {
//		String sError = "";
//		try {
//			NetworkIF networkIF = AbstractFactory.getNetworkIF(req.getProjectName());
//
//			// network update
//			Network network = new Network();
//			network.setId(req.getNetworkId());
//			network.setName(req.getNetworkName());
//			network.setAdmin_state_up(req.getAdminStateUp());
////			network.setShared(req.getShared());
//			networkIF.updateNetwork(network);
//
//			return "1";
//
//		} catch (NotConnectGatewayException e) {
//			logger.error("NotConnectGatewayException");
//			sError = e.getMessage();
//		} catch (NotSupportGatewayException e) {
//			logger.error("NotSupportGatewayException");
//			sError = e.getMessage();
//		} catch (InvaildOpenStackException e) {
//			logger.error("InvaildOpenStackException");
//			sError = e.getMessage();
//		}
//
//	    try {
//	        JsonObject jsonResponse = new JsonObject();
//	        jsonResponse.addProperty("error", sError);
//	        return jsonResponse.toString();
//	    } catch (JsonIOException e) {
//	        logger.error("JSON 처리 중 오류 발생");
//	    }
//		return "";
//	}
//
//
//	public String delete(CustomOssNetworkVO req) {
//		String sError = "";
//		try {
//			NetworkIF networkIF = AbstractFactory.getNetworkIF(req.getProjectName());
//			networkIF.deleteNetwork(req.getNetworkId());
//			dao.delete(req);
//
//			return "1";
//
//		} catch (NotConnectGatewayException e) {
//			logger.error("NotConnectGatewayException");
//			sError = e.getMessage();
//		} catch (NotSupportGatewayException e) {
//			logger.error("NotSupportGatewayException");
//			sError = e.getMessage();
//		} catch (InvaildOpenStackException e) {
//			logger.error("InvaildOpenStackException");
//			sError = e.getMessage();
//		}
//
//	    try {
//	        JsonObject jsonResponse = new JsonObject();
//	        jsonResponse.addProperty("error", sError);
//	        return jsonResponse.toString();
//	    } catch (JsonIOException e) {
//	        logger.error("JSON 처리 중 오류 발생");
//	    }
//		return "";
//	}


}
