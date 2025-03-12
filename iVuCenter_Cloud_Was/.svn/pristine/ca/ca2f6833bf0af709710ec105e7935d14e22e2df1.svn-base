// ***** Variables *************************************************************

var popup_dragging = false;
var popup_target;
var popup_mouseX;
var popup_mouseY;
var popup_mouseposX;
var popup_mouseposY;
var popup_oldfunction;
var popup_bg=false;
var popup_count=0;
var message_popup_count=0;

/**
 * 기본 알림창
 * msg[String] : 알림 문구
 * ex) alertMsg("등록되었습니다.");
 * 
 * 복수 알림 가능
 */
function alertMsg(msg){
	messageBox2("iVucenter", msg, "", "screen-center", 0, 0, "", true);
}

/**
 * 알림창 + 후처리 함수
 * msg[String] : 알림 문구
 * func[String] : 후처리 함수 
 * ex) alertMsg("등록되었습니다.", "goList()");
 * 
 * 복수 알림 기능
 */
function alertMsg2(msg, func) {
	messageBox2("iVucenter", msg, func, "screen-center", 0, 0, "", true);
}

/**
 * 컨펌창 + 확인버튼 함수
 * title[String] : 헤더 문구
 * msg[String] : 컨펌 문구
 * func[String] : 확인버튼 누른 후 처리될 함수 
 * ex) alertMsg("iVuCenter", "등록되었습니다.", "goList()");
 * 
 * 복수 알림 불가
 */
function confirmMsg(title, msg, func){
	if(typeof title=="undefined" || title==null || title=="")
	{
		title="iVucenter";
	}
	
	confirmBox(title, msg, func, 'screen-center', 0, 0, '', true);
}

/**
 * 컨펌창 + 확인버튼 함수 + 취소버튼 함수
 * title[String] : 헤더 문구
 * msg[String] : 컨펌 문구
 * func[String] : 확인버튼 누른 후 처리될 함수 
 * func2[String] : 취소버튼 누른 후 처리될 함수 
 * ex) alertMsg("iVuCenter", "등록되었습니다.", "goList()", "closeEvent()");
 * 
 * 복수 알림 불가
 */
function confirmMsg2(title, msg, func,func2){
	if(typeof title=="undefined" || title==null || title=="")
	{
		title="iVucenter";
	}
	
	confirmBox2(title, msg, func, func2, 'screen-center', 0, 0, '', true);
}

/**
 * 컨펌창 + 확인버튼 함수 + 취소버튼 함수
 * title[String] : 헤더 문구
 * msg[String] : 컨펌 문구
 * func[String] : 확인버튼 누른 후 처리될 함수 
 * func2[String] : 취소버튼 누른 후 처리될 함수 
 * ex) alertMsg("iVuCenter", "등록되었습니다.", "goList()", "closeEvent()");
 * 
 * 복수 알림 가능
 */
function confirmMsg3(title, msg, func,func2){
	if(typeof title=="undefined" || title==null || title=="")
	{
		title="iVucenter";
	}
	
	confirmBox3(title, msg, func, func2, 'screen-center', 0, 0, '', true);
}


