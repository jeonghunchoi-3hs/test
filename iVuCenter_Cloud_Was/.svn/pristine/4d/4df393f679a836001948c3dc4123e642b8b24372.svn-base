package com.ivucenter.cloud.portal.oss.publicip;

import java.util.List;

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

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/oss/publicip")
public class MbrOssIpController {

	@Autowired
	private OssIpService ossIpService;
	
	@RequestMapping(value="/")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String MngOssPublicIp() {
		
		return "mng/oss/publicip/ipList";
	}
	
	//ip 리스트
	@RequestMapping(value = "/ipList")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String ipList(){
		
		return "mng/oss/publicip/ipList";
	}
	
	//리스트 
	@RequestMapping(value = "/ipList", method = RequestMethod.GET)
	public ResponseEntity<Object> getWorkList(CustomOssIpVO req){
		String res = "";		
		int recordsTotal;
		int recordsFiltered;
		
		log.debug("getSearchKind : "+req.getSearchKind());
		log.debug("getKeyword : "+req.getKeyword());
		
		List<CustomOssIpVO> getIpList = ossIpService.getIpList(req);
				
		recordsTotal = getIpList.size();
		recordsFiltered = recordsTotal;
		try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();
	        
	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(getIpList));
	        
	        res = jsonResponse.toString();
	    } catch (JsonIOException e) {
	        log.error(e.getMessage());
	    }		
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
}
