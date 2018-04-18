<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_dlg_add_tieuchi_xd_ntm_cha(isEdit) {
    	
        $('#form_tieuchi_xd_ntm_cha_them').each(function () {
            this.reset();
        });
        var row;
        var datagrid_id = 'dlg_tieuchi_xd_ntm_cha_show_datagrid';
        var kiemtraRowNULL = true;
        if (isEdit) {
            row = $('#' + datagrid_id).datagrid('getSelected');
            if(row != null){
            $.ajax({
                url: root_href + HOME_SERVLET ,
                data:{
                    action: ACT_GET_DATA_TO_EDIT_TIEUCHI_XD_NTM_CHA,
                    condition: 'id_tieuchi =' + row.id_tieuchi
                },
                async:false,
                success:function(jsonData) {
                    var jsonObject = JSON.parse(jsonData);
                    document.getElementById('dlg_tieuchi_xd_ntm_cha_them_ID').value = jsonObject.rows[0].ten_tieuchi;
                    return;
                }});
            }else{
            	kiemtraRowNULL = false;
	           	$('#form_tieuchi_xd_ntm_cha_them').hide();
	           	msgalert_autoclose('Thông báo','Chọn đề tài','error');
            }
        }
        if(kiemtraRowNULL){
	        try {
	            $('#dlg_tieuchi_xd_ntm_cha_them').dialog({
	                title: "Cập nhật đề tài ",
	                modal: false, open: function () {
	                    $(this).dialog('widget').draggable('option', {containment: false});
	                },
	                height: 200,
	                width: 400,
	                collapsible: true,
	                draggable: true,
	                resizable: false,
	                position: [450, 100],
	
	                buttons: {
	                    "Cập nhật": function () {
	                        var ten_tieuchi = document.getElementById('dlg_tieuchi_xd_ntm_cha_them_ID').value;
	                        
	                        if ( kiemtrarong(ten_tieuchi)  ){
	                            msgalert_autoclose('Thông báo','Không được bỏ trống','warning');
	                            return;
	                        }
	               
	                        var check;
	                        if(!isEdit){ 
	                            $.ajax({
	                                url: root_href + HOME_SERVLET ,
	                                data:
	                                {
	                                    action: ACT_DB_CHECK_DATA_EXISTS,
	                                    tableName:'tbl_tieuchi_xaydung_ntm',
	                                    fieldName:'id_tieuchi',
	                                    condition: 'ten_tieuchi='+ ten_tieuchi 
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
	                                    tableName:'tbl_tieuchi_xaydung_ntm',
	                                    fieldName:'id_tieuchi',
	                                    condition: 'ten_tieuchi='+ ten_tieuchi 
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
	                        utils.putfval_string('ten_tieuchi', trim(ten_tieuchi));             
	                        if (isEdit){
	                            //last param
	                            utils.putfval_int_condition('id_tieuchi', row.id_tieuchi);
	                        }else{
	                        	$.ajax({
	            					url: root_href + HOME_SERVLET ,
	            					data:
	            				    { 
	            					 action: ACT_DB_MAX_DATA,
	            					 tableName:'tbl_tieuchi_xaydung_ntm',
	            					  fieldName:'id_tieuchi' ,
	            					  condition: null
	            					},
	            					async:false,
	            					success:function(result) {
	            						max = parseInt(result)+1 ;
	            						utils.putfval_int('id_tieuchi', max);
	            					   }
	            				});
	                        }
	                        strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_tieuchi_xaydung_ntm'):utils.genUpdateCmd_PreStatement('tbl_tieuchi_xaydung_ntm','id_tieuchi=?'));
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
	            alert("func_dlg_tieuchi_xd_ntm_cha_show have dlg_tieuchi_xd_ntm_cha_show " + err);
	        }
        }
    }
</script>

<form id="form_tieuchi_xd_ntm_cha_them">
    <table>
        <tr>
            <td><b>Tên tiêu chí: </b></td>
            <td><input name="dlg_tieuchi_xd_ntm_cha_them_ID" id="dlg_tieuchi_xd_ntm_cha_them_ID"
                       type="text" size="25"></td>
        </tr>
    </table>
</form>