<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Đề tài:</strong>
    <select name="dlg_hinhanh_thumuc_TheLoai_DeTai" id="dlg_hinhanh_thumuc_TheLoai_DeTai" ></select>
</div>
<table id="dlg_hinhanh_thumuc_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DUAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_hinhanh_thumuc_TheLoai_DeTai');
	    $('#dlg_hinhanh_thumuc_TheLoai_DeTai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_hinhanh_thumuc();
		  }else{
			 getval_quanly_hinhanh_thumuc("id_detai =" + this.value);
		  }
	    });
	});

  function getval_quanly_hinhanh_thumuc(sel) {
	    try {
	        $('#dlg_hinhanh_thumuc_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_THUMUC), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_folder',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_folder',
	          columns: [[
					{field: 'foldername', title: 'Tên thư mục', width: 80, align: 'left', alignH: 'center'},
					{field: 'type_media', title: 'Loại', width: 80, align: 'left', alignH: 'center',
						formatter:function(value,row){    
							if (row.type_media == '0')	return 'Băng hình';
							else return 'Hình ảnh';
                    	} 
						
					},
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_hinhanh_thumuc have dlg_hinhanh_thumuc_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_hinhanh_thumuc(){
    var datagrid_id = 'dlg_hinhanh_thumuc_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_folder + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_picture_folder', ' id_folder='+row.id_folder);
      }
    });
  }

  function func_dlg_quanly_hinhanh_thumuc() {
    try {
      $('#dlg_hinhanh_thumuc_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_THUMUC), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_folder',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_folder',
        columns: [[
					{field: 'foldername', title: 'Tên thư mục', width: 80, align: 'left', alignH: 'center'},
					{field: 'type_media', title: 'Loại', width: 80, align: 'left', alignH: 'center',
						formatter:function(value,row){    
							if (row.type_media == '0')	return 'Băng hình';
							else return 'Hình ảnh';
                    	}    
					},
   	          ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_hinhanh_thumuc have dlg_hinhanh_thumuc_show_datagrid: " + err);
    }

    try{
      $('#dlg_hinhanh_thumuc_show').dialog({
        title: "Danh sách thư mục ",
        modal: false, open: function () {
          $(this).dialog('widget').draggable('option', {containment: false});
        },
        height: 460,
        width: 920,
        collapsible: true,
        draggable: true,
        resizable: false,
        position:[230,80],
        buttons: {
          "Xoá": function () {
            func_deleteRow_DlgShow_hinhanh_thumuc();
          },
          "Sửa": function () {
            loadHtml("dlg_hinhanh_thumuc_them","./page/quanly_hinhanh_thumuc_control.jsp", false);
            func_dlg_add_hinhanh_thumuc(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_hinhanh_thumuc_them","./page/quanly_hinhanh_thumuc_control.jsp", false);
            func_dlg_add_hinhanh_thumuc(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_hinhanh_thumuc have dlg_hinhanh_thumuc_show " + err);
    }
  }

  function onsubmenu_hienthi_hinhanh_thumuc(id_kh_capkinhph){
		loadHtml("dlg_hinhanh_thumuc_hienthi_show","./page/quanly_hinhanh_thumuc_hienthi.jsp", false);
		func_dlg_hinhanh_thumuc_hienthi(id_folder);
  }
</script>