var oTable;
var sGbn;
var iSubmit = 0;
var openGbn = "add";
var setting = {
		callback: {
			onClick: onClick
		}
	};

$(document).ready(function() {
	// 페이지 구분값 
	sGbn = $("#subname").val();
	
	// select box
	setComboBox( aCode_yn,"divBox-ext-active_yn","ext-active_yn","100%", " class='form-control2' " );
	setComboBox( aCode_icon,"divBox-abv_menu_img","ext-abv_menu_img","100%", " class='form-control2' " );
	setText("divModal-ext-abv_menu_id", "ext-abv_menu_id", "", "상위 메뉴식별자", "100%", " class='form-control2' " );
	setText("divModal-ext-prgm_path", "ext-prgm_path", "", "프로그램 경로", "100%", " class='form-control2' " );
	
	setComboBox( aCode_yn,"divModal-active_yn","active_yn","100%", " class='form-control' " );
	setComboBox( aCode_menu_level,"divModal-menu_level","menu_level","100%", " class='form-control' " );
	setComboBox( aCode_icon,"divModal-abv_menu_img","abv_menu_img","100%", " class='form-control' " );
	setText("divModal-abv_menu_id", "abv_menu_id", "", "상위 메뉴식별자", "100%", " class='form-control' " );
	setText("divModal-prgm_path", "prgm_path", "", "프로그램 경로", "100%", " class='form-control' " );
	
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
    
    // 설명 자동 입력 처리
    $('#menu_nm').blur(function (){
    	if($("#menu_desc").val() == ""){
			$("#menu_desc").val( $("#menu_nm").val() );	
    	}else{    		
    		if($("#menu_desc").val().substring($("#menu_desc").val().length-2, $("#menu_desc").val().length) == "- "){
    			$("#menu_desc").val($("#menu_desc").val()+$("#menu_nm").val());		
    		}
    	}
    });
    
    // 설명 자동 입력 처리
    $('#ext-menu_nm').blur(function (){
    	if($("#ext-menu_desc").val() == ""){
			$("#ext-menu_desc").val( $("#ext-menu_nm").val() );	
    	}else{    		
    		if($("#ext-menu_desc").val().substring($("#ext-menu_desc").val().length-2, $("#ext-menu_desc").val().length) == "- "){
    			$("#ext-menu_desc").val($("#ext-menu_desc").val()+$("#ext-menu_nm").val());		
    		}
    	}
    });
    
	$("#ext-btnUpdate").on('click', function(){ actSubAjax('update'); });
	$("#ext-btnDelete").on('click', function(){ actSubAjax('delete'); });
	
    $('#menu_order').keyup(function () { number_only(this); } );
    $('#menu_order').focus( function(){ changeValue(this, "num"); });
    $('#menu_order').blur( function(){ changeValue(this, "num"); });
    
	$('#'+sGbn+'-modal').on('hidden.bs.modal', function () { location.reload(); });
});

/**
 * 리스트 출력
 */
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
		             {"data":"menu_id","class":"tbl-menu_id"}
		             , {"data":"abv_menu_id","class":"tbl-abv_menu_id"}
		             , {"data":"menu_level","class":"tbl-menu_level"}
		             , {"data":"menu_nm","class":"tbl-menu_nm"}
		             , {"data":"prgm_path","class":"tbl-prgm_path"}
		             , {"data":"abv_menu_img","class":"tbl-abv_menu_img"}
		             , {"data":"menu_order","class":"tbl-menu_order"}
		             , {"data":"menu_desc","class":"tbl-menu_desc"}
		             , {"data":"active_yn","class":"tbl-active_yn"}
		             , {"data":"reg_dt","class":"tbl-reg_dt"}
		             , {"data":"reg_usr","class":"tbl-reg_usr"}
		             , {"data":"upd_dt","class":"tbl-upd_dt"}
		             , {"data":"upd_usr","class":"tbl-upd_usr"}
		             , {"class":'details-control',"orderable":false,"data":"","defaultContent":''}
		]
		,"columnDefs":[ 
		                {"targets":[0],"visible":false,"searchable":false}
		                , {"targets":[1],"visible":false,"searchable":false}
		                , {"targets":[2],"visible":false,"searchable":false}
		                , {"targets":[5],"visible":false,"searchable":false}
		                , {"targets":[7],"visible":false,"searchable":false}
		                , {"targets":[9],"visible":false,"searchable":false}
		                , {"targets":[10],"visible":false,"searchable":false}
		                , {"targets":[11],"visible":false,"searchable":false}
		                , {"targets":[12],"visible":false,"searchable":false}
		]
		,"order":[[6,"asc"]]
		,"lengthMenu":[[5,10],[5,10]]
		,"oLanguage": {
			"sZeroRecords":"<p align='center'>검색결과가 없습니다.</p>"
		}
		,"sDom":'<"top"Tfl>rt<"bottom"pi>'
		,"oTableTools": {
			"aButtons":[ {
				"sExtends":"text"
				,"sButtonText":"등록"
				,"fnClick":function(nButton,oConfig,oFlash) {
					actEmpty();
					openModal("add");

					if($("#ext-abv_menu_id").val() != ""){
						$("#abv_menu_id").val($("#ext-abv_menu_id").val());
						$("#menu_level").val(parseInt($("#ext-menu_level").val(),10)+1);
						$("#menu_desc").val($("#ext-menu_desc").val()+" - ");
						$("#abv_menu_img").val($("#ext-abv_menu_img").val());
					}
				}
			}]
		}
	});
}

