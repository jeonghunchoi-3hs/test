var oTable;
var sGbn;
var iSubmit = 0;
var openGbn = "add";
/*
pdid
lcls_code
mcls_code
scls_code
name
use_yn
reg_date
upd_date
*/
$(document).ready(function() {
    // 페이지 구분값 
    sGbn = $("#subname").val();
    
    // select box
    setComboBox( aCode_yn,"divModal-use_yn","use_yn","100%", " class='form-control' " );
    // 리스트
    gridList();
    // DB 처리
    $('#btnInsert').on( 'click', function () { actAjax('insert'); } );
//    $('#btnUpdate').on( 'click', function () { actAjax('update'); } );
//    $('#btnDelete').on( 'click', function () { actAjax('delete'); } );
    
    // 상세보기 버튼 이벤트
    $('#'+sGbn+'-list tbody').on( 'click', 'td.details-control', function () {
        openModal("edt");
        format( oTable.row( $(this).closest('tr') ) );
    } );
    
    // 제품 분류코드 설정
    $('#pdid').blur( function(){ 
    	var vLen = getFieldLenVal($('#pdid').val())
    	if(vLen > 2){ $('#lcls_code').val( $('#pdid').val().substring(0,3) ); }
    	if(vLen > 5){ $('#scls_code').val( $('#pdid').val().substring(0,3) ); }
    	if(vLen > 7){ $('#mcls_code').val( $('#pdid').val().substring(0,3) ); }
    });
    $('#lcls_code').blur( function(){ setPdid(); });
    $('#mcls_code').blur( function(){ setPdid(); });
    $('#scls_code').blur( function(){ setPdid(); });
	
	$('#'+sGbn+'-modal').on('hidden.bs.modal', function () { location.reload(); });
});

function setPdid(){
	$('#pdid').val($('#lcls_code').val()+$('#scls_code').val()+$('#mcls_code').val());
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
		,"columns":[ 
		        {"data":"pdid","class":"tbl-pdid"}
		        , {"data":"lcls_code","class":"tbl-lcls_code"}
		        , {"data":"mcls_code","class":"tbl-mcls_code"}
		        , {"data":"scls_code","class":"tbl-scls_code"}
		        , {"data":"name","class":"tbl-name"}
		        , {"data":"use_yn","class":"tbl-use_yn"}	//5
				, {"data":"reg_date","class":"tbl-reg_date"}
				, {"data":"upd_date","class":"tbl-upd_date"}
				, {"class":'details-control',"orderable":false,"data":"","defaultContent":''}
		]
		,"columnDefs":[ 
				{"targets":[6],"visible":false,"searchable":false}
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
	$('#'+sGbn+'-modal').modal();
	$('#'+sGbn+'-modal').modal( {keyboard:false});
	$('#'+sGbn+'-modal').modal('show');
	
	if(e=="add") {
		$('#btnInsert').show();
		$('#btnUpdate').hide();
		$('#btnDelete').hide();
	} else if(e =='edt') {
		$('#btnInsert').hide();
		$('#btnUpdate').hide();
		$('#btnDelete').hide();
	}
}

function actEmpty() {
	openGbn="add";
	$('#pdid').val('');
	$('#lcls_code').val('');
	$('#mcls_code').val('');
	$('#scls_code').val('');
	$('#name').val('');
	$('#use_yn').val('Y');
	$('#reg_date').val('');
	$('#upd_date').val('');
}
function format(row) {
	openGbn="update";
	$('#pdid').val(row.data().pdid);
	$('#lcls_code').val(row.data().lcls_code);
	$('#mcls_code').val(row.data().mcls_code);
	$('#scls_code').val(row.data().scls_code);
	$('#name').val(row.data().name);
	$('#use_yn').val(row.data().use_yn);
	$('#reg_date').val(getDateChangeStr(row.data().reg_date));
	$('#upd_date').val(getDateChangeStr(row.data().upd_date));	
}

function actAjax(act){
    $('#'+sGbn+'-form').bootstrapValidator({
        message: 'This value is not valid',
        fields: {
        	pdid: { validators: { notEmpty: { message: '필수 입력사항입니다.' } } },
        	lcls_code: { validators: { notEmpty: { message: '필수 입력사항입니다.' } } },
        	mcls_code: { validators: { notEmpty: { message: '필수 입력사항입니다.' }} },            
        	scls_code: { validators: { notEmpty: { message: '필수 입력사항입니다.' }} },            
        	name: { validators: { notEmpty: { message: '필수 입력사항입니다.' }} }            
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
		            if(result == 1) { 
		            	alert(sMsg+" 되었습니다.") 
		            }
		            else if(result == 2){
		            	alert("동일한 제품분류코드가 이미 등록되어 있습니다.");
		            	return;
		            }
		            else { alert(sMsg+" 실패하였습니다.") }
		            $('#'+sGbn+'-modal').modal('hide');
		        }
        	, 'json'
        );
    });	 
}