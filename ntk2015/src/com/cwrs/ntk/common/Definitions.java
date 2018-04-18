package com.cwrs.ntk.common;

public class Definitions {
	
	public static final String DATE_FORMAT= "dd/MM/yyyy";
	public static final long TIME_OF_DAY_MSEC = 86400000;
  
	public static final int TRUE = 1;
	public static final int FALSE = 0;
	
	public static final String DB_STR_OK= "1";
	public static final String DB_STR_FAILED = "0";
	
	public static final int DB_INT_OK = 1;
	public static final int DB_INT_FAILED = 0;
	
	public static final int TYPE_GEOMETRY_WKT = 0;
	public static final int TYPE_GEOMETRY_WKB = 1;
	
	public static final int TYPE_BIGENDIAN_XDR = 0;
	public static final int TYPE_LITTLEENDIAN_NDR = 1;
	public static final int TYPE_DATA_JSON_CBB = 0;
	public static final int TYPE_DATA_HTML_CBB = 1;
	
	
	
	public static final String SQL_QUERY_SEP = "<o>";
	public static final String SQL_ID_VALUE_REPLACED = "<.>";
	public static final String SQL_VALUES_LIST_SEP = "<v>";	
	public static final String SQL_ID_LIST_SEP = "<,>";	
	public static final String SQL_COMMA_SEP = ",";
	public static final String SQL_VALUES_SEP = "<,>";
	
	public static final String SQL_TYPE_INT = "i";
	public static final String SQL_TYPE_BIGINT = "bi";
	public static final String SQL_TYPE_STRING = "s";
	public static final String SQL_TYPE_LONG = "l";
	public static final String SQL_TYPE_FLOAT = "f";
	public static final String SQL_TYPE_DOUBLE = "d";
	public static final String SQL_TYPE_SHORT = "sh";
	public static final String SQL_TYPE_BOOLEAN = "boo";
	public static final String SQL_TYPE_TIME = "t";
	public static final String SQL_TYPE_SEP = "-";
	
	public static final String COM_TYPE_SEP = "-";
	public static final String SEP_TEXT_AND_BINARY = "<o>";
	
	public static final String DB_URL_DATASOURCE = "java:comp/env/jdbc/dbscl";
	
	
	//Define commands access to the database
	public static final int ACT_GET_SAUHAI_TO_CBB  = 0;
	public static final int ACT_GET_LIST_SAUHAI_RM = 1;
	public static final int ACT_GET_LIST_RUONGID_SAME_CANHDONG = 2;
	public static final int ACT_GET_TINH_TO_CBB = 3;
	public static final int ACT_GET_HUYEN_TO_CBB = 4;
	public static final int ACT_GET_XA_TO_CBB = 5;
	
	

	
	public static final int ACT_GET_BOUND_OF_XA = 6;
	

	
	public static final int ACT_GET_GIONGLUA_TO_CBB = 10;
	public static final int ACT_GET_TRALUA_TO_CBB = 11;
	public static final int ACT_GET_VULUA_TO_CBB = 10001;
	
	
	public static final int ACT_SIGNIN = 12;
	
	public static final int ACT_GET_BOUND_OF_AREA = 13;
	
	public static final int ACT_GET_THIENTAI_TO_CBB = 14;

	public static final int ACT_GET_LIST_GDST_TO_CBB = 15;
	
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TTGC_RUONG = 16;
	
	public static final int	ACT_GET_GEOMETRY_BY_INTERSECTION = 17;
	
	public static final int ACT_GET_GEOMETRY_OF_AREA = 18;
	public static final int ACT_PRECACHE_GEOMETRY = 19;
	public static final int  ACT_GET_DATA_CANHDONG_FOR_XA = 20;
	public static final int ACT_GET_ID_GEOMETRY_BY_INTERSECTION = 21;
	
	public static final int ACT_GET_DATA_TO_EDIT_TTGC_CANHDONG = 22;
	public static final int ACT_GET_DATA_TO_EDIT_TTSH_CANHDONG = 23;
	public static final int ACT_GET_DATA_TO_EDIT_TTBH_CANHDONG = 24;
	public static final int ACT_GET_DATA_TO_EDIT_HTL_CANHDONG  = 25;
	
	
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TTSH_CANHDONG = 26;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TTBH_CANHDONG = 27;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_HTL_CANHDONG = 28;
	
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TTTT_RUONG = 29;
	
	
	public static final int ACT_GET_DATA_TO_EDIT_TTTT_RUONG = 30;
	
	public static final int  ACT_GET_DATA_TO_FORM_SHOW_TTTT_CANHDONG = 31;
	
	public static final int  ACT_GET_DATA_TO_EDIT_TTTT_CANHDONG  = 32;
	public static final int ACT_GET_PPGC_TO_CBB = 33;
	
	public static final int ACT_GET_CURRENT_TIME = 34;
	
	public static final int  ACT_GET_DATA_TO_FORM_ADD_TTTT_CANHDONG = 35;
	
	public static final int	ACT_GET_DATA_TO_FORM_ADD_HTL_CANHDONG = 36;
	
