<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Thuyết minh đề tài:</strong>
    <select name="dlg_bb_kiemphieu_TheLoai_Detai" id="dlg_bb_kiemphieu_TheLoai_Detai" ></select>
</div>
<table id="dlg_bb_kiemphieu_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_bb_kiemphieu_TheLoai_Detai');
	    $('#dlg_bb_kiemphieu_TheLoai_Detai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_bb_kiemphieu();
		  }else{
			 getval_quanly_bb_kiemphieu("id_thuyetminh_detai =" + this.value);
		  }
	    });
	});

  function getval_quanly_bb_kiemphieu(sel) {
	    try {
	        $('#dlg_bb_kiemphieu_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_BIENBAN_KIEMPHIEU), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_thuyetminh_detai',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_thuyetminh_detai',
	          columns: [[
				{field: 'tenfile', title: 'Tên file', width: 80, align: 'left', alignH: 'center',
					formatter:function(value,row){
						  return '<a href="#" onclick="onsubmenu_hienthi_bb_kiemphieu('+row.id_thuyetminh_detai+');">'+value+'</a>';
					  	}
				},
   				{field: 'diemtb', title: 'Điểm trung bình', width: 80, align: 'left', alignH: 'center',},
				{field: 'ngay', title: 'Thời gian', width: 80, align: 'center', alignH: 'center',
					  formatter:function(value,row){
			      		  return gm.date.Int2DateString(row.ngay);
			      	  }  
				}
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_bb_kiemphieu have dlg_bb_kiemphieu_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_bb_kiemphieu(){
    var datagrid_id = 'dlg_bb_kiemphieu_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.tieude + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_bienban_kiemphieu', 'id_thuyetminh_detai ='+row.id_thuyetminh_detai);
      }
    });
  }

  function func_dlg_quanly_bb_kiemphieu() {
    try {
      $('#dlg_bb_kiemphieu_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_BIENBAN_KIEMPHIEU), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_thuyetminh_detai',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_thuyetminh_detai',
        columns: [[
               	{field: 'tenfile', title: 'Tên file', width: 80, align: 'left', alignH: 'center',
					formatter:function(value,row){
						  return '<a href="#" onclick="onsubmenu_hienthi_bb_kiemphieu('+row.id_thuyetminh_detai+');">'+value+'</a>';
					  	}
				},
   				{field: 'diemtb', title: 'Điểm trung bình', width: 80, align: 'left', alignH: 'center',},
				{field: 'ngay', title: 'Thời gian', width: 80, align: 'center', alignH: 'center',
					  formatter:function(value,row){
			      		  return gm.date.Int2DateString(row.ngay);
			      	  }  
				}
   	          ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_bb_kiemphieu have dlg_bb_kiemphieu_show_datagrid: " + err);
    }

    try{
      $('#dlg_bb_kiemphieu_show').dialog({
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
            func_deleteRow_DlgShow_bb_kiemphieu();
          },
          "Sửa": function () {
            loadHtml("dlg_bb_kiemphieu_them","./page/quanlybb_kiemphieu_control.jsp", false);
            func_dlg_add_bb_kiemphieu(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_bb_kiemphieu_them","./page/quanlybb_kiemphieu_control.jsp", false);
            func_dlg_add_bb_kiemphieu(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_bb_kiemphieu have dlg_bb_kiemphieu_show " + err);
    }
  }

  function onsubmenu_hienthi_bb_kiemphieu(id_thuyetminh_detai){
		loadHtml("dlg_bb_kiemphieu_hienthi_show","./page/quanlybb_kiemphieu_hienthi.jsp", false);
		func_dlg_bb_kiemphieu_hienthi(id_thuyetminh_detai);
  }
</script>