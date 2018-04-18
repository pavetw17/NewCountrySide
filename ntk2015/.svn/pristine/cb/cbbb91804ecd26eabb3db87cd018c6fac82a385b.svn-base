/**
 * requiments:
 * JsSimpleDateFormat
 * 
 * 
 */

function Lanhtho(){
    // members
    this.tinh_id = -1;
    this.tinh_ten = '';
    
    this.huyen_id = -1;
    this.huyen_ten = '';
    
    this.xa_id = -1;
    this.xa_ten = '';
    
    this.poswkt = '';
    
    this.selected = false;
}
Lanhtho.prototype = {
		setIDTinh:function (id){this.tinh_id  = id;},
		setIDHuyen:function (id){this.huyen_id  = id;},
		setIDXa:function (id){this.xa_id  = id;},
		setPosWKT:function (poswkt){this.poswkt  = poswkt;},
		
		getIDTinh:function (){return this.tinh_id;},
		getIDHuyen:function (){return this.huyen_id;},
		getIDXa:function (){return this.xa_id;},
		getPosWKT:function (){return this.poswkt;},
		
		getTenTinh:function (){return this.tinh_ten;},
		getTenHuyen:function (){return this.huyen_ten;},
		getTenXa:function (){return this.xa_ten;}

}
/** Class Canhdong*/
function Canhdong(source){
	this.id = 0;
	this.color = 0;
	this.ruong_id_array =  null;
	if (source != undefined){
		this.id = source.id;
		this.color = source.color;//màu để tô cánh đồng
		this.ruong_id_array =  source.ruong_id_array.slice();
	}else{
		this.id = 0;
		this.color = 0;//màu để tô cánh đồng
		this.ruong_id_array =  new Array();
	}
	


}
Canhdong.prototype = {
		setID:function (_id){
			this.id  = _id;
		},	
		setFillColor:function ( _color ){
			this.color  = _color;	
		},
		setRuongIDArray:function (_ruongIDArray){
			this.ruong_id_array  = _ruongIDArray;	
		},
		size:function ()
		{
		    return (this.ruong_id_array.length);
		},

		getID:function ()
		{
			return this.id;
		},

		getRuongIDArray:function ()
		{
			return this.ruong_id_array;
		},

		getFillColor:function ()
		{
			return this.color;
		},

		showMe:function ()
		{
		  
		},
		copy:function ()
		{
		   new Canhdong();
		}
		 
};



/** Class Canhdong Manager*/
function CCanhdongManager(){
    this.lstCanhdong = [];
    this.lstCanhdongTmp = [];
    
    this.isCopied = false;
    this.isEditingCanhdong = false;
    this.featureAtRightClick = null;
    this.mapCanhdongChanged = new Map();
}

