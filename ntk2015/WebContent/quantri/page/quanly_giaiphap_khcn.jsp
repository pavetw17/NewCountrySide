<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Thuyết minh đề tài:</strong>
    <select name="dlg_giaiphap_khcn_TheLoai_TMDeTai" id="dlg_giaiphap_khcn_TheLoai_TMDeTai" ></select>
</div>
<table id="dlg_giaiphap_khcn_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_giaiphap_khcn_TheLoai_TMDeTai');
	    $('#dlg_giaiphap_khcn_TheLoai_TMDeTai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_giaiphap_khcn();
		  }else{
			 getval_quanly_giaiphap_khcn("id_thuyetminhdetai =" + this.value);
		  }
	    });
	});

  function getval_quanly_giaiphap_khcn(sel) {
	    try {
	        $('#dlg_giaiphap_khcn_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_GIAIPHAP_KHCN), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_giaiphap_khcn',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_giaiphap_khcn',
	          columns: [[
	                 	{field: 'ten_giaiphap_khcn', title: 'Tên giải pháp', width: 80, align: 'left', alignH: 'center',
	                 		formatter:function(value,row){
	    						  return '<a href="javascript:;" onclick="onsubmenu_hienthi_giaiphap_khcn('+row.id_giaiphap_khcn+');">'+value+'</a>';
	    					  	}
	                 	},
	                 	{field: 'noidung_giaiphap_khcn', title: 'Nội dung', width: 80, align: 'left', alignH: 'center'},
	                 	{field: 'quytrinh_thuc_hien', title: 'Quy trình', width: 80, align: 'left', alignH: 'center',
	                 	},
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_giaiphap_khcn have dlg_giaiphap_khcn_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_giaiphap_khcn(){
    var datagrid_id = 'dlg_giaiphap_khcn_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_giaiphap_khcn + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_giaiphap_khcn', ' id_giaiphap_khcn='+row.id_giaiphap_khcn);
      }
    });
  }

  function func_dlg_quanly_giaiphap_khcn() {
    try {
      $('#dlg_giaiphap_khcn_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_GIAIPHAP_KHCN), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_giaiphap_khcn',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_giaiphap_khcn',
        columns: [[
					{field: 'ten_giaiphap_khcn', title: 'Tên giải pháp', width: 80, align: 'left', alignH: 'center',
						formatter:function(value,row){
  						  return '<a href="javascript:;" onclick="onsubmenu_hienthi_giaiphap_khcn('+row.id_giaiphap_khcn+');">'+value+'</a>';
  					  	}	
					
					},
					{field: 'noidung_giaiphap_khcn', title: 'Nội dung', width: 80, align: 'left', alignH: 'center'},
					{field: 'quytrinh_thuc_hien', title: 'Quy trình', width: 80, align: 'left', alignH: 'center',
					},
   	          ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_giaiphap_khcn have dlg_giaiphap_khcn_show_datagrid: " + err);
    }

    try{
      $('#dlg_giaiphap_khcn_show').dialog({
        title: "Danh sách giải pháp  KHCN ",
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
            func_deleteRow_DlgShow_giaiphap_khcn();
          },
          "Sửa": function () {
            loadHtml("dlg_giaiphap_khcn_them","./page/quanly_giaiphap_khcn_control.jsp", false);
            func_dlg_add_giaiphap_khcn(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_giaiphap_khcn_them","./page/quanly_giaiphap_khcn_control.jsp", false);
            func_dlg_add_giaiphap_khcn(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_giaiphap_khcn have dlg_giaiphap_khcn_show " + err);
    }
  }

  function onsubmenu_hienthi_giaiphap_khcn(id_giaiphap_khcn){
		loadHtml("dlg_giaiphap_khcn_hienthi_show","./page/quanly_giaiphap_khcn_hienthi.jsp", false);
		func_dlg_giaiphap_khcn_hienthi(id_giaiphap_khcn);
  }
</script>