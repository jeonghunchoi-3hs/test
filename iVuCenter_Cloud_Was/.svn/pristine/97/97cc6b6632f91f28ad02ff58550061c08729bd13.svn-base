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
    
    $('#btnTest2').on( 'click', function () { 
        $.ajax({
            type:"GET",
            url: '/admin/user/list',
            dataType:'html',
            success:function( ret ) {
            	console.log(ret);
            	var json = eval('('+ret+')');
            	console.log(json);          
            	console.log(json.data[0].userName);          
            },
            error:function(e) { alert(e.responseText); }
        }); 
    });
});


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


