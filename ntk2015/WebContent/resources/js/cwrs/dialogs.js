/**
 * Declare global variables for each dialogs
 */

//Dialog: Thông tin gieo cấy
var g_dlg_ttgc_datagrid_total = -1;
var g_dlg_ttgc_datagrid_rows  = 0;
function checkRoleDieutraRuongCanhdong(){
	//return true;
	//alert('check login');

	//return false;

	if (g_acc_signedin == false){
		msginfo('Bạn chưa đăng nhập!');
		return false;
	} else
	{ 
		if (g_xa_id_by_search != g_mlogin.xa_id){
			msgwarning('Bạn không có quyền thao tác dữ liệu của địa phương này.');
			return false;
		} else
			return true;
	}
	return false;
}
function checkRoleXa(){
	if (((g_acc_role==XA_ROLE)&&(g_lanhtho_selected.xa_id == g_mlogin.xa_id))
	//		||((g_acc_role==TINH_ROLE)&&(g_lanhtho_selected.tinh_id == g_mlogin.xa_id))
	//		||((g_acc_role==HUYEN_ROLE)&&(g_lanhtho_selected.huyen_id == g_mlogin.xa_id))
			||(g_acc_role==ADMIN)) return true;
	else return false;
}

function checkRoleHuyen(){
	if (((g_acc_role==HUYEN_ROLE)&&(g_lanhtho_selected.huyen_id == g_mlogin.huyen_id))
		//	||((g_acc_role==TINH_ROLE)&&(g_lanhtho_selected.tinh_id == g_mlogin.xa_id))
			||(g_acc_role==ADMIN)) return true;
	else return false;
}

function checkRoleTinh(){
	if (((g_acc_role==TINH_ROLE)&&(g_lanhtho_selected.tinh_id == g_mlogin.tinh_id))
			||(g_acc_role==ADMIN)) return true;
	else return false;
}

function checkRoleCuc(){
	// return true;
	if ((g_acc_role==BVTV_ROLE)||(g_acc_role==ADMIN)) return true;
	else return false;
}	
function checkDataExists(servlet, tableName,condition){
	var ret = -1;
	$.ajax({
		url:servlet ,
		data:
		{ 
			action: ACT_DB_CHECK_DATA_EXISTS,
			tableName: tableName,
			fieldName:'*' ,
			condition: condition 
		},
		async:false,
		error: function (request, status, error) {
			ret = -1;    
		},
		success:function(_ret) {
			ret = parseInt(_ret);
	   }
	});
	return ret;
}

function show_login_dialog(){

//	 move_div('form_login',410,410,10000) ;
	//Hiển thị dialog
	$('#dlg_login').dialog({
		title:"        Đăng nhập hệ thống",
	    		    modal:false , open: function() {$(this).dialog('widget').draggable('option', {containment: false});}, 
		height: 250,
		width: 400,
		collapsible:false

	    });
	  
}


function login(username, password){
	if (g_acc_signedin){
		logout();
		return;
	}

	//var username = document.getElementById('dlg_login_username').value;
	//var password = document.getElementById('dlg_login_password').value;
	if (username == undefined || password==undefined){
		username = $('#acc_login_user').val();
		password = $('#acc_login_pass').val();
		
	}
	g_acc_signedin = false;
	var jr = null;
	$.ajax({
		url:MAIN_SERVLET ,
		data:
	    { 
		 action: ACT_SIGNIN,
		  username: username,
		  password:password,
		  datareturn: YES
		},
		async:false,
		success:function(jsonDataResult) {
		//	alert(jsonDataResult)
			var ojson = JSON.parse(jsonDataResult);
			
		  	  if (ojson.code == DB_STR_OK){
		  		// alert(ojson.json)
		  		g_mlogin = JSON.parse(ojson.json);
		  		
				g_lanhtho_selected.tinh_id = g_mlogin.tinh_id;
				g_lanhtho_selected.huyen_id = g_mlogin.huyen_id;
				g_lanhtho_selected.xa_id = g_mlogin.xa_id;
				
		  		g_acc_signedin = true;
		  		g_acc_role = g_mlogin.role;
		  		g_acc_xa_id = g_mlogin.xa_id;
		  		g_mlogin.signedin = true;
		  		g_acc_password = password;
		  		g_acc_username = username;
		  		$("#acc_login_btnchange").attr('disabled',false);
		  		msginfo('Xin chào bạn <b>' + g_mlogin.ten+ '</b>. Bạn đã đăng nhập thành công!');//<'+g_mlogin.xa_id+'>');
		  		//precache_feature_geometry(g_acc_xa_id);
		  		//$('#dlg_login').dialog('close');
		  		$("#acc_login_btnenter").val('Thoát');
		  		zoom_map_to_area(map,g_mlogin.tinh_id,g_mlogin.huyen_id, g_mlogin.xa_id);

		  	  } else {
		  		msgwarning('Tên hoặc mật khẩu không đúng!');
		  		  g_acc_signedin = false;
		  		  //g_mlogin.signedin = false;
		  	  }
		  
		}
	});
	
}
function goBackLoginPanel(){
	showPanelLogin();
}
function showPanelChangePassword(){
	$('#account_panel').corner();
	//$('#panel_change_password').hide();
	$('#account_panel').css({background:"rgb(0, 0, 0)"})
	$("#account_panel").flip({
		direction:'lr',
		content: $('#panel_change_password').html()
	});
	 $('#account_panel').css({background:"rgba(0, 0, 0, 0.50)"})
}
function showPanelLogin(){
	 
	 $('#account_panel').css({background:"rgb(0, 0, 0)"})
	$('#account_panel').corner();
	$("#account_panel").revertFlip();
	$('#account_panel').css({background:"rgba(0, 0, 0, 0.50)"})
}
function logout(){
	  g_acc_signedin = false;
	  g_acc_xa_id = 0;
	  g_acc_username = '';
	  g_acc_password = '';
	  g_mlogin.role = -1;
  	  g_mlogin.xa_id =-1;
  	  g_mlogin.signedin = false;
	  
	  $("#acc_login_btnenter").val('Đăng nhập');
}
function changePassword(){
	//check pass cu
	if ($('#acc_pass_old').val() != g_acc_password){
		msginfo('Mật khẩu hiện tại không đúng.');
		$('#acc_pass_old').val('');
		return;
	}
	
	//check pass new
	if ($('#acc_pass_new1').val() ==''){
		msginfo('Hãy nhập mật khẩu mới.');
		return;
	}
	if ($('#acc_pass_new2').val() ==''){
		msginfo('Hãy nhập lại mật khẩu mới lần 2.');
		return;
	}
	if ($('#acc_pass_new1').val() != $('#acc_pass_new2').val()){
		msginfo('Mật khẩu mới không chính xác (bạn phải nhập giống nhau ở cả 2 lần nhập).');
		$('#acc_pass_new1').val('');
		$('#acc_pass_new2').val('');
		return;
	}
	var strSQL = 'UPDATE tbl_user SET user_password=\''+$('#acc_pass_new1').val()+'\' WHERE user_xa='+g_acc_xa_id + ' AND user_password=\''+g_acc_password+'\'';             
	if (cwrs_execSQLDirectly2DB(MAIN_SERVLET, strSQL,true) == DB_STR_OK){

		msginfo('Thay đổi mật khẩu thành công!');
		showPanelLogin();

	} else {
		msgwarning('Hệ thống không có khả năng thay đổi mật khẩu của bạn tại thời điểm này.Hãy thử lại sau.');
	}
}








function getNewValueOfField(tablename, field){
	var max = -1;
		$.ajax({
			url:MAIN_SERVLET ,
			data:
			{ 
			action: ACT_DB_MAX_DATA,
			tableName:tablename,
			fieldName:field ,
			condition: null
			},
			async:false,
			success:function(result) {
				max = parseInt(result)+1 ;
			}
   }); 
	return max;	
}
/**
 * 
 **/
function getSumField(tablename, field, condition){
	var json = null;
	var sql = "SELECT SUM("+field+") as sum FROM " +tablename + " "+((condition == undefined || condition == null)?"":(" WHERE "+condition));
	
	json = cwrs_getDataDynamic(MAIN_SERVLET, sql, false);
	//alert(sql);
	if (json != null) return json.rows[0].sum; 
	return -1;	
}

function getCbbValue(id){
	var combo = document.getElementById(id);
	var val = combo.options[combo.selectedIndex].value;
	return val;
}
function getCbbText(id){
	var combo = document.getElementById(id);
	var val = combo.options[combo.selectedIndex].text;
	return val;
}

