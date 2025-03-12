package com.ivucenter.cloud.portal.excel;

import java.net.URLEncoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;

import com.ivucenter.cloud.portal.cmm.company.CustomCmmCompanyVO;
import com.ivucenter.cloud.portal.operation.adminuser.CustomAdminUserVO;
import com.ivucenter.cloud.portal.oss.network.CustomOssNetworkVO;

public class OperationExcelView extends AbstractXlsView{

	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> modelMap, Workbook workbook, HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		
		String excelGbn = (String) modelMap.get("excel_gbn");
		String excelTitle = (String) modelMap.get("excel_title");
		
		//엑셀 파일명 설정
		String fileName = excelTitle+DateFormatUtils.format(new Date(), "_yyyyMMdd_HHmmss");
		
		String userAgent = req.getHeader("User-Agent");
		// 사용자의 브라우저 정보에 따라 파일명의 인코딩 여부를 결정함 IE11이상은 MSIE에 대한 값이 변경되어 해당 부분 수정 (2019.12.12 장중일)
		if (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("rv") > -1) {
			// IE일 경우 
			fileName = URLEncoder.encode(fileName, "utf-8");
		} else {
			// 크롬, 사파리 등
			fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1"); 
		}
		
		res.setHeader("Content-disposition", "attachment; filename="+fileName+".xls");
		res.setHeader("Content-Transfer-Encoding", "binary");
		
