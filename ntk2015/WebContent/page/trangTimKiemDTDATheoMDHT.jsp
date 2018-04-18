<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
         
<div style="padding: 10px 0 0 15px">

    <span style="color: #B5250A;
  font: bold 15px Verdana,Arial,sans-serif;
  margin: 0;
  text-decoration: underline;
  text-transform: uppercase;
  margin-bottom: 12px;" >Tìm kiếm theo sản phẩm</span>
<br><br>
    <strong>Nhóm đề tài</strong>
    <select name="dlg_detai_duan_MDHT_cbb" id="dlg_detai_duan_MDHT_cbb" ></select>
    <br><br>
     <strong>Tình trạng</strong>
    <select name="dlg_detai_duan_MDHT_tinhtrang_cbb" id="dlg_detai_duan_MDHT_tinhtrang_cbb" >
    		<option value="-1">Tất cả</option>
    		<option value="0">Được phê duyệt</option>
    		<option value="1">Đang thực hiện</option>
    		<option value="2">Đã nghiệm thu</option>
    
    </select>
   
   
    <a class="btn_tim" onclick="findDT_theodieukien();" href="javascript:;"> Tìm </a>
    <br><br>
    <strong>Tìm đề tài</strong>
    <input  id="dl_detai_duan_MDHT_find" style="margin-bottom: 13px; height: 24px" >
    <a class="btn_tim" onclick="findDT();" href="javascript:;"> Tìm theo tên </a>
	<table id="dlg_detai_duan_MDHT_show_datagrid"></table>
	
	<br>
    <input TYPE="BUTTON" NAME="" VALUE="Phân loại theo mức độ hoàn thành" style="margin-bottom: 5px; height: 24px"  onclick="phanloaiMDHT_func()">
	<br><br>
    <strong><span id="span_tmdt"></span></strong>
	<table id="dlg_detai_duan_PhanLoai_TMDT_show_datagrid"></table>
	<span id="span_btn"></span>
	<br><br>
    <strong><span id="span_sp"></span></strong>
	<table id="dlg_detai_duan_PhanLoai_SanPham_show_datagrid"></table>
	<br>
	<strong><span id="span_cccs"></span></strong>
	<table id="dlg_detai_duan_PhanLoai_CoCheChinhSach_show_datagrid"></table>
	<br>
	<strong><span id="span_gpkhcn"></span></strong>
	<table id="dlg_detai_duan_PhanLoai_GiaiPhapKHCN_show_datagrid"></table>
	<br>
	<strong><span id="span_pbvthm"></span></strong>
	<table id="dlg_detai_duan_PhanLoai_PhanBoVonTheoHangMuc_show_datagrid"></table>
	<br>
</div>