//need pass diaphuong 
function getTimeRange2CreateHientrangCCGL(time_int_select,condition){
	
//	var sql = "select ttgc_ngaygieocay_mp  as maxtime,ttgc_vulua_mp as vulua_id from tbl_ttgc_ruong_mp WHERE ttgc_ngaygieocay_mp=(SELECT MAX(ttgc_ngaygieocay_mp) from tbl_ttgc_ruong_mp where  ttgc_ngaygieocay_mp <="+time_int_select+")";
	//alert(1);
	

	 sql= 
		 " select ttgc_ngaygieocay_mp  as maxtime, "+
	     "    ttgc_vulua_mp as vulua_id "+
	     " from tbl_ttgc_ruong_mp "+
		"	  WHERE ttgc_ngaygieocay_mp= "+
		"	  (SELECT MAX(ttgc_ngaygieocay_mp) "+
		"	   from tbl_ttgc_ruong_mp "+
		"	   where  ttgc_ngaygieocay_mp <=" +time_int_select+ 
		"	   AND tbl_ttgc_ruong_mp.ttgc_ruong_id_mp IN "+
		"	   (SELECT tbl_ruong_region.ruong_id FROM tbl_ruong_region WHERE  "+condition+"))"+
		"	   GROUP BY ttgc_vulua_mp, ttgc_ngaygieocay_mp ";
	// alert(sql);
	 json = cwrs_getDataDynamic(MAIN_SERVLET, sql, false);
//	alert(sql)
	if (json != null &&  json.rows.length>0){
		if((time_int_select - json.rows[0].maxtime) >120){
			time_int1=1;
			time_int2=0;

		} else {
			time_int2 = json.rows[0].maxtime;
			time_int1=time_int2-120;
		}
		var vulua_id=json.rows[0].vulua_id;
		var strJson = '{\"time_int1\":'+ time_int1 +',\"time_int2\":'+time_int2+',\"vuluaid\":'+vulua_id+'}';
		var json = JSON.parse(strJson);
		return json;
	}
	return null;	
}

/**
 * COMMON
 */
function notify_ruong_error(lstRuongerr){
	
	var ruong_ids = lstRuongerr.split(SQL_ID_LIST_SEP);
	//alert('ruong_ids.size = ' + ruong_ids.length);

	for (var i = 0; i < ruong_ids.length-1; i++){
		var feat = g_layer_vector_ruong.getFeatureByFid(ruong_ids[i]);
		//alert('ruong_ids = ' + ruong_ids[i] + ', '+feat );
		//alert('ruong_ids = ' + ruong_ids[i] +',feat.fid='+feat.fid+',g_styleError.fillColor'+g_styleError.fillColor);
		g_layer_vector_ruong.drawFeature(feat, g_styleError);
	}
	msgerror('Số liệu điều tra đã được nhập cho những ruộng/cánh đồng được đánh dấu');
	
}
function notify_canhdong_error(lstCanhdongErrs){
	
	var canhdong_ids = lstCanhdongErrs.split(SQL_ID_LIST_SEP);
	//alert('canhdong_ids.size = ' + canhdong_ids.length);

	for (var i = 0; i < canhdong_ids.length-1; i++){
		
		var feats = g_layer_vector_ruong.getFeaturesByAttribute('pid',canhdong_ids[i]);
		for (var j = 0; j < feats.length; j++){
			var feat = feats[j];
			//alert('ruong_ids = ' + ruong_ids[i] +',feat.fid='+feat.fid+',g_styleError.fillColor'+g_styleError.fillColor);
			g_layer_vector_ruong.drawFeature(feat, g_styleError);
		}
		
	}
	msgerror('Số liệu điều tra đã được nhập cho những cánh đồng được đánh dấu');
	
}
					 //MAIN_SERVLET, ACT_GET_GIONGLUA_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_dtr_ttgc_cbgionglua'
function cwrs_Data2ComboBox(servlet, action, condition,type,topsymbol, element,prefix_to_id,prefix_to_name,isAppend){

	/*$('#'+element).load(servlet+'action=' + action + '&condition=' + condition + '&type=' +type +'&topsymbol='+topsymbol
	); */
	var oresult="";
	
	if (isAppend == undefined) {
		isAppend = false;
	}
	//alert(isAppend);
	var bAppend = isAppend;
	$.ajax({
			url:servlet ,
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
}

function cwrs_testnhap(servlet, action, condition,type,topsymbol, element,prefix_to_id,prefix_to_name,isAppend){
alert(" Servlet: " + servlet + " Action: " + action + " Condition: " + condition + " Type: " + type + " Topsymbol: " + topsymbol + " Element: " + element + " ");
	/*$('#'+element).load(servlet+'action=' + action + '&condition=' + condition + '&type=' +type +'&topsymbol='+topsymbol
	 ); */
	var oresult="";

	if (isAppend == undefined) {
		isAppend = false;
	}
	//alert(isAppend);
	var bAppend = isAppend;
	$.ajax({
		url:servlet ,
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
			var _data = 	$('#'+element).html();
			s=_data + data;
			//alert("bao " + s);
			$('#'+element).html(s);
			//alert(data);
			oresult=s;
			return data;
		}
	});
	return oresult;

}


/**used for insert/update operations*/
function cwrs_execSQLDirectly2DB(servlet, strSQL, async){
	var result = DB_STR_FAILED;
	$.ajax({
		url:servlet,
		data:
	    { 
		  action: ACT_EXEC_SQL_FROM_CLIENT,
		  sqlquery: strSQL,
		  async:async
		},
		async:false,
		
		success:function(ret) {
			
				result = ret;
		}
	});

	return result;	
}

function cwrs_getDataBySQLDirectlyDB(servlet, strSQL, async){
	var result = null;
	$.ajax({
		url:servlet,
		data:
	    { 
		  action: ACT_DB_GET_DATA_DYNAMIC,
		  sqlquery: strSQL,
		  async:async
		},
		async:false,
		
		success:function(jsonData) {
			
				result = jsonData;
		}
	});

	return result;	
}
/**Universal get data
 *  Lấy dữ liệun và tạo json object với mỗi field name là tên field trong câu lệnh select colum1,... 
 *
 **/
function cwrs_getDataDynamic(servlet, strSQL, async){
	var jsonObject = null;
	$.ajax({
		url:servlet,
		data:
	    { 
		  action: ACT_DB_GET_DATA_DYNAMIC,
		  sqlquery: strSQL,
		  async:async
		},
		async:false,
		
		success:function(jsonData) {
		
			if (jsonData =='')jsonObject = null;
			else
			jsonObject = JSON.parse(jsonData);
		}
	});

	return jsonObject;	
}
function cwrs_Data2CheckboxBox(servlet, action, condition,type,topsymbol, element,prefix_to_id,prefix_to_name,isAppend){

	/*$('#'+element).load(servlet+'action=' + action + '&condition=' + condition + '&type=' +type +'&topsymbol='+topsymbol
	); */
	
	if (isAppend == undefined) {
		isAppend = false;
	}
	//alert(isAppend);
	var bAppend = isAppend;
	$.ajax({
			url:servlet ,
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
			 //       alert(request.responseText);
			    },
			 success:function(data) {
				if (bAppend == true){
				   var _data = 	$('#'+element).html();
				   $('#'+element).html(_data + data);
				} else {
				   $('#'+element).html(data);
				}
		//		alert(data)
				return data;
		    }});
}

function cwrs_Data2ComboBox_arrayElement(servlet, action, condition,type,topsymbol, element){
	$.ajax({
			url:servlet ,
			type: "POST",
			data:
		    { 
			  action: action,
			  condition: condition,
			  type:type,
			  topsymbol:topsymbol
			},
			 async:false,

			 success:function(data) {
				 for ( var i = 0; i < element.length; i++) { 
					  $('#'+element[i]).html(data);
				 }
				return data;
		    }});
}

function cwrs_Data2ComboBox1(servlet, action, condition,type,topsymbol, element){

	/*$('#'+element).load(servlet+'action=' + action + '&condition=' + condition + '&type=' +type +'&topsymbol='+topsymbol
	); */

	$.ajax({
			url:servlet ,
			type: "POST",
			data:
		    { 
			  action: action,
			  condition: condition,
			  type:type,
			  topsymbol:topsymbol

			  
			},
			 async:false,

			 success:function(data) {
			
				   $('#'+element).html(data);
			
				return data;
		    }});
}

function cwrs_SendData2DB(servlet, action, condition, strSQL, strJSONObject){
	$.post(servlet ,									
		    { 
			  action: action,
			  object: strJSONObject,
			  sqlquery: strSQL,
			  condition: condition
			},
		    function(result) {
				//alert(result);
				return result;
		    });
}
/*function cwrs_CreateMapCBB(servlet, action, type, out_jsonobject){
	
	var hashMap = null;
	$.ajax({url:servlet ,
		type: "POST",
		data:
	    { 
		  action: action,
		  type:TYPE_DATA_JSON_CBB,
		},
		 async:false,
		 error: function (request, status, error) {
		        alert(request.responseText);
		        hashMap =  null;
		 },
		 success:function(data) {
			 hashMap = new Map();
				var jsonObject = JSON.parse(data);
				out_jsonobject = jsonObject;
				for (var i = 0; i < jsonObject.length; i++){
					hashMap.put(jsonObject[i].id, jsonObject[i].text);
				}
			return data;
	    }});
	return hashMap;
}*/
function cwrs_getJsonStringCBB(servlet, action, options){
	
	var jsonStr = null;
	if(options==undefined)options={};
	$.ajax({url:servlet ,
		type: "POST",
		data:
	    { 
		  action: action,
		  type:TYPE_DATA_JSON_CBB,
		  condition:options.condition,
		  topsymbol:options.topsymbol,
		  prefix_to_id:options.prefixid,
		  prefix_to_name:options.prefixname
		},
		 async:false,
		 error: function (request, status, error) {
		        alert(request.responseText);
		 },
		 success:function(data) {
			 jsonStr = data;
			return data;
	    }});
	return jsonStr;
}
function cwrs_CreateJsonCBB(servlet, action, options){
	
	var jsonObj = null;
	if(options==undefined)options={};
	var data = cwrs_getJsonStringCBB(servlet, action, options);
	jsonObj = JSON.parse(data);
	return jsonObj;
}