//title=confirm 제목
//message= 메세지 내용
//onclick_script= 스크립트 텍스트
//position= screen-top-left, screen-center, screen-bottom-right, mouse, element-bottom, element-right, element-bottom-right
//x = 가로 위치
//y = 세로 위치
//position_id = 오브젝트 ID 해당 오브젝트 위치에 찍어줌
//bg_bool = 백그라운드 사용 (true, false)
function confirmBox(title, message, onclick_script1, position, x, y, position_id, bg_bool)
{
	if(typeof title=="undefined" || title==null || title=="")
	{
		title="iVucenter";
	}
	
	if(x == null) x = 0;
	if(y == null) y = 0;

	BackDivControl(bg_bool,'confirmBox_popup0');

	if(title=='')
		title='MessageBox';
	
	var popup_obj=document.getElementById('confirmBox_popup0');
	
	if(popup_obj)
	{
		var popup_parent=popup_obj.parentNode;
		popup_parent.removeChild(popup_obj);	
	}
	
	if(typeof onclick_script1!="undefined" && onclick_script1!=null && onclick_script1!="" && onclick_script1.indexOf(";")==-1)
	{
		onclick_script1+=";";
	}
	
	
	var pop = '<div class="pop_header" id="confirmBox_popup_drag0" > ';
	pop += '		<h3 class="page_title" style="margin:11px 0 0 20px;">'+title+'</h3>';
	pop += '		<div class="close_btn_pop"><a id="confirmBox_popup_top_exit0" href="javaScript:void(0);" onclick="return false;"><img src="'+contextPath+'/images/common/closeBtn.png" /></a></div>';
	pop += '	</div>';
	pop += '	<div class="center_con"  style="min-width: 300px;">';
	pop += '		<div class="section2" style="float:center;">';
	pop += '			<div class="txt01_color">';
	pop += '				<center>'+message + ' <br/><br/><a href="javascript:void(0);"  id="confirmBox_popup_btn_ok0" onclick="layerClose(\'confirmBox_popup0\');'+onclick_script1+'" class="btn_pop"><span>'+message_ok+'</span></a>';
	pop += '				&nbsp;&nbsp;<a href="javascript:void(0);" id="confirmBox_popup_link_exit0"  onclick="layerClose(\'confirmBox_popup0\');" class="btn_pop"><span>'+message_cancel+'</span></a></center><br/>';
	pop += '			</div>';
	pop += '		</div>';
	pop += '	</div>';
	
	var oDiv = document.createElement('div');
	oDiv.id='confirmBox_popup0';
	//oDiv.className='popup';
	oDiv.className='pop_layer';
	
	oDiv.style.display='none';
	oDiv.style.zIndex=2000+popup_count;
	oDiv.style.width='400px';
	
	var ie6_iframe="";
	if((/msie 6/i).test(navigator.userAgent))
		ie6_iframe="<iframe title=\"내용 없는 프레임\" style=\"position:absolute;top:0px;left:0px;z-index:-99;width:400px;border:0;opacity:0.0;filter: alpha(opacity=0);-moz-opacity:0.0;\"></iframe>";
	
	oDiv.innerHTML=pop+ie6_iframe;
	window.document.body.appendChild(oDiv);

	popup_show('confirmBox_popup0', 'confirmBox_popup_drag0', 'confirmBox_popup_top_exit0', '', '', position, x, y, position_id);
//	
	document.getElementById("confirmBox_popup_link_exit0").focus();
}

function confirmBox2(title, message, onclick_script1, onclick_script2, position, x, y, position_id, bg_bool)
{
	if(typeof title=="undefined" || title==null || title=="")
	{
		title="iVucenter";
	}
	
	if(x == null) x = 0;
	if(y == null) y = 0;

	BackDivControl(bg_bool,'confirmBox_popup0');

	if(title=='')
		title='MessageBox';
	
	var popup_obj=document.getElementById('confirmBox_popup0');
	
	if(popup_obj)
	{
		var popup_parent=popup_obj.parentNode;
		popup_parent.removeChild(popup_obj);	
	}
	
	if(typeof onclick_script1!="undefined" && onclick_script1!=null && onclick_script1!="" && onclick_script1.indexOf(";")==-1)
	{
		onclick_script1+=";";
	}
	
	if(typeof onclick_script2!="undefined" && onclick_script2!=null && onclick_script2!="" && onclick_script2.indexOf(";")==-1)
	{
		onclick_script2+=";";
	}
	
	var pop = '<div class="pop_header" id="confirmBox_popup_drag0" > ';
	pop += '		<h3 class="page_title" style="margin:11px 0 0 20px;">'+title+'</h3>';
	pop += '		<div class="close_btn_pop"><a id="confirmBox_popup_top_exit0" href="javaScript:void(0);" onclick="return false;"><img src="'+contextPath+'/images/common/closeBtn.png" /></a></div>';
	pop += '	</div>';
	pop += '	<div class="center_con"  style="min-width: 300px;">';
	pop += '		<div class="section2" style="float:center;">';
	pop += '			<div class="txt01_color">';
	pop += '				<center>'+message + ' <br/><br/><a href="javascript:void(0);"  id="confirmBox_popup_btn_ok0" onclick="layerClose(\'confirmBox_popup0\');'+onclick_script1+'" class="btn_pop"><span>'+message_ok+'</span></a>';
	pop += '				&nbsp;&nbsp;<a href="javascript:void(0);" id="confirmBox_popup_link_exit0"  onclick="layerClose(\'confirmBox_popup0\');'+onclick_script2+'"  class="btn_pop"><span>'+message_cancel+'</span></a></center><br/>';
	pop += '			</div>';
	pop += '		</div>';
	pop += '	</div>';
	
	var oDiv = document.createElement('div');
	oDiv.id='confirmBox_popup0';
	//oDiv.className='popup';
	oDiv.className='pop_layer';
	
	oDiv.style.display='none';
	oDiv.style.zIndex=2000+popup_count;
	oDiv.style.width='400px';
	
	var ie6_iframe="";
	if((/msie 6/i).test(navigator.userAgent))
		ie6_iframe="<iframe title=\"내용 없는 프레임\" style=\"position:absolute;top:0px;left:0px;z-index:-99;width:400px;border:0;opacity:0.0;filter: alpha(opacity=0);-moz-opacity:0.0;\"></iframe>";
	
	oDiv.innerHTML=pop+ie6_iframe;
	window.document.body.appendChild(oDiv);

	popup_show('confirmBox_popup0', 'confirmBox_popup_drag0', 'confirmBox_popup_top_exit0', '', 'confirmBox_popup_link_exit0', position, x, y, position_id);
	
	document.getElementById("confirmBox_popup_link_exit0").focus();
}

