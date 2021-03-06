<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_deleteRow_DlgShow_phanloai_phieu(){
        var datagrid_id = 'dlg_phanloai_phieu_show_datagrid';
        var row = $('#' + datagrid_id).datagrid('getSelected');
        msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_phanloaiphieu + ' )?',function(r){
            if(r){
                datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_phanloai_phieu', 'id_phanloaiphieu ='+row.id_phanloaiphieu);
            }
        });
    }

    function func_dlg_phanloai_phieu_show() {
        try {
            $('#dlg_phanloai_phieu_show_datagrid').datagrid({
                width: 880,
                height: 300,
                nowrap: false,
                striped: true,
                fitColumns: true,
                singleSelect: true,
                collapsible: true,
                url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_SHOW_PHANLOAI_PHIEU),
                queryParams:{
                    total: -1,
                    records: 0
                },
                loadMsg: MSG_WAIT_LOADING,
                 sortName: 'id_phanloaiphieu',
                 sortOrder: 'asc',
                 remoteSort: false,
                 idField:'id_phanloaiphieu',
                columns: [[
                    {field: 'ten_phanloai_phieu', title: 'Tên phiếu', width: 80, align: 'left', alignH: 'center'},
                ]],
                pagination: true,
                rownumbers: true,
                onLoadSuccess: function (data) {
                }
            });
        } catch (err) {
            alert("func_dlg_phanloai_phieu_show have dlg_phanloai_phieu_show_datagrid: " + err);
        }

        try{
            $('#dlg_phanloai_phieu_show').dialog({
                title: "Danh sách phiếu ",
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
                        func_deleteRow_DlgShow_phanloai_phieu();
                    },
                    "Sửa": function () {
                        loadHtml("dlg_phanloai_phieu_them","./page/quanlyphanloai_phieu_control.jsp", false);
                        func_dlg_add_phanloai_phieu(/*isEdit*/true);
                    },
                    "Thêm mới": function () {
                        loadHtml("dlg_phanloai_phieu_them","./page/quanlyphanloai_phieu_control.jsp", false);
                        func_dlg_add_phanloai_phieu(false);
                    },
                    "Đóng": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });
        } catch (err) {
            alert("func_dlg_phanloai_phieu_show have dlg_phanloai_phieu_show " + err);
        }
    }
</script>
<div>
    <table id="dlg_phanloai_phieu_show_datagrid"></table>
</div>