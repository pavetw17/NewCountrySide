<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_dlg_add_detai_duan(isEdit) {
    	 cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_NHOM_DETAI_DUAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_detai_them_TheLoai');
        $('#form_detai_them').each(function () {
            this.reset();
        });
        var row;
        var datagrid_id = 'dlg_detai_duan_show_datagrid';
        var kiemtraRowNULL = true;
        if (isEdit) {
            row = $('#' + datagrid_id).datagrid('getSelected');
            if(row != null){
            $.ajax({
                url: root_href + HOME_SERVLET ,
                data:{
                    action: ACT_GET_DATA_TO_EDIT_DETAI_DUAN,
                    condition: 'id_detai =' + row.id_detai
                },
                async:false,
                success:function(jsonData) {
                    var jsonObject = JSON.parse(jsonData);
                    document.getElementById('dlg_detai_them_Ten').value = jsonObject.rows[0].tendt;
                    document.getElementById('dlg_detai_them_LV').value = jsonObject.rows[0].linhvuckh;
                    document.getElementById('dlg_detai_them_TG').value = jsonObject.rows[0].tgthuchien;
                    document.getElementById('dlg_detai_them_KP').value = jsonObject.rows[0].kinhphi;
                    document.getElementById('dlg_detai_them_TheLoai').value = jsonObject.rows[0].id_phannhom_detai_duan;
                    document.getElementById('dlg_detai_them_TinhTrang').value = jsonObject.rows[0].tinhtrang;
                    document.getElementById('dlg_detai_them_NgayTH').value = gm.date.Int2DateString(jsonObject.rows[0].ngaythuchien);
                    return;
                }});
            }else{
            	kiemtraRowNULL = false;
	           	$('#form_detai_them').hide();
	           	msgalert_autoclose('Thông báo','Chọn đề tài','error');
            }
        }
        if(kiemtraRowNULL){
	        try {
	            $('#dlg_detai_duan_them').dialog({
	                title: "Cập nhật đề tài ",
	                modal: false, open: function () {
	                    $(this).dialog('widget').draggable('option', {containment: false});
	                },
	                height: 410,
	                width: 450,
	                collapsible: true,
	                draggable: true,
	                resizable: false,
	                position: [450, 100],
	
	                buttons: {
	                    "Cập nhật": function () {
	                        var tendt = document.getElementById('dlg_detai_them_Ten').value;
	                        var linhvuckh = document.getElementById('dlg_detai_them_LV').value;
	                        var tgthuchien = document.getElementById('dlg_detai_them_TG').value;
	                        var ngaythuchien = document.getElementById('dlg_detai_them_NgayTH').value;
	                        var kinhphi = document.getElementById('dlg_detai_them_KP').value;
	                        var combo = document.getElementById('dlg_detai_them_TheLoai');
	                        var theLoaiDeTai = combo.options[combo.selectedIndex].value; 
	                        combo =  document.getElementById('dlg_detai_them_TinhTrang');
							var tinhtrang = combo.options[combo.selectedIndex].value;
	                        
	                        if (theLoaiDeTai == -1 ||  kiemtrarong(tendt) || kiemtrarong(tgthuchien) || kiemtrarong(kinhphi) || kiemtrarong(ngaythuchien)){
	                            msgalert_autoclose('Thông báo','Không được bỏ trống','warning');
	                            return;
	                        }
	               
	                        if (isNaN(kinhphi) || isNaN(tgthuchien))  {
	                            msgalert_autoclose('Thông báo','Kinh phí hay thời gian phải nhập số!','warning');
	                            return;
	                        }
	                        
	                        var check; var max;
	                        if(!isEdit){ 
                                    $.ajax({
                                        url: root_href + HOME_SERVLET ,
                                        data:
                                        {
                                          action: ACT_DB_MAX_DATA,
                                          tableName:'tbl_detai_duan',
                                          fieldName:'id_detai' ,
                                          condition: null
                                        },
                                        async:false,
                                        success:function(result) {
                                          max = parseInt(result)+1 ;
                                        }
                                      });
                               
	                        }else{ 
	                           
	                        }
	                        
	                        var utils = new Utils();
	                        var	strSQL;
	                        utils.clearFieldStorer();
	                        utils.putfval_string('tendt', trim(tendt));             
	                        utils.putfval_string('linhvuckh', trim(linhvuckh));             
	                        utils.putfval_int('tgthuchien', trim(tgthuchien));             
	                        utils.putfval_int('kinhphi', trim(kinhphi));             
	                        utils.putfval_int('id_phannhom_detai_duan', trim(theLoaiDeTai));             
	                        utils.putfval_int('tinhtrang', tinhtrang);             
	                        utils.putfval_int('ngaythuchien',  gm.date.stringDate2Int(ngaythuchien));             
	                        if (isEdit){
	                            //last param
	                            utils.putfval_int_condition('id_detai', row.id_detai);
	                        }else{
                                utils.putfval_int('id_detai', max);
                            }
	                        strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_detai_duan'):utils.genUpdateCmd_PreStatement('tbl_detai_duan','id_detai=?'));
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
	                                	 $('#form_detai_them').each(function () {
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
	            alert("func_dlg_detai_show have dlg_detai_show " + err);
	        }
        }
    }
</script>

<form id="form_detai_them">
    <table>
      <tr>
      <td><b>Thể loại đề tài: </b></td>
      <td><select name="dlg_detai_them_TheLoai" id="dlg_detai_them_TheLoai"></select></td>
    </tr>
        <tr>
            <td><b>Tên đề tài: </b></td>
            <td><input name="dlg_detai_them_Ten" id="dlg_detai_them_Ten"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Lĩnh vực: </b></td>
            <td><input name="dlg_detai_them_LV" id="dlg_detai_them_LV"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Thời gian thực hiện: </b></td>
            <td><input name="dlg_detai_them_TG" id="dlg_detai_them_TG"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Ngày thực hiện: </b></td>
            <td><input name="dlg_detai_them_NgayTH" id="dlg_detai_them_NgayTH"
                       type="text" size="25" class="datepicker"></td>
        </tr>
        <tr>
            <td><b>Kinh phí: </b></td>
            <td><input name="dlg_detai_them_KP" id="dlg_detai_them_KP"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Tình trạng: </b></td>
            <td><select name="dlg_detai_them_TinhTrang" id="dlg_detai_them_TinhTrang">
            		<option value="0">Được phê duyệt</option>
            		<option value="1">Đang thực hiện</option>
            		<option value="2">Đã nghiệm thu</option>
            	</select>
            </td>
        </tr>
    </table>
</form>