function confirmBox3(title, message, onclick_script1, onclick_script2, position, x, y, position_id, bg_bool)
{
	if(typeof title=="undefined" || title==null || title=="" || title == " ")
	{
		title="iVucenter";
	}
	
	if(x == null) x = 0;
	if(y == null) y = 0;

	message_popup_count++;
	
	BackDivControl(bg_bool,'messagebox_popup'+message_popup_count);

	if(title=='')
		title='MessageBox';
	
	var popup_obj=document.getElementById('messagebox_popup'+message_popup_count);
	
	if(popup_obj)
	{
		var popup_parent=popup_obj.parentNode;
		popup_parent.removeChild(popup_obj);
	}
	
	if(typeof onclick_script1!="undefined" && onclick_script1!=null && onclick_script1!="" && onclick_script1.indexOf(";")==-1)
	{
		onclick_script1+=";";
	}
	
	if(typeof onclick_script2!="undefined" && onclick_script2!=null && onclick_script2!="" && onclick_script2.indexOf(";")==-1)
	{
		onclick_script2+=";";
	}
	

	 var pop = '<div class="pop_header" id="popup_drag'+message_popup_count+'" > ';
	pop += '		<h3 class="page_title" style="margin:11px 0 0 20px;">'+title+'</h3>';
	pop += '		<div class="close_btn_pop"><a href="javaScript:void(0);"  id="popup_top_exit'+message_popup_count+'" onclick="layerClose(\'messagebox_popup'+message_popup_count+'\');return false;"><img src="'+contextPath+'/images/common/closeBtn.png" /></a></div>';
	pop += '	</div>';
	pop += '	<div class="center_con"  style="min-width: 300px;" >';
	pop += '		<div class="section2" style="float:center;">';
	pop += '			<div class="txt01_color">';
	//pop += '				<center>'+message + ' <br/><br/><a href="javascript:void(0);"id="popup_link_exit'+message_popup_count+'" onclick="'+onclick_script+' return false;"  class="btn_pop"><span>확인</span></a></center><br/>';
	pop += '				<center>'+message + ' <br/><br/><a href="javascript:void(0);"  id="confirmBox_popup_btn_ok'+message_popup_count+'" onclick="layerClose(\'messagebox_popup'+message_popup_count+'\');'+onclick_script1+'" class="btn_pop"><span>'+message_ok+'</span></a>';
	pop += '				&nbsp;&nbsp;<a href="javascript:void(0);" id="popup_link_exit'+message_popup_count+'"  onclick="layerClose(\'messagebox_popup'+message_popup_count+'\');'+onclick_script2+'"  class="btn_pop"><span>'+message_cancel+'</span></a></center><br/>';
	pop += '			</div>';
	pop += '		</div>';
	pop += '	</div>';
	pop += '<iframe style="position:absolute;top:0px;left:0px;z-index:-99;width:400px;border:0;opacity:0.0;filter: alpha(opacity=0);\"></iframe>';
	
	var oDiv = document.createElement('div');
	oDiv.id='messagebox_popup'+message_popup_count;
	oDiv.className='pop_layer';
	//oDiv.className='popup';
	oDiv.style.display='none';
	oDiv.style.zIndex=2000+popup_count;
	oDiv.style.width='400px';

	var ie6_iframe="";
	if((/msie 6/i).test(navigator.userAgent))
		ie6_iframe="<iframe title=\"내용 없는 프레임\" style=\"position:absolute;top:0px;left:0px;z-index:-99;width:400px;border:0;opacity:0.0;filter: alpha(opacity=0);-moz-opacity:0.0;\"></iframe>";
	
	oDiv.innerHTML=pop+ie6_iframe;
	window.document.body.appendChild(oDiv);

	
	popup_show('messagebox_popup'+message_popup_count, 'popup_drag'+message_popup_count, 'popup_top_exit'+message_popup_count, 'popup_link_exit'+message_popup_count, '', position, x+(message_popup_count*20), y+(message_popup_count*20), position_id);
	
	document.getElementById("popup_link_exit"+message_popup_count).focus();
}

//title=메세지박스 제목
//message= 메세지 내용
//position= screen-top-left, screen-center, screen-bottom-right, mouse, element-bottom, element-right, element-bottom-right
//x = 가로 위치
//y = 세로 위치
//position_id = 오브젝트 ID 해당 오브젝트 위치에 찍어줌
//bg_bool = 백그라운드 사용 (true, false)
function messageBox(title, message, position, x, y, position_id, bg_bool)
{
	if(typeof title=="undefined" || title==null || title=="" || title == " ")
	{
		title="iVucenter";
	}
	
	messageBox2(title, message, '', position, x, y, position_id, bg_bool);
}

