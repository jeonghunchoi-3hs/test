package com.ivucenter.cloud.portal.oss.nas;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mbr/oss/nas")
public class MbrOssNasController {

	@Autowired
	private OssNasService nasService;

	//nas 리스트
	@RequestMapping(value = "/nasList", method = RequestMethod.GET)
	public ResponseEntity<Object> getNasList(HttpServletRequest request,HttpServletResponse response,CustomOssNasVO req){

		String res = "";
		int recordsTotal;
		int recordsFiltered;

		log.debug("getSearchKind : "+req.getSearchKind());
		log.debug("getKeyword : "+req.getKeyword());

		List<CustomOssNasVO> getNasList = null;
		if(req.getRequestType().equals("REQTYPE_CHANGE")) {
			// Openshift NAS 변경신청 제외, 일반 NAS 목록만 조회
			getNasList = nasService.getNasList(req);
		}else {
			// NAS 삭제 신청 > Openshift 포함 NAS 목록 조회
			getNasList = nasService.getNasAllList(req);
		}

		recordsTotal = getNasList.size();
		log.debug("recordsTotal : " + recordsTotal);
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
	        log.error(e.getMessage());
	    }
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
}
