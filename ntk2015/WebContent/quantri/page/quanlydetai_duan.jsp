<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
         
<div>
    <strong>Nhóm đề tài</strong>
    <select name="dlg_detai_duan_cbb" id="dlg_detai_duan_cbb" ></select>
   
    <strong>Tìm đề tài</strong>
    <input  id="dl_detai_duan_find" style="margin-bottom: 13px; height: 24px" >
    <input TYPE="BUTTON" NAME="" VALUE="Tìm" style="margin-bottom: 5px; height: 24px"  onclick="findDT()">
</div>
<table id="dlg_detai_duan_show_datagrid"></table>

<script>
	$(document).ready(function() {
        cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_NHOM_DETAI_DUAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_detai_duan_cbb');
	    $('#dlg_detai_duan_cbb').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_detai_duan_show();
		  }else{
			 getval_detai_duan_show("id_phannhom_detai_duan=" + this.value);
		  }
	    });
	});

  function findDT(){
	  var tukhoa = document.getElementById("dl_detai_duan_find").value;
       var cond = "tendt ilike '%"+ tukhoa.replace("'", " '' ") +"%'";
       //alert(cond);
       getval_detai_duan_show(cond);
  }	
	
  function getval_detai_duan_show(sel) {
	    try {
	        $('#dlg_detai_duan_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_DETAI_DUAN), 
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
	        alert("func_dlg_detai_duan_show have dlg_detai_duan_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_qldetai_duan(){
    var datagrid_id = 'dlg_detai_duan_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.tendt + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_detai_duan', 'id_detai ='+row.id_detai);
      }
    });
  }

  function func_dlg_detai_duan_show() {
    try {
      $('#dlg_detai_duan_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_DETAI_DUAN),  
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
      alert("func_dlg_detai_duan_show have dlg_detai_duan_show_datagrid: " + err);
    }

    try{
      $('#dlg_detai_duan_show').dialog({
        title: "Danh sách đề tài",
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
            func_deleteRow_DlgShow_qldetai_duan();
          },
          "Sửa": function () {
            loadHtml("dlg_detai_duan_them","./page/quanlydetai_duan_control.jsp", false);
            func_dlg_add_detai_duan(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_detai_duan_them","./page/quanlydetai_duan_control.jsp", false);
            func_dlg_add_detai_duan(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_detai_duan_show have dlg_qldetai_duan_show " + err);
    }
  }

  function onsubmenu_hienthi_vanban(id_detai){
		loadHtml("dlg_qldetai_duan_hienthi_show","./page/quanlydetai_duan_hienthi.jsp", false);
		func_dlg_qldetai_duan_hienthi(id_detai);
  }
</script>