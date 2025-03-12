<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
    <sec:authentication var="roles" property="principal.roles"/>
    <sec:authentication var="userId" property="principal.username"/>
    <sec:authentication var="userName" property="principal.nickname"/>
</sec:authorize>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
        <meta content="" name="description" />
        <meta content="" name="author" />
        <c:import url="../../include/import.jsp" charEncoding="UTF-8"></c:import>
        <title>한전 KDN K-ECP</title>
    </head>
    <body>
        <div id="page-container" class="fade page-container page-header-fixed page-sidebar-fixed page-with-footer">
			<!-- begin #header -->
			<c:import url="../../include/header.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #header -->
			<!-- begin #sidebar -->
			<c:import url="../../include/sidebar.jsp" charEncoding="UTF-8"></c:import>
			<!-- end #sidebar -->

                <!-- begin #content -->
                <div id="content" class="content">
                    <!-- begin header -->
				<p class="page_title">오토스케일링 수정
				<span class="root f14">Home <span class="arrow_ab"> &#8227; </span><a href="${wasPath}/mbr/main"> 콘솔</a>  <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/application/management/"> 자원 현황 </a> <span class="arrow_ab"> &#8227; </span> <a href="${wasPath}/mbr/application/management/">어플리케이션 관리</a>  <span class="arrow_ab"> &#8227; </span> <b> 오토스케일링 수정 </b>
			    </span>
				</p>
                    <!-- end header -->

                    <div class="container-fluid p-0">
                        <input type="hidden" id="h_scaleOutUid" value="${scaleOutdetail.scaleOutUid}">
                        <input type="hidden" id="hid_projectBoxId" value="${scaleOutdetail.projectBoxId}">
                        <input type="hidden" id="hid_projectId" value="${scaleOutdetail.projectId}">
                        <input type="hidden" id="hid_appName" value="${scaleOutdetail.appName}">
                        <input type="hidden" id="hid_nameSpace" value="${scaleOutdetail.nameSpace}">
                        <input type="hidden" id="hid_cloudId" value="${scaleOutdetail.cloudId}">

                        <div class="row p20 bgwh br10">
                            <div class="col-12">
                                    <div class="mb20 tableE">
                                            <table>
                                                <colgroup>
                                                    <col width="140px" />
                                                    <col width="*" />
                                                    <col width="140px" />
                                                    <col width="*" />
                                                </colgroup>
                                                <tbody>
                                                    <tr>
                                                        <th class="tal">프로젝트 ID</th>
                                                        <td><strong id="projectName">${scaleOutdetail.projectName}</strong></td>
                                                        <th class="tal">프로젝트명</th>
                                                        <td id="projectAlias">${scaleOutdetail.projectAlias}</td>
                                                    </tr>
                                                    <tr>
                                                        <th class="tal">회원사</th>
                                                        <td><span id="customerName"></span></td>
                                                        <th class="tal">부서</th>
                                                        <td><span id="deptId"></span></td>
                                                    </tr>
                                                    <tr>
                                                        <th class="tal">담당자</th>
                                                        <td colspan="3"><span id="managerName"></span>(<span id="managerPhone"></span>)</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                    </div>
					<div class="tableF">
					    <table>
					        <colgroup>
					            <col width="140px" />
                                <col width="*" />
                                <col width="140px" />
                                <col width="*" />
					        </colgroup>
					        <tbody>
					            <tr>
					                <td>Scale-Out 이름</td>
					                <td colspan="3">
					                    <input class="form-control w95" type="text" id="scaleOutName" value="${scaleOutdetail.scaleOutName}" readonly />
					                </td>
					            </tr>
					            <tr>
					                <td class="left-t">Scale-Out 구분</td>
					                <td colspan="3">
					                	<div class="flex align-center gap10">
						                    <label class="form-check">
						                        <input class="form-check-input" type="radio" id="onDemandFlag1" name="onDemandFlag" value="cpu" checked />
						                        <span class="form-check-label">CPU</span>
						                    </label>
						                    <label class="form-check">
						                        <input class="form-check-input" type="radio" id="onDemandFlag2" name="onDemandFlag" value="memory" />
						                        <span class="form-check-label">메모리</span>
						                    </label>
					                    </div>
					                </td>
					            </tr>
					            <tr>
					                <td class="left">컨테이너</td>
					                <td>
					                    <input class="form-control w95" type="text" id="appAlias" value="${scaleOutdetail.appAlias}" readonly />
					                </td>
					                <td class="left">이미지 템플릿</td>
					                <td>
					                    <input class="form-control w95" type="text" id="appImageName" value="${scaleOutdetail.appImageName}" readonly />
					                </td>
					            </tr>
								<tr>
								    <td class="left">임계값</td>
										<td>
											<div class="input-group form-input-group form-input-group-type2" style="display: inline-flex; align-items: center;">
											    <input type="text" class="form-control" id="hpaMax" value="${scaleOutdetail.hpaMax}" readonly>
											    <p class="inputUnit pt10">%</p>
											    <div class="input-group input-count-group" style="display: inline-flex; align-items: center;">
											        <img src="/resources/assets/img/icon_minus.png" onclick="btnMinus(this, 10);" style="cursor: pointer; margin-left: 5px; margin-right: 5px;">
											        <span id="cpuMemMax01" class="snemo">10</span>
											        <img src="/resources/assets/img/icon_plus.png" onclick="btnPlus(this, 10);" style="cursor: pointer; margin-left: 5px;">
											    </div>
											</div>
										</td>
								    <td colspan="2">
								        <div class="col-md-7">
								            <span class="form-text-type2">Scale Out 이 적용될 리소스 사용률</span>
								        </div>
								    </td>
								</tr>

										<tr> <!-- 지속시간 -->
											<td class="left">지속시간</td>
											<td>
												<div class="input-group form-input-group form-input-group-type2" style="display: inline-flex; align-items: center;">
													<input type="text" class="form-control" id="hpaContinue" value="${scaleOutdetail.hpaContinue}" readonly>
													<p class="inputUnit pt10">분</p>
													<div class="input-group input-count-group" style="display: inline-flex; align-items: center;">
														<img src="/resources/assets/img/icon_minus.png" onclick="btnMinus(this, 1);" style="cursor: pointer; margin-left: 5px; margin-right: 5px;">
														<span id="cpuMemDurationTime01" class="snemo">1</span>
														<img src="/resources/assets/img/icon_plus.png" onclick="btnPlus(this, 1);" style="cursor: pointer; margin-left: 5px;">
													</div>
												</div>
											</td>
											<td colspan="2">
												<div class="col-md-7">
													<span class="form-text-type2">지속시간 동안의 평균 사용률로 Scale-Out 정책이 적용됩니다.</span>
												</div>
											</td>
										</tr>

								<tr>
									<td class="left">최소 POD</td>
										<td>
												<div class="input-group form-input-group form-input-group-type2" style="display: inline-flex; align-items: center;">
													<input type="text" class="form-control" id="hpaMinPod" value="${scaleOutdetail.hpaMinPod}" readonly>
													<p class="inputUnit pt10">EA</p>
													<div class="input-group input-count-group" style="display: inline-flex; align-items: center;">
														<img src="/resources/assets/img/icon_minus.png" onclick="btnMinus(this, 1);" style="cursor: pointer; margin-left: 5px; margin-right: 5px;">
														<span id="hpaMinPodCnt" class="snemo">1</span>
														<img src="/resources/assets/img/icon_plus.png" onclick="btnPlus(this, 1);" style="cursor: pointer; margin-left: 5px;">
													</div>
											</div>
										</td>
								    <td colspan="2">
								        <div class="col-md-7">
								            <span class="form-text-type2">자동 증가 정책으로 동작하는 최소 POD 수량입니다.</span>
								        </div>
								    </td>
								</tr>
								<tr>
								    <td class="left">최대 POD</td>
										<td>
												<div class="input-group form-input-group form-input-group-type2" style="display: inline-flex; align-items: center;">
													<input type="text" class="form-control" id="hpaMaxPod" value="${scaleOutdetail.hpaMaxPod}" readonly>
													<p class="inputUnit pt10">EA</p>
													<div class="input-group input-count-group" style="display: inline-flex; align-items: center;">
														<img src="/resources/assets/img/icon_minus.png" onclick="btnMinus(this, 1);" style="cursor: pointer; margin-left: 5px; margin-right: 5px;">
														<span id="hpaMaxPodCnt" class="snemo">1</span>
														<img src="/resources/assets/img/icon_plus.png" onclick="btnPlus(this, 1);" style="cursor: pointer; margin-left: 5px;">
													</div>
											</div>
										</td>
								    <td colspan="2">
								        <div class="col-md-7">
								            <span class="form-text-type2">자동 증가 정책으로 동작가능한 최대 POD 수량입니다.</span>
								        </div>
								    </td>
								</tr>
								<tr>
								    <td class="left">증가 POD</td>
										<td>
												<div class="input-group form-input-group form-input-group-type2" style="display: inline-flex; align-items: center;">
													<input type="text" class="form-control" id="hpaIncrePod" value="${scaleOutdetail.hpaIncrePod}" readonly>
													<p class="inputUnit pt10">EA</p>
													<div class="input-group input-count-group" style="display: inline-flex; align-items: center;">
														<img src="/resources/assets/img/icon_minus.png" onclick="btnMinus(this, 1);" style="cursor: pointer; margin-left: 5px; margin-right: 5px;">
														<span id="hpaIncrePodCnt" class="snemo">1</span>
														<img src="/resources/assets/img/icon_plus.png" onclick="btnPlus(this, 1);" style="cursor: pointer; margin-left: 5px;">
													</div>
											</div>
										</td>
								    <td colspan="2">
								        <div class="col-md-7">
								            <span class="form-text-type2">자동 증가 정책으로 증가 혹은 감소하는 POD 수량입니다.</span>
								        </div>
								    </td>
								</tr>

					        </tbody>
					    </table>
					</div>

                                    <div class="btn-wrap tac">
                                    	<a type="button" class="btn_navy" id="noticeList" onclick="updateScaleOut();">저장</a>
