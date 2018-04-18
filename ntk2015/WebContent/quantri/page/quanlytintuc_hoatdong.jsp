<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <strong>Phân loại</strong>
    <select name="dlg_tintuchoatdong_TheLoai_phanloai" id="dlg_tintuchoatdong_TheLoai_phanloai" ></select>
    <strong>Tìm tin tức</strong>
    <input  id="dl_tintuchoatdong_find_tthd" style="margin-bottom: 13px; height: 24px" >
    <input TYPE="BUTTON" NAME="" VALUE="Tìm" style="margin-bottom: 13px; height: 24px"  onclick="find_tthd()">
</div>
<table id="dlg_tintuchoatdong_show_datagrid"></table>

<script>
	$(document).ready(function() {
		cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TINTUCHOATDONG_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_tintuchoatdong_TheLoai_phanloai');
	    $('#dlg_tintuchoatdong_TheLoai_phanloai').on('change', function() {
	      if(this.value == -1){
	    	 func_dlg_tintuchoatdong_show();
		  }else{
			 getval_tintuchoatdong_show("id_phanloai_tintuc=" + this.value);
		  }
	    });
	});

  function find_tthd(){
	  var tukhoa = document.getElementById("dl_tintuchoatdong_find_tthd").value;
       var cond = "tieude ilike '%"+ tukhoa.replace("'", " '' ") +"%' or tomtat ilike '%" + tukhoa.replace("'", " '' ") +"%'";
       //alert(cond);
       getval_tintuchoatdong_show(cond);
  }	
	
  function getval_tintuchoatdong_show(sel) {
	    try {
	        $('#dlg_tintuchoatdong_show_datagrid').datagrid({
	          width: 880,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_SHOW_TINTUCHOATDONG), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_tintuc',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_tintuc',
	          columns: [[
	            {field: 'tieude', title: 'Tiêu đề', width: 80, align: 'left', alignH: 'center',
	            	formatter:function(value,row){
		          		   <%-- var url = 'print.php?id='+row.id;
		          		   return '<a target="_blank" href="' + url + '">'+value+'</a>'; --%>
		          		  return '<a href="#" onclick="onsubmenu_hienthi_tintuc('+row.id_tintuc+');">'+value+'</a>';
		          	  } 
	            },
	            {field: 'ngaytao', title: 'Ngày tạo', width: 80, align: 'center', alignH: 'center'},
	            {field: 'tomtat', title: 'Tóm tắt', width: 80, align: 'left', alignH: 'center'  },
	          ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_tintuchoatdong_show have dlg_tintuchoatdong_show_datagrid: " + err);
	      }
  }

  function func_deleteRow_DlgShow_tintuchoatdong(){
    var datagrid_id = 'dlg_tintuchoatdong_show_datagrid';
    var row = $('#' + datagrid_id).datagrid('getSelected');
    msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.tieude + ' )?',function(r){
      if(r){
        datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_tintuc', 'id_tintuc ='+row.id_tintuc);
      }
    });
  }

  function func_dlg_tintuchoatdong_show() {
    try {
      $('#dlg_tintuchoatdong_show_datagrid').datagrid({
        width: 880,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_SHOW_TINTUCHOATDONG), 
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_tintuc',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_tintuc',
        columns: [[
				{field: 'tieude', title: 'Tiêu đề', width: 80, align: 'left', alignH: 'center',
					formatter:function(value,row){
		          		   <%-- var url = 'print.php?id='+row.id;
		          		   return '<a target="_blank" href="' + url + '">'+value+'</a>'; --%>
		          		  return '<a href="#" onclick="onsubmenu_hienthi_tintuc('+row.id_tintuc+');">'+value+'</a>';
		          	  } 
				},
				{field: 'ngaytao', title: 'Ngày tạo', width: 80, align: 'center', alignH: 'center'},
				{field: 'tomtat', title: 'Tóm tắt', width: 80, align: 'left', alignH: 'center'	},
        ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_tintuchoatdong_show have dlg_tintuchoatdong_show_datagrid: " + err);
    }

    try{
      $('#dlg_tintuchoatdong_show').dialog({
        title: "Danh sách tin tức ",
        modal: false, open: function () {
          $(this).dialog('widget').draggable('option', {containment: false});
        },
        height: 500,
        width: 920,
        collapsible: true,
        draggable: true,
        resizable: false,
        position:[260,150],
        buttons: {
          "Xoá": function () {
            func_deleteRow_DlgShow_tintuchoatdong();
          },
          "Sửa": function () {
            loadHtml("dlg_tintuchoatdong_them","./page/quanlytintuc_hoatdong_control.jsp", false);
            func_dlg_add_tintuchoatdong(true);
          },
          "Thêm mới": function () {
            loadHtml("dlg_tintuchoatdong_them","./page/quanlytintuc_hoatdong_control.jsp", false);
            func_dlg_add_tintuchoatdong(false);
          },
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_tintuchoatdong_show have dlg_tintuchoatdong_show " + err);
    }
  }

  function onsubmenu_hienthi_tintuc(id_tintuc){
		loadHtml("dlg_tintuchoatdong_hienthi_show","./page/quanlytintuc_hoatdong_hienthi.jsp", false);
		func_dlg_tintuchoatdong_hienthi(id_tintuc);
  }
</script>