		if(excelGbn.equals("cmmCompany")){
			excelCmmCompany(workbook, (List<CustomCmmCompanyVO>) modelMap.get("excel_list"), excelTitle);
		}else if(excelGbn.equals("cmmNetwork")){
			excelCmmNetwork(workbook, (List<CustomOssNetworkVO>) modelMap.get("excel_list"), excelTitle);
		}else if(excelGbn.equals("cmmNetworkDetail")){
			excelCmmNetworkDetail(workbook, (List<CustomOssNetworkVO>) modelMap.get("excel_list"), excelTitle);
		}else if(excelGbn.equals("adminUser")){
			excelAdminUser(workbook, (List<CustomAdminUserVO>) modelMap.get("excel_list"), excelTitle);
		}
		res.setContentType("Application/Msexcel");
	}
	
	private void excelAdminUser(Workbook workbook, List<CustomAdminUserVO> list, String excelTitle) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, excelTitle);
		
		//header
		int rowIndex = 1;
	
		Row rowHead = sheet.createRow(rowIndex++);
		CellStyle styleHeader = workbook.createCellStyle();		// 헤더스타일 객체 생성
		CellStyle styleHeader2 = workbook.createCellStyle();		// 헤더스타일 객체 생성
		CellStyle styleBody = workbook.createCellStyle();		// 본문스타일 객체 생성
		CellStyle styleBody2 = workbook.createCellStyle();		// 본문스타일 객체 생성
		
		styleHeader.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
		styleHeader.setVerticalAlignment(CellStyle.VERTICAL_CENTER);					//정렬
		styleHeader.setFillPattern(CellStyle.SOLID_FOREGROUND);				//셀 색채우기
		styleHeader.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);	//셀 색채우기
		styleHeader.setBorderLeft(CellStyle.BORDER_THIN);
		styleHeader.setBorderRight(CellStyle.BORDER_THIN);
		styleHeader.setBorderTop(CellStyle.BORDER_MEDIUM);
		styleHeader.setBorderBottom(CellStyle.BORDER_THIN);
		
		styleHeader2.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
		styleHeader2.setVerticalAlignment(CellStyle.VERTICAL_CENTER);					//정렬
		styleHeader2.setFillPattern(CellStyle.SOLID_FOREGROUND);				//셀 색채우기
		styleHeader2.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);	//셀 색채우기
		styleHeader2.setBorderLeft(CellStyle.BORDER_THIN);
		styleHeader2.setBorderRight(CellStyle.BORDER_THIN);
		styleHeader2.setBorderTop(CellStyle.BORDER_THIN);
		styleHeader2.setBorderBottom(CellStyle.BORDER_MEDIUM);
		
		styleBody.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
		styleBody.setBorderLeft(CellStyle.BORDER_THIN);
		styleBody.setBorderRight(CellStyle.BORDER_THIN);
		styleBody.setBorderTop(CellStyle.BORDER_THIN);
		styleBody.setBorderBottom(CellStyle.BORDER_THIN);
		
		styleBody2.setAlignment(CellStyle.ALIGN_RIGHT);					//정렬
		styleBody2.setBorderLeft(CellStyle.BORDER_THIN);
		styleBody2.setBorderRight(CellStyle.BORDER_THIN);
		styleBody2.setBorderTop(CellStyle.BORDER_THIN);
		styleBody2.setBorderBottom(CellStyle.BORDER_THIN);
		
		for(int i=1; i <= 8; i++){
			sheet.setColumnWidth(i, 5000);
		}
		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("회원사");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("소속조직(부서)");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("ID");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("이름");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("작업담당");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("회원가입승인");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("한전결재라인");
		headCell7.setCellStyle(styleHeader);
		Cell headCell8 = rowHead.createCell(8);
		headCell8.setCellValue("결재전결");
		headCell8.setCellStyle(styleHeader);

		for(CustomAdminUserVO vo : list){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getCustomerName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getDeptName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getUserId());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getUserName());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			if(vo.getOperation().equals("Y")) {
				bodyCell5.setCellValue("✔");
			} else {
				bodyCell5.setCellValue("-");
			}
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			if(vo.getLogin().equals("Y")) {
				bodyCell6.setCellValue("✔");
			} else {
				bodyCell6.setCellValue("-");
			}
			bodyCell6.setCellStyle(styleBody);
			Cell bodyCell7 = rowBody.createCell(7);
			if(vo.getWF4000A0().equals("Y")) {
				bodyCell7.setCellValue("✔");
			} else {
				bodyCell7.setCellValue("-");
			}
			bodyCell7.setCellStyle(styleBody);
			Cell bodyCell8 = rowBody.createCell(8);
			if(vo.getApprvPass().equals("Y")) {
				bodyCell8.setCellValue("✔");
			} else {
				bodyCell8.setCellValue("-");
			}
			bodyCell8.setCellStyle(styleBody);
		}
	}

	private void excelCmmNetwork(Workbook workbook, List<CustomOssNetworkVO> list, String excelTitle) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, excelTitle);
		
		//header
		int rowIndex = 1;
	
		Row rowHead = sheet.createRow(rowIndex++);
		CellStyle styleHeader = workbook.createCellStyle();		// 헤더스타일 객체 생성
		CellStyle styleBody = workbook.createCellStyle();		// 본문스타일 객체 생성
		CellStyle styleBody2 = workbook.createCellStyle();		// 본문스타일 객체 생성
		
		styleHeader.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
		styleHeader.setFillPattern(CellStyle.SOLID_FOREGROUND);				//셀 색채우기
		styleHeader.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);	//셀 색채우기
		styleHeader.setBorderLeft(CellStyle.BORDER_THIN);
		styleHeader.setBorderRight(CellStyle.BORDER_THIN);
		styleHeader.setBorderTop(CellStyle.BORDER_MEDIUM);
		styleHeader.setBorderBottom(CellStyle.BORDER_MEDIUM);
		
		styleBody.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
		styleBody.setBorderLeft(CellStyle.BORDER_THIN);
		styleBody.setBorderRight(CellStyle.BORDER_THIN);
		styleBody.setBorderTop(CellStyle.BORDER_THIN);
		styleBody.setBorderBottom(CellStyle.BORDER_THIN);
		
		styleBody2.setAlignment(CellStyle.ALIGN_RIGHT);					//정렬
		styleBody2.setBorderLeft(CellStyle.BORDER_THIN);
		styleBody2.setBorderRight(CellStyle.BORDER_THIN);
		styleBody2.setBorderTop(CellStyle.BORDER_THIN);
		styleBody2.setBorderBottom(CellStyle.BORDER_THIN);
		
		for(int i=1; i <= 7; i++){
			sheet.setColumnWidth(i, 5000);
		}
		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("클라우드");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("네트워크ID");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("네트워크명");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("네트워크 별칭");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("서브넷명");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("서브넷 주소");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("할당된IP");
		headCell7.setCellStyle(styleHeader);
		
		for(CustomOssNetworkVO vo : list){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getCloudName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getNetworkId());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getNetworkName());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getNetworkAlias());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getSubnetName());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getSubnetCidr());
			bodyCell6.setCellStyle(styleBody);
			Cell bodyCell7 = rowBody.createCell(7);
			bodyCell7.setCellValue(vo.getPortCnt());
			bodyCell7.setCellStyle(styleBody);
			
		}
	}
	
	private void excelCmmNetworkDetail(Workbook workbook, List<CustomOssNetworkVO> list, String excelTitle) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, excelTitle);
		
		//header
		int rowIndex = 1;
	
		Row rowHead = sheet.createRow(rowIndex++);
		CellStyle styleHeader = workbook.createCellStyle();		// 헤더스타일 객체 생성
		CellStyle styleBody = workbook.createCellStyle();		// 본문스타일 객체 생성
		CellStyle styleBody2 = workbook.createCellStyle();		// 본문스타일 객체 생성
		
		styleHeader.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
		styleHeader.setFillPattern(CellStyle.SOLID_FOREGROUND);				//셀 색채우기
		styleHeader.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);	//셀 색채우기
		styleHeader.setBorderLeft(CellStyle.BORDER_THIN);
		styleHeader.setBorderRight(CellStyle.BORDER_THIN);
		styleHeader.setBorderTop(CellStyle.BORDER_MEDIUM);
		styleHeader.setBorderBottom(CellStyle.BORDER_MEDIUM);
		
		styleBody.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
		styleBody.setBorderLeft(CellStyle.BORDER_THIN);
		styleBody.setBorderRight(CellStyle.BORDER_THIN);
		styleBody.setBorderTop(CellStyle.BORDER_THIN);
		styleBody.setBorderBottom(CellStyle.BORDER_THIN);
		
		styleBody2.setAlignment(CellStyle.ALIGN_RIGHT);					//정렬
		styleBody2.setBorderLeft(CellStyle.BORDER_THIN);
		styleBody2.setBorderRight(CellStyle.BORDER_THIN);
		styleBody2.setBorderTop(CellStyle.BORDER_THIN);
		styleBody2.setBorderBottom(CellStyle.BORDER_THIN);
		
		for(int i=1; i <= 8; i++){
			sheet.setColumnWidth(i, 5000);
		}
		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("VIP주소");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("IP주소");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("MAC주소");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("프로젝트명");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("호스트명");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("서버명");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("상태");
		headCell7.setCellStyle(styleHeader);
		
		for(CustomOssNetworkVO vo : list){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getVirtualIps());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getFixedIps());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getMacAddress());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getProjectAlias());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getHostName());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getHostNameAlias());
			bodyCell6.setCellStyle(styleBody);
			Cell bodyCell7 = rowBody.createCell(7);
			bodyCell7.setCellValue(vo.getStatus());
			bodyCell7.setCellStyle(styleBody);
		}
	}
	

	private void excelCmmCompany(Workbook workbook, List<CustomCmmCompanyVO> list, String excelTitle) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, excelTitle);
		
		//header
		int rowIndex = 1;
	
		Row rowHead = sheet.createRow(rowIndex++);
		CellStyle styleHeader = workbook.createCellStyle();		// 헤더스타일 객체 생성
		CellStyle styleBody = workbook.createCellStyle();		// 본문스타일 객체 생성
		CellStyle styleBody2 = workbook.createCellStyle();		// 본문스타일 객체 생성
		
		styleHeader.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
		styleHeader.setFillPattern(CellStyle.SOLID_FOREGROUND);				//셀 색채우기
		styleHeader.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);	//셀 색채우기
		styleHeader.setBorderLeft(CellStyle.BORDER_THIN);
		styleHeader.setBorderRight(CellStyle.BORDER_THIN);
		styleHeader.setBorderTop(CellStyle.BORDER_MEDIUM);
		styleHeader.setBorderBottom(CellStyle.BORDER_MEDIUM);
		
		styleBody.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
		styleBody.setBorderLeft(CellStyle.BORDER_THIN);
		styleBody.setBorderRight(CellStyle.BORDER_THIN);
		styleBody.setBorderTop(CellStyle.BORDER_THIN);
		styleBody.setBorderBottom(CellStyle.BORDER_THIN);
		
		styleBody2.setAlignment(CellStyle.ALIGN_RIGHT);					//정렬
		styleBody2.setBorderLeft(CellStyle.BORDER_THIN);
		styleBody2.setBorderRight(CellStyle.BORDER_THIN);
		styleBody2.setBorderTop(CellStyle.BORDER_THIN);
		styleBody2.setBorderBottom(CellStyle.BORDER_THIN);
		
		for(int i=1; i <= 6; i++){
			sheet.setColumnWidth(i, 5000);
		}
		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("구분");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("구분ID");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("계열사명");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("계열사ID");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("등록일시");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("등록자");
		headCell6.setCellStyle(styleHeader);
		
		for(CustomCmmCompanyVO vo : list){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getCompanyName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getCompanyId());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getCustomerName());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getCustomerId());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getRegDatetime());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getRegUserId());
			bodyCell6.setCellStyle(styleBody);			
		}
	}
}
