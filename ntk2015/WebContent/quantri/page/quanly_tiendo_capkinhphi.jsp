<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Thuyết minh đề tài:</strong>
    <select name="dlg_tiendo_capkinhphi_TheLoai_TMDeTai" id="dlg_tiendo_capkinhphi_TheLoai_TMDeTai" ></select>
</div>
<table id="dlg_tiendo_capkinhphi_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_tiendo_capkinhphi_TheLoai_TMDeTai');
	    $('#dlg_tiendo_capkinhphi_TheLoai_TMDeTai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_tiendo_capkinhphi();
		  }else{
			 getval_quanly_tiendo_capkinhphi("id_thuyetminhdetai =" + this.value);
		  }
	    });
	});

  function getval_quanly_tiendo_capkinhphi(sel) {
	    try {
	        $('#dlg_tiendo_capkinhphi_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_TD_CAPKINHPHI), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_tiendo_capkinhphi',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_tiendo_capkinhphi',
	          columns: [[
	                 	{field: 'tentc', title: 'Tổ chức', width: 80, align: 'left', alignH: 'center',
	                 		formatter:function(value,row){
	        	   				  return '<a href="javascript:;" onclick="onsubmenu_hienthi_tiendo_capkinhphi('+row.id_tiendo_capkinhphi+');">'+value+'</a>';
	        	   			  	}	
	                 	},
	                 	{field: 'sotien', title: 'Số tiền', width: 80, align: 'left', alignH: 'center'},
	                 	{field: 'ghichu', title: 'Ghi chú', width: 80, align: 'left', alignH: 'center'},
	                 	{field: 'ngaycap', title: 'Ngày cấp', width: 80, align: 'left', alignH: 'center',
	                 		 formatter:function(value,row){
		                  		  return gm.date.Int2DateString(row.ngaycap);
		                  	  }  	
	                 	},
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_tiendo_capkinhphi have dlg_tiendo_capkinhphi_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_tiendo_capkinhphi(){
    var datagrid_id = 'dlg_tiendo_capkinhphi_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_tiendo_capkinhphi + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_tiendo_capkinhphi', ' id_tiendo_capkinhphi='+row.id_tiendo_capkinhphi );
      }
    });
  }

  function func_dlg_quanly_tiendo_capkinhphi() {
    try {
      $('#dlg_tiendo_capkinhphi_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_TD_CAPKINHPHI), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_tiendo_capkinhphi',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_tiendo_capkinhphi',
        columns: [[
               	{field: 'tentc', title: 'Tổ chức', width: 80, align: 'left', alignH: 'center',
               		formatter:function(value,row){
  	   				  return '<a href="javascript:;" onclick="onsubmenu_hienthi_tiendo_capkinhphi('+row.id_tiendo_capkinhphi+');">'+value+'</a>';
  	   			  	}	
               	},
               	{field: 'sotien', title: 'Số tiền', width: 80, align: 'left', alignH: 'center'},
             	{field: 'ghichu', title: 'Ghi chú', width: 80, align: 'left', alignH: 'center'},
             	{field: 'ngaycap', title: 'Ngày cấp', width: 80, align: 'left', alignH: 'center',
             		 formatter:function(value,row){
                  		  return gm.date.Int2DateString(row.ngaycap);
                  	  }  	
             	},
   	          ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_tiendo_capkinhphi have dlg_tiendo_capkinhphi_show_datagrid: " + err);
    }

    try{
      $('#dlg_tiendo_capkinhphi_show').dialog({
        title: "Danh sách tiến độ cấp kinh phí ",
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
            func_deleteRow_DlgShow_tiendo_capkinhphi();
          },
          "Sửa": function () {
            loadHtml("dlg_tiendo_capkinhphi_them","./page/quanly_tiendo_capkinhphi_control.jsp", false);
            func_dlg_add_tiendo_capkinhphi(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_tiendo_capkinhphi_them","./page/quanly_tiendo_capkinhphi_control.jsp", false);
            func_dlg_add_tiendo_capkinhphi(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_tiendo_capkinhphi have dlg_tiendo_capkinhphi_show " + err);
    }
  }

  function onsubmenu_hienthi_tiendo_capkinhphi(id_tiendo_capkinhphi){
		loadHtml("dlg_tiendo_capkinhphi_hienthi_show","./page/quanly_tiendo_capkinhphi_hienthi.jsp", false);
		func_dlg_tiendo_capkinhphi_hienthi(id_tiendo_capkinhphi);
  }
</script>