function cwrs_joinJSONCBB(arrayJsonString){
	var s ="[{}]";
	for (var i =0; i < arrayJsonString.length;i++){
		if (i==0){	
		  s = arrayJsonString[i].substring(0,arrayJsonString[i].length-1);
		} else if (i == (arrayJsonString.length-1)){
			s += arrayJsonString[i].substring(1,arrayJsonString[i].length);
		} else {
			s += arrayJsonString[i].substring(1,arrayJsonString[i].length-1);
		}
		if (i<arrayJsonString.length-1)
			s +=',';
		
	}
	//alert('json joined: '+s);
	var jsonObj = JSON.parse(s);
	return jsonObj;
}

//Send data to database for insert/update
function cwrs_InsUpdMultiRecord2DB(servlet, action, condition, strSQL, strListValues, sqlTypeOrder, strListIDs, strJSONObject){
	var result = DB_STR_FAILED;
	$.ajax({
		url:servlet ,
		data:
	    { 
		  action: action,
		  object: strJSONObject,// strJSONObject,
		  sqlquery: strSQL,
		  condition: null,
		  values: strListValues,
		  sqlTypeOrder:sqlTypeOrder, //thứ tự kiểu dữ liệu của chuỗi values (cần cho sử dụng pre-statement
		  ids: strListIDs
		},
		async:false,
		
		success:function(ret) {
				result = ret;
		}
	});

	return result;	
}

function cwrs_InsertObject2DB(servlet, action, condition, strSQL, hasReturnID, strJSONObject){
	$.post(servlet ,									
		    { 
			  action: action,
			  object: strJSONObject,
			  sqlquery: strSQL,
			  condition: condition,
			  hasReturnID: hasReturnID,
			  id:''
			},
		    function(result) {
				alert(result);
				return result;
		    });
}
function cwrs_delete_data(servlet, tablename,condition){
	var result = false;
	$.ajax({
		url:servlet ,
		data:
		{ 
			action: ACT_DB_DELETE_OBJECT,
			tableName:tablename,
			condition:condition
		},
		async:false,
		error: function (request, status, error) {
			result = false;    
		},
		success:function(jsonDataResult) {
			var jr = JSON.parse(jsonDataResult);
			if(jr.code == DB_STR_OK)
				result = true;
			else {
				msgerror(jr.msg);
				result = false;
			}
		}
	});
	return result;
}
function datagrid_delete_row(servlet, odatagrid, rowindex, tablename, condition){
	if (cwrs_delete_data(servlet, tablename,condition)){
		odatagrid.datagrid('deleteRow', rowindex);   
	    var rowcount = odatagrid.datagrid('getRows').length;
	    for(var i=0; i<rowcount; i++){
	    	odatagrid.datagrid('updateRow',{
	    		index:i,
	    		row:{action:''}
	    		});
	    }		
		msginfo('Xóa dữ liệu thành công.');
	    return true;
	} else
		return false;
}
/**
 * load data to datagrid without errors
 * @param datagrid_id
 */
function datagrid_load_safe(action, datagrid_id){
	try {
		$('#' + datagrid_id).datagrid(action); 	
	}catch (err){}
}
function odatagrid_load_safe(action, odatagrid){
	try {
		odatagrid.datagrid(action); 	
	}catch (err){}
}
/**
 * Insert/Update với 1 (theo indexRow param) hoặc tất cả những row đang edit trên datagrid 
 * @param odatagrid
 * @param tblname
 * @param indexRow
 * 			nếu indexRow được chỉ định thì chỉ có row này được insert/update
 * @returns
 */
function datagrid_insert_multirow_editing(odatagrid, tblname, options){
	var fields = odatagrid.datagrid('getColumnFields',{frozen:false});
	/*alert(field);*/
	var rows = odatagrid.datagrid('getRows');
	if (options == undefined)options={};
	//alert('options.rowIndex ='+options.rowIndex)
	//INSERT+UPDATE
	var insertSql = '';
	var updateSql = '';
	var columnFieldIns ='';
	var columnFieldUpd ='';
	for (var i = 0; i<rows.length; i++){
		if (rows[i].editing && ((options.rowIndex == undefined)?'1==1':(i == options.rowIndex))){
			var isNew = (rows[i][odatagrid.datagrid('options').idField] == undefined);
			
			if (isNew){
				insertSql += '(';
			}
			else{
				//updateSql += '(';
				updateSql += '';
			}				
			columnFieldIns = '';
			for(var j=0; j<fields.length-1; j++){//trừ column action ở cuối
		        var skip = false;
		        skip = false;
		       //alert('options.skipFields.length: '+options.skipFields.length);
		        if (options.skipFields != undefined)
				for (var sk = 0; sk < options.skipFields.length; sk++){
					// alert('fields[j] == options.skipFields[sk]: '+fields[j]+','+options.skipFields[sk]);
					if (fields[j] == options.skipFields[sk]){
						skip = true;
						break;
					}
				}else;// alert('skip skipFields undefined')
				if (skip){/*alert('skip '+fields[j]) */;continue;}
				var opts = odatagrid.datagrid('getColumnOption', fields[j]);  
		        //alert('fields['+j+']: '+fields[j])
		        //alert('opts.field: '+opts.field)
		        
		        var val;
		        columnFieldIns += fields[j];
		        
                
		        if (opts.editor == 'text'){
		        	val = $(odatagrid.datagrid('getEditor', {index:i, field:opts.field}).target).val();
		        	val = ('\'' + val.replace("'", " '' ")  + '\'');
		        	//val = val.trim();if (val =='') val =0;
		        } else if (opts.editor.type == 'combobox'){
		        	val = $(odatagrid.datagrid('getEditor', {index:i, field:opts.field}).target).combobox('getValue');
		        	if (isNaN(val)) val = ('\'' + val + '\'');
		        } else if (opts.editor.type == 'numberbox'){
		        	val = $(odatagrid.datagrid('getEditor', {index:i, field:opts.field}).target).numberbox('getValue');
		        	val = val.trim();if (val =='') val =0;
		        	//alert(val)
		        	if (isNaN(val)) val = 0;
		        } else if (opts.editor.type == 'datebox'){
		        	val = $(odatagrid.datagrid('getEditor', {index:i, field:opts.field}).target).datebox('getValue');
		        	val = gm.date.stringDate2Int(val);
		        }else if (opts.editor.type == 'textbox'){
		        	val = $(odatagrid.datagrid('getEditor', {index:i, field:opts.field}).target).textbox('getValue');
		        	val = val.replace("'", " '' ") ;
		        } else {
		        	msgerror('datagrid: unknown opts.editor.type');
		        	return false;
		        }
		        if (isNew)insertSql += val;
				else updateSql += val;		
		        
		        if (j<fields.length-2){
			        if (isNew)insertSql += ',';
					else updateSql += ',';
		        	
			        columnFieldIns += ',';
		        } else {
		        	if (!isNew) updateSql +=(','+ rows[i][odatagrid.datagrid('options').idField]);
		        }
		    }
			columnFieldUpd = (columnFieldIns +','+odatagrid.datagrid('options').idField);
			
			 if (isNew){
				 insertSql += ')';insertSql += ',';
			 } else {
				 //updateSql += ')';updateSql += ',';
				 updateSql += '<v>';
			 }
		}
	}

	
	//at here, we have one part of insert and update sql query like '(1,2,3),(4,5,6),'
	
	insertSql = insertSql.trim();

	updateSql = updateSql.trim();
	//alert(columnFieldIns)
	//alert(insertSql)
	//alert(columnFieldUpd)
	//alert(updateSql)

	//insertSql: (ttgc_cd_gionglua_id,ttgc_cd_tralua_id,ttgc_cd_phuongphap,ttgc_cd_dientich,ttgc_cd_tyle,ttgc_cd_ngaygieocay) VALUES(45,2,'Cấy thẳng',1.00,0.15,15336),
	//updateSql: (ttgc_cd_gionglua_id,ttgc_cd_tralua_id,ttgc_cd_phuongphap,ttgc_cd_dientich,ttgc_cd_tyle,ttgc_cd_ngaygieocay,ttgc_cd_id)<v>(40,1,'Cay',1.00,0.00,15336,206),
	var jr = JResultFailed;
	$.ajax({
		url:MAIN_SERVLET ,
		data:
	    { 
		  action: ACT_DB_UPDATE_DATAGRID,
		  tablename:tblname,
		  insertFields:columnFieldIns,
		  insertValues:insertSql,
		  updateFields:columnFieldUpd,
		  updateValues: updateSql,
		  returnid:((options.rowIndex == undefined)||(rows[options.rowIndex][odatagrid.datagrid('options').idField]!=undefined))?"null":(" RETURNING "+odatagrid.datagrid('options').idField)
		},
		async:false,
		error: function (request, status, error) {
			//jr.msg = request.
			jr.success = false;
		},
		success:function(jsonDataResult) {
			//alert(jsonDataResult)
			jr = JSON.parse(jsonDataResult);
			if(jr.code == DB_STR_OK){
				jr.success = true;
			}
			else {
				msgerror(jr.msg);
				jr.success = false;
			}
					
		}
	});
	
	return jr;
}


