<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_dlg_add_tochuc(isEdit) {
        $('#form_tochuc_them').each(function () {
            this.reset();
        });

        $('form').submit(function(e){
		    e.preventDefault();
		  });
        
        var row;
        var datagrid_id = 'dlg_tochuc_show_datagrid';
        
        var kiemtraRowNULL =true ;
        if (isEdit) {
            row = $('#' + datagrid_id).datagrid('getSelected');
            if(row != null){ 
            $.ajax({
                url: root_href + HOME_SERVLET ,
                data:{
                    action: ACT_GET_DATA_TO_EDIT_TOCHUC,
                    condition: 'id_tochuc =' + row.id_tochuc
                },
                async:false,
                success:function(jsonData) {
                    var jsonObject = JSON.parse(jsonData);
                    document.getElementById('dlg_tochuc_them_Ten').value = jsonObject.rows[0].tentc;
                    document.getElementById('dlg_tochuc_them_DT').value = jsonObject.rows[0].phonecq;
                    document.getElementById('dlg_tochuc_them_DC').value = jsonObject.rows[0].diachi_coquan;
                    document.getElementById('dlg_tochuc_them_Email').value = jsonObject.rows[0].email;
                    document.getElementById('dlg_tochuc_them_SoCanBoDaiHoc').value = jsonObject.rows[0].so_canbo_trinhdo_dh;
                    document.getElementById('dlg_tochuc_them_SoCanBoThacSi').value = jsonObject.rows[0].so_canbo_trinhdo_ths;
                    document.getElementById('dlg_tochuc_them_SoCanBoTienSi').value = jsonObject.rows[0].so_canbo_trinhdo_ts;
                    
                    return;
                }});
            }else{
          	  kiemtraRowNULL = false;
          	 // document.getElementById('form_tintuchoatdong_them').style.display = 'none';
          	  $('#form_tochuc_them').hide();
          	  msgalert_autoclose('Thông báo','Chọn tổ chức','error');
            } 
        }
        
        if(kiemtraRowNULL){
        try {
            $('#dlg_tochuc_them').dialog({
                title: "Cập nhật tổ chức ",
                modal: false, open: function () {
                    $(this).dialog('widget').draggable('option', {containment: false});
                },
                height: 400,
                width: 400,
                collapsible: true,
                draggable: true,
                resizable: false,
                position: [450, 100],

                buttons: {
                    "Cập nhật": function () {
                        var tenToChuc = $("#dlg_tochuc_them_Ten").val();
                        var dienthoaiToChuc =$("#dlg_tochuc_them_DT").val() ;
                        var diachiToChuc = $("#dlg_tochuc_them_DC").val();
                        var emailToChuc =$("#dlg_tochuc_them_Email").val() ;
                        var soCanBoDaiHocToChuc =$("#dlg_tochuc_them_SoCanBoDaiHoc").val();
                        var soCanBoThacSiToChuc =$("#dlg_tochuc_them_SoCanBoThacSi").val();
                        var soCanBoTienSiToChuc =$("#dlg_tochuc_them_SoCanBoTienSi").val();
						 
                        if (kiemtrarong(tenToChuc) || kiemtrarong(dienthoaiToChuc) || 
                        	kiemtrarong(diachiToChuc) || kiemtrarong(emailToChuc) || 
                        	kiemtrarong(soCanBoDaiHocToChuc) || kiemtrarong(soCanBoThacSiToChuc) ||
                        	kiemtrarong(soCanBoTienSiToChuc)	){
                            msgalert_autoclose('Thông báo','Không được bỏ trống','warning');
                            return;
                        }
                        
                        if (isNaN(soCanBoDaiHocToChuc) || isNaN(soCanBoThacSiToChuc) || isNaN(soCanBoTienSiToChuc) )  {
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
                                    tableName:'tbl_tochuc',
                                    fieldName:'tentc' ,
                                    condition: 'lower(tentc)='+ ' lower(\''+tenToChuc+'\') '
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
                                msgalert_autoclose('Thông báo',' Số liệu này đã tồn tại!','warning');
                                return;
                            } 
                        }else{ 
                            $.ajax({
                                url: root_href + HOME_SERVLET ,
                                data:
                                {
                                    action: ACT_DB_CHECK_DATA_EXISTS,
                                    tableName:'tbl_tochuc',
                                    fieldName:'tentc' ,
                                    condition: 'lower(tentc)='+ ' lower( \''+ tenToChuc +'\') ' 
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
                                msgalert_autoclose('Thông báo',' Số liệu này đã tồn tại!','warning');
                                return;
                            }
                        }
                        var utils = new Utils();
                        var	strSQL;
                        utils.clearFieldStorer();
                        utils.putfval_string('tentc', trim(tenToChuc));
                        utils.putfval_string('phonecq', trim(dienthoaiToChuc));
                        utils.putfval_string('diachi_coquan', trim(emailToChuc));
                        utils.putfval_string('email', trim(diachiToChuc));
                        utils.putfval_int('so_canbo_trinhdo_dh', soCanBoDaiHocToChuc);
                        utils.putfval_int('so_canbo_trinhdo_ths', soCanBoThacSiToChuc);
                        utils.putfval_int('so_canbo_trinhdo_ts', soCanBoTienSiToChuc);
                        if (isEdit){
                            //last param
                            utils.putfval_int_condition('id_tochuc', row.id_tochuc);
                           
                        }
                        strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_tochuc'):utils.genUpdateCmd_PreStatement('tbl_tochuc','id_tochuc=?'));
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
            alert("func_dlg_tochuc_show have dlg_tochuc_show " + err);
        }
    }
}
</script>

<form id="form_tochuc_them">
    <table>
        <tr>
            <td><b>Tên tổ chức: </b></td>
            <td><input name="dlg_tochuc_them_Ten" id="dlg_tochuc_them_Ten"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Điện thoại: </b></td>
            <td><input name="dlg_tochuc_them_DT" id="dlg_tochuc_them_DT"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Địa chỉ: </b></td>
            <td><input name="dlg_tochuc_them_DC" id="dlg_tochuc_them_DC"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Email: </b></td>
            <td><input name="dlg_tochuc_them_Email" id="dlg_tochuc_them_Email"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Số cán bộ đại học: </b></td>
            <td><input name="dlg_tochuc_them_SoCanBoDaiHoc" id="dlg_tochuc_them_SoCanBoDaiHoc"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Số cán bộ thạc sĩ: </b></td>
            <td><input name="dlg_tochuc_them_SoCanBoThacSi" id="dlg_tochuc_them_SoCanBoThacSi"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Số cán bộ tiến sĩ: </b></td>
            <td><input name="dlg_tochuc_them_SoCanBoTienSi" id="dlg_tochuc_them_SoCanBoTienSi"
                       type="text" size="25"></td>
        </tr>
    </table>
</form>