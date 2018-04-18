<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Đề tài:</strong>
    <select name="dlg_detai_tochuc_TheLoai_DeTai" id="dlg_detai_tochuc_TheLoai_DeTai" ></select>
</div>
<table id="dlg_detai_tochuc_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DUAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_detai_tochuc_TheLoai_DeTai');
	    $('#dlg_detai_tochuc_TheLoai_DeTai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_detai_tochuc();
		  }else{
			 getval_detai_tochuc("a.id_detai =" + this.value);
		  }
	    });
	});

  function getval_detai_tochuc(sel) {
	    try {
	        $('#dlg_detai_tochuc_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_DETAI_TOCHUC), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_tochuc',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_tochuc',
	          columns: [[
	                 	{field: 'maso', title: 'Mã số đề tài', width: 80, align: 'left', alignH: 'center',
	    					formatter:function(value,row){
	    						  return '<a href="javascript:;" onclick="onsubmenu_hienthi_detai_tochuc('+row.id_detai+','+row.id_thuyetminhdetai+','+row.id_tochuc+');">'+value+'</a>';
	    					  	}
	    				},
	                 	{field: 'tentc', title: 'Tên tổ chức', width: 80, align: 'left', alignH: 'center'},
	                 	{field: 'masodt', title: 'Mã số đề tài', width: 80, align: 'left', alignH: 'center'},
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_detai_tochuc have dlg_detai_tochuc_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_detai_tochuc(){
    var datagrid_id = 'dlg_detai_tochuc_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.maso + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_detai_tochuc', ' id_detail='+row.id_detai +' and id_thuyetminhdetai='+row.id_thuyetminhdetai+' and id_detai_tochuc ='+row.id_detai_tochuc);
      }
    });
  }

  function func_dlg_quanly_detai_tochuc() {
    try {
      $('#dlg_detai_tochuc_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_DETAI_TOCHUC), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_tochuc',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_tochuc',
        columns: [[
				{field: 'maso', title: 'Mã số đề tài', width: 80, align: 'left', alignH: 'center',
					formatter:function(value,row){
						  return '<a href="javascript:;" onclick="onsubmenu_hienthi_detai_tochuc('+row.id_detai+','+row.id_thuyetminhdetai+','+row.id_tochuc+');">'+value+'</a>';
					  	}
				},
				{field: 'tentc', title: 'Tên tổ chức', width: 80, align: 'left', alignH: 'center'},
             	{field: 'masodt', title: 'Mã số đề tài', width: 80, align: 'left', alignH: 'center'},
   	          ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_detai_tochuc have dlg_detai_tochuc_show_datagrid: " + err);
    }

    try{
      $('#dlg_detai_tochuc_show').dialog({
        title: "Danh sách đề tài tổ chức ",
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
            func_deleteRow_DlgShow_detai_tochuc();
          },
          "Sửa": function () {
            loadHtml("dlg_detai_tochuc_them","./page/quanly_detai_tochuc_control.jsp", false);
            func_dlg_add_detai_tochuc(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_detai_tochuc_them","./page/quanly_detai_tochuc_control.jsp", false);
            func_dlg_add_detai_tochuc(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_detai_tochuc have dlg_detai_tochuc_show " + err);
    }
  }

  function onsubmenu_hienthi_detai_tochuc(id_detai,id_thuyetminhdetai,id_tochuc){
		loadHtml("dlg_detai_tochuc_hienthi_show","./page/quanly_detai_tochuc_hienthi.jsp", false);
		func_dlg_detai_tochuc_hienthi(id_detai,id_thuyetminhdetai,id_tochuc);
  }
</script>