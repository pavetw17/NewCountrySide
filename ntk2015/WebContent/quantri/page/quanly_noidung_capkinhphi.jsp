<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Thuyết minh đề tài:</strong>
    <select name="dlg_noidung_capkinhphi_TheLoai_TMDeTai" id="dlg_noidung_capkinhphi_TheLoai_TMDeTai" ></select>
   
     <strong>Tiến độ cấp kinh phí:</strong>
    <select name="dlg_noidung_capkinhphi_GhiChu" id="dlg_noidung_capkinhphi_GhiChu" ></select>
</div>
<table id="dlg_noidung_capkinhphi_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_noidung_capkinhphi_TheLoai_TMDeTai');
	    
		$('#dlg_noidung_capkinhphi_TheLoai_TMDeTai').on('change', function() {
			 if(this.value == -1){
				 $('#dlg_noidung_capkinhphi_GhiChu').text('');
				 func_dlg_quanly_noidung_capkinhphi();
			 }else{
				 cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_KH_CAPKINHPHI_CBB, 'id_thuyetminhdetai =' + this.value , TYPE_DATA_HTML_CBB,'*', 'dlg_noidung_capkinhphi_GhiChu');
				 getval_quanly_noidung_capkinhphi("id_thuyetminhdetai =" + this.value  );
			 }
		});
		
		$('#dlg_noidung_capkinhphi_GhiChu').on('change', function() {
	      var id_thuyetminhdetai = 	$('#dlg_noidung_capkinhphi_TheLoai_TMDeTai').val();
	      if(this.value == -1){
	    	  getval_quanly_noidung_capkinhphi("id_thuyetminhdetai =" + id_thuyetminhdetai  );
		  }else{
			 getval_quanly_noidung_capkinhphi("id_thuyetminhdetai =" + id_thuyetminhdetai + " and id_tiendo_capkinhphi = " + this.value );
		  }
	    }); 
	});

  function getval_quanly_noidung_capkinhphi(sel) {
	    try {
	        $('#dlg_noidung_capkinhphi_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_NOIDUNG_CAPKINHPHI), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_tiendo_capkinhphi',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_tiendo_capkinhphi',
	          columns: [[
					{field: 'tentc', title: 'Tên tổ chức', width: 80, align: 'left', alignH: 'center',
							formatter:function(value,row){
								  return '<a href="javascript:;" onclick="onsubmenu_hienthi_noidung_capkinhphi('+row.id_tiendo_capkinhphi+');">'+value+'</a>';
							  	}
						},
						{field: 'tendt', title: 'Tên đề tài', width: 80, align: 'left', alignH: 'center'},
	                 	{field: 'sotien', title: 'Số tiền', width: 80, align: 'left', alignH: 'center'},
	                 	{field: 'ten_noidung', title: 'Tên nội dung', width: 80, align: 'left', alignH: 'center'},
			 ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_quanly_noidung_capkinhphi have dlg_noidung_capkinhphi_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_noidung_capkinhphi(){
    var datagrid_id = 'dlg_noidung_capkinhphi_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_tiendo_capkinhphi + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_noidung_capkinhphi', ' id_tiendo_capkinhphi='+row.id_tiendo_capkinhphi );
      }
    });
  }

  function func_dlg_quanly_noidung_capkinhphi() {
    try {
      $('#dlg_noidung_capkinhphi_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_NOIDUNG_CAPKINHPHI), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_tiendo_capkinhphi',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_tiendo_capkinhphi',
        columns: [[
					{field: 'tentc', title: 'Tên tổ chức', width: 80, align: 'left', alignH: 'center',
						formatter:function(value,row){
							  return '<a href="javascript:;" onclick="onsubmenu_hienthi_noidung_capkinhphi('+row.id_tiendo_capkinhphi+');">'+value+'</a>';
						  	}
					},
					{field: 'tendt', title: 'Tên đề tài', width: 80, align: 'left', alignH: 'center'},
					{field: 'sotien', title: 'Số tiền', width: 80, align: 'left', alignH: 'center'},
					{field: 'ten_noidung', title: 'Tên nội dung', width: 80, align: 'left', alignH: 'center'},
   	          ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_quanly_noidung_capkinhphi have dlg_noidung_capkinhphi_show_datagrid: " + err);
    }

    try{
      $('#dlg_noidung_capkinhphi_show').dialog({
        title: "Danh sách tiến độ cấp kinh phí ",
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
            func_deleteRow_DlgShow_noidung_capkinhphi();
          },
          "Sửa": function () {
            loadHtml("dlg_noidung_capkinhphi_them","./page/quanly_noidung_capkinhphi_control.jsp", false);
            func_dlg_add_noidung_capkinhphi(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_noidung_capkinhphi_them","./page/quanly_noidung_capkinhphi_control.jsp", false);
            func_dlg_add_noidung_capkinhphi(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_noidung_capkinhphi have dlg_noidung_capkinhphi_show " + err);
    }
  }

  function onsubmenu_hienthi_noidung_capkinhphi(id_tiendo_capkinhphi){
		loadHtml("dlg_noidung_capkinhphi_hienthi_show","./page/quanly_noidung_capkinhphi_hienthi.jsp", false);
		func_dlg_noidung_capkinhphi_hienthi(id_tiendo_capkinhphi);
  }
</script>