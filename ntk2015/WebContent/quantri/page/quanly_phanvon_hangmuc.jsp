<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Thuyết minh đề tài:</strong>
    <select name="dlg_phanvon_hangmuc_TheLoai_TMDeTai" id="dlg_phanvon_hangmuc_TheLoai_TMDeTai" ></select>
</div>
<table id="dlg_phanvon_hangmuc_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_phanvon_hangmuc_TheLoai_TMDeTai');
	    $('#dlg_phanvon_hangmuc_TheLoai_TMDeTai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_phanvon_hangmuc();
		  }else{
			 getval_quanly_phanvon_hangmuc("id_thuyetminhdetai =" + this.value);
		  }
	    });
	});

  function getval_quanly_phanvon_hangmuc(sel) {
	    try {
	        $('#dlg_phanvon_hangmuc_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_PHANBOVON_THEOHANGMUC), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_tieuchi',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_tieuchi',
	          columns: [[
	                 	{field: 'tentc', title: 'Tên tổ chức', width: 80, align: 'left', alignH: 'center',
	                 		 formatter:function(value,row){
		                  		  return '<a href="javascript:;" onclick="onsubmenu_hienthi_phanvon_hangmuc('+row.id_tieuchi+');">'+value+'</a>';
		                  	  }  	
	                 	},
	                 	{field: 'tenfile', title: 'Tên file', width: 80, align: 'left', alignH: 'center',
	                 		
	                 	},
	                 	{field: 'tukhoa', title: 'Từ khóa', width: 80, align: 'left', alignH: 'center'},
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_phanvon_hangmuc have dlg_phanvon_hangmuc_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_phanvon_hangmuc(){
    var datagrid_id = 'dlg_phanvon_hangmuc_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_tieuchi + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_phanbovon_theohangmuc', ' id_tieuchi='+row.id_tieuchi);
      }
    });
  }

  function func_dlg_quanly_phanvon_hangmuc() {
    try {
      $('#dlg_phanvon_hangmuc_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_PHANBOVON_THEOHANGMUC), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_tieuchi',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_tieuchi',
        columns: [[
                	{field: 'tentc', title: 'Tên tổ chức', width: 80, align: 'left', alignH: 'center',
                		 formatter:function(value,row){
	                  		  return '<a href="javascript:;" onclick="onsubmenu_hienthi_phanvon_hangmuc('+row.id_tieuchi+');">'+value+'</a>';
	                  	  }  		
                	},
                 	{field: 'tenfile', title: 'Tên file', width: 80, align: 'left', alignH: 'center',
                		
                 	},
                 	{field: 'tukhoa', title: 'Từ khóa', width: 80, align: 'left', alignH: 'center'},
		 ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_phanvon_hangmuc have dlg_phanvon_hangmuc_show_datagrid: " + err);
    }

    try{
      $('#dlg_phanvon_hangmuc_show').dialog({
        title: "Danh sách phân vốn hạng mục ",
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
            func_deleteRow_DlgShow_phanvon_hangmuc();
          },
          "Sửa": function () {
            loadHtml("dlg_phanvon_hangmuc_them","./page/quanly_phanvon_hangmuc_control.jsp", false);
            func_dlg_add_phanvon_hangmuc(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_phanvon_hangmuc_them","./page/quanly_phanvon_hangmuc_control.jsp", false);
            func_dlg_add_phanvon_hangmuc(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_phanvon_hangmuc have dlg_phanvon_hangmuc_show " + err);
    }
  }

  function onsubmenu_hienthi_phanvon_hangmuc(id_tieuchi){
		loadHtml("dlg_phanvon_hangmuc_hienthi_show","./page/quanly_phanvon_hangmuc_hienthi.jsp", false);
		func_dlg_phanvon_hangmuc_hienthi(id_tieuchi);
  }
</script>