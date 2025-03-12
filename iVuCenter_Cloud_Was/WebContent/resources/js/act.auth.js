var oTable;
var oTable2;
var sGbn;
var vRet = "";
var vColor = "";
var vAct = "";
var vMenu_id = "";
var iSubmit = 0;
var openGbn = "add";

var setting = {
        callback: {
            onClick: onClick
        }
    };

$(document).ready(function() {
    //  페이지 구분값 
    sGbn = $("#subname").val();
    sGbn2 = $("#subname2").val();
    
    // select box
    setComboBox( aCode_yn,"divModal-active_yn","active_yn","100%", " class='form-control' " );
    
    // 리스트
    gridList();
    
	// DB 처리
    $('#btnInsert').on( 'click', function () { actAjax('insert'); } );
    $('#btnUpdate').on( 'click', function () { actAjax('update'); } );
    $('#btnDelete').on( 'click', function () { actAjax('delete'); } );
    
    $.fn.zTree.init($("#treeDemo"), setting, eval('(' + $("#tree").val() + ')'));
    
    // 상세보기 버튼 이벤트
    $('#'+sGbn+'-list tbody').on( 'click', 'td.details-control', function () {
        openModal("edt");
        format( oTable.row( $(this).closest('tr') ) );
    } );
    
    // 권한 부여
    $('#'+sGbn+'-list tbody').on( 'click', 'td.authBtn-control', function () {
        $('#'+sGbn2+'-modal').modal();
        $('#'+sGbn2+'-modal').modal({keyboard:false});
        $('#'+sGbn2+'-modal').modal('show');

        var row = oTable.row( $(this).closest('tr') );
        $('#key3').val(row.data().auth_id);
        gridList2();
    } );

    // modal창 재오픈시 권한 메뉴 리스트 관련 오류 떄문에 화면 새로 고침 처리
    $('#'+sGbn2+'-modal').on('hidden.bs.modal', function () { location.reload(); });
	$('#'+sGbn+'-modal').on('hidden.bs.modal', function () { location.reload(); });
});

function gridList() {
	oTable = $('#'+sGbn+'-list').DataTable( {
		"processing":true
		,"serverSide":true
		,"ajax": {
			"url":sGbn+"List.do"
			,"data":function (d) {
				d.key1=$('#key1').val();
				d.key2=$('#key2').val();
				d.key3=$('#key3').val();
				d.key4=$('#key4').val();
				d.key5=$('#key5').val();
			}
		}
		,"columns":[ 
		        {"data":"auth_id","class":"tbl-auth_id"}
		        , {"data":"auth_nm","class":"tbl-auth_nm"}
		        , {"data":"active_yn","class":"tbl-active_yn"}
		        , {"data":"auth_desc","class":"tbl-auth_desc"}
		        , {"data":"reg_dt","class":"tbl-reg_dt"}
		        , {"data":"reg_usr","class":"tbl-reg_usr"}
		        , {"data":"upd_dt","class":"tbl-upd_dt"}
		        , {"data":"upd_usr","class":"tbl-upd_usr"}
		        , {"class":'authBtn-control',"orderable":false,"data":"","defaultContent":''}
		        , {"class":'details-control',"orderable":false,"data":"","defaultContent":''}
		]
		,"columnDefs":[ 
		        {"targets":[1],"visible":false,"searchable":false}
		        , {"targets":[4],"visible":false,"searchable":false}
		        , {"targets":[5],"visible":false,"searchable":false}
		        , {"targets":[6],"visible":false,"searchable":false}
		        , {"targets":[7],"visible":false,"searchable":false}
		]
		,"order": [[0,"asc"]]
		,"lengthMenu": [[10,15], [10, 15]]
		,"oLanguage": {"sZeroRecords":"<p align='center'>검색결과가 없습니다.</p>"}
		,"sDom":'<"top"Tfl>rt<"bottom"pi>'
		,"oTableTools": {
			"aButtons":[ {
				"sExtends":"text"
				,"sButtonText":"등록"
				,"fnClick":function(nButton,oConfig,oFlash) {
					actEmpty();
				    openModal("add");
				}
			}]
		}
	});
}

function openModal(e) {
	$('#auth-modal').modal();
	$('#auth-modal').modal( {keyboard:false});
	
	if(e=="add") {
		$('#btnInsert').show();
		$('#btnUpdate').hide();
		$('#btnDelete').hide();
		$('#auth-modal').modal('show');
		$('#auth_id').attr('readonly',false);
	} else if(e =='edt') {
		$('#btnInsert').hide();
		$('#btnUpdate').show();
		$('#btnDelete').show();
		$('#auth-modal').modal('show');
		$('#auth_id').attr('readonly',true);
	}
}
function actEmpty() {
	openGbn="add";
	$('#auth_id').val('');
	$('#auth_nm').val('');
	$('#active_yn').val('Y');
	$('#auth_desc').val('');
	$('#reg_dt').val('');
	$('#reg_usr').val($('#loginId').val());
	$('#upd_dt').val('');
	$('#upd_usr').val();
}

function format(row) {
	openGbn="update";
	$('#auth_id').val(row.data().auth_id);
	$('#auth_nm').val(row.data().auth_nm);
	$('#active_yn').val(row.data().active_yn);
	$('#auth_desc').val(row.data().auth_desc);
	$('#reg_dt').val(row.data().reg_dt);
	$('#reg_usr').val(row.data().reg_usr);
	$('#upd_dt').val(row.data().upd_dt);
	$('#upd_usr').val(row.data().upd_usr);
}

