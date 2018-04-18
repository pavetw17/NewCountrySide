<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
         
<div>
    <strong>Tổ chức</strong>
    <select name="dlg_tochuc_cbb" id="dlg_tochuc_cbb" ></select>
   
    <strong>Tìm nhân sự</strong>
    <input  id="dl_qlnhansu_findNS" style="margin-bottom: 13px; height: 24px" >
    <input TYPE="BUTTON" NAME="" VALUE="Tìm" style="margin-bottom: 5px; height: 24px"  onclick="findNS()">
</div>
<table id="dlg_nhansu_show_datagrid"></table>

<script>
	$(document).ready(function() {
        cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_tochuc_cbb');
	    $('#dlg_tochuc_cbb').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_nhansu_show();
		  }else{
			 getval_nhansu_show("id_tochuc=" + this.value);
		  }
	    });
	});

  function findNS(){
	  var tukhoa = document.getElementById("dl_qlnhansu_findNS").value;
       var cond = "hoten ilike '%"+ tukhoa.replace("'", " '' ") +"%'";
       //alert(cond);
       getval_nhansu_show(cond);
  }	
	
  function getval_nhansu_show(sel) {
	    try {
	        $('#dlg_nhansu_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_SHOW_NHANSU), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_nhansu',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_nhansu',
	          columns: [[
	            {field: 'hoten', title: 'Họ và tên', width: 80, align: 'left', alignH: 'center'},
	            {field: 'chucvu', title: 'Chức vụ', width: 80, align: 'center', alignH: 'center'},
	            {field: 'mobile', title: 'Điện thoại', width: 80, align: 'left', alignH: 'center',
	          	  /*  formatter:function(value,row){
	          		  return '<a href="#" onclick="onsubmenu_hienthi_vanban('+row.id_nhansu+');">'+value+'</a>';
	          	  }  */
	            },
	          ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_nhansu_show have dlg_nhansu_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_qlnhansu(){
    var datagrid_id = 'dlg_nhansu_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.hoten + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_nhansu', 'id_nhansu ='+row.id_nhansu);
      }
    });
  }

  function func_dlg_nhansu_show() {
    try {
      $('#dlg_nhansu_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_SHOW_NHANSU), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_nhansu',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_nhansu',
        columns: [[
          {field: 'hoten', title: 'Họ và tên', width: 80, align: 'left', alignH: 'center',
        	/*   formatter:function(value,row){
       		  return '<a href="#" onclick="onsubmenu_hienthi_vanban('+row.id_nhansu+');">'+value+'</a>';
       	  }    */
          },
          {field: 'chucvu', title: 'Chức vụ', width: 80, align: 'center', alignH: 'center'},
          {field: 'gioitinh', title: 'Giới tính', width: 80, align: 'center', alignH: 'center'},
          {field: 'mobile', title: 'Điện thoại', width: 80, align: 'left', alignH: 'center'},
        ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_nhansu_show have dlg_nhansu_show_datagrid: " + err);
    }

    try{
      $('#dlg_nhansu_show').dialog({
        title: "Danh sách nhân sự",
        modal: false, open: function () {
          $(this).dialog('widget').draggable('option', {containment: false});
        },
        height: 450,
        width: 920,
        collapsible: true,
        draggable: true,
        resizable: false,
        position:[260,150],
        buttons: {
          "Xoá": function () {
            func_deleteRow_DlgShow_qlnhansu();
          },
          "Sửa": function () {
            loadHtml("dlg_nhansu_them","./page/quanly_nhansu_control.jsp", false);
            func_dlg_add_nhansu(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_nhansu_them","./page/quanly_nhansu_control.jsp", false);
            func_dlg_add_nhansu(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_nhansu_show have dlg_qlnhansu_show " + err);
    }
  }

  function onsubmenu_hienthi_vanban(id_nhansu){
		loadHtml("dlg_qlnhansu_hienthi_show","./page/quanly_nhansu_hienthi.jsp", false);
		func_dlg_qlnhansu_hienthi(id_nhansu);
  }
</script>