	public static final int ACT_GET_DATA_TO_FORM_ADD_DTN_CANHDONG =37;
	
	
	
	
	
	
	
	
	
	
	
	
	
	 
	

	//ACTION CỦA TÙNG
	public static final int ACT_GET_LIST_HIENTUONGGAYHAI_TO_CHECKBOX = 500;
	public static final int ACT_GET_LIST_KHANGSAU_TO_CHECKBOX = 501;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_HTL_XA = 502;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_THIENTAI_XA = 503;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_KQTHUHOACH_XA = 504;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_SINHTHAI_XA = 505;
	public static final int ACT_GET_DATA_TO_EDIT_HTL_XA = 506;
	public static final int ACT_GET_DATA_TO_EDIT_KQTH_XA = 507;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_KQTHUHOACH_PHAPLY_XA = 508;
	public static final int ACT_GET_DATA_TO_EDIT_KQTH_PHAPLY_XA = 509;
	public static final int ACT_GET_DATA_TO_EDIT_SINHTHAI_XA = 510;
	public static final int ACT_GET_CAPDOTHIENTAI_TO_CBB = 511;
	public static final int ACT_GET_DATA_TO_EDIT_THIENTAI_XA = 512;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TTGIEOCAY_XA = 513;
	public static final int ACT_GET_DATA_TO_EDIT_TTGIEOCAY_XA = 514;
	public static final int ACT_GET_DATA_TO_EDIT_MATDOSAU_XA = 515;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_MATDOSAU_XA = 516;
	public static final int ACT_GET_DATA_TO_EDIT_TYLEBENH_XA = 517;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TYLEBENH_XA = 518;
	public static final int ACT_GET_DATA_TO_EDIT_DTNHIEM_XA = 519;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_DTNHIEM_XA = 520;
	public static final int ACT_GET_DATA_TO_EDIT_BAYDEN_XA = 521;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_BAYDEN_XA = 522;
	public static final int ACT_GET_DATA_TO_EDIT_KYSINH_XA = 523;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_KYSINH_XA = 524;
	public static final int ACT_GET_THIENDICH_TO_CBB = 525;
	public static final int ACT_GET_DATA_TO_EDIT_BATMOIANTHIT_XA = 526;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_BATMOIANTHIT_XA = 527;
	public static final int ACT_GET_DATA_TO_EDIT_PHUNTHUOC_XA = 528;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_PHUNTHUOC_XA = 529;
	public static final int ACT_GET_CACHBONPHAN_TO_CBB = 530;
	public static final int ACT_GET_LOAIPHAN_TO_CBB = 531;
	public static final int ACT_GET_DATA_TO_EDIT_BONPHAN_XA = 532;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_BONPHAN_XA = 533;
	public static final int ACT_GET_HUONGGIO_TO_CBB = 534;
	public static final int ACT_GET_DATA_TO_EDIT_THOITIETTINH_XA = 535;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_THOITIETTINH_XA = 536;
	public static final int ACT_GET_DATA_TO_EDIT_DUBAOTHOITIETTINH_XA = 537;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_DUBAOTHOITIETTINH_XA = 538;
	public static final int ACT_GET_DATA_TO_EDIT_THOITIETHUYEN_XA = 539;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_THOITIETHUYEN_XA = 540;
	public static final int ACT_GET_DATA_TO_EDIT_SOLIEUTHIENDICH = 541;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_SOLIEUTHIENDICH = 542;
	public static final int ACT_GET_DATA_TO_EDIT_SOLIEUVISINHVAT = 543;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_SOLIEUVISINHVAT = 544;
	public static final int ACT_GET_DATA_TO_EDIT_SOLIEUPHANBON = 545;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_SOLIEUPHANBON = 546;
	public static final int ACT_GET_DATA_TO_EDIT_SOLIEUTHUOCBVTV = 547;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_SOLIEUTHUOCBVTV = 548;
	public static final int ACT_GET_DATA_TO_EDIT_SOLIEUHIENTUONGGAYHAI = 549;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_SOLIEUHIENTUONGGAYHAI = 550;
	public static final int ACT_GET_DATA_TO_EDIT_SOLIEUGIONGLUA = 551;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_SOLIEUGIONGLUA = 552;
	public static final int ACT_GET_DATA_TO_EDIT_SOLIEUDICHBENH = 553;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_SOLIEUDICHBENH = 554;
	public static final int ACT_GET_DATA_TO_EDIT_SOLIEUSAUHAI = 555;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_SOLIEUSAUHAI = 556;
	public static final int ACT_GET_LIST_KHANGBENH_TO_CHECKBOX = 557;
	public static final int ACT_GET_LIST_THIENDICH_TO_CHECHBOX = 558;
	public static final int ACT_GET_LIST_THUOC_TO_CHECKBOX = 559;
	public static final int ACT_GET_LIST_VISINHVAT_TO_CHECHBOX = 560;
	public static final int ACT_GET_DATA_TO_EDIT_DOTTHIENTAI = 561;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_DOTTHIENTAI = 562;

