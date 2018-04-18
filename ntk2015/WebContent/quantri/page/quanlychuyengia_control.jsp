<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_dlg_add_quanlychuyengia(isEdit) {
        $('#form_chuyengia_them').each(function () {
            this.reset();
        });
        
        $('form').submit(function(e){
		    e.preventDefault();
		  });

        var row;
        var datagrid_id = 'dlg_quanlychuyengia_show_datagrid';
        var kiemtraRowNULL = true;
        if (isEdit) {
            row = $('#' + datagrid_id).datagrid('getSelected');
            if(row != null){
            $.ajax({
                url: root_href + HOME_SERVLET ,
                data:{
                    action: ACT_GET_DATA_TO_EDIT_CHUYENGIA,
                    condition: 'id_chuyengia =' + row.id_chuyengia
                },
                async:false,
                success:function(jsonData) {
                    var jsonObject = JSON.parse(jsonData);
                    document.getElementById('dlg_chuyengia_them_Ten').value = jsonObject.rows[0].hoten;
                    document.getElementById('dlg_chuyengia_them_CT').value = jsonObject.rows[0].donvictac;
                    document.getElementById('dlg_chuyengia_them_CV').value = jsonObject.rows[0].chucvu;
                    document.getElementById('dlg_chuyengia_them_DT').value = jsonObject.rows[0].donvictac;
                    return;
                }});
            }else{
            	kiemtraRowNULL = false;
	           	$('#form_chuyengia_them').hide();
	           	msgalert_autoclose('Thông báo','Chọn chuyên gia','error');
            }
        }
        if(kiemtraRowNULL){
	        try {
	            $('#dlg_chuyengia_them').dialog({
	                title: "Cập nhật chuyên gia ",
	                modal: false, open: function () {
	                    $(this).dialog('widget').draggable('option', {containment: false});
	                },
	                height: 280,
	                width: 400,
	                collapsible: true,
	                draggable: true,
	                resizable: false,
	                position: [450, 100],
	
	                buttons: {
	                    "Cập nhật": function () {
	                        var tenQuyen = document.getElementById('dlg_chuyengia_them_Ten').value;
	                        var congTac = document.getElementById('dlg_chuyengia_them_CT').value;
	                        var chucVu = document.getElementById('dlg_chuyengia_them_CV').value;
	                        var dienThoai = document.getElementById('dlg_chuyengia_them_DT').value;
							
	                        if (kiemtrarong(tenQuyen) || kiemtrarong(congTac) || kiemtrarong(chucVu) || kiemtrarong(dienThoai) ){
	                            msgalert_autoclose('Thông báo','Không được bỏ trống','warning');
	                            return;
	                        }
	               
	                        
	                        var utils = new Utils();
	                        var	strSQL;
	                        utils.clearFieldStorer();
	                        utils.putfval_string('hoten', trim(tenQuyen));             
	                        utils.putfval_string('donvictac', trim(congTac));             
	                        utils.putfval_string('chucvu', trim(chucVu));             
	                        utils.putfval_string('dienthoai', trim(dienThoai));             
	                        if (isEdit){
	                            //last param
	                            utils.putfval_int_condition('id_chuyengia', row.id_chuyengia);
	                        }
	                        strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_chuyengia'):utils.genUpdateCmd_PreStatement('tbl_chuyengia','id_chuyengia=?'));
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
	                            	$('#form_chuyengia_them').each(function () {
	         	               	       this.reset();
	         	               	  });
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
	            alert("func_dlg_chuyengia_show have dlg_chuyengia_show " + err);
	        }
        }
    }
</script>

<form id="form_chuyengia_them">
    <table>
        <tr>
            <td><b>Tên chuyên gia: </b></td>
            <td><input name="dlg_chuyengia_them_Ten" id="dlg_chuyengia_them_Ten"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Đ/v công tác: </b></td>
            <td><input name="dlg_chuyengia_them_CT" id="dlg_chuyengia_them_CT"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Chức vụ: </b></td>
            <td><input name="dlg_chuyengia_them_CV" id="dlg_chuyengia_them_CV"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Điện thoại: </b></td>
            <td><input name="dlg_chuyengia_them_DT" id="dlg_chuyengia_them_DT"
                       type="text" size="25"></td>
        </tr>
    </table>
</form>