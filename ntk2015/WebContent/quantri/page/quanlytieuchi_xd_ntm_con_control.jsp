<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_dlg_add_tieuchi_xd_ntm_con(isEdit) {
    	cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_KHUVUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_tieuchi_xd_ntm_con_them_KhuVuc');
    	cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TIEUCHI_XD_NTM_CHA_TO_CBB, 'id_tieuchi_cha is null', TYPE_DATA_HTML_CBB,'*', 'dlg_tieuchi_xd_ntm_con_them_TheLoai');
        $('#form_tieuchi_xd_ntm_con_them').each(function () {
            this.reset();
        });
        var row;
        var datagrid_id = 'dlg_tieuchi_xd_ntm_show_con_datagrid';
        var kiemtraRowNULL = true;
        if (isEdit) {
            row = $('#' + datagrid_id).datagrid('getSelected');
            if(row != null){
            $.ajax({
                url: root_href + HOME_SERVLET ,
                data:{
                    action: ACT_GET_DATA_TO_EDIT_TIEUCHI_XD_NTM_CON,
                    condition: 'id_tieuchi =' + row.id_tieuchi
                },
                async:false,
                success:function(jsonData) {
                    var jsonObject = JSON.parse(jsonData);
                    document.getElementById('dlg_tieuchi_xd_ntm_con_them_KhuVuc').value = jsonObject.rows[0].id_khuvuc;
                    document.getElementById('dlg_tieuchi_xd_ntm_con_them_Ten').value = jsonObject.rows[0].ten_tieuchi;
                    document.getElementById('dlg_tieuchi_xd_ntm_con_them_ND').value = jsonObject.rows[0].noidung_tieuchi;
                    document.getElementById('dlg_tieuchi_xd_ntm_con_them_CT').value = jsonObject.rows[0].chitieu_phaidat;
                    document.getElementById('dlg_tieuchi_xd_ntm_con_them_TheLoai').value = jsonObject.rows[0].id_tieuchi_cha;
                    return;
                }});
            }else{
            	kiemtraRowNULL = false;
	           	$('#form_tieuchi_xd_ntm_con_them').hide();
	           	msgalert_autoclose('Thông báo','Chọn tiêu chí','error');
            }
        }
        if(kiemtraRowNULL){
	        try {
	            $('#dlg_tieuchi_xd_ntm_con_them').dialog({
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
	                        var ten_tieuchi = document.getElementById('dlg_tieuchi_xd_ntm_con_them_Ten').value;
	                        var noidung_tieuchi = document.getElementById('dlg_tieuchi_xd_ntm_con_them_ND').value;
	                        var chitieu_phaidat = document.getElementById('dlg_tieuchi_xd_ntm_con_them_CT').value;
	                        var combo = document.getElementById('dlg_tieuchi_xd_ntm_con_them_TheLoai');
	                        var id_tieuchi_cha = combo.options[combo.selectedIndex].value; 
	                        combo = document.getElementById('dlg_tieuchi_xd_ntm_con_them_KhuVuc');
	                        var id_khuvuc = combo.options[combo.selectedIndex].value; 
	                        
	                        if (id_tieuchi_cha == -1 || kiemtrarong(ten_tieuchi) || kiemtrarong(noidung_tieuchi) || id_khuvuc == -1 ){
	                            msgalert_autoclose('Thông báo','Không được bỏ trống','warning');
	                            return;
	                        }
	                        if (isNaN(chitieu_phaidat))  {
	                            msgalert_autoclose('Thông báo','Phải nhập số phần trăm','warning');
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
	                                    condition: 'noidung_tieuchi='+ noidung_tieuchi 
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
	                                    condition: 'noidung_tieuchi='+ noidung_tieuchi 
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
	                        utils.putfval_int('id_tieuchi_cha', id_tieuchi_cha);             
	                        utils.putfval_string('ten_tieuchi', trim(ten_tieuchi));             
	                        utils.putfval_string('noidung_tieuchi', trim(noidung_tieuchi));             
	                        utils.putfval_int('id_khuvuc', id_khuvuc);             
	                        utils.putfval_int('chitieu_phaidat', chitieu_phaidat);             
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
	            alert("func_dlg_tieuchi_xd_ntm_con_show have dlg_tieuchi_xd_ntm_con_show " + err);
	        }
        }
    }
</script>

<form id="form_tieuchi_xd_ntm_con_them">
    <table>
	    <tr>
	      <td><b>Khu vực: </b></td>
	      <td><select name="dlg_tieuchi_xd_ntm_con_them_KhuVuc" id="dlg_tieuchi_xd_ntm_con_them_KhuVuc"></select></td>
	    </tr>
	    <tr>
	      <td><b>Thể loại tiêu chí: </b></td>
	      <td><select name="dlg_tieuchi_xd_ntm_con_them_TheLoai" id="dlg_tieuchi_xd_ntm_con_them_TheLoai"></select></td>
	    </tr>
        <tr>
            <td><b>Tên tiêu chí: </b></td>
            <td><input name="dlg_tieuchi_xd_ntm_con_them_Ten" id="dlg_tieuchi_xd_ntm_con_them_Ten"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Nội dung: </b></td>
            <td><input name="dlg_tieuchi_xd_ntm_con_them_ND" id="dlg_tieuchi_xd_ntm_con_them_ND"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Chỉ tiêu phải đạt: </b></td>
            <td><input name="dlg_tieuchi_xd_ntm_con_them_CT" id="dlg_tieuchi_xd_ntm_con_them_CT"
                       type="text" size="25"></td>
        </tr>
    </table>
</form>