	public static final int ACT_GET_TENTHUOC_TO_CBB = 570;
	public static final int ACT_GET_DOTTHIENTAI_TO_CBB = 571;
//Database
	public static final int ACT_DB_INSERT_OBJECT = 100;
	public static final int ACT_DB_UPDATE_OBJECT = 101;

	public static final int ACT_DB_INSERT_THONGTIN_GIEOCAY = 102;
	
	public static final int ACT_DB_INSERT_UPDATE_MULTI_OBJECT = 103;
	//huyen
	public static final int ACT_DB_DELETE_OBJECT = 104; 
	
	public static final int ACT_GET_DATA_TO_EDIT_TTGC_RUONG = 105;
	
	public static final int ACT_GET_GDST_LUA_TO_CBB = 106;
	public static final int ACT_GET_TUOI_SAUHAI_TO_CBB = 107;
	
	
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TTSH_RUONG = 108;
	
	public static final int ACT_GET_DATA_TO_EDIT_TTSH_RUONG = 109;
	
	public static final int  ACT_GET_BENHHAI_TO_CBB = 110;
	public static final int  ACT_GET_DATA_TO_FORM_SHOW_TTBH_RUONG = 111;

	public static final int ACT_GET_DATA_TO_EDIT_TTBH_RUONG = 112;
	public static final int ACT_GEN_REPORT = 113;
	
	public static final int	ACT_GET_INFO_AREA_CLICKED = 114;
	
	public static final int ACT_GET_MUCDOTHIENTAI_TO_CBB = 115;
	
	public static final int ACT_UPDATE_EDITING_CANHDONG = 116;
	public static final int ACT_EXEC_SQL_FROM_CLIENT= 117;
	public static final int ACT_DB_GET_DATA_DYNAMIC=118;
	public static final int ACT_DB_UPDATE_DATAGRID = 119;
	public static final int ACT_DB_GET_DIENTICH_GIEOCAY=120;
	public static final int ACT_DB_CHECK_DOTTHIENTAI_EXISTS= 121;
	public static final int ACT_GET_DATA_TO_VIENTHAM_IMAGE =122;
	public static final int ACT_GET_DIENTICH_ON_VIENTHAM_IMG_HTL=123;
	public static final int	ACT_GET_LIST_XAID_SAME_SINHTHAI=124;	
	
	public static final int	ACT_CHECK_GIONGLUA_GIEOCAY=125;	
	public static final int ACT_GET_DIENTICH_ON_VIENTHAM_IMG_SACAY=126;
	public static final int ACT_GET_DIENTICH_ON_VIENTHAM_IMG_NS=127;
	
	
    //Huyen
	public static final int ACT_GET_DATA_TO_FORM_SHOW_HTL_RUONG=1001;
	public static final int ACT_GET_DATA_TO_EDIT_HTL_RUONG=1002;

	public static final int ACT_GET_HIENTRANG_TO_CBB = 1003;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TTGC_CANHDONG = 1004;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TTNS_CANHDONG = 1005;
	public static final int ACT_GET_DATA_TO_EDIT_TTNS_CANHDONG = 1006;
	public static final int ACT_GET_DATA_TO_EDIT_TTTT = 1007;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TTTT = 1008;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_MDS_RUONG = 1009;
	public static final int ACT_GET_DATA_TO_EDIT_MDS_RUONG = 1010;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_MDS_CANHDONG = 1011;
	public static final int ACT_GET_DATA_TO_EDIT_MDS_CANHDONG = 1012;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TTNS_RUONG = 1013;
	public static final int ACT_GET_DATA_TO_EDIT_TTNS_RUONG = 1014;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TLB_RUONG = 1015;
	public static final int ACT_GET_DATA_TO_EDIT_TLB_RUONG = 1016;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TLB_CANHDONG = 1017;
	public static final int ACT_GET_DATA_TO_EDIT_TLB_CANHDONG = 1018;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_DTN_CANHDONG = 1019;
	public static final int ACT_GET_DATA_TO_EDIT_DTN_CANHDONG = 1020;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_DTN_RUONG = 1021;
	public static final int ACT_GET_DATA_TO_EDIT_DTN_RUONG = 1022;
	public static final int ACT_GET_DATA_TO_EDIT_NUOC_RUONG = 1023;
	public static final int ACT_DB_CHECK_DATA_EXISTS = 1024;
	public static final int ACT_DB_MAX_DATA = 1025;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TTKS_CANHDONG = 1026;
	public static final int ACT_GET_DATA_TO_EDIT_TTKS_CANHDONG = 1027;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TTKS_RUONG = 1028;
	public static final int ACT_GET_DATA_TO_EDIT_TTKS_RUONG = 1029;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TTTD_CANHDONG = 1030;
	public static final int ACT_GET_DATA_TO_EDIT_TTTD_CANHDONG = 1031;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TTTD_RUONG = 1032;
	public static final int ACT_GET_DATA_TO_EDIT_TTTD_RUONG = 1033;
	public static final int ACT_DB_CHECK_RUONG =1034;
	public static final int ACT_DB_DIENTICH =1035;
	public static final int ACT_DB_ADD_TROGIUP=1036;
	public static final int ACT_GET_DOT_THIENTAI_TO_CBB=1037;
	public static final int ACT_GET_DATA_TO_EDIT_TTT_HUYEN = 1038;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TTT_HUYEN = 1039;
	public static final int	ACT_GET_VIENTHAM_TO_CBB = 1040;
	public static final int	ACT_GET_LOAILUA_TO_CBB = 1041;
	public static final int	ACT_GET_LOAIBANDO_TO_CBB = 1042;
	
//	public static final int ACT_GET_DATA_TO_FORM_SHOW_BAOCAO_GIONGLUA = 1023;
	public static final int TEST = 9999;
	
	
	