/**
 * Insert/Update với 1 (theo indexRow param) hoặc tất cả những row đang edit trên datagrid 
 * @param odatagrid
 * @param tblname
 * @param indexRow
 * 			nếu indexRow được chỉ định thì chỉ có row này được insert/update
 * @out_odatagrid du lieu ngoai grid
 * @returns
 */
function datagrid_insert_multirow_editing(odatagrid,column_add, tblname, options, out_odatagrid){
	var fields = odatagrid.datagrid('getColumnFields',{frozen:false});
	var rows = odatagrid.datagrid('getRows');
	if (options == undefined)options={};
	//alert('options.rowIndex ='+options.rowIndex)
	//INSERT+UPDATE
	var insertSql = '';
	var updateSql = '';
	var columnFieldIns ='';
	var columnFieldUpd ='';
	for (var i = 0; i<rows.length; i++){
		if (rows[i].editing && ((options.rowIndex == undefined)?'1==1':(i == options.rowIndex))){
			var isNew = (rows[i][odatagrid.datagrid('options').idField] == undefined);
			if (isNew){
				insertSql += '(';
			}
			else{
				//updateSql += '(';
				updateSql += '';
			}				
			columnFieldIns = '';
			for(var j=0; j<fields.length-1; j++){//trừ column action ở cuối
		        var skip = false;
		        skip = false;
		       //alert('options.skipFields.length: '+options.skipFields.length);
		        if (options.skipFields != undefined)
				for (var sk = 0; sk < options.skipFields.length; sk++){
					// alert('fields[j] == options.skipFields[sk]: '+fields[j]+','+options.skipFields[sk]);
					if (fields[j] == options.skipFields[sk]){
						skip = true;
						break;
					}
				}else;// alert('skip skipFields undefined')
				if (skip){/*alert('skip '+fields[j]) */;continue;}
				var opts = odatagrid.datagrid('getColumnOption', fields[j]);  
		        //alert('fields['+j+']: '+fields[j])
		        //alert('opts.field: '+opts.field)
		        
		        var val;
		        columnFieldIns += fields[j];
		        
                
		        if (opts.editor == 'text'){
		        	val = $(odatagrid.datagrid('getEditor', {index:i, field:opts.field}).target).val();
		        	val = ('\'' + val.replace("'", " '' ")  + '\'');
		        	//val = val.trim();if (val =='') val =0;
		        } else if (opts.editor.type == 'combobox'){
		        	val = $(odatagrid.datagrid('getEditor', {index:i, field:opts.field}).target).combobox('getValue');
		        	if (isNaN(val)) val = ('\'' + val + '\'');
		        } else if (opts.editor.type == 'numberbox'){
		        	val = $(odatagrid.datagrid('getEditor', {index:i, field:opts.field}).target).numberbox('getValue');
		        	val = val.trim();if (val =='') val =0;
		        	//alert(val)
		        	if (isNaN(val)) val = 0;
		        } else if (opts.editor.type == 'datebox'){
		        	val = $(odatagrid.datagrid('getEditor', {index:i, field:opts.field}).target).datebox('getValue');
		        	val = gm.date.stringDate2Int(val);
		        }else if (opts.editor.type == 'textbox'){
		        	val = $(odatagrid.datagrid('getEditor', {index:i, field:opts.field}).target).textbox('getValue');
		        	val = val.replace("'", " '' ") ;
		        	//alert("text="+val);
		        }  else if(opts.editor.type == 'checkbox'){
		        	var o =  odatagrid.datagrid('getEditor', {index:i, field:opts.field}).target;
		         	if($(o).is(":checked")){
		        			val = o.val();
		        		}else{
		        			val = o.attr("offval");
		        		}
		         	//alert(val);
		        }else {
		        
		        	msgerror('datagrid: unknown opts.editor.type');
			        alert('opts.field: '+opts.field);
		        	return false;
		        }
		        if (isNew)insertSql += val;
				else updateSql += val;		
		        
		        if (j<fields.length-2){
			        if (isNew)insertSql += ',';
					else updateSql += '<,>';
		        	
			        columnFieldIns += ',' ;
		        } else {
		        	if (!isNew) updateSql +=('<,>' +  '\'' + out_odatagrid + '\'' + '<,>'+ rows[i][odatagrid.datagrid('options').idField]);
		        }
		    }
			
			columnFieldIns += ',' + column_add ;  //add columnn into insert sentence  insertFields =tentk,matkhau,id_quyen
			columnFieldUpd = (columnFieldIns +','+odatagrid.datagrid('options').idField);
			
			 if (isNew){
				 insertSql += ',' +  '\'' + out_odatagrid + '\'' +')';
				 insertSql +=   ',';   //  insertValues =('rty','rty','3,5'),
			 } else {
				 //updateSql += ')';updateSql += ',';
				 updateSql += '<v>';
			 }
		}
	}

	
	//at here, we have one part of insert and update sql query like '(1,2,3),(4,5,6),'
	
	insertSql = insertSql.trim();

	updateSql = updateSql.trim();
	//alert(columnFieldIns)
	 //alert(insertSql);
	//alert(columnFieldUpd)
	//alert(updateSql)

	var jr = JResultFailed;
	$.ajax({
		url:root_href + HOME_SERVLET ,
		data:
	    { 
		  action: ACT_DB_UPDATE_DATAGRID,
		  tablename:tblname,
		  insertFields:columnFieldIns,
		  insertValues:insertSql,
		  updateFields:columnFieldUpd,
		  updateValues: updateSql,
		  returnid:((options.rowIndex == undefined)||(rows[options.rowIndex][odatagrid.datagrid('options').idField]!=undefined))?"null":(" RETURNING "+odatagrid.datagrid('options').idField)
		},
		async:false,
		error: function (request, status, error) {
			//jr.msg = request.
			jr.success = false;
		},
		success:function(jsonDataResult) {
			//alert(jsonDataResult)
			jr = JSON.parse(jsonDataResult);
			if(jr.code == DB_STR_OK){
				jr.success = true;
			}
			else {
				msgerror(jr.msg);
				jr.success = false;
			}
					
		}
	});
	
	return jr;
}





/*
 *[BEGIN]  METHODS USED ON MAIN WEB GUI
 * 
 */
		
function OnComboTinhQuickSearchChange(){
	
	//alert("OnComboTinhQuickSearchChange");
		
    var combo = document.getElementById("quicksearch_cbtinh");
    var val = combo.options[combo.selectedIndex].value;
	cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_HUYEN_TO_CBB, "tinh_id="+val,TYPE_DATA_HTML_CBB,'Quận/Huyện', 'quicksearch_cbhuyen');
    
    cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_XA_TO_CBB, "xa_id="+'-1',TYPE_DATA_HTML_CBB,'Xã/Phường', 'quicksearch_cbxa');
    
    //update to main search
    $("#dlg_main_cbtinh").html($("#quicksearch_cbtinh").html());
    $("#dlg_main_cbtinh").val($("#quicksearch_cbtinh").val());
    $("#dlg_main_cbhuyen").html($("#quicksearch_cbhuyen").html());
    $("#dlg_main_cbhuyen").val($("#quicksearch_cbhuyen").val());
    $("#dlg_main_cbxa").html($("#quicksearch_cbxa").html());
    $("#dlg_main_cbxa").val($("#quicksearch_cbxa").val());
    checkEnableSearchButton();
   // alert($("#quicksearch_cbtinh").val())
}

function checkEnableSearchButton(){
	var tinhval =$("#quicksearch_cbtinh").val();
	var huyenval =$("#quicksearch_cbhuyen").val();
	var xaval =$("#quicksearch_cbxa").val();
	//alert($("#quicksearch_cbtinh").val()+','+$("#quicksearch_cbhuyen").val()+','+$("#quicksearch_cbxa").val())

	if (tinhval!=null&&tinhval!= -1) $("#btn_search_tinh").attr('disabled',false);
	else $("#btn_search_tinh").attr('disabled',true);
	
	if (huyenval!=null&&huyenval!= -1)$("#btn_search_huyen").attr('disabled',false);
	else $("#btn_search_huyen").attr('disabled',true);
	
	if(xaval!=null&&xaval!= -1)$("#btn_search_xa").attr('disabled',false);
	else $("#btn_search_xa").attr('disabled',true);
}
function OnComboHuyenQuickSearchChange(){
	   //cwrs_debug('OnComboHuyenQuickSearchChange');
	   var combo = document.getElementById("quicksearch_cbhuyen");
	   var val = combo.options[combo.selectedIndex].value;
       cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_XA_TO_CBB, "huyen_id="+val,TYPE_DATA_HTML_CBB,'Xã/Phường', 'quicksearch_cbxa');
       
       //update to quick search
       $("#dlg_main_cbhuyen").html($("#quicksearch_cbhuyen").html());
       $("#dlg_main_cbhuyen").val($("#quicksearch_cbhuyen").val());
       $("#dlg_main_cbxa").html($("#quicksearch_cbxa").html());
       $("#dlg_main_cbxa").val($("#quicksearch_cbxa").val());
       checkEnableSearchButton();
}
function OnComboXaQuickSearchChange(){

       $("#dlg_main_cbxa").html($("#quicksearch_cbxa").html());
       $("#dlg_main_cbxa").val($("#quicksearch_cbxa").val());
       checkEnableSearchButton();
}


