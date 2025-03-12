package com.ivucenter.cloud.portal.oss.nas;

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

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/oss/nas")
public class MngOssNasController {

    private static final Logger logger = LoggerFactory.getLogger(MngOssNasController.class);

	@Autowired
	OssNasService nasService;

	/**
	 *	PAGE
	 */
	@RequestMapping(value="/")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String MngOssNas() {
		log.debug("MngOssNasController:MngOssNas()");
		return "mng/oss/nas/nasList";
	}
	//nas 리스트
	@RequestMapping(value = "/nasList")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER", "ROLE_CUSTOM_PM"} )
	public String nasList(){

		return "mng/oss/nas/nasList";
	}

	//nas 리스트
	@RequestMapping(value = "/nasList", method = RequestMethod.GET)
	public ResponseEntity<Object> getNasList(CustomOssNasVO req){

		String res = "";
		int recordsTotal;
		int recordsFiltered;

		log.debug("getSearchKind : "+req.getSearchKind());
		log.debug("getKeyword : "+req.getKeyword());

		List<CustomOssNasVO> getNasList = nasService.getNasList(req);

		recordsTotal = getNasList.size();
		recordsFiltered = recordsTotal;
		try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(getNasList));

	        res = jsonResponse.toString();
	    } catch (JsonIOException e) {
	    	logger.error("JSON 처리 중 오류 발생");
	    }
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
}
