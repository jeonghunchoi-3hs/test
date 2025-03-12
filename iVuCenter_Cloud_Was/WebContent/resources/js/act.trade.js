var oTable;
var sGbn;
var starDt;
var endDt;
/*
tr_date
tr_time
tr_pid
tr_type
*/
$(document).ready(function() {
	$("#modal-btn").hide();
	$('#key1').val( getDateChangeStr(nowToday) );
	$('#key2').val( getDateChangeStr(nowToday) );
    // 페이지 구분값 
    sGbn = $("#subname").val();
    // 리스트
    gridList();

    // 상세보기 버튼 이벤트
    $('#'+sGbn+'-list tbody').on( 'click', 'td.details-control', function () {
        openModal("edt");
        format( oTable.row( $(this).closest('tr') ) );
    } );
    /*
    $('#key1').change( function(){ oTable.ajax.reload();  });
    $('#key2').change( function(){ oTable.ajax.reload();  });
    */
	// 검색
	$('#btnSearch').on( 'click', function () { oTable.ajax.reload(); });
	
	// 시작일	
	$('#key1').focus( function(){ 
		setPosition(270,240);
		var Yy = nowYear;
		var Mm = nowMonth;
		try{
			starDt = $('#key1').val().replace(/[^0-9]/gi,'');
			if(starDt != ""){
				Yy = starDt.substring(0,4);
				Mm = starDt.substring(4,6);
			}
		}catch(e){}
		showCalendar(Yy, Mm, "key1");
	});
    $('#key1').blur( function(){ $(this).val( getDateChangeStr(this.value)); });
	$('#btnStartDt').on( 'click', function () {
		setPosition(270,240);
		var Yy = nowYear;
		var Mm = nowMonth;
		try{
			starDt = $('#key1').val().replace(/[^0-9]/gi,'');
			if(starDt != ""){
				Yy = starDt.substring(0,4);
				Mm = starDt.substring(4,6);
			}
		}catch(e){}
		showCalendar(Yy, Mm, "key1");
	});

	// 종료일
	$('#key2').focus( function(){ 
		setPosition(470,240);
		var Yy = nowYear;
		var Mm = nowMonth;
		try{
			endDt = $('#key2').val().replace(/[^0-9]/gi,'');
			if(endDt != ""){
				Yy = endDt.substring(0,4);
				Mm = endDt.substring(4,6);
			}
		}catch(e){}
		showCalendar(Yy, Mm, "key2");
	});
    $('#key2').blur( function(){ $(this).val( getDateChangeStr(this.value)); });
	$('#btnEndDt').on( 'click', function () {
		setPosition(470,240);
		var Yy = nowYear;
		var Mm = nowMonth;
		try{
			endDt = $('#key2').val().replace(/[^0-9]/gi,'');
			if(endDt != ""){
				Yy = endDt.substring(0,4);
				Mm = endDt.substring(4,6);
			}
		}catch(e){}
		showCalendar(Yy, Mm, "key2");
	});
});


function reloadTable(){
	oTable.ajax.reload();
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
		        {"data":"tr_date","class":"tbl-tr_date"}
		        , {"data":"tr_time","class":"tbl-tr_time"}
		        , {"data":"tr_pid","class":"tbl-tr_pid"}
		        , {"data":"tr_pid_etc","class":"tbl-tr_pid_etc"}
		        , {"data":"tr_type","class":"tbl-tr_type"}
				, {"class":'details-control',"orderable":false,"data":"","defaultContent":''}
		]
		,"columnDefs":[ 
				{"targets":[5],"visible":false,"searchable":false}
		]
		,"order": [[1,"asc"]]
		,"lengthMenu": [[10,15], [10, 15]]
		,"oLanguage": {"sZeroRecords":"<p align='center'>검색결과가 없습니다.</p>"}
		,"sDom":'<"top"fl>rt<"bottom"pi>'
	});
}

function format(row) {
	$('#tr_date').val(row.data().tr_date);
	$('#tr_time').val(row.data().tr_time);
	$('#tr_pid').val(row.data().tr_pid);
	$('#tr_type').val(row.data().tr_type);

}
