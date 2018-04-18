<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
         
<div>
    <strong>Tìm nhóm tiêu chí</strong>
    <input  id="dl_tieuchi_xd_ntm_cha_find" style="margin-bottom: 13px; height: 24px" >
    <input TYPE="BUTTON" NAME="" VALUE="Tìm" style="margin-bottom: 5px; height: 24px"  onclick="findNTM_cha()">
</div>
<table id="dlg_tieuchi_xd_ntm_cha_show_datagrid"></table>

<script>
  function findNTM_cha(){
	  var tukhoa = document.getElementById("dl_tieuchi_xd_ntm_cha_find").value;
       var cond = "ten_tieuchi ilike '%"+ tukhoa.replace("'", " '' ") +"%' and id_tieuchi_cha is null";
       //alert(cond);
       getval_xd_ntm_cha_show(cond);
  }	
	
  function getval_xd_ntm_cha_show(sel) {
	    try {
	        $('#dlg_tieuchi_xd_ntm_cha_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_TIEUCHI_XD_NTM_CHA), 
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
	                     {field: 'ten_tieuchi', title: 'Tên tiêu chí', width: 80, align: 'left', alignH: 'center',
	                   	/*   formatter:function(value,row){
	                  		  return '<a href="#" onclick="onsubmenu_hienthi_vanban('+row.id_tieuchi+');">'+value+'</a>';
	                  	  }    */
	                     },
	          ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_tieuchi_xd_ntm_cha_show have dlg_tieuchi_xd_ntm_cha_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_qltieuchi_xd_ntm_cha(){
    var datagrid_id = 'dlg_tieuchi_xd_ntm_cha_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.ten_tieuchi + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_tieuchi_xaydung_ntm', 'id_tieuchi ='+row.id_tieuchi);
      }
    });
  }

  function func_dlg_tieuchi_xd_ntm_cha_show() {
    try {
      $('#dlg_tieuchi_xd_ntm_cha_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_TIEUCHI_XD_NTM_CHA),  
        queryParams:{
          total: -1,
          records: 0,
          condition: 'id_tieuchi_cha is null'
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_tieuchi',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_tieuchi',
        columns: [[
          {field: 'ten_tieuchi', title: 'Tên tiêu chí', width: 80, align: 'left', alignH: 'center',
        	 /*  formatter:function(value,row){
       		  	return '<a href="#" onclick="onsubmenu_hienthi_vanban('+row.id_tieuchi+');">'+value+'</a>';
       	  	  }    */
          },
        ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_tieuchi_xd_ntm_cha_show have dlg_tieuchi_xd_ntm_cha_show_datagrid: " + err);
    }

    try{
      $('#dlg_tieuchi_xd_ntm_cha_show').dialog({
        title: "Danh sách nhóm tiêu chí",
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
            func_deleteRow_DlgShow_qltieuchi_xd_ntm_cha();
          },
          "Sửa": function () {
            loadHtml("dlg_tieuchi_xd_ntm_cha_them","./page/quanlytieuchi_xd_ntm_cha_control.jsp", false);
            func_dlg_add_tieuchi_xd_ntm_cha(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_tieuchi_xd_ntm_cha_them","./page/quanlytieuchi_xd_ntm_cha_control.jsp", false);
            func_dlg_add_tieuchi_xd_ntm_cha(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_tieuchi_xd_ntm_cha_show have dlg_qltieuchi_xd_ntm_cha_show " + err);
    }
  }

  function onsubmenu_hienthi_vanban(id_tieuchi){
		loadHtml("dlg_qltieuchi_xd_ntm_cha_hienthi_show","./page/quanlytieuchi_xd_ntm_cha_hienthi.jsp", false);
		func_dlg_qltieuchi_xd_ntm_cha_hienthi(id_tieuchi);
  }
</script>