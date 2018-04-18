<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Đề tài:</strong>
    <select name="dlg_bb_mohoso_TheLoai_detai" id="dlg_bb_mohoso_TheLoai_detai" ></select>
</div>
<table id="dlg_bb_mohoso_show_datagrid"></table>

<script>
	$(document).ready(function() {
		
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DUAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_bb_mohoso_TheLoai_detai');
	    $('#dlg_bb_mohoso_TheLoai_detai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_bb_mohoso();
		  }else{
			 getval_quanly_bb_mohoso("id_detai =" + this.value);
		  }
	    });
	});

	
  function getval_quanly_bb_mohoso(sel) {
	    try {
	        $('#dlg_bb_mohoso_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_BIENBAN_MOHOSO), 
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
				{field: 'diadiem', title: 'Địa điểm', width: 80, align: 'left', alignH: 'center'},
   				{field: 'qd_thanhlaphoidong', title: 'Quyết định thành lập', width: 80, align: 'left', alignH: 'center',
					   	formatter:function(value,row){
						  return '<a href="#" onclick="onsubmenu_hienthi_bb_mohoso('+row.id_detai+');">'+value+'</a>';
					  	} 
   				},
				{field: 'ngay_ra_quyetdinh', title: 'Ngày ra quyết định', width: 80, align: 'center', alignH: 'center',
					  formatter:function(value,row){
			      		  return gm.date.Int2DateString(row.ngay_ra_quyetdinh);
			      	  }  
				},
				{field: 'thoigian_mohoso', title: 'Thời gian', width: 80, align: 'center', alignH: 'center',
					  formatter:function(value,row){
			      		  return gm.date.Int2DateString(row.thoigian_mohoso);
			      	  }  
				}
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_bb_mohoso have dlg_bb_mohoso_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_bb_mohoso(){
    var datagrid_id = 'dlg_bb_mohoso_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.tieude + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_bienban_mohoso', 'id_detai ='+row.id_detai);
      }
    });
  }

  function func_dlg_quanly_bb_mohoso() {
    try {
      $('#dlg_bb_mohoso_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_BIENBAN_MOHOSO), 
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
   				{field: 'diadiem', title: 'Địa điểm', width: 80, align: 'left', alignH: 'center'},
      				{field: 'qd_thanhlaphoidong', title: 'Quyết định thành lập', width: 80, align: 'left', alignH: 'center',
   					   	formatter:function(value,row){
   						  return '<a href="#" onclick="onsubmenu_hienthi_bb_mohoso('+row.id_detai+');">'+value+'</a>';
   					  	} 
      				},
   				{field: 'ngay_ra_quyetdinh', title: 'Ngày ra quyết định', width: 80, align: 'center', alignH: 'center',
   					  formatter:function(value,row){
   			      		  return gm.date.Int2DateString(row.ngay_ra_quyetdinh);
   			      	  }  
   				},
   				{field: 'thoigian_mohoso', title: 'Thời gian', width: 80, align: 'center', alignH: 'center',
   					  formatter:function(value,row){
   			      		  return gm.date.Int2DateString(row.thoigian_mohoso);
   			      	  }  
   				}
   			 ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_bb_mohoso have dlg_bb_mohoso_show_datagrid: " + err);
    }

    try{
      $('#dlg_bb_mohoso_show').dialog({
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
            func_deleteRow_DlgShow_bb_mohoso();
          },
          "Sửa": function () {
            loadHtml("dlg_bb_mohoso_them","./page/quanlybb_mohoso_control.jsp", false);
            func_dlg_add_bb_mohoso(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_bb_mohoso_them","./page/quanlybb_mohoso_control.jsp", false);
            func_dlg_add_bb_mohoso(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_bb_mohoso have dlg_bb_mohoso_show " + err);
    }
  }

  function onsubmenu_hienthi_bb_mohoso(id_detai){
		loadHtml("dlg_bb_mohoso_hienthi_show","./page/quanlybb_mohoso_hienthi.jsp", false);
		func_dlg_bb_mohoso_hienthi(id_detai);
  }
</script>