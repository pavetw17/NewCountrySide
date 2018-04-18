<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
    <strong>Tìm ý kiến chỉ đạo</strong>
    <input  id="dl_ykienchidao_find" style="margin-bottom: 5px;margin-top: 10px; height: 24px" >
    <input TYPE="BUTTON" NAME="" VALUE="Tìm" style="margin-bottom: 5px;margin-top: 10px; height: 24px"  onclick="find_qlvb()">
</div>
<table id="dlg_qlvanban_ykienchidao_show_datagrid"></table>

<script>

  function func_deleteRow_DlgShow_qlvanban_ykienchidao(){
    var datagrid_id = 'dlg_qlvanban_ykienchidao_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.loai_vanbanykienchidao + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_ykienchidao', 'id_ykienchidao ='+row.id_ykienchidao);
      }
    });
  }
  
  function find_qlvb() {
	  var tukhoa = document.getElementById("dl_ykienchidao_find").value;
      var cond = "sokihieu ilike '%"+ tukhoa.replace("'", " '' ") +"%' or tieude ilike '%" + tukhoa.replace("'", " '' ") +"%'";
	    try {
	      $('#dlg_qlvanban_ykienchidao_show_datagrid').datagrid({
	        width: 880,
	        height: 300,
	        nowrap: false,
	        striped: true,
	        fitColumns: true,
	        singleSelect: true,
	        collapsible: true,
	        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_SHOW_DS_YKIENCHIDAO), 
	        queryParams:{
	          total: -1,
	          records: 0,
	          condition: cond
	        },
	        loadMsg: MSG_WAIT_LOADING,
	        sortName: 'id_ykienchidao',
	        sortOrder: 'asc',
	        remoteSort: false,
	        idField:'id_ykienchidao',
	        columns: [[
	          {field: 'tieude', title: 'Tên văn bản', width: 80, align: 'left', alignH: 'center',
	        	   formatter:function(value,row){
	        		  return '<a href="#" onclick="onsubmenu_hienthi_ykienchidao('+row.id_ykienchidao+');">'+value+'</a>';
	        	  } 
	          },
	          {field: 'sokihieu', title: 'Kí hiệu ', width: 80, align: 'left', alignH: 'center'},
	          {field: 'ngay_chidao_cohieuluc', title: 'Ngày ban hành', width: 80, align: 'center', alignH: 'center'},
	        ]],
	        pagination: true,
	        rownumbers: true,
	        onLoadSuccess: function (data) {
	        }
	      });
	    } catch (err) {
	      alert("func_dlg_qlvanban_ykienchidao_show have dlg_qlvanban_ykienchidao_show_datagrid: " + err);
	    }
  }
  
  function func_dlg_qlvanban_ykienchidao_show() {
    try {
      $('#dlg_qlvanban_ykienchidao_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_SHOW_DS_YKIENCHIDAO), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_ykienchidao',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_ykienchidao',
        columns: [[
          {field: 'tieude', title: 'Tên văn bản', width: 80, align: 'left', alignH: 'center',
        	   formatter:function(value,row){
        		  return '<a href="#" onclick="onsubmenu_hienthi_ykienchidao('+row.id_ykienchidao+');">'+value+'</a>';
        	  } 
          },
          {field: 'sokihieu', title: 'Kí hiệu ', width: 80, align: 'left', alignH: 'center'},
          {field: 'ngay_chidao_cohieuluc', title: 'Ngày ban hành', width: 80, align: 'center', alignH: 'center'},
        ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_qlvanban_ykienchidao_show have dlg_qlvanban_ykienchidao_show_datagrid: " + err);
    }

    try{
      $('#dlg_qlvanban_ykienchidao_show').dialog({
        title: "Danh sách văn bản ý kiến chỉ đạo ",
        modal: false, open: function () {
          $(this).dialog('widget').draggable('option', {containment: false});
        },
        height: 500,
        width: 920,
        collapsible: true,
        draggable: true,
        resizable: false,
        position:[230,150],
        buttons: {
          "Xoá": function () {
            func_deleteRow_DlgShow_qlvanban_ykienchidao();
          },
          "Sửa": function () {
            loadHtml("dlg_qlvanban_ykienchidao_them","./page/quanlyvanban_ykienchidao_control.jsp", false);
            func_dlg_add_qlvanban_ykienchidao(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_qlvanban_ykienchidao_them","./page/quanlyvanban_ykienchidao_control.jsp", false);
            func_dlg_add_qlvanban_ykienchidao(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_qlvanban_ykienchidao_show have dlg_qlvanban_ykienchidao_show " + err);
    }
  }

  function onsubmenu_hienthi_ykienchidao(id_ykienchidao){
		loadHtml("dlg_qlvanban_ykienchidao_hienthi_show","./page/quanlyvanban_ykienchidao_hienthi.jsp", false);
		func_dlg_qlvanban_ykienchidao_hienthi(id_ykienchidao);
  }
</script>
    