<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Thuyết minh đề tài:</strong>
    <select name="dlg_tiendo_giaingan_TheLoai_TMDeTai" id="dlg_tiendo_giaingan_TheLoai_TMDeTai" ></select>
</div>
<table id="dlg_tiendo_giaingan_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_tiendo_giaingan_TheLoai_TMDeTai');
	    $('#dlg_tiendo_giaingan_TheLoai_TMDeTai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_tiendo_giaingan();
		  }else{
			 getval_quanly_tiendo_giaingan("id_thuyetminhdetai =" + this.value);
		  }
	    });
	});

  function getval_quanly_tiendo_giaingan(sel) {
	    try {
	        $('#dlg_tiendo_giaingan_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_TIENDO_GIAINGAN), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_tiendogiaingan',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_tiendogiaingan',
	          columns: [[
						{field: 'tentc', title: 'Tên tổ chức', width: 80, align: 'left', alignH: 'center',
							formatter:function(value,row){
								  return '<a href="javascript:void(0) onclick="onsubmenu_hienthi_tiendo_giaingan('+row.id_tiendogiaingan+');">'+value+'</a>';
							  	}
						},
					 	{field: 'tendt', title: 'Tên đề tài', width: 80, align: 'left', alignH: 'center'},
	                 	{field: 'sotien', title: 'Số tiền', width: 80, align: 'left', alignH: 'center'},
	                 	{field: 'ghichu', title: 'Ghi chú', width: 80, align: 'left', alignH: 'center'},
	                 	{field: 'ngaygiaingan', title: 'Ngày giải ngân', width: 80, align: 'left', alignH: 'center',
	                 		 formatter:function(value,row){
		                  		  return gm.date.Int2DateString(row.ngaygiaingan);
		                  	  }  	
	                 	},
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_tiendo_giaingan have dlg_tiendo_giaingan_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_tiendo_giaingan(){
    var datagrid_id = 'dlg_tiendo_giaingan_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_tiendogiaingan + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_tiendo_giaingan', ' id_tiendogiaingan='+row.id_tiendogiaingan);
      }
    });
  }

  function func_dlg_quanly_tiendo_giaingan() {
    try {
      $('#dlg_tiendo_giaingan_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_TIENDO_GIAINGAN), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_tiendogiaingan',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_tiendogiaingan',
        columns: [[
				{field: 'tentc', title: 'Tên tổ chức', width: 80, align: 'left', alignH: 'center',
					formatter:function(value,row){
						  return '<a href="javascript:void(0)" onclick="onsubmenu_hienthi_tiendo_giaingan('+row.id_tiendogiaingan+');">'+value+'</a>';
					  	}
				},
               	{field: 'tendt', title: 'Tên đề tài', width: 80, align: 'left', alignH: 'center'},
               	{field: 'sotien', title: 'Số tiền', width: 80, align: 'left', alignH: 'center'},
             	{field: 'ghichu', title: 'Ghi chú', width: 80, align: 'left', alignH: 'center'},
             	{field: 'ngaygiaingan', title: 'Ngày giải ngân', width: 80, align: 'left', alignH: 'center',
             		 formatter:function(value,row){
                  		  return gm.date.Int2DateString(row.ngaygiaingan);
                  	  }  	
             	},
   	          ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_tiendo_giaingan have dlg_tiendo_giaingan_show_datagrid: " + err);
    }

    try{
      $('#dlg_tiendo_giaingan_show').dialog({
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
            func_deleteRow_DlgShow_tiendo_giaingan();
          },
          "Sửa": function () {
            loadHtml("dlg_tiendo_giaingan_them","./page/quanly_tiendo_giaingan_control.jsp", false);
            func_dlg_add_tiendo_giaingan(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_tiendo_giaingan_them","./page/quanly_tiendo_giaingan_control.jsp", false);
            func_dlg_add_tiendo_giaingan(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_tiendo_giaingan have dlg_tiendo_giaingan_show " + err);
    }
  }

  function onsubmenu_hienthi_tiendo_giaingan(id_tiendogiaingan){
		loadHtml("dlg_tiendo_giaingan_hienthi_show","./page/quanly_tiendo_giaingan_hienthi.jsp", false);
		func_dlg_tiendo_giaingan_hienthi(id_tiendogiaingan);
  }
</script>