<script>
    var id_phannhom;
  
	$(document).ready(function() {
        cwrs_Data2ComboBox( HOME_SERVLET, ACT_GET_NHOM_DETAI_DUAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'Tất cả', 'dlg_detai_duan_MDHT_cbb');
	   
	});
	
	
	var id_detai_luu;
	function phanloaiMDHT_func(){
		var row = $('#dlg_detai_duan_MDHT_show_datagrid').datagrid('getSelected');
		if (row){
			$('#span_tmdt').text('Danh sách thuyết minh đề tài dự án');
		    func_dlg_detai_duan_PhanLoai_TMDT_show(" id_detai =" + row.id_detai);
		    $('#span_btn').html('<br><input TYPE="BUTTON" NAME="" VALUE="Chọn thuyết minh đề tài dự án" style="margin-bottom: 5px; height: 24px"  onclick="phanloaiTMDT_func()">');
			id_detai_luu = row.id_detai;
		}
	}
	
	function phanloaiTMDT_func(){
		var row = $('#dlg_detai_duan_PhanLoai_TMDT_show_datagrid').datagrid('getSelected');
		if (row){
			$('#span_sp').text('Danh sách sản phẩm');
			func_dlg_detai_duan_PhanLoai_SP_show(" id_thuyetminh_detai =" + row.id_thuyetminh_detai_duan);
			$('#span_cccs').text('Danh sách cơ chế chính sách');
			func_dlg_detai_duan_PhanLoai_CCCS_show(" id_detai=" + id_detai_luu + " and id_thuyetminh_detai =" + row.id_thuyetminh_detai_duan   );
			$('#span_gpkhcn').text('Danh sách giải pháp KHCN');
			func_dlg_quanly_giaiphap_khcn(" id_detai=" + id_detai_luu + " and id_thuyetminh_detai=" + row.id_thuyetminh_detai_duan  );
			$('#span_pbvthm').text('Danh sách phân bổ vốn theo hạng mục');
			func_dlg_quanly_phanvon_hangmuc(" id_detai=" + id_detai_luu + " and id_thuyetminhdetai=" + row.id_thuyetminh_detai_duan  );
		}
	}
	
	
	  function findDT_theodieukien(){
	
	      id_phannhom = $('#dlg_detai_duan_MDHT_cbb').val();
	      var id_tinhtrang =  $('#dlg_detai_duan_MDHT_tinhtrang_cbb').val();
	      
	      if(id_phannhom == -1){
	    	  if(id_tinhtrang == -1){
	    		  getval_detai_duan_MDHT_show();
	    	  }else{
	    		  getval_detai_duan_MDHT_show("tinhtrang=" + id_tinhtrang  );
	    	  }
	      }else{
	    	  if(id_tinhtrang == -1){
	    		  getval_detai_duan_MDHT_show( "id_phannhom_detai_duan=" + id_phannhom  );
	    	  }else{
	    		  getval_detai_duan_MDHT_show("id_phannhom_detai_duan=" + id_phannhom + "and tinhtrang=" + id_tinhtrang  );
	    	  }
	      }
	  } 	
	

  function findDT(){
	  var tukhoa = document.getElementById("dl_detai_duan_MDHT_find").value;
       var cond = "tendt ilike '%"+ tukhoa.replace("'", " '' ") +"%'";
       //alert(cond);
       getval_detai_duan_MDHT_show(cond);
  }	
  
  
	
  function getval_detai_duan_MDHT_show(sel) {
	    try {
	        $('#dlg_detai_duan_MDHT_show_datagrid').datagrid({
	          width: 500,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:(  HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_DETAI_DUAN), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_detai',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_detai',
	          columns: [[
	                     {field: 'tendt', title: 'Tên đề tài', width: 80, align: 'left', alignH: 'center',
	                   	  formatter:function(value,row){
	                  		  return '<a href="#" onclick="onsubmenu_hienthi_vanban('+row.id_detai+');">'+value+'</a>';
	                  	  }   
	                     },
	                     {field: 'linhvuckh', title: 'Lĩnh vực', width: 80, align: 'center', alignH: 'center'},
	                     {field: 'tgthuchien', title: 'Thời gian', width: 80, align: 'center', alignH: 'center'},
	                     {field: 'kinhphi', title: 'Kinh phí', width: 80, align: 'left', alignH: 'center'},
	          ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_detai_duan_MDHT_show have dlg_detai_duan_MDHT_show_datagrid: " + err);
	      }
  }

  function func_dlg_detai_duan_MDHT_show() {
    try {
      $('#dlg_detai_duan_MDHT_show_datagrid').datagrid({
        width: 500,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:(  HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_DETAI_DUAN),  
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_detai',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_detai',
        columns: [[
          {field: 'tendt', title: 'Tên đề tài', width: 80, align: 'left', alignH: 'center',
        	  formatter:function(value,row){
       		  return '<a href="#" onclick="onsubmenu_hienthi_vanban('+row.id_detai+');">'+value+'</a>';
       	  }   
          },
          {field: 'linhvuckh', title: 'Lĩnh vực', width: 80, align: 'center', alignH: 'center'},
          {field: 'tgthuchien', title: 'Thời gian', width: 80, align: 'center', alignH: 'center'},
          {field: 'kinhphi', title: 'Kinh phí', width: 80, align: 'left', alignH: 'center'},
        ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_detai_duan_MDHT_show have dlg_detai_duan_MDHT_show_datagrid: " + err);
    }
  }

  
  function func_dlg_detai_duan_PhanLoai_TMDT_show(sel) {
	    try {
	      $('#dlg_detai_duan_PhanLoai_TMDT_show_datagrid').datagrid({
	        width: 500,
	        height: 300,
	        nowrap: false,
	        striped: true,
	        fitColumns: true,
	        singleSelect: true,
	        collapsible: true,
	        url:(  HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_THUYETMINH_DETAI),  
	        queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	        loadMsg: MSG_WAIT_LOADING,
	        sortName: 'id_thuyetminh_detai_duan',
	        sortOrder: 'asc',
	        remoteSort: false,
	        idField:'id_thuyetminh_detai_duan',
	        columns: [[
	                   {field: 'masodt', title: 'Mã đề tài', width: 80, align: 'left', alignH: 'center',
		                   	  formatter:function(value,row){
		                  		  return '<a href="#" onclick="onsubmenu_hienthi_tmdt('+row.id_thuyetminh_detai_duan+');">'+value+'</a>';
		                  	  }   
		               },
                     {field: 'muctieu_detai', title: 'Mục tiêu', width: 80, align: 'center', alignH: 'center'},
                     {field: 'ngaybatdau', title: 'Thời gian', width: 80, align: 'center', alignH: 'center',
                    	 formatter:function(value,row){
	                  		  return gm.date.Int2DateString(row.ngaybatdau);
	                  	  } 
                     },
                     {field: 'tinhtrangdt', title: 'Kinh phí', width: 80, align: 'left', alignH: 'center'},
	        ]],
	        pagination: true,
	        rownumbers: true,
	        onLoadSuccess: function (data) {
	        }
	      });
	    } catch (err) {
	      alert("dlg_detai_duan_PhanLoai_SanPham_show_datagrid have dlg_detai_duan_PhanLoai_SanPham_show_datagrid: " + err);
	    }
	  }
  
  function func_dlg_detai_duan_PhanLoai_SP_show(sel) {
	    try {
	      $('#dlg_detai_duan_PhanLoai_SanPham_show_datagrid').datagrid({
	        width: 500,
	        height: 300,
	        nowrap: false,
	        striped: true,
	        fitColumns: true,
	        singleSelect: true,
	        collapsible: true,
	        url:(  HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_SANPHAM),  
	        queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	        loadMsg: MSG_WAIT_LOADING,
	        sortName: 'id_sanpham',
	        sortOrder: 'asc',
	        remoteSort: false,
	        idField:'id_sanpham',
	        columns: [[
	                 	{field: 'tensanpham', title: 'Tên sản phẩm', width: 80, align: 'left', alignH: 'center',
	    					formatter:function(value,row){
	    						  return '<a href="#" onclick="onsubmenu_hienthi_sanpham('+row.id_sanpham+');">'+value+'</a>';
	    					  	}
	    				},
	    				{field: 'chitieuchatluong', title: 'Chỉ tiêu chất lượng', width: 80, align: 'left', alignH: 'center'},
	    				{field: 'donvido', title: 'Đơn vị đo', width: 80, align: 'left', alignH: 'center'}
			 ]],
	        pagination: true,
	        rownumbers: true,
	        onLoadSuccess: function (data) {
	        }
	      });
	    } catch (err) {
	      alert("dlg_detai_duan_PhanLoai_SanPham_show_datagrid have dlg_detai_duan_PhanLoai_SanPham_show_datagrid: " + err);
	    }
	  }
  
  function func_dlg_detai_duan_PhanLoai_CCCS_show(sel) {
	    try {
	      $('#dlg_detai_duan_PhanLoai_CoCheChinhSach_show_datagrid').datagrid({
	        width: 500,
	        height: 300,
	        nowrap: false,
	        striped: true,
	        fitColumns: true,
	        singleSelect: true,
	        collapsible: true,
	        url:(  HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_COCHE_CHINHSACH), 
	        queryParams:{
	          total: -1,
	          records: 0,
	          condition: sel
	        },
	        loadMsg: MSG_WAIT_LOADING,
	        sortName: 'id_coche_chinhsach',
	        sortOrder: 'asc',
	        remoteSort: false,
	        idField:'id_coche_chinhsach',
	        columns: [[
						{field: 'ten_coche_chinhsach', title: 'Tên cơ chế', width: 80, align: 'left', alignH: 'center',
							formatter:function(value,row){
	    						  return '<a href="#" onclick="onsubmenu_hienthi_cccs('+row.id_coche_chinhsach+');">'+value+'</a>';
	    					  	}	
						},
						{field: 'noidung_coche_chinhsach', title: 'Nội dung', width: 80, align: 'left', alignH: 'center'},
						{field: 'maso_coche_chinhsach', title: 'Mã số', width: 80, align: 'left', alignH: 'center',
						},
	   	          ]],
	        pagination: true,
	        rownumbers: true,
	        onLoadSuccess: function (data) {
	        }
	      });
	    } catch (err) {
	      alert("func_dlg_detai_duan_PhanLoai_CCCS_show have dlg_detai_duan_PhanLoai_CoCheChinhSach_show_datagrid: " + err);
	    }
  }
  
  function func_dlg_quanly_giaiphap_khcn(sel) {
	    try {
	      $('#dlg_detai_duan_PhanLoai_GiaiPhapKHCN_show_datagrid').datagrid({
	        width: 500,
	        height: 300,
	        nowrap: false,
	        striped: true,
	        fitColumns: true,
	        singleSelect: true,
	        collapsible: true,
	        url:( HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_GIAIPHAP_KHCN), 
	        queryParams:{
	          total: -1,
	          records: 0,
	          condition: sel
	        },
	        loadMsg: MSG_WAIT_LOADING,
	        sortName: 'id_giaiphap_khcn',
	        sortOrder: 'asc',
	        remoteSort: false,
	        idField:'id_giaiphap_khcn',
	        columns: [[
						{field: 'ten_giaiphap_khcn', title: 'Tên giải pháp', width: 80, align: 'left', alignH: 'center',
							formatter:function(value,row){
	    						  return '<a href="#" onclick="onsubmenu_hienthi_giaiphap_khcn('+row.id_giaiphap_khcn+');">'+value+'</a>';
	    					  	}	
						},
						{field: 'noidung_giaiphap_khcn', title: 'Nội dung', width: 80, align: 'left', alignH: 'center'},
						{field: 'quytrinh_thuc_hien', title: 'Quy trình', width: 80, align: 'left', alignH: 'center',
						},
	   	          ]],
	        pagination: true,
	        rownumbers: true,
	        onLoadSuccess: function (data) {
	        }
	      });
	    } catch (err) {
	      alert("func_dlg_quanly_giaiphap_khcn have dlg_giaiphap_khcn_show_datagrid: " + err);
	    }
  }
  
  
  function func_dlg_quanly_phanvon_hangmuc(sel) {
	    try {
	      $('#dlg_detai_duan_PhanLoai_PhanBoVonTheoHangMuc_show_datagrid').datagrid({
	        width: 500,
	        height: 300,
	        nowrap: false,
	        striped: true,
	        fitColumns: true,
	        singleSelect: true,
	        collapsible: true,
	        url:( HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_PHANBOVON_THEOHANGMUC), 
	        queryParams:{
	          total: -1,
	          records: 0,
	          condition: sel
	        },
	        loadMsg: MSG_WAIT_LOADING,
	        sortName: 'id_tieuchi',
	        sortOrder: 'asc',
	        remoteSort: false,
	        idField:'id_tieuchi',
	        columns: [[
	                	{field: 'tentc', title: 'Tên tổ chức', width: 80, align: 'left', alignH: 'center',
	                		formatter:function(value,row){
	    						  return '<a href="#" onclick="onsubmenu_hienthi_phanbovon('+row.id_tieuchi+');">'+value+'</a>';
	    					  	}	
	                	},
	                 	{field: 'tenfile', title: 'Tên file', width: 80, align: 'left', alignH: 'center'},
	                 	{field: 'tukhoa', title: 'Từ khóa', width: 80, align: 'left', alignH: 'center'},
			 ]],
	        pagination: true,
	        rownumbers: true,
	        onLoadSuccess: function (data) {
	        }
	      });
	    } catch (err) {
	      alert("func_dlg_quanly_phanvon_hangmuc have dlg_phanvon_hangmuc_show_datagrid: " + err);
	    }
  }
	    
  function onsubmenu_hienthi_vanban(id_detai){
		loadHtml("dlg_timkiem_dtda_sp_hienthi_show","./page/trangTimKiemDTDATheoSP_hienthi.jsp", false);
		window.scrollTo(400, 0);
		func_dlg_timkiem_dtda_sp_hienthi(id_detai);
	}
  
  function onsubmenu_hienthi_tmdt(id_thuyetminh_detai_duan){
		loadHtml("dlg_timkiem_dtda_sp_hienthi_show","./page/trangTimKiemDTDATheoMDHT_TMDT_hienthi.jsp", false);
		window.scrollTo(400, 0);
		func_dlg_timkiem_dtda_tmdt_hienthi(id_thuyetminh_detai_duan);
	}
  
  function onsubmenu_hienthi_sanpham(id_sanpham){
		loadHtml("dlg_timkiem_dtda_sp_hienthi_show","./page/trangTimKiemDTDATheoMDHT_SP_hienthi.jsp", false);
		window.scrollTo(400, 0);
		func_dlg_sanpham_hienthi(id_sanpham);
	}
  
  function onsubmenu_hienthi_cccs(id_coche_chinhsach){
		loadHtml("dlg_timkiem_dtda_sp_hienthi_show","./page/trangTimKiemDTDATheoMDHT_CCCS_hienthi.jsp", false);
		window.scrollTo(400, 0);
		func_dlg_cochechinhsach_hienthi(id_coche_chinhsach);
	}
  
  function onsubmenu_hienthi_giaiphap_khcn(id_giaiphap_khcn){
		loadHtml("dlg_timkiem_dtda_sp_hienthi_show","./page/trangTimKiemDTDATheoMDHT_GP_KHCN_hienthi.jsp", false);
		window.scrollTo(400, 0);
		func_dlg_giaiphap_khcn_hienthi(id_giaiphap_khcn);
	}
  
  function onsubmenu_hienthi_phanbovon(id_tieuchi){
		loadHtml("dlg_timkiem_dtda_sp_hienthi_show","./page/trangTimKiemDTDATheoMDHT_PBV_hienthi.jsp", false);
		window.scrollTo(400, 0);
		func_dlg_phanbovon_hienthi(id_tieuchi);
	}
  
  
</script>