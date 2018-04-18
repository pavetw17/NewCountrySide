<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Thuyết minh đề tài:</strong>
    <select name="dlg_coche_chinhsach_TheLoai_TMDeTai" id="dlg_coche_chinhsach_TheLoai_TMDeTai" ></select>
</div>
<table id="dlg_coche_chinhsach_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_coche_chinhsach_TheLoai_TMDeTai');
	    $('#dlg_coche_chinhsach_TheLoai_TMDeTai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_coche_chinhsach();
		  }else{
			 getval_coche_chinhsach("id_thuyetminhdetai =" + this.value);
		  }
	    });
	});

  function getval_coche_chinhsach(sel) {
	    try {
	        $('#dlg_coche_chinhsach_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_COCHE_CHINHSACH), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_coche_chinhsach',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_coche_chinhsach',
	          columns: [[
	                 	{field: 'ten_coche_chinhsach', title: 'Tên cơ chế', width: 80, align: 'left', alignH: 'center',
	                 		formatter:function(value,row){
	    						  return '<a href="javascript:;" onclick="onsubmenu_hienthi_coche_chinhsach('+row.id_coche_chinhsach+');">'+value+'</a>';
	    					  	}	
	                 	},
	                 	{field: 'noidung_coche_chinhsach', title: 'Nội dung', width: 80, align: 'left', alignH: 'center'},
	                 	{field: 'maso_coche_chinhsach', title: 'Mã số', width: 80, align: 'left', alignH: 'center',
	                 	},
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_coche_chinhsach have dlg_coche_chinhsach_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_coche_chinhsach(){
    var datagrid_id = 'dlg_coche_chinhsach_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_coche_chinhsach + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_coche_chinhsach', ' id_coche_chinhsach='+row.id_coche_chinhsach);
      }
    });
  }

  function func_dlg_quanly_coche_chinhsach() {
    try {
      $('#dlg_coche_chinhsach_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_COCHE_CHINHSACH), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_coche_chinhsach',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_coche_chinhsach',
        columns: [[
					{field: 'ten_coche_chinhsach', title: 'Tên cơ chế', width: 80, align: 'left', alignH: 'center',
						formatter:function(value,row){
  						  return '<a href="javascript:;" onclick="onsubmenu_hienthi_coche_chinhsach('+row.id_coche_chinhsach+');">'+value+'</a>';
  					  	}	
					},
					{field: 'noidung_coche_chinhsach', title: 'Nội dung', width: 80, align: 'left', alignH: 'center'},
					{field: 'maso_coche_chinhsach', title: 'Mã số', width: 80, align: 'left', alignH: 'center',
					},
   	          ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_coche_chinhsach have dlg_coche_chinhsach_show_datagrid: " + err);
    }

    try{
      $('#dlg_coche_chinhsach_show').dialog({
        title: "Danh sách cơ chế chính sách ",
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
            func_deleteRow_DlgShow_coche_chinhsach();
          },
          "Sửa": function () {
            loadHtml("dlg_coche_chinhsach_them","./page/quanly_coche_chinhsach_control.jsp", false);
            func_dlg_add_coche_chinhsach(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_coche_chinhsach_them","./page/quanly_coche_chinhsach_control.jsp", false);
            func_dlg_add_coche_chinhsach(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_coche_chinhsach have dlg_coche_chinhsach_show " + err);
    }
  }

  function onsubmenu_hienthi_coche_chinhsach(id_coche_chinhsach){
		loadHtml("dlg_coche_chinhsach_hienthi_show","./page/quanly_coche_chinhsach_hienthi.jsp", false);
		func_dlg_coche_chinhsach_hienthi(id_coche_chinhsach);
  }
</script>