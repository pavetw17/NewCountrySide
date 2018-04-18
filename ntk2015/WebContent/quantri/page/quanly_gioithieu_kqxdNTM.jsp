<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Phân loại xã điểm</strong>
    <select name="dlg_gioithieu_kqxdNTM_TheLoai_phanloai" id="dlg_gioithieu_kqxdNTM_TheLoai_phanloai" ></select>
    <strong>Tìm bài viết:</strong>
    <input  id="dl_gioithieu_kqxdNTM_findVB" style="margin-bottom: 13px; height: 24px" >
    <input TYPE="BUTTON" NAME="" VALUE="Tìm" style="margin-bottom: 13px; height: 24px"  onclick="find_gioithieu_kqxdNTM()">
</div>
<table id="dlg_gioithieu_kqxdNTM_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_XADIEM_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_gioithieu_kqxdNTM_TheLoai_phanloai');
	    $('#dlg_gioithieu_kqxdNTM_TheLoai_phanloai').on('change', function() {
	      if(this.value == -1){
	    	  func_dlg_quanly_gioithieu_kqxdNTM();
		  }else{
			 getval_gioithieu_kqxdNTM_show("id_xadiem=" + this.value);
		  }
	    });
	});

  function find_gioithieu_kqxdNTM(){
	  var tukhoa = document.getElementById("dl_gioithieu_kqxdNTM_findVB").value;
       var cond = "tentieude ilike '%"+ tukhoa.replace("'", " '' ") +"%' or tomtatnoidung ilike '%" + tukhoa.replace("'", " '' ") +"%'";
       //alert(cond);
       getval_gioithieu_kqxdNTM_show(cond);
  }	
	
  function getval_gioithieu_kqxdNTM_show(sel) {
	    try {
	        $('#dlg_gioithieu_kqxdNTM_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_BAIVIET_GIOITHIEU_NTM), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_baiviet',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_baiviet',
	          columns: [[
	            {field: 'tentieude', title: 'Tiêu đề', width: 80, align: 'left', alignH: 'center',
	            	formatter:function(value,row){
		          		  return '<a href="#" onclick="onsubmenu_hienthi_kqxdNTM('+row.id_baiviet+');">'+value+'</a>';
		          	  } 
	            },
	            {field: 'ngaycongbo', title: 'Ngày tạo', width: 80, align: 'center', alignH: 'center',
	          	  formatter:function(value,row){
	            		  return gm.date.Int2DateString(row.ngaycongbo);
	            	  } 
	            },
	            {field: 'tinhtrang', title: 'Tình trạng', width: 80, align: 'left', alignH: 'center',
	            },
	          ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_gioithieu_kqxdNTM_show have dlg_gioithieu_kqxdNTM_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_gioithieu_kqxdNTM(){
    var datagrid_id = 'dlg_gioithieu_kqxdNTM_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.tentieude + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_baiviet', 'id_baiviet ='+row.id_baiviet);
      }
    });
  }

  function func_dlg_quanly_gioithieu_kqxdNTM() {
    try {
      $('#dlg_gioithieu_kqxdNTM_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_BAIVIET_GIOITHIEU_NTM), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_baiviet',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_baiviet',
        columns: [[
          {field: 'tentieude', title: 'Tiêu đề', width: 80, align: 'left', alignH: 'center',
        	  formatter:function(value,row){
          		  return '<a href="#" onclick="onsubmenu_hienthi_kqxdNTM('+row.id_baiviet+');">'+value+'</a>';
          	  }  
          },
          {field: 'ngaycongbo', title: 'Ngày tạo', width: 80, align: 'center', alignH: 'center',
        	  formatter:function(value,row){
          		  return gm.date.Int2DateString(row.ngaycongbo);
          	  } 
          },
          {field: 'tinhtrang', title: 'Tình trạng', width: 80, align: 'left', alignH: 'center',
        	   
          },
        ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_gioithieu_kqxdNTM_show have dlg_gioithieu_kqxdNTM_show_datagrid: " + err);
    }

    try{
      $('#dlg_gioithieu_kqxdNTM_show').dialog({
        title: "Danh sách bài viết giới thiệu NTM ",
        modal: false, open: function () {
          $(this).dialog('widget').draggable('option', {containment: false});
        },
        height: 480,
        width: 920,
        collapsible: true,
        draggable: true,
        resizable: false,
        position:[260,150],
        buttons: {
          "Xoá": function () {
            func_deleteRow_DlgShow_gioithieu_kqxdNTM();
          },
          "Sửa": function () {
            loadHtml("dlg_gioithieu_kqxdNTM_them","./page/quanly_gioithieu_kqxdNTM_control.jsp", false);
            func_dlg_add_gioithieu_kqxdNTM(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_gioithieu_kqxdNTM_them","./page/quanly_gioithieu_kqxdNTM_control.jsp", false);
            func_dlg_add_gioithieu_kqxdNTM(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_gioithieu_kqxdNTM_show have dlg_gioithieu_kqxdNTM_show " + err);
    }
  }

  function onsubmenu_hienthi_kqxdNTM(id_baiviet){
		loadHtml("dlg_gioithieu_kqxdNTM_hienthi_show","./page/quanly_gioithieu_kqxdNTM_hienthi.jsp", false);
		func_dlg_gioithieu_kqxdNTM_hienthi(id_baiviet);
  }
</script>