function messageBox2(title, message, onclick_script, position, x, y, position_id, bg_bool)
{
	if(typeof title=="undefined" || title==null || title=="" || title == " ")
	{
		title="iVucenter";
	}
	
	if(x == null) x = 0;
	if(y == null) y = 0;

	message_popup_count++;
	
	BackDivControl(bg_bool,'messagebox_popup'+message_popup_count);

	if(title=='')
		title='MessageBox';
	
	var popup_obj=document.getElementById('messagebox_popup'+message_popup_count);
	
	if(popup_obj)
	{
		var popup_parent=popup_obj.parentNode;
		popup_parent.removeChild(popup_obj);
	}
	
	if(typeof onclick_script!="undefined" && onclick_script!=null && onclick_script!="" && onclick_script.indexOf(";")==-1)
	{
		onclick_script+=";";
	}
	

	 var pop = '<div class="pop_header" id="popup_drag'+message_popup_count+'" > ';
	pop += '		<h3 class="page_title" style="margin:11px 0 0 20px;">'+title+'</h3>';
	pop += '		<div class="close_btn_pop"><a href="javaScript:void(0);"  id="popup_top_exit'+message_popup_count+'" onclick="'+onclick_script+'return false;"><img src="'+contextPath+'/images/common/closeBtn.png" /></a></div>';
	pop += '	</div>';
	pop += '	<div class="center_con" style="min-width: 300px;">';
	pop += '		<div class="section2" style="float:center;">';
	pop += '			<div class="txt01_color">';
	pop += '				<center>'+message + ' <br/><br/><a href="javascript:void(0);"id="popup_link_exit'+message_popup_count+'" onclick="'+onclick_script+' return false;"  class="btn_pop"><span>'+message_ok+'</span></a></center><br/>';
	pop += '			</div>';
	pop += '		</div>';
	pop += '	</div>';
	pop += '<iframe style="position:absolute;top:0px;left:0px;z-index:-99;width:300px;border:0;opacity:0.0;filter: alpha(opacity=0);\"></iframe>';
	
	var oDiv = document.createElement('div');
	oDiv.id='messagebox_popup'+message_popup_count;
	oDiv.className='pop_layer';
	//oDiv.className='popup';
	oDiv.style.display='none';
	oDiv.style.zIndex=2000+popup_count;
	oDiv.style.width='300px';

	var ie6_iframe="";
	if((/msie 6/i).test(navigator.userAgent))
		ie6_iframe="<iframe title=\"내용 없는 프레임\" style=\"position:absolute;top:0px;left:0px;z-index:-99;width:300px;border:0;opacity:0.0;filter: alpha(opacity=0);-moz-opacity:0.0;\"></iframe>";
	
	oDiv.innerHTML=pop+ie6_iframe;
	window.document.body.appendChild(oDiv);

	
	popup_show('messagebox_popup'+message_popup_count, 'popup_drag'+message_popup_count, 'popup_top_exit'+message_popup_count, 'popup_link_exit'+message_popup_count, '', position, x+(message_popup_count*20), y+(message_popup_count*20), position_id);
	
	document.getElementById("popup_link_exit"+message_popup_count).focus();
}

/*
 * popup_id=레이어 아이디
 * popup_drag=드레그바 레이어 아이디
 * popup_exit=닫기 버튼 아이디
 * position= screen-top-left, screen-center, screen-bottom-right, mouse, element-bottom, element-right, element-bottom-right
 * x = 가로 위치
 * y = 세로 위치
 * position_id = 오브젝트 ID 해당 오브젝트 위치에 찍어줌
 * bg_bool = 백그라운드 사용 (true, false)
 */