function actAjax(act){
    $('#'+sGbn+'-form').bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            auth_id: {validators: {notEmpty: {message: '필수 입력사항입니다.'}}},
            auth_nm: {validators: {notEmpty: {message: '필수 입력사항입니다.'}}},
            active_yn: {validators: {notEmpty: {message: '필수 선택사항입니다.'}}}
        }
    })
    .on('success.form.bv', function(e) {
        e.preventDefault();
        var $form = $(e.target);
        var sMsg = "";

       	if(act == "insert" && openGbn =="update"){ act="update"; }
       	
        if(act==("insert")){ sMsg = "등록이"; }
        else if(act==("update")){ sMsg = "수정이"; }
        else if(act==("delete")){ 
            if (!confirm("정말 삭제하시겠습니까? ")) { return false; } 
            sMsg = "삭제가"; 
        }
        else{ alert("잘못된 접근입니다."); return false; }
        // 이중처리 되는 경우가 있어 추가함
        iSubmit++;
        if( iSubmit != 1){return false;}   
        $form.attr('action', sGbn+'Act.do');  
        
        $.post(
        		$form.attr('action')
        		, $form.serialize()+"&act="+act
        		, function(result) {
		            if(result == 1) { alert(sMsg+" 되었습니다.") }
		            else { alert(sMsg+" 실패하였습니다.") }
		            $('#'+sGbn+'-modal').modal('hide');
		        }
        	, 'json'
        );
    });	
}

function gridList2(){
    oTable2 = $('#'+sGbn2+'-list').DataTable({
        "processing":true,
        "serverSide":true,
        "ajax":{
        	"url":sGbn2+"List.do",
            "data":function (d){
                d.key1=$('#key1').val();
                d.key2=$('#key2').val();
                d.key3=$('#key3').val();
                d.key4=$('#key4').val();
                d.key5=$('#key5').val();
            }
        },
        "columns":[
                   {"data":"menu_id","class":"tbl-menu_id"},
                   {"data":"auth_id","class":"tbl-auth_id"},
                   {"data":"abv_menu_id","class":"tbl-abv_menu_id"},
                   {"data":"menu_level","class":"tbl-menu_level"},
                   {"data":"menu_nm","class":"tbl-menu_nm"},
                   {"data":"prgm_path","class":"tbl-prgm_path"},
                   {"data":"active_yn","class":"tbl-active_yn"},
                   {"data":"reg_dt","class":"tbl-reg_dt"},
                   {"data":"reg_usr","class":"tbl-reg_usr"},
                   {"data":"upd_dt","class":"tbl-upd_dt"},
                   {"data":"upd_usr","class":"tbl-upd_usr"}
         ],
         "columnDefs":[
                   {"targets":[0],"visible":false,"searchable":false},
                   {"targets":[1],"visible":false,"searchable":false},
                   {"targets":[2],"visible":false,"searchable":false},
                   {"targets":[3],"visible":false,"searchable":false},
                   {"render":function(data,type,row){
                        if(data == "0"){
                            vColor = "red";
                            vAct = "insert";
                        }else{
                            vColor = "blue";
                            vAct = "update";
                        }
                        vMenu_id = row.menu_level == "1" ? "": row.menu_id;
                        vRet = "<a style='cursor:pointer;' onclick='javascript:actActive_yn(\""+vMenu_id+"\",\""+vAct+"\", \""+data+"\", \""+row.abv_menu_id+"\");'><b><font color='"+vColor+"'>"+getValue(data,aCode_yn2)+"</font></b></a>";
                        return vRet;
                        },
                        "targets":6
                    },
                   {"targets":[7],"visible":false,"searchable":false},
                   {"targets":[8],"visible":false,"searchable":false},
                   {"targets":[9],"visible":false,"searchable":false},
                   {"targets":[10],"visible":false,"searchable":false}
         ],
         "order": [[0,"asc"]],
         "lengthMenu": [["10"], [10]],
         "oLanguage":{"sZeroRecords":"<p align='center'>검색결과가 없습니다.</p>" },
         "sDom":'<"top"f>rt<"bottom"pi>'
    });
}

function onClick(event, treeId, treeNode, clickFlag) {
    var dAry = "";
    try { 
        dAry = treeNode.data.split("/%/");
        if(dAry[0] != ""){
        	$('#key1').val(parseInt(dAry[2], 10)+1);
	    	$('#key2').val(dAry[1]);
        }else{
            $('#key1').val("1");
            $('#key2').val("");
        }
        oTable2.ajax.reload();
    }catch(e){}   
}

function actActive_yn(menu_id, act, active_yn, abv_menu_id){
    active_yn = active_yn == "Y"?"N":"Y";   
    $.ajax({
        type:"POST",
        url: sGbn2+'Act.do',
        data: {
        	act					: act,
            menu_id         	: menu_id,
            auth_id         	: $("#key3").val(),
            abv_menu_id			: abv_menu_id,
            active_yn       	: active_yn,
            loginId       		: $("#loginId").val()
        },
        success:function( ret ) {
        	if(act == "insert"){
        		if(ret == 1) { alert("권한이 등록 되었습니다."); }
                else if( ret > 1){ alert( ret + "건 권한이 등록 되었습니다."); }
                else { alert( "실패하였습니다."); }
        	} 
            oTable2.ajax.reload();          
        },
        error:function(e) { alert(e.responseText); }
    });
}