	//Report type
	public static final int REPORT_TYPE_HTL = 0;  //hiện trạng lúa 
	public static final int REPORT_TYPE_TTTT = 1; //thông tin thiên tai
	public static final int REPORT_TYPE_CCGL= 2;  //cơ cấu giống lúa
	public static final int REPORT_TYPE_TDSX= 3;  //tien do san xuat
	public static final int REPORT_TYPE_TDTH= 4;  //tien do thu hoạch
	public static final int REPORT_TYPE_BUILDGRAPH=5;//xay dung do thi so sanh
	public static final int REPORT_TYPE_TTDH= 10;  //tien do thu hoạch

	public static final int REPORT_TYPE_BUILDGRAPH_OPTION_DT_XUONGGIONG=1;//dien tich xuong giong
	public static final int REPORT_TYPE_BUILDGRAPH_OPTION_DT_THUHOACH=2;//dien tich thu hoach
	public static final int REPORT_TYPE_BUILDGRAPH_OPTION_SL_THUHOACH=3;//san luong thu hoach
	public static final int REPORT_TYPE_BUILDGRAPH_OPTION_MDS_TLB_DTN=4;//mat do sau, ty le benh
	
	public static final int REPORT_TYPE_BUILDGRAPH_OPTION_VT_DTLUA=10;//san luong thu hoach
	public static final int REPORT_TYPE_BUILDGRAPH_OPTION_VT_DTGIEOTRONG=11;//mat do sau, ty le benh

	
	
	public static final int REPORT_CCGL_OPTION_TAINGAY= 1; 
	public static final int REPORT_CCGL_OPTION_DAUVU2NGAY= 2; 
	public static final int REPORT_CCGL_OPTION_VUOFNAM= 3; 
	 
	public static final int REPORT_TTTT_OPTION_DOT= 1; 
	public static final int REPORT_TTTT_OPTION_VUOFNAM= 2; 
	
	public static final int REPORT_TDSX_OPTION_MAU02= 1;
	public static final int REPORT_TDSX_OPTION_MAU02_01= 2; 
	//Ma[ Render Servlet
	public static final int ACT_RENDER_MAP_CCGL = 0;
	public static final int ACT_RENDER_MAP_NUOC = 1;
	public static final int ACT_RENDER_MAP_HTL =  2;
	public static final int ACT_RENDER_MAP_DICHHAI = 3;
	public static final int ACT_RENDER_MAP_THIENTAI = 4;
	public static final int ACT_RENDER_MAP_NANGSUAT = 5;
	public static final int ACT_RENDER_MAP_VIENTHAM = 6;
	public static final int ACT_RENDER_MAP_DUBAO = 7;
	

	public static final int RENDER_TTTT_OPTION_DOT= 1; 
	public static final int RENDER_TTTT_OPTION_NGAY= 2; 
	  
	//REPORT
	public static final String REPORT_GIONGLUA_KHAC =  "z.Giống khác";
	
	//PhAN BO
	public static final int ACT_PHANBO_CANHDONG_TTGC = 10000;
	public static final int ACT_PHANBO_CANHDONG_TTTT = 10001;
	public static final int ACT_PHANBO_CANHDONG_HTL = 10002;
	public static final int ACT_PHANBO_CANHDONG_DTN = 10003;
	public static final int ACT_PHANBO_XA_TTGC = 10004;
	
	//public static final int ACT_PHANBO_TTGC=10005;
	public static final int ACT_PHANBO_XA_HTL=10006;
	public static final int ACT_PHANBO_XA_DTN = 10007;
	
	public static final int ACT_PHANBO_CANHDONG_NS = 10008;
	public static final int ACT_PHANBO_XA_NS = 10009;
	public static final int ACT_PHANBO_XA_TTTT = 10010;
	
	
	
	
	
	public static final int TYPE_PHANBO_RUONG = 1;
	public static final int TYPE_PHANBO_CANHDONG = 2;
	public static final int TYPE_PHANBO_XA = 3;
	
	
	