function popupShow(popup_id, popup_drag, popup_exit, position, x, y, position_id, bg_bool, obj_remove)
{
	if(x == null) x = 0;
	if(y == null) y = 0;
	
	BackDivControl(bg_bool, popup_id);
	
	if(typeof obj_remove=="undefined" || obj_remove==null)
	{
		obj_remove=true;
	}

	if(obj_remove)
	{
		var popup_obj=document.getElementById(popup_id);
	
		var oDiv = popup_obj.cloneNode(true);
		
		if(oDiv.style.zIndex=='')
			oDiv.style.zIndex=501+popup_count;
		
		var popup_body_parent=popup_obj.parentNode;
		popup_body_parent.removeChild(popup_obj);
		
		window.document.body.appendChild(oDiv);
	}
	
	if(typeof popup_drag=='undefined' || popup_drag==null)
		popup_drag='';
	
	popup_id=popup_id.replace(/(^\s*)|(\s*$)/gi, "");
	popup_drag=popup_drag.replace(/(^\s*)|(\s*$)/gi, "");
	popup_exit=popup_exit.replace(/(^\s*)|(\s*$)/gi, "");
	
	var arr_btn_id;
	if(popup_exit.indexOf(',')>-1)
	{
		arr_btn_id=popup_exit.split(',');
		if(arr_btn_id.length==2)
		{
			arr_btn_id[0]=arr_btn_id[0].replace(/(^\s*)|(\s*$)/gi, "");
			arr_btn_id[1]=arr_btn_id[1].replace(/(^\s*)|(\s*$)/gi, "");
			popup_show(popup_id, popup_drag, arr_btn_id[0], arr_btn_id[1], '', position, x, y, position_id);
		}
		else if(arr_btn_id.length==3)
		{
			arr_btn_id[0]=arr_btn_id[0].replace(/(^\s*)|(\s*$)/gi, "");
			arr_btn_id[1]=arr_btn_id[1].replace(/(^\s*)|(\s*$)/gi, "");
			arr_btn_id[2]=arr_btn_id[2].replace(/(^\s*)|(\s*$)/gi, "");
			popup_show(popup_id, popup_drag, arr_btn_id[0], arr_btn_id[1], arr_btn_id[2], position, x, y, position_id);
		}
	}
	else
		popup_show(popup_id, popup_drag, popup_exit, '', '', position, x, y, position_id);
	
	//document.getElementById(popup_id).focus();
}


/*
 * popup_id=레이어 아이디
 * popup_drag=드레그바 레이어 아이디
 * popup_exit=닫기 버튼 아이디
 * position= screen-top-left, screen-center, screen-bottom-right, mouse, element-bottom, element-right, element-bottom-right
 * x = 가로 위치
 * y = 세로 위치
 * position_id = 오브젝트 ID 해당 오브젝트 위치에 찍어줌
 * bg_bool = 백그라운드 사용 (true, false)
 */
function popupShow2(popup_id, popup_drag, popup_exit, position, x, y, position_id, bg_bool, obj_remove)
{
	if(x == null) x = 0;
	if(y == null) y = 0;
	
	BackDivControl(bg_bool, popup_id);
	
	if(typeof obj_remove=="undefined" || obj_remove==null)
	{
		obj_remove=true;
	}

	if(obj_remove)
	{
		var popup_obj=document.getElementById(popup_id);
	
		var oDiv = popup_obj.cloneNode(true);
		
		if(oDiv.style.zIndex=='')
			oDiv.style.zIndex=501+popup_count;
		
		var popup_body_parent=popup_obj.parentNode;
		popup_body_parent.removeChild(popup_obj);
		
		window.document.body.appendChild(oDiv);
	}
	
	if(typeof popup_drag=='undefined' || popup_drag==null)
		popup_drag='';
	
	popup_id=popup_id.replace(/(^\s*)|(\s*$)/gi, "");
	popup_drag=popup_drag.replace(/(^\s*)|(\s*$)/gi, "");
	popup_exit=popup_exit.replace(/(^\s*)|(\s*$)/gi, "");
	
	var arr_btn_id;
	if(popup_exit.indexOf(',')>-1)
	{
		arr_btn_id=popup_exit.split(',');
		if(arr_btn_id.length==2)
		{
			arr_btn_id[0]=arr_btn_id[0].replace(/(^\s*)|(\s*$)/gi, "");
			arr_btn_id[1]=arr_btn_id[1].replace(/(^\s*)|(\s*$)/gi, "");
			popup_show(popup_id, popup_drag, arr_btn_id[0], arr_btn_id[1], '', position, x, y, position_id, 'my');
		}
		else if(arr_btn_id.length==3)
		{
			arr_btn_id[0]=arr_btn_id[0].replace(/(^\s*)|(\s*$)/gi, "");
			arr_btn_id[1]=arr_btn_id[1].replace(/(^\s*)|(\s*$)/gi, "");
			arr_btn_id[2]=arr_btn_id[2].replace(/(^\s*)|(\s*$)/gi, "");
			popup_show(popup_id, popup_drag, arr_btn_id[0], arr_btn_id[1], arr_btn_id[2], position, x, y, position_id, 'my');
		}
	}
	else
		popup_show(popup_id, popup_drag, popup_exit, '', '', position, x, y, position_id, 'my');
	
	//document.getElementById(popup_id).focus();
}

/**
 * 백그라운드 레이어
 * @param bg_chk
 * @return
 */
