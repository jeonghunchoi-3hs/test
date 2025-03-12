$(document).ready(function() {
    // 리스트
//    gridList();
    
    $('#btnTest1').on( 'click', function () { 
        $.ajax({
            type:"GET",
            url: '/admin/user/list',
            dataType:'json',
            success:function( ret ) {
            	console.log(ret);
            	var json = eval("("+ret+")");
            	console.log(json);          
            	console.log(json.data[0].userName);          
            },
            error:function(e) { alert(e.responseText); }
        }); 
    });

});


function fileUpload(){
	/* 한글 검사 */
	var pattern =/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	if(pattern.test($('#fileName').val())){
		alert("파일 이름은 한글이 아닌 영문 또는 숫자로 입력 해주십시오.");
		return false;
	}
	
	var formData = new FormData();   
    formData.append('source', $('#source')[0].files[0]);
    formData.append('file_name', $('#file_name').val());
    formData.append('program_name', $('#program_name').val());
    formData.append('program_seq', $('#program_seq').val());
    
	$.ajax({
        url: "/admin/cmm/file/insert",
        type:"POST",
        processData:false,
        contentType:false,
        data: formData,
        success:function(responese) {
        	
        },
        error:function(e) { alert(e.responseText); }
    });
}



function reloadTable(){
	oTable.ajax.reload();
}

function gridList() {
	oTable = $('#users-list').DataTable( {
		"processing":true
		,"serverSide":true
		,"ajax": {
			"url":"/admin/user/list"
			,"data":function (d) {
				d.key1=$('#key1').val();
				d.key2=$('#key2').val();
				d.key3=$('#key3').val();
				d.key4=$('#key4').val();
				d.key5=$('#key5').val();
			}
		
		}
		,"columns":[ 
		        {"data":"userId","class":"tbl-userId"}
		        , {"data":"userName","class":"tbl-userName"}
		        , {"data":"userPassword","class":"tbl-userPassword"}
		]
		,"columnDefs":[ 
		]
		,"order": [[1,"asc"]]
		,"lengthMenu": [[10,15], [10, 15]]
		,"oLanguage": {"sZeroRecords":"<p align='center'>검색결과가 없습니다.</p>"}
		,"sDom":'<"top"fl>rt<"bottom"pi>'
	});
}


