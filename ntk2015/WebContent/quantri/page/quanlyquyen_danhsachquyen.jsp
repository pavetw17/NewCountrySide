<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_deleteRow_DlgShow_qlquyen_dsquyen(){
        var datagrid_id = 'dlg_qlquyen_dsquyen_show_datagrid';
        var row = $('#' + datagrid_id).datagrid('getSelected');
        msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_quyen + ' )?',function(r){
            if(r){
                datagrid_delete_row(root_href + QUYEN_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_phan_quyen', 'id_quyen ='+row.id_quyen);
            }
        });
    }

    function func_dlg_qlquyen_dsquyen_show() {
        try {
            $('#dlg_qlquyen_dsquyen_show_datagrid').datagrid({
                width: 880,
                height: 300,
                nowrap: false,
                striped: true,
                fitColumns: true,
                singleSelect: true,
                collapsible: true,
                url:( root_href + QUYEN_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_SHOW_DANHSACHQUYEN),
                queryParams:{
                    total: -1,
                    records: 0
                },
                loadMsg: MSG_WAIT_LOADING,
                 sortName: 'id_quyen',
                 sortOrder: 'asc',
                 remoteSort: false,
                 idField:'id_quyen',
                columns: [[
                    {field: 'id_quyen', title: 'Mã quyền', width: 80, align: 'left', alignH: 'center'},
                    {field: 'ten_quyen', title: 'Tên quyền', width: 80, align: 'left', alignH: 'center'},
                ]],
                pagination: true,
                rownumbers: true,
                onLoadSuccess: function (data) {
                }
            });
        } catch (err) {
            alert("func_dlg_qlquyen_dsquyen_show have dlg_qlquyen_dsquyen_show_datagrid: " + err);
        }

        try{
            $('#dlg_qlquyen_dsquyen_show').dialog({
                title: "Danh sách phân quyền ",
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
                        func_deleteRow_DlgShow_qlquyen_dsquyen();
                    },
                    "Sửa": function () {
                        loadHtml("dlg_qlquyen_dsquyen_them","./page/quanlyquyen_danhsachquyen_control.jsp", false);
                        func_dlg_add_qlquyen_dsquyen(/*isEdit*/true);
                    },
                    "Thêm mới": function () {
                        loadHtml("dlg_qlquyen_dsquyen_them","./page/quanlyquyen_danhsachquyen_control.jsp", false);
                        func_dlg_add_qlquyen_dsquyen(false);
                    },
                    "Đóng": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });
        } catch (err) {
            alert("func_dlg_qlquyen_dsquyen_show have dlg_qlquyen_dsquyen_show " + err);
        }
    }
</script>
<div>
    <table id="dlg_qlquyen_dsquyen_show_datagrid"></table>
</div>