/**
 * modal 버튼 제어
 * @param e 구분값
 */
function openModal(e) {
	$('#menu-modal').modal();
	$('#menu-modal').modal( { keyboard: false } );
	
	if(e=="add") {
		$('#btnInsert').show();
		$('#btnUpdate').hide();
		$('#btnDelete').hide();
		$('#menu-modal').modal('show');
		$('#prgm_path').attr('readonly',false);
		$('#modal-menu_level').show();
	}
	else if(e =='edt') {
		$('#btnInsert').hide();
		$('#btnUpdate').show();
		$('#btnDelete').show();
		$('#menu-modal').modal('show');
		$('#modal-menu_level').hide();
	}
}

/**
 * modal 데이터 초기화
 */
function actEmpty() {
	openGbn="add";
	$('#menu_id').val('');
	$('#abv_menu_id').val('');
	$('#menu_level').val('');
	$('#menu_nm').val('');
	$('#prgm_path').val('');
	$('#abv_menu_img').val('');
	$('#menu_order').val('');
	$('#menu_desc').val('');
	$('#active_yn').val( 'Y' );
	$('#reg_dt').val('');
	$('#reg_usr').val($('#loginId').val());
	$('#upd_dt').val('');
	$('#upd_usr').val();
}

/**
 * modal 데이터
 * @param row obj
 */
function format(row) {
	openGbn="update";
	$('#menu_id').val(row.data().menu_id);
	$('#abv_menu_id').val(row.data().abv_menu_id);
	$('#menu_level').val(row.data().menu_level);
	$('#menu_nm').val(row.data().menu_nm);
	$('#abv_menu_img').val(row.data().abv_menu_img);
	$('#menu_order').val(row.data().menu_order);
	$('#menu_desc').val(row.data().menu_desc);
	$('#active_yn').val(row.data().active_yn);
	$('#reg_dt').val(row.data().reg_dt);
	$('#reg_usr').val(row.data().reg_usr);
	$('#upd_dt').val(row.data().upd_dt);
	$('#upd_usr').val(row.data().upd_usr);
	
	if($('#menu_level').val() == "1"){
		setText("divModal-abv_menu_id", "abv_menu_id", row.data().abv_menu_id, "상위 메뉴식별자", "100%", " class='form-control' " );
		setComboBoxDb( "dbSelect.do","divModal-prgm_path","prgm_path","100%", " class='form-control' ", row.data().abv_menu_id, row.data().prgm_path,"" );
	}
	else{ 
		setComboBoxDb( "dbSelect.do","divModal-abv_menu_id","abv_menu_id","100%", " class='form-control' ", $("#ext-menu_level").val(), $("#abv_menu_id").val(),"" );
		$('#modal-abv_menu_id').show();
		setText("divModal-prgm_path", "prgm_path", row.data().prgm_path, "프로그램 경로", "100%", " class='form-control' " );
		$('#prgm_path').attr('readonly',true);
	}
}

/**
 * tree 제어
 * @param event
 * @param treeId
 * @param treeNode
 * @param clickFlag
 */
