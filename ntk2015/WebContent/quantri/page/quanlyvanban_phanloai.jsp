<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
  function func_deleteRow_DlgShow_qlvanban_phanloai(){
    var datagrid_id = 'dlg_qlvanban_phanloai_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.loai_vanbanphaply + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_phanloai_vanban', 'id_phanloai ='+row.id_phanloai);
      }
    });
  }

  function func_dlg_qlvanban_phanloai_show() {
    try {
      $('#dlg_qlvanban_phanloai_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_SHOW_DS_PHANLOAIVANBAN),
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_phanloai',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_phanloai',
        columns: [[
          {field: 'loai_vanbanphaply', title: 'Tên loại văn bản', width: 80, align: 'left', alignH: 'center'},

        ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {

        }
      });
    } catch (err) {
      alert("func_dlg_qlvanban_phanloai_show have dlg_qlvanban_phanloai_show_datagrid: " + err);
    }

    try{
      $('#dlg_qlvanban_phanloai_show').dialog({
        title: "Danh sách phân loại văn bản ",
        modal: false, open: function () {
          $(this).dialog('widget').draggable('option', {containment: false});
        },
        height: 430,
        width: 920,
        collapsible: true,
        draggable: true,
        resizable: false,
        position:[230,150],
        buttons: {
          "Xoá": function () {
            func_deleteRow_DlgShow_qlvanban_phanloai();
          },
          "Sửa": function () {
            loadHtml("dlg_qlvanban_phanloai_them","./page/quanlyvanban_phanloai_control.jsp", false);
            func_dlg_add_qlvanban_phanloai(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_qlvanban_phanloai_them","./page/quanlyvanban_phanloai_control.jsp", false);
            func_dlg_add_qlvanban_phanloai(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_qlvanban_phanloai_show have dlg_qlvanban_phanloai_show " + err);
    }
  }
</script>

<div>
  <table id="dlg_qlvanban_phanloai_show_datagrid"></table>
</div>