	//
	public static final String LIST_TABLES_RELATIVE_CANHDONG = "tbl_dong_dientichnhiem," +
															   "tbl_dong_ht_benh," +
															   "tbl_dong_ht_lua," +
															   "tbl_dong_ht_sau," +
															   "tbl_dong_ht_thientai," +
															   "tbl_dong_kysinh," +
															   "tbl_dong_matdo_sau," +
															   "tbl_dong_nangsuat," +
															   "tbl_dong_thiendich," +
															   "tbl_dong_tylebenh,";
	public static final String LIST_TABLES_RELATIVE_CANHDONGID = "ddtn_canhdong_id," +
			   												   "dbh_canhdong_id," +
			   												   "dht_canhdong_id," +
			   												   "dsh_canhdong_id," +
			   												   "dtt_canhdong_id," +
			   												   "dks_canhdong_id," +
			   												   "dmds_canhdong_id," +
			   												   "dns_canhdong_id," +
			   												   "dtd_canhdong_id," +
			   												   "dtlb_canhdong_id,";
	/*public static final String LIST_TABLES_RELATIVE_RUONG = "tbl_dong_dientichnhiem," +
			   												"tbl_dong_ht_benh," +
			   												"tbl_dong_ht_lua," +
			   												"tbl_dong_ht_sau," +
			   												"tbl_dong_ht_thientai," +
			   												"tbl_dong_kysinh," +
			   												"tbl_dong_matdo_sau," +
			   												"tbl_dong_nangsuat," +
			   												"tbl_dong_thiendich," +
			   												"tbl_dong_tylebenh,";*/															   
	
	
	
	//ROLES
	public static final int ROLE_ADMIN = 0;
	public static final int ROLE_BVTV = 1;
	public static final int ROLE_TINH = 2;
	public static final int ROLE_XA = 3;
	public static final int ROLE_HUYEN = 4;
	
	public static final int CHECK_RUONG= 1;
	public static final int CHECK_CANHDONG = 2;
	public static final int CHECK_XA = 3;
	
	//DU BAO
	public static final int ACT_DUBAO_HQH = 1;
	public static final int ACT_DUBAO_HCG = 2;

	//----------------------------------- NTM --------------------------------------//
	public static final int TRANG_VIDEO = 80;
	public static final int COUNT_TRANG_VIDEO = 81;
	public static final int LIST_TRANG_VIDEO = 82;
	public static final int XEM_VIDEO = 83;
	
	public static final int TRANG_ANH = 90;
	public static final int COUNT_TRANG_ANH = 91;
	public static final int XEM_TRANG_ANH = 92;
	
	public static final int PAGINATION_VB = 102;
	public static final int VIEW_CONTENT_VB = 103;
	public static final int SUBJECT_SEARCH_VB = 104;
	
	public static final int PAGINATION_YK = 105;
	public static final int VIEW_CONTENT_YK = 106;
	public static final int SUBJECT_SEARCH_YK = 107;
	
	public static final int PAGINATION_TT = 108;
	public static final int VIEW_CONTENT_TT = 109;
	public static final int SUBJECT_SEARCH_TT = 110;
	
	public static final int PAGINATION_DETAI = 111;
	public static final int VIEW_CONTENT_DETAI = 112;
	public static final int SUBJECT_SEARCH_DETAI = 113;
	
	public static final int PAGINATION_GIOITHIEU = 114;
	public static final int VIEW_CONTENT_GIOITHIEU = 115;
	public static final int SUBJECT_SEARCH_GIOITHIEU = 116;
	
	
	//----------------------------------- Quan Tri --------------------------------------//
	public static final int ACT_GET_DATA_TO_FORM_SHOW_DANHSACHQUYEN = 0;
	public static final int ACT_GET_DATA_TO_EDIT_DANHSACHQUYEN = 1;
	public static final int ACT_GET_LIST_DANHSACHQUYEN_TO_CHECKBOX = 2;

	public static final int ACT_GET_DATA_TO_FORM_SHOW_DS_PHANLOAIVANBAN = 3;
	public static final int ACT_GET_DATA_TO_EDIT_DS_PHANLOAIVANBAN = 4;
	
	public static final int ACT_GET_DATA_TO_FORM_SHOW_DS_TAIKHOAN = 5;
	public static final int ACT_GET_DATA_TO_EDIT_DS_TAIKHOAN = 6;
	public static final int ACT_GET_DATA_USERLIST = 7;
	
	public static final int ACT_GET_VANBAN_PHANLOAI_TO_CBB = 8;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_DS_VANBANPHAPLY = 9;
	public static final int ACT_GET_DATA_TO_EDIT_DS_VANBANPHAPLY = 10;
	
	// Y kien chi dao
	public static final int ACT_GET_DATA_TO_FORM_SHOW_DS_YKIENCHIDAO = 11;
	public static final int ACT_GET_DATA_TO_EDIT_DS_YKIENCHIDAO = 12;

	// Tin tuc hoat dong
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TINTUCHOATDONG_PHANLOAI = 13;
	public static final int ACT_GET_DATA_TO_EDIT_TINTUCHOATDONG_PHANLOAI = 14;
	public static final int ACT_GET_TINTUCHOATDONG_TO_CBB = 15;
	public static final int ACT_GET_DATA_TO_FORM_SHOW_TINTUCHOATDONG = 16;
	public static final int ACT_GET_DATA_TO_EDIT_DS_TINTUCHOATDONG = 17; 
	
