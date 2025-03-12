var today = new Date(); 
var nowYear = today.getFullYear(); // 로컬 컴퓨터의 년(year)을 구함
var nowMonth = today.getMonth()+1; // 로컬 컴퓨터의 월(month)을 구함
nowMonth = nowMonth<10 ? "0"+nowMonth: nowMonth;
var nowDate = today.getDate(); // 로컬 컴퓨터의 일(day)을 구함  
nowDate = nowDate<10 ? "0"+nowDate: nowDate;
var nowToday = nowYear.toString()+ nowMonth.toString() +nowDate.toString();

function selectCalender(id){
    var y = parseInt( ($("#selYear").val()==undefined?nowYear:$("#selYear").val()), 10);
    var m = parseInt( ($("#selMonth").val()==undefined?nowMonth:$("#selMonth").val()), 10);
    showCalendar(y,m,id);
}

function setPosition(x,y){
    var iLeft = (document.layers) ? loc.pageX : event.clientX;
    var iTop = (document.layers) ? loc.pageY : event.clientY;
    x==undefined? iLeft-100: x;
    y==undefined? iTop-100: y;
//    console.log(iTop+"/"+iLeft);
    
    $('#divCal').css("left", x);
    $('#divCal').css("top", y);
    
}

function showCalendar(y, m, id){
    $("#divCal").show();
    m = parseInt(m,10);
    
    var text = '<table>\n<tr><td colspan=7 style="text-align:center;padding:5px 0px;">'; 
    text += '<span style="cursor:pointer" title="1년 뒤로" onclick="showCalendar('+(y-1)+','+m+',\''+id+'\')"> ◀ </span>'; 
    text += '<span style="cursor:pointer" title="1개월 뒤로"onclick="showCalendar('+(m==1?(y-1)+','+12: y+','+(m-1))+',\''+id+'\')"> ◁ </span>'; 

    text += '<select id="selYear" onchange="selectCalender(\''+id+'\')">';
    for(var i=-5;i<10;i++){
        text += '<option value="'+(y-i)+'" '+((y-i)==y? 'selected':'')+'>'+(y-i)+'년</option>';
    }
    text += '</select>';
    text += '<select id="selMonth" onchange="selectCalender(\''+id+'\')">';
    for(var i=1;i<13;i++){
        text += '<option value="'+i+'" '+(i==m? 'selected':'')+'>'+i+'월</option>';
    }
    text += '</select>';
    //text += '&nbsp;' + y + '년' + ((m < 10) ? ('0' + m) : m) + '월&nbsp;'; 
    text += '<span style="cursor:pointer" title="1개월 앞으로" onclick="showCalendar('+(m==12?(y+1)+','+1:y+','+(m+1))+',\''+id+'\')"> ▷ </span>'; 
    text += '<span style="cursor:pointer" title="1년 앞으로" onclick="showCalendar('+(y+1)+','+m+',\''+id+'\')"> ▶ </span>'; 
    text += '<span style="cursor:pointer" title="달력 숨기기" onclick="$(\'#divCal\').hide();"> × </span>'; 
    text += '</td>'; 

    var d1 = (y+(y-y%4)/4-(y-y%100)/100+(y-y%400)/400+m*2+(m*5-m*5%9)/9-(m<3?y%4||y%100==0&&y%400?2:3:4))%7; 
    for (i = 0; i < 42; i++) { 
        if (i%7==0) text += '</tr>\n<tr>'; 
        if (i < d1 || i >= d1+(m*9-m*9%8)/8%2+(m==2?y%4||y%100==0&&y%400?28:29:30)) 
            text += '<td> </td>'; 
        else 
            text += '<td' + (i%7 ? '' : ' style="color:red;"') + ' style="cursor:pointer" onclick="setCalendarDate(\''+id+'\',\''+y+((m<10)?('0'+m):m+'')+(((i+1-d1)<10)?('0'):'')+(i+1-d1)+'\');">' + (i+1-d1) + '</td>'; 
    }
    $("#calendarDiv").html(text + '</tr>\n</table>');
} 

function setCalendarDate(id, date){
//    console.log(id);
//    console.log(date);
	$('#'+id).val(getDateChangeStr(date));
	$('#divCal').hide();
}