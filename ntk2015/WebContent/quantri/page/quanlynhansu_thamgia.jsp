<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
         
<div>
    <strong>Tổ chức</strong>
    <select name="dlg_nhansu_thamgia_tochuc_cbb" id="dlg_nhansu_thamgia_tochuc_cbb" ></select>
   
    <strong>Tìm nhân sự tham gia </strong>
    <input  id="dl_nhansu_thamgia_find" style="margin-bottom: 13px; height: 24px" >
    <input TYPE="BUTTON" NAME="" VALUE="Tìm" style="margin-bottom: 5px; height: 24px"  onclick="findTC_con()">
</div>
<table id="dlg_nhansu_thamgia_show_datagrid"></table>

<script>
	$(document).ready(function() {
        cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_nhansu_thamgia_tochuc_cbb');
	    $('#dlg_nhansu_thamgia_tochuc_cbb').on('change', function() {
	      if(this.value == -1){
	    	  func_dlg_nhansu_thamgia_show();
		  }else{
			 getval_nhansu_thamgia_show("b.id_tochuc=" + this.value);
		  }
	    });
	});

  function findTC_con(){
	  var tukhoa = document.getElementById("dl_nhansu_thamgia_find").value;
       var cond = "hoten ilike '%"+ tukhoa.replace("'", " '' ") +"%'";
       //alert(cond);
       getval_nhansu_thamgia_show(cond);
  }	
	
  function getval_nhansu_thamgia_show(sel) {
	    try {
	        $('#dlg_nhansu_thamgia_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_NHANSU_THAMGIA), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_nhansu_detai',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_nhansu_detai',
	          columns: [[
	                     {field: 'hoten', title: 'Tên nhân sự', width: 80, align: 'left', alignH: 'center',
	                   	  formatter:function(value,row){
	                  		  return '<a href="#" onclick="onsubmenu_hienthi_vanban('+row.id_nhansu_detai+');">'+value+'</a>';
	                  	  }   
	                     },
	                     {field: 'tentc', title: 'Tổ chức', width: 80, align: 'center', alignH: 'center'},
	                     {field: 'noidungthamgia', title: 'Nội dung tham gia', width: 80, align: 'center', alignH: 'center'},
	          ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_nhansu_thamgia_show have dlg_nhansu_thamgia_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_nhansu_thamgia(){
    var datagrid_id = 'dlg_nhansu_thamgia_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.hoten + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_nhansu_thamgia', 'id_nhansu_detai ='+row.id_nhansu_detai);
      }
    });
  }

  function func_dlg_nhansu_thamgia_show() {
    try {
      $('#dlg_nhansu_thamgia_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_NHANSU_THAMGIA),  
        queryParams:{
          total: -1,
          records: 0,
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_nhansu_detai',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_nhansu_detai',
        columns: [[
          {field: 'hoten', title: 'Tên nhân sự', width: 80, align: 'left', alignH: 'center',
        	  formatter:function(value,row){
       		  	return '<a href="#" onclick="onsubmenu_hienthi_vanban('+row.id_nhansu_detai+');">'+value+'</a>';
       	  	  }   
          },
          {field: 'tentc', title: 'Tổ chức', width: 80, align: 'center', alignH: 'center'},
          {field: 'noidungthamgia', title: 'Nội dung tham gia', width: 80, align: 'center', alignH: 'center' },
        ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_nhansu_thamgia_show have dlg_nhansu_thamgia_show_datagrid: " + err);
    }

    try{
      $('#dlg_nhansu_thamgia_show').dialog({
        title: "Danh sách nhân sự tham gia",
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
            func_deleteRow_DlgShow_nhansu_thamgia();
          },
          "Sửa": function () {
            loadHtml("dlg_nhansu_thamgia_them","./page/quanlynhansu_thamgia_control.jsp", false);
            func_dlg_add_nhansu_thamgia(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_nhansu_thamgia_them","./page/quanlynhansu_thamgia_control.jsp", false);
            func_dlg_add_nhansu_thamgia(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_nhansu_thamgia_show have dlg_qlnhansu_thamgia_show " + err);
    }
  }

  function onsubmenu_hienthi_vanban(id_nhansu_detai){
		loadHtml("dlg_nhansu_thamgia_hienthi_show","./page/quanlynhansu_thamgia_hienthi.jsp", false);
		func_dlg_nhansu_thamgia_hienthi(id_nhansu_detai);
  }
</script>