CCanhdongManager.prototype = {
		
	reset: function(){
	    //this.lstCanhdong = [];
	    //this.lstCanhdongTmp = [];
	    
	    this.isCopied = false;
	    this.isEditingCanhdong = false;
	    this.featureAtRightClick = null;
	    this.mapCanhdongChanged.clear();
	},	
    getListCanhdongClone: function(){
    	return this.lstCanhdongTmp;
    },
    setListCanhdongClone: function(arrayCanhdong){
    	this.lstCanhdongTmp = arrayCanhdong;
    },
    getListCanhdong: function(){
    	return this.lstCanhdong;
    },
    setListCanhdong: function(arrayCanhdong){
    	this.lstCanhdong = arrayCanhdong;
    },
    getFeatureAtRightClick: function(){
    	return this.featureAtRightClick;
    },
    setFeatureAtRightClick: function(feature){
    	this.featureAtRightClick = feature;
    },
    getCanhdongByID: function(id, arrayCanhdong){
		if (arrayCanhdong == undefined || arrayCanhdong == 'undefined')
			arrayCanhdong = this.lstCanhdong;
		
			 for (var i = 0; i < arrayCanhdong.length; i++) {
				 if (arrayCanhdong[i].getID() == id){
					 return arrayCanhdong[i];
				 }
			 }
			 cwrs_debug('no canhdong found by id:'+id+'. Create one new!');
			 return (new Canhdong());
	},
	move: function (srcFeats, toCanhdongID, lstCanhdong){
			 //dest
			 var canhdongDest = this.getCanhdongByID(toCanhdongID, lstCanhdong);
			 this.mapCanhdongChanged.put(canhdongDest.getID(),"");
			 //alert('1) ' +mapCanhdongChanged.size())
			 for (var  i = 0; i < srcFeats.length; i++){
				  var feat = srcFeats[i];
				  canhdongDest.getRuongIDArray().push(feat.fid);
				  
				 //remove id from src
				 //alert('cd id =' + feat.attributes['pid']);
				 var srcCanhdong = this.getCanhdongByID(feat.attributes['pid'],lstCanhdong);
				 this.removeItem(srcCanhdong.getRuongIDArray(),feat.fid);
				 if (srcCanhdong.getID()!=0){
					 this.mapCanhdongChanged.put(srcCanhdong.getID(),"");
				 }
				 //alert(i+ ') '+srcCanhdong.getID() + ' size ='+mapCanhdongChanged.size())
			     //change canh dong id for src
				  feat.attributes['pid'] = canhdongDest.getID();

				  
			 }
			 return this.mapCanhdongChanged;
	},
	getCanhdongChanged: function(){
		 return this.mapCanhdongChanged;
	},
	addCanhdong: function(canhdong, lstCanhdong){
		 return lstCanhdong.push(canhdong);
	},
	getMinCanhdongID: function(lstCanhdong){
		var min = 0;
		for (var i =0; i< lstCanhdong.length; i++){
			var canhdong = lstCanhdong[i];
			if (canhdong.getID() < min)
				min = canhdong.getID();
		}
		 return min;
	},
	countCanhdongNew: function(lstCanhdong){
		var c = 0;
		for (var i =0; i< lstCanhdong.length; i++){
			var canhdong = lstCanhdong[i];
			if (canhdong.getID()<=0)
				c++;
		}
		 return c;
	},
	removeItem: function(array, item){
	    for(var i in array){
	        if(array[i]==item){
	            array.splice(i,1);
	            break;
	            }
	    }
	}
};


/** Class Canhdong Manager*/
function CJsError(){
    this.lstErrors = [];

}

CJsError.prototype = {
		
	clear: function(){
	    this.lstErrors = [];

	},	
    add: function(msg){
    	this.lstErrors.push(msg); 
    },
    hasErrors:function(){
    	if (this.lstErrors.length > 0) return true;
    	return false;
    },
    getErrorMessages:function(motifyError){
    	var msgErrors = '';
    	msgErrors += '<strong>';
    	if (motifyError == undefined) msgErrors += 'Dữ liệu không hợp lệ. Hãy kiểm tra lại những thông tin sau:';
    	else 
    		msgErrors += motifyError;
    	
    	msgErrors += '</strong>';
    	msgErrors +='<br>';
    	for (var i = 0; i < this.lstErrors.length; i++){
    		msgErrors += ((i+1)+'. ' + this.lstErrors[i]);
    		msgErrors += '<br>';
    	}
    	return msgErrors;
    }
};


/**CLASS LUA*/
function Lua()
{
    this.id = 0;
    this.phantram = 0;
  
}
/**CLASS RUONG*/
function Ruong()
{
    this.id = 0;
    this.dientich = 0;
    this.phantram = 0;  
    this.gionglua = 0;
    
}
Ruong.prototype.clone = function() {
	  var newObj = (this instanceof Array) ? [] : {};
	  for (i in this) {
	    if (i == 'clone') continue;
	    if (this[i] && typeof this[i] == "object") {
	      newObj[i] = this[i].clone();
	    } else newObj[i] = this[i];
	  } return newObj;
	};
	
