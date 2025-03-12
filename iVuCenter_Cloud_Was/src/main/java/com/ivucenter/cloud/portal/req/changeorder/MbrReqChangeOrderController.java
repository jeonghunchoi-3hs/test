package com.ivucenter.cloud.portal.req.changeorder;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.entity.OssFlavorVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.cmm.user.CmmUserService;
import com.ivucenter.cloud.portal.cmm.user.CustomCmmUserVO;
import com.ivucenter.cloud.portal.login.UserSession;
import com.ivucenter.cloud.portal.oss.service.CustomOssServiceVO;
import com.ivucenter.cloud.portal.oss.service.OssServiceService;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqCatalogueVO;
import com.ivucenter.cloud.portal.req.catalogue.ReqCatalogueService;

@Controller
@RequestMapping(value = "/mbr/req/changeOrder")
public class MbrReqChangeOrderController {

    private static final Logger logger = LoggerFactory.getLogger(MbrReqChangeOrderController.class);

//	@Autowired	private OssVmService vmService;

	@Autowired
	private OssServiceService serviceService;

	@Autowired
	private ReqCatalogueService reqCatalogueService;

	@Autowired
	private CmmUserService cmmUserService;

	@Autowired
	private OssCloudService ossCloudService;

	/**
	 * 변경 및 해지 신청 페이지
	 * "projectId="+projectId
	   "&gubun="+gubun
	   "&productId="+productId;
	 */
	@RequestMapping(value = "/changeOrderView")
	@Secured( {"ROLE_CUSTOM_ADMIN","ROLE_CUSTOM_USER"} )
	public String changeOrderView(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("apprvPass", userSession.getApprvPass());
		String projectBoxId = request.getParameter("projectBoxId");
		model.addAttribute("projectBoxId",projectBoxId);

		String viewFlag = request.getParameter("viewFlag");
		model.addAttribute("viewFlag",viewFlag);

		String gubun = request.getParameter("gubun");
		model.addAttribute("gubun",gubun);

		String productId = request.getParameter("productId");	//상품구분
		model.addAttribute("productId",productId);

		String loginId = request.getUserPrincipal().getName();

		CustomCmmUserVO cmmUserInfo = cmmUserService.userInfoDetail(loginId);
		model.addAttribute("userLevelCode", cmmUserInfo.getUserLevelCode());

		return "mbr/req/changeOrder/changeOrder";
	}

	@RequestMapping(value = "/changeOrderPriceInfo")
	public ResponseEntity<Object> changeOrderGridPrice(HttpServletRequest req){

		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		projectvo.setCloudId(req.getParameter("cloudId"));
		CustomReqCatalogueVO changeOrderPriceInfo = reqCatalogueService.getChangOrderViewPriceInfo(projectvo);
		HttpStatus status = ObjectUtils.isEmpty(changeOrderPriceInfo) ? HttpStatus.NO_CONTENT : HttpStatus.OK;
		return new ResponseEntity<Object>(changeOrderPriceInfo, status);
	}

	// 서비스목록
	@RequestMapping(value = "/serviceList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> getServiceList(CustomOssServiceVO req){
		String res = "";
		int recordsTotal;
		int recordsFiltered;

		List<CustomOssServiceVO> getServiceList = serviceService.getServiceList(req);

		recordsTotal = getServiceList.size();
		recordsFiltered = recordsTotal;
		try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(getServiceList));

	        res = jsonResponse.toString();
	    } catch (JsonIOException e) {
	        logger.error("JSON 처리 중 오류 발생");
	    }
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	//Flavor 목록
	@RequestMapping(value = "/getFlavorList")
	public ResponseEntity<Object> getFlavorList(HttpServletRequest req){
		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setCloudId(req.getParameter("cloudId"));
		List<OssFlavorVO> getCatalogueFlavorList = reqCatalogueService.getCatalogueFlavorList(projectvo);
		HttpStatus status = ObjectUtils.isEmpty(getCatalogueFlavorList) ? HttpStatus.NO_CONTENT : HttpStatus.OK;
		return new ResponseEntity<Object>(getCatalogueFlavorList, status);
	}

	@RequestMapping(value = "/getFlavorTypeList")
	public ResponseEntity<Object> getFlavorTypeList(HttpServletRequest req){
		CustomReqCatalogueVO projectvo = new CustomReqCatalogueVO();
		projectvo.setCloudId(req.getParameter("cloudId"));
		List<OssFlavorVO> getFlavorTypeList = reqCatalogueService.getFlavorTypeList(projectvo);
		HttpStatus status = ObjectUtils.isEmpty(getFlavorTypeList) ? HttpStatus.NO_CONTENT : HttpStatus.OK;
		return new ResponseEntity<Object>(getFlavorTypeList, status);
	}

}
