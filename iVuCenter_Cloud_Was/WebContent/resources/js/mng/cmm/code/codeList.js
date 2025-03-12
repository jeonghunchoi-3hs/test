$(document).ready(function() {
	App.init();
	
	// 리스트
    gridList();
    gridList2();
//    $("#leftNavi").load("/mng/");
});


function movePageDetail(codeKeyId, codeId){
	var params = "?codeKeyId="+codeKeyId;
	params += "&codeId="+codeId;

	location.href = $("#contextPath").val()+"/mng/cmm/code/view"+params
}

function setGridList2(codeKeyId){
	$('#list2SearchKey').val(codeKeyId);
	gridList2();
}

function gridList() {
	$('#cmmCode-list').DataTable( {
		"processing": true
		,"autoWidth": false
		,"serverSide": true
		,"ordering": false
		,"destroy" : true
		,"ajax": {
			"url": $("#contextPath").val()+"/mng/cmm/code/list"
			,"data":function (d) {
				d.parentCodeId="*";
			}
			,"error": function (xhr, error, thrown) {
				if ( error == "parsererror" ) {
					location.reload();
				}else{
					alert("ajax error");
					console.log(error);
					console.log(xhr);				
					console.log(thrown);
					return false;
				}
			}	
		}
		,"columns": [ 
	        {"data":"codeKeyId", "class":"tac", "width":"20%"}
	        , {"data":"codeId", "class":"tac", "width":"20%"}
	        , {"data":"codeName", "class":"tac", "width":"30%"}
	        , {"data":"codeType", "class":"tac"}
	        , {"data":"codeLevel", "class":"tac"}
	        , {"data":"parentCodeId", "class":"tac"}
	        , {"data":"codeHideFlag", "class":"tac"}
	        , {"data":"codeSortNum", "class":"tac"}
	        , {"data":"delFlag", "class":"tac", "width":"15%"}
		]
		,"columnDefs": [ 
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[0], "render": function(data,type,full){
						return "<div style='color:blue;cursor:pointer;' onclick='setGridList2(\""+data+"\")'>"+data+"</div>";
					}
				}
				, {"targets":[3],"visible":false,"searchable":false }
				, {"targets":[4],"visible":false,"searchable":false }
				, {"targets":[5],"visible":false,"searchable":false }
				, {"targets":[6],"visible":false,"searchable":false }
				, {"targets":[7],"visible":false,"searchable":false }
		]
		,"oLanguage": {"sZeroRecords":"<p align='center'>검색결과가 없습니다.</p>"}
		,"sDom":'<"top">rt<"bottom"pi>'
		,"oTableTools": {
			"aButtons":[ {
				"sExtends":"text"
				,"sButtonText":"등록"
				,"fnClick":function(nButton,oConfig,oFlash) {
					moveInsertPage();
				}
			}]
		}			
	});
}


function gridList2() {
	$('#cmmCode-list2').DataTable( {
		"processing": true
		,"autoWidth": false
		,"serverSide": true
		,"ordering": false
		,"destroy" : true
		,"ajax": {
			"url": $("#contextPath").val()+"/mng/cmm/code/list"
			,"data":function (d) {
				d.parentCodeId=$('#list2SearchKey').val();
			}
			,"error": function (xhr, error, thrown) {
				if ( error == "parsererror" ) {
					location.reload();
				}else{
					alert("ajax error");
					return false;
				}
			}	
		
		}
		,"columns": [ 
			{"data":"codeKeyId", "class":"tac", "width":"20%"}
	        , {"data":"codeId", "class":"tac", "width":"20%"}
	        , {"data":"codeName", "class":"tac", "width":"30%"}
	        , {"data":"codeType", "class":"tac"}
	        , {"data":"codeLevel", "class":"tac"}
	        , {"data":"parentCodeId", "class":"tac"}
	        , {"data":"codeHideFlag", "class":"tac"}
	        , {"data":"codeSortNum", "class":"tac"}
	        , {"data":"delFlag", "class":"tac", "width":"15%"}
		]
		,"columnDefs": [ 
				{"defaultContent" : "", targets:"_all" }
				, {"targets":[3],"visible":false,"searchable":false }
				, {"targets":[4],"visible":false,"searchable":false }
				, {"targets":[6],"visible":false,"searchable":false }
				, {"targets":[7],"visible":false,"searchable":false }
		]
		,"oLanguage": {"sZeroRecords":"<p align='center'>검색결과가 없습니다.</p>"}
		,"sDom":'<"top">rt<"bottom"pi>'
	});
}