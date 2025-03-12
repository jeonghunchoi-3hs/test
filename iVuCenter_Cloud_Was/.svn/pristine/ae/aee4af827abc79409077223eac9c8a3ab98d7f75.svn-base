var oTable;
var oTable2;
var sGbn;
var sGbn2;
var iSubmit = 0;
var openGbn = "add";

$(document).ready(function() {
    // select box
    setComboBox( aCode_yn,"divModal-use_yn","use_yn","100%", " class='form-control' " );
    setComboBox( aCode_yn,"divModal2-use_yn","sub_use_yn","100%", " class='form-control' " );
    setComboBoxDb( "dbSelect.do","divModal-cmm_cd","sub_cmm_cd","100%", " class='form-control' ", "", "","" );
    
    sGbn = $("#subname").val();
    sGbn2 = $("#subname2").val();
    
    // 공통코드 리스트
    gridList();
    // 상세 공통코드 리스트
    gridList2();
    
    // 공통코드 db처리
    $('#btnInsert').on( 'click', function () { actAjax('insert'); } );
    $('#btnUpdate').on( 'click', function () { actAjax('update'); } );
    $('#btnDelete').on( 'click', function () { actAjax('delete'); } );
    
    // 상세 공통코드 db처리
    $('#btnDtlInsert').on( 'click', function () { actAjax2('insert'); } );
    $('#btnDtlUpdate').on( 'click', function () { actAjax2('update'); } );
    $('#btnDtlDelete').on( 'click', function () { actAjax2('delete'); } );
    
    // 공통 코드 상세보기 버튼 이벤트
    $('#'+sGbn+'-list tbody').on( 'click', 'td.details-control', function () {
        openModal("edt");
        format( oTable.row( $(this).closest('tr') ) );
    } );
    
    // 상세 공통 코드 상세보기 버튼 이벤트
    $('#'+sGbn2+'-list tbody').on( 'click', 'td.details-control', function () {
        openModal2("edt");
        format2( oTable2.row( $(this).closest('tr') ) );
    } );
    
    // listCmmCd tr 이벤트
    $('#'+sGbn+'-list tbody').on('click', 'td.tbl-cmm_cd', function () {
        $('#key').val( oTable.row( $(this).closest('tr') ).data().cmm_cd);
        // reload 처리가 무조껀 처음에 있는 dataTable에만 처리된다. oTable2 이벤트를 해도 동일
        //oTable2.ajax.reload(); 
        location.href= sGbn+"?key="+oTable.row( $(this).closest('tr') ).data().cmm_cd ;
    } );
    
	$('#'+sGbn+'-modal').on('hidden.bs.modal', function () { location.reload(); });
	$('#'+sGbn2+'-modal').on('hidden.bs.modal', function () { location.reload(); });
});

//등록
function setNewModal(){
	actEmpty();
	openModal("add");
}

