var g_dientich_edit = 0;
var id_test = 0;
/**DATE TIME*/
var dateTimePattern = "ddMMyyyy";
var g_dfSearch_ddMM = new JsSimpleDateFormat("ddMM","en");
var g_dfSearch_ddMMyy = new JsSimpleDateFormat("ddMMyyyy","en");
var dateTimePatternDefault = "dd/MM/yyyy";
var g_dfDefault = new JsSimpleDateFormat(dateTimePatternDefault,"en");
var gDateFormatterDefault = new JsSimpleDateFormat("dd/MM/yyyy","en");

/**ACCOUNT*/
var g_acc_username = '';
var g_acc_password = '';
var g_acc_xa_id = -1;
var g_acc_role = -1;
var g_acc_signedin = false;
var g_mlogin = null;

    
/**FUNCTION*/
var FN_DIEUTRA_RUONG = 0;
var FN_DIEUTRA_CANHDONG = 1;
var FN_DIEUTRA_XA = 2;
var FN_EDITING_CANHDONG = 3;
var FN_BAOCAO_HIENTRANGLUA = 4;
var FN_BAOCAO_COCAUGIONGLUA = 5;
var FN_BAOCAO_THONGTINTHIENTAI = 6;
var FN_DIEUTRA_THITRUONG = 8;
var FN_DIEUTRA_THUHOACH= 7;
var FN_MAP_HIENTRANG_CCGL = 9;
var FN_MAP_HIENTRANG_NUOC = 10;
var FN_MAP_HIENTRANG_HTL = 11;
var FN_MAP_HIENTRANG_DICHHAI = 12;
var FN_MAP_HIENTRANG_THIENTAI = 13;
var FN_MAP_HIENTRANG_NANGSUAT = 14;
var FN_DIEUTRA_THOITIET = 15;
var FN_BAOCAO_TIENDOSANXUAT = 16;
var FN_DIEUTRA_DOTTHIENTAI = 17;
var FN_BAOCAO_TIENDOTHUHOACH = 18;
var FN_VIENTHAM = 19;
var FN_BAOCAO_BUILDGRAPH = 20;
var FN_BAOCAO_THONGTINDICHHAI = 21;
var FN_DUBAO_VT = 22;
var FN_DUBAO_HCG = 23;//he chuyen gia
var FN_DUBAO_HQH = 24;//ham quan he
var FN_BAOCAO_THIENTAI = 25;

///
var FN_ID_XA = -1;
var FN_TEN_XA = "";
var FN_ID_HUYEN = -1;
var FN_TEN_HUYEN = "";



var g_fn_selected = -1;//FN_DIEUTRA_RUONG;

/**Data*/
var g_current_feature = null;
var g_list_canhdong = [];//new: mảng element object Canhdong.    old:new Map(); //key:canhdong_id, value: list ruong id thuộc cánh đồng canhdong_id
var g_xa_id_by_search = -1; 
var g_huyen_id_by_search = -1; 
var g_tinh_id_by_search = -1; 

/**keyboard*/
var g_key_CTR_pressed = false;
var g_key_SPACE_pressed = false;

/**ONLY FOR EDITTING CANHDONG FUNCTION */
var isCopied = false;
var g_fn_editing_canhdong = false;
var g_selected_feature_editing = null;
var g_list_canhdong_clone = [];//bản sao được sử dụng để lưu các thay đổi khi edit cánh đồng
var g_cdm =  new CCanhdongManager();//Canh dong manager


/** VECTOR LAYER */
var g_layer_vector_ruong = null;
var g_layer_vector_canhdong = null;//unused
var g_layer_search = null;
/** STYLE */
var g_style_vector_layer = null;
var g_style_fill_tinh = null;
var g_style_fill_huyen = null;
var g_style_fill_xa = null;
var g_style_fill_ruong = null;
var g_style_geometry_hide = null;
var g_style_fill_canhdong = null;
var g_style_highlight = null;
var g_style_feature_selected = null;
var g_style_blink_editing_canhdong = null;
var g_styleError = null;

/**Một mảng color string để tô cho mỗi cánh đồng*/
var g_array_colors = [];//array

/**buttons and controls*/
var g_controlPanel = null;
var g_btnPanningHand = null;
var g_ctr_drag_rectangle = null;
var g_btnSelectDeature = null;
var g_ctrSelectDeature = null;
var g_ctrDragFeature = null;
var g_btnEditCanhdong=null;

var g_btnZoomIn = null;
var g_btnZoomOut = null;
var g_btnZoomBox = null;
var g_startBox = false;
var g_highlightCtrl = null;
var g_isEnableEditCanhdongByAdmin = false;



var g_Utils = new Utils();

