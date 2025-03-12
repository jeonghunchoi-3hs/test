var oTable;
var oTable2;
var sGbn;
var sGbn2;
var iSubmit = 0;
var openGbn = "add";

/*
mid
name
img_path
img_name
reg_date
upd_date
*/
$(document).ready(function() {
    // 페이지 구분값 
    sGbn = $("#subname").val();
	sGbn2 = $("#subname2").val();
	 // select box
    setComboBoxDb( "dbSelect.do","divModal-sub_mid","sub_mid","100%", " class='form-control' ", "", "","" );
    // 리스트
    gridList();
	gridList2();
    // DB 처리
    $('#btnInsert').on( 'click', function () { actAjax('insert'); } );
    $('#btnUpdate').on( 'click', function () { actAjax('update'); } );
    $('#btnDelete').on( 'click', function () { actAjax('delete'); } );
	$('#sub_btnInsert').on( 'click', function () { actAjax2('insert'); } );
    $('#sub_btnUpdate').on( 'click', function () { actAjax2('update'); } );
    $('#sub_btnDelete').on( 'click', function () { actAjax2('delete'); } );
    
    // 상세보기 버튼 이벤트
    $('#'+sGbn+'-list tbody').on( 'click', 'td.details-control', function () {
		GblOpenChk = sGbn;
        openModal("edt");
        format( oTable.row( $(this).closest('tr') ) );
        actImgMap("imgMapList.do");
    } );
    // 상세보기 버튼 이벤트
    $('#'+sGbn2+'-list tbody').on( 'click', 'td.details-control', function () {
		GblOpenChk = sGbn2;
        openModal2("edt");
        format2( oTable2.row( $(this).closest('tr') ) );
        actImgMap("imgMapList.do");
    } );

    $('#tel').keyup(function () { number_only(this); } );
    $('#tel').focus( function(){ changeValue(this, "num"); });
    $('#tel').blur( function(){ changeValue(this, "phone"); });
    
    $('#'+sGbn+'-modal').on('hidden.bs.modal', function () { location.reload(); });
	$('#'+sGbn2+'-modal').on('hidden.bs.modal', function () { location.reload(); });

    // listCmmCd tr 이벤트
    $('#'+sGbn+'-list tbody').on('click', 'td.tbl-name', function () {
        $('#key').val( oTable.row( $(this).closest('tr') ).data().mid);
        // reload 처리가 무조껀 처음에 있는 dataTable에만 처리된다. oTable2 이벤트를 해도 동일
        //oTable2.ajax.reload(); 
        location.href= sGbn+"?key="+oTable.row( $(this).closest('tr') ).data().mid ;
    } );
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
		        {"data":"mid","class":"tbl-mid"}
		        , {"data":"name","class":"tbl-name"}
		        , {"data":"addr","class":"tbl-addr"}
		        , {"data":"tel","class":"tbl-tel"}
		        , {"data":"img_path","class":"tbl-img_path"}
		        , {"data":"img_name","class":"tbl-img_name"}
				, {"data":"reg_date","class":"tbl-reg_date"}
				, {"data":"upd_date","class":"tbl-upd_date"}
				, {"class":'details-control',"orderable":false,"data":"","defaultContent":''}
		]
		,"columnDefs":[ 
				{"targets":[0],"visible":false,"searchable":false}
				, {"targets":[2],"visible":false,"searchable":false}
				, {"targets":[4],"visible":false,"searchable":false}
				, {"targets":[5],"visible":false,"searchable":false}
				, {"targets":[7],"visible":false,"searchable":false}
		]
		,"order": [[1,"asc"]]
		,"lengthMenu": [[10,15], [10, 15]]
		,"oLanguage": {"sZeroRecords":"<p align='center'>검색결과가 없습니다.</p>"}
		,"sDom":'<"top"Tfl>rt<"bottom"pi>'
		,"oTableTools": {
			"aButtons":[ {
				"sExtends":"text"
				,"sButtonText":"등록"
				,"fnClick":function(nButton,oConfig,oFlash) {
					imgBtn("1");
				    $("#divImg").html("");
				    $("#divModalImg").hide();    
				    actEmpty();
				    openModal("add");
				}
			}]
		}
	});
}
function openModal(e) {
	$('#'+sGbn+'-modal').modal();
	$('#'+sGbn+'-modal').modal( {keyboard:false});
	$('#'+sGbn+'-modal').modal('show');
	
	if(e=="add") {
		$('#btnInsert').show();
		$('#btnUpdate').hide();
		$('#btnDelete').hide();
		$('#img_path').attr('readonly',false);
		$('#modal-img_path').hide();
		$('#img_name').attr('readonly',false);
		$('#modal-img_name').hide();
	} else if(e =='edt') {
		$('#btnInsert').hide();
		$('#btnUpdate').show();
		$('#btnDelete').show();
		$('#img_path').attr('readonly',true);
		$('#modal-img_path').show();
		$('#img_name').attr('readonly',true);
		$('#modal-img_name').show();
	}
}

