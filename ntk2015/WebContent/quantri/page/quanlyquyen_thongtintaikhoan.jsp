<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_dlg_add_qlquyen_dsquyen(isEdit) {
        //reset form
        $('#form_qlquyen_dsquyen_them').each(function () {
            this.reset();
        });

        var row;
        var datagrid_id = 'dlg_qlquyen_dsquyen_show_datagrid';
        if (isEdit) {
            /*  alert("Sua: " + isEdit);*/
            row = $('#' + datagrid_id).datagrid('getSelected');
            $.ajax({
                url: root_href + QUYEN_SERVLET ,
                data:{
                    action: ACT_GET_DATA_TO_EDIT_DANHSACHQUYEN,
                    condition: 'id_quyen =' + row.id_quyen
                },
                async:false,
                success:function(jsonData) {
                    //alert(jsonData); //get row selected
                    var jsonObject = JSON.parse(jsonData);
                    document.getElementById('dlg_qlquyen_dsquyen_them_Ma').value = jsonObject.rows[0].id_quyen;
                    document.getElementById('dlg_qlquyen_dsquyen_them_Ten').value = jsonObject.rows[0].ten_quyen;
                    return;
                }});
        }
        try {
            $('#dlg_qlquyen_dsquyen_them').dialog({
                title: "Thêm quyền ",
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
                        //get data from form dialog
                        var maQuyen = document.getElementById('dlg_qlquyen_dsquyen_them_Ma').value;
                        var tenQuyen = document.getElementById('dlg_qlquyen_dsquyen_them_Ten').value;

                        if (kiemtrarong(maQuyen) || kiemtrarong(tenQuyen) ){
                            msgalert_autoclose('Thông báo','Không được bỏ trống','warning');
                            return;
                        }

                        if (isNaN(maQuyen))  {
                            msgalert_autoclose('Thông báo','Phải nhập số','warning');
                            return;
                        }

                        /* var max;*/
                        var check;
                        if(!isEdit){ //add
                            $.ajax({
                                url: root_href + QUYEN_SERVLET ,
                                data:
                                {
                                    action: ACT_DB_CHECK_DATA_EXISTS,
                                    tableName:'tbl_phan_quyen',
                                    fieldName:'ten_quyen' ,
                                    condition: 'lower(ten_quyen)='+ ' lower(\''+tenQuyen+'\') or id_quyen = ' + maQuyen
                                },
                                async:false,
                                success:function(result) {
                                    if (result == DB_STR_OK){
                                        check=true;
                                    }
                                    else {
                                        check=false; //not exists
                                    }
                                    return;
                                }
                            });
                            if (check == true){
                                msgalert_autoclose('Thông báo',' Số liệu này đã tồn tại, mã quyền hay tên quyền không được trùng!','warning');
                                return;
                            } <%--else{
                                $.ajax({
                                    url: root_href + QUYEN_SERVLET ,
                                    data:
                                    {
                                        action: ACT_DB_MAX_DATA,
                                        tableName:'tbl_phan_quyen',
                                        fieldName:'id_quyen' ,
                                        condition: null
                                    },
                                    async:false,
                                    success:function(result) {
                                       *//* max = parseInt(result)+1 ;*//*
                                    }
                                });
                            }--%>
                        }else{ //edit
                            $.ajax({
                                url: root_href + QUYEN_SERVLET ,
                                data:
                                {
                                    action: ACT_DB_CHECK_DATA_EXISTS,
                                    tableName:'tbl_phan_quyen',
                                    fieldName:'ten_quyen' ,
                                    condition: 'lower(ten_quyen)='+ ' lower( \''+ tenQuyen +'\') ' +' AND id_quyen<>' + maQuyen
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
                        utils.putfval_string('ten_quyen', tenQuyen);
                        utils.putfval_int('id_quyen', maQuyen);
                        if (isEdit){
                            //last param
                            utils.putfval_int_condition('id_quyen', row.id_quyen);
                        }
                        /* else{
                         utils.putfval_int('id_quyen', max);
                         }*/

                        strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_phan_quyen'):utils.genUpdateCmd_PreStatement('tbl_phan_quyen','id_quyen=?'));
                        /*alert('Query =' + strSQL);*/

                        var strListValues = utils.getListValues();
                        /* alert(strListValues);*/

                        var strListIDs = '';
                        <%--if (!isEdit) {
                         alert('false');
                         strListIDs = utils.createStringWithSeparator(getListFeaturesIDSelected(), SQL_ID_LIST_SEP);
                         }
                         else{
                         strListIDs = '';}
                         alert('strListIDs'+strListIDs);--%>


                        var sqlTypeOrder = utils.getSQLTypeOrderInQuery();  // get datatypes in SQL sentence
                        //alert('sqlTypeOrder= ' + sqlTypeOrder);

                        var ret = cwrs_InsUpdMultiRecord2DB(root_href + QUYEN_SERVLET, ACT_DB_INSERT_UPDATE_MULTI_OBJECT, null/*condition*/, strSQL, strListValues, sqlTypeOrder, strListIDs, null/*strJSONObject*/);
                        if (ret == DB_STR_OK){
                            if (isEdit){
                                $('#' + datagrid_id).datagrid('reload');  //alert('insert/update multi object OK');
                            }else {
                                try{
                                    $('#' + datagrid_id).datagrid('load');
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
            alert("func_dlg_qlquyen_dsquyen_show have dlg_qlquyen_dsquyen_show " + err);
        }

    }
</script>
<form id="form_qlquyen_dsquyen_them">
    <table>
        <tr>
            <td><b>Mã quyền: </b></td>
            <td><input name="dlg_qlquyen_dsquyen_them_Ma" id="dlg_qlquyen_dsquyen_them_Ma"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Tên quyền: </b></td>
            <td><input name="dlg_qlquyen_dsquyen_them_Ten" id="dlg_qlquyen_dsquyen_them_Ten"
                       type="text" size="25"></td>
        </tr>
    </table>
</form>