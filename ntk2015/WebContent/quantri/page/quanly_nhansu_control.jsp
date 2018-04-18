<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_dlg_add_nhansu(isEdit) {
        $('#form_nhansu_them').each(function () {
            this.reset();
        });

        $('form').submit(function(e){
		    e.preventDefault();
		  });
        
        cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_tochuc_cbb_them');
        
        var row;
        var datagrid_id = 'dlg_nhansu_show_datagrid';
        
        var kiemtraRowNULL =true ;
        if (isEdit) {
            row = $('#' + datagrid_id).datagrid('getSelected');
            if(row != null){ 
            $.ajax({
                url: root_href + HOME_SERVLET ,
                data:{
                    action: ACT_GET_DATA_TO_EDIT_NHANSU,
                    condition: 'id_nhansu =' + row.id_nhansu
                },
                async:false,
                success:function(jsonData) {
                    var jsonObject = JSON.parse(jsonData);
                    document.getElementById('dlg_nhansu_them_Ten').value = jsonObject.rows[0].hoten;
                    document.getElementById('dlg_nhansu_them_CV').value = jsonObject.rows[0].chucvu;
                    document.getElementById('dlg_nhansu_them_DT').value = jsonObject.rows[0].mobile;
                    document.getElementById('dlg_tochuc_cbb_them').value = jsonObject.rows[0].id_tochuc;
                    $('input[name="rdb_gioitinh"][value="' + jsonObject.rows[0].gioitinh + '"]').prop('checked', true);
                    return;
                }});
            }else{
          	  kiemtraRowNULL = false;
          	 // document.getElementById('form_tintuchoatdong_them').style.display = 'none';
          	  $('#form_nhansu_them').hide();
          	  msgalert_autoclose('Thông báo','Chọn nhân sự','error');
            } 
        }
        
        if(kiemtraRowNULL){
        try {
            $('#dlg_nhansu_them').dialog({
                title: "Cập nhật nhân sự ",
                modal: false, open: function () {
                    $(this).dialog('widget').draggable('option', {containment: false});
                },
                height: 320,
                width: 400,
                collapsible: true,
                draggable: true,
                resizable: false,
                position: [450, 100],

                buttons: {
                    "Cập nhật": function () {
                    	var combo = document.getElementById('dlg_tochuc_cbb_them');
               		    var toChucCbb = combo.options[combo.selectedIndex].value; 
                        var tenNhanSu = $("#dlg_nhansu_them_Ten").val();
                        var dienThoaiNhanSu =$("#dlg_nhansu_them_DT").val() ;
                        var chucVu = $("#dlg_nhansu_them_CV").val();
                    	var gioitinh = $('input[name=rdb_gioitinh]:checked').val();
                    	
                    	
                        if (kiemtrarong(tenNhanSu) || kiemtrarong(dienThoaiNhanSu) || 
                        	kiemtrarong(chucVu) || toChucCbb == -1 ){
                            msgalert_autoclose('Thông báo','Không được bỏ trống','warning');
                            return;
                        }
                        
                        var utils = new Utils();
                        var	strSQL;
                        utils.clearFieldStorer();
                        utils.putfval_string('hoten', trim(tenNhanSu));
                        utils.putfval_string('mobile', trim(dienThoaiNhanSu));
                        utils.putfval_string('chucvu', trim(chucVu));
                        utils.putfval_int('id_tochuc',toChucCbb);
                        utils.putfval_int('gioitinh',gioitinh);
                        if (isEdit){
                            //last param
                            utils.putfval_int_condition('id_nhansu', row.id_nhansu);
                           
                        }
                        strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_nhansu'):utils.genUpdateCmd_PreStatement('tbl_nhansu','id_nhansu=?'));
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
                                	 $('#form_nhansu_them').each(function () {
                 	               	       this.reset();
                 	               	  });	 
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
            alert("func_dlg_nhansu_show have dlg_nhansu_show " + err);
        }
    }
}
</script>

<form id="form_nhansu_them">
    <table>
        <tr>
            <td><b>Tổ chức: </b></td>
            <td> <select name="dlg_tochuc_cbb_them" id="dlg_tochuc_cbb_them" ></select></td>
        </tr>
        <tr>
            <td><b>Họ và tên: </b></td>
            <td><input name="dlg_nhansu_them_Ten" id="dlg_nhansu_them_Ten"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Chức vụ: </b></td>
            <td><input name="dlg_nhansu_them_CV" id="dlg_nhansu_them_CV"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Giới tính: </b></td>
            <td style="padding-bottom: 8px;">
        <input type="radio" value="1" checked id="rdb_gioitinh" name="rdb_gioitinh" style="width: 16px; height: 16px;">Nam
		<input type="radio" value="0" name="rdb_gioitinh" id="rdb_gioitinh" style=" width: 16px; height: 16px; margin-left: 40px;">Nữ</td>
        
        </tr>
        <tr>
            <td><b>Điện thoại: </b></td>
            <td><input name="dlg_nhansu_them_DT" id="dlg_nhansu_them_DT"
                       type="text" size="25"></td>
        </tr>
    </table>
</form>