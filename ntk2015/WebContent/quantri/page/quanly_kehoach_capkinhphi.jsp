<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Thuyết minh đề tài:</strong>
    <select name="dlg_kehoach_capkinhphi_TheLoai_TMDeTai" id="dlg_kehoach_capkinhphi_TheLoai_TMDeTai" ></select>
</div>
<table id="dlg_kehoach_capkinhphi_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_kehoach_capkinhphi_TheLoai_TMDeTai');
	    $('#dlg_kehoach_capkinhphi_TheLoai_TMDeTai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_kehoach_capkinhphi();
		  }else{
			 getval_quanly_kehoach_capkinhphi("id_thuyetminhdetai =" + this.value);
		  }
	    });
	});

  function getval_quanly_kehoach_capkinhphi(sel) {
	    try {
	        $('#dlg_kehoach_capkinhphi_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_KH_CAPKINHPHI), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_kh_capkinhphi',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_kh_capkinhphi',
	          columns: [[
	                 	{field: 'tentc', title: 'Tên tổ chức', width: 80, align: 'left', alignH: 'center',
	                 		formatter:function(value,row){
	        	   				  return '<a href="javascript:;" onclick="onsubmenu_hienthi_kehoach_capkinhphi('+row.id_kh_capkinhphi+');">'+value+'</a>';
	        	   			  	}
	                 	},
	                 	{field: 'sotien', title: 'Số tiền', width: 80, align: 'left', alignH: 'center'},
	                 	{field: 'ghichu', title: 'Ghi chú', width: 80, align: 'left', alignH: 'center'},
	                 	{field: 'ngaydukiencap', title: 'Ngày dự kiến', width: 80, align: 'left', alignH: 'center',
	                 		formatter:function(value,row){
		                  		  return gm.date.Int2DateString(row.ngaydukiencap);
		                  	  } 
	                 	},
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_kehoach_capkinhphi have dlg_kehoach_capkinhphi_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_kehoach_capkinhphi(){
    var datagrid_id = 'dlg_kehoach_capkinhphi_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_kh_capkinhphi + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_kh_capkinhphi', ' id_kh_capkinhphi='+row.id_kh_capkinhphi);
      }
    });
  }

  function func_dlg_quanly_kehoach_capkinhphi() {
    try {
      $('#dlg_kehoach_capkinhphi_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_KH_CAPKINHPHI), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_kh_capkinhphi',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_kh_capkinhphi',
        columns: [[
             	{field: 'tentc', title: 'Tên tổ chức', width: 80, align: 'left', alignH: 'center',
             		formatter:function(value,row){
  	   				  return '<a href="javascript:;" onclick="onsubmenu_hienthi_kehoach_capkinhphi('+row.id_kh_capkinhphi+');">'+value+'</a>';
  	   			  	}
             	},
               	{field: 'sotien', title: 'Số tiền', width: 80, align: 'left', alignH: 'center'},
             	{field: 'ghichu', title: 'Ghi chú', width: 80, align: 'left', alignH: 'center'},
             	{field: 'ngaydukiencap', title: 'Ngày dự kiến', width: 80, align: 'left', alignH: 'center',
             		formatter:function(value,row){
                		  return gm.date.Int2DateString(row.ngaydukiencap);
                	  } 
             	},
   	          ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_kehoach_capkinhphi have dlg_kehoach_capkinhphi_show_datagrid: " + err);
    }

    try{
      $('#dlg_kehoach_capkinhphi_show').dialog({
        title: "Danh sách kế hoạch cấp kinh phí ",
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
            func_deleteRow_DlgShow_kehoach_capkinhphi();
          },
          "Sửa": function () {
            loadHtml("dlg_kehoach_capkinhphi_them","./page/quanly_kehoach_capkinhphi_control.jsp", false);
            func_dlg_add_kehoach_capkinhphi(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_kehoach_capkinhphi_them","./page/quanly_kehoach_capkinhphi_control.jsp", false);
            func_dlg_add_kehoach_capkinhphi(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_kehoach_capkinhphi have dlg_kehoach_capkinhphi_show " + err);
    }
  }

  function onsubmenu_hienthi_kehoach_capkinhphi(id_kh_capkinhphi){
		loadHtml("dlg_kehoach_capkinhphi_hienthi_show","./page/quanly_kehoach_capkinhphi_hienthi.jsp", false);
		func_dlg_kehoach_capkinhphi_hienthi(id_kh_capkinhphi);
  }
</script>