function onClick(event, treeId, treeNode, clickFlag) {
	var dAry = "";
	try	{ 
		dAry = treeNode.data.split("/%/");
		if(dAry[0] != ""){
	    	$('#key1').val(parseInt(dAry[2], 10)+1);
	    	$('#key2').val(dAry[1]);
	    	
	    	$("#ext-menu_id").val(dAry[0]);
	    	$("#ext-menu_level").val(dAry[2]);
	    	$("#ext-menu_nm").val(dAry[3]);
	    	$("#ext-abv_menu_img").val(dAry[5]);
	    	$("#ext-menu_order").val(dAry[6]);
	    	$("#ext-menu_desc").val(dAry[7]);
	    	$("#ext-active_yn").val(dAry[8]);
			

	    	if($('#ext-menu_level').val() == "1"){
	    		setComboBoxDb( "dbSelect.do","divModal-ext-prgm_path","ext-prgm_path","100%", " class='form-control2' ", dAry[1], dAry[4],"" );
				setText("divModal-ext-abv_menu_id", "ext-abv_menu_id", dAry[1], "상위 메뉴식별자", "100%", " class='form-control2' " );
	    		$('#ext-abv_menu_id').attr('readonly',true);
	    	}
	    	else{ 
	    		setText("divModal-ext-prgm_path", "ext-prgm_path", dAry[4], "프로그램 경로", "100%", " class='form-control2' " );
				setComboBoxDb( "dbSelect.do","divModal-ext-abv_menu_id","ext-abv_menu_id","100%", " class='form-control2' ", (parseInt(dAry[2], 10)-1), dAry[1],"" );
	    		$('#ext-prgm_path').attr('readonly',true);
	    	}
		}else{
	    	$('#key1').val("1");
	    	$('#key2').val("");

	    	$("#ext-menu_id").val("");
	    	$("#ext-abv_menu_id").val("");
	    	$("#ext-menu_level").val("1");
	    	$("#ext-menu_nm").val("");
	    	$("#ext-abv_menu_img").val("");
	    	$("#ext-menu_order").val("");
	    	$("#ext-menu_desc").val("");
	    	$("#ext-active_yn").val("");
	    	setText("divModal-ext-prgm_path", "ext-prgm_path", "", "", "100%", " class='form-control2' " );
			setText("divModal-ext-abv_menu_id", "ext-abv_menu_id", "", "상위 메뉴식별자", "100%", " class='form-control2' " );
		}
    	oTable.ajax.reload();
		$('#divMenuView').show();    	
	}catch(e){}
	
}

/**
 * main action
 * @param act
 */
function actAjax(act){
    $('#'+sGbn+'-form').bootstrapValidator({
        message: 'This value is not valid',
        fields: {
        	menu_id: {validators: {notEmpty: {message: '필수 입력사항입니다.'}}},
            abv_menu_id: {validators: {notEmpty: {message: '필수 입력사항입니다.'}}},
            menu_level: {validators: {notEmpty: {message: '필수 입력사항입니다.'}}},
            menu_nm: {validators: {notEmpty: {message: '필수 입력사항입니다.'}}},
            menu_order: {validators: {notEmpty: {message: '필수 입력사항입니다.'}}},
            active_yn: {validators: {notEmpty: {message: '필수 입력사항입니다.'}}}
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

/**
 * sub action
 * @param act
 */
function actSubAjax(act){

	if($("#ext-menu_id").val() == ""){ alert("메뉴식별자는 필수 입력 사항입니다."); return ;}
    if($("#ext-abv_menu_id").val() == ""){alert("상위 메뉴식별자는 필수 입력 사항입니다."); return ;}
    if($("#ext-menu_level").val() == ""){alert("메뉴레벨은 필수 입력 사항입니다."); return ;}
    if($("#ext-menu_nm").val() == ""){alert("메뉴이름은 필수 입력 사항입니다."); return ;}
    if($("#ext-menu_order").val() == ""){alert("순번은 필수 입력 사항입니다."); return ;}
    if($("#ext-active_yn").val() == ""){alert("활성화여부는 필수 입력 사항입니다."); return ;}
    
	$.ajax({
		type:"POST",
		url: sGbn+'Act.do',
		data: {
			act				: act,
			menu_id			: $("#ext-menu_id").val(),
			abv_menu_id		: $("#ext-abv_menu_id").val(),
			menu_level		: $("#ext-menu_level").val(),
			menu_nm			: $("#ext-menu_nm").val(),
			prgm_path		: $("#ext-prgm_path").val(),
			abv_menu_img	: $("#ext-abv_menu_img").val(),
			menu_order		: $("#ext-menu_order").val(),
			menu_desc		: $("#ext-menu_desc").val(),
			active_yn		: $("#ext-active_yn").val(),
			upd_usr			: $('#loginId').val()
		},
		success:function( ret ) {
			if(ret == 1) { alert("처리 되었습니다."); }
		    else { alert( "실패하였습니다."); }
			location.href="menu";			
		},
		error:function(e) { alert(e.responseText); }
	});
}