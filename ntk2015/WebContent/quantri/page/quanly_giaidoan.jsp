<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Thuyết minh đề tài:</strong>
    <select name="dlg_giaidoan_TheLoai_TMDeTai" id="dlg_giaidoan_TheLoai_TMDeTai" ></select>
</div>
<table id="dlg_giaidoan_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_giaidoan_TheLoai_TMDeTai');
	    $('#dlg_giaidoan_TheLoai_TMDeTai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_giaidoan();
		  }else{
			 getval_quanly_giaidoan("id_thuyetminh_detai =" + this.value);
		  }
	    });
	});

  function getval_quanly_giaidoan(sel) {
	    try {
	        $('#dlg_giaidoan_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_GIAIDOAN), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_giaidoan',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_giaidoan',
	          columns: [[
	                 	{field: 'tengiaidoan', title: 'Tên giai đoạn', width: 80, align: 'left', alignH: 'center',
	    					/* formatter:function(value,row){
	    						  return '<a href="#" onclick="onsubmenu_hienthi_giaidoan('+row.id_giaidoan+');">'+value+'</a>';
	    					  	} */
	    				},
	    				{field: 'masodt', title: 'Mã thuyết minh', width: 80, align: 'left', alignH: 'center'},
	    				{field: 'noidung', title: 'Nội dung', width: 80, align: 'left', alignH: 'center'},
	       				{field: 'tungay', title: 'Từ ngày', width: 80, align: 'left', alignH: 'center',
	       				 formatter:function(value,row){
	                  		  return gm.date.Int2DateString(row.tungay);
	                  	  }  	
	       				},
	       				{field: 'denngay', title: 'Đến ngày', width: 80, align: 'left', alignH: 'center',
	       				 formatter:function(value,row){
	                  		  return gm.date.Int2DateString(row.denngay);
	                  	  }  
	       				},
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_giaidoan have dlg_giaidoan_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_giaidoan(){
    var datagrid_id = 'dlg_giaidoan_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_giaidoan + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_giaidoan', 'id_giaidoan ='+row.id_giaidoan);
      }
    });
  }

  function func_dlg_quanly_giaidoan() {
    try {
      $('#dlg_giaidoan_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_GIAIDOAN), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_giaidoan',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_giaidoan',
        columns: [[
				{field: 'tengiaidoan', title: 'Tên giai đoạn', width: 80, align: 'left', alignH: 'center',
					/* formatter:function(value,row){
						  return '<a href="#" onclick="onsubmenu_hienthi_giaidoan('+row.id_giaidoan+');">'+value+'</a>';
					  	} */
				},
				{field: 'masodt', title: 'Mã thuyết minh', width: 80, align: 'left', alignH: 'center'},
				{field: 'noidung', title: 'Nội dung', width: 80, align: 'left', alignH: 'center'},
				{field: 'tungay', title: 'Từ ngày', width: 80, align: 'left', alignH: 'center',
      				 formatter:function(value,row){
                 		  return gm.date.Int2DateString(row.tungay);
                 	  }  	
      				},
      				{field: 'denngay', title: 'Đến ngày', width: 80, align: 'left', alignH: 'center',
      				 formatter:function(value,row){
                 		  return gm.date.Int2DateString(row.denngay);
                 	  }  
      				},
   	          ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_giaidoan have dlg_giaidoan_show_datagrid: " + err);
    }

    try{
      $('#dlg_giaidoan_show').dialog({
        title: "Danh sách giai đoạn ",
        modal: false, open: function () {
          $(this).dialog('widget').draggable('option', {containment: false});
        },
        height: 460,
        width: 920,
        collapsible: true,
        draggable: true,
        resizable: false,
        position:[200,80],
        buttons: {
          "Xoá": function () {
            func_deleteRow_DlgShow_giaidoan();
          },
          "Sửa": function () {
            loadHtml("dlg_giaidoan_them","./page/quanly_giaidoan_control.jsp", false);
            func_dlg_add_giaidoan(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_giaidoan_them","./page/quanly_giaidoan_control.jsp", false);
            func_dlg_add_giaidoan(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_giaidoan have dlg_giaidoan_show " + err);
    }
  }

  function onsubmenu_hienthi_giaidoan(id_giaidoan){
		loadHtml("dlg_giaidoan_hienthi_show","./page/quanly_giaidoan_hienthi.jsp", false);
		func_dlg_giaidoan_hienthi(id_giaidoan);
  }
</script>