function BackDivControl(bg_chk , id)
{
	popup_bg=bg_chk;

	if(popup_bg)
	{
		var popup_bg_obj=document.getElementById('popup_bg_div_'+id);
		
		if(popup_bg_obj)
		{
			var popup_bg_parent=popup_bg_obj.parentNode;
			popup_bg_parent.removeChild(popup_bg_obj);
		}

		var oDivBg = document.createElement('div');
		oDivBg.id='popup_bg_div_'+id;
		
		oDivBg.style.left=document.documentElement.scrollLeft + "px";
		oDivBg.style.top=document.documentElement.scrollTop + "px";
		
		oDivBg.style.width='100%';
		oDivBg.style.height='100%';
		oDivBg.style.background='grey';
		oDivBg.style.opacity=0.5;
		oDivBg.style.MozOpacity=0.0;
		oDivBg.style.position='absolute';
		oDivBg.style.overflow='auto';
		oDivBg.style.zIndex=String((1500+popup_count)-1);
		oDivBg.style.filter = "alpha(opacity=50)"; 
		window.document.body.appendChild(oDivBg);

		if((/msie 6/i).test(navigator.userAgent))
		{
			var iframe_bg_obj=document.getElementById('popup_bg_iframe_'+id);
	
			if(iframe_bg_obj)
			{
				var iframe_bg_parent=iframe_bg_obj.parentNode;
				iframe_bg_parent.removeChild(iframe_bg_obj);
			}
			
			var oiframeBg = document.createElement('iframe');
			oiframeBg.id='popup_bg_iframe_'+id;
			oiframeBg.style.left=document.documentElement.scrollLeft + "px";
			oiframeBg.style.top=document.documentElement.scrollTop + "px";
			oiframeBg.style.width='100%';
			oiframeBg.style.height='100%';
			oiframeBg.style.opacity=0.0;
			oiframeBg.style.MozOpacity=0;
			oiframeBg.style.position='absolute';
			oiframeBg.style.overflow='auto';
			oiframeBg.style.zIndex=100;
			oiframeBg.style.filter = "alpha(opacity=0)"; 
			window.document.body.appendChild(oiframeBg);
		}
		
		document.documentElement.onscroll=popup_scroll;

	}

}

function popup_scroll(e)
{
	for (var key in document.getElementsByTagName('div')) {
      if (key.indexOf("popup_bg_div_") > -1) {
    	  var popup_bg_obj=document.getElementById(key);
    		
    		if(popup_bg_obj)
    		{
    			popup_bg_obj.style.left=document.documentElement.scrollLeft + "px";
    			popup_bg_obj.style.top=document.documentElement.scrollTop + "px";
    		}
      }
	}
	
	if((/msie 6/i).test(navigator.userAgent))
	{
		for (var key in document.getElementsByTagName('iframe')) {
		      if (key.indexOf("popup_bg_iframe_") > -1) {
		    	  var iframe_bg_obj=document.getElementById(key);
		    		
		    		if(iframe_bg_obj)
		    		{
		    			iframe_bg_obj.style.left=document.documentElement.scrollLeft + "px";
		    			iframe_bg_obj.style.top=document.documentElement.scrollTop + "px";
		    		}
		      }
			}	
	}
}

/**
 * 팝업 레이어 창닫기
 * @param id 팝업레이어 ID
 * @return
 */
function layerClose(id)
{
	if(id!='wm_TrMsgBox_layer')  //Tr 메세지박스 걸러내기
		if(popup_count>0) popup_count--;
	
	var popup_obj=document.getElementById(id);
	popup_obj.style.display='none';
	
	var popup_bg_obj=document.getElementById('popup_bg_div_'+id);
	
	if(popup_bg_obj)
	{
		var popup_bg_parent=popup_bg_obj.parentNode;
		popup_bg_parent.removeChild(popup_bg_obj);
		popup_bg=false;
	}
	
	var iframe_bg_obj=document.getElementById('popup_bg_iframe_'+id);
	
	if(iframe_bg_obj)
	{
		var iframe_bg_parent=iframe_bg_obj.parentNode;
		iframe_bg_parent.removeChild(iframe_bg_obj);
	}
}


// Copyright (C) 2005-2008 Ilya S. Lyubinskiy. All rights reserved.
// Technical support: http://www.php-development.ru/
//
// YOU MAY NOT
// (1) Remove or modify this copyright notice.
// (2) Re-distribute this code or any part of it.
//     Instead, you may link to the homepage of this code:
//     http://www.php-development.ru/javascripts/popup-window.php
//
// YOU MAY
// (1) Use this code on your website.
// (2) Use this code as part of another product.
//
// NO WARRANTY
// This code is provided "as is" without warranty of any kind.
// You expressly acknowledge and agree that use of this code is at your own risk.

// USAGE
//
// function popup_show(id, drag_id, exit_id, position, x, y, position_id)
//
// id          - id of a popup window;
// drag_id     - id of an element within popup window intended for dragging it
// exit_id     - id of an element within popup window intended for hiding it
// position    - positioning type:
//               "element", "element-right", "element-bottom", "mouse",
//               "screen-top-left", "screen-center", "screen-bottom-right"
// x, y        - offset
// position_id - id of an element relative to which popup window will be positioned

