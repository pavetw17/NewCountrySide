<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Thư mục:</strong>
    <select name="dlg_banghinh_kqxdNTM_TheLoai_Folder" id="dlg_banghinh_kqxdNTM_TheLoai_Folder" ></select>
</div>
<table id="dlg_banghinh_kqxdNTM_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_FOLDER_HINHANH_DETAI_TO_CBB, 'type_media = 0', TYPE_DATA_HTML_CBB,'*', 'dlg_banghinh_kqxdNTM_TheLoai_Folder');
	    $('#dlg_banghinh_kqxdNTM_TheLoai_Folder').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_banghinh_kqxdNTM();
		  }else{
			 getval_kqxdNTM("id_folder =" + this.value + " and type_media = 0 ");
		  }
	    });
	});

  function getval_kqxdNTM(sel) {
	    try {
	        $('#dlg_banghinh_kqxdNTM_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_UPLOAD_BANGHINH_NTM), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_picture',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_picture',
	          columns: [[
					{field: 'tenanh', title: 'Tên băng hình', width: 70, align: 'left', alignH: 'center'},
					{field: 'pathfile', title: 'Đường dẫn', width: 100, align: 'left', alignH: 'center'},
					{field: 'ten_xadiem', title: 'Xã điểm', width: 100, align: 'left', alignH: 'center'},
			 ]],
	          pagination: true,
	          rownumbers: false,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_banghinh_kqxdNTM have dlg_banghinh_kqxdNTM_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_banghinh_kqxdNTM(){
    var datagrid_id = 'dlg_banghinh_kqxdNTM_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_picture + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_picture', ' id_picture='+row.id_picture);
      }
    });
  }

  function func_dlg_quanly_banghinh_kqxdNTM() {
    try {
      $('#dlg_banghinh_kqxdNTM_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_UPLOAD_BANGHINH_NTM), 
        queryParams:{
          total: -1,
          records: 0,
          condition: " type_media = 0 "
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_picture',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_picture',
        columns: [[
					{field: 'tenanh', title: 'Tên băng hình', width: 70, align: 'left', alignH: 'center'},
					{field: 'pathfile', title: 'Đường dẫn', width: 100, align: 'left', alignH: 'center'},
					{field: 'ten_xadiem', title: 'Xã điểm', width: 100, align: 'left', alignH: 'center'},
				]],
        pagination: true,
        rownumbers: false,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_banghinh_kqxdNTM have dlg_banghinh_kqxdNTM_show_datagrid: " + err);
    }

    try{
      $('#dlg_banghinh_kqxdNTM_show').dialog({
        title: "Danh sách băng hình kết quả xây dựng NTM ",
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
            func_deleteRow_DlgShow_banghinh_kqxdNTM();
          },
          "Upload": function () {
            loadHtml("dlg_banghinh_kqxdNTM_them","./page/quanly_banghinh_kqxdNTM_control.jsp", false);
            func_dlg_add_banghinh_kqxdNTM(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_banghinh_kqxdNTM have dlg_banghinh_kqxdNTM_show " + err);
    }
  }

  function onsubmenu_hienthi_banghinh_kqxdNTM(id_kh_capkinhph){
		loadHtml("dlg_banghinh_kqxdNTM_hienthi_show","./page/quanly_banghinh_kqxdNTM_hienthi.jsp", false);
		func_dlg_banghinh_kqxdNTM_hienthi(id_picture);
  }
</script>