/*
function OnComboTinhMainSearchChange(){
	
	//alert("MainGUI_OnComboTinhChange");
	//$('#'+'dlg_main_cbhuyen').html('<option selected="true" value="-1">Quận/Huyện</option>');
	
    var combo = document.getElementById("dlg_main_cbtinh");
    var val = combo.options[combo.selectedIndex].value;
	cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_HUYEN_TO_CBB, "tinh_id="+val,TYPE_DATA_HTML_CBB,'Quận/Huyện', 'dlg_main_cbhuyen');
    
    cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_XA_TO_CBB, "xa_id="+'-1',TYPE_DATA_HTML_CBB,'Xã/Phường', 'dlg_main_cbxa');
    //update to quick search
    $("#quicksearch_cbtinh").html($("#dlg_main_cbtinh").html());
    $("#quicksearch_cbtinh").val($("#dlg_main_cbtinh").val());
    $("#quicksearch_cbhuyen").html($("#dlg_main_cbhuyen").html());
    $("#quicksearch_cbhuyen").val($("#dlg_main_cbhuyen").val());
    $("#quicksearch_cbxa").html($("#dlg_main_cbxa").html());
    $("#quicksearch_cbxa").val($("#dlg_main_cbxa").val());

}*/
/*
function OnComboHuyenMainSearchChange(){
	   //cwrs_debug('OnComboHuyenMainSearchChange');
	   var combo = document.getElementById("dlg_main_cbhuyen");
	   var val = combo.options[combo.selectedIndex].value;
       cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_XA_TO_CBB, "huyen_id="+val,TYPE_DATA_HTML_CBB,'Xã/Phường', 'dlg_main_cbxa');
       
       //update to quick search
       $("#quicksearch_cbhuyen").html($("#dlg_main_cbhuyen").html());
       $("#quicksearch_cbhuyen").val($("#dlg_main_cbhuyen").val());
       $("#quicksearch_cbxa").html($("#dlg_main_cbxa").html());
       $("#quicksearch_cbxa").val($("#dlg_main_cbxa").val());
}
*/
/*
function OnComboXaMainSearchChange(){
      $("#quicksearch_cbxa").html($("#dlg_main_cbxa").html());
      $("#quicksearch_cbxa").val($("#dlg_main_cbxa").val());
	
}*/
/*
function MainGUI_Baocao_OnComboTinhChange(){
	
	//alert("MainGUI_OnComboTinhChange");
    var combo = document.getElementById("dlg_main_baocao_cbtinh");
    var val = combo.options[combo.selectedIndex].value;
	cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_HUYEN_TO_CBB, "tinh_id="+val,TYPE_DATA_HTML_CBB,'Quận/Huyện', 'dlg_main_baocao_cbhuyen');
    
    cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_XA_TO_CBB, "xa_id="+'-1',TYPE_DATA_HTML_CBB,'Xã/Phường', 'dlg_main_baocao_cbxa');

    
    
    
}*/
/*
function MainGUI_Hientrang_OnComboTinhChange(){
	
	//alert("MainGUI_OnComboTinhChange");
    var combo = document.getElementById("dlg_main_hientrang_cbtinh");
    var val = combo.options[combo.selectedIndex].value;
	cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_HUYEN_TO_CBB, "tinh_id="+val,TYPE_DATA_HTML_CBB,'Quận/Huyện', 'dlg_main_hientrang_cbhuyen');
    
    cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_XA_TO_CBB, "xa_id="+'-1',TYPE_DATA_HTML_CBB,'Xã/Phường', 'dlg_main_hientrang_cbxa');

    
    
    
}*/




// angiang, tp.longxuyen,an phu'
//hienthi_bando_ruong(map, 89, 890, 30514){

function zoom_map_to_area(map, tinh_id, huyen_id, xa_id){
	//alert("zoom_map_to_area");
	//get bounds 
	/*$.post(MAIN_SERVLET ,									
		    { 
			  action: ACT_GET_BOUND_OF_AREA,
			  tinh_id: tinh_id,
			  huyen_id: huyen_id,
			  xa_id: xa_id

			},
		    function(result) {
				var strBound = result.split(",");
				var strBound = result.split(",");
				var newBounds = new OpenLayers.Bounds(strBound[0], strBound[1], strBound[2], strBound[3]); 
				//alert("Bound(" +strBound[0]+"," + strBound[1]+","+ strBound[2]+","+ strBound[3]+")");
				map.zoomToExtent(newBounds);		
			
		    });
	*/
	//alert('tinh_id:'+tinh_id+', huyen_id:'+huyen_id+', xa:'+xa_id);
	$.post(MAIN_SERVLET ,									
		    { 
			  action: ACT_GET_GEOMETRY_OF_AREA,
			  tinh_id: tinh_id,
			  huyen_id: huyen_id,
			  xa_id: xa_id,
			  type: TYPE_GEOMETRY_WKT

			},
		    function(geometry) {
				g_lanhtho_search_selected.tinh_id = tinh_id;
				g_lanhtho_search_selected.huyen_id = huyen_id;
				g_lanhtho_search_selected.xa_id = xa_id;
				

				//alert(geometry.length)
				 var featureGeom = new OpenLayers.Feature.Vector(
     		  			OpenLayers.Geometry.fromWKT(geometry),null,g_style_fill_huyen
				 );
				// alert(tinh_id);
				// alert(geometry);
				// alert('dt ='+featureGeom.geometry.getArea());
				var newBounds = featureGeom.geometry.getBounds(); 
				//alert("Bound(" +strBound[0]+"," + strBound[1]+","+ strBound[2]+","+ strBound[3]+")");
				map.zoomToExtent(newBounds);
				//Remove các feauture trước đó
				g_layer_search.removeAllFeatures();
				//Tạo và vẽ mới
				g_layer_search.addFeatures([featureGeom]);
				g_layer_search.drawFeature(featureGeom);
				if (xa_id > 0){//chỉ cache cho xã
					//alert(xa_id)
					g_xa_id_by_search = xa_id;
					g_tinh_id_by_search = tinh_id;
					g_huyen_id_by_search = huyen_id;

					
					
					var condition = 'xa_id ='+ xa_id; 
					precache_feature_geometry(condition);
					
				}
				
				if (xa_id > 0){
					if (!layer_xa.getVisibility()){
						layer_xa.setVisibility(true);
					} 
				} else if (huyen_id > 0){
					
					if (!layer_huyen.getVisibility()){
						layer_huyen.setVisibility(true);
					} 
				} else if (tinh_id > 0){
					if (!layer_tinh.getVisibility()){
						layer_tinh.setVisibility(true);
					} 
				}
			
		    });

}

/**render */
function draw_area_on_map(map, tinh_id, huyen_id, xa_id){
	return;
	//alert("zoom_map_to_area");
	if(!layer_xa.getVisibility()){
		xa_id=-1;
	} else if(!layer_huyen.getVisibility()){
		huyen_id=-1;
	} else if(!layer_tinh.getVisibility()){
		tinh_id=-1;
	} 
	//alert(tinh_id+','+huyen_id+','+xa_id)
	$.post(MAIN_SERVLET ,									
		    { 
			  action: ACT_GET_GEOMETRY_OF_AREA,
			  tinh_id: tinh_id,
			  huyen_id: huyen_id,
			  xa_id: xa_id,
			  type: TYPE_GEOMETRY_WKT

			},
		    function(geometry) {
			
				alert(geometry)
				 var featureGeom = new OpenLayers.Feature.Vector(
     		  			OpenLayers.Geometry.fromWKT(geometry),null,g_style_fill_huyen
				 );
				// alert(tinh_id);
				// alert(geometry);
				// alert('dt ='+featureGeom.geometry.getArea());
				//var newBounds = featureGeom.geometry.getBounds(); 
				//alert("Bound(" +strBound[0]+"," + strBound[1]+","+ strBound[2]+","+ strBound[3]+")");
				//map.zoomToExtent(newBounds);
				//Remove các feauture trước đó
				g_layer_search.removeAllFeatures();
				//Tạo và vẽ mới
				g_layer_search.addFeatures([featureGeom]);
				g_layer_search.drawFeature(featureGeom);
	
		    });

}