function actAjax(act){
    $('#'+sGbn+'-form').bootstrapValidator({
        fields: {
            cmm_cd: {validators: {notEmpty: {message: '필수 입력사항입니다.'},stringLength: {max : 5,message : "5글자 이하로 입력하십시오."}}},
            cmm_cd_nm: {validators: {notEmpty: {message: '필수 입력사항입니다.'}}},
            use_yn: {validators: {notEmpty: {message: '필수 선택사항입니다.'}}}
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
        iSubmit++;
        if( iSubmit != 1){return false;}
        $form.attr('action', sGbn+'Act.do');      

        $.post($form.attr('action'), $form.serialize()+"&act="+act, function(result) {
            if(result == 1) { alert(sMsg+" 되었습니다.") }
            else { alert(sMsg+" 실패하였습니다.") }
            $('#'+sGbn+'-modal').modal('hide');
        }, 'json');
    }); 
}

/*
 * 상세코드 등록
 */ 
function actAjax2(act){
    $('#'+sGbn2+'-form').bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            sub_cmm_cd: {validators: {notEmpty: {message: '필수 입력사항입니다.'}}}, 
            cmm_dtl_cd: {validators: {notEmpty: {message: '필수 입력사항입니다.'}}},
            sub_use_yn: {validators: {notEmpty: {message: '필수 선택사항입니다.'}}}
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
        $form.attr('action', sGbn2+'Act.do');

        $.post($form.attr('action'), $form.serialize()+"&act="+act, function(result) {
            if(result == 1) { alert(sMsg+" 되었습니다.") }
            else { alert(sMsg+" 실패하였습니다.") }
            $('#'+sGbn2+'-modal').modal('hide');
        }, 'json');
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
			"data":"cmm_cd","class":"tbl-cmm_cd"
		}
		, {
			"data":"cmm_cd_nm","class":"tbl-cmm_cd_nm"
		}
		, {
			"data":"opt_nm1","class":"tbl-opt_nm1"
		}
		, {
			"data":"opt_nm2","class":"tbl-opt_nm2"
		}
		, {
			"data":"opt_nm3","class":"tbl-opt_nm3"
		}
		, {
			"data":"opt_nm4","class":"tbl-opt_nm4"
		}
		, {
			"data":"opt_nm5","class":"tbl-opt_nm5"
		}
		, {
			"data":"opt_nm6","class":"tbl-opt_nm6"
		}
		, {
			"data":"opt_nm7","class":"tbl-opt_nm7"
		}
		, {
			"data":"opt_nm8","class":"tbl-opt_nm8"
		}
		, {
			"data":"opt_nm9","class":"tbl-opt_nm9"
		}
		, {
			"data":"opt_nm10","class":"tbl-opt_nm10"
		}
		, {
			"data":"reg_dt","class":"tbl-reg_dt"
		}
		, {
			"data":"reg_usr","class":"tbl-reg_usr"
		}
		, {
			"data":"upd_dt","class":"tbl-upd_dt"
		}
		, {
			"data":"upd_usr","class":"tbl-upd_usr"
		}
		, {
			"data":"use_yn","class":"tbl-use_yn"
		}
		, {
			"class":'details-control',"orderable":false,"data":"","defaultContent":''
		}
		,],"columnDefs":[ {
			"targets":[2],"visible":false,"searchable":false
		}
		, {
			"targets":[3],"visible":false,"searchable":false
		}
		, {
			"targets":[4],"visible":false,"searchable":false
		}
		, {
			"targets":[5],"visible":false,"searchable":false
		}
		, {
			"targets":[6],"visible":false,"searchable":false
		}
		, {
			"targets":[7],"visible":false,"searchable":false
		}
		, {
			"targets":[8],"visible":false,"searchable":false
		}
		, {
			"targets":[9],"visible":false,"searchable":false
		}
		, {
			"targets":[10],"visible":false,"searchable":false
		}
		, {
			"targets":[11],"visible":false,"searchable":false
		}
		, {
			"targets":[12],"visible":false,"searchable":false
		}
		, {
			"targets":[13],"visible":false,"searchable":false
		}
		, {
			"targets":[14],"visible":false,"searchable":false
		}
		, {
			"targets":[15],"visible":false,"searchable":false
		}
		, {
			"targets":[16],"visible":false,"searchable":false
		}
		,],"order": [[12,"asc"]],"lengthMenu": [[10,15], [10, 15]],"oLanguage": {
			"sZeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
		}
		,"sDom":'<"top"Tfl>rt<"bottom"pi>',"oTableTools": {
			"aButtons":[ {
				"sExtends":"text","sButtonText":"등록","fnClick":function(nButton,oConfig,oFlash) {
					setNewModal();
				}
			}
			]
		}
	}
	);
}
function openModal(e) {
	$('#code-modal').modal();
	$('#code-modal').modal( {
		keyboard:false
	}
	);
	if(e=="add") {
		$('#btnInsert').show();
		$('#btnUpdate').hide();
		$('#btnDelete').hide();
		$('#code-modal').modal('show');
		$('#cmm_cd').attr('readonly',false);
	} else if(e =='edt') {
		$('#btnInsert').hide();
		$('#btnUpdate').show();
		$('#btnDelete').show();
		$('#code-modal').modal('show');
		$('#cmm_cd').attr('readonly',true);
	}
}
function actEmpty() {
	openGbn="add";
	$('#cmm_cd').val('');
	$('#cmm_cd_nm').val('');
	$('#opt_nm1').val('');
	$('#opt_nm2').val('');
	$('#opt_nm3').val('');
	$('#opt_nm4').val('');
	$('#opt_nm5').val('');
	$('#opt_nm6').val('');
	$('#opt_nm7').val('');
	$('#opt_nm8').val('');
	$('#opt_nm9').val('');
	$('#opt_nm10').val('');
	$('#reg_dt').val('');
	$('#reg_usr').val($('#loginId').val());
	$('#upd_dt').val('');
	$('#upd_usr').val('');
	$('#use_yn').val( 'Y' );
}
function format(row) {
	openGbn="update";
	$('#cmm_cd').val(row.data().cmm_cd);
	$('#cmm_cd_nm').val(row.data().cmm_cd_nm);
	$('#opt_nm1').val(row.data().opt_nm1);
	$('#opt_nm2').val(row.data().opt_nm2);
	$('#opt_nm3').val(row.data().opt_nm3);
	$('#opt_nm4').val(row.data().opt_nm4);
	$('#opt_nm5').val(row.data().opt_nm5);
	$('#opt_nm6').val(row.data().opt_nm6);
	$('#opt_nm7').val(row.data().opt_nm7);
	$('#opt_nm8').val(row.data().opt_nm8);
	$('#opt_nm9').val(row.data().opt_nm9);
	$('#opt_nm10').val(row.data().opt_nm10);
	$('#reg_dt').val(row.data().reg_dt);
	$('#reg_usr').val(row.data().reg_usr);
	$('#upd_dt').val(row.data().upd_dt);
	$('#upd_usr').val(row.data().upd_usr);
	$('#use_yn').val(row.data().use_yn);
}