/***/
var g_div_chugiai_flip = 'Welcome to CWRS@2011';
var g_div_chugiai_flip_orginal = '';
var map;
var g_i = 1;
var g_debugInfo = null;

/**control*/
g_control_enable_timer = false;

/**Area */
var g_lanhtho_selected = new Lanhtho();
var g_lanhtho_search_selected = new Lanhtho();


 
//Dialog: 
var g_dlg_ttgc_datagrid_total = -1;
var g_dlg_ttgc_datagrid_rows  = 0;


/**Check diện tich so với thực tế*/
var g_is_checking_are = false;
/***/
var g_ErrorNotifier = new CJsError();











//Variables globals
var gm=new GenericManager();





/***
 * DATE TIME
 * @param msg
 */
var g_rtc = JSON.parse('[{}]');


var JResultFailed = JSON.parse('{\"code\":'+ 0 +',\"msg\":'+0+',\"val\":'+0+'}');

function cwrs_debug(msg){
	if (g_debugInfo != null)
		g_debugInfo.show(msg);
}


function msginfo_autoclose(msg,offset_x, offset_y,time){
	if (time == undefined) time = 1000;
	if (offset_x == undefined) offset_x = 20;
	if (offset_y == undefined) offset_y = 20;
	new $.Zebra_Dialog(msg, {
	    'type':    'information',
	    'title':    'Thông báo',
	    'modal': false,
	    'buttons':  false,
	    'position': ['right - ' +offset_x, 'top + ' + offset_y],
	    'auto_close': time
});
}
function msginfo(msg){

	new $.Zebra_Dialog(msg, {
	    'type':    'information',
	    'title':    'Thông báo',
	    'modal': false

});
}


function msgerror(msg){
	new $.Zebra_Dialog(msg, {
		    'type':     'error',
		    'title':    'Thông báo lỗi',
		    'modal': false
	});
}
function msgwarning(msg){
	new $.Zebra_Dialog(msg, {
	    'type':     'warning',
	    'title':    'Thông báo',
	    'modal': false
});
}

function msgalert(title, msg, type){
	
	new $.Zebra_Dialog(msg, {
	    'type':     type,
	    'title':    title,
	    'modal': false
});
}
function msgalert_autoclose(title, msg, type, time){
	if (time == undefined) time = 1200;
	new $.Zebra_Dialog(msg, {
	    'type':     type,
	    'title':    title,
	    'modal': false,
	    'auto_close': time
});
}/*
function msgalert(title, msg, type){
	if (title = 'confirmation'){
		title = 'confirmation';
	}
	$.Zebra_Dialog(msg, {
	    'type':     type,
	    'title':    title,
	    'modal': false
});
}*/
function msgquestion(msg){
	new $.Zebra_Dialog(msg, {
		'modal': false,
	    'type':     'question',
	    'title':    'Custom buttons',
	    'buttons':  ['Đồng ý', 'Không', 'Trợ giúp'],
	    'onClose':  function(caption) {
	        //alert((caption != '' ? '"' + caption + '"' : 'nothing') + ' was clicked');
	    }
});
}

function msgconfirm(title, msg, callback){
	new $.Zebra_Dialog(msg, {
		'modal': false,
	    'type':     'question',
	    'title':    title,
	    'buttons':  ['Đồng ý', 'Không']
		,'onClose':  function(caption) {
			if (caption == 'Không')
	    		return callback(0);
			else
				return callback(1);
	    //    alert((caption != '' ? '"' + caption + '"' : 'nothing') + ' was clicked');
	    //	return '1';
	    }
});
}
function msgconfirmI(msg, callback,ok,cancel,title){
	new $.Zebra_Dialog(msg, {
		'modal': false,
	    'type':     'warning',
	    'title':    (title==undefined?'Thông báo':title),
	    'buttons':  [ok, cancel]
		,'onClose':  function(caption) {
			if (caption == cancel)
	    		return callback(0);
			else
				return callback(1);
	     //   alert((caption != '' ? '"' + caption + '"' : 'nothing') + ' was clicked');
	    //	return '1';
	    }
	});
}



function set_empty_to_zero(_x){
	_x = _x.trim();
	if (_x == '') _x = '0';
	return _x;
}
function DialogShow(url, width, height,idtext) {
	var left = (screen.width - width) / 2;
	var top = (screen.height - height) / 2;
	var params = "width=" + width + ", height=" + height;
	params += ", top=" + top + ", left=" + left;
	params += ", directories=no";
	params += ", location=no";
	params += ", menubar=yes";
	params += ", resizable=yes";
	params += ", scrollbars=yes";
	params += ", status=no";
	params += ", toolbar=yes";
	win = window.open(url, idtext, params, "_blank");
	if (window.focus) {
		win.focus();
	}
};