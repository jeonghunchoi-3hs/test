var oTable;
var sGbn;
var iSubmit = 0;
var openGbn = "add";

$(document).ready(function() {
    // 페이지 구분값 
    sGbn = $("#subname").val();
    
    // select box
    setComboBoxDb( "dbSelect.do","divModal-div_code","div_code","100%", " class='form-control' ", "", "","" );
    setComboBoxDb( "dbSelect.do","divModal-mid","mid","100%", " class='form-control' onchange='setBrid();", "", "","" );
    setComboBoxDb( "dbSelect.do","divModal-brid","brid","100%", " class='form-control' ", "", "","" );
    setComboBox( aCode_stat2,"divModal-stat","stat","100%", " class='form-control' " );
//    setComboBox( aCode_gender,"divModal-gender","gender","100%", " class='form-control' " );
    // 리스트
    gridList();
    // DB 처리
    $('#btnInsert').on( 'click', function () { actAjax('insert'); } );
    $('#btnUpdate').on( 'click', function () { actAjax('update'); } );
    $('#btnDelete').on( 'click', function () { actAjax('delete'); } );
    
    // QR 코드 처리
    $('#btnAdd_qrcode').on( 'click', function () {
//    	if($("#qrcode").val() == ""){
    		actQrcode("add");
//    	}else{
//    		alert("이미 등록된 QRCODE가 존재 합니다.");
//    	}
    });
    $('#btnPrint_qrcode').on( 'click', function () { 
		var qrcode = "<div style='float:left;padding:4.3px 0.7px 4.3px 0.7px;border: 1px solid #fff;'><img src='"+$("#qrcode").val()+"' style='width:100px;height:100px;'/></div>"; 
		var sDiv = "<div style='padding-left:54px;padding-top:16px;'>";
		for(var i=0;i<54;i++){
			sDiv += qrcode;
		}
		sDiv += "</div>";
		ifraPrint.document.open();
        ifraPrint.document.writeln(sDiv);
        ifraPrint.document.close();
        ifraPrint.document.execCommand('Print');

//    	$.ajax({
//            url: "qrCodePrint.do",
//            data:{
//            	mid		: $("#mid").val(),		//maker
//            	brid	: $("#brid").val()		//brand
//            },
//            type: "POST",
//            success: function( ret ) {
//            	var product = "<div style='padding-left:25px;'><img src='"+ret+"' style='width:100px;height:100px;'/></div>"; 
//            	var qrcode = "<div><img src='"+$("#qrcode").val()+"' style='width:150px;height:150px;'/></div>"; 
//				var divLeft =  "<div style='width:260px;height:230px;float:left;padding-left:150px;padding-top:5px;'>";
//				var divRight = "<div style='width:260px;height:230px;float:left;padding-left:10px;padding-top:5px;'>";
//				var divPadding = "<div style='width:100%;height:10px;float:left;'></div>";
//
//            	var sDiv = "<div>"
//					+ divPadding + divPadding
//        			+ divLeft
//        			+ product
//            		+ qrcode
//        			+ "</div>"
//        			+ divRight
//        			+ product
//            		+ qrcode
//        			+ "</div>"
//					+ divPadding
//        			+ divLeft
//        			+ product
//            		+ qrcode
//        			+ "</div>"
//        			+ divRight
//        			+ product
//            		+ qrcode
//        			+ "</div>"
//					+ divPadding + divPadding
//        			+ divLeft
//        			+ product
//            		+ qrcode
//        			+ "</div>"
//        			+ divRight
//        			+ product
//            		+ qrcode
//        			+ "</div>"
//					+ divPadding 
//        			+ divLeft
//        			+ product
//            		+ qrcode
//        			+ "</div>"
//        			+ divRight
//        			+ product
//            		+ qrcode
//        			+ "</div>"
//        			+ "</div>";
//            	
//            	ifraPrint.document.open();
//            	ifraPrint.document.writeln(sDiv);
//        		ifraPrint.document.close();
//        		ifraPrint.document.execCommand('Print');
//            },
//            error: function(e) { alert(e.responseText); }
//      	 });
	});
    
    // 상세보기 버튼 이벤트
    $('#'+sGbn+'-list tbody').on( 'click', 'td.details-control', function () {
        openModal("edt");
        format( oTable.row( $(this).closest('tr') ) );
        actImgMap("imgMapList.do");
        actQrcode("list");
    } );

    $('#min_size').keyup(function () { number_only(this); } );
    $('#min_size').focus( function(){ changeValue(this, "num"); });
    $('#min_size').blur( function(){ changeValue(this, "num"); });
    $('#max_size').keyup(function () { number_only(this); } );
    $('#max_size').focus( function(){ changeValue(this, "num"); });
    $('#max_size').blur( function(){ changeValue(this, "num"); });
    $('#size').keyup(function () { number_only(this); } );
    $('#size').focus( function(){ changeValue(this, "num"); });
    $('#size').blur( function(){ changeValue(this, "num"); });
//    $('#factory_price').keyup(function () { number_only(this); } );
//    $('#factory_price').focus( function(){ changeValue(this, "num"); });
//    $('#factory_price').blur( function(){ changeValue(this, "num"); });
    $('#retail_price').keyup(function () { number_only(this); } );
    $('#retail_price').focus( function(){ changeValue(this, "num"); });
    $('#retail_price').blur( function(){ changeValue(this, "num"); });    

	$('#intro_path').blur( function(){ 
		if(this.value != "" && !(this.value.indexOf("http://") == 0 || this.value.indexOf("https://") == 0 )){
			$(this).val("http://"+this.value);
			
			var chkExp = /http:\/\/([\w\-]+\.)+/g;
			if (chkExp.test(this.value)) {
			} else {
				alert ("유효하지 않은 URL 입니다.");
				$(this).focus();
			}
		}
	});
	$('#'+sGbn+'-modal').on('hidden.bs.modal', function () { location.reload(); });
});