	//To chuc
	public static final int ACT_GET_DATA_TO_FORM_TOCHUC = 18;
	public static final int ACT_GET_DATA_TO_EDIT_TOCHUC = 19;
	public static final int ACT_GET_TOCHUC_TO_CBB = 20;
	
	//Nhan su
	public static final int ACT_GET_DATA_TO_FORM_SHOW_NHANSU = 21;
	public static final int ACT_GET_DATA_TO_EDIT_NHANSU = 22;
	
	//De tai du an
	public static final int ACT_GET_NHOM_DETAI_DUAN_TO_CBB = 23;
	public static final int ACT_GET_DATA_TO_FORM_DETAI_DUAN = 24;
	public static final int ACT_GET_DATA_TO_EDIT_DETAI_DUAN = 25;
	public static final int ACT_GET_DETAI_DUAN_TO_CBB = 26;
	
	//Thuyet minh de tai
	public static final int ACT_GET_DATA_TO_FORM_THUYETMINH_DETAI = 27;
	public static final int ACT_GET_DATA_TO_EDIT_THUYETMINH_DETAI = 28;
	public static final int ACT_GET_THUYETMINH_DETAI_TO_CBB = 29;
	
	//Phan Loai Thanh Vien
	public static final int ACT_GET_DATA_TO_FORM_PHANLOAI_THANHVIEN = 200;
	public static final int ACT_GET_DATA_TO_EDIT_PHANLOAI_THANHVIEN = 201;
	
	//Tieu chi xay dung ntm 
	public static final int  ACT_GET_DATA_TO_FORM_TIEUCHI_XD_NTM_CHA = 30;
	public static final int  ACT_GET_DATA_TO_EDIT_TIEUCHI_XD_NTM_CHA = 31;
	public static final int  ACT_GET_TIEUCHI_XD_NTM_CHA_TO_CBB = 32;
	public static final int ACT_GET_DATA_TO_FORM_TIEUCHI_XD_NTM_CON = 33;
	public static final int ACT_GET_DATA_TO_EDIT_TIEUCHI_XD_NTM_CON = 34;
	public static final int  ACT_GET_KHUVUC_TO_CBB = 35;
	
	//Tieu chi ung dung
	public static final int ACT_GET_DATA_TO_FORM_TIEUCHI_UNGDUNG = 36;
	public static final int ACT_GET_DATA_TO_EDIT_TIEUCHI_UNGDUNG = 37;
	public static final int ACT_GET_TIEUCHI_CON_TO_CBB = 38;
	public static final int ACT_GET_XADIEM_TO_CBB = 39;

	//Nhan su tham gia
	public static final int ACT_GET_DATA_TO_FORM_NHANSU_THAMGIA = 40; 
	public static final int ACT_GET_DATA_TO_EDIT_NHANSU_THAMGIA = 41; 
	public static final int ACT_GET_NHANSU_TO_CBB = 42; 
	public static final int ACT_GET_VAITRO_TO_CBB = 43; 
	
	//Bien ban hop hoi dong
	public static final int ACT_GET_DATA_TO_FORM_BIENBAN_HOPHOIDONG = 44; 
	public static final int ACT_GET_DATA_TO_EDIT_BIENBAN_HOPHOIDONG= 45; 
	public static final int ACT_GET_CHUYENGIA_TO_CBB = 46; 
	public static final int ACT_GET_DATA_OUT_BIENBAN_HOPHOIDONG= 47; 
	
	//Bien ban mo ho so
	public static final int ACT_GET_DATA_TO_FORM_BIENBAN_MOHOSO = 48; 
	public static final int ACT_GET_DATA_TO_EDIT_BIENBAN_MOHOSO= 49;
	public static final int ACT_GET_DATA_TO_OUT_BIENBAN_MOHOSO = 50;
	
	//Bien ban kiem phieu
	public static final int ACT_GET_DATA_TO_FORM_BIENBAN_KIEMPHIEU = 51; 
	public static final int ACT_GET_DATA_TO_EDIT_BIENBAN_KIEMPHIEU= 52;
	public static final int ACT_GET_DATA_OUT_BIENBAN_KIEMPHIEU = 53;
	
	//To chuc tham gia
	public static final int ACT_GET_DATA_TO_FORM_TOCHUC_THAMGIA = 54; 
	public static final int ACT_GET_DATA_TO_EDIT_TOCHUC_THAMGIA= 55;
	public static final int ACT_GET_DATA_OUT_TOCHUC_THAMGIA = 56;
	public static final int ACT_GET_PHANLOAI_KQ_TO_CBB = 57;
	
	//Phieu
	public static final int ACT_GET_DATA_TO_FORM_PHIEU = 58; 
	public static final int ACT_GET_DATA_TO_EDIT_PHIEU= 59;
	public static final int ACT_GET_DATA_OUT_PHIEU = 60;
	public static final int ACT_GET_PHANLOAI_PHIEU_TO_CBB = 61;
	public static final int ACT_GET_KIENNGHI_TO_CBB = 62;
	public static final int ACT_GET_PHANLOAI_THANHVIEN_TO_CBB = 63;
	
