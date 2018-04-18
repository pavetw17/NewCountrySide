<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_dlg_add_phanloai_khuvuc(isEdit) {
        $('#form_phanloai_khuvuc_them').each(function () {
            this.reset();
        });

        var row;
        var datagrid_id = 'dlg_phanloai_khuvuc_show_datagrid';
        var kiemtrarownull = true;
        if (isEdit) {
            row = $('#' + datagrid_id).datagrid('getSelected');
            if(row != null){
	            $.ajax({
	                url: root_href + HOME_SERVLET ,
	                data:{
	                    action: ACT_GET_DATA_TO_EDIT_PHANLOAI_KHUVUC,
	                    condition: 'id_khuvuc =' + row.id_khuvuc
	                },
	                async:false,
	                success:function(jsonData) {
	                    var jsonObject = JSON.parse(jsonData);
	                    <%-- id_test = jsonObject.rows[0].id_khuvuc; --%>
	                    document.getElementById('dlg_phanloai_khuvuc_them_Ma').value = jsonObject.rows[0].id_khuvuc;
	                    document.getElementById('dlg_phanloai_khuvuc_them_Ten').value = jsonObject.rows[0].ten_khuvuc;
	                    return;
	                }});
            }else{
            	kiemtrarownull=false;
            	$('#form_phanloai_kq_them').hide();
	           	msgalert_autoclose('Thông báo','Chọn kết quả ','error');
            }
        }
        if(kiemtrarownull){
        	try {
                $('#dlg_phanloai_khuvuc_them').dialog({
                    title: "Cập nhật khu vực ",
                    modal: false, open: function () {
                        $(this).dialog('widget').draggable('option', {containment: false});
                    },
                    height: 230,
                    width: 360,
                    collapsible: true,
                    draggable: true,
                    resizable: false,
                    position: [450, 100],

                    buttons: {
                        "Cập nhật": function () {
                            var maKhuVuc = document.getElementById('dlg_phanloai_khuvuc_them_Ma').value;
                            var tenKhuVuc = document.getElementById('dlg_phanloai_khuvuc_them_Ten').value;

                            if (kiemtrarong(maKhuVuc) || kiemtrarong(tenKhuVuc) ){
                                msgalert_autoclose('Thông báo','Không được bỏ trống','warning');
                                return;
                            }

                            if (isNaN(maKhuVuc))  {
                                msgalert_autoclose('Thông báo','Phải nhập số','warning');
                                return;
                            }

                            var check;
                            if(!isEdit){ 
                                $.ajax({
                                    url: root_href + HOME_SERVLET ,
                                    data:
                                    {
                                        action: ACT_DB_CHECK_DATA_EXISTS,
                                        tableName:'tbl_phanloai_khuvuc',
                                        fieldName:'ten_khuvuc' ,
                                        condition: 'lower(ten_khuvuc)='+ ' lower(\''+tenKhuVuc+'\') or id_khuvuc = ' + maKhuVuc
                                    },
                                    async:false,
                                    success:function(result) {
                                        if (result == DB_STR_OK){
                                            check=true;
                                        }
                                        else {
                                            check=false; 
                                        }
                                        return;
                                    }
                                });
                                if (check == true){
                                    msgalert_autoclose('Thông báo',' Số liệu này đã tồn tại, mã quyền hay tên quyền không được trùng!','warning');
                                    return;
                                } 
                            }else{ 
                                $.ajax({
                                    url: root_href + HOME_SERVLET ,
                                    data:
                                    {
                                        action: ACT_DB_CHECK_DATA_EXISTS,
                                        tableName:'tbl_phanloai_khuvuc',
                                        fieldName:'ten_khuvuc' ,
                                        condition: 'lower(ten_khuvuc)='+ ' lower( \''+ tenKhuVuc +'\') ' +' AND id_khuvuc<>' + maKhuVuc
                                    },
                                    async:false,
                                    success:function(result) {
                                        if (result == DB_STR_OK){
                                            check=true;
                                        }
                                        else {
                                            check=false;
                                        }
                                        return;
                                    }
                                });
                                if (check == true){
                                    msgalert_autoclose('Thông báo',' Số liệu này đã tồn tại, mã quyền hay tên quyền không được trùng!','warning');
                                    return;
                                }
                            }
                            var utils = new Utils();
                            var	strSQL;
                            utils.clearFieldStorer();
                            utils.putfval_string('ten_khuvuc', trim(tenKhuVuc));
                            utils.putfval_int('id_khuvuc', trim(maKhuVuc));
                            if (isEdit){
                                //last param
                                utils.putfval_int_condition('id_khuvuc', row.id_khuvuc);
                            }
                            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_phanloai_khuvuc'):utils.genUpdateCmd_PreStatement('tbl_phanloai_khuvuc','id_khuvuc=?'));
                            /*alert('Query =' + strSQL);*/

                            var strListValues = utils.getListValues();
                            /* alert(strListValues);*/

                            var strListIDs = '';

                            var sqlTypeOrder = utils.getSQLTypeOrderInQuery();  // get datatypes in SQL sentence
                            //alert('sqlTypeOrder= ' + sqlTypeOrder);

                            var ret = cwrs_InsUpdMultiRecord2DB(root_href + HOME_SERVLET, ACT_DB_INSERT_UPDATE_MULTI_OBJECT, null/*condition*/, strSQL, strListValues, sqlTypeOrder, strListIDs, null/*strJSONObject*/);
                            if (ret == DB_STR_OK){
                                if (isEdit){
                                    $('#' + datagrid_id).datagrid('reload'); 
                                }else {
                                    try{
                                        $('#' + datagrid_id).datagrid('reload');
                                    }catch(err){
                                        msgalert_autoclose('Thông báo', err ,'warning');
                                        return;
                                    }
                                }
                                if (isEdit) 	$( this ).dialog( "close" );
                                
                                msgalert_autoclose('Thông báo','Cập nhật/Thêm mới thành công','info');
                            }else {
                                msgalert_autoclose('Thông báo','Thao tác không thành công','error');//alert('insert/update multi object FAILED!');
                            }
                        },
                        "Đóng": function () {
                            $(this).dialog("close");
                        }
                    },
                    close: function () {
                    }
                });
            } catch (err) {
                alert("func_dlg_phanloai_khuvuc_show have dlg_phanloai_khuvuc_show " + err);
            }	
        }
    }
</script>

<form id="form_phanloai_khuvuc_them">
    <table>
        <tr>
            <td><b>Mã khu vực: </b></td>
            <td><input name="dlg_phanloai_khuvuc_them_Ma" id="dlg_phanloai_khuvuc_them_Ma"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Tên khu vực: </b></td>
            <td><input name="dlg_phanloai_khuvuc_them_Ten" id="dlg_phanloai_khuvuc_them_Ten"
                       type="text" size="25"></td>
        </tr>
    </table>
</form>