function mainSearch(){
	
	var combo = document.getElementById("dlg_main_cbtinh");
	var search_tinh_id = combo.options[combo.selectedIndex].value;
	
	combo = document.getElementById("dlg_main_cbhuyen");
	var search_huyen_id = combo.options[combo.selectedIndex].value;
	
	combo = document.getElementById("dlg_main_cbxa");
	var search_xa_id = combo.options[combo.selectedIndex].value;
	
	//-1,-1,-1
	if ((search_tinh_id == -1) && (search_huyen_id == -1) && (search_xa_id == -1)){
		
		layer_tinh.setVisibility(true);
		layer_huyen.setVisibility(false);
		layer_xa.setVisibility(false);	

	}else//+1,+1,-1
	if ((search_tinh_id != -1) && (search_huyen_id != -1) && (search_xa_id == -1)){
		layer_tinh.setVisibility(false);
		layer_huyen.setVisibility(true);
		layer_xa.setVisibility(false);	
		
	}else//+1,+1,+1
	if ((search_tinh_id != -1) && (search_huyen_id != -1) && (search_xa_id != -1)){
		layer_tinh.setVisibility(false);
		layer_huyen.setVisibility(false);
		layer_xa.setVisibility(true);	
			
	}else//+1,-1,-1
	if ((search_tinh_id != -1) && (search_huyen_id == -1) && (search_xa_id == -1)){
		layer_tinh.setVisibility(true);
		layer_huyen.setVisibility(false);
		layer_xa.setVisibility(false);	
			
	}
	//-1,-1,+1
	//-1,+1,+1
	//-1,+1,-1
	//+1,-1,+1
	zoom_map_to_area(map, search_tinh_id, search_huyen_id, search_xa_id);
}
function quickTinhSearch(){
	quickSearch(SEARCH_TINH);
}
function quickHuyenSearch(){
	quickSearch(SEARCH_HUYEN);
}
function quickXaSearch(){
	quickSearch();
}
function quickSearch(search_type){
	
	var combo = document.getElementById("quicksearch_cbtinh");
	var search_tinh_id = combo.options[combo.selectedIndex].value;
	var search_tinh_name = combo.options[combo.selectedIndex].text;
	
	combo = document.getElementById("quicksearch_cbhuyen");
	var search_huyen_id = combo.options[combo.selectedIndex].value;
	var search_huyen_name = combo.options[combo.selectedIndex].text;
	
	combo = document.getElementById("quicksearch_cbxa");
	var search_xa_id = combo.options[combo.selectedIndex].value;
	var search_xa_name = combo.options[combo.selectedIndex].text;
	if (search_type != undefined){
		if (search_type == SEARCH_TINH){
			search_huyen_id = -1;
			search_xa_id = -1;
		} else if (search_type == SEARCH_HUYEN){
			search_xa_id = -1;
		}
	}
	//-1,-1,-1
	if ((search_tinh_id == -1) && (search_huyen_id == -1) && (search_xa_id == -1)){
		
		layer_tinh.setVisibility(true);
		layer_huyen.setVisibility(false);
		layer_xa.setVisibility(false);	

	}else//+1,+1,-1
	if ((search_tinh_id != -1) && (search_huyen_id != -1) && (search_xa_id == -1)){
		layer_tinh.setVisibility(false);
		layer_huyen.setVisibility(true);
		layer_xa.setVisibility(false);	
		
	}else//+1,+1,+1
	if ((search_tinh_id != -1) && (search_huyen_id != -1) && (search_xa_id != -1)){
		layer_tinh.setVisibility(false);
		layer_huyen.setVisibility(false);
		layer_xa.setVisibility(true);	
			
	}else//+1,-1,-1
	if ((search_tinh_id != -1) && (search_huyen_id == -1) && (search_xa_id == -1)){
		layer_tinh.setVisibility(true);
		layer_huyen.setVisibility(false);
		layer_xa.setVisibility(false);	
			
	}
	//-1,-1,+1
	//-1,+1,+1
	//-1,+1,-1
	//+1,-1,+1
	zoom_map_to_area(map, search_tinh_id, search_huyen_id, search_xa_id);
	
	 g_lanhtho_selected.tinh_id = search_tinh_id;
	 g_lanhtho_selected.tinh_ten = search_tinh_name;
	 g_lanhtho_selected.huyen_id = search_huyen_id;
	 g_lanhtho_selected.huyen_ten = search_huyen_name;
	 g_lanhtho_selected.xa_id = search_xa_id;
	 g_lanhtho_selected.xa_ten = search_xa_name;
	 g_lanhtho_selected.selected = true;
}


//[END] *  METHODS USED ON MAIN WEB GUI








function test(){

	clearFieldStorer();
	putfval_int('id', '?');
	putfval_string('name', '?');


	var strSQL = "";
	strSQL = genInsertCmd_PreStatement('test');
	var condition = '';
	var strListValues = "10,tuan<v>11,diu<v>12,dang<v>13,dang<v>14,ngoc<v> ";
	var strListIDs = "10,11,12,13,14";
	
	//alert(genUpdateCmd('table1')); 
	
	cwrs_InsUpdMultiRecord2DB(MAIN_SERVLET,
			ACT_DB_INSERT_UPDATE_MULTI_OBJECT,
			condition,
			strSQL,
			strListValues,
			getSQLTypeOrderInQuery(),
			null,//strListIDs,
			null);

   
 // Array arr=  map.keySet();
  // alert(map.size());
}


/**
 * *
 * *
 * *
 * *ĐIỀU TRA CÁNH ĐỒNG
 * *
 * *
 * *
 * *
 * *
 */

/**
 * @sti :start time of year in integer : 01/01/2010 -> 15451
 * @eti :end time of year in integer : 31/12/2010 -> 15751
 */
function phanboCanhdong(action, xa_id, canhdong_id,vulua_id, sti ,eti, condition){
	//alert(action+","+ xa_id+","+ canhdong_id+","+vulua_id+","+ sti +","+eti+","+ condition)
	
	var result = false;
try{	
	$.ajax({
		url:PHANBO_CANHDONG_SERVLET ,
		data:
		{ 
			action: action,//ACT_PHANBO_CANHDONG_TTGC,
			xa_id:xa_id,
			canhdong_id:canhdong_id,
			vulua_id:vulua_id,
			sti:sti,
			eti:eti,
			condition:condition
		},
		async:false,
		error: function (request, status, error) {
			result = false;    
		},
		success:function(jsonDataResult) {
			//alert(jsonDataResult);
			var jr = JSON.parse(jsonDataResult);
			if(jr.code == DB_STR_OK)
				result = true;
			else {
				g_ErrorNotifier.clear();
				g_ErrorNotifier.add(jr.msg);
				
				msgerror(g_ErrorNotifier.getErrorMessages("Có một số lỗi xảy ra. Vui lòng sao chép thông báo lỗi sau và gửi email tới cwrs.dbscl@gmail.com:"));
				result = false;
			}
		}
	});
}catch(err){}
	return result;
}
//phan bo xa
function phanboXa(action, xa_id, vulua_id, sti ,eti, condition){
	//alert(action+","+ xa_id+","+ canhdong_id+","+vulua_id+","+ sti +","+eti+","+ condition)
	
	var result = false;
try{	
	$.ajax({
		url:PHANBO_CANHDONG_SERVLET ,
		data:
		{ 
			action: action,//ACT_PHANBO_CANHDONG_TTGC,
			xa_id:xa_id,
			vulua_id:vulua_id,
			sti:sti,
			eti:eti,
			condition:condition
		},
		async:false,
		error: function (request, status, error) {
			result = false;    
		},
		success:function(jsonDataResult) {
			//alert(jsonDataResult);
			var jr = JSON.parse(jsonDataResult);
			if(jr.code == DB_STR_OK)
				result = true;
			else {
				g_ErrorNotifier.clear();
				g_ErrorNotifier.add(jr.msg);
				
				msgerror(g_ErrorNotifier.getErrorMessages("Có một số lỗi xảy ra. Vui lòng sao chép thông báo lỗi sau và gửi email tới cwrs.dbscl@gmail.com:"));
				result = false;
			}
		}
	});
}catch(err){}
	return result;
}

//[BEGIN] Cập nhật nguồn nước

function changeNguonnuoc_Canhdong(val){
	if (!checkRoleDieutraRuongCanhdong()) return;
//alert($('input:radio[name=radio_nuoc]:checked').val())
	var arrayCanhdong = getCanhdongIDSelected();

	if (arrayCanhdong.length >0){
		msgconfirmI('Bạn muốn cập nhập nguồn nước cho (những) tiểu vùng này? (số tiểu vùng:'+arrayCanhdong.length+').',function(r){
			if(r) {
				var strSQL = "";
				for (var i =0; i< arrayCanhdong.length;i++){
					strSQL+='UPDATE tbl_canhdong_region SET canhdong_nuoc='+val+' WHERE canhdong_id='+arrayCanhdong[i]+';';             

				}
				if (cwrs_execSQLDirectly2DB(MAIN_SERVLET, strSQL,true) == DB_STR_OK){
					//msginfo('Cập nhật nguồn nước thành công!');		

				} else {
					msgwarning('Không thể cập nhật nguồn nước tới những cánh đồng này.');
					return;
				}
				
				var strIds='';


				for (var i =0; i< arrayCanhdong.length;i++){
					var canhdongid = arrayCanhdong[i];
					var arrayRuong = getArrayRuongIDHasCanhdongID(canhdongid);
					strIds += Utils.createStringWithSeparator(arrayRuong,',');
					if (i<arrayCanhdong.length-1)strIds +=',';
				}
				if (arrayCanhdong.length >0){
					var strSQL = 'UPDATE tbl_ruong_region SET ruong_nuoc='+val+' WHERE ruong_id IN ('+strIds+')' ;             
					if (cwrs_execSQLDirectly2DB(MAIN_SERVLET, strSQL,true) == DB_STR_OK){
						msginfo('Cập nhật nguồn nước thành công!');		

					} else {
						msgwarning('Không thể cập nhật nguồn nước tới những cánh đồng này.');

					}
				}
			}
		},'Đúng','Sai');
	} else {
		msgwarning('Hãy chọn một hoặc một nhóm cánh đồng');
	}


}

