<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Nhóm nội dung:</strong>
    <select name="dlg_noidungcv_con_TheLoai_TMDeTai" id="dlg_noidungcv_con_TheLoai_TMDeTai" ></select>
</div>
<table id="dlg_noidungcv_con_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_NOIDUNG_THUYETMINH_NHOM_TO_CBB, 'id_noidung_cha is null', TYPE_DATA_HTML_CBB,'*', 'dlg_noidungcv_con_TheLoai_TMDeTai');
	    $('#dlg_noidungcv_con_TheLoai_TMDeTai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_noidungcv_con();
		  }else{
			  getval_quanly_noidungcv_con("id_noidung_cha=" + this.value);
		  }
	    });
	});

  function getval_quanly_noidungcv_con(sel) {
	    try {
	        $('#dlg_noidungcv_con_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_NOIDUNG_THUYETMINH_CON), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_noidung',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_noidung',
	          columns: [[
	                 	{field: 'tentc', title: 'Tên tổ chức', width: 80, align: 'left', alignH: 'center',
	                 		formatter:function(value,row){
								  return '<a href="javascript:;" onclick="onsubmenu_hienthi_noidungcv_con('+row.id_noidung+');">'+value+'</a>';
							  	}	
	                 	},
	                 	{field: 'ten_noidung', title: 'Tên nội dung', width: 80, align: 'left', alignH: 'center'},
	                 	{field: 'thoigian_batdau', title: 'Thời gian bắt đầu', width: 80, align: 'left', alignH: 'center',
	                 		 formatter:function(value,row){
	   			      		  return gm.date.Int2DateString(row.thoigian_batdau);
	   			      	  } 	
	                 	},
	                 	{field: 'thoigian_ketthuc', title: 'Thời gian kết thúc', width: 80, align: 'left', alignH: 'center',
	                 		 formatter:function(value,row){
	   			      		  return gm.date.Int2DateString(row.thoigian_ketthuc);
	   			      	  } 	
	                 	},
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_noidungcv_con have dlg_noidungcv_con_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_noidungcv_con(){
    var datagrid_id = 'dlg_noidungcv_con_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_noidung + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_phanbovon_theohangmuc', ' id_noidung='+row.id_noidung);
      }
    });
  }

  function func_dlg_quanly_noidungcv_con() {
    try {
      $('#dlg_noidungcv_con_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_NOIDUNG_THUYETMINH_CON), 
        queryParams:{
          total: -1,
          records: 0,
          condition: 'id_noidung_cha is not null'
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_noidung',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_noidung',
        columns: [[
				    {field: 'tentc', title: 'Tên tổ chức', width: 80, align: 'left', alignH: 'center',
				    	formatter:function(value,row){
							  return '<a href="javascript:;" onclick="onsubmenu_hienthi_noidungcv_con('+row.id_noidung+');">'+value+'</a>';
						  	}	
				    },
					{field: 'ten_noidung', title: 'Tên nội dung', width: 80, align: 'left', alignH: 'center'},
					{field: 'thoigian_batdau', title: 'Thời gian bắt đầu', width: 80, align: 'left', alignH: 'center',
						 formatter:function(value,row){
				 		  return gm.date.Int2DateString(row.thoigian_batdau);
				 	  } 	
					},
					{field: 'thoigian_ketthuc', title: 'Thời gian kết thúc', width: 80, align: 'left', alignH: 'center',
						 formatter:function(value,row){
				 		  return gm.date.Int2DateString(row.thoigian_ketthuc);
				 	  } 	
					},
		 ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_noidungcv_con have dlg_noidungcv_con_show_datagrid: " + err);
    }

    try{
      $('#dlg_noidungcv_con_show').dialog({
        title: "Danh sách nhóm nội dung công việc cụ thể ",
        modal: false, open: function () {
          $(this).dialog('widget').draggable('option', {containment: false});
        },
        height: 460,
        width: 920,
        collapsible: true,
        draggable: true,
        resizable: false,
        position:[250,110],
        buttons: {
          "Xoá": function () {
            func_deleteRow_DlgShow_noidungcv_con();
          },
          "Sửa": function () {
            loadHtml("dlg_noidungcv_con_them","./page/quanly_noidungcv_con_control.jsp", false);
            func_dlg_add_noidungcv_con(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_noidungcv_con_them","./page/quanly_noidungcv_con_control.jsp", false);
            func_dlg_add_noidungcv_con(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_noidungcv_con have dlg_noidungcv_con_show " + err);
    }
  }

  function onsubmenu_hienthi_noidungcv_con(id_noidung){
		loadHtml("dlg_noidungcv_con_hienthi_show","./page/quanly_noidungcv_con_hienthi.jsp", false);
		func_dlg_noidungcv_con_hienthi(id_noidung);
  }
</script>