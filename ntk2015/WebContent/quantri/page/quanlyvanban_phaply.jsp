<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Phân loại</strong>
    <select name="dlg_qlvanban_phaply_theloai_phanloai" id="dlg_qlvanban_phaply_theloai_phanloai" ></select>
    
    <strong>Tìm văn bản</strong>
    <input  id="dl_qlvanban_phaply_findVB" style="margin-bottom: 10px;" >
    <input TYPE="BUTTON" NAME="" VALUE="Tìm" style="margin-bottom: 10px;"  onclick="findVB()">
</div>
<table id="dlg_qlvanban_phaply_show_datagrid"></table>

<script>
	$(document).ready(function() {
        cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_VANBAN_PHANLOAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_qlvanban_phaply_theloai_phanloai');
	    $('#dlg_qlvanban_phaply_theloai_phanloai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_qlvanban_phaply_show();
		  }else{
			 getval_qlvanban_phaply_show("id_phanloai=" + this.value);
		  }
	    });
	});

  function findVB(){
	  var tukhoa = document.getElementById("dl_qlvanban_phaply_findVB").value;
       var cond = "kihieuvanban ilike '%"+ tukhoa.replace("'", " '' ") +"%' or tenvanban ilike '%" + tukhoa.replace("'", " '' ") +"%'";
       //alert(cond);
       getval_qlvanban_phaply_show(cond);
  }	
	
  function getval_qlvanban_phaply_show(sel) {
	    try {
	        $('#dlg_qlvanban_phaply_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_SHOW_DS_VANBANPHAPLY), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_vanbanphaply',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_vanbanphaply',
	          columns: [[
	            {field: 'tenvanban', title: 'Tên văn bản', width: 80, align: 'left', alignH: 'center',
	          	   formatter:function(value,row){
	          		   <%-- var url = 'print.php?id='+row.id;
	          		   return '<a target="_blank" href="' + url + '">'+value+'</a>'; --%>
	          		  return '<a href="#" onclick="onsubmenu_hienthi_vanban('+row.id_vanbanphaply+');">'+value+'</a>';
	          	  }
	            },
	            {field: 'kihieuvanban', title: 'Kí hiệu văn bản', width: 80, align: 'left', alignH: 'center'},
	            {field: 'ngaybanhanh', title: 'Ngày ban hành', width: 80, align: 'center', alignH: 'center'},
	            
	          ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_qlvanban_phaply_show have dlg_qlvanban_phaply_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_qlvanban_phaply(){
    var datagrid_id = 'dlg_qlvanban_phaply_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.loai_vanbanphaply + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_vanbanphaply', 'id_vanbanphaply ='+row.id_vanbanphaply);
      }
    });
  }

  function func_dlg_qlvanban_phaply_show() {
    try {
      $('#dlg_qlvanban_phaply_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_SHOW_DS_VANBANPHAPLY), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_vanbanphaply',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_vanbanphaply',
        columns: [[
          {field: 'tenvanban', title: 'Tên văn bản', width: 80, align: 'left', alignH: 'center',
        	   formatter:function(value,row){
        		   <%-- var url = 'print.php?id='+row.id;
        		   return '<a target="_blank" href="' + url + '">'+value+'</a>'; --%>
        		  return '<a href="#" onclick="onsubmenu_hienthi_vanban('+row.id_vanbanphaply+');">'+value+'</a>';
        	  } 
          },
          {field: 'kihieuvanban', title: 'Kí hiệu văn bản', width: 80, align: 'left', alignH: 'center'},
          {field: 'ngaybanhanh', title: 'Ngày ban hành', width: 80, align: 'center', alignH: 'center'},
        ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_qlvanban_phaply_show have dlg_qlvanban_phaply_show_datagrid: " + err);
    }

    try{
      $('#dlg_qlvanban_phaply_show').dialog({
        title: "Danh sách văn bản pháp lý ",
        modal: false, open: function () {
          $(this).dialog('widget').draggable('option', {containment: false});
        },
        height: 500,
        width: 920,
        collapsible: true,
        draggable: true,
        resizable: false,
        position:[260,150],
        buttons: {
          "Xoá": function () {
            func_deleteRow_DlgShow_qlvanban_phaply();
          },
          "Sửa": function () {
            loadHtml("dlg_qlvanban_phaply_them","./page/quanlyvanban_phaply_control.jsp", false);
            func_dlg_add_qlvanban_phaply(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_qlvanban_phaply_them","./page/quanlyvanban_phaply_control.jsp", false);
            func_dlg_add_qlvanban_phaply(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_qlvanban_phaply_show have dlg_qlvanban_phaply_show " + err);
    }
  }

  function onsubmenu_hienthi_vanban(id_vanbanphaply){
		loadHtml("dlg_qlvanban_phaply_hienthi_show","./page/quanlyvanban_phaply_hienthi.jsp", false);
		func_dlg_qlvanban_phaply_hienthi(id_vanbanphaply);
  }
</script>