function CCWRSUtils(){
}
CCWRSUtils.prototype = {
		/** Tạo clause AND theo mảng clause, chỉ giữ lại clause hợp lệ, 
		 * ví dụ: createANDClause(['a>0','b=-1','c=null']) thì kết quả là 'a>0'
		 **/
		 removeSpaces:function(s)
		{
			 return s.split(' ').join('');
		},
		createANDClause:function (clauses){
			if(clauses instanceof Array);else {
				alert('arg passed in createANDClause is not array type!');
				return;
			}
			var s='';
			for (var i=0;i<clauses.length;i++){
				var clause=clauses[i].trim();
				clause=this.removeSpaces(clause);
				var val=clause.split('=');
				if(val[1]=='null'||val[1]=='-1') continue;
				if (i!=0)s+=' AND ';
				s+=clauses[i];
				
				
					
			}
			return s;
		},
		/**
		 * Tạo đối tượng json từ một struct tham số 
		 * @param params
		 * 		like {a:"hello", b:5, c:"125"}
		 */
		createJSONObject:function(params, bShowDebug){
			try{
				var jsonStr = JSON.stringify(params);
				if(bShowDebug!=undefined)alert(jsonStr);
				return JSON.parse(jsonStr);
			}catch(err){};
		},
		 rgbToHex:function(r, g, b) { 
			// var char = "0123456789ABCDEF"; 
			//return String(char.charAt(Math.floor(rgb / 16))) + String(char.charAt(rgb - (Math.floor(rgb / 16) * 16))); 
		    return "#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
		 },
			createStringWithSeparator:function (array, separator){
				var s = '';
				for (var i = 0; i < array.length; i++){
						s += array[i];
						if (i < (array.length -1)){
							s += separator;
						}
				}
			   return s;
			   }

 
};
function CCWRSDate(){
}
CCWRSDate.prototype = {
		/**Trả về số ngày trong một tháng của một năm
		 **/
		 getDaysInMonth:function(month,year) {
			var dd = new Date(year, month, 0);
			return parseInt(dd.getDate());
		 } ,
		 getDaysInYear:function(year) {
				var dd = new Date(year, 0, 0);
				return dd.getDate();
			 } ,
		 /**
		  * Chuyển chuỗi date có dạng dd/MM/yyyy sang integer (tính theo mốc 01/01/1970)
		  */
		 stringDate2Int:function(txtDate)
		  {
				var _txtDate = txtDate.trim();
				//alert(_txtDate);
				var arrDMY= _txtDate.split('/');
				if (arrDMY[0].length<2)arrDMY[0]='0'+arrDMY[0];
				if (arrDMY[1].length<2)arrDMY[1]='0'+arrDMY[1];
				txtDate=arrDMY[0]+'/'+arrDMY[1]+'/'+arrDMY[2];
				//alert(txtDate) 
				var oPos = {index: 0, errorIndex: -1};
				var oDate = gDateFormatterDefault.parse(txtDate, oPos);
				gDateFormatterDefault.format(oDate);
				//alert((oDate.getTime()/TIME_OF_DAY_MSEC));
				if(	(parseInt(oDate.getTime()/TIME_OF_DAY_MSEC))!=(Math.ceil(oDate.getTime()/TIME_OF_DAY_MSEC))){
					//alert("Fatal Error: (parseInt(oDate.getTime()/TIME_OF_DAY_MSEC))!=(Math.ceil(oDate.getTime()/TIME_OF_DAY_MSEC))"
					//		+ " => val=" +((oDate.getTime()/TIME_OF_DAY_MSEC)));
				}
				return 	(Math.ceil(oDate.getTime()/TIME_OF_DAY_MSEC));
		 },
		 date2Int:function(oDate)
		  {
			return 	(parseInt(oDate.getTime()/TIME_OF_DAY_MSEC));
		  },
		 Int2Date:function(intDate)
			  {
			var longDate = intDate* TIME_OF_DAY_MSEC;
			var oDate = new Date(longDate);
			return oDate;
		 },
		 Int2DateString:function(intDate,df)
		  {
             if(df==undefined)df=g_dfDefault;
			 var longDate = intDate* TIME_OF_DAY_MSEC;
			 var oDate = new Date(longDate);
			 return (df.format(oDate));
		  },
		long2DateString:function(longDate,df)
			  {
	             if(df==undefined)df=g_dfDefault;
				 var oDate = new Date(longDate);
				 return (df.format(oDate));
		 },
		 /**
		  * Lấy thông tin về thời gian hiện tại (theo server) bao gồm: ngày, tháng, năm và ngày đầu năm( đã chuyển thành int), ngày cuối năm (int) và ngày hiện tại (int)
		  * @param showinfo
		  * 	true nếu muốn hiện alert thông tin, bỏ qua trong trường hợp ngược lại
		  * @returns {rtc}
		  * 	rtc.day
		  * 	rtc.month
		  * 	rtc.year
		  * 	rtc.sti	 //đầu năm
		  *	 	rtc.eti  //cuối năm
		  * 	rtc.cti  //hiện tại (int)
		  */
		getCurrentTime:function (showinfo){

			var rtc = null;
			$.ajax({
				url:MAIN_SERVLET ,
				data:
			    { 
				  action: ACT_GET_CURRENT_TIME,
				},
				async:false,
				error: function (request, status, error) {
					result = false;    
					alert(request.responseText);
				},
				success:function(jsonDate) {
					
					try{
					rtc = JSON.parse(jsonDate);
					var txtSTYear = "01/01/"+rtc.year;
					rtc.styear = gm.date.stringDate2Int(txtSTYear);
					rtc.timeint = gm.date.stringDate2Int(rtc.day+'/'+rtc.month+'/'+rtc.year);
					g_rtc = rtc;
					//alert(g_rtc.timeint)
					var txtStartTimeIntYear = "01/01/"+rtc.year;
					var txtEndTimeIntYear = gm.date.getDaysInMonth(12,rtc.year)+ "/12/"+rtc.year;
					
					g_rtc.sti = gm.date.stringDate2Int(txtStartTimeIntYear);
					g_rtc.eti	= gm.date.stringDate2Int(txtEndTimeIntYear);
					g_rtc.cti= rtc.timeint;
						
					//var strJson = '{\"month\":'+ month +',\"sti\":'+stiyear+',\"eti\":'+etiyear+',\"cti\":'+cti+',\"year\":'+year+',\"day\":'+day+'}';
					if (showinfo != undefined)
					{alert(g_rtc.day+'/'+g_rtc.month+'/'+g_rtc.year+'. Convert 01/01/'+g_rtc.year+'->'+g_rtc.styear);}
					}catch (e){
						alert('Không thể kiểm tra đồng bộ thời gian với máy chủ! Điều này có thể ảnh hưởng đến việc thao tác dữ liệu. Bạn nên thử lại vào thời điểm khác.');
					}
				}
			});
			return rtc;
		},	
		/**	
		 * 
		 * @param df
		 * 		Date formatter. Nếu không chỉ định df mặc định là g_dfDefault (định nghõa
		 * @param txtDate
		 * 		Date string like 10/10/2010 or 10102010
		 * @returns Date object
		 */
		 string2Date:function(txtDate,df) {
			try{
			if(df==undefined)df=g_dfDefault;	
			var oPos = {index: 0, errorIndex: -1};
			var oDate = df.parse(txtDate, oPos);
			df.format(oDate);
			return 	oDate;
			}catch(err){return null;}
		},
		/**
		 * Chuyển đổi chuỗi date vd 01/01/2012 sang json date
		 * @param txtDate
		 * @param df
		 * 		date formater: nếu không chỉ định thì df sẽ mặc định là gDateFormatterDefault (định nghĩa trong global.js)
		 * @returns json date
		 * 		usage: {jsondate}.day,
		 * 						 .month,
		 * 							.year
		 * 							.sti,//start time in integer (01/01/xxxx)
		 * 							.eti,//end time (?/12/xxxx)
		 * 							.cti//current time in int
		 */
		 stringToJSONDate:function(txtDate,df) {
			try{
			var _df;
			if (df == undefined) _df = gDateFormatterDefault;
			else _df = df;
			var oPos = {index: 0, errorIndex: -1};
			var oDate = _df.parse(txtDate, oPos);
			_df.format(oDate);
			var day = oDate.getDate();
			var month = oDate.getMonth()+1;
			var year = oDate.getFullYear();
			
			var txtStartTimeIntYear = "01/01/"+year;

			var txtEndTimeIntYear = this.getDaysInMonth(12, year)+"/12/"+year;
			
			var stiyear = this.stringDate2Int(txtStartTimeIntYear);
			var etiyear	= this.stringDate2Int(txtEndTimeIntYear);
			
			var cti = this.stringDate2Int(day+'/'+month+'/'+year);
			var _cti = this.stringDate2Int(txtDate);
			if (cti != _cti){
				msgerror('Fatal Error at stringToJSONDate');
			}
			//day of year
			var day_of_year = cti - stiyear + 1;
			var strJson = '{\"month\":'+ month +',\"sti\":'+stiyear+',\"eti\":'+etiyear+',\"cti\":'+cti+',\"year\":'+year+',\"day\":'+day+ ',\"doy\":'+day_of_year + '}';
			var json = JSON.parse(strJson);
			return 	json;
			}catch(err){/*msgerror(err);*/return null;}
		},
		/**
		 * Chuyển năm sang json date (mục đích để lấy ngày đầu năm và cuối năm tính theo int (từ 01/01/1970))
		 * @param txtYear
		 * 			kiểu string thuộc 1 trong 2 trường hợp hoặc là năm duy nhất vd 2012 hoặc 2 năm liền kề vd 2011-2012 (cách nhau bởi '-')
		 * @param df
		 * @returns
		 */
		 year2JSONDate:function(txtYear,df) {
			try{
			
				if(txtYear.indexOf("-")>0){
					
				}
				
				var txtDate = "01/01/"+txtYear;	
				var _df;
				if (df == undefined) _df = gDateFormatterDefault;
				else _df = df;
				var oPos = {index: 0, errorIndex: -1};
				var oDate = _df.parse(txtDate, oPos);
				_df.format(oDate);
				var day = oDate.getDate();
				var month = oDate.getMonth()+1;
				var year = oDate.getFullYear();
				var txtStartTimeIntYear = "01/01/"+year;

				var txtEndTimeIntYear = this.getDaysInMonth(12, year)+"/12/"+year;
			
				var stiyear = this.stringDate2Int(txtStartTimeIntYear);
				var etiyear	= this.stringDate2Int(txtEndTimeIntYear);
				var cti = this.stringDate2Int(day+'/'+month+'/'+year);
				var _cti = this.stringDate2Int(txtDate);
				if (cti != _cti){
					msgerror('Fatal Error at stringToJSONDate');
			}
			
			
			
			
			
			var strJson = '{\"month\":'+ month +',\"sti\":'+stiyear+',\"eti\":'+etiyear+',\"cti\":'+cti+',\"year\":'+year+',\"day\":'+day+'}';
			var json = JSON.parse(strJson);
			return 	json;
			}catch(err){msgerror(err);return null;}
		},
		/**
		 * Chuyển date object sang chuỗi theo định dạng vd 01/01/2012
		 * @param df
		 * @param date
		 * @returns
		 */
		 date2String:function(date,df) {
			 if(df==undefined)df=g_dfDefault;
			return df.format(date);
		},
		isValidateDMY:function(dateStr)// dd/MM/YYYY 
		{
			if(dateStr.indexOf("/") == -1){
				return false;
			}
			dt1 = dateStr.split("/");
			dd1  = parseFloat(dt1[0]).toFixed(0);
			mm1 = parseFloat(dt1[1]).toFixed(0);
			yy1 = parseFloat(dt1[2]).toFixed(0);
			if(isNaN(dd1) || isNaN(mm1) || isNaN(yy1)){
				return false;
			}
			dt2 = this.string2Date(dateStr);
			if (dt2 ==null) return false;
			dd2 = dt2.getDate();
			mm2 = dt2.getMonth()+1;
			yy2 = dt2.getFullYear();
			

			if(dd1==dd2 && mm1==mm2 && yy1==yy2){
			    if (dd1 > 31 || dd2 > 31) return false;
			    if (mm1 > 12 || mm2 > 12) return false;
			    return true;
			} 
			else {
				//alert(dd1+'/'+mm1+'/'+yy1);
				//alert(dd2+'/'+mm2+'/'+yy2);
				return false;
			}

		}
 
};
function CCWRSCombobox(){
	this._html_vulua==null;
}
CCWRSCombobox.prototype = {
		/**
		 * Lấy value của một combobox, nếu value chứa '-' ví dụ combobox năm của vụ đông xuân (2011-2012,...)
		 * @param cbbid
		 * @returns
		 * 		nếu value có chứa '-' thì sẽ trả về json object với các trường p0,p1...được tách bởi '-' và trường value gốc
		 * của combobox, vd: cbb có value '2011-2012' thì sẽ trả về json với : {json}.p0=2011,{json}.p1=2012 và {json}.value='2011-2012' 
		 */
		getValue:function (cbbid){
			try{
				var combo = document.getElementById(cbbid);
				var value = combo.options[combo.selectedIndex].value;
				return value;
			}catch(err){alert('getValue of '+cbbid+': '+err);return null;}
		},	
		/**
		 * Lấy
		 * @param cbbid
		 * @returns
		 */
		getValueYear:function (cbbid){
			try{
				var combo = document.getElementById(cbbid);
				var value = combo.options[combo.selectedIndex].value;
				if(value.indexOf("-")>0){
					var vals = value.split("-");
					var strJson="";
					strJson+='{';
					for(var i=0;i<vals.length;i++){
						if(i!=0)strJson+=',';
						strJson += "\"p"+i+"\""+':'+ vals[i].trim(); 
					}
					strJson += "\"value\""+':'+ value; 
					strJson+= '}';
					var json = JSON.parse(strJson);
					return 	json;
				} else {
					
				}
				return value;
			}catch(err){alert('getValue of '+cbbid+': '+err);return null;}
		},	
		getText:function(cbbid){
			try{
				var combo = document.getElementById(cbbid);
				var text = combo.options[combo.selectedIndex].text;
				return text;
			}catch(e){return null;}
		},
		setVulua:function (cbbID,content){
			if(this._html_vulua==null){
				if (content==undefined)
					this._html_vulua=cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_VULUA_TO_CBB, null,TYPE_DATA_HTML_CBB,'*');
				else this._html_vulua=content;
			}
			$("#"+cbbID).html(this._html_vulua);
		},	
		/**
		 * Set danh sách năm for combobox
		 * @param cbb_id
		 * 			combobox id
		 * @param dir
		 * 			Tăng dần hay giảm dần
		 * @param topsymbol
		 * 		   Giá trị đầu (thường để *) và có value=-1	
		 * @param vulua
		 * 		 Nếu là vụ lúa đông xuân (vulua=VU_DX) thì combobox năm sẽ là 2011-2012,2012-2013,...	
		 */
		 setYear:function(cbb_id, dir,topsymbol, vulua){
			
			 var cbbyear_dongxuan="",cbbyear="";
			 if(dir==DESC){
				 for (var i =0; i >= -10; i--){
				 cbbyear_dongxuan += ('<option value=\'' + (parseInt(g_rtc.year)+i)+'-'+( parseInt(g_rtc.year)+i+1)+ '\'>'+(parseInt(g_rtc.year)+i)+' - '+(parseInt(g_rtc.year)+i+1)+'</option>');
				 cbbyear += ('<option value=\'' + (parseInt(g_rtc.year)+i)+'\'>'+(parseInt(g_rtc.year)+i)+'</option>');
			 
				 }
			 } else {
				 for (var i =-10; i <= 0; i++){
					 cbbyear_dongxuan += ('<option value=\'' + (parseInt(g_rtc.year)+i)+'-'+( parseInt(g_rtc.year)+i+1)+ '\'>'+(parseInt(g_rtc.year)+i)+' - '+(parseInt(g_rtc.year)+i+1)+'</option>');
					 cbbyear += ('<option value=\'' + (parseInt(g_rtc.year)+i)+'\'>'+(parseInt(g_rtc.year)+i)+'</option>');
				 
				 }
			 }
			 cbbyear_dongxuan=('<option value=\'' + -1 +'\'>'+topsymbol+'</option>')+cbbyear_dongxuan;
			 cbbyear=('<option value=\'' + -1 +'\'>'+topsymbol+'</option>')+cbbyear;
			 if (vulua!=VU_DX) $("#"+cbb_id).html(cbbyear);
			 else $("#"+cbb_id).html(cbbyear_dongxuan);
		},
		/**
		 * Tạo combobox số
		 * @param cbb_id
		 * @param dir
		 * 			DESC: giảm dần, ASC: tăng dần
		 * @param start_num
		 * @param end_num
		 * @param topsymbol
		 */
		setNumber:function(cbb_id, dir,start_num,end_num,topsymbol){
				
			 var cbbNumber="";
			 if(dir==DESC){
				 for (var i =end_num; i >= start_num; i--){
					 cbbNumber += ('<option value=\'' + (i)+'\'>'+(i)+'</option>');
			 
				 }
			 } else {
				 for (var i =start_num; i <= end_num; i++){
					 cbbNumber += ('<option value=\'' + (i)+'\'>'+(i)+'</option>');		 
				 }
			 }

			 cbbNumber=('<option value=\'' + -1 +'\'>'+topsymbol+'</option>')+cbbNumber;
			 $("#"+cbb_id).html(cbbNumber);
			 $("#"+cbb_id).val(-1);
		},
		/**
		 * 
		 * @param action Chỉ định lấy data cho combobox nào? vd ACT_GET_SAUHAI_TO_CBB để lấy danh sách sâu hại...
		 * @param condition Điều kiện lấy data vd "sau_id=5" để lấy loại sâu có id=5 (sau_id là trường trong bảng csdl)
		 * @param type TYPE_DATA_HTML_CBB hoặc TYPE_DATA_JSON_CBB
		 * @param topsymbol Kí hiệu trên cùng (id =-1)
		 * @param element id của combobox cần load dữ liệu
		 * @param prefix_to_id  prefix thêm vào trước thuộc tính id của mỗi item của combobox 
		 * @param prefix_to_name  prefix thêm vào trước thuộc tính name của mỗi item của combobox 
		 * @param isAppend Trong một số trường hợp combox chứa item thuộc hai mục khác nhau như sâu hai+bệnh hại
		 * 		  isAppend set true để nối dữ liệu mới với dữ liệu cũ trước đó
		 * @returns {String} Chuỗi html content của combobox
		 */
		load:function(action,element,topsymbol, type, condition, prefix_to_id,prefix_to_name,isAppend){

			/*$('#'+element).load(servlet+'action=' + action + '&condition=' + condition + '&type=' +type +'&topsymbol='+topsymbol
			); */
			var oresult="";
			
			if (isAppend == undefined) {
				isAppend = false;
			}
			//alert(isAppend);
			var bAppend = isAppend;
			$.ajax({
					url:MAIN_SERVLET ,
					type: "POST",
					data:
				    { 
					  action: action,
					  condition: condition,
					  type:type,
					  topsymbol:topsymbol,
					  prefix_to_id:prefix_to_id,
					  prefix_to_name:prefix_to_name
					  
					},
					 async:false,
					 error: function (request, status, error) {
					        alert(request.responseText);
					 },
					 success:function(data) {
						var s=""; 
						if (type == TYPE_DATA_HTML_CBB){
							if (bAppend == true){
								var _data = 	$('#'+element).html();
								s=_data + data;
								if(element!=undefined && element!=null)
								$('#'+element).html(s);
							} else {
								s=data;
								if(element!=undefined && element!=null)
								$('#'+element).html(s);
							}
						} else {
							/*if (bAppend == true){
								var _data = 	$('#'+element).html();
								$('#'+element).html(_data + data);
							} else {
								$('#'+element).html(data);
							}*/
						}
						//alert(data)
						oresult=s;
						return data;
				    }});
			return oresult;
		},
		/**
		 * 
		 * @param cbbid
		 */
		getValueDTN:function(cbbid,isShowDebug){
			var dichhai_id= this.getValue(cbbid);
			var  array_id=dichhai_id.split('o');
			   if (array_id[0]==0)
			   {
				    sau_id=array_id[1];
				    benh_id=0;
			   } else {
				    benh_id=array_id[1];
				    sau_id=0;
			   }
	         var strJson = '{\"sau_id\":'+ sau_id +',\"benh_id\":'+benh_id+'}';
	         if(isShowDebug!=undefined) alert(strJson);
	  	 return JSON.parse(strJson);
		}
		
		
 
};
function CCWRSDbscl(parent){
  this.date=new CCWRSDate();
}
CCWRSDbscl.prototype = {
		/**
		 * Lấy khoảng thời gian t1-t2 (tính theo integer). Method này được sử dụng sau khi lấy value từ combobox năm.
		 * @param txtYear
		 * 			Hoặc là string năm vd 2012 hoặc là chuỗi 2 năm liên tiếp 2011-2012
		 * @returns
		 * 		json time {json).sti  //->t1: start time int
		 * 		, {json).eti //->t2: end time int
		 */
		getTimeRangeIntOfCbbYear: function(txtYear){
			if(txtYear.indexOf("-")>0){//2011-2012
				var year=txtYear.split("-");
				return (this.date.year2JSONDate(year[0]));
			}
		}
		
};

