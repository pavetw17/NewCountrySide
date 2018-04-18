<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Thuyết minh đề tài:</strong>
    <select name="dlg_sanpham_TheLoai_TMDeTai" id="dlg_sanpham_TheLoai_TMDeTai" ></select>
</div>
<table id="dlg_sanpham_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_sanpham_TheLoai_TMDeTai');
	    $('#dlg_sanpham_TheLoai_TMDeTai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_sanpham();
		  }else{
			 getval_quanly_sanpham("id_thuyetminh_detai =" + this.value);
		  }
	    });
	});

  function getval_quanly_sanpham(sel) {
	    try {
	        $('#dlg_sanpham_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_SANPHAM), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_sanpham',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_sanpham',
	          columns: [[
	                 	{field: 'tensanpham', title: 'Tên sản phẩm', width: 80, align: 'left', alignH: 'center',
	    					formatter:function(value,row){
	    						  return '<a href="#" onclick="onsubmenu_hienthi_sanpham('+row.id_sanpham+');">'+value+'</a>';
	    					  	}
	    				},
	    				{field: 'chitieuchatluong', title: 'Chỉ tiêu chất lượng', width: 80, align: 'left', alignH: 'center'},
	    				{field: 'donvido', title: 'Đơn vị đo', width: 80, align: 'left', alignH: 'center'}
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_sanpham have dlg_sanpham_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_sanpham(){
    var datagrid_id = 'dlg_sanpham_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.maso + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_sanpham', ' id_thuyetminh_detail='+row.id_thuyetminh_detai +' and id_thuyetminhdetai='+row.id_thuyetminhdetai+' and id_thuyetminh_detai ='+row.id_thuyetminh_detai);
      }
    });
  }

  function func_dlg_quanly_sanpham() {
    try {
      $('#dlg_sanpham_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_SANPHAM), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_sanpham',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_sanpham',
        columns: [[
               	{field: 'tensanpham', title: 'Tên sản phẩm', width: 80, align: 'left', alignH: 'center',
					formatter:function(value,row){
						  return '<a href="#" onclick="onsubmenu_hienthi_sanpham('+row.id_sanpham+');">'+value+'</a>';
					  	}
				},
				{field: 'chitieuchatluong', title: 'Chỉ tiêu chất lượng', width: 80, align: 'left', alignH: 'center'},
				{field: 'donvido', title: 'Đơn vị đo', width: 80, align: 'left', alignH: 'center'}
   	          ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_sanpham have dlg_sanpham_show_datagrid: " + err);
    }

    try{
      $('#dlg_sanpham_show').dialog({
        title: "Danh sách sản phẩm",
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
            func_deleteRow_DlgShow_sanpham();
          },
          "Sửa": function () {
            loadHtml("dlg_sanpham_them","./page/quanly_sanpham_control.jsp", false);
            func_dlg_add_sanpham(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_sanpham_them","./page/quanly_sanpham_control.jsp", false);
            func_dlg_add_sanpham(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_sanpham have dlg_sanpham_show " + err);
    }
  }

  function onsubmenu_hienthi_sanpham(id_sanpham){
		loadHtml("dlg_sanpham_hienthi_show","./page/quanly_sanpham_hienthi.jsp", false);
		func_dlg_sanpham_hienthi(id_sanpham);
  }
</script>