<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_dlg_add_tieuchi_ungdung(isEdit) {
    	cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TIEUCHI_CON_TO_CBB, 'id_tieuchi_cha is not null', TYPE_DATA_HTML_CBB,'*', 'dlg_tieuchi_ungdung_them_TieuChi');
    	cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_tieuchi_ungdung_them_ThuyetMinh');
    	cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_XADIEM_TO_CBB, null , TYPE_DATA_HTML_CBB,'*', 'dlg_tieuchi_ungdung_them_XD');
        $('#form_tieuchi_ungdung_them').each(function () {
            this.reset();
        });
        var row;
        var datagrid_id = 'dlg_tieuchi_ungdung_datagrid';
        var kiemtraRowNULL = true;
        if (isEdit) {
            row = $('#' + datagrid_id).datagrid('getSelected');
            if(row != null){
            $.ajax({
                url: root_href + HOME_SERVLET ,
                data:{
                    action: ACT_GET_DATA_TO_EDIT_TIEUCHI_UNGDUNG,
                    condition: 'id_tieuchi =' + row.id_tieuchi + ' and id_xadiem=' + row.id_xadiem + ' and id_thuyetminh_detai=' + row.id_thuyetminh_detai
                },
                async:false,
                success:function(jsonData) {
                    var jsonObject = JSON.parse(jsonData);
                    document.getElementById('dlg_tieuchi_ungdung_them_TieuChi').value = jsonObject.rows[0].id_tieuchi;
                    document.getElementById('dlg_tieuchi_ungdung_them_ThuyetMinh').value = jsonObject.rows[0].id_thuyetminh_detai;
                    document.getElementById('dlg_tieuchi_ungdung_them_XD').value = jsonObject.rows[0].id_xadiem;
                    return;
                }});
            }else{
            	kiemtraRowNULL = false;
	           	$('#form_tieuchi_ungdung_them').hide();
	           	msgalert_autoclose('Thông báo','Chọn tiêu chí','error');
            }
        }
        if(kiemtraRowNULL){
	        try {
	            $('#dlg_tieuchi_ungdung_them').dialog({
	                title: "Cập nhật tiêu chí ",
	                modal: false, open: function () {
	                    $(this).dialog('widget').draggable('option', {containment: false});
	                },
	                height: 350,
	                width: 500,
	                collapsible: true,
	                draggable: true,
	                resizable: false,
	                position: [450, 100],
	
	                buttons: {
	                    "Cập nhật": function () {
	                        var combo = document.getElementById('dlg_tieuchi_ungdung_them_TieuChi');
	                        var id_tieuchi = combo.options[combo.selectedIndex].value;
	                        combo = document.getElementById('dlg_tieuchi_ungdung_them_ThuyetMinh');
	                        var id_thuyetminh = combo.options[combo.selectedIndex].value;
	                        combo = document.getElementById('dlg_tieuchi_ungdung_them_XD');
	                        var id_xadiem = combo.options[combo.selectedIndex].value;
	                        
	                        if (id_tieuchi == -1 || id_thuyetminh == -1 || id_xadiem == -1 ){
	                            msgalert_autoclose('Thông báo','Không được bỏ trống','warning');
	                            return;
	                        }

	                        
	                        var utils = new Utils();
	                        var	strSQL;
	                        utils.clearFieldStorer();
	                        utils.putfval_int('id_tieuchi', id_tieuchi);             
	                        utils.putfval_int('id_thuyetminh_detai', id_thuyetminh);             
	                        utils.putfval_int('id_xadiem', id_xadiem);             
	                        if (isEdit){
	                            //last param
	                            utils.putfval_int_condition('id_tieuchi', row.id_tieuchi);
	                        }
	                        
	                        strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_tieuchi_ungdung'):utils.genUpdateCmd_PreStatement('tbl_tieuchi_ungdung','id_tieuchi=?'));
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
	            alert("func_dlg_tieuchi_ungdung_show have dlg_tieuchi_ungdung_show " + err);
	        }
        }
    }
</script>

<form id="form_tieuchi_ungdung_them">
    <table>
	    <tr>
	      <td><b>Tiêu chí: </b></td>
	      <td><select name="dlg_tieuchi_ungdung_them_TieuChi" id="dlg_tieuchi_ungdung_them_TieuChi"></select></td>
	    </tr>
	    <tr>
	      <td><b>Thuyết minh: </b></td>
	      <td><select name="dlg_tieuchi_ungdung_them_ThuyetMinh" id="dlg_tieuchi_ungdung_them_ThuyetMinh"></select></td>
	    </tr>
	    <tr>
	      <td><b>Xã điểm: </b></td>
	      <td><select name="dlg_tieuchi_ungdung_them_XD" id="dlg_tieuchi_ungdung_them_XD"></select></td>
	    </tr>
        
    </table>
</form>