	//Giai doan
	public static final int ACT_GET_DATA_TO_FORM_GIAIDOAN = 64; 
	public static final int ACT_GET_DATA_TO_EDIT_GIAIDOAN = 65;
	
	//De tai to chuc 
	public static final int ACT_GET_DATA_TO_FORM_DETAI_TOCHUC = 66; 
	public static final int ACT_GET_DATA_TO_EDIT_DETAI_TOCHUC = 67;
	
	//Phan loai san pham
	public static final int ACT_GET_DATA_TO_FORM_PHANLOAI_SANPHAM = 68; 
	public static final int ACT_GET_DATA_TO_EDIT_PHANLOAI_SANPHAM = 69;
	
	//San pham
	public static final int ACT_GET_DATA_TO_FORM_SANPHAM = 70; 
	public static final int ACT_GET_DATA_TO_EDIT_SANPHAM = 71;
	public static final int ACT_GET_PHANLOAI_SANPHAM_TO_CBB = 72; 
	
	//Ke hoach cap kinh phi 
	public static final int ACT_GET_DATA_TO_FORM_KH_CAPKINHPHI = 73; 
	public static final int ACT_GET_DATA_TO_EDIT_KH_CAPKINHPHI = 74;

	//Tien do cap kinh phi 
	public static final int ACT_GET_DATA_TO_FORM_TD_CAPKINHPHI = 75; 
	public static final int ACT_GET_DATA_TO_EDIT_TD_CAPKINHPHI = 76;
	
	//Phan bo von theo hang muc
	public static final int ACT_GET_DATA_TO_FORM_PHANBOVON_THEOHANGMUC = 77; 
	public static final int ACT_GET_DATA_TO_EDIT_PHANBOVON_THEOHANGMUC = 78;
	
	//Tien do giai ngan
	public static final int ACT_GET_DATA_TO_FORM_TIENDO_GIAINGAN = 79; 
	public static final int ACT_GET_DATA_TO_EDIT_TIENDO_GIAINGAN = 80;

	//Co che chinh sach
	public static final int ACT_GET_DATA_TO_FORM_COCHE_CHINHSACH = 81; 
	public static final int ACT_GET_DATA_TO_EDIT_COCHE_CHINHSACH = 82;
	
	//Giai phap khoa hoc cong nghe
	public static final int ACT_GET_DATA_TO_FORM_GIAIPHAP_KHCN= 83; 
	public static final int ACT_GET_DATA_TO_EDIT_GIAIPHAP_KHCN = 84;
	
	//Noi dung cong viec thuyet minh 
	public static final int ACT_GET_DATA_TO_FORM_NOIDUNG_THUYETMINH_NHOM= 85; 
	public static final int ACT_GET_DATA_TO_EDIT_NOIDUNG_THUYETMINH_NHOM = 86;
	public static final int ACT_GET_DATA_TO_FORM_NOIDUNG_THUYETMINH_CON = 91;
	public static final int ACT_GET_DATA_TO_EDIT_NOIDUNG_THUYETMINH_CON = 92;
	public static final int ACT_GET_NOIDUNG_THUYETMINH_NHOM_TO_CBB = 93;
	
	
	public static final int ACT_GET_TOCHUC_DETAI_TOCHUC_TO_CBB = 87;
	public static final int ACT_GET_THUYETMINH_DETAI_TOCHUC_TO_CBB = 88;
	public static final int ACT_GET_DETAI_DETAI_TOCHUC_TO_CBB = 89;
	
	//Combobox Giai doan
	public static final int ACT_GET_GIAI_DOAN_TO_CBB = 90;
	
	public static final int ACT_GET_DATA_TO_FORM_UPLOAD_BANGHINH_DETAI = 94;
	public static final int ACT_GET_DATA_TO_EDIT_UPLOAD_BANGHINH_DETAI = 95;
	public static final int ACT_GET_DATA_TO_FORM_UPLOAD_HINHANH_DETAI = 96;
	public static final int ACT_GET_DATA_TO_EDIT_UPLOAD_HINHANH_DETAI = 97;
	public static final int ACT_GET_FOLDER_HINHANH_DETAI_TO_CBB = 98;
	public static final int ACT_GET_DATA_TO_FORM_THUMUC = 99;
	public static final int ACT_GET_DATA_TO_EDIT_THUMUC = 100;
	
	public static final int ACT_GET_DATA_TO_FORM_UPLOAD_BANGHINH_NTM = 101;
	public static final int ACT_GET_DATA_TO_EDIT_UPLOAD_BANGHINH_NTM = 102;
	public static final int ACT_GET_DATA_TO_FORM_UPLOAD_HINHANH_NTM = 105;
	
	// Control Image
	public static final int CODE_UPLOAD = 500 ;
	public static final int CODE_DELETE = 501 ;
	
	
	//Chuyen Gia
	public static final int ACT_GET_DATA_TO_FORM_CHUYENGIA = 202;
	public static final int ACT_GET_DATA_TO_EDIT_CHUYENGIA = 203;
	
