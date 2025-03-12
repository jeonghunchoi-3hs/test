package com.ivucenter.cloud.portal.bss.catalog;

import java.io.IOException;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ivucenter.cloud.portal.bss.product.CustomBssProductVO;
import com.ivucenter.cloud.portal.bss.product.MngBssProductService;
import com.ivucenter.cloud.portal.cmm.cloud.OssCloudService;
import com.ivucenter.cloud.portal.cmm.code.CmmCodeService;
import com.ivucenter.cloud.portal.cmm.code.CustomCmmCodeVO;
import com.ivucenter.cloud.portal.cmm.file.CmmFileService;
import com.ivucenter.cloud.portal.cmm.file.CustomCmmFileVO;
import com.ivucenter.cloud.portal.util.CodeUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/bss/catalog")
public class MngBssCatalogController {

	@Autowired
	private BssCatalogService mngCatalogService;

	@Autowired
	private MngBssProductService mngBssProductService;

	@Autowired
	private BssCatalogDAO mngCatalogDao;

	@Autowired
	private CmmCodeService cmmCodeService;

	@Autowired
	private OssCloudService ossCloudService;

	@Autowired
	private CmmFileService cmmFileService;

	/**
	 * 카탈로그 관리
	 */
	@RequestMapping(value="/")
	public String mngBbsFaqList(Model model) {
		return "mng/bss/catalog/bssCatalog-list";
	}
	/**
	 * 카탈로그 등록 페이지
	 */
	@RequestMapping(value = "/write")
	public String catalogueWrite(CustomBssCatalogVO req, Model model){

		model.addAttribute("catalogSeq", req.getCatalogSeq());

		// 카테고리 상품목록
		List<CustomCmmCodeVO> cateList = cmmCodeService.getCmmCode("CATALOG_CATEGORY");
		model.addAttribute("cateList", cateList);

		// item 가격정보
		CustomBssCatalogVO 	cataInfo = mngCatalogDao.detail(req.getCatalogSeq());
		CustomBssProductVO productVO = new CustomBssProductVO();
		//productVO.setApplyDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
		productVO.setApplyDate(cataInfo.getApplyDate());
		productVO.setCloudId(req.getCloudId());
//		CustomBssProductVO itemPrice = mngBssProductService.getItemPriceInfo(productVO);

		CustomBssProductVO itemPrice = mngBssProductService.getItemPriceInfo(productVO);
		model.addAttribute("getItemPrice", itemPrice);

		//model.addAttribute("downloadNo", req.getDownloadNo());
		model.addAttribute("programName", CodeUtil.FILE_PROGRAM_CATALOG_ITEM);

		return "mng/bss/catalog/bssCatalog-write";
	}


