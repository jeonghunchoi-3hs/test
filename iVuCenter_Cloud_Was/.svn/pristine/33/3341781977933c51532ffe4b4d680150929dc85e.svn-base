var oTable;
var sGbn;
var iSubmit = 0;
var openGbn = "add";

$(document).ready(function() {
    // 페이지 구분값 
    sGbn = $("#subname").val();
    
    // select box
    setComboBox( aCode_yn,"divModal-active_yn","active_yn","100%", " class='form-control' " );
    setComboBox( aCode_yn,"divModal-ip_chck_yn","ip_chck_yn","100%", " class='form-control' " );
    setComboBoxDb( "dbSelect.do","divModal-auth_id","auth_id","100%", " class='form-control' ", "", "","" );
    // 리스트
    gridList();
    // DB 처리
    $('#btnInsert').on( 'click', function () { chkEmail('#admin_id'); actAjax('insert'); } );
    $('#btnUpdate').on( 'click', function () { actAjax('update'); } );
    $('#btnDelete').on( 'click', function () { actAjax('delete'); } );
    
    $('#admin_id').blur( function(){ chkEmail(this); });
    
    // 상세보기 버튼 이벤트
    $('#'+sGbn+'-list tbody').on( 'click', 'td.details-control', function () {
        openModal("edt");
        format( oTable.row( $(this).closest('tr') ) );
    });
    
	$('#'+sGbn+'-modal').on('hidden.bs.modal', function () { location.reload(); });
});

function actAjax(act){
    $('#'+sGbn+'-form').bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            admin_id: {validators: {notEmpty: {message: '필수 입력사항입니다.'}}},
            auth_id: {validators: {notEmpty: {message: '필수 입력사항입니다.'}}},
            active_yn: {validators: {notEmpty: {message: '필수 선택사항입니다.'}}},
            retry_cnt: {validators: {notEmpty: {message: '필수 입력사항입니다.'}}}
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
		,"columns":[ {
			"data":"admin_id","class":"tbl-admin_id"
		}
		, {
			"data":"admin_nm","class":"tbl-admin_nm"
		}
		, {
			"data":"password","class":"tbl-password"
		}
		, {
			"data":"auth_id","class":"tbl-auth_id"
		}
		, {
			"data":"description","class":"tbl-description"
		}
		, {
			"data":"active_yn","class":"tbl-active_yn"
		}
		, {
			"data":"ip_chck_yn","class":"tbl-ip_chck_yn"
		}
		, {
			"data":"apptv_ip","class":"tbl-apptv_ip"
		}
		, {
			"data":"retry_cnt","class":"tbl-retry_cnt"
		}
		, {
			"class":'details-control',"orderable":false,"data":"","defaultContent":''
		}
		],"columnDefs":[ {
			"targets":[2],"visible":false,"searchable":false
		}
		, {
			"targets":[4],"visible":false,"searchable":false
		}
		, {
			"targets":[6],"visible":false,"searchable":false
		}
		, {
			"targets":[7],"visible":false,"searchable":false
		}
		, {
			"targets":[8],"visible":false,"searchable":false
		}]
		,"order": [[0,"asc"]]
		,"lengthMenu": [[10,15], [10, 15]]
		,"oLanguage": { "sZeroRecords":"<p align='center'>검색결과가 없습니다.</p>" }
		,"sDom":'<"top"Tfl>rt<"bottom"pi>',"oTableTools": {
			"aButtons":[ {
				"sExtends":"text"
				,"sButtonText":"등록"
				,"fnClick":function(nButton,oConfig,oFlash) {
					actEmpty();
				    openModal("add");
				}
			}]
		}
	}
	);
}
function openModal(e) {
	$('#'+sGbn+'-modal').modal();
	$('#'+sGbn+'-modal').modal( {keyboard:false });
	$('#admin-modal').modal('show');
	
	if(e=="add") {
		$('#btnInsert').show();
		$('#btnUpdate').hide();
		$('#btnDelete').hide();
		$('#admin_id').attr('readonly',false);
		$('#retry_cnt').attr('readonly',false);
	} else if(e =='edt') {
		$('#btnInsert').hide();
		$('#btnUpdate').show();
		$('#btnDelete').show();
		$('#admin_id').attr('readonly',true);
		$('#retry_cnt').attr('readonly',true);
	}
}
function actEmpty() {
	openGbn="add";
	$('#admin_id').val('');
	$('#admin_nm').val('');
	$('#password').val( '' );
	$('#auth_id').val('');
	$('#description').val('');
	$('#active_yn').val( 'Y' );
	$('#ip_chck_yn').val( 'N' );
	$('#apptv_ip').val('');
	$('#retry_cnt').val( '0' );
}
function format(row) {
	openGbn="update";
    if( row.data().auth_id == AdminAuth.toUpperCase()){
        $("#modal-auth_id").hide();
    }else{
        $("#modal-auth_id").show();
    }
	$('#admin_id').val(row.data().admin_id);
	$('#admin_nm').val(row.data().admin_nm);
	$('#auth_id').val(row.data().auth_id);
	$('#description').val(row.data().description);
	$('#active_yn').val(row.data().active_yn);
	$('#ip_chck_yn').val(row.data().ip_chck_yn);
	$('#apptv_ip').val(row.data().apptv_ip);
	$('#retry_cnt').val(row.data().retry_cnt);
}