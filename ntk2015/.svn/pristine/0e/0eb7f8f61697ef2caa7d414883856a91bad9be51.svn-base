/**********************************************************
*	functions.js
*
**********************************************************/
function greate(x,y){return x>=y?"true":"false";};
function checkRange(number,min,max){if((greate(number,min)=="false")||(greate(max,number)=="false")){return false;}else{return true;}};
function trim(s){return s.replace(/^\s+|\s+$/g, "");};
function isNumber(value){if((undefined == value)||(null == value)){return false;}if (typeof value == 'number'){return true;}return !isNaN(value - 0);};
function isInteger(value){if((undefined == value) || (null == value)){return false;}return value % 1 == 0;};
function isBelongTo(idHuyen,phamvi){
	phamvi = phamvi.replace(/^\s+|\s+$/g, '');
	var ktra = false;
	var arr = phamvi.split(",");
	for(var i=0;i<arr.length;i++){
		if(parseInt(idHuyen)==parseInt(arr[i])){
			ktra=true;
			break;
		}
	}
	return ktra;
}

var fgdot=false;
function isIntKey(evt)
{
	var charCode = (evt.which) ? evt.which : event.keyCode;	
	if ((charCode > 31 && charCode < 48) || (charCode > 57))
        return false;
    return true;
}
function isIntKey(evt,vl,min,max)
{
	if(isInteger(vl.value)){		
		var charCode = (evt.which) ? evt.which : event.keyCode;	
		if ((charCode > 31 && charCode < 48) || (charCode > 57))
	        return false;	
		var v = parseInt(vl.value)*10+parseInt(String.fromCharCode(charCode));
		if(v<min || v>max){
			alert("Bạn chỉ được nhập từ "+min+" đến "+max+"!");
			return false;
		}
		return true;
	}
	return false;
}
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
}
function isNumberKey(evt,vl,min,max)
{
	if(isNumber(vl.value)){
		var charCode = (evt.which) ? evt.which : event.keyCode;
		var text = vl.value;
	    for(var i =0;i<text.length;i++){
	        if(text[i]=="."){fgdot = true; break;}else fgdot = false;
	    }
	    if (charCode > 31 && (charCode < 46 || charCode > 57  || charCode == 47 ) ){
	       return false; 
	    }
	    if(fgdot){ if (charCode == 46 ) return false;}
	    if(charCode != 46){
	    	var v = parseFloat(vl.value+String.fromCharCode(charCode));
	    	if(v<min || v>max){
				alert("Bạn chỉ được nhập từ "+min+" đến "+max+"!");
				return false;
			}
	    }
	    return true;
	}
	return false;
}
function format_number(dec,fix){fixValue = parseFloat(Math.pow(10,fix));retValue = parseInt(Math.round(dec * fixValue))/fixValue;return retValue;}