	//Kien nghi
	public static final int ACT_GET_DATA_TO_FORM_SHOW_KIENNGHI = 204;
	public static final int ACT_GET_DATA_TO_EDIT_KIENNGHI = 205;
	
	//phan loai phieu
	public static final int ACT_GET_DATA_TO_FORM_SHOW_PHANLOAI_PHIEU = 206;
	public static final int ACT_GET_DATA_TO_EDIT_PHANLOAI_PHIEU = 207;
	
	//phan loai de tai du an
	public static final int ACT_GET_DATA_TO_FORM_SHOW_PHANLOAI_DETAI_DUAN = 208;
	public static final int ACT_GET_DATA_TO_EDIT_PHANLOAI_DETAI_DUAN = 209;
	
	//phanloai bao cao
	public static final int ACT_GET_DATA_TO_FORM_SHOW_PHANLOAI_BAOCAO = 210;
	public static final int ACT_GET_DATA_TO_EDIT_PHANLOAI_BAOCAO = 211;
	
	//vai tro
	public static final int ACT_GET_DATA_TO_FORM_SHOW_VAITRO = 212;
	public static final int ACT_GET_DATA_TO_EDIT_VAITRO = 213;
	
	//phan loai ket qua
	public static final int ACT_GET_DATA_TO_FORM_SHOW_PHANLOAI_KQ = 214;
	public static final int ACT_GET_DATA_TO_EDIT_PHANLOAI_KQ = 215;
	
	//phan loai khu vuc
	public static final int ACT_GET_DATA_TO_FORM_SHOW_PHANLOAI_KHUVUC = 216;
	public static final int ACT_GET_DATA_TO_EDIT_PHANLOAI_KHUVUC = 217;
	
	//bai viet gioi thieu NTM 
	public static final int ACT_GET_DATA_TO_BAIVIET_GIOITHIEU_NTM = 218;
	public static final int ACT_GET_DATA_TO_EDIT_BAIVIET_GIOITHIEU_NTM = 219;
	
	//bai viet gioi thieu NCDTDA 
	public static final int ACT_GET_DATA_TO_BAIVIET_GIOITHIEU_UDNC_DTDA = 220;
	public static final int ACT_GET_DATA_TO_EDIT_BAIVIET_GIOITHIEU_UDNC_DTDA = 221;
	
	//ket qua danh gia hang nam
	public static final int ACT_GET_DATA_TO_KETQUA_DANHGIA_HANGNAM = 222;
	public static final int ACT_GET_DATA_TO_EDIT_KETQUA_DANHGIA_HANGNAM = 223;
	
	//Combobox ke hoach cap kinh phi
	public static final int ACT_GET_KH_CAPKINHPHI_CBB = 224;
	public static final int ACT_GET_DATA_TO_FORM_NOIDUNG_CAPKINHPHI = 225;
	public static final int ACT_GET_DATA_TO_EDIT_NOIDUNG_CAPKINHPHI = 226;
	
	//lay tieu chi cha trong bang tieu chi ung dung (Phân loại đề tài, 
	//dự án theo tiêu chí được ứng dụng vào việc xây dựng các mô hình điểm nông thôn 
	//mới' trong trình thực đơn
	public static final int ACT_GET_DATA_TO_FORM_DTDA_THEO_TIEUCHIUNGDUNG_NTM = 227;
	public static final int ACT_GET_DATA_TO_EDIT_DTDA_THEO_TIEUCHIUNGDUNG_NTM = 228;
	
	public static final int ACT_GET_DATA_OUT_TINTUCHOATDONG = 229;
	public static final int ACT_GET_DATA_OUT_GIOITHIEU_KQXDNTM = 230;
	public static final int ACT_GET_DATA_OUT_GIOITHIEU_KQNCDTDA = 231;
	public static final int ACT_GET_DATA_OUT_KETQUA_DANHGIA_HANGNAM = 232;
	public static final int ACT_GET_DATA_OUT_TIEUCHI_XD_NTM_CON = 233;
	public static final int ACT_GET_DATA_OUT_TIEUCHI_DETAI_DUAN = 234;
	public static final int ACT_GET_DATA_OUT_NHANSU_THAMGIA = 235;
	public static final int ACT_GET_DATA_OUT_DETAI_TOCHUC = 236;
	public static final int ACT_GET_DATA_OUT_KH_CAPKINHPHI = 237;
	public static final int ACT_GET_DATA_OUT_TD_CAPKINHPHI = 238;
	public static final int ACT_GET_DATA_OUT_NOIDUNG_CAPKINHPHI = 239;
	public static final int ACT_GET_DATA_OUT_NOIDUNG_THUYETMINH_CON = 240;
	public static final int ACT_GET_DATA_OUT_TIENDO_GIAINGAN = 241;
	
	public static final int ACT_GET_DATA_FORM_BANGBIEU_CAPKINHPHI = 242;
	
	
	
	
	
	
}


