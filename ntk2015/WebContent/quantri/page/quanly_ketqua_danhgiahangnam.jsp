<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Phân loại xã điểm</strong>
    <select name="dlg_ketqua_danhgiahangnam_TheLoai_phanloai" id="dlg_ketqua_danhgiahangnam_TheLoai_phanloai" ></select>
   
</div>
<table id="dlg_ketqua_danhgiahangnam_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_XADIEM_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_ketqua_danhgiahangnam_TheLoai_phanloai');
	    $('#dlg_ketqua_danhgiahangnam_TheLoai_phanloai').on('change', function() {
	      if(this.value == -1){
	    	  func_dlg_quanly_ketqua_danhgiahangnam();
		  }else{
			 getval_ketqua_danhgiahangnam_show("a.id_xadiem=" + this.value);
		  }
	    });
	});


  function getval_ketqua_danhgiahangnam_show(sel) {
	    try {
	        $('#dlg_ketqua_danhgiahangnam_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_KETQUA_DANHGIA_HANGNAM), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id',
	          columns: [[
	            {field: 'tieuchi_ungdung_khcn', title: 'Tiêu chí ứng dụng KHCN', width: 80, align: 'left', alignH: 'center',
	            	 formatter:function(value,row){
	   				  return '<a href="#" onclick="onsubmenu_hienthi_ketqua_danhgiahangnam('+row.id+');">'+value+'</a>';
	   			  	}
	            },
	            {field: 'ten_xadiem', title: 'Tên xã', width: 80, align: 'left', alignH: 'center'},
	            {field: 'ngay_danhgia', title: 'Ngày tạo', width: 80, align: 'center', alignH: 'center',
	          	  formatter:function(value,row){
	            		  return gm.date.Int2DateString(row.ngay_danhgia);
	            	  } 
	            },
	            {field: 'tiendo_hoanthanh', title: 'Tiến độ hoàn thành', width: 80, align: 'left', alignH: 'center',
	            },
	          ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_ketqua_danhgiahangnam_show have dlg_ketqua_danhgiahangnam_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_ketqua_danhgiahangnam(){
    var datagrid_id = 'dlg_ketqua_danhgiahangnam_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.ten_xadiem + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_baiviet', 'id ='+row.id);
      }
    });
  }

  function func_dlg_quanly_ketqua_danhgiahangnam () {
    try {
      $('#dlg_ketqua_danhgiahangnam_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_KETQUA_DANHGIA_HANGNAM), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id',
        columns: [[
          {field: 'tieuchi_ungdung_khcn', title: 'Tiêu chí ứng dụng KHCN', width: 80, align: 'left', alignH: 'center',
        	  formatter:function(value,row){
				  return '<a href="#" onclick="onsubmenu_hienthi_ketqua_danhgiahangnam('+row.id+');">'+value+'</a>';
			  	}
          },
          {field: 'ten_xadiem', title: 'Tên xã', width: 80, align: 'left', alignH: 'center'},
          {field: 'ngay_danhgia', title: 'Ngày tạo', width: 80, align: 'center', alignH: 'center',
        	  formatter:function(value,row){
          		  return gm.date.Int2DateString(row.ngay_danhgia);
          	  } 
          },
          {field: 'tiendo_hoanthanh', title: 'Tiến độ hoàn thành', width: 80, align: 'left', alignH: 'center',
          },
        ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_ketqua_danhgiahangnam_show have dlg_ketqua_danhgiahangnam_show_datagrid: " + err);
    }

    try{
      $('#dlg_ketqua_danhgiahangnam_show').dialog({
        title: "Danh sách đánh giá ",
        modal: false, open: function () {
          $(this).dialog('widget').draggable('option', {containment: false});
        },
        height: 480,
        width: 920,
        collapsible: true,
        draggable: true,
        resizable: false,
        position:[260,150],
        buttons: {
          "Xoá": function () {
            func_deleteRow_DlgShow_ketqua_danhgiahangnam();
          },
          "Sửa": function () {
            loadHtml("dlg_ketqua_danhgiahangnam_them","./page/quanly_ketqua_danhgiahangnam_control.jsp", false);
            func_dlg_add_ketqua_danhgiahangnam(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_ketqua_danhgiahangnam_them","./page/quanly_ketqua_danhgiahangnam_control.jsp", false);
            func_dlg_add_ketqua_danhgiahangnam(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_ketqua_danhgiahangnam_show have dlg_ketqua_danhgiahangnam_show " + err);
    }
  }

  function onsubmenu_hienthi_ketqua_danhgiahangnam(id){
		loadHtml("dlg_ketqua_danhgiahangnam_hienthi_show","./page/quanly_ketqua_danhgiahangnam_hienthi.jsp", false);
		func_dlg_ketqua_danhgiahangnam_hienthi(id);
  }
</script>