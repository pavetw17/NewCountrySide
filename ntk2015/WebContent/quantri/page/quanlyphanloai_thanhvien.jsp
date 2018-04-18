<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_deleteRow_DlgShow_phanloai_thanhvien(){
        var datagrid_id = 'dlg_phanloai_thanhvien_show_datagrid';
        var row = $('#' + datagrid_id).datagrid('getSelected');
        msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_phanloai_thanhvien + ' )?',function(r){
            if(r){
                datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_phanloai_thanhvien', 'id_phanloai_thanhvien ='+row.id_phanloai_thanhvien);
            }
        });
    }

    function func_dlg_phanloai_thanhvien_show() {
        try {
            $('#dlg_phanloai_thanhvien_show_datagrid').datagrid({
                width: 880,
                height: 300,
                nowrap: false,
                striped: true,
                fitColumns: true,
                singleSelect: true,
                collapsible: true,
                url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_PHANLOAI_THANHVIEN),
                queryParams:{
                    total: -1,
                    records: 0
                },
                loadMsg: MSG_WAIT_LOADING,
                 sortName: 'id_phanloai_thanhvien',
                 sortOrder: 'asc',
                 remoteSort: false,
                 idField:'id_phanloai_thanhvien',
                columns: [[
                    {field: 'mota_thanhvien', title: 'Tên thành viên', width: 80, align: 'left', alignH: 'center'},
                ]],
                pagination: true,
                rownumbers: true,
                onLoadSuccess: function (data) {
                }
            });
        } catch (err) {
            alert("func_dlg_phanloai_thanhvien_show have dlg_phanloai_thanhvien_show_datagrid: " + err);
        }

        try{
            $('#dlg_phanloai_thanhvien_show').dialog({
                title: "Danh sách phân loại thành viên ",
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
                        func_deleteRow_DlgShow_phanloai_thanhvien();
                    },
                    "Sửa": function () {
                        loadHtml("dlg_phanloai_thanhvien_them","./page/quanlyphanloai_thanhvien_control.jsp", false);
                        func_dlg_add_phanloai_thanhvien(/*isEdit*/true);
                    },
                    "Thêm mới": function () {
                        loadHtml("dlg_phanloai_thanhvien_them","./page/quanlyphanloai_thanhvien_control.jsp", false);
                        func_dlg_add_phanloai_thanhvien(false);
                    },
                    "Đóng": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });
        } catch (err) {
            alert("func_dlg_phanloai_thanhvien_show have dlg_phanloai_thanhvien_show " + err);
        }
    }
</script>
<div>
    <table id="dlg_phanloai_thanhvien_show_datagrid"></table>
</div>