function gridList2() {
	oTable2 = $('#'+sGbn2+'-list').DataTable( {
		"processing":true
		,"serverSide":true
		,"ajax": {
			"url":sGbn2+"List.do"
			,"data":function (d) {
				d.key1=$('#key1').val();
				d.key2=$('#key2').val();
				d.key3=$('#key3').val();
				d.key4=$('#key4').val();
				d.key5=$('#key5').val();
			}
		}
		,"columns":[ {
			"data":"cmm_cd"
		}
		, {
			"data":"cmm_dtl_cd"
		}
		, {
			"data":"cmm_dtl_nm"
		}
		, {
			"data":"opt_val1"
		}
		, {
			"data":"opt_val2"
		}
		, {
			"data":"opt_val3"
		}
		, {
			"data":"opt_val4"
		}
		, {
			"data":"opt_val5"
		}
		, {
			"data":"opt_val6"
		}
		, {
			"data":"opt_val7"
		}
		, {
			"data":"opt_val8"
		}
		, {
			"data":"opt_val9"
		}
		, {
			"data":"opt_val10"
		}
		, {
			"data":"reg_dt"
		}
		, {
			"data":"reg_usr"
		}
		, {
			"data":"upd_dt"
		}
		, {
			"data":"upd_usr"
		}
		, {
			"data":"use_yn"
		}
		, {
			"class":'details-control',"orderable":false,"data":"","defaultContent":''
		}
		,],"columnDefs":[ {
			"targets":[3],"visible":false,"searchable":false
		}
		, {
			"targets":[4],"visible":false,"searchable":false
		}
		, {
			"targets":[5],"visible":false,"searchable":false
		}
		, {
			"targets":[6],"visible":false,"searchable":false
		}
		, {
			"targets":[7],"visible":false,"searchable":false
		}
		, {
			"targets":[8],"visible":false,"searchable":false
		}
		, {
			"targets":[9],"visible":false,"searchable":false
		}
		, {
			"targets":[10],"visible":false,"searchable":false
		}
		, {
			"targets":[11],"visible":false,"searchable":false
		}
		, {
			"targets":[12],"visible":false,"searchable":false
		}
		, {
			"targets":[13],"visible":false,"searchable":false
		}
		, {
			"targets":[14],"visible":false,"searchable":false
		}
		, {
			"targets":[15],"visible":false,"searchable":false
		}
		, {
			"targets":[16],"visible":false,"searchable":false
		}
		, {
			"targets":[17],"visible":false,"searchable":false
		}
		,],"order": [[12,"asc"]],"lengthMenu": [[10, 15], [10, 15]],"oLanguage": {
			"sZeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
		}
		,"sDom":'<"top"Tfl>rt<"bottom"pi>',"oTableTools": {
			"aButtons":[ {
				"sExtends":"text","sButtonText":"등록","fnClick":function(nButton,oConfig,oFlash) {
					actEmpty2();
					openModal2("add");
				}
			}
			]
		}
	}
	);
}
function openModal2(e) {
	$('#codeDtl-modal').modal();
	$('#codeDtl-modal').modal( {
		keyboard:false
	}
	);
	if(e=="add") {
		$('#btnDtlInsert').show();
		$('#btnDtlUpdate').hide();
		$('#btnDtlDelete').hide();
		$('#codeDtl-modal').modal('show');
		$('#sub_cmm_cd').attr('disabled',false);
		$('#cmm_dtl_cd').attr('readonly',false);
	} else if(e =='edt') {
		$('#btnDtlInsert').hide();
		$('#btnDtlUpdate').show();
		$('#btnDtlDelete').show();
		$('#codeDtl-modal').modal('show');
		$('#sub_cmm_cd').attr('disabled',true);
		$('#cmm_dtl_cd').attr('readonly',true);
	}
}
function actEmpty2() {
	openGbn="add";
	$('#sub_cmm_cd').val('');
	$('#cmm_dtl_cd').val('');
	$('#cmm_dtl_nm').val('');
	$('#opt_val1').val('');
	$('#opt_val2').val('');
	$('#opt_val3').val('');
	$('#opt_val4').val('');
	$('#opt_val5').val('');
	$('#opt_val6').val('');
	$('#opt_val7').val('');
	$('#opt_val8').val('');
	$('#opt_val9').val('');
	$('#opt_val10').val('');
	$('#sub_reg_dt').val('');
	$('#sub_reg_usr').val($('#loginId').val());
	$('#sub_upd_dt').val('');
	$('#sub_upd_usr').val('');
	$('#sub_use_yn').val( 'Y' );
}
function format2(row) {
	openGbn="update";
	$('#sub_cmm_cd').val(row.data().cmm_cd);
	$('#cmm_dtl_cd').val(row.data().cmm_dtl_cd);
	$('#cmm_dtl_nm').val(row.data().cmm_dtl_nm);
	$('#opt_val1').val(row.data().opt_val1);
	$('#opt_val2').val(row.data().opt_val2);
	$('#opt_val3').val(row.data().opt_val3);
	$('#opt_val4').val(row.data().opt_val4);
	$('#opt_val5').val(row.data().opt_val5);
	$('#opt_val6').val(row.data().opt_val6);
	$('#opt_val7').val(row.data().opt_val7);
	$('#opt_val8').val(row.data().opt_val8);
	$('#opt_val9').val(row.data().opt_val9);
	$('#opt_val10').val(row.data().opt_val10);
	$('#sub_reg_dt').val(row.data().reg_dt);
	$('#sub_reg_usr').val(row.data().reg_usr);
	$('#sub_upd_dt').val(row.data().upd_dt);
	$('#sub_upd_usr').val(row.data().upd_usr);
	$('#sub_use_yn').val(row.data().use_yn);
}