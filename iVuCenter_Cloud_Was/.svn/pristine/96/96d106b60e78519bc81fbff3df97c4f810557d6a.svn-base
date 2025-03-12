package com.ivucenter.cloud.portal.bss.product;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.time.DateFormatUtils;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.api.nutanix.NutanixObject;
import com.ivucenter.cloud.api.nutanix.NutanixUtils;
import com.ivucenter.cloud.api.openshift.object.OpsApiOptionService;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;
import com.ivucenter.cloud.api.openstack.interfaces.ImageIF;
import com.ivucenter.cloud.api.openstack.object.Image;
import com.ivucenter.cloud.api.vRealize.interfaces.vraAbstractFactory;
import com.ivucenter.cloud.api.vRealize.interfaces.vraCatalogIF;
import com.ivucenter.cloud.api.vRealize.object.vraCatalogObject;
import com.ivucenter.cloud.api.vmware.object.VmwareItemJsonObject;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.cmm.code.CmmCodeService;
import com.ivucenter.cloud.portal.cmm.code.CustomCmmCodeVO;
import com.ivucenter.cloud.portal.req.catalogue.CustomReqCatalogueVO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping(value="/mng/bss/product")
public class MngBssProductController {

    private static final Logger logger = LoggerFactory.getLogger(MngBssProductController.class);

	@Autowired
	private CmmCodeService cmmCodeService;

	@Autowired
	private MngBssProductService mngBssProductService;

	@Autowired
	private OssCloudService ossCloudService;

	private List<String> librarysList;

	@Autowired
	OpsApiOptionService opsApiOptionService;
	/**
	 * 상품 관리
	 */
	@RequestMapping(value="/")
	public String mngBbsFaqList(Model model, CustomBssProductVO req) {
		model.addAttribute("pageNum", mngBssProductService.pageNum(req));

		return "mng/bss/product/bssProductList";
	}