// ***** popup_mousedown *******************************************************

function popup_mousedown(e)
{
  var ie = navigator.appName == "Microsoft Internet Explorer";

  popup_mouseposX = ie ? window.event.clientX : e.clientX;
  popup_mouseposY = ie ? window.event.clientY : e.clientY;
}


// ***** popup_mousedown_window ************************************************

function popup_mousedown_window(e)
{
  var ie = navigator.appName == "Microsoft Internet Explorer";

  if ( ie && window.event.button != 1) return;
  if (!ie && e.button            != 0) return;

  popup_dragging = true;
  popup_target   = this['target'];
  popup_mouseX   = ie ? window.event.clientX : e.clientX;
  popup_mouseY   = ie ? window.event.clientY : e.clientY;

  if (ie)
       popup_oldfunction = document.onselectstart;
  else popup_oldfunction = document.onmousedown;

  if (ie)
       document.onselectstart = new Function("return false;");
  else document.onmousedown   = new Function("return false;");
}


// ***** popup_mousemove *******************************************************

function popup_mousemove(e)
{
  var ie      = navigator.appName == "Microsoft Internet Explorer";
  var element = document.getElementById(popup_target);
  var mouseX  = ie ? window.event.clientX : e.clientX;
  var mouseY  = ie ? window.event.clientY : e.clientY;

  if (!popup_dragging) return;

  element.style.left = (element.offsetLeft+mouseX-popup_mouseX)+'px';
  element.style.top  = (element.offsetTop +mouseY-popup_mouseY)+'px';

  popup_mouseX = ie ? window.event.clientX : e.clientX;
  popup_mouseY = ie ? window.event.clientY : e.clientY;
}

// ***** popup_mouseup *********************************************************

function popup_mouseup(e)
{
  var ie      = navigator.appName == "Microsoft Internet Explorer";
  var element = document.getElementById(popup_target);

  if (!popup_dragging) return;

  popup_dragging = false;

  if (ie)
       document.onselectstart = popup_oldfunction;
  else document.onmousedown   = popup_oldfunction;
}

// ***** popup_exit ************************************************************

function popup_exit(e, target)
{
  popup_target   = this['target'];
  //var ie      = navigator.appName == "Microsoft Internet Explorer";
  var element = document.getElementById(target);

  if(target!='wm_TrMsgBox_layer') //Tr 메세지박스 걸러내기
  {
	  if(element.style.display != 'none' && popup_count>0) 
		  popup_count--;
	  
	  if(element.style.display != 'none' && target.indexOf('messagebox_popup')>-1)
		  if(message_popup_count>0) message_popup_count--;
  }  
	  
  element.style.display = 'none';

  var div_bg = document.getElementById('popup_bg_div_'+target);
  if(div_bg)
  {
	  var popup_bg_parent=div_bg.parentNode;
	  popup_bg_parent.removeChild(div_bg);	
  }
  
  	var iframe_bg_obj=document.getElementById('popup_bg_iframe_'+target);
	
	if(iframe_bg_obj)
	{
		var iframe_bg_parent=iframe_bg_obj.parentNode;
		iframe_bg_parent.removeChild(iframe_bg_obj);
	}
	
  popup_bg=false;


  popup_dragging = false;
  popup_mouseup(e);
}
// ***** popup_show ************************************************************
// 2012-06-14   변만복, gbn 추가 ( myStock 레이어 위치 absolute 여부 )
function popup_show(id, drag_id, exit_id, ok_btn_id, exit_btn_id, position, xx, yy, position_id, gbn)
{
  //Tr 메세지박스 걸러내기
  if(id!='wm_TrMsgBox_layer') popup_count++; //팝업 개수 증가

  var x=parseInt(xx);
  var y=parseInt(yy);
  var element      = document.getElementById(id);
  var exit1_element,exit2_element,exit3_element,drag_element;
  
  if(drag_id!='')
  {
	  drag_element = document.getElementById(drag_id);
	  drag_element.style.cursor="move";
  }
  
  if(exit_id!='')
	  exit1_element = document.getElementById(exit_id);
 
  if(exit_btn_id!='')
	  exit2_element = document.getElementById(exit_btn_id);
  
  if(ok_btn_id!='')
	  exit3_element = document.getElementById(ok_btn_id);

  var width        = window.innerWidth  ? window.innerWidth  : document.documentElement.clientWidth;
  var height       = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight;

  if(gbn != 'my') {	// && popup_count < 2
	  element.style.position = "absolute";  
  } 
  
  element.style.display  = "block";
  

  if (position == "element" || position == "element-right" || position == "element-bottom" || position == "element-bottom-right")
  {
    var position_element = document.getElementById(position_id);

    for (var p = position_element; p; p = p.offsetParent)
      if (p.style.position != 'absolute')
      {
        x += p.offsetLeft;
        y += p.offsetTop;
      }

    if (position == "element-right" ) x += position_element.clientWidth;
    if (position == "element-bottom") y += position_element.clientHeight;
    if (position == "element-bottom-right") {
        x += position_element.clientWidth - element.clientWidth;
        y += position_element.clientHeight;
    }

	if(x<0) x=0;
	if(y<0) y=0;
	
    element.style.left = x+'px';
    element.style.top  = y+'px';
  }

  var scrollLeft,scrollTop;
  var browser=navigator.userAgent.toLowerCase();

  if(browser.indexOf('msie 6')>-1 || browser.indexOf('msie 7')>-1 || browser.indexOf('msie 8')>-1 || browser.indexOf('msie 9')>-1)
  {
	  scrollLeft=document.documentElement.scrollLeft;
	  scrollTop=document.documentElement.scrollTop;
  }
  else if(browser.indexOf('safari')>-1 || browser.indexOf('chrome')>-1)
  {
	  scrollLeft=document.body.scrollLeft;
	  scrollTop=document.body.scrollTop;
  }
  else
  {
	  scrollLeft=document.documentElement.scrollLeft;
	  scrollTop=document.documentElement.scrollTop;
  }
  
  var top=0;
  var left=0;
  if (position == "mouse")
  {
	left=scrollLeft+popup_mouseposX+x;
	top=scrollTop +popup_mouseposY+y;
	
	if(left<0) left=0;
	if(top<0) top=0;
	
    element.style.left = left+'px';
    element.style.top  = top+'px';
  }

  if (position == "screen-top-left")
  {
	left=scrollLeft+x;
	top=scrollTop +y;
		
	if(left<0) left=0;
	if(top<0) top=0;

    element.style.left = left+'px';
    element.style.top  = top+'px';
  }

  if (position == "screen-center")
  {
	left=scrollLeft+(width -element.clientWidth )/2+x;
	top=scrollTop +(height-element.clientHeight)/2+y;
		
	if(left<0) left=0;
	if(top<0) top=0;

    element.style.left = left+'px';
    element.style.top  = top+'px';
  }

  if (position == "screen-bottom-right")
  {
	left=scrollLeft+(width -element.clientWidth )  +x;
	top=scrollTop +(height-element.clientHeight)  +y;
		
	if(left<0) left=0;
	if(top<0) top=0;
	  
    element.style.left = left+'px';
    element.style.top  = top+'px';
  }
  
  var fn=function(){popup_exit(window.event,id);};
  
  if(exit_id!='')
  {
	  exit1_element['target']   = id;
	  if (navigator.appName == "Microsoft Internet Explorer")
	  {
		  //exit1_element.detachEvent('onclick', fn);
		  exit1_element.attachEvent('onclick', fn);
	  }
	  else 
	  {
		  //exit1_element.removeEventListener('click', fn, false);
		  exit1_element.addEventListener('click', fn, false);
	  }
  }
  
  if(exit_btn_id!='')
  {
	  exit2_element['target']   = id;
	  if (navigator.appName == "Microsoft Internet Explorer")
	  {
		  //exit2_element.detachEvent('onclick', fn);
		  exit2_element.attachEvent('onclick', fn);
	  }
	  else
	  {
		  //exit2_element.removeEventListener('click',fn, false);
		  exit2_element.addEventListener('click', fn, false);
	  }
  }
  
  if(ok_btn_id!='')
  {
	  exit3_element['target']   = id;

	  if (navigator.appName == "Microsoft Internet Explorer")
	  {
		  //exit3_element.detachEvent('onclick' , fn);
		  exit3_element.attachEvent('onclick', fn);
	  }
	  else
	  {
		  //exit3_element.removeEventListener('click', fn, false);
		  exit3_element.addEventListener('click', fn, false);
	  }
  }
  
  if(drag_id!='')
  {
	  drag_element['target']   = id;
	  drag_element.onmousedown = popup_mousedown_window;
  }  
 
}

// ***** Attach Events *********************************************************

if (navigator.appName == "Microsoft Internet Explorer")
     document.attachEvent   ('onmousedown', popup_mousedown);
else document.addEventListener('mousedown', popup_mousedown, false);

if (navigator.appName == "Microsoft Internet Explorer")
     document.attachEvent   ('onmousemove', popup_mousemove);
else document.addEventListener('mousemove', popup_mousemove, false);

if (navigator.appName == "Microsoft Internet Explorer")
     document.attachEvent   ('onmouseup', popup_mouseup);
else document.addEventListener('mouseup', popup_mouseup, false);