<!--                                         <button class="btn_navy" id="noticeList" onclick="updateScaleOut()">저장</button> -->
                                        <a type="button" class="btn_lgrey ml10" onclick="moveListPage();"> 목록</a>
                                    </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="listDetailView" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">상세</h5>
                                    <button type="button" class="btn btn-close btn-close-black" data-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body m-3"></div>
                            </div>
                        </div>
                    </div>

                <c:import url="../../include/footer.jsp" charEncoding="UTF-8"></c:import>
            </div>
        </div>

        <c:import url="../../include/script.jsp" charEncoding="UTF-8"></c:import>
<script type="text/javascript">

	function getDetail() {

		$.ajax({
			url : "${contextPath}/mbr/oss/project/detail",
			dataType : "JSON",
			data : {
				"projectBoxId" : $("#hid_projectBoxId").val()
			},
			async : false,
			success : function(data) {
				delete data.length;
				$.each(data, function(i, val){
					//프로젝트 상세 ID 값 넣기
					if(i != "deptName"){
						if(i == "cloudType"){
							if(val == "vmware"){
								$("#status1").text("상태");
								$("#status3").text("상태 : ");
								$("#status4").remove();
								visible = 0;
							}
						}
						$("#"+i).text(val);
					}
				});
			},
			error : function(request, status, error) {
				alertBox3("code:" + request.status + "<br>" + "error:" + request.responseText);
			}
		});
	}

	function scaleOutDivision() {
		if ("${scaleOutdetail.scaleOutName}" === "cpu") {
			  document.getElementById("onDemandFlag1").checked = true;
			} else {
			  document.getElementById("onDemandFlag2").checked = true;
			}
	}



	function scaleOutCpu() {

		$("input:radio[name=scaleOutCpu]").prop("checked", true);

		$("#cpuMinTr").show();
		$("#cpuMaxTr").show();
		$("#cpuDurationTimeTr").show();
		$("#memMinTr").hide();
		$("#memMaxTr").hide();
		$("#memDurationTimeTr").hide();
	}

	function scaleOutMem() {

		$("input:radio[name=scaleOutMem]").prop("checked", true);

		$("#cpuMinTr").hide();
		$("#cpuMaxTr").hide();
		$("#cpuDurationTimeTr").hide();
		$("#memMinTr").show();
		$("#memMaxTr").show();
		$("#memDurationTimeTr").show();

	}

	//목록 페이지이동
	function moveListPage() {
// 		location.href = "${contextPath}/mbr/application/management/";
		history.back();
	}

	function updateScaleOut() {

		var hpaMin = Number(rtnnumber($("#hpaMin").val()));
		var hpaMax = Number(rtnnumber($("#hpaMax").val()));

		if (hpaMin > hpaMax) {
			alertBox3("최소값이 최대값보다 큽니다.");
			return false;
		}

		var hpaMinPod = Number(rtnnumber($("#hpaMinPod").val()));
		var hpaMinPod = Number(rtnnumber($("#hpaMaxPod").val()));

		if (hpaMinPod > hpaMinPod) {
			alertBox3("POD 최소수량이 최대수량보다 큽니다.");
			return false;
		}

		confirmBox("수정하시겠습니까?", ajaxUpdate)

	}

	function ajaxUpdate() {

		$.ajax({
			url : "${contextPath}/mbr/oss/app/scaleOutUpdate",
			dataType : "JSON",
			data : {
				"scaleOutUid" : $("#h_scaleOutUid").val(),
				"scaleOutName" : $("#scaleOutName").val(),
				"hpaMin" : $("#hpaMin").val(),
				"hpaMax" : $("#hpaMax").val(),
				"hpaContinue" : $("#hpaContinue").val(),
				"hpaMinPod" : $("#hpaMinPod").val(),
				"hpaMaxPod" : $("#hpaMaxPod").val(),
				"hpaIncrePod" : $("#hpaIncrePod").val(),
				"hpaDivision" : $("input[name='onDemandFlag']:checked").val(),
				"projectId" : $("#hid_projectId").val(),
				"appName" : $("#hid_appName").val(),
				"nameSpace" : $("#hid_nameSpace").val(),
				"cloudId" : $("#hid_cloudId").val(),
			},
			success : function(req) {
				if (req == "1") {
					alertBox("수정되었습니다.", moveListPage);
				} else {
					alertBox3("수정실패");
				}
			},
			error : function(request, status, error) {
				alertBox3("code : " + request.status + "\n" + "error : "
						+ request.responseText);
			}
		});
	}

	function vmSet(hostnameAlias, dcId) {
		$("#hostnameAlias").val(hostnameAlias);
		$("#dcId").val(dcId);
	}

	function btnMinus(argElement, argMinusNum){
		var inputId = argElement.parentElement.parentNode.children.item(0).id
		var minNumber = Number(rtnnumber($("#" + inputId).val())) - Number(rtnnumber(argMinusNum));

		if(inputId == "hpaMinPod"){
			alertBox3("최소 pod수는 변경 할 수 없습니다.");
			return false;
		}else if(inputId == "hpaMaxPod"){
			var pod = ${scaleOutdetail.hpaMaxPod};
			if(minNumber < pod){
				alertBox3(pod + "보다 작습니다.");
				return false;
			}
		}else{
			if(minNumber < 1){
				alertBox3("1보다 작습니다.");
				return false;
			}
		}
		$("#"+inputId).val(minNumber);
	}

	function btnPlus(argElement, argPlusNum){
		var inputId = argElement.parentElement.parentNode.children.item(0).id
		var maxNumber = Number(rtnnumber($("#" + inputId).val())) + Number(rtnnumber(argPlusNum));

		if(inputId == "hpaMinPod"){
			alertBox3("최소 pod수는 변경 할 수 없습니다.");
			return false;
		}

		if(maxNumber > 100){
			alertBox3("100 이하로 적용해주세요.");
			return false;
		}
		$("#"+inputId).val(maxNumber);
	}

	$(document).ready(function() {
		App.init();
		getDetail();

		scaleOutDivision();

		//메뉴활성화
		$("#myGoods").addClass("active");
		$("#managementApp").addClass("active");

		$("#cpuMinTr").show();
		$("#cpuMaxTr").show();
		$("#cpuDurationTimeTr").show();
		$("#memMinTr").hide();
		$("#memMaxTr").hide();
		$("#memDurationTimeTr").hide();

	});

</script>
</body>
</html>