	/**
	 * 상품 관리 리스트
	 */
	@RequestMapping(value = "/list",method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> bssProductList(CustomBssProductVO req){

		String res = mngBssProductService.list(req);

		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	/**
	 * 상품정보 상세
	 */
	@RequestMapping(value="/view")
	public String mngReqProjectView(Model model, CustomBssProductVO req) {
		try{
			String  productSeq =req.getProductSeq();
			model.addAttribute("productSeq", productSeq);


			// item 가격정보
			req.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
			List<CustomBssProductVO> itemPrice = mngBssProductService.getItemsPriceInfo(req);
			model.addAttribute("getItemPrice", itemPrice);

			return "mng/bss/product/bssProductView";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	/**
	 * 상품 상세 불러오기
	 */
	@RequestMapping(value = "/productView", method = RequestMethod.POST)
	public ResponseEntity<Object> mngBbsNoticeDetail(String productSeq) {
		log.debug("detail 상제 불러오기");
		log.debug("=== mngBbsNoticeDetail Controller ===");

		CustomBssProductVO req = mngBssProductService.view(productSeq);
		CustomBssProductVO res =  null;

		if(req.getProductCategory().equals("PRODCATE_VM")){

			res = mngBssProductService.productView(productSeq);
			log.debug("PRODCATE_VM 상세 불러오기");
		}else if(req.getProductCategory().equals("PRODCATE_OS")){

			res = mngBssProductService.osView(productSeq);
			log.debug("PRODCATE_OS 상세 불러오기");
		}else if(req.getProductCategory().equals("PRODCATE_DISK")){

			res = mngBssProductService.diskView(productSeq);
			log.debug("PRODCATE_DISK 상세 불러오기");
		}else if(req.getProductCategory().equals("PRODCATE_NAS")){

			res = mngBssProductService.nasView(productSeq);
			log.debug("PRODCATE_NAS 상세 불러오기");
		}else if(req.getProductCategory().equals("PRODCATE_PUBLICIP")){

			res = mngBssProductService.ipView(productSeq);
			log.debug("PRODCATE_PUBLICIP 상세 불러오기");
		}else if(req.getProductCategory().equals("PRODCATE_LOADBALANCER")){

			res = mngBssProductService.lbView(productSeq);
			log.debug("PRODCATE_LOADBALANCER 상세 불러오기");
		}else if(req.getProductCategory().equals("PRODCATE_SERVICE")) {
			res = mngBssProductService.serviceView(productSeq);
		}else if(req.getProductCategory().equals("PRODCATE_APP")) {
			res = mngBssProductService.appView(productSeq);
		}
//		else if(req.getProductCategory().equals("PRODCATE_SCM")){
//			res = mngBssProductService.scmView(productSeq);
//			log.debug("PRODCATE_SCM 상세 불러오기");
//		}else if(req.getProductCategory().equals("PRODCATE_BACKUP")){
//			res = mngBssProductService.bkView(productSeq);
//			log.debug("PRODCATE_BACKUP 상세 불러오기");
//		}else if(req.getProductCategory().equals("PRODCATE_SECURITY")){
//			res = mngBssProductService.serView(productSeq);
//			log.debug("PRODCATE_SECURITY 상세 불러오기");
//		}else if(req.getProductCategory().equals("PRODCATE_MCA")){
//			res = mngBssProductService.mcaView(productSeq);
//			log.debug("PRODCATE_MCA 상세 불러오기");
//		}

		if (res != null) {
		res.setUserName(req.getUserName());
		res.setModDatetime(req.getModDatetime());
		}

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	/**
	 * 상품 수정 상세 페이지
	 */
	@RequestMapping(value = "/update", method=RequestMethod.GET)
	public String catalog(CustomBssProductVO req, Model model,HttpServletRequest request){
		try{

			model.addAttribute("productSeq",req.getProductSeq());

			// item 가격정보
			req.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
			CustomBssProductVO itemPrice = mngBssProductService.getItemPriceInfo(req);
			model.addAttribute("getItemPrice", itemPrice);

			List<String> parentCodeKeyList = new ArrayList<>();
			parentCodeKeyList.add("ITEMCATE_VMIMAGE");
			parentCodeKeyList.add("ITEMCATE_DISK");
			List<CustomCmmCodeVO> cateList = cmmCodeService.getCmmCodeByList(parentCodeKeyList);
			model.addAttribute("cmmCode", cateList);

			//product image type
			if(req.getProductCategory().equals("PRODCATE_VM")){
			CustomBssProductVO productImageType = mngBssProductService.getProductImageType(req);
				model.addAttribute("productImageType", productImageType.getImageType());
			}
			//product image type
			if(req.getProductCategory().equals("PRODCATE_VM")){
			CustomBssProductVO productImageType = mngBssProductService.getProductImageType(req);
				model.addAttribute("productVmDiskType", productImageType.getDiskType());
			}

			//product disk type
			if(req.getProductCategory().equals("PRODCATE_DISK")){
			CustomBssProductVO productDiskType = mngBssProductService.getProductDiskType(req);
				model.addAttribute("productDiskType", productDiskType.getDiskType());
			}

			return "mng/bss/product/bssProductUpdate";
		} catch (Exception e) {
			return "redirect:j_spring_security_logout";
		}
	}
	/**
	 * 가상서버 상품 등록
	 */
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public ResponseEntity<Object> bssProductInsert(HttpServletRequest request, CustomBssProductVO req, Model model) {

		String res = "";
		String cloudType = "";
		Date requestSeqdate = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String productSeq = dateFormat.format(requestSeqdate);
		req.setProductSeq(productSeq);

		String regUserId = request.getUserPrincipal().getName();
		req.setRegUserId(regUserId);
		res = mngBssProductService.productInsert(req);

		String productSategory = req.getProductCategory();
		switch(productSategory) {
			case "PRODCATE_SERVICE":
				res = mngBssProductService.serviceInsert(req);
				break;
			case "PRODCATE_VM":
				res = mngBssProductService.vmInsert(req);
				break;
			case "PRODCATE_OS":
				cloudType = req.getCloudType();
				if(cloudType.equals("openshift")) {
					res = mngBssProductService.osInsert(req);
					if(res == null) {
						return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
					}
					res = mngBssProductService.templateInsert(req);
				}else {
					res = mngBssProductService.osInsert(req);
				}
				break;
			case "PRODCATE_DISK":
				res = mngBssProductService.diskInsert(req);
				break;
			case "PRODCATE_NAS":
				res = mngBssProductService.nasInsert(req);
				break;
			case "PRODCATE_PUBLICIP":
				res = mngBssProductService.ipInsert(req);
				break;
			case "PRODCATE_LOADBALANCER":
				res = mngBssProductService.lbInsert(req);
				break;
			case "PRODCATE_ENV":
				System.out.println("PRODCATE_ENV");
				res = mngBssProductService.envInsert(req);
				break;
			case "PRODCATE_APP":
				res = mngBssProductService.containerInsert(req);
				break;
			default :
				break;
		}

//		else if(req.getProductCategory().equals("PRODCATE_SCM")) {
//			res = mngBssProductService.scmInsert(req);
//
//		} else if(req.getProductCategory().equals("PRODCATE_BACKUP")) {
//			res = mngBssProductService.bkInsert(req);
//
//		} else if(req.getProductCategory().equals("PRODCATE_SECURITY")) {
//			res = mngBssProductService.serInsert(req);
//
//		} else if(req.getProductCategory().equals("PRODCATE_MCA")) {
//			res = mngBssProductService.mcaInsert(req);
//		}


		if(res == null) {
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	/**
	 * os 팝업
	 */
	@RequestMapping(value = "/osPopList", method={RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<Object> osPopList(CustomBssProductVO req){

		List<CustomBssProductVO> res = mngBssProductService.osPopList(req);

		HashMap<String, Object> map = new HashMap<>();
		map.put("osPopList", res);
		log.debug("osPopList : " + res.size());
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	@RequestMapping(value = "/appTemplateList", method= {RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<Object> appTemplateList(CustomBssProductVO req){
		final String cloudId = req.getCloudId();
		Assert.notNull(cloudId, "");
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(cloudId);
		HashMap<String, Object> map = new HashMap<>();
		if(cloudVo.getCloudType().equals("openshift")) {
			try {
				map.put("appTemplateList", opsApiOptionService.getTemplates(cloudVo));
			} catch (Exception e) {
				// TODO Auto-generated catch block
	            logger.error("appTemplateList Exception");
			}
		}
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}
	/**
	 * Image 팝업
	 * @throws Exception
	 */
	@RequestMapping(value = "/imagePopList", method={RequestMethod.GET, RequestMethod.POST})
	public ResponseEntity<Object> imagePopList(CustomBssProductVO req) throws Exception{

		final String cloudId = req.getCloudId();
		Assert.notNull(cloudId, "");
		CustomOssCloudVO cloudVo = ossCloudService.getCloudInfo(cloudId);
		HashMap<String, Object> map = new HashMap<>();
//		List<VmwareItemJsonObject> result = new ArrayList<VmwareItemJsonObject>();

		try {

			if(cloudVo.getCloudType().equals("openstack")) {
				ImageIF apiIF = AbstractFactory.getImageIF(cloudVo);
				List<Image> list = apiIF.getImages();
				map.put("imagePopList", list);
			}else if(cloudVo.getCloudType().equals("vmware")) {
				vraCatalogIF vraCatalogIF = vraAbstractFactory.getCatalogueIF(cloudVo);
	        	List<vraCatalogObject> vraCatalogList = vraCatalogIF.vraGetCatalogue().getContent();
				map.put("imagePopList", vraCatalogList);
			}else if(cloudVo.getCloudType().equals("nutanix")) {


				List<CustomReqCatalogueVO> getCatalogueOslist = new ArrayList();
				NutanixObject nutanixObject = NutanixUtils.getMarketplaceItemList(cloudVo);

				 for (NutanixObject nobj : nutanixObject.getMarketplaceItems()) {
					CustomReqCatalogueVO customReqCatalogueVO = new CustomReqCatalogueVO();
					log.info("marketplace_item name : " + nobj.getObject("metadata").getValue("name"));
					log.info("marketplace_item uuid : " + nobj.getObject("metadata").getValue("uuid"));
					log.info("marketplace_item app_state : " + nobj.getObject("status").getValue("app_state"));
					log.info("marketplace_item version : " + nobj.getObject("status").getValue("version"));
					customReqCatalogueVO.setName((String) nobj.getObject("metadata").getValue("name"));
					customReqCatalogueVO.setId((String) nobj.getObject("metadata").getValue("uuid"));
					getCatalogueOslist.add(customReqCatalogueVO);
					map.put("imagePopList", getCatalogueOslist);

				 }
			}else if(cloudVo.getCloudType().equals("openshift")) {
				try {
					map.put("imagePopList", opsApiOptionService.getTemplates(cloudVo));

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			map.put("osCloudType", cloudVo.getCloudType());
		} catch (NotConnectGatewayException|NotSupportGatewayException|InvaildOpenStackException e) {
			log.error(e.getMessage());
		}
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	@RequestMapping(value = "/cloudPopList", method={RequestMethod.GET, RequestMethod.POST})
	public ResponseEntity<Object> cloudPopList(CustomBssProductVO req){

		List<CustomOssCloudVO> cloudVo = ossCloudService.getCloudList();
		HashMap<String, Object> map = new HashMap<>();
		map.put("cloudPopList", cloudVo);
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}
	/**
	 *상품 가상서버/운영체제 상세 수정
	 */
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public ResponseEntity<String> mngBbsNoticeUpdate(CustomBssProductVO req) {
		String res = "";
		res = mngBssProductService.productUpdate(req);

		if(req.getProductCategory().equals("PRODCATE_VM")){
			res = mngBssProductService.vmUpdate(req);
		}
		else if(req.getProductCategory().equals("PRODCATE_OS")){
			res = mngBssProductService.osUpdate(req);
		}else if(req.getProductCategory().equals("PRODCATE_DISK")){
			res = mngBssProductService.diskUpdate(req);
		}else if(req.getProductCategory().equals("PRODCATE_NAS")){
			res = mngBssProductService.nasUpdate(req);
		}else if(req.getProductCategory().equals("PRODCATE_PUBLICIP")){
			res = mngBssProductService.ipUpdate(req);
		}else if(req.getProductCategory().equals("PRODCATE_LOADBALANCER")){
			res = mngBssProductService.lbUpdate(req);
		}else if(req.getProductCategory().equals("PRODCATE_SERVICE")){
			res = mngBssProductService.serviceUpdate(req);
		}

//		else if(req.getProductCategory().equals("PRODCATE_SCM")){
//			res = mngBssProductService.scmUpdate(req);
//		}else if(req.getProductCategory().equals("PRODCATE_BACKUP")){
//			res = mngBssProductService.bkUpdate(req);
//		}else if(req.getProductCategory().equals("PRODCATE_SECURITY")){
//			res = mngBssProductService.serUpdate(req);
//		}else if(req.getProductCategory().equals("PRODCATE_MCA")){
//			res = mngBssProductService.mcaUpdate(req);
//		}

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	/**
	 * 상품 관리 등록 페이지
	 */
	@RequestMapping(value = "/write")
	public String bssProductWrite(HttpServletRequest request, CustomBssProductVO req, Model model) {
		try {

			model.addAttribute("productSeq", req.getProductSeq());

			List<CustomCmmCodeVO> productCategory = cmmCodeService.getCmmCode("PRODUCT_CATEGPRY");
			model.addAttribute("pc",productCategory);

			// item 가격정보
			req.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
			List<CustomBssProductVO> itemPrice = mngBssProductService.getItemsPriceInfo(req);
			model.addAttribute("getItemPrice", itemPrice);

			List<String> parentCodeKeyList = new ArrayList<>();
			parentCodeKeyList.add("ITEMCATE_VMIMAGE");
			parentCodeKeyList.add("ITEMCATE_DISK");
			parentCodeKeyList.add("ITEMCATE_VMDK_FILE");
			parentCodeKeyList.add("SERVICE_TYPE");
			parentCodeKeyList.add("ITEM_CATEGORY");
			parentCodeKeyList.add("ITEMCATE_APP_DIVISION");
			List<CustomCmmCodeVO> cmmCode = cmmCodeService.getCmmCodeByList(parentCodeKeyList);
			model.addAttribute("cmmCode", cmmCode);

			return "mng/bss/product/bssProductWrite";

		} catch (Exception e) {
			log.error(e.getMessage());
			return "redirect:j_spring_security_logout";
		}
	}

	@RequestMapping(value = "/excel")
	public ModelAndView bssProductExcel(CustomBssProductVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "product");
		map.addAttribute("excel_title", "상품관리_상품구성관리");
		map.addAttribute("excel_list", mngBssProductService.excel(req));
		return new ModelAndView("productExcelView", map);
	}


	/**
	 *상품 가상서버/운영체제 상세 수정
	 */
	@RequestMapping(value="/productDelete", method=RequestMethod.POST)
	public ResponseEntity<String> productDelete(CustomBssProductVO req) {
		String res = "";

			res = mngBssProductService.productDelete(req);

			if(req.getProductCategory().equals("PRODCATE_VM")){
				res = mngBssProductService.vmDelete(req);

			}else if(req.getProductCategory().equals("PRODCATE_DISK")){
				res = mngBssProductService.diskDelete(req);

			}else if(req.getProductCategory().equals("PRODCATE_SERVICE")){
				res = mngBssProductService.seviceDelete(req);

			}else if(req.getProductCategory().equals("PRODCATE_OS")){
				res = mngBssProductService.osDelete(req);

			}

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


}