function getNguonnuocCanhdong(canhdong_id){
	//if (!checkRoleDieutraRuongCanhdong()) return;
//alert($('input:radio[name=radio_nuoc]:checked').val())
	var arrayCanhdong = getCanhdongIDSelected();

	if (arrayCanhdong.length ==1){
		var json = null;
		
		var sql = "SELECT canhdong_nuoc FROM tbl_canhdong_region WHERE canhdong_id="+arrayCanhdong[0];
		json = cwrs_getDataDynamic(MAIN_SERVLET, sql, false);
		if (json != null) return json.rows[0].canhdong_nuoc; 
		return -1;	
			
	
	} else {
		msgwarning('Hãy chọn duy nhất một cánh đồng.');
	}
}
function getTinhchatDatCanhdong(canhdong_id){
	//if (!checkRoleDieutraRuongCanhdong()) return;
//alert($('input:radio[name=radio_nuoc]:checked').val())
	var arrayCanhdong = getCanhdongIDSelected();

	if (arrayCanhdong.length ==1){
		var json = null;
		
		var sql = "SELECT canhdong_dat FROM tbl_canhdong_region WHERE canhdong_id="+arrayCanhdong[0];
		json = cwrs_getDataDynamic(MAIN_SERVLET, sql, false);
		if (json != null) return json.rows[0].canhdong_dat; 
		return -1;	
			
	
	} else {
		msgwarning('Hãy chọn duy nhất một cánh đồng.');
	}


}
function getNguonnuocRuong(ruong_id){
	//if (!checkRoleDieutraRuongCanhdong()) return;

	var nRuong =getTotalFeaturesSelected();
	var lstRuong=getListRuongSelected();
	//alert(nRuong)
	 if (nRuong == 0) {
		 msgwarning('Hãy chọn duy nhất một ruộng.');
	 } else if (nRuong == 1) {
			var json = null;
			
			var sql = "SELECT ruong_nuoc FROM tbl_ruong_region WHERE ruong_id="+lstRuong[0].fid;
			json = cwrs_getDataDynamic(MAIN_SERVLET, sql, false);
			if (json != null) return json.rows[0].ruong_nuoc; 
			return -1;
	 }else {
		 msgwarning('Hãy chọn duy nhất một ruộng.');
	 }

	


}

function getTinhchatDatRuong(ruong_id){
	//if (!checkRoleDieutraRuongCanhdong()) return;

	var nRuong =getTotalFeaturesSelected();
	var lstRuong=getListRuongSelected();
	//alert(nRuong)
	 if (nRuong == 0) {
		 msgwarning('Hãy chọn duy nhất một ruộng.');
	 } else if (nRuong == 1) {
			var json = null;
			
			var sql = "SELECT ruong_dat FROM tbl_ruong_region WHERE ruong_id="+lstRuong[0].fid;
			json = cwrs_getDataDynamic(MAIN_SERVLET, sql, false);
			if (json != null) return json.rows[0].ruong_dat; 
			return -1;
	 }else {
		 msgwarning('Hãy chọn duy nhất một ruộng.');
	 }

	


}
function changeNguonnuoc_Ruong(val){
	if (!checkRoleDieutraRuongCanhdong()) return;
	 if (getTotalFeaturesSelected() == 0) {
		 msgwarning('Hãy chọn một hoặc một nhóm ruộng');
		 return;
	 }else{
		var arrayRuong=getListFeaturesIDSelected();
	 	msgconfirmI('Bạn muốn cập nhập nguồn nước cho (những) ruộng này? (số ruộng:'+arrayRuong.length+').',function(r){
			if(r){
				var strIDs = Utils.createStringWithSeparator(arrayRuong,',');
	
				var strSQL = 'UPDATE tbl_ruong_region SET ruong_nuoc='+val+' WHERE ruong_id IN ('+strIDs+')' ;              
				if (cwrs_execSQLDirectly2DB(MAIN_SERVLET, strSQL,true) == DB_STR_OK){
					msginfo('Cập nhật nguồn nước thành công!');		

				} else {
					msgwarning('Cập nhật không thành công!');
				}
			}
	 	},'Đúng','Sai');
	 }
}
//[END] Cập nhật nguồn nước


//[BEGIN] Cập nhật tính chất đất

function changeDat_Canhdong(val){
	if (!checkRoleDieutraRuongCanhdong()) return;
//alert($('input:radio[name=radio_nuoc]:checked').val())
	var arrayCanhdong = getCanhdongIDSelected();

	if (arrayCanhdong.length >0){
		msgconfirmI('Bạn muốn cập nhập tính chất đất cho (những) tiểu vùng này? (số tiểu vùng:'+arrayCanhdong.length+').',function(r){
			if(r) {
				var strSQL = "";
				for (var i =0; i< arrayCanhdong.length;i++){
					strSQL+='UPDATE tbl_canhdong_region SET canhdong_dat='+val+' WHERE canhdong_id='+arrayCanhdong[i]+';';             

				}
				if (cwrs_execSQLDirectly2DB(MAIN_SERVLET, strSQL,true) == DB_STR_OK){
					//msginfo('Cập nhật nguồn nước thành công!');		

				} else {
					msgwarning('Không thể cập nhật tính chất đất cho những cánh đồng này.');
					return;
				}
				
				var strIds='';


				for (var i =0; i< arrayCanhdong.length;i++){
					var canhdongid = arrayCanhdong[i];
					var arrayRuong = getArrayRuongIDHasCanhdongID(canhdongid);
					strIds += Utils.createStringWithSeparator(arrayRuong,',');
					if (i<arrayCanhdong.length-1)strIds +=',';
				}
				if (arrayCanhdong.length >0){
					var strSQL = 'UPDATE tbl_ruong_region SET ruong_dat='+val+' WHERE ruong_id IN ('+strIds+')' ;             
					if (cwrs_execSQLDirectly2DB(MAIN_SERVLET, strSQL,true) == DB_STR_OK){
						msginfo('Cập nhật tính chất đất thành công!');		

					} else {
						msgwarning('Không thể cập nhật tính chất đất cho những cánh đồng này.');

					}
				}
			}
		},'Đúng','Sai');
	} else {
		msgwarning('Hãy chọn một hoặc một nhóm cánh đồng');
	}


}
function changeDat_Ruong(val){
	if (!checkRoleDieutraRuongCanhdong()) return;
	 if (getTotalFeaturesSelected() == 0) {
		 msgwarning('Hãy chọn một hoặc một nhóm ruộng');
		 return;
	 }else{
		var arrayRuong=getListFeaturesIDSelected();
	 	msgconfirmI('Bạn muốn cập nhập tính chất đất cho (những) ruộng này? (số ruộng:'+arrayRuong.length+').',function(r){
			if(r){
				var strIDs = Utils.createStringWithSeparator(arrayRuong,',');
	
				var strSQL = 'UPDATE tbl_ruong_region SET ruong_dat='+val+' WHERE ruong_id IN ('+strIDs+')' ;              
				if (cwrs_execSQLDirectly2DB(MAIN_SERVLET, strSQL,true) == DB_STR_OK){
					msginfo('Cập nhật tính chất đất thành công!');		

				} else {
					msgwarning('Cập nhật tính chất đất thành công!');
				}
			}
	 	},'Đúng','Sai');
	 }
}
function dlg_add_trogiup_nguoidung(){
			//get data from form dialog
	       	
	           
				var ten = document.getElementById('main_heft_name').value;
				var email = document.getElementById('main_heft_email').value;
				var dienthoai = document.getElementById('main_heft_telephone').value;
				var tieude = document.getElementById('main_heft_title').value;
				var noidung = document.getElementById('main_heft_content').value;	
				  if (!checkRoleDieutraRuongCanhdong()) return;	
				if (ten==''){
					msgalert_autoclose('Thông báo',' Bạn hãy nhập họ tên','warning');
						return;
				}
				if(isEmail(email)== false){
					msgalert_autoclose('Thông báo','Bạn phải nhập đúng định dạng email','warning');
					return;
				}
			
				if (dienthoai==''){
					msgalert_autoclose('Thông báo',' Bạn hãy nhập số điện thoai','warning');
						return;
				}
				if (dienthoai.length<10||dienthoai.length>11){
					msgalert_autoclose('Thông báo',' Số điện thoại phải là chuỗi có 10 hoặc 11 chứ số','warning');
						return;
				}
				if (tieude==''){
					msgalert_autoclose('Thông báo',' Bạn hãy nhập tiêu đề','warning');
					return;
			     }
				if (noidung==''){
					msgalert_autoclose('Thông báo',' Bạn hãy nhập nội dung cần trợ giúp','warning');
					return;
			     }
			
				 
	        	var utils = new Utils();    
			    	var	strSQL;	
			    	utils.clearFieldStorer();	
			    	utils.putfval_int('user_id', g_mlogin.user_id);
			    	utils.putfval_string('email', email);
			    	utils.putfval_string('tieude', tieude);		    				  
			    	utils.putfval_string('hoten', ten);
			    	utils.putfval_int('dienthoai', dienthoai);
			    	utils.putfval_string('noidung', noidung);
			    	/*if (mota !="") utils.putfval_string('hoten', ten);
			    	else utils.putfval_string('hoten', " ");*/
			 	    //utils.putfval_int('ttgc_ruong_id', -1);
				 	

				 	var strSQL = utils.genInsertCmd_PreStatement('tbl_trogiup');
				 	//alert('Query =' +strSQL);
                    var strListValues = utils.getListValues();
				 	
				 	//alert(strListValues);
				    var strListIDs;
				   
				    	strListIDs = utils.createStringWithSeparator(getListFeaturesIDSelected(), SQL_ID_LIST_SEP);
				 
				 	var sqlTypeOrder = utils.getSQLTypeOrderInQuery();
				 	
		     		var ret = cwrs_InsUpdMultiRecord2DB(MAIN_SERVLET, ACT_DB_INSERT_UPDATE_MULTI_OBJECT, null/*condition*/, strSQL, strListValues, sqlTypeOrder, strListIDs, null/*strJSONObject*/);
		            if (ret == DB_STR_OK){		            
		            	msgalert_autoclose('Thông báo','Gửi thông tin thành công','info');
		            	
		            }else {
		            	msgalert_autoclose('Thông báo','Gửi thông tin không thành công','error');//alert('insert/update multi object FAILED!');
		            }	
}

