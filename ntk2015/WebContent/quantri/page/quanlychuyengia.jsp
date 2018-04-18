<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_deleteRow_DlgShow_quanlychuyengia(){
        var datagrid_id = 'dlg_quanlychuyengia_show_datagrid';
        var row = $('#' + datagrid_id).datagrid('getSelected');
        msgconfirm('Confirm','Bạn có chắc chắn muốn xoá dữ liệu này( ' + row.id_chuyengia + ' )?',function(r){
            if(r){
                datagrid_delete_row(root_href + HOME_SERVLET, $('#' + datagrid_id), $('#'+datagrid_id).datagrid('getRowIndex', row), 'tbl_chuyengia', ' id_chuyengia ='+row.id_chuyengia);
            }
        });
    }

    function func_dlg_quanlychuyengia_show() {
        try {
            $('#dlg_quanlychuyengia_show_datagrid').datagrid({
                width: 880,
                height: 300,
                nowrap: false,
                striped: true,
                fitColumns: true,
                singleSelect: true,
                collapsible: true,
                url:( root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_CHUYENGIA),
                queryParams:{
                    total: -1,
                    records: 0
                },
                loadMsg: MSG_WAIT_LOADING,
                 sortName: 'id_chuyengia',
                 sortOrder: 'asc',
                 remoteSort: false,
                 idField:'id_chuyengia',
                columns: [[
                    {field: 'hoten', title: 'Tên Chuyên Gia', width: 80, align: 'left', alignH: 'center'},
                    {field: 'donvictac', title: 'Đ/v công tác', width: 80, align: 'left', alignH: 'center'},
                    {field: 'chucvu', title: 'Chức vụ', width: 80, align: 'left', alignH: 'center'},
                    {field: 'dienthoai', title: 'Điện thoại', width: 80, align: 'left', alignH: 'center'},
                ]],
                pagination: true,
                rownumbers: true,
                onLoadSuccess: function (data) {
                }
            });
        } catch (err) {
            alert("func_dlg_quanlychuyengia_show have dlg_quanlychuyengia_show_datagrid: " + err);
        }

        try{
            $('#dlg_quanlychuyengia_show').dialog({
                title: "Danh sách chuyên gia",
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
                        func_deleteRow_DlgShow_quanlychuyengia();
                    },
                    "Sửa": function () {
                        loadHtml("dlg_chuyengia_them","./page/quanlychuyengia_control.jsp", false);
                        func_dlg_add_quanlychuyengia(/*isEdit*/true);
                    },
                    "Thêm mới": function () {
                        loadHtml("dlg_chuyengia_them","./page/quanlychuyengia_control.jsp", false);
                        func_dlg_add_quanlychuyengia(false);
                    },
                    "Đóng": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });
        } catch (err) {
            alert("func_dlg_quanlychuyengia_show have dlg_quanlychuyengia_show " + err);
        }
    }
</script>
<div>
    <table id="dlg_quanlychuyengia_show_datagrid"></table>
</div>