function actEmpty() {
	openGbn="add";
	$('#mid').val('');
	$('#name').val('');
	$('#addr').val('');
	$('#tel').val('');
	$('#img_path').val('');
	$('#img_name').val('');
	$('#reg_date').val('');
	$('#upd_date').val('');
}
function format(row) {
	openGbn="update";
	$('#mid').val(row.data().mid);
	$('#name').val(row.data().name);
	$('#addr').val(row.data().addr);
	$('#tel').val(row.data().tel);
	$('#img_path').val(row.data().img_path);
	$('#img_name').val(row.data().img_name);

	$('#reg_date').val(getDateChangeStr(row.data().reg_date));
	$('#upd_date').val(getDateChangeStr(row.data().upd_date));	
}

function actAjax(act){
    $('#'+sGbn+'-form').bootstrapValidator({
        message: 'This value is not valid',
        fields: {
        	name: { validators: { notEmpty: { message: '필수 입력사항입니다.' } } }            
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

/*brand*/
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
		,"columns":[ 
		        {"data":"brid","class":"tbl-brid"}
		        , {"data":"mid","class":"tbl-mid"}
		        , {"data":"mid_etc","class":"tbl-mid_etc"}
		        , {"data":"br_name","class":"tbl-br_name"}
		        , {"data":"img_path","class":"tbl-img_path"}
		        , {"data":"img_name","class":"tbl-img_name"}
				, {"data":"reg_date","class":"tbl-reg_date"}
				, {"data":"upd_date","class":"tbl-upd_date"}
				, {"class":'details-control',"orderable":false,"data":"","defaultContent":''}
		]
		,"columnDefs":[ 
				{"targets":[0],"visible":false,"searchable":false}
				, {"targets":[1],"visible":false,"searchable":false}
				, {"targets":[4],"visible":false,"searchable":false}
				, {"targets":[5],"visible":false,"searchable":false}
				, {"targets":[7],"visible":false,"searchable":false}
		]
		,"order": [[1,"asc"]]
		,"lengthMenu": [[10,15], [10, 15]]
		,"oLanguage": {"sZeroRecords":"<p align='center'>검색결과가 없습니다.</p>"}
		,"sDom":'<"top"Tfl>rt<"bottom"pi>'
		,"oTableTools": {
			"aButtons":[ {
				"sExtends":"text"
				,"sButtonText":"등록"
				,"fnClick":function(nButton,oConfig,oFlash) {
					imgBtn("1");
				    $("#divsub_Img").html("");
				    $("#divModalsub_Img").hide();    
				    actEmpty2();
				    openModal2("add");
				}
			}]
		}
	});
}
function openModal2(e) {
	$('#'+sGbn2+'-modal').modal();
	$('#'+sGbn2+'-modal').modal( {keyboard:false});
	$('#'+sGbn2+'-modal').modal('show');
	
	if(e=="add") {
		$('#sub_btnInsert').show();
		$('#sub_btnUpdate').hide();
		$('#sub_btnDelete').hide();
		$('#sub_img_path').attr('readonly',false);
		$('#modal-sub_img_path').hide();
		$('#sub_img_name').attr('readonly',false);
		$('#modal-sub_img_name').hide();
	} else if(e =='edt') {
		$('#sub_btnInsert').hide();
		$('#sub_btnUpdate').show();
		$('#sub_btnDelete').show();
		$('#sub_img_path').attr('readonly',true);
		$('#modal-sub_img_path').show();
		$('#sub_img_name').attr('readonly',true);
		$('#modal-sub_img_name').show();
	}
}

function actEmpty2() {
	openGbn="add";
	$('#sub_brid').val('');
	$('#sub_mid').val('');
	$('#sub_br_name').val('');
	$('#sub_img_path').val('');
	$('#sub_img_name').val('');
	$('#sub_reg_date').val('');
	$('#sub_upd_date').val('');
}
function format2(row) {
	openGbn="update";
	$('#sub_brid').val(row.data().brid);
	$('#sub_mid').val(row.data().mid);
	$('#sub_br_name').val(row.data().br_name);
	$('#sub_img_path').val(row.data().img_path);
	$('#sub_img_name').val(row.data().img_name);
	$('#sub_reg_date').val(getDateChangeStr(row.data().reg_date));
	$('#sub_upd_date').val(getDateChangeStr(row.data().upd_date));	
}

function actAjax2(act){
    $('#'+sGbn2+'-form').bootstrapValidator({
        message: 'This value is not valid',
        fields: {
        	sub_mid: { validators: { notEmpty: { message: '필수 입력사항입니다.' } } },
        	sub_name: { validators: { notEmpty: { message: '필수 입력사항입니다.' } } }            
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
		            $('#'+sGbn2+'-modal').modal('hide');		            	
		        }
        	, 'json'
        );
    });	 
}