	/**
	 * 카탈로그 관리 리스트
	 */
	@RequestMapping(value = "/list",method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> MngBssCatalogList(CustomBssCatalogVO req){
		String res = mngCatalogService.list(req);
		if(res.equals("")){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	/**
	 * 카탈로그 등록(복사기능)
	 */
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public ResponseEntity<String> mngCatalogInsert(CustomBssCatalogVO req) throws IOException {
		return new ResponseEntity<String>(mngCatalogService.insert(req), HttpStatus.OK);
	}
	/**
	 * 카탈로그 삭제
	 */
	@RequestMapping(value = "/delete", method={RequestMethod.POST,RequestMethod.GET})
	public  ResponseEntity<Object> catalogDelchkOk(CustomBssCatalogVO req, Model model) {
		return new ResponseEntity<Object>(mngCatalogService.delete(req), HttpStatus.OK);
	}

	/**
	 * 카탈로그 등록(신규등록)
	 */
	@RequestMapping(value="/catalogNewInsert", method=RequestMethod.POST)
	public ResponseEntity<String> mngCatalogNewInsert(CustomBssCatalogVO req ,Principal principal) throws IOException {
		req.setUserId(principal.getName());
		return new ResponseEntity<String>(mngCatalogService.catalogNewInsert(req), HttpStatus.OK);
	}

	/**
	 * 카탈로그 상품 삭제
	 */
	@RequestMapping(value = "/catalogProductDelete", method={RequestMethod.POST,RequestMethod.GET})
	public  ResponseEntity<Object> catalogProductDelete(CustomBssCatalogVO req, Model model) {
		return new ResponseEntity<Object>(mngCatalogService.catalogProductDelete(req), HttpStatus.OK);
	}


	@RequestMapping(value = "/excel")
	public ModelAndView MngBssCatalogExcel(CustomBssCatalogVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "catalog");
		map.addAttribute("excel_title", "삼품관리_카탈로그 관리");
		map.addAttribute("excel_list", mngCatalogService.excel(req));
		return new ModelAndView("productExcelView", map);
	}

	/**
	 * 카탈로그 수정 로직
	 */
	@RequestMapping(value = "/catalogUpdate", method=RequestMethod.POST)
	public ResponseEntity<String> catalogueUpdate(CustomBssCatalogVO req){
		String res = mngCatalogService.catalogUpdate(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);

	}
	/**
	 * 카탈로그 수정 상세 로직
	 */
	@RequestMapping(value = "/catalogDetail", method={RequestMethod.POST,RequestMethod.GET})
	public  ResponseEntity<Object> catalogDetail(CustomBssCatalogVO req, Model model, Principal principal){

		req.setRegUserId(principal.getName());
		String catalogSeq = req.getCatalogSeq();
		log.debug("=== catalogDetail Controller ==="+catalogSeq);

		CustomBssCatalogVO res = mngCatalogService.catalogDetail(catalogSeq);

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	/**
	 * 카탈로그 수정 상세 페이지
	 */
	@RequestMapping(value = "/catalog", method=RequestMethod.GET)
	public String catalog(CustomBssCatalogVO req, Model model){
		model.addAttribute("catalogSeq",req.getCatalogSeq());
		return "mng/bss/catalog/catalogUpdate";
	}
	/**
	 * 카탈로그 복사  페이지
	 */
	@RequestMapping(value = "/catalogCopy")
	public String catalogueCopy(CustomBssCatalogVO req, Model model){
		model.addAttribute("catalogSeq",req.getCatalogSeq());
		return "mng/bss/catalog/catalogCopy";
	}

	/**
	 * 카탈로그 리스트 ( 주석 : /viewPage 으로 변경)
	@RequestMapping(value="/view")
	public String mngReqProjectView(Model model, CustomBssCatalogVO req) {
		model.addAttribute("catalogSeq", req.getCatalogSeq());
		model.addAttribute("catalogName", req.getCatalogName());
		String catalogSeq = req.getCatalogSeq();

		CustomBssCatalogVO detail = mngCatalogService.detail(catalogSeq);
		String applyDate = detail.getApplyDate();

		model.addAttribute("detail", detail);
		//가상서버 조회
		String showCatalogCategory="CATACATE_VM";
		String showDisplayFlag="Y";

		req.setShowCatalogCategory(showCatalogCategory);
		req.setShowDisplayFlag(showDisplayFlag);
		req.setApplyDate(applyDate);

		CustomCmmFileVO vo2 = new CustomCmmFileVO();
		vo2.setProgramName(catalogSeq);

		List<CustomBssCatalogVO> getCatalogueProductList = mngCatalogService.getCatalogueProductList(req);
		for(int i=0;i<getCatalogueProductList.size();i++){
			vo2.setProgramSeq(getCatalogueProductList.get(i).getProductSeq());

			if(getCatalogueProductList.get(i).getDisplayFlag().equals("Y") ){
				getCatalogueProductList.get(i).setDisplayFlagName("표시");

			}if(getCatalogueProductList.get(i).getDisplayFlag().equals("N")){
				getCatalogueProductList.get(i).setDisplayFlagName("미표시");

			}if(getCatalogueProductList.get(i).getRecommandFlag().equals("Y")){
				getCatalogueProductList.get(i).setRecommandFlagName("추천");

			}if(getCatalogueProductList.get(i).getRecommandFlag().equals("N")){
				getCatalogueProductList.get(i).setRecommandFlagName("미추천");
			}
		}
		model.addAttribute("product", getCatalogueProductList);

		//os운영체제 조회
		showCatalogCategory="CATACATE_OS";
		req.setShowCatalogCategory(showCatalogCategory);
		List<CustomBssCatalogVO> getCatalogueProductOsList = mngCatalogService.getCatalogueProductOsList(req);
		for(int i=0;i<getCatalogueProductOsList.size();i++){
			if(getCatalogueProductOsList.get(i).getDisplayFlag().equals("Y")){
				getCatalogueProductOsList.get(i).setDisplayFlagName("표시");
			}if(getCatalogueProductOsList.get(i).getDisplayFlag().equals("N")){
				getCatalogueProductOsList.get(i).setDisplayFlagName("미표시");

			}if(getCatalogueProductOsList.get(i).getRecommandFlag().equals("Y")){
				getCatalogueProductOsList.get(i).setRecommandFlagName("추천");

			}if(getCatalogueProductOsList.get(i).getRecommandFlag().equals("N")){
				getCatalogueProductOsList.get(i).setRecommandFlagName("미추천");
			}
		}

		model.addAttribute("os", getCatalogueProductOsList);

		//블록디스크 조회
		showCatalogCategory="CATACATE_DISK";
		req.setShowCatalogCategory(showCatalogCategory);
		List<CustomBssCatalogVO> getCatalogueProductDiskList = mngCatalogService.getCatalogueProductDiskList(req);
		for(int i=0;i<getCatalogueProductDiskList.size();i++){
			if(getCatalogueProductDiskList.get(i).getDisplayFlag().equals("Y")){
				getCatalogueProductDiskList.get(i).setDisplayFlagName("표시");
			}if(getCatalogueProductDiskList.get(i).getDisplayFlag().equals("N")){
				getCatalogueProductDiskList.get(i).setDisplayFlagName("미표시");

			}if(getCatalogueProductDiskList.get(i).getRecommandFlag().equals("Y")){
				getCatalogueProductDiskList.get(i).setRecommandFlagName("추천");

			}if(getCatalogueProductDiskList.get(i).getRecommandFlag().equals("N")){
				getCatalogueProductDiskList.get(i).setRecommandFlagName("미추천");
			}
		}

		model.addAttribute("disk", getCatalogueProductDiskList);

		//NAS 조회
		showCatalogCategory="CATACATE_NAS";
		req.setShowCatalogCategory(showCatalogCategory);
		List<CustomBssCatalogVO> getCatalogueProductNasList = mngCatalogService.getCatalogueProductNasList(req);
		for(int i=0;i<getCatalogueProductNasList.size();i++){
			if(getCatalogueProductNasList.get(i).getDisplayFlag().equals("Y")){
				getCatalogueProductNasList.get(i).setDisplayFlagName("표시");
			}if(getCatalogueProductNasList.get(i).getDisplayFlag().equals("N")){
				getCatalogueProductNasList.get(i).setDisplayFlagName("미표시");

			}if(getCatalogueProductNasList.get(i).getRecommandFlag().equals("Y")){
				getCatalogueProductNasList.get(i).setRecommandFlagName("추천");

			}if(getCatalogueProductNasList.get(i).getRecommandFlag().equals("N")){
				getCatalogueProductNasList.get(i).setRecommandFlagName("미추천");
			}
		}

		model.addAttribute("nas", getCatalogueProductNasList);
		//공인IP 조회
		showCatalogCategory="CATACATE_PUBLICIP";
		req.setShowCatalogCategory(showCatalogCategory);
		List<CustomBssCatalogVO> getCatalogueProductPublicIpList = mngCatalogService.getCatalogueProductPublicIpList(req);
		for(int i=0;i<getCatalogueProductPublicIpList.size();i++){
			if(getCatalogueProductPublicIpList.get(i).getDisplayFlag().equals("Y")){
				getCatalogueProductPublicIpList.get(i).setDisplayFlagName("표시");
			}if(getCatalogueProductPublicIpList.get(i).getDisplayFlag().equals("N")){
				getCatalogueProductPublicIpList.get(i).setDisplayFlagName("미표시");

			}if(getCatalogueProductPublicIpList.get(i).getRecommandFlag().equals("Y")){
				getCatalogueProductPublicIpList.get(i).setRecommandFlagName("추천");

			}if(getCatalogueProductPublicIpList.get(i).getRecommandFlag().equals("N")){
				getCatalogueProductPublicIpList.get(i).setRecommandFlagName("미추천");
			}
		}

		model.addAttribute("ip", getCatalogueProductPublicIpList);
		//로드밸런서 조회
		showCatalogCategory="CATACATE_LOADBALANCER";
		req.setShowCatalogCategory(showCatalogCategory);
		List<CustomBssCatalogVO> getCatalogueProductLbList = mngCatalogService.getCatalogueProductLbList(req);
		for(int i=0;i<getCatalogueProductLbList.size();i++){
			if(getCatalogueProductLbList.get(i).getDisplayFlag().equals("Y")){
				getCatalogueProductLbList.get(i).setDisplayFlagName("표시");
			}if(getCatalogueProductLbList.get(i).getDisplayFlag().equals("N")){
				getCatalogueProductLbList.get(i).setDisplayFlagName("미표시");

			}if(getCatalogueProductLbList.get(i).getRecommandFlag().equals("Y")){
				getCatalogueProductLbList.get(i).setRecommandFlagName("추천");

			}if(getCatalogueProductLbList.get(i).getRecommandFlag().equals("N")){
				getCatalogueProductLbList.get(i).setRecommandFlagName("미추천");
			}
		}

		model.addAttribute("lb", getCatalogueProductLbList);
		//형상관리 조회
		showCatalogCategory="CATACATE_SCM";
		req.setShowCatalogCategory(showCatalogCategory);
		List<CustomBssCatalogVO> getCatalogueProductScmList = mngCatalogService.getCatalogueProductScmList(req);
		for(int i=0;i<getCatalogueProductScmList.size();i++){
			if(getCatalogueProductScmList.get(i).getDisplayFlag().equals("Y")){
				getCatalogueProductScmList.get(i).setDisplayFlagName("표시");
			}if(getCatalogueProductScmList.get(i).getDisplayFlag().equals("N")){
				getCatalogueProductScmList.get(i).setDisplayFlagName("미표시");

			}if(getCatalogueProductScmList.get(i).getRecommandFlag().equals("Y")){
				getCatalogueProductScmList.get(i).setRecommandFlagName("추천");

			}if(getCatalogueProductScmList.get(i).getRecommandFlag().equals("N")){
				getCatalogueProductScmList.get(i).setRecommandFlagName("미추천");
			}
		}

		model.addAttribute("scm", getCatalogueProductScmList);
		//백업 조회
		showCatalogCategory="CATACATE_BACKUP";
		req.setShowCatalogCategory(showCatalogCategory);
		List<CustomBssCatalogVO> getCatalogueProductBackupList = mngCatalogService.getCatalogueProductBackupList(req);
		for(int i=0;i<getCatalogueProductBackupList.size();i++){
			if(getCatalogueProductBackupList.get(i).getDisplayFlag().equals("Y")){
				getCatalogueProductBackupList.get(i).setDisplayFlagName("표시");
			}if(getCatalogueProductBackupList.get(i).getDisplayFlag().equals("N")){
				getCatalogueProductBackupList.get(i).setDisplayFlagName("미표시");

			}if(getCatalogueProductBackupList.get(i).getRecommandFlag().equals("Y")){
				getCatalogueProductBackupList.get(i).setRecommandFlagName("추천");

			}if(getCatalogueProductBackupList.get(i).getRecommandFlag().equals("N")){
				getCatalogueProductBackupList.get(i).setRecommandFlagName("미추천");
			}
		}

		model.addAttribute("backup", getCatalogueProductBackupList);

		//서비스 조회
				showCatalogCategory="CATACATE_SERVICE";
				req.setShowCatalogCategory(showCatalogCategory);
				List<CustomBssCatalogVO> getCatalogueProductServiceList = mngCatalogService.getCatalogueProductServiceList(req);
				for(int i=0;i<getCatalogueProductServiceList.size();i++){
					if(getCatalogueProductServiceList.get(i).getDisplayFlag().equals("Y")){
						getCatalogueProductServiceList.get(i).setDisplayFlagName("표시");
					}if(getCatalogueProductServiceList.get(i).getDisplayFlag().equals("N")){
						getCatalogueProductServiceList.get(i).setDisplayFlagName("미표시");

					}if(getCatalogueProductServiceList.get(i).getRecommandFlag().equals("Y")){
						getCatalogueProductServiceList.get(i).setRecommandFlagName("추천");

					}if(getCatalogueProductServiceList.get(i).getRecommandFlag().equals("N")){
						getCatalogueProductServiceList.get(i).setRecommandFlagName("미추천");
					}
				}

				model.addAttribute("service", getCatalogueProductServiceList);

		//보안관제 조회
		showCatalogCategory="CATACATE_SECURITY";
		req.setShowCatalogCategory(showCatalogCategory);
		List<CustomBssCatalogVO> getCatalogueProductSercurityList = mngCatalogService.getCatalogueProductSercurityList(req);
		for(int i=0;i<getCatalogueProductSercurityList.size();i++){
			if(getCatalogueProductSercurityList.get(i).getDisplayFlag().equals("Y")){
				getCatalogueProductSercurityList.get(i).setDisplayFlagName("표시");
			}if(getCatalogueProductSercurityList.get(i).getDisplayFlag().equals("N")){
				getCatalogueProductSercurityList.get(i).setDisplayFlagName("미표시");

			}if(getCatalogueProductSercurityList.get(i).getRecommandFlag().equals("Y")){
				getCatalogueProductSercurityList.get(i).setRecommandFlagName("추천");

			}if(getCatalogueProductSercurityList.get(i).getRecommandFlag().equals("N")){
				getCatalogueProductSercurityList.get(i).setRecommandFlagName("미추천");
			}
		}

		model.addAttribute("security", getCatalogueProductSercurityList);
		//대외계 조회
		showCatalogCategory="CATACATE_MCA";
		req.setShowCatalogCategory(showCatalogCategory);
		List<CustomBssCatalogVO> getCatalogueProductMcaList = mngCatalogService.getCatalogueProductMcaList(req);
		for(int i=0;i<getCatalogueProductMcaList.size();i++){
			if(getCatalogueProductMcaList.get(i).getDisplayFlag().equals("Y")){
				getCatalogueProductMcaList.get(i).setDisplayFlagName("표시");

			}if(getCatalogueProductMcaList.get(i).getDisplayFlag().equals("N")){
				getCatalogueProductMcaList.get(i).setDisplayFlagName("미표시");

			}if(getCatalogueProductMcaList.get(i).getRecommandFlag().equals("Y")){
				getCatalogueProductMcaList.get(i).setRecommandFlagName("추천");

			}if(getCatalogueProductMcaList.get(i).getRecommandFlag().equals("N")){
				getCatalogueProductMcaList.get(i).setRecommandFlagName("미추천");

			}

			log.debug("!!!!!!!!!!!!!!!@@@@@@@@@@@#################******"+getCatalogueProductMcaList.get(i).getProductName());

		}

		model.addAttribute("mca", getCatalogueProductMcaList);
		//스토리지 아직 없음
//		CustomMngCatalogueVO getProjectView = mngCatalogService.getProjectView(reqProjectSeq);
//		model.addAttribute("getProjectView", getProjectView);

		return "mng/bss/catalog/catalogView";
	}
	*/

	/**
	 * 카탈로그 상세페이지
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping(value="/viewPage", produces="text/plain;charset=UTF-8")
	public String mngReqProductViewPage(Model model, CustomBssCatalogVO req) {
		model.addAttribute("catalogSeq", req.getCatalogSeq());
		model.addAttribute("catalogName", req.getCatalogName());

		// 카테고리 기본정보 + 클라우드 정보
		String catalogSeq = req.getCatalogSeq();
		CustomBssCatalogVO detail = mngCatalogService.detail(catalogSeq);
		model.addAttribute("detail", detail);

		// 카테고리 상품목록
		List<CustomCmmCodeVO> cateList = cmmCodeService.getCmmCode("CATALOG_CATEGORY");
		model.addAttribute("cateList", cateList);

		String applyDate = detail.getApplyDate();
		model.addAttribute("applyDate", applyDate);

		return "mng/bss/catalog/catalogView";
	}

	/**
	 * 카탈로그 상품 목록조회
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/mngReqProjectViewList", produces="text/plain;charset=UTF-8")
	public ResponseEntity<Object> mngReqProductViewList(CustomBssCatalogVO req) {
		String res = mngCatalogService.catalogueProductList(req);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/mngReqProjectViewExcel")
	public ModelAndView mngReqProjectViewExcel(CustomBssCatalogVO req, ModelMap map) {
		map.addAttribute("excel_gbn", "bssCatalog");
		map.addAttribute("excel_title", "상품관리_카탈로그상세");
		map.addAttribute("excel_list", mngCatalogService.catalogueProductExcel(req));

		return new ModelAndView("bssCatalogExcelView", map);
	}

	/**
	 * 카탈로그 상품 DisplayOrder Update
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/updateDiplayOrder")
	public ResponseEntity<Object> updateDiplayOrder(CustomBssCatalogVO req) {
		log.debug("=== updateDiplayOrder Controller ===");
		log.debug("productSeq : " + req.getProductSeq());
		String res = mngCatalogService.updateDisplayOrder(req);
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	/**
	 * 카탈로그 상품별 Count
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/getDisplayOrderCount")
	public ResponseEntity<Object> getDisplayOrderCount(CustomBssCatalogVO req) {
		log.debug("=== updateDiplayOrder Controller ===");
		log.debug("productSeq : " + req.getProductSeq());
		int orderCount = mngCatalogService.getDisplayOrderCount(req);
		return new ResponseEntity<Object>(orderCount, HttpStatus.OK);
	}


	/**
	 * 카탈로그 상품 상세페이지
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping(value="/productViewPage")
	public String mngReqCateProductViewPage(HttpServletRequest request, Model model, CustomBssCatalogVO req) {

		String catalogSeq = req.getCatalogSeq();
		CustomBssCatalogVO detail = mngCatalogService.detail(catalogSeq);

		// 상품 이미지 정보
		CustomCmmFileVO vo = new CustomCmmFileVO();
		vo.setProgramName(CodeUtil.FILE_PROGRAM_CATALOG_ITEM);
		vo.setProgramSeq(req.getCatalogSeq() + "_" + req.getProductSeq() );
		model.addAttribute("file", cmmFileService.list(vo));

		String applyDate = detail.getApplyDate();

		model.addAttribute("catalogSeq", req.getCatalogSeq());
		model.addAttribute("productSeq", req.getProductSeq());
		model.addAttribute("catalogCategory", req.getCatalogCategory());
		model.addAttribute("detail", detail);
		model.addAttribute("applyDate", applyDate);
		req.setApplyDate(applyDate);

		CustomBssCatalogVO res = mngCatalogService.productView(req);

		String cataCate = req.getCatalogCategory();

		if(cataCate.equals("CATACATE_VM")){
			res.setCategoryType("1");
		}else if(cataCate.equals("CATACATE_DISK")){
			res.setCategoryType("2");
		}else if(cataCate.equals("CATACATE_NAS")){
			res.setCategoryType("3");
		}else if(cataCate.equals("CATACATE_PUBLICIP")){
			res.setCategoryType("4");
		}else if(cataCate.equals("CATACATE_LOADBALANCER")){
			res.setCategoryType("5");
		}else if(cataCate.equals("CATACATE_OS")){
			res.setCategoryType("10");
		}

//		else if(cataCate.equals("CATACATE_BACKUP")){
//			res.setCategoryType("6");
//		}else if(cataCate.equals("CATACATE_SCM")){
//			res.setCategoryType("7");
//		}else if(cataCate.equals("CATACATE_MCA")){
//			res.setCategoryType("8");
//		}else if(cataCate.equals("CATACATE_SECURITY")){
//			res.setCategoryType("9");
//		}

		model.addAttribute("viewDetail", res);

		return "mng/bss/catalog/catalogViewDetail";
	}


	/**
	 * 카탈로그 상품 수정페이지
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping(value="/productUpdatePage")
	public String mngReqCateProductUpdatePage(HttpServletRequest request, Model model, CustomBssCatalogVO req) {
		// 카테고리 기본정보

		String catalogSeq = req.getCatalogSeq();
		CustomBssCatalogVO detail = mngCatalogService.detail(catalogSeq);

		String applyDate = detail.getApplyDate();

		model.addAttribute("catalogSeq", req.getCatalogSeq());
		model.addAttribute("productSeq", req.getProductSeq());
		model.addAttribute("catalogCategory", req.getCatalogCategory());
		model.addAttribute("detail", detail);
		model.addAttribute("applyDate", applyDate);
		req.setApplyDate(applyDate);

		CustomBssCatalogVO res = mngCatalogService.productView(req);

		String cataCate = req.getCatalogCategory();

		if(cataCate.equals("CATACATE_VM")){
			res.setCategoryType("1");
		}else if(cataCate.equals("CATACATE_DISK")){
			res.setCategoryType("2");
		}else if(cataCate.equals("CATACATE_NAS")){
			res.setCategoryType("3");
		}else if(cataCate.equals("CATACATE_PUBLICIP")){
			res.setCategoryType("4");
		}else if(cataCate.equals("CATACATE_LOADBALANCER")){
			res.setCategoryType("5");
		}else if(cataCate.equals("CATACATE_OS")){
			res.setCategoryType("10");
		}
		model.addAttribute("viewDetail", res);

		// 카테고리 상품목록
		List<CustomCmmCodeVO> cateList = cmmCodeService.getCmmCode("CATALOG_CATEGORY");
		model.addAttribute("cateList", cateList);

		int totalCnt = mngCatalogDao.listTot(req).size();
		model.addAttribute("totalCnt", totalCnt);

		return "mng/bss/catalog/catalogViewDetailUp";
	}


	/**
	 * 상품 상세 불러오기
	 */
	@RequestMapping(value = "/productView", method = RequestMethod.POST)
	public ResponseEntity<Object> mngBbsNoticeDetail(CustomBssCatalogVO req) {
		log.debug("productDetail 상제 불러오기");
		log.debug("=== mngBbsNoticeDetail Controller ===");

		CustomBssCatalogVO res = mngCatalogService.productView(req);

		log.debug("res.getDisplayFlag() 상제 불러오기"+res.getDisplayFlag());

			if(res.getDisplayFlag().equals("Y")){
				res.setDisplayFlagName("표시");
			}if(res.getDisplayFlag().equals("N")){
				res.setDisplayFlagName("미표시");

			}if(res.getRecommandFlag().equals("Y")){
				res.setRecommandFlagName("추천");

			}if(res.getRecommandFlag().equals("N")){
				res.setRecommandFlagName("미추천");
			}

			log.debug("추천여부 넘어오는 값"+res.getRecommandFlagName());

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	/**
	 * osos
	 */
	@RequestMapping(value = "/osView", method = RequestMethod.POST)
	public ResponseEntity<Object> mngOs(CustomBssCatalogVO req) {
		log.debug("productDetail 상제 불러오기");
		CustomBssCatalogVO res = new CustomBssCatalogVO();
		log.debug("=== mngOs Controller ===");
/*		if(req.getCatalogCategory().equals("CATACATE_OS")){
			res = mngCatalogService.osView(req);
		}else if(req.getCatalogCategory().equals("CATACATE_DISK")){
			res = mngCatalogService.osView(req);
		}*/

		res = mngCatalogService.osView(req);
		if(res == null){
			return new ResponseEntity<Object>(HttpStatus.NO_CONTENT);
		}

		if(res.getDisplayFlag().equals("Y")){
			res.setDisplayFlagName("표시");
		}else{
			res.setDisplayFlagName("미표시");
		}

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
/*	*//**
	 * OS 상세 불러오기
	 *//*
	@RequestMapping(value = "/osView", method = RequestMethod.POST)
	public ResponseEntity<Object> mngOsView(CustomMngCatalogVO req) {
		log.debug("osDetail 상제 불러오기");
		CustomMngCatalogVO res = mngCatalogService.osView(req);

		if(res.getDisplayFlag().equals("Y")){
			res.setDisplayFlagName("표시");
		}else{
			res.setDisplayFlagName("미표시");
		}

		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}	*/
	/**
	 * 가상서버 상세 수정
	 */
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public ResponseEntity<String> mngBbsNoticeUpdate(CustomBssCatalogVO req) {
		String res = "";
		//req_project 에서  apprv_state , del_flag 수정
		res = mngCatalogService.update(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
	/**
	 * 가상서버 상세 수정
	 */
	@RequestMapping(value="/osUpdate", method=RequestMethod.POST)
	public ResponseEntity<String> mngOsUpdate(CustomBssCatalogVO req) {
		String res = "";
		res = mngCatalogService.osUpdate(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	/**
	 * 카탈로그 상품별 삭제값 변경
	 */
	@RequestMapping(value="/productDelchk", method=RequestMethod.POST)
	public ResponseEntity<String> productDelchk(CustomBssCatalogVO req) {
		String res = "";
		res = mngCatalogService.productDelchk(req);
		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	/**
	 * 가상서버 등록
	 */
	@RequestMapping(value="/productInsert", method=RequestMethod.POST)
	public ResponseEntity<String> mngProductInsert(CustomBssCatalogVO req, Principal principal) {
		String res = "";
		String catalogCategory ="CATACATE_VM";

		req.setRegUserId(principal.getName());
		req.setCatalogCategory(catalogCategory);
		//기존 정렬값 수정
		String updatechk = mngCatalogService.productDisplayUpdate(req);
		log.debug("update check : " + updatechk);
		//신규가상서버 등록
		res = mngCatalogService.productInsert(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	/**
	 * os 등록
	 */
	@RequestMapping(value="/osInsert", method=RequestMethod.POST)
	public ResponseEntity<String> mngOsInsert(CustomBssCatalogVO req, Principal principal) {
		String res = "";

		String catalogCategory ="CATACATE_OS";

		req.setRegUserId(principal.getName());
		req.setCatalogCategory(catalogCategory);
		//기존 정렬값 수정
		String updatechk = mngCatalogService.productDisplayUpdate(req);
		log.debug("update check : " + updatechk);
		res = mngCatalogService.osInsert(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	/**
	 * App 등록
	 */
	@RequestMapping(value="/appInsert", method=RequestMethod.POST)
	public ResponseEntity<String> mngAppInsert(CustomBssCatalogVO req, Principal principal) {
		String res = "";

		String catalogCategory ="CATACATE_APP";

		req.setRegUserId(principal.getName());
		req.setCatalogCategory(catalogCategory);
		//기존 정렬값 수정
		String updatechk = mngCatalogService.productDisplayUpdate(req);
		log.debug("update check : " + updatechk);
		res = mngCatalogService.appInsert(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	/**
	 *디스크 등록
	 */
	@RequestMapping(value="/diskInsert", method=RequestMethod.POST)
	public ResponseEntity<String> diskInsert(CustomBssCatalogVO req, Principal principal) {
		String res = "";
		String catalogCategory ="CATACATE_DISK";

		req.setRegUserId(principal.getName());
		req.setCatalogCategory(catalogCategory);

		//기존 정렬값 수정
		String updatechk = mngCatalogService.productDisplayUpdate(req);
		log.debug("update check : " + updatechk);
		res = mngCatalogService.diskInsert(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	/**
	 * nas 등록
	 */
	@RequestMapping(value="/nasInsert", method=RequestMethod.POST)
	public ResponseEntity<String> nasInsert(CustomBssCatalogVO req, Principal principal) {
		String res = "";
		String catalogCategory ="CATACATE_NAS";

		req.setRegUserId(principal.getName());
		req.setCatalogCategory(catalogCategory);

		//기존 정렬값 수정
		String updatechk = mngCatalogService.productDisplayUpdate(req);
		log.debug("update check : " + updatechk);
		res = mngCatalogService.nasInsert(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	/**
	 * ip 등록
	 */
	@RequestMapping(value="/ipInsert", method=RequestMethod.POST)
	public ResponseEntity<String> ipInsert(CustomBssCatalogVO req, Principal principal) {
		String res = "";
		String catalogCategory ="CATACATE_PUBLICIP";

		req.setRegUserId(principal.getName());
		req.setCatalogCategory(catalogCategory);

		//기존 정렬값 수정
		String updatechk = mngCatalogService.productDisplayUpdate(req);
		log.debug("update check : " + updatechk);
		res = mngCatalogService.ipInsert(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}


	/**
	 * lb 등록
	 */
	@RequestMapping(value="/envInsert", method=RequestMethod.POST)
	public ResponseEntity<String> envInsert(CustomBssCatalogVO req, Principal principal) {
		String res = "";
		String catalogCategory ="CATACATE_ENV";

		req.setRegUserId(principal.getName());
		req.setCatalogCategory(catalogCategory);

		//기존 정렬값 수정
		String updatechk = mngCatalogService.productDisplayUpdate(req);
		log.debug("update check : " + updatechk);
		res = mngCatalogService.envInsert(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	/**
	 * lb 등록
	 */
	@RequestMapping(value="/lbInsert", method=RequestMethod.POST)
	public ResponseEntity<String> lbInsert(CustomBssCatalogVO req, Principal principal) {
		String res = "";
		String catalogCategory ="CATACATE_LOADBALANCER";

		req.setRegUserId(principal.getName());
		req.setCatalogCategory(catalogCategory);

		//기존 정렬값 수정
		String updatechk = mngCatalogService.productDisplayUpdate(req);
		log.debug("update check : " + updatechk);
		res = mngCatalogService.lbInsert(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

//	@RequestMapping(value="/scmInsert", method=RequestMethod.POST)
//	public ResponseEntity<String> scmInsert(CustomBssCatalogVO req, Principal principal) {
//		String res = "";
//		String catalogCategory ="CATACATE_SCM";
//
//		req.setRegUserId(principal.getName());
//		req.setCatalogCategory(catalogCategory);
//
//		//기존 정렬값 수정
//		String updatechk = mngCatalogService.productDisplayUpdate(req);
//		log.debug("update check : " + updatechk);
//		res = mngCatalogService.scmInsert(req);
//
//		return new ResponseEntity<String>(res, HttpStatus.OK);
//	}

//	@RequestMapping(value="/bkInsert", method=RequestMethod.POST)
//	public ResponseEntity<String> bkInsert(CustomBssCatalogVO req, Principal principal) {
//		String res = "";
//		String catalogCategory ="CATACATE_BACKUP";
//
//		req.setRegUserId(principal.getName());
//		req.setCatalogCategory(catalogCategory);
//
//		//기존 정렬값 수정
//		String updatechk = mngCatalogService.productDisplayUpdate(req);
//		log.debug("update check : " + updatechk);
//		res = mngCatalogService.bkInsert(req);
//
//		return new ResponseEntity<String>(res, HttpStatus.OK);
//	}


	/**
	 * 상품 서비스 등록
	 */
	@RequestMapping(value="/serviceInsert", method=RequestMethod.POST)
	public ResponseEntity<String> serviceInsert(CustomBssCatalogVO req, Principal principal) {
		String res = "";
		String catalogCategory ="CATACATE_SERVICE";

		req.setRegUserId(principal.getName());
		req.setCatalogCategory(catalogCategory);

		//기존 정렬값 수정
		String updatechk = mngCatalogService.productDisplayUpdate(req);
		log.debug("update check : " + updatechk);
		res = mngCatalogService.serviceInsert(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

//	@RequestMapping(value="/serInsert", method=RequestMethod.POST)
//	public ResponseEntity<String> serInsert(CustomBssCatalogVO req, Principal principal) {
//		String res = "";
//		String catalogCategory ="CATACATE_SECURITY";
//
//		req.setRegUserId(principal.getName());
//		req.setCatalogCategory(catalogCategory);
//
//		//기존 정렬값 수정
//		String updatechk = mngCatalogService.productDisplayUpdate(req);
//		log.debug("update check : " + updatechk);
//		res = mngCatalogService.serInsert(req);
//
//		return new ResponseEntity<String>(res, HttpStatus.OK);
//	}

//	@RequestMapping(value="/mcaInsert", method=RequestMethod.POST)
//	public ResponseEntity<String> mcaInsert(CustomBssCatalogVO req, Principal principal) {
//		String res = "";
//		String catalogCategory ="CATACATE_MCA";
//
//		req.setRegUserId(principal.getName());
//		req.setCatalogCategory(catalogCategory);
//
//		//기존 정렬값 수정
//		String updatechk = mngCatalogService.productDisplayUpdate(req);
//		log.debug("update check : " + updatechk);
//		res = mngCatalogService.mcaInsert(req);
//
//		return new ResponseEntity<String>(res, HttpStatus.OK);
//	}
	/**
	 * 가상서버 팝업
	 */
	@RequestMapping(value = "/productPopList", method={RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<Object> productPopList(CustomBssCatalogVO req){

		log.debug("CatalogSeq : " + req.getCatalogSeq());
		log.debug("CatalogCategory : " + req.getCatalogCategory());
		log.debug("CloudId : " + req.getCloudId());

		String cataCate = req.getCatalogCategory();
		HashMap<String, Object> map = new HashMap<>();

		if(cataCate.equals("CATACATE_VM")){
			List<CustomBssCatalogVO> res = mngCatalogService.productPopList(req);
			map.put("productPopList", res);
		}else if(cataCate.equals("CATACATE_DISK")){
			List<CustomBssCatalogVO> res = mngCatalogService.diskPopList(req);
			map.put("productPopList", res);
		}else if(cataCate.equals("CATACATE_SERVICE")){
			List<CustomBssCatalogVO> res = mngCatalogService.servicePopList(req);
			map.put("productPopList", res);
		}else if(cataCate.equals("CATACATE_NAS")){
			List<CustomBssCatalogVO> res = mngCatalogService.nasPopList(req);
			map.put("productPopList", res);
		}else if(cataCate.equals("CATACATE_PUBLICIP")){
			List<CustomBssCatalogVO> res = mngCatalogService.ipPopList(req);
			map.put("productPopList", res);
		}else if(cataCate.equals("CATACATE_LOADBALANCER")){
			List<CustomBssCatalogVO> res = mngCatalogService.lbPopList(req);
			map.put("productPopList", res);
		}else if(cataCate.equals("CATACATE_ENV")){
				List<CustomBssCatalogVO> res = mngCatalogService.envPopList(req);
				map.put("productPopList", res);
		}else if(cataCate.equals("CATACATE_OS")){
			List<CustomBssCatalogVO> res = mngCatalogService.osPopList(req);
			map.put("productPopList", res);
		}else if(cataCate.equals("CATACATE_APP")) {
			List<CustomBssCatalogVO> res = mngCatalogService.templatePopList(req);
			map.put("productPopList", res);
		}

//		else if(cataCate.equals("CATACATE_BACKUP")){
//			List<CustomBssCatalogVO> res = mngCatalogService.bkPopList(req);
//			map.put("productPopList", res);
//		}else if(cataCate.equals("CATACATE_SCM")){
//			List<CustomBssCatalogVO> res = mngCatalogService.scmPopList(req);
//			map.put("productPopList", res);
//		}else if(cataCate.equals("CATACATE_MCA")){
//			List<CustomBssCatalogVO> res = mngCatalogService.mcaPopList(req);
//			map.put("productPopList", res);
//		}else if(cataCate.equals("CATACATE_SECURITY")){
//			List<CustomBssCatalogVO> res = mngCatalogService.serPopList(req);
//			map.put("productPopList", res);
//		}

		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	/**
	 * os 팝업
	 */
	@RequestMapping(value = "/osPopList", method={RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<Object> osPopList(CustomBssCatalogVO req){

		log.debug("req.getCatalogSeq() : " + req.getCatalogSeq());

		List<CustomBssCatalogVO> res = mngCatalogService.osPopList(req);

		HashMap<String, Object> map = new HashMap<>();
		map.put("osPopList", res);
		log.debug("osPopList : " + res.size());
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	@RequestMapping(value = "/diskPopList", method={RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<Object> diskPopList(CustomBssCatalogVO req){

		log.debug("req.getCatalogSeq() : " + req.getCatalogSeq());

		List<CustomBssCatalogVO> res = mngCatalogService.diskPopList(req);

		HashMap<String, Object> map = new HashMap<>();
		map.put("diskPopList", res);
		log.debug("diskPopList : " + res.size());
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	@RequestMapping(value = "/nasPopList", method={RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<Object> nasPopList(CustomBssCatalogVO req){

		log.debug("req.getCatalogSeq() : " + req.getCatalogSeq());

		List<CustomBssCatalogVO> res = mngCatalogService.nasPopList(req);

		HashMap<String, Object> map = new HashMap<>();
		map.put("nasPopList", res);
		log.debug("nasPopList : " + res.size());
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	@RequestMapping(value = "/ipPopList", method={RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<Object> ipPopList(CustomBssCatalogVO req){

		log.debug("req.getCatalogSeq() : " + req.getCatalogSeq());

		List<CustomBssCatalogVO> res = mngCatalogService.ipPopList(req);

		HashMap<String, Object> map = new HashMap<>();
		map.put("ipPopList", res);
		log.debug("ipPopList : " + res.size());
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

	@RequestMapping(value = "/lbPopList", method={RequestMethod.GET,RequestMethod.POST})
	public ResponseEntity<Object> lbPopList(CustomBssCatalogVO req){

		log.debug("req.getCatalogSeq() : " + req.getCatalogSeq());

		List<CustomBssCatalogVO> res = mngCatalogService.lbPopList(req);

		HashMap<String, Object> map = new HashMap<>();
		map.put("lbPopList", res);
		log.debug("lbPopList : " + res.size());
		return new ResponseEntity<Object>(map, HttpStatus.OK);
	}

//	@RequestMapping(value = "/scmPopList", method={RequestMethod.GET,RequestMethod.POST})
//	public ResponseEntity<Object> scmPopList(CustomBssCatalogVO req){
//
//		log.debug("req.getCatalogSeq() : " + req.getCatalogSeq());
//
//		List<CustomBssCatalogVO> res = mngCatalogService.scmPopList(req);
//
//		HashMap<String, Object> map = new HashMap<>();
//		map.put("scmPopList", res);
//		log.debug("scmPopList : " + res.size());
//		return new ResponseEntity<Object>(map, HttpStatus.OK);
//	}

//	@RequestMapping(value = "/bkPopList", method={RequestMethod.GET,RequestMethod.POST})
//	public ResponseEntity<Object> bkPopList(CustomBssCatalogVO req){
//
//		log.debug("req.getCatalogSeq() : " + req.getCatalogSeq());
//
//		List<CustomBssCatalogVO> res = mngCatalogService.bkPopList(req);
//
//		HashMap<String, Object> map = new HashMap<>();
//		map.put("bkPopList", res);
//		log.debug("bkPopList : " + res.size());
//		return new ResponseEntity<Object>(map, HttpStatus.OK);
//	}

//	@RequestMapping(value = "/serPopList", method={RequestMethod.GET,RequestMethod.POST})
//	public ResponseEntity<Object> serPopList(CustomBssCatalogVO req){
//
//		log.debug("req.getCatalogSeq() : " + req.getCatalogSeq());
//
//		List<CustomBssCatalogVO> res = mngCatalogService.serPopList(req);
//
//		HashMap<String, Object> map = new HashMap<>();
//		map.put("serPopList", res);
//		log.debug("serPopList : " + res.size());
//		return new ResponseEntity<Object>(map, HttpStatus.OK);
//	}

//	@RequestMapping(value = "/mcaPopList", method={RequestMethod.GET,RequestMethod.POST})
//	public ResponseEntity<Object> mcaPopList(CustomBssCatalogVO req){
//
//		log.debug("req.getCatalogSeq() : " + req.getCatalogSeq());
//
//		List<CustomBssCatalogVO> res = mngCatalogService.mcaPopList(req);
//
//		HashMap<String, Object> map = new HashMap<>();
//		map.put("mcaPopList", res);
//		log.debug("mcaPopList : " + res.size());
//		return new ResponseEntity<Object>(map, HttpStatus.OK);
//	}

	/**
	 * 카탈로그 리스트 상품 상세
	 */
	@RequestMapping(value="/viewDetail")
	public String mngReqProjectviewDetail(Model model) {
		return "mng/bss/catalog/catalogViewDetail";
	}

	/**
	 * 카탈로그 리스트 상품 수정
	 */
	@RequestMapping(value="/viewDetailUpdate")
	public String mngReqProjectviewDetailUp(Model model) {
		return "mng/bss/catalog/catalogViewDetailUp";
	}


//	@RequestMapping(value="/catalogInsert", method=RequestMethod.POST)
//	public ResponseEntity<Object> mngCatalogInsert(HttpServletRequest request,HttpServletResponse response,CustomMngCatalogVO req) throws IOException {
//		String res = "";
//		CustomMngCatalogVO catalogvo = new CustomMngCatalogVO();
//		List<CustomMngCatalogVO> getOldCataloginfo = null;
//
//		if(req.getCatalogSeq()!=null){
//			String catalogSeq =req.getCatalogSeq();
//			getOldCataloginfo = mngCatalogService.getCopyCataloginfo(catalogSeq);
//		}else{
//			String applyDate =req.getApplyDate();
//			getOldCataloginfo = mngCatalogService.getOldCataloginfo(applyDate);
//			log.debug("getOldCataloginfo : " + getOldCataloginfo);
//		}
//
//		Date requestSeqdate = new Date();
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
//		String catalogSeq = dateFormat.format(requestSeqdate);
//
//		MngSession mngDetails = (MngSession)SecurityContextHolder.getContext().getAuthentication().getDetails();
//		req.setRegUserId(principal.getName());
//		req.setCatalogSeq(catalogSeq);
//
//		//겹치는 날짜 카탈로그 있는지 확인
//		log.debug("getCatalogCnt : " + req.getApplyDate());
//		int getCatalogCnt = mngCatalogService.getCatalogCnt(req);
//			log.debug("getCatalogCnt : " + getCatalogCnt);
//			if(getCatalogCnt==0){
//				//카탈로그 등록
//				String resCatalog = mngCatalogService.setCatalog(req);
//
//				for(int i=0;i<getOldCataloginfo.size();i++){
//
//					CustomMngCatalogVO setCatalogProductVo = new CustomMngCatalogVO();
//					setCatalogProductVo.setCatalogSeq(catalogSeq);
//					setCatalogProductVo.setProductSeq(getOldCataloginfo.get(i).getProductSeq());
//					setCatalogProductVo.setDisplayName(getOldCataloginfo.get(i).getDisplayName());
//					setCatalogProductVo.setImagePath(getOldCataloginfo.get(i).getImagePath());
//					setCatalogProductVo.setDescription(getOldCataloginfo.get(i).getDescription());
//					setCatalogProductVo.setDescriptionTop(getOldCataloginfo.get(i).getDescriptionTop());
//					setCatalogProductVo.setDescriptionList(getOldCataloginfo.get(i).getDescriptionList());
//					setCatalogProductVo.setHotBadge(getOldCataloginfo.get(i).getHotBadge());
//					setCatalogProductVo.setDisplayOrder(getOldCataloginfo.get(i).getDisplayOrder());
//					setCatalogProductVo.setCatalogCategory(getOldCataloginfo.get(i).getCatalogCategory());
//					setCatalogProductVo.setDisplayFlag(getOldCataloginfo.get(i).getDisplayFlag());
//					setCatalogProductVo.setRegDatetime(getOldCataloginfo.get(i).getRegDatetime());
//					setCatalogProductVo.setRegUserId(getOldCataloginfo.get(i).getRegUserId());
//					setCatalogProductVo.setModDatetime(getOldCataloginfo.get(i).getModDatetime());
//					setCatalogProductVo.setModUserId(getOldCataloginfo.get(i).getModUserId());
//					setCatalogProductVo.setRecommandFlag(getOldCataloginfo.get(i).getRecommandFlag());
//					setCatalogProductVo.setBasicProductFlag(getOldCataloginfo.get(i).getBasicProductFlag());
//
//					//카탈로그 프로덕트에 등록
//					String setCatalogProduct = mngCatalogService.setCatalogProduct(setCatalogProductVo);
//
//					// 이미지 복사
//					CustomCmmFileVO vo = new CustomCmmFileVO();
//					vo.setProgramName(getOldCataloginfo.get(i).getCatalogSeq());
//					vo.setProgramSeq(getOldCataloginfo.get(i).getProductSeq());
//				}
//				res = "1";
//			}else{
//				res = "0";
//			}
//			return new ResponseEntity<Object>(res, HttpStatus.OK);
//		}
}