function getTimeRange(vulua_id,time_str){
	//alert('getDientichRuongGieocay(xa_id,vulua_id,gionglua_id,time_str)');
	var time_int1,time_int2;
	var jsDate=null;
	if(time_str.indexOf("/") !=-1){
		jsDate=gm.date.stringToJSONDate(time_str);
		if (vulua_id==1){//dong xuan
			if (jsDate.month <6){
				time_int1=jsDate.sti-90;
				time_int2=jsDate.sti+180;
			}else{
				time_int1=jsDate.sti+180;
				time_int2=jsDate.eti;
			}
		} else {
			time_int1=jsDate.sti;
			time_int2=jsDate.eti;
		}
		
		var strJson = '{\"time_int1\":'+ time_int1 +',\"time_int2\":'+time_int2+'}';
		var json = JSON.parse(strJson);
		return 	json;
		
	} else {
		msgerror('getDientichRuongGieocay: time is not like dd/mm/yyyy');
		return null;
	}
	
	
}
function getDientichRuongGieocay(id,vulua_id,gionglua_id,time_str,check_type){
	//alert('getDientichRuongGieocay(xa_id,vulua_id,gionglua_id,time_str)');
	var time_int1,time_int2;
	var jsDate=null;
	if(time_str.indexOf("/") !=-1){
		jsDate=gm.date.stringToJSONDate(time_str);
		if (vulua_id==1){//dong xuan
			if (jsDate.month <6){
				time_int1=jsDate.sti-90;
				time_int2=jsDate.cti;//time_int2=jsDate.sti+180;
			}else{
				time_int1=jsDate.sti+180;
				time_int2=jsDate.cti;
			}
		} else {
			time_int1=jsDate.sti;
			time_int2=jsDate.cti;
		}
		
		return getDientichRuongGieocayOfRange(id,vulua_id,gionglua_id,time_int1, time_int2, check_type);
		
	} else {
		msgerror('getDientichRuongGieocay: time is not like dd/mm/yyyy');
	}
	
	
}


function getDientichRuongGieocayOfRange(id,vulua_id,gionglua_id,time_int1, time_int2, check_type){
	//alert('getDientichRuongGieocay(xa_id,vulua_id,gionglua_id,time_int1, time_int2)');
	//get dien tich gieo cay ruong
	var tong_dientich_gieocay = -1;
	$.ajax({
		url:MAIN_SERVLET ,
		data:
		{ 
			action: ACT_DB_GET_DIENTICH_GIEOCAY,
			id:id,
			vulua_id:vulua_id,
			gionglua_id:gionglua_id,
			time_int1:time_int1,
			time_int2:time_int2,
			check_type : check_type
			
		},
		async:false,
		error: function (request, status, error) {
  
		},
		success:function(jsonDataResult) {
			var jr = JSON.parse(jsonDataResult);
			if(jr.code == DB_STR_OK)
				tong_dientich_gieocay = parseFloat(jr.val);
			else {
				msgerror(jr.msg);
			}
		}
	});
	return tong_dientich_gieocay;
	
}
function getLanhthoClicked(table,id,posWKT){
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
	 } 
	 
	 return g_lanhtho_selected;
}
function getMaxDateNgaygieocay(t1, t2, vuluaid)
{
	var sql = "SELECT MAX(pb_lua_ngaybatdau) as max_ngaygieocay_xa,"+
                      "TBL_CANHDONG_TMP.max_ngaygieocay_cd, "+
                      " TBL_RUONG_TMP.max_ngaygieocay_ruong "+
			  " FROM tbl_ttgc_xa"+
			  " LEFT  JOIN 	"+
			  "          (SELECT MAX(ttgc_cd_ngaygieocay) as max_ngaygieocay_cd,"+
              "                  ttgc_cd_vulua	"+
              "           FROM tbl_ttgc_canhdong	"+
              "           WHERE ttgc_cd_ngaygieocay >="+t1+
			  "           AND   ttgc_cd_ngaygieocay <="+t2+
			  "           AND ttgc_cd_vulua ="+vuluaid+	
			  "           Group by ttgc_cd_vulua) AS TBL_CANHDONG_TMP "+
              " ON tbl_ttgc_xa.pb_lua_vu=TBL_CANHDONG_TMP.ttgc_cd_vulua "+ 
              " LEFT JOIN 		"+
			  "		     (SELECT  MAX(ttgc_ngaybatdau) as max_ngaygieocay_ruong, ttgc_vulua"+
			  "		      FROM tbl_ttgc_ruong_tmp 		"+
			  "		      WHERE ttgc_ngaybatdau >="+t1+ 
			  "		      AND   ttgc_ngaybatdau <="+t2+ 
			  "		     AND ttgc_vulua ="+vuluaid+		
			  "		      group by ttgc_vulua) AS TBL_RUONG_TMP "+
			  "		      ON tbl_ttgc_xa.pb_lua_vu=TBL_RUONG_TMP.ttgc_vulua  "+
			  "	WHERE pb_lua_ngaybatdau >="+t1+	
			  "	AND   pb_lua_ngaybatdau <="+t2+		
			  "	AND pb_lua_vu ="+vuluaid+
			  "	GROUP BY TBL_CANHDONG_TMP.max_ngaygieocay_cd, TBL_RUONG_TMP.max_ngaygieocay_ruong";
//alert("sql_max_ngaygieocay"+ sql);
	json = cwrs_getDataDynamic(MAIN_SERVLET, sql, false);
	
//alert("json"+json.rows.length);
	if (json != null&& json.rows.length>0){ 
		var max_ngaygieocay =Math.max(json.rows[0].max_ngaygieocay_ruong,json.rows[0].max_ngaygieocay_cd,json.rows[0].max_ngaygieocay_xa);
		//alert(max_ngaygieocay);
		return max_ngaygieocay; 
	
	} else {
	   //alert('-1')
	   return -1;	
	}

}

function checkGiongluaGieocay(gionglua_id,vulua_id,id,time_str,check_type){
	var ret = false;
	var time_int1,time_int2;
	//var ngay = "ngày điều tra";
	//alert("time_str: "+ time_str);
	//alert("ngày: "+ ngay.indexOf);
	var jsDate;
	if(time_str.indexOf("/") !=-1){
		jsDate=gm.date.stringToJSONDate(time_str);
		if (vulua_id==1){//dong xuan
			if (jsDate.month <6){
				time_int1=jsDate.sti-90;
				time_int2=jsDate.cti;//time_int2=jsDate.sti+180;
			}else{
				time_int1=jsDate.sti+180;
				time_int2=jsDate.cti;
			}
		} else {
			time_int1=jsDate.sti;
			time_int2=jsDate.cti;
		}
		
	} else {
		msgerror('checkGiongluaGieocay: time is not like dd/mm/yyyy');
		return false;
	}
	
	
	 $.ajax({
				url: MAIN_SERVLET ,
				type: "POST",
				data:
			    { 
				  action: ACT_CHECK_GIONGLUA_GIEOCAY,
				  gionglua_id: gionglua_id,
				  id:id,
				  check_type:check_type,
				  vulua_id:vulua_id,
				  time_int1:time_int1,
				  time_int2:time_int2
				},
				 async:false,
				 error: function (request, status, error) {
				        msgerror(request.responseText);
				    },
				 success:function(r) {
					//	alert(r)
					if(r=='1') ret=true;
					else if(r=='0') ret=false;
					else if(r=='-1') {
						ret=false;
						msgerror('Xảy ra lỗi trong khi kiểm tra dữ liệu. Vui lòng thử lại sau!');
					}
					return;
			    }});
	 
	 return ret;
}


function func_ConvertToUnsign(str) {  
	str= str.toLowerCase();
	str= str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g,"a");
	str= str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g,"e");
	str= str.replace(/ì|í|ị|ỉ|ĩ/g,"i");
	str= str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g,"o");
	str= str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g,"u");
	str= str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g,"y");
	str= str.replace(/đ/g,"d");
	str= str.replace(/!|@|\$|%|\^|\*|\(|\)|\+|\=|\<|\>|\?|\/|,|\.|\:|\'| |\"|\&|\#|\[|\]|~/g,"-");
	str= str.replace(/-+-/g,"-"); //thay thế 2- thành 1-
	str= str.replace(/^\-+|\-+$/g,"");//cắt bỏ ký tự - ở đầu và cuối chuỗi
	return str;  
}






