<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Loại phiếu:</strong>
    <select name="dlg_phieu_TheLoai_Phieu" id="dlg_phieu_TheLoai_Phieu" ></select>
</div>
<table id="dlg_phieu_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_PHANLOAI_PHIEU_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_phieu_TheLoai_Phieu');
	    $('#dlg_phieu_TheLoai_Phieu').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_phieu();
		  }else{
			 getval_quanly_phieu("id_phanloaiphieu =" + this.value);
		  }
	    });
	});

  function getval_quanly_phieu(sel) {
	    try {
	        $('#dlg_phieu_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_PHIEU), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_phieu',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_phieu',
	          columns: [[
	                 	{field: 'tenphieu', title: 'Tên phiếu', width: 80, align: 'left', alignH: 'center',
	    					formatter:function(value,row){
	    						  return '<a href="#" onclick="onsubmenu_hienthi_phieu('+row.id_phieu+');">'+value+'</a>';
	    					  	}
	    				},
	    				{field: 'masodt', title: 'Mã thuyết minh', width: 80, align: 'left', alignH: 'center'},
	       				{field: 'hoten', title: 'Họ tên chuyên gia', width: 80, align: 'left', alignH: 'center'},
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_phieu have dlg_phieu_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_phieu(){
    var datagrid_id = 'dlg_phieu_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.tieude + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_phieu', 'id_phieu ='+row.id_phieu);
      }
    });
  }

  function func_dlg_quanly_phieu() {
    try {
      $('#dlg_phieu_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_PHIEU), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_phieu',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_phieu',
        columns: [[
               	{field: 'tenphieu', title: 'Tên phiếu', width: 80, align: 'left', alignH: 'center',
					formatter:function(value,row){
						  return '<a href="#" onclick="onsubmenu_hienthi_phieu('+row.id_phieu+');">'+value+'</a>';
					  	}
				},
				{field: 'masodt', title: 'Mã thuyết minh', width: 80, align: 'left', alignH: 'center'},
   				{field: 'hoten', title: 'Họ tên chuyên gia', width: 80, align: 'left', alignH: 'center'},
   	          ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_phieu have dlg_phieu_show_datagrid: " + err);
    }

    try{
      $('#dlg_phieu_show').dialog({
        title: "Danh sách phiếu",
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
            func_deleteRow_DlgShow_phieu();
          },
          "Sửa": function () {
            loadHtml("dlg_phieu_them","./page/quanly_phieu_control.jsp", false);
            func_dlg_add_phieu(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_phieu_them","./page/quanly_phieu_control.jsp", false);
            func_dlg_add_phieu(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_phieu have dlg_phieu_show " + err);
    }
  }

  function onsubmenu_hienthi_phieu(id_phieu){
		loadHtml("dlg_phieu_hienthi_show","./page/quanly_phieu_hienthi.jsp", false);
		func_dlg_phieu_hienthi(id_phieu);
  }
</script>