function setBrid(){
	setComboBoxDb( "dbSelect.do","divModal-brid","brid","100%", " class='form-control' ", $("#mid").val(), "","" );
}

function actQrcode(sAct){
	$.ajax({
        url: "qrCodeAct.do",
        data:{
        	act		: sAct,
        	pid		: $("#pid").val(),
        	qrcode  : $("#qrcode").val(),
        	qrcode_url  : $("#qrcode_url").val()
        },
        type: "POST",
        success: function( ret ) {
        	if(sAct == "list"){
        		$("#divQrcode").html(ret);
        	}else if(sAct == "add"){
        		actQrcode("list");
        		$("#qrcode").val(ret.split("/%/")[2]);
        		alert("QR CODE가 생성 되었습니다.");
        	}
        },
        error: function(e) { alert(e.responseText); }
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
		,"columns":[ 
		        {"data":"pid","class":"tbl-pid"}
		        , {"data":"name","class":"tbl-name"}
		        , {"data":"mid","class":"tbl-mid"}
		        , {"data":"mid_etc","class":"tbl-mid_etc"}
		        , {"data":"brid","class":"tbl-brid"}
		        , {"data":"brid_etc","class":"tbl-brid_etc"}	//5
		        , {"data":"gender","class":"tbl-gender"}
		        , {"data":"material","class":"tbl-material"}
		        , {"data":"color","class":"tbl-color"}
		        , {"data":"min_size","class":"tbl-min_size"}
		        , {"data":"max_size","class":"tbl-max_size"}	//10
		        , {"data":"size","class":"tbl-size"}	
		        , {"data":"factory_price","class":"tbl-factory_price"}
				, {"data":"retail_price","class":"tbl-retail_price"}
		        , {"data":"div_code","class":"tbl-div_code"}
		        , {"data":"img_path","class":"tbl-img_path"}	//15
		        , {"data":"img_name","class":"tbl-img_name"}	
		        , {"data":"qrcode","class":"tbl-qrcode"}	
				, {"data":"intro_path","class":"tbl-intro_path"}
				, {"data":"stat","class":"tbl-stat"}
				, {"data":"contents","class":"tbl-contents"}
				, {"data":"reg_date","class":"tbl-reg_date"}
				, {"data":"upd_date","class":"tbl-upd_date"}
				, {"class":'details-control',"orderable":false,"data":"","defaultContent":''}
		]
		,"columnDefs":[ 
				{"targets":[2],"visible":false,"searchable":false}
				, {"targets":[4],"visible":false,"searchable":false}
				, {"targets":[6],"visible":false,"searchable":false}
				, {"targets":[7],"visible":false,"searchable":false}
				, {"targets":[6],"visible":false,"searchable":false}
				, {"targets":[8],"visible":false,"searchable":false}
				, {"targets":[9],"visible":false,"searchable":false}
				, {"targets":[10],"visible":false,"searchable":false}
				, {"targets":[12],"visible":false,"searchable":false}
				, {"targets":[13],"visible":false,"searchable":false}
				, {"targets":[14],"visible":false,"searchable":false}
				, {"targets":[15],"visible":false,"searchable":false}
				, {"targets":[16],"visible":false,"searchable":false}
				, {"targets":[17],"visible":false,"searchable":false}
				, {"targets":[18],"visible":false,"searchable":false}
				
				, {
					"render":function(data,type,row) {
						return getValue(data,aCode_stat2);
					}
					,"targets":19
				}
				, {"targets":[20],"visible":false,"searchable":false}
				, {
					"render":function(data,type,row) {
						return getDateChangeStr(data);
					}
					,"targets":21
				}
				, {"targets":[22],"visible":false,"searchable":false}
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
		$('#qrcode').attr('readonly',false);
		$('#modal-qrcode').hide();
	} else if(e =='edt') {
		$('#btnInsert').hide();
		$('#btnUpdate').show();
		$('#btnDelete').show();
		$('#img_path').attr('readonly',true);
		$('#modal-img_path').show();
		$('#img_name').attr('readonly',true);
		$('#modal-img_name').show();
		$('#qrcode').attr('readonly',true);
		$('#modal-qrcode').show();
	}
}
function actEmpty() {
	openGbn="add";
	$('#pid').val('');
	$('#name').val('');
	$('#mid').val('');
	$('#brid').val('');
	$('#gender').val('');
	$('#material').val('');
	$('#color').val('');
	$('#min_size').val('0');
	$('#max_size').val('0');
	$('#size').val('0');
	$('#factory_price').val('');
	$('#retail_price').val('0');
	$('#div_code').val('');
	$('#img_path').val('');
	$('#img_name').val('');
	$('#qrcode').val('');
	$('#intro_path').val('');
	$('#stat').val('0');
	$('#stat').val('');
	$('#reg_date').val('');
	$('#upd_date').val('');
}
function format(row) {
	openGbn="update";
	$('#pid').val(row.data().pid);
	$('#name').val(row.data().name);
	$('#mid').val(row.data().mid);
	$('#brid').val(row.data().brid);
	$('#gender').val(row.data().gender);
	$('#material').val(row.data().material);
	$('#color').val(row.data().color);
	$('#min_size').val(row.data().min_size);
	$('#max_size').val(row.data().max_size);
	$('#size').val(row.data().size);
	$('#factory_price').val(row.data().factory_price);
	$('#retail_price').val(row.data().retail_price);
	$('#div_code').val(row.data().div_code);
	$('#img_path').val(row.data().img_path);
	$('#img_name').val(row.data().img_name);
	$('#qrcode').val(row.data().qrcode);
	$('#intro_path').val(row.data().intro_path);
	$('#stat').val(row.data().stat);
	$('#contents').val(row.data().contents);
	$('#reg_date').val(getDateChangeStr(row.data().reg_date));
	$('#upd_date').val(getDateChangeStr(row.data().upd_date));	
}

function actAjax(act){
    $('#'+sGbn+'-form').bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            name: { validators: { notEmpty: { message: '필수 입력사항입니다.' } } },
            mid: { validators: { notEmpty: { message: '필수 선택사항입니다.' } } },
            div_code: { validators: { notEmpty: { message: '필수 선택사항입니다.' }} },            
//          gender: { validators: { notEmpty: { message: '필수 선택사항입니다.' }} },            
            stat: { validators: { notEmpty: { message: '필수 선택사항입니다.' }} },            
            //factory_price: {validators: {notEmpty: {message: '필수 입력사항입니다.'}, integer: { message: '숫자만 입력이 가능합니다.' }}},
            retail_price: {validators: {notEmpty: {message: '필수 입력사항입니다.'}, integer: { message: '숫자만 입력이 가능합니다.' }}}
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