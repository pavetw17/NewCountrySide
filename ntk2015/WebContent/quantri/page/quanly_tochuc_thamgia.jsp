<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Thuyết minh đề tài:</strong>
    <select name="dlg_tochuc_thamgia_TheLoai_detai" id="dlg_tochuc_thamgia_TheLoai_detai" ></select>
</div>
<table id="dlg_tochuc_thamgia_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_tochuc_thamgia_TheLoai_detai');
	    $('#dlg_tochuc_thamgia_TheLoai_detai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_tochuc_thamgia();
		  }else{
			 getval_quanly_tochuc_thamgia("id_thuyetminhdetai =" + this.value);
		  }
	    });
	});

  function getval_quanly_tochuc_thamgia(sel) {
	    try {
	        $('#dlg_tochuc_thamgia_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_TOCHUC_THAMGIA), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_tochuc_thamgia_detai',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_tochuc_thamgia_detai',
	          columns: [[
				{field: 'tentc', title: 'Tên tổ chức', width: 80, align: 'left', alignH: 'center',
					formatter:function(value,row){
						  return '<a href="#" onclick="onsubmenu_hienthi_tochuc_thamgia('+row.id_tochuc_thamgia_detai+');">'+value+'</a>';
					  	}
				},
				{field: 'masodt', title: 'Mã thuyết minh', width: 80, align: 'left', alignH: 'center'},
				{field: 'ten_vaitro', title: 'Vai trò', width: 80, align: 'left', alignH: 'center'},
				{field: 'so_canbo_dh_thamgia', title: 'Số cán bộ ĐH', width: 80, align: 'center', alignH: 'center'},
				{field: 'so_canbo_ths_thamgia', title: 'Số cán bộ ThS', width: 80, align: 'center', alignH: 'center'},
				{field: 'so_canbo_ts_thamgia', title: 'Số cán bộ TS', width: 80, align: 'center', alignH: 'center'}
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_tochuc_thamgia have dlg_tochuc_thamgia_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_tochuc_thamgia(){
    var datagrid_id = 'dlg_tochuc_thamgia_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.tieude + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_tochuc_thamgia', 'id_tochuc_thamgia_detai ='+row.id_tochuc_thamgia_detai);
      }
    });
  }

  function func_dlg_quanly_tochuc_thamgia() {
    try {
      $('#dlg_tochuc_thamgia_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_TOCHUC_THAMGIA), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_tochuc_thamgia_detai',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_tochuc_thamgia_detai',
        columns: [[
               	{field: 'tentc', title: 'Tên tổ chức', width: 80, align: 'left', alignH: 'center',
					formatter:function(value,row){
						  return '<a href="#" onclick="onsubmenu_hienthi_tochuc_thamgia('+row.id_tochuc_thamgia_detai+');">'+value+'</a>';
					  	}
				},
				{field: 'masodt', title: 'Mã thuyết minh', width: 80, align: 'left', alignH: 'center'},
   				{field: 'ten_vaitro', title: 'Vai trò', width: 80, align: 'left', alignH: 'center'},
				{field: 'so_canbo_dh_thamgia', title: 'Số cán bộ ĐH', width: 80, align: 'center', alignH: 'center'},
				{field: 'so_canbo_ths_thamgia', title: 'Số cán bộ ThS', width: 80, align: 'center', alignH: 'center'},
				{field: 'so_canbo_ts_thamgia', title: 'Số cán bộ TS', width: 80, align: 'center', alignH: 'center'}
   	          ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_tochuc_thamgia have dlg_tochuc_thamgia_show_datagrid: " + err);
    }

    try{
      $('#dlg_tochuc_thamgia_show').dialog({
        title: "Danh sách tổ chức ",
        modal: false, open: function () {
          $(this).dialog('widget').draggable('option', {containment: false});
        },
        height: 460,
        width: 920,
        collapsible: true,
        draggable: true,
        resizable: false,
        position:[260,100],
        buttons: {
          "Xoá": function () {
            func_deleteRow_DlgShow_tochuc_thamgia();
          },
          "Sửa": function () {
            loadHtml("dlg_tochuc_thamgia_them","./page/quanly_tochuc_thamgia_control.jsp", false);
            func_dlg_add_tochuc_thamgia(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_tochuc_thamgia_them","./page/quanly_tochuc_thamgia_control.jsp", false);
            func_dlg_add_tochuc_thamgia(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_tochuc_thamgia have dlg_tochuc_thamgia_show " + err);
    }
  }

  function onsubmenu_hienthi_tochuc_thamgia(id_tochuc_thamgia_detai){
		loadHtml("dlg_tochuc_thamgia_hienthi_show","./page/quanly_tochuc_thamgia_hienthi.jsp", false);
		func_dlg_tochuc_thamgia_hienthi(id_tochuc_thamgia_detai);
  }
</script>