<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<meta content="" name="description" />
		<meta content="" name="author" />
		<c:import url="${contextPath}/WEB-INF/views/home/include/home_import.jsp" charEncoding="UTF-8"></c:import>
		<title>KEPCO Cloud Service Platform</title>
		
		<style>
			.table_p {width:95%; margin-left:30px;}
			.table_p thead tr th {
				border-right:1px solid #d9e5f9; 
				border-top:2px solid #0068B6 !important; 
				border-bottom:2px solid #0068B6 !important; 
				background:#f3f6f7;
				font-weight:bold;
				padding:12px 6px;
				text-align:center !important;
				vertical-align:middle;
				}
			.table_p thead tr th:last-child {border-right:none;}
			.table_p tbody tr td {
				border-right:1px solid #e5e5e5; 
				border-bottom:1px solid #e5e5e5; 
				padding:10px 8px;
				text-align:center;
				vertical-align:middle;
				}
			.table_p tbody tr:last-child td {border-bottom:1px solid #c5c5c5;}
			.table_p tbody tr td:last-child {border-right:none;}
		</style>
	</head>
	<body>
		<div id="container">
		<!-- top menu start -->
		<c:import url="${contextPath}/WEB-INF/views/home/include/home_top.jsp" charEncoding="UTF-8"></c:import>	
		<!-- top menu end -->
	  	
	  	<div class="simg"></div>
	 	<div class="sub mb30">
			<h3 class="subtitle"><i class="fa fa-cloud f18"></i>  개인정보처리방침</h3>
			<p class="p1010022 wbka">
				① 개인정보란 생존하는 개인에 관한 정보로서 당해 정보에 포함되어 있는 성명, 주민등록번호 등의 사항에 의하여 당해 개인을 식별할 수 있는 정보(당해 정보만으로는 특정 개인을 식별할 수 없더라도 다른 정보와 용이하게 결합하여 식별할 수 있는 것을 포함)를 말합니다.<br/>
				② 한국전력공사에서 운영하는 K-cloud(이하 ‘본 홈페이지)는 사용자의 개인정보보호를 매우 중요시하며,『개인정보보호법』및 『표준개인정보보호지침』을 준수하고 있습니다. 본 홈페이지는 개인정보처리방침을 통하여 사용자께서 제공하시는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.<br/>
				③ 본 홈페이지는 개인정보처리방침을 홈페이지 첫 화면에 공개함으로써 사용자께서 언제나 용이하게 보실 수 있도록 조치하고 있습니다.<br/>
				④ 본 홈페이지는 개인정보처리방침의 지속적인 개선을 위하여 개인정보처리방침을 개정하는데 필요한 절차를 정하고 있습니다. 그리고 개인정보처리방침을 개정하는 경우 버전번호 등을 부여하여 개정된 사항을 귀하께서 쉽게 알아볼 수 있도록 하고 있습니다.<br/>
		  	</p>
		  	
		  	<section class="policy">
				<h5 class="bgee p10">제1조 개인정보의 처리 목적</h5>
				<p>
					① 공사의 본 홈페이지는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.
					<table class="table_p"> 
						<colgroup>
							<col width="15%"/>
							<col width="15%"/>
							<col width="*"/>
						</colgroup>
						<thead>
							<tr>
									<th>개인정보파일명</th>
									<th>처리목적</th>
									<th>세부내용</th>
							</tr>
						</thead>
						
						<tbody>
							<tr>
								<td>회원정보</td>
								<td>홈페이지 회원 가입 및 관리</td>
								<td>회원 가입의사 확인, 회원제 서비스 제공에 따른 본인식별 인증, 회원자격 유지 관리 등을 목적으로 개인정보를 처리합니다.</td>
							</tr>
						</tbody>
					</table>
				</p>
	
			 	<h5 class="bgee p10"> 제2조 개인정보의 처리 및 보유기간 </h5>
			 		<p>
						① 공사에서 본 홈페이지는 처리하는 개인정보는 수집·이용 목적으로 명시한 범위 내에서 처리하며, 개인정보보호법 및 관련법령에서 정하는 보유기간을 준용하여 이행하고 있습니다.<br />
						<table class="table_p"> 
	 						<colgroup>
								<col width="25%"/>
								<col width="25%"/>
								<col width="25%"/>
								<col width="25"/>
							</colgroup>
							<thead>
								<tr>
		 							<th>처리목적</th>
		 							<th>개인정보 항목</th>
		 							<th>수집 방법 및 근거</th>
		 							<th>보유기간</th>
								</tr>
	 						</thead>
	 						<tbody>
	 							<tr>
		 							<td>홈페이지 회원 가입 및 관리</td>
		 							<td>
		 								· 필수 : 사번, 이름, 전화번호 <br />
		 								· 선택 : 휴대전화번호 <br />
		 							</td>
		 							<td>정보주제 동의</td>
		 							<td>탈퇴시 파기</td>
	 							</tr>
	 						</tbody>
	 					</table>
					</p>
			
					<h5 class="bgee p10"> 제3조 정보주체와 법정대리인의 권리·의무 및 그 행사방법 </h5>
					<p>
						① 정보주체는 공사의 본 홈페이지는 대해 다음과 같은 권리를 행사할 수 있으며 만 14세미만 아동의 법정대리인은 해당 아동의 개인정보에 대한 열람, 정정·삭제, 처리정지를 요구할 수 있습니다. <br />
						② 개인정보 열람 요구 <br />
						&nbsp; 1. 공사의 본 홈페이지는 보유하고 있는 개인정보파일은 『개인정보보호법』제35조에 따라 본인의 개인정보에 대한 열람을 요구할 수 있습니다. 다만, 개인정보 열람 요구는 『개인정보보호법』제35조 제5항<br />
						&nbsp;&nbsp;에 의하여 다음과 같이 제한될 수 있습니다.<br />
						&nbsp;&nbsp;- 법률에 따라 열람이 금지되거나 제한되는 경우<br />
						&nbsp;&nbsp;- 다른 사람의 생명·신체를 해할 우려가 있거나 다른 사람의 재산과 그 밖의 이익을 부당하게 침해할 우려가 있는 경우<br />
						&nbsp;&nbsp;- 공공기관이 다음 각 목의 어느 하나에 해당하는 업무를 수행할 때 중대한 지장을 초래하는 경우<br />
						&nbsp; 2. 조세의 부과·징수 또는 환급에 관한 업무<br />
						&nbsp; 3. 학력·기능 및 채용에 관한 시험, 자격 심사에 관한 업무<br />
						&nbsp; 4. 보상금·급부금 산정 등에 대하여 진행 중인 평가 또는 판단에 관한 업무<br />
						&nbsp; 5. 다른 법률에 따라 진행 중인 감사 및 조사에 관한 업무<br />
						③ 개인정보 정정·삭제 요구<br />
						&nbsp; - 공사에서 보유하고 있는 개인정보파일은 『개인정보보호법』제36조(개인정보의 정정·삭제)에 따라 정정·삭제를 요구할 수 있습니다. 다만, 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우 <br />
						&nbsp;&nbsp;&nbsp;&nbsp;에는 그 삭제를 요구할 수 없습니다.<br />
						④ 개인정보 처리정지 요구<br />
						&nbsp;&nbsp;&nbsp;&nbsp;공사의 본 홈페이지는 보유하고 있는 개인정보파일은 『개인정보보호법』제37조에 따라 처리정지를 요구할 수 있습니다. 다만, 개인정보 처리정지 요구 시 『개인정보보호법』제37조제2항에 의하여 처리<br />
						&nbsp;&nbsp;&nbsp;&nbsp;정지 요구가 거절될 수 있습니다.<br />
						&nbsp;&nbsp;- 법률에 특별한 규정이 있거나 법령상 의무를 준수하기 위하여 불가피한 경우 다른 사람의 생명·신체를 해할 우려가 있거나 다른 사람의 재산과 그 밖의 이익을 부당하게 침해할 우려가 있는 경우<br />
						&nbsp;&nbsp;- 공공기관이 개인정보를 처리하지 아니하면 다른 법률에서 정하는 소관업무를 수행할 수 없는 경우<br />
						&nbsp;&nbsp;- 개인정보를 처리하지 아니하면 정보주체와 약정한 서비스를 제공하지 못하는 등 계약의 이행이 곤란한 경우로서 정보주체가 그 계약의 해지의사를 명확하게 밝히지 아니한 경우<br />
						⑤ 개인정보 열람 등 요구방법<br />
						&nbsp;&nbsp;- 제1항에 따른 권리 행사는 『개인정보보호법』시행규칙 별지 제8호 서식을 이용하여 방문, 서면, 전화, 전자우편, FAX를 통해 요구하거나 “개인정보보호 종합지원 포탈” 홈페이지 (www.privacy.go.kr, “ <br />
						&nbsp;&nbsp;&nbsp;&nbsp;개인정보 열람․정정․삭제․처리정지 요구”) 등 다양한 방법을 통하여 요구할 수 있으며, 공사는 신청자의 신분을 확인 후 지체없이(10일 이내) 조치하겠습니다.<br />
						&nbsp;&nbsp;- 정보주체 본인의 '열람/증명' 접수 처리 시에는 사용자의 신분을 나타내는 주민등록증, 여권, 운전면허증 등의 신분증명서를 제출하여 본인 여부를 확인합니다.<br />
						&nbsp;&nbsp;- 정보주체의 대리인이 방문하여 개인정보의 열람/증명을 요구하는 경우에는 대리관계를 나타내는 위임장 및 명의 사용자의 인감증명서와 대리인의 신분증명서 등의 증표를 제시받아 진정한 대리인인지 여부를 <br />
						&nbsp;&nbsp;&nbsp;&nbsp; 확인합니다.<br />
						&nbsp;&nbsp;- 개인정보의 전부 또는 일부에 대하여 열람/증명 또는 정정을 거절할 이유가 있는 경우에는 사용자에게 이를 통지하고 그 이유를 설명합니다.<br />
						③ 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.<br />
						④ 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 제1항에 대한 권리 행사를 하는 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하여야 합니다.<br />
					</p>
					
					<h5 class="bgee p10"> 제4조 개인정보의 파기 </h5>
					<p>
						① 공사의 본 홈페이지는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체 없이 해당 개인정보를 파기합니다. <br/>
						②  파기의 절차 및 방법은 다음과 같습니다.<br/>
						1. 파기절차<br/>
						&nbsp;&nbsp; - 불필요한 개인정보 및 개인정보파일은 개인정보파기 계획을 수립하여 파기합니다. <br/>
						&nbsp;&nbsp; - 파기 사유가 발생한 개인정보(또는 개인정보파일)을 선정하고, 개인정보 보호책임자의 승인을 받아 개인정보(또는 개인정보파일)을 파기합니다. <br/>
						&nbsp;&nbsp; - 개인정보는 목적 달성 후 즉시 또는 별도 공간에 옮겨져 내부방침 및 기타 관련법령에 따라 일정기간 보유한 후 파기되며, 별도의 공간으로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 <br/>
						&nbsp;&nbsp;&nbsp;&nbsp; 이용되지 않습니다.  <br/>
						&nbsp;&nbsp;&nbsp;   • 개인정보의 파기 <br/>
						&nbsp;&nbsp;&nbsp;&nbsp; 보유기간이 경과하거나 처리목적 달성한 개인정보는 종료일로부터 지체 없이 파기합니다. <br/>
						&nbsp;&nbsp;&nbsp;   • 개인정보파일의 파기 <br/>
						&nbsp;&nbsp;&nbsp;&nbsp; 개인정보파일의 보유기간이 만료되었거나 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보파일이 불필요하게 되었을 때에는 지체 없이 그 개인정보파일을 파기합니다. <br/>
						2. 파기방법 <br/>
						&nbsp;&nbsp; - 전자적 파일 형태로 기록·저장된 개인정보는 기록을 재생할 수 없도록 파기합니다. <br/>
						&nbsp;&nbsp; - 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다. <br/>
					</p>
					
					<h5 class="bgee p10"> 제5조 개인정보의 안전성 확보조치 </h5>
					<p>
						① 공사의 본 홈페이지는 『개인정보보호법』제29조에 따라 다음과 같이 개인정보의 안전성 확보를 위하여 관리적, 기술적, 물리적 대책으로 여러 보안장치를 마련하고 있습니다. <br />
					 	&nbsp;&nbsp;1. 개인정보의 안전한 처리를 위한 내부관리계획의 수립ㆍ시행 <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 개인정보의 안전한 처리를 위하여 공사의 내부관리계획을 수립하고 시행하고 있습니다. <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 개인정보를 취급하는 직원은 반드시 필요한 인원에 한하여 지정·관리하고 있습니다. <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 개인정보취급자를 대상으로 안전한 관리를 위한 교육을 실시하고 있습니다. <br />
						&nbsp;&nbsp;2. 개인정보에 대한 접근 통제 및 접근 권한의 제한 조치 <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 접근권한의 부여·변경·말소를 통하여 개인정보에 대한 접근 통제를 위한 필요한 조치를 하고 있습니다. <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 침입차단시스템을 이용하여 외부로부터의 무단접근을 통제하고 있습니다. <br />
						&nbsp;&nbsp;3. 개인정보를 안전하게 저장ㆍ전송할 수 있는 암호화 기술의 적용 또는 이에 상응하는 조치 <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 개인정보는 암호화 등을 통해 안전하게 저장 및 관리되고 있습니다. <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 중요한 데이터는 저장 및 전송 시 암호화하여 사용하는 등의 별도 보안기능을 사용하고 있습니다. <br />
						&nbsp;&nbsp;4. 개인정보 침해사고 발생에 대응하기 위한 접속기록 보관 조치 <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 개인정보처리시스템에 접속한 기록을 보관·관리하고 있습니다. <br />
						&nbsp;&nbsp;5. 개인정보에 대한 보안프로그램의 설치 및 갱신 <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 해킹이나 컴퓨터 바이러스 등에 의한 개인정보 유출 및 훼손을 막기 위하여 보안 프로그램을 설치하고 주기적으로 갱신·점검하고 있습니다. <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 접근이 통제된 구역에 시스템을 설치하고 기술적/물리적으로 감시 및 차단하고 있습니다. <br />
						&nbsp;&nbsp;6. 개인정보의 안전한 보관을 위한 보관시설의 마련 또는 잠금장치의 설치 등 물리적 조치 <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 개인정보를 보관하고 있는 개인정보처리시스템의 물리적 보관 장소를 별도로 두고 이에 대해 출입통제 절차를 수립, 운영하고 있습니다. <br />
					</p>
					
					<h5 class="bgee p10"> 제6조 개인정보 보호책임자의 성명 또는 개인정보 보호업무 및 관련 고충사항을 처리하는 부서의 명칭과 전화번호 등 연락처 </h5>
					<p>
						① 공사의 본 홈페이지는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 두고 있습니다.<br/>
	 					&nbsp;&nbsp;<table class="table_p"> 
	 						<colgroup>
								<col width="25%"/>
								<col width="25%"/>
								<col width="25%"/>
								<col width="25%"/>
							</colgroup>
							<thead>
								<tr>
		 							<th colspan="2">개인정보보호 분임 책임자</th>
		 							<th colspan="2">개인정보보호 분임 담당자</th>
								</tr>
	 						</thead>
	 						<tbody>
	 							<tr>
		 							<td>담당부서</td>
		 							<td>ICT기획처</td>
		 							<td>담당부서</td>
		 							<td>ICT기획처</td>
	 							</tr>
	 							<tr>
		 							<td>직      책</td>
		 							<td>ICT기획처장</td>
		 							<td>직      책</td>
		 							<td>인프라계획실장</td>
	 							</tr>
	 						</tbody>
	 					</table>
	 					<br />
	 					&nbsp;&nbsp;<table class="table_p"> 
	 						<colgroup>
								<col width="25%"/>
								<col width="25%"/>
								<col width="25%"/>
								<col width="25%"/>
							</colgroup>
							<thead>
								<tr>
		 							<th colspan="2">개인정보보호 총괄 책임자</th>
		 							<th colspan="2">개인정보보호 총괄 담당자</th>
								</tr>
	 						</thead>
	 						<tbody>
	 							<tr>
		 							<td>담당부서</td>
		 							<td>안전보안처</td>
		 							<td>담당부서</td>
		 							<td>안전보안처</td>
	 							</tr>
	 							<tr>
		 							<td>성      명</td>
		 							<td>김경수</td>
		 							<td>성      명</td>
		 							<td>윤원주</td>
	 							</tr>
	 						</tbody>
	 					</table>
					</p>
					
					<h5 class="bgee p10"> 제7조 정보주체의 권익침해에 대한 구제방법 </h5>
					<p>
						① 정보주체는 아래의 기관에 개인정보 침해에 대한 피해구제, 상담 등을 문의할 수 있습니다. <br />
						② 아래의 기관은 공사와 별개의 기관으로서, 공사의 자체적인 개인정보 불만처리, 피해 구제 결과에 만족 하지 못하시거나 보다 자세한 도움이 필요하시면 문의하여 주시기 바랍니다. <br />
						&nbsp;&nbsp;▶ 개인정보 침해신고센터 (한국인터넷진흥원 운영) <br /> 
						&nbsp;&nbsp;&nbsp;&nbsp;- 소관업무 : 개인정보 침해사실 신고, 상담 신청 <br /> 
						&nbsp;&nbsp;&nbsp;&nbsp;- 홈페이지 : privacy.kisa.or.kr <br /> 
						&nbsp;&nbsp;&nbsp;&nbsp;- 전화 : (국번 없이) 118 <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 주소 : 전라남도 나주시 진흥길 9 한국인터넷진흥원 <br />
						&nbsp;&nbsp;▶ 개인정보 분쟁조정위원회 <br /> 
						&nbsp;&nbsp;&nbsp;&nbsp;- 소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결) <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 홈페이지 : www.kopico.go.kr <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 전화 : (국번 없이) 1833-6972 <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 주소 : (03171) 서울시 종로구 세종대로 209 정부서울청사 4층 <br />
						&nbsp;&nbsp;▶ 경찰청 사이버안전국 <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 소관업무 : 개인정보 침해 관련 형사사건 문의 및 신고 <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 홈페이지 : cyberbureau.police.go.kr <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 전화 : (국번 없이) 182 <br />
						&nbsp;&nbsp;▶ 대검찰청 사이버수사과 : (국번 없이) 1301 (www.spo.go.kr) <br />
						③ 개인정보의 열람, 정정·삭제, 처리정지 등에 대한 정보주체의 요구에 대하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익을 침해 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다. <br />
						&nbsp;&nbsp;&nbsp;&nbsp;☞ 중앙행정심판위원회(www.simpan.go.kr)의 전화번호 안내 참조 <br />
					</p>
					
					<h5 class="bgee p10"> 제8조 개인정보의 열람청구 등 민원 접수·처리하는 부서 </h5>
					<p>
						① 공사에서는 다음과 같이 개인정보 열람청구 접수·처리부서를 운영하고 있으므로 정보주체는『개인정보보호법』제35조에 따른 개인정보의 열람청구를 아래의 부서에 할 수 있습니다. (14세 미만 아동은 법적 대리인의 동의를 통해 가능합니다) <br/>
	 					&nbsp;&nbsp;<table class="table_p"> 
	 						<colgroup>
								<col width="10%"/>
								<col width="10%"/>
								<col width="*"/>
								<col width="15%"/>
								<col width="15%"/>
							</colgroup>
							<thead>
								<tr>
		 							<th>부서명</th>
		 							<th>담당자</th>
		 							<th>주소</th>
		 							<th>전자우편</th>
		 							<th>전화번호</th>
								</tr>
	 						</thead>
	 						<tbody>
	 							<tr>
		 							<td>ICT기획처</td>
		 							<td>정경승</td>
		 							<td>전라남도 나주시 전력로 55 한국전력공사 ICT기획처 인프라계획실 우)58217</td>
		 							<td>kitae_kim@kepco.co.kr</td>
		 							<td>061-345-5366</td>
	 							</tr>
	 						</tbody>
	 					</table>
						<br />
	 					② 정보주체께서는 제1항의 열람청구 접수․처리부서 이외에, 행정안전부의 ‘개인정보보호 종합포털’ 웹사이트(www.privacy.go.kr)를 통하여서도 개인정보 열람청구를 하실 수 있습니다. <br /> 
						&nbsp;&nbsp;&nbsp;&nbsp;☞  행정안전부 개인정보보호 종합포털 → 개인정보 민원 → 개인정보 열람 등 요구
					</p>
					
					<h5 class="bgee p10"> 제9조 개인정보 처리방침의 변경 </h5>
					<p>
						① 이 개인정보 처리방침은 2020년 3월 25일부터 적용됩니다. <br />
						② 이전의 개인정보 처리방침은 아래에서 확인하실 수 있습니다. <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 2016년 6월 30일 이전 개인정보 처리방침 v2 <br />
						&nbsp;&nbsp;&nbsp;&nbsp;- 2015년 3월 01일 이전 개인정보 처리방침 v1 <br />
					</p>
					
		  		</section>
	 		</div>
			
			<div class="clear"></div>	
			
			<!-- footer start -->
			<c:import url="${contextPath}/WEB-INF/views/home/include/home_footer.jsp" charEncoding="UTF-8"></c:import>	
			<!-- footer end -->
		</div>	
	</body>	
</html>