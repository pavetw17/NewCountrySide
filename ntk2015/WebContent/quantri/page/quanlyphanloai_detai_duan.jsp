<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_deleteRow_DlgShow_phanloai_detai_duan(){
        var datagrid_id = 'dlg_phanloai_detai_duan_show_datagrid';
        var row = $('#' + datagrid_id).datagrid('getSelected');
        msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_phannhom_detai + ' )?',function(r){
            if(r){
                datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_phanloai_detai_duan', 'id_phannhom_detai ='+row.id_phannhom_detai);
            }
        });
    }

    function func_dlg_phanloai_detai_duan_show() {
        try {
            $('#dlg_phanloai_detai_duan_show_datagrid').datagrid({
                width: 880,
                height: 300,
                nowrap: false,
                striped: true,
                fitColumns: true,
                singleSelect: true,
                collapsible: true,
                url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_SHOW_PHANLOAI_DETAI_DUAN),
                queryParams:{
                    total: -1,
                    records: 0
                },
                loadMsg: MSG_WAIT_LOADING,
                 sortName: 'id_phannhom_detai',
                 sortOrder: 'asc',
                 remoteSort: false,
                 idField:'id_phannhom_detai',
                columns: [[
                    {field: 'ten_phannhom_detai', title: 'Tên đề tài', width: 80, align: 'left', alignH: 'center'},
                ]],
                pagination: true,
                rownumbers: true,
                onLoadSuccess: function (data) {
                }
            });
        } catch (err) {
            alert("func_dlg_phanloai_detai_duan_show have dlg_phanloai_detai_duan_show_datagrid: " + err);
        }

        try{
            $('#dlg_phanloai_detai_duan_show').dialog({
                title: "Danh sách nhóm đề tài",
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
                        func_deleteRow_DlgShow_phanloai_detai_duan();
                    },
                    "Sửa": function () {
                        loadHtml("dlg_phanloai_detai_duan_them","./page/quanlyphanloai_detai_duan_control.jsp", false);
                        func_dlg_add_phanloai_detai_duan(/*isEdit*/true);
                    },
                    "Thêm mới": function () {
                        loadHtml("dlg_phanloai_detai_duan_them","./page/quanlyphanloai_detai_duan_control.jsp", false);
                        func_dlg_add_phanloai_detai_duan(false);
                    },
                    "Đóng": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });
        } catch (err) {
            alert("func_dlg_phanloai_detai_duan_show have dlg_phanloai_detai_duan_show " + err);
        }
    }
</script>
<div>
    <table id="dlg_phanloai_detai_duan_show_datagrid"></table>
</div>