function DialogShow(url, width, height,idtext) {
		var left = (screen.width - width) / 2;
		var top = (screen.height - height) / 2;
		var params = "width=" + width + ", height=" + height;
		params += ", top=" + top + ", left=" + left;
		params += ", directories=no";
		params += ", location=no";
		params += ", menubar=yes";
		params += ", resizable=no";
		params += ", scrollbars=yes";
		params += ", status=no";
		params += ", toolbar=yes";
		win = window.open(url, idtext, params, "_blank");
		if (window.focus) {
			win.focus();
		}
	}
function stringToDate(date)
{
	var temp = date.split('/');
	var ngay,thang,nam;
	ngay = parseInt(temp[0],10);thang=parseInt(temp[1],10);nam = parseInt(temp[2]);
    if(nam<2000)return -1;
	var vVectorDayOfMonth = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
	var m_ChuKy = parseInt((nam - 2000)/4);
	if(nam%4 == 0 )m_ChuKy--;				
	var m_IntNgay = m_ChuKy*(365*3+366)+(nam-(2000+m_ChuKy*4))*365+1;
	var m_NgayOfThang =0;
	for(var i=0; i<thang-1; i++)
	{
		m_NgayOfThang += vVectorDayOfMonth[i];
	}
	if(nam%4 ==0 && thang >2) m_NgayOfThang ++;
	m_IntNgay = parseInt(m_IntNgay) + parseInt(m_NgayOfThang) + parseInt(ngay);

	return m_IntNgay;		
}

function checkDatex(date){
	var ok =false;
	var temp = date.split('/');
	var ngay,thang,nam;
	if(temp.length !=3){
		jAlert("Bạn nhập sai định dạng ngày/tháng/năm","Thông báo");
		ok =true;
	}
	else
	{
		if(temp[0]!=''){
			ngay = temp[0]-0;
			if(ngay < 1 || ngay > 31){jAlert("Bạn nhập sai ngày","Thông báo");ok =true;}
		}
		if(temp[1]!=''){	
			thang=temp[1]-0;
			if(thang < 1 || thang > 12){jAlert("Bạn nhập sai tháng","Thông báo");ok =true;}	
		}
		if(temp[2]!=''){
			nam = temp[2]-0;
			if(nam <1900 || nam > 3000){jAlert("Bạn phải nhập năm trong khoảng từ 1900 đến 3000","Thông báo");ok =true;}
		}
	}
	return ok;
}

function checkDate(date1,date2){
	var ok =false;
	var bd = stringToDate(date1);
	var kt = stringToDate(date2);
	if(parseInt(bd)> parseInt(kt)){
		ok = true;
	}
	return ok;
}

function getDate(){
	var currentTime = new Date();
	var month = parseInt(currentTime.getMonth() + 1);
	month = month <= 9 ? "0"+month : month;
	var day = currentTime.getDate();
	day = day <= 9 ? "0"+day : day;
	var year = currentTime.getFullYear();
	return day+"/"+month + "/"+year;
}
function cwrs_InitDialog(dlgName, dlgHtml) 
	{ 
	$("#"+ dlgName).load(dlgHtml, function(response, status, xhr) {
			if (status == "error") {
				    
				}
	});
}
function exportReport(option,name){
	var url="";
	if(option=="HTML"){
		url="http://"+hostName+":"+port+"/QLCTTL/baocao_"+name+idhc+".html";          			
	}else if(option=="PDF"){
		url="http://"+hostName+":"+port+"/QLCTTL/baocao_"+name+idhc+".pdf"; 
	}else if(option=="RTF"){
		url="http://"+hostName+":"+port+"/QLCTTL/baocao_"+name+idhc+".rtf"; 
	}
	window.open(url,'download');
}
function isIntKey(evt)
{
   var charCode = (evt.which) ? evt.which : event.keyCode;
   if (charCode > 31 && (charCode < 48 || charCode > 57))
      return false;
   return true;
}
var fgdot=false;
function isNumberKey(evt,vl)
{
	var charCode = (evt.which) ? evt.which : event.keyCode;
	var text = vl.value;
    for(var i =0;i<text.length;i++){
        if(text[i]=="."){fgdot = true; break;}else fgdot = false;
    }
    if (charCode > 31 && (charCode < 46 || charCode > 57  || charCode == 47 ) ){
       return false; 
    }
    if(fgdot){ if (charCode == 46 ) return false;}
    return true;
};
