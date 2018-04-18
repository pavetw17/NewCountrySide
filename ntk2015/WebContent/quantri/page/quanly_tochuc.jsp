<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
         
<style type="text/css">
.classFirstDialog{
    margin-right:400px !important;
}
</style> 
<script>
    function func_deleteRow_DlgShow_tochuc(){
        var datagrid_id = 'dlg_tochuc_show_datagrid';
        var row = $('#' + datagrid_id).datagrid('getSelected');
        msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_tochuc + ' )?',function(r){
            if(r){
                datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_tochuc', 'id_tochuc ='+row.id_tochuc);
            }
        });
    }

    function func_dlg_tochuc_show() {
        try {
            $('#dlg_tochuc_show_datagrid').datagrid({
                width: 880,
                height: 300,
                nowrap: false,
                striped: true,
                fitColumns: true,
                singleSelect: true,
                collapsible: true,
                url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_TOCHUC),
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
                    {field: 'tentc', title: 'Tên tổ chức', width: 80, align: 'left', alignH: 'center'},
                    {field: 'phonecq', title: 'Điện thoại', width: 80, align: 'left', alignH: 'center'},
                    {field: 'diachi_coquan', title: 'Địa chỉ', width: 80, align: 'left', alignH: 'center'},
                    {field: 'email', title: 'Email', width: 80, align: 'left', alignH: 'center'},
                    {field: 'so_canbo_trinhdo_dh', title: 'Số cán bộ đại học', width: 80, align: 'left', alignH: 'center'},
                    {field: 'so_canbo_trinhdo_ths', title: 'Số cán bộ thạc sĩ', width: 80, align: 'left', alignH: 'center'},
                    {field: 'so_canbo_trinhdo_ts', title: 'Số cán bộ tiến sĩ', width: 80, align: 'left', alignH: 'center'},
                ]],
                pagination: true,
                rownumbers: true,
                onLoadSuccess: function (data) {
                }
            });
        } catch (err) {
            alert("func_dlg_tochuc_show have dlg_tochuc_show_datagrid: " + err);
        }

        try{
            $('#dlg_tochuc_show').dialog({
                title: "Danh sách tổ chức ",
                modal: false, open: function () {
                    $(this).dialog('widget').draggable('option', {containment: false});
                },
                height: 430,
                width: 920,
                collapsible: true,
                draggable: true,
                resizable: false,
                position:[230,150],
                buttons: [
					{   text: "Danh sách nhân sự",
					    "class": 'classFirstDialog',
					    click: function() {
					    	loadHtml("dlg_nhansu_show","./page/quanly_nhansu.jsp", false);
	                      	func_dlg_nhansu_show();
					    }
					},
					{   text: "Xoá",
					    click: function() {
					    	func_deleteRow_DlgShow_tochuc();
					    }
					},
					{   text: "Sửa",
					    click: function() {
					    	 loadHtml("dlg_tochuc_them","./page/quanly_tochuc_control.jsp", false); 
			                 func_dlg_add_tochuc(/*isEdit*/true);
					    }
					},
					{   text: "Thêm mới",
					    click: function() {
					    	loadHtml("dlg_tochuc_them","./page/quanly_tochuc_control.jsp", false);
	                        func_dlg_add_tochuc(false);
					    }
					},
					{   text: "Đóng",
					    click: function() {
					    	  $(this).dialog("close");
					    }
					},
               ],
                close: function () {
                }
            });
        } catch (err) {
            alert("func_dlg_tochuc_show have dlg_tochuc_show " + err);
        }
    }
</script>
<div>
    <table id="dlg_tochuc_show_datagrid"></table>
</div>