<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Thư mục:</strong>
    <select name="dlg_hinhanh_kqncDTDA_TheLoai_Folder" id="dlg_hinhanh_kqncDTDA_TheLoai_Folder" ></select>
</div>
<table id="dlg_hinhanh_kqncDTDA_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_FOLDER_HINHANH_DETAI_TO_CBB, 'type_media = 1', TYPE_DATA_HTML_CBB,'*', 'dlg_hinhanh_kqncDTDA_TheLoai_Folder');
	    $('#dlg_hinhanh_kqncDTDA_TheLoai_Folder').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_quanly_hinhanh_kqncDTDA();
		  }else{
			 getval_quanly_hinhanh_kqncDTDA("id_folder =" + this.value + " and type_media = 1 ");
		  }
	    });
	});

  function getval_quanly_hinhanh_kqncDTDA(sel) {
	    try {
	        $('#dlg_hinhanh_kqncDTDA_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_UPLOAD_HINHANH_DETAI), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_picture',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_picture',
	          columns: [[
	                 	{field: 'pathfile', title: 'Hình ảnh', width: 80, align: 'left', alignH: 'center',
	                 		formatter:function(value,row){    
	                        	return '<img class="item-img" src="${pageContext.request.contextPath}/'+  row.pathfile+'" style="width: 100px;"/>';    
	                    	}    
	                 	},
	                 	{field: 'tendt', title: 'Tên đề tài', width: 80, align: 'left', alignH: 'center'},
	                 	
			 ]],
	          pagination: true,
	          rownumbers: false,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_hinhanh_kqncDTDA have dlg_hinhanh_kqncDTDA_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_hinhanh_kqncDTDA(){
    var datagrid_id = 'dlg_hinhanh_kqncDTDA_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_picture + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_picture_detai', ' id_picture='+row.id_picture);
      }
    });
  }

  function func_dlg_quanly_hinhanh_kqncDTDA() {
    try {
      $('#dlg_hinhanh_kqncDTDA_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_UPLOAD_HINHANH_DETAI), 
        queryParams:{
          total: -1,
          records: 0,
          condition: " type_media = 1 "
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_picture',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_picture',
        columns: [[
					{field: 'pathfile', title: 'Hình ảnh', width: 80, align: 'left', alignH: 'center',
						formatter:function(value,row){    
                        	return '<img class="item-img" src="${pageContext.request.contextPath}/'+  row.pathfile+'" style="width: 100px;"/>';    
                    	} 
					},
					{field: 'tendt', title: 'Tên đề tài', width: 80, align: 'left', alignH: 'center'},
   	          ]],
        pagination: true,
        rownumbers: false,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_hinhanh_kqncDTDA have dlg_hinhanh_kqncDTDA_show_datagrid: " + err);
    }

    try{
      $('#dlg_hinhanh_kqncDTDA_show').dialog({
        title: "Danh sách hình ảnh nghiên cứu đề tài ",
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
            func_deleteRow_DlgShow_hinhanh_kqncDTDA();
          },
          "Upload": function () {
            loadHtml("dlg_hinhanh_kqncDTDA_them","./page/quanly_hinhanh_kqncDTDA_control.jsp", false);
            func_dlg_add_hinhanh_kqncDTDA(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_hinhanh_kqncDTDA have dlg_hinhanh_kqncDTDA_show " + err);
    }
  }

  function onsubmenu_hienthi_hinhanh_kqncDTDA(id_kh_capkinhph){
		loadHtml("dlg_hinhanh_kqncDTDA_hienthi_show","./page/quanly_hinhanh_kqncDTDA_hienthi.jsp", false);
		func_dlg_hinhanh_kqncDTDA_hienthi(id_picture);
  }
</script>