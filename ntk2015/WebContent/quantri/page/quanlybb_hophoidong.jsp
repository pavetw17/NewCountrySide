<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Đề tài:</strong>
    <select name="dlg_bb_hophoidong_TheLoai_detai" id="dlg_bb_hophoidong_TheLoai_detai" ></select>
    <strong>Tìm biên bản:</strong>
    <input  id="dl_bb_hophoidong_findBBHHD" style="margin-bottom: 13px; height: 24px" >
    <input TYPE="BUTTON" NAME="" VALUE="Tìm" style="margin-bottom: 13px; height: 24px"  onclick="find_bb_hophoidong()">
</div>
<table id="dlg_bb_hophoidong_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DUAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_bb_hophoidong_TheLoai_detai');
	    $('#dlg_bb_hophoidong_TheLoai_detai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_bb_hophoidong();
		  }else{
			 getval_quanly_bb_hophoidong("id_detai =" + this.value);
		  }
	    });
	});

  function find_bb_hophoidong(){
	  var tukhoa = document.getElementById("dl_bb_hophoidong_findBBHHD").value;
       var cond = "tenfile ilike '%"+ tukhoa.replace("'", " '' ") +"%' or tenfile ilike '%" + tukhoa.replace("'", " '' ") +"%'";
       //alert(cond);
       getval_quanly_bb_hophoidong(cond);
  }	
	
  function getval_quanly_bb_hophoidong(sel) {
	    try {
	        $('#dlg_bb_hophoidong_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_BIENBAN_HOPHOIDONG), 
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
				{field: 'tenfile', title: 'Tên file', width: 80, align: 'left', alignH: 'center'},
   				{field: 'quyetdinh_thanhlap_hoidong', title: 'Quyết định thành lập', width: 80, align: 'left', alignH: 'center',
					   	formatter:function(value,row){
						  return '<a href="#" onclick="onsubmenu_hienthi_bb_hophoidong('+row.id_detai+');">'+value+'</a>';
					  	} 
   				},
				{field: 'ngay_ra_quyetdinh', title: 'Ngày ra quyết định', width: 80, align: 'center', alignH: 'center',
					  formatter:function(value,row){
			      		  return gm.date.Int2DateString(row.ngay_ra_quyetdinh);
			      	  }  
				},
				{field: 'diadiem', title: 'Địa điểm', width: 80, align: 'left', alignH: 'center'},
				{field: 'thoigian', title: 'Thời gian', width: 80, align: 'center', alignH: 'center',
					  formatter:function(value,row){
			      		  return gm.date.Int2DateString(row.thoigian);
			      	  }  
				}
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_bb_hophoidong have dlg_bb_hophoidong_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_bb_hophoidong(){
    var datagrid_id = 'dlg_bb_hophoidong_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.tieude + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_bienban_hophoidong', 'id_detai ='+row.id_detai);
      }
    });
  }

  function func_dlg_quanly_bb_hophoidong() {
    try {
      $('#dlg_bb_hophoidong_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_BIENBAN_HOPHOIDONG), 
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
                {field: 'tenfile', title: 'Tên file', width: 80, align: 'left', alignH: 'center'},
   	            {field: 'quyetdinh_thanhlap_hoidong', title: 'Quyết định thành lập', width: 80, align: 'left', alignH: 'center',
   	        	   	formatter:function(value,row){
   	        		  return '<a href="#" onclick="onsubmenu_hienthi_bb_hophoidong('+row.id_detai+');">'+value+'</a>';
   	        	  	} 
   	            },
   				{field: 'ngay_ra_quyetdinh', title: 'Ngày ra quyết định', width: 80, align: 'center', alignH: 'center',
   					  formatter:function(value,row){
   		           		  return gm.date.Int2DateString(row.ngay_ra_quyetdinh);
   		           	  }  
   				},
   				{field: 'diadiem', title: 'Địa điểm', width: 80, align: 'left', alignH: 'center'},
   				{field: 'thoigian', title: 'Thời gian', width: 80, align: 'center', alignH: 'center',
   				  formatter:function(value,row){
		      		  return gm.date.Int2DateString(row.thoigian);
		      	  }  
   				}
   	          ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_bb_hophoidong have dlg_bb_hophoidong_show_datagrid: " + err);
    }

    try{
      $('#dlg_bb_hophoidong_show').dialog({
        title: "Danh sách biên bản ",
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
            func_deleteRow_DlgShow_bb_hophoidong();
          },
          "Sửa": function () {
            loadHtml("dlg_bb_hophoidong_them","./page/quanlybb_hophoidong_control.jsp", false);
            func_dlg_add_bb_hophoidong(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_bb_hophoidong_them","./page/quanlybb_hophoidong_control.jsp", false);
            func_dlg_add_bb_hophoidong(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_bb_hophoidong have dlg_bb_hophoidong_show " + err);
    }
  }

  function onsubmenu_hienthi_bb_hophoidong(id_detai){
		loadHtml("dlg_bb_hophoidong_hienthi_show","./page/quanlybb_hophoidong_hienthi.jsp", false);
		func_dlg_bb_hophoidong_hienthi(id_detai);
  }
</script>