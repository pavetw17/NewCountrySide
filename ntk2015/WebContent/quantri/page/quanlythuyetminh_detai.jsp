<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
         
<div>
    <strong>Nhóm đề tài</strong>
    <select name="dlg_thuyetminh_detai_cbb" id="dlg_thuyetminh_detai_cbb" ></select>
   
    <strong>Tìm đề tài</strong>
    <input  id="dl_thuyetminh_detai_find" style="margin-bottom: 13px; height: 24px" >
    <input TYPE="BUTTON" NAME="" VALUE="Tìm" style="margin-bottom: 5px; height: 24px"  onclick="findTMDT()">
</div>
<table id="dlg_thuyetminh_detai_show_datagrid"></table>

<script>
	$(document).ready(function() {
        cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DUAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_thuyetminh_detai_cbb');
	    $('#dlg_thuyetminh_detai_cbb').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_thuyetminh_detai_show();
		  }else{
			 getval_thuyetminh_detai_show("id_detai=" + this.value);
		  }
	    });
	});

  function findTMDT(){
	  var tukhoa = document.getElementById("dl_thuyetminh_detai_find").value;
       var cond = "masodt ilike '%"+ tukhoa.replace("'", " '' ") +"%'";
       //alert(cond);
       getval_thuyetminh_detai_show(cond);
  }	
	
  function getval_thuyetminh_detai_show(sel) {
	    try {
	        $('#dlg_thuyetminh_detai_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_THUYETMINH_DETAI), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_thuyetminh_detai_duan',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_thuyetminh_detai_duan',
	          columns: [[
	                     {field: 'masodt', title: 'Mã đề tài', width: 80, align: 'left', alignH: 'center',
	                   	  formatter:function(value,row){
	                  		  return '<a href="#" onclick="onsubmenu_hienthi_vanban('+row.id_thuyetminh_detai_duan+');">'+value+'</a>';
	                  	  }   
	                     },
	                     {field: 'muctieu_detai', title: 'Mục tiêu', width: 80, align: 'center', alignH: 'center'},
	                     {field: 'ngaybatdau', title: 'Thời gian', width: 80, align: 'center', alignH: 'center'},
	                     {field: 'tinhtrangdt', title: 'Kinh phí', width: 80, align: 'left', alignH: 'center'},
	          ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_thuyetminh_detai_show have dlg_thuyetminh_detai_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_qlthuyetminh_detai(){
    var datagrid_id = 'dlg_thuyetminh_detai_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.masodt + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_thuyetminh_detai_duan', 'id_thuyetminh_detai_duan ='+row.id_thuyetminh_detai_duan);
      }
    });
  }

  function func_dlg_thuyetminh_detai_show() {
    try {
      $('#dlg_thuyetminh_detai_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_THUYETMINH_DETAI),  
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_thuyetminh_detai_duan',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_thuyetminh_detai_duan',
        columns: [[
          {field: 'masodt', title: 'Mã thuyết minh đề tài', width: 80, align: 'left', alignH: 'center',
        	  formatter:function(value,row){
       		  	return '<a href="#" onclick="onsubmenu_hienthi_vanban('+row.id_thuyetminh_detai_duan+');">'+value+'</a>';
       	  	  }   
          },
          {field: 'muctieu_detai', title: 'Mục tiêu', width: 80, align: 'center', alignH: 'center'},
          {field: 'ngaybatdau', title: 'Ngày bắt đầu', width: 80, align: 'center', alignH: 'center',
        	  formatter:function(value,row){
           		  return gm.date.Int2DateString(row.ngaybatdau);
           	  }   
          },
          {field: 'tinhtrangdt', title: 'Tình trạng', width: 80, align: 'left', alignH: 'center',
        	  formatter:function(value,row){
        		  switch(row.tinhtrangdt){
        		  		case '0' : return  "Đang tuyển chọn"; 
        		  		case '1' : return  "Đang thực hiện"; 
        		  }
           	  }   
          },
        ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_thuyetminh_detai_show have dlg_thuyetminh_detai_show_datagrid: " + err);
    }

    try{
      $('#dlg_thuyetminh_detai_show').dialog({
        title: "Danh sách thuyết minh đề tài",
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
        	"Bảng Giai đoạn": function () {
        		onsubmenu_quanly_giaidoan();
              },
          "Xoá": function () {
            func_deleteRow_DlgShow_qlthuyetminh_detai();
          },
          "Sửa": function () {
            loadHtml("dlg_thuyetminh_detai_them","./page/quanlythuyetminh_detai_control.jsp", false);
            func_dlg_add_thuyetminh_detai(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_thuyetminh_detai_them","./page/quanlythuyetminh_detai_control.jsp", false);
            func_dlg_add_thuyetminh_detai(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_thuyetminh_detai_show have dlg_qlthuyetminh_detai_show " + err);
    }
  }

  function onsubmenu_hienthi_vanban(id_thuyetminh_detai_duan){
		loadHtml("dlg_qlthuyetminh_detai_hienthi_show","./page/quanlythuyetminh_detai_hienthi.jsp", false);
		func_dlg_qlthuyetminh_detai_hienthi(id_thuyetminh_detai_duan);
  }
</script>