function CCWRS_Map(){
	  this.posWKT=null;
	  
}
CCWRS_Map.prototype = {

		onClick:function(posWKT){
				var table = '';
				var id = '';
				if (layer_xa.getVisibility()){
					table = 'tbl_xa_region';
					id = 'xa_id';
				} else if (layer_huyen.getVisibility()) {
					table = 'tbl_huyen_region';
					id = 'huyen_id';
				} else {
					table = 'tbl_tinh_region';
					id = 'tinh_id';	
			}
			this.posWKT=posWKT;	
			g_lanhtho_selected.selected = false;
			
			
			var jsonData = null;
			$.ajax({
								url: REPORT_SERVLET ,
								type: "POST",
								data:
							    { 
								  action: ACT_GET_INFO_AREA_CLICKED,
								  position: posWKT,
								  table:table,
								  id:id
								},
								 async:false,
								 error: function (request, status, error) {
								        alert(request.responseText);
								    },
								 success:function(_data) {
									//$('#'+element).html(data);
									 jsonData = _data;
				           	         //alert(jsonData)
									return _data;
							    }});
					 
					 if (jsonData != null){
						 var jsonObject = JSON.parse(jsonData);
						 g_lanhtho_selected.tinh_id = jsonObject.rows[0].tinh_id;
						 g_lanhtho_selected.tinh_ten = jsonObject.rows[0].tinh_ten;
						 g_lanhtho_selected.huyen_id = jsonObject.rows[0].huyen_id;
						 g_lanhtho_selected.huyen_ten = jsonObject.rows[0].huyen_ten;
						 g_lanhtho_selected.xa_id = jsonObject.rows[0].xa_id;
						 g_lanhtho_selected.xa_ten = jsonObject.rows[0].xa_ten;
						 g_lanhtho_selected.poswkt=posWKT;
						 g_lanhtho_selected.selected = true;
						 //alert(g_lanhtho_selected.tinh_id+","+g_lanhtho_selected.huyen_id+","+g_lanhtho_selected.xa_id)
						 if(g_lanhtho_selected.tinh_id == undefined) g_lanhtho_selected.tinh_id = 0;
						 if(g_lanhtho_selected.huyen_id == undefined) g_lanhtho_selected.huyen_id = 0;
						 if(g_lanhtho_selected.xa_id == undefined) g_lanhtho_selected.xa_id = 0;
					 } 
					 return g_lanhtho_selected;
			},
			getLanhthoSelected:function(field){
				if(field=="tinh_id"){
					if(g_lanhtho_selected.tinh_id == undefined) g_lanhtho_selected.tinh_id = 0;
					return g_lanhtho_selected.tinh_id;
				} else if(field=="huyen_id"){
					if(g_lanhtho_selected.huyen_id == undefined) g_lanhtho_selected.huyen_id = 0;
					return g_lanhtho_selected.huyen_id;
				} else if(field=="xa_id"){
					if(g_lanhtho_selected.xa_id == undefined) g_lanhtho_selected.xa_id = 0;
					return g_lanhtho_selected.xa_id;
				} 
				
				if(field=="tinh_name"){
					return g_lanhtho_selected.tinh_ten;
				} else if(field=="huyen_name"){
					return g_lanhtho_selected.huyen_ten;
				} else if(field=="xa_name"){
					return g_lanhtho_selected.xa_ten;
				} 
				return g_lanhtho_selected;
			},
			getCurrentPosWKT:function(){
				return this.postWKT;
			},
			getCurrentLayerActivated:function(){
				 for(var i=map.layers.length-1;i>0;i--) {  
			 		 if ((map.layers[i].CLASS_NAME == 'OpenLayers.Layer.WMS') && map.layers[i].visibility && (map.layers[i].CLASS_NAME != 'OpenLayers.Layer.Vector')) { // Refresh visible non base  
			          return map.layers[i].name;
			         }  
				 }
				 return '?';
			}
			
};
	
function GenericManager(init){
	if(init==undefined)return;
    // members
	//Combobox
	this.cbb= new CCWRSCombobox();
	this.utils= new CCWRSUtils();
	this.date= new CCWRSDate();
//	this.dbscl= new CCWRSDbscl(this);
	//this.report=new CCWRS_Report();
//	this.map=new CCWRS_Map();
//	this.vientham=new CCWRS_Vientham();
//	this.gui=new CCWRS_GUI();
//	this.dubao=new CCWRS_DuBao();
	//alert('ok')

}
GenericManager.prototype = {
		info:function(){
			alert('Generic Manager version 1.0');
		},
		loadScript:function(url, callback){
			//alert(url)
			$.getScript(url)
			.done(function(script, textStatus) {
			 // alert( textStatus );
			  if(typeof callback == 'function'){
          		callback.call(this);
              }
			})
			.fail(function(jqxhr, settings, exception) {
				alert('can not load '+url);
			});  
		}

};
	
