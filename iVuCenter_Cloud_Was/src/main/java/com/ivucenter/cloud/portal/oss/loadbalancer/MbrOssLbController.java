package com.ivucenter.cloud.portal.oss.loadbalancer;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.portal.oss.vm.CustomOssVmVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/oss/loadbalancer")
public class MbrOssLbController {

    private static final Logger logger = LoggerFactory.getLogger(MbrOssLbController.class);

	@Autowired
	OssLbService ossLbService;

	/**
	 *	PAGE
	 */
	@RequestMapping(value="/")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String MngOssLoadBalancer() {
		log.debug("MbrOssLbController:MngOssLoadBalancer()");
		return "mng/oss/loadbalancer/lbList";
	}
	//리스트
	@RequestMapping(value = "/lbList")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String lbList(){

		return "mng/oss/loadbalancer/lbList";
	}

	//리스트
	@RequestMapping(value = "/list", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> getWorkList(CustomOssLbVO req){
		String res = "";
		int recordsTotal;
		int recordsFiltered;
		List<CustomOssLbVO> getLbList = ossLbService.getLbList(req);
		for(CustomOssLbVO vo : getLbList) {
    		vo.setManagerTel(vo.getManagerTelDec());
    		vo.setManagerPhone(vo.getManagerPhoneDec());
    	}
		recordsTotal = ossLbService.getLbListTot(req);
		recordsFiltered = recordsTotal;
		try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(getLbList));

	        res = jsonResponse.toString();
	    } catch (JsonIOException e) {
            logger.error("JSON 처리 중 오류 발생");
	    }
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/detail",produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngProjectQuotaCloudDetail(CustomOssLbVO req) {
		String res = "";
		int recordsTotal;
		int recordsFiltered;
		List<CustomOssLbVO> getLbList = ossLbService.getLb(req);
		recordsTotal = getLbList.size();
		recordsFiltered = recordsTotal;
		try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(getLbList));

	        res = jsonResponse.toString();
	    } catch (JsonIOException e) {
            logger.error("JSON 처리 중 오류 발생");
	    }

		return new ResponseEntity<Object>(res, HttpStatus.OK);

	}

	@RequestMapping(value = "/vmList",produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngProjectvmList(CustomOssLbVO req) {
		String res = "";
		int recordsTotal;
		int recordsFiltered;
		List<CustomOssVmVO> getVmList = ossLbService.getVmList(req);
		recordsTotal = getVmList.size();
		recordsFiltered = recordsTotal;
		try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(getVmList));

	        res = jsonResponse.toString();
	    } catch (JsonIOException e) {
            logger.error("JSON 처리 중 오류 발생");
	    }

		return new ResponseEntity<Object>(res, HttpStatus.OK);

	}

	@RequestMapping(value = "/deleteVm", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> deleteVm(CustomOssLbVO req){

		String res = ossLbService.deleteVm(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
}
