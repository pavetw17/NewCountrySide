<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
	$(document).ready(function() {
		$('form').submit(function(e){
		    e.preventDefault();
		});
		
	    $('#dlg_nhansu_thamgia_them_ToChuc').on('change', function() {
	      if(this.value == -1){
	    	  $('#dlg_nhansu_thamgia_them_NhanSu')
	    	    .find('option')
	    	    .remove()
	    	    .end()
	    	    .append('<option value="-1">*</option>')
	    	    .val('whatever');
		  }else{
			  cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_NHANSU_TO_CBB, 'id_tochuc='+ this.value, TYPE_DATA_HTML_CBB,'*', 'dlg_nhansu_thamgia_them_NhanSu');
		  }
	    });
	});

    function func_dlg_add_nhansu_thamgia(isEdit) {
        $('#form_nhansu_thamgia_them').each(function () {
            this.reset();
        });

        cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_nhansu_thamgia_them_TM');
        cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_nhansu_thamgia_them_ToChuc');
        cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_VAITRO_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_nhansu_thamgia_them_VaiTro');
        
        var row;
        var datagrid_id = 'dlg_nhansu_thamgia_show_datagrid';
        var kiemtraRowNULL = true;
        if (isEdit) {
            row = $('#' + datagrid_id).datagrid('getSelected');
            if(row != null){
            $.ajax({
                url: root_href + HOME_SERVLET ,
                data:{
                    action: ACT_GET_DATA_TO_EDIT_NHANSU_THAMGIA,
                    condition: 'id_nhansu_detai =' + row.id_nhansu_detai
                },
                async:false,
                success:function(jsonData) {
                    var jsonObject = JSON.parse(jsonData);
                    document.getElementById('dlg_nhansu_thamgia_them_NoiDung').value = jsonObject.rows[0].noidungthamgia;
                    document.getElementById('dlg_nhansu_thamgia_them_SoThang').value = jsonObject.rows[0].sothangthamgia;
                    document.getElementById('dlg_nhansu_thamgia_them_TM').value = jsonObject.rows[0].id_thuyetminh_detai;
                    document.getElementById('dlg_nhansu_thamgia_them_ToChuc').value = jsonObject.rows[0].id_tochuc;
                    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_NHANSU_TO_CBB, 'id_tochuc='+ jsonObject.rows[0].id_tochuc, TYPE_DATA_HTML_CBB,'*', 'dlg_nhansu_thamgia_them_NhanSu');
                    document.getElementById('dlg_nhansu_thamgia_them_NhanSu').value = jsonObject.rows[0].id_nhansu;
                    document.getElementById('dlg_nhansu_thamgia_them_VaiTro').value = jsonObject.rows[0].id_vaitro;
                    return;
                }});
            }else{
            	kiemtraRowNULL = false;
	           	$('#form_nhansu_thamgia_them').hide();
	           	msgalert_autoclose('Thông báo','Chọn nhân sự','error');
            }
        }
        
        if(kiemtraRowNULL){
        try {
            $('#dlg_nhansu_thamgia_them').dialog({
                title: "Cập nhật dự án ",
                modal: false, open: function () {
                    $(this).dialog('widget').draggable('option', {containment: false});
                },
                height: 380,
                width: 410,
                collapsible: true,
                draggable: true,
                resizable: false,
                position: [450, 100],

                buttons: {
                    "Cập nhật": function () {
                      var id_nhansu = $('#dlg_nhansu_thamgia_them_NhanSu').val();
                      var id_thuyetminh = $('#dlg_nhansu_thamgia_them_TM').val();
                      var id_vaitro = $('#dlg_nhansu_thamgia_them_VaiTro').val();
                      var noidung =  $('#dlg_nhansu_thamgia_them_NoiDung').val(); 
                      var sothang =  $('#dlg_nhansu_thamgia_them_SoThang').val(); 
                      
                      if ( id_nhansu == null || id_thuyetminh == -1 || id_vaitro == -1  || kiemtrarong(noidung) || isNaN(sothang) ){
                            msgalert_autoclose('Thông báo','Không được bỏ trống hoặc nhập không đúng','warning');
                            return;
                      }

                        var utils = new Utils();
                        var	strSQL;
                        utils.clearFieldStorer();
                        utils.putfval_string('noidungthamgia', trim(noidung));
                        utils.putfval_int('id_thuyetminh_detai', id_thuyetminh);
                        utils.putfval_int('id_nhansu', id_nhansu);
                        utils.putfval_int('id_vaitro', id_vaitro);
                        utils.putfval_int('sothangthamgia', trim(sothang));
                        if (isEdit){
                            //last param
                            utils.putfval_int_condition('id_nhansu_detai', row.id_nhansu_detai);
                        }else {
                        	$.ajax({
            					url: root_href + HOME_SERVLET ,
            					data:
            				    { 
            					 action: ACT_DB_MAX_DATA,
            					 tableName:'tbl_nhansu_thamgia',
            					  fieldName:'id_nhansu_detai' ,
            					  condition: null
            					},
            					async:false,
            					success:function(result) {
            						max = parseInt(result)+1 ;
            						utils.putfval_int('id_nhansu_detai', max);
            					   }
            				});
            				
            			}
                        strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_nhansu_thamgia'):utils.genUpdateCmd_PreStatement('tbl_nhansu_thamgia','id_nhansu_detai=?'));
                        /*alert('Query =' + strSQL);*/

                        var strListValues = utils.getListValues();
                        /* alert(strListValues);*/

                        var strListIDs = '';

                        var sqlTypeOrder = utils.getSQLTypeOrderInQuery();  // get datatypes in SQL senThangce
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
            alert("func_dlg_nhansu_thamgia_show have dlg_nhansu_thamgia_show " + err);
        }
    }
    }
</script>

<form id="form_nhansu_thamgia_them">
    <table>
        <tr>
            <td><b>Thuyết minh: </b></td>
            <td><select name="dlg_nhansu_thamgia_them_TM" id="dlg_nhansu_thamgia_them_TM" ></select></td>
        </tr>
        <tr>
            <td><b>Tổ chức: </b></td>
            <td><select name="dlg_nhansu_thamgia_them_ToChuc" id="dlg_nhansu_thamgia_them_ToChuc" ></select></td>
        </tr>
        <tr>
            <td><b>Nhân sự: </b></td>
            <td><select name="dlg_nhansu_thamgia_them_NhanSu" id="dlg_nhansu_thamgia_them_NhanSu" >
            </select></td>
        </tr>
        <tr>
            <td><b>Vai trò: </b></td>
            <td><select name="dlg_nhansu_thamgia_them_VaiTro" id="dlg_nhansu_thamgia_them_VaiTro" >
            </select></td>
        </tr>
        <tr>
            <td><b>Nội dung tham gia: </b></td>
            <td><input name="dlg_nhansu_thamgia_them_NoiDung" id="dlg_nhansu_thamgia_them_NoiDung"
                       type="text" size="25"></td>
        </tr>
        <tr>
                       <td><b>Số tháng tham gia: </b></td>
            <td><input name="dlg_nhansu_thamgia_them_SoThang" id="dlg_nhansu_thamgia_them_SoThang"
                       type="text" size="25"></td>
        </tr>
    </table>
</form>