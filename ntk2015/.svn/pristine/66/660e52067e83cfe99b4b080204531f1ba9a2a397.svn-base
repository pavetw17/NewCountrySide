

function insertText(id, val){
document.getElementById(id).value =val;
}

function move_div(id,top,left, zIndex){
	//alert('move_div');
	$("#"+id).css({"z-index":zIndex,"top":(top+"px"), "left":(left+"px")});
	
}



//Used with jquery easyui
function showDateBox(id_dialog, id_calendar, id_textbox, id_imgdate){
	
 	if ((document.getElementById(id_calendar).style.display == 'none') || (document.getElementById(id_calendar).style.display == ''))
	{
 		
    document.getElementById(id_calendar).style.display = "block";
    //showHelp(id_dialog);
   // alert($('#'+id_dialog).offset().top+$('#'+ id_dialog).position().top + 28 +", "+ $('#'+id_dialog).position().left+$('#'+id_dialog).offset().left);
    move_div(id_calendar, $('#'+id_dialog).offset().top+$('#'+ id_imgdate).position().top - 2, $('#'+id_imgdate).position().left+$('#'+id_dialog).offset().left,10000);
    //alert(document.getElementById(id_textbox).value);
    var dateShown;
    if (document.getElementById(id_textbox).value == ''){
    	dateShown = new Date();
    }
    else{
    	try{
    		dateShown = gm.date.string2Date(document.getElementById(id_textbox).value);
    	}catch(err){
    		dateShown = new Date();
    	}
    }
  	$('#'+ id_calendar).calendar({         width:180,      height:180,    current: dateShown,
		 onSelect: function(date) {
				
			var month = date.getMonth()+1;
			var day = date.getDate();
			day = ((day < 10)?('0'+day):day);
			month = ((month < 10)?('0'+month):month);
			// alert(date.getDate() +"/"+ (date.getMonth()+1) + "/" + date.getFullYear()); 
			insertText(id_textbox, day +"/"+ month + "/" + date.getFullYear());
			document.getElementById(id_calendar).style.display = 'none';
		 }
		});
    $('#'+ id_calendar).calendar('moveTo',dateShown);

	} else {
		document.getElementById(id_calendar).style.display = 'none';
	}
	 
	 }

function closeDateBox(id_calendar){
	document.getElementById(id_calendar).style.display = 'none';
		
}

function getIntNumber(textNum){
	var i = 0;
	try {
		i = parseInt(textNum);
		if (isNaN(i)) i=0;
	} catch (err) {
		i = 0;
	}
	return i;
}
function getIntNumberSafe(textNum){
	var i = 0;
	try {
		i = parseInt(textNum);
		if (isNaN(i)) i=0;
	} catch (err) {
		i = 0;
	}
	return i;
}
function getFloatNumberSafe(textNum){
	var i = 0;
	try {
		i = parseFloat(textNum);
		if (isNaN(i)) i=0;
		
	} catch (err) {
		i = 0;
	}
	return i;
}/*
function showFormattedTime(txtDate) {

	
	oDf.format(oDf.parse(txtDate, 0));
	//alert(d.getTime());
}*//*
function showParsedTime(txtDate) {
	var oPos = {index: 0, errorIndex: -1};
	var oDate = dateFormatter.parse(txtDate, oPos);
	dateFormatter.format(oDate);
	//alert(oDate.getTime()+","+oDate.getDate() +"/"+ (oDate.getMonth()+1) + "/" + oDate.getFullYear() +","+oDate.getHours()+":"+oDate.getMinutes()+":"+oDate.getSeconds());
	
}
*/
/**
 * 
 * @param df
 * 		Date formatter
 * @param txtDate
 * 		Date string like 10/10/2010 or 10102010
 * @returns Date object
 *//*
function stringToDate(df, txtDate) {
	try{
	var oPos = {index: 0, errorIndex: -1};
	var oDate = df.parse(txtDate, oPos);
	df.format(oDate);
	return 	oDate;
	}catch(err){return null;}
}

*/




function parseSearch(id_time_field, searchText){
//alert('searchText: '+searchText);
if (searchText == null)
	searchText = "";
	searchText = searchText.trim();
	searchText = searchText.replace(/\//gi, '');//thay thế kí tự '/' = ''
if ((searchText !="") && (searchText != ALL_SYMBOL)) {
	if (searchText.search("to") != -1) {//Search according to date time
		var arrtime = searchText.split("to");
		var strDateFrom = arrtime[0];
		var strDateTo   = arrtime[1];
         
		try {
			strDateFrom = strDateFrom.trim();
			strDateTo = strDateTo.trim();
		    if (strDateFrom =='')
		    	strDateFrom = '01011970';
		    if (strDateTo =='')
		    	strDateTo = '01013000';
		    
			//alert(strDateFrom+","+strDateTo);
			if (strDateFrom.length < 6){
				
				strDateFrom += (new Date).getFullYear();
			}
			if (strDateTo.length < 6){
				
				strDateTo += (new Date).getFullYear();
			}
			var oDateStart =    stringToDate(g_dfSearch_ddMMyy, strDateFrom);
			var oDateEnd   =	stringToDate(g_dfSearch_ddMMyy, strDateTo);
			/*alert("strDateFrom = " + strDateFrom + " ,"
					+ Math.ceil(oDateStart.getTime()/TIME_OF_DAY_MSEC));
			alert("strDateTo = " + strDateTo + " ,"
					+ Math.ceil(oDateEnd.getTime()/TIME_OF_DAY_MSEC));*/
			var intDateStart = Math.ceil(oDateStart.getTime()/TIME_OF_DAY_MSEC);
			var intDateEnd = Math.ceil(oDateEnd.getTime()/TIME_OF_DAY_MSEC);
			
			var result = ' '+id_time_field+' >=' +intDateStart +' AND ' +id_time_field +'<='+intDateEnd;
			//alert('Tìm kiếm:' + result);
			return result;

	} catch (err) {
			alert('Error:Định dạng ngày tháng không đúng');
		}

	} else {//Search by content subject or only date from
		 n = getIntNumber(searchText);
		
		if (n >= 0) {//search in date or content subject
			if (n > 0101) {//date
				if (n <= 3112) { //+ year like 3112, + 2010
					
					searchText += (new Date()).getFullYear();
					//var oCurrentDate=    stringToDate(g_dfSearch_ddMMyy, searchText);
					
					// intDate = Math.ceil(oCurrentDate.getTime()/TIME_OF_DAY_MSEC);
					//alert('search by this date: '+intDate);

				} else {//full like 31122007
					//var oCurrentDate=    stringToDate(g_dfSearch_ddMMyy, searchText);
					//var intDate = Math.ceil(oCurrentDate.getTime()/TIME_OF_DAY_MSEC);
					//alert('search by this date: '+intDate);
				}

				try {
					var byODate = gm.date.string2Date(searchText );
				  /*alert("byDate = " + searchText +'('+dateToString(g_dfSearch_ddMMyy,byODate)+')'
							+ " ," + Math.ceil(byODate.getTime()/TIME_OF_DAY_MSEC));*/
					var intSearchInDate = Math.ceil(byODate.getTime()/TIME_OF_DAY_MSEC);
					//alert('Tìm kiếm trong ngay:' + intSearchInDate);
					var result = ' ' +id_time_field+' =' +intSearchInDate;
					//alert('Tìm kiếm:' + result);
					return result;
					
				} catch (err) {
					alert(err);
				}
			} else {//subject
				
		}
		} else {//by only content subject
			
		}
	}
}

}





