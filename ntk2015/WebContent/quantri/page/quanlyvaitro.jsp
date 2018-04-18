<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_deleteRow_DlgShow_vaitro(){
        var datagrid_id = 'dlg_vaitro_show_datagrid';
        var row = $('#' + datagrid_id).datagrid('getSelected');
        msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_vaitro + ' )?',function(r){
            if(r){
                datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_vaitro', 'id_vaitro ='+row.id_vaitro);
            }
        });
    }

    function func_dlg_vaitro_show() {
        try {
            $('#dlg_vaitro_show_datagrid').datagrid({
                width: 880,
                height: 300,
                nowrap: false,
                striped: true,
                fitColumns: true,
                singleSelect: true,
                collapsible: true,
                url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_SHOW_VAITRO),
                queryParams:{
                    total: -1,
                    records: 0
                },
                loadMsg: MSG_WAIT_LOADING,
                 sortName: 'id_vaitro',
                 sortOrder: 'asc',
                 remoteSort: false,
                 idField:'id_vaitro',
                columns: [[
                    {field: 'ten_vaitro', title: 'Tên vai trò', width: 80, align: 'left', alignH: 'center'},
                ]],
                pagination: true,
                rownumbers: true,
                onLoadSuccess: function (data) {
                }
            });
        } catch (err) {
            alert("func_dlg_vaitro_show have dlg_vaitro_show_datagrid: " + err);
        }

        try{
            $('#dlg_vaitro_show').dialog({
                title: "Danh sách vai trò ",
                modal: false, open: function () {
                    $(this).dialog('widget').draggable('option', {containment: false});
                },
                height: 430,
                width: 920,
                collapsible: true,
                draggable: true,
                resizable: false,
                position:[230,150],
                buttons: {
                    "Xoá": function () {
                        func_deleteRow_DlgShow_vaitro();
                    },
                    "Sửa": function () {
                        loadHtml("dlg_vaitro_them","./page/quanlyvaitro_control.jsp", false);
                        func_dlg_add_vaitro(/*isEdit*/true);
                    },
                    "Thêm mới": function () {
                        loadHtml("dlg_vaitro_them","./page/quanlyvaitro_control.jsp", false);
                        func_dlg_add_vaitro(false);
                    },
                    "Đóng": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });
        } catch (err) {
            alert("func_dlg_vaitro_show have dlg_vaitro_show " + err);
        }
    }
</script>
<div>
    <table id="dlg_vaitro_show_datagrid"></table>
</div>