<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_dlg_add_kiennghi(isEdit) {
        $('#form_kiennghi_them').each(function () {
            this.reset();
        });
        $('form').submit(function(e){
		    e.preventDefault();
		  });

        var row;
        var datagrid_id = 'dlg_kiennghi_show_datagrid';
        var kiemtraRowNULL =true ;
        if (isEdit) {
           row = $('#' + datagrid_id).datagrid('getSelected');
            if(row != null){
            $.ajax({
                url: root_href + HOME_SERVLET ,
                data:{
                    action: ACT_GET_DATA_TO_EDIT_KIENNGHI,
                    condition: 'id_kiennghi =' + row.id_kiennghi
                },
                async:false,
                success:function(jsonData) {
                    var jsonObject = JSON.parse(jsonData);
                    document.getElementById('dlg_kiennghi_them_Ten').value = jsonObject.rows[0].tenkiennghi;
                    return;
                }});
            }else{
	            kiemtraRowNULL = false;
	           	 // document.getElementById('form_tintuchoatdong_them').style.display = 'none';
	           	$('#form_kiennghi_them').hide();
	           	msgalert_autoclose('Thông báo','Chọn kiến nghị','error');
            } 
        }
        if(kiemtraRowNULL){        
	        try {
	            $('#dlg_kiennghi_them').dialog({
	                title: "Cập nhật kiến nghị ",
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
	                        var tenKienNghi = document.getElementById('dlg_kiennghi_them_Ten').value;
	
	                        if ( kiemtrarong(tenKienNghi) ){
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
	                                    tableName:'tbl_kiennghi',
	                                    fieldName:'tenkiennghi' ,
	                                    condition: 'lower(tenkiennghi)='+ ' lower(\''+tenKienNghi+'\') ' 
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
	                                msgalert_autoclose('Thông báo',' Số liệu này đã tồn tại, mã kiến nghị hay tên kiến nghị không được trùng!','warning');
	                                return;
	                            } else{
                                    $.ajax({
                                        url: root_href + HOME_SERVLET ,
                                        data:
                                        {
                                          action: ACT_DB_MAX_DATA,
                                          tableName:'tbl_kiennghi',
                                          fieldName:'id_kiennghi' ,
                                          condition: null
                                        },
                                        async:false,
                                        success:function(result) {
                                          max = parseInt(result)+1 ;
                                        }
                                      });
                                } 
	                        }else{ 
	                            $.ajax({
	                                url: root_href + HOME_SERVLET ,
	                                data:
	                                {
	                                    action: ACT_DB_CHECK_DATA_EXISTS,
	                                    tableName:'tbl_kiennghi',
	                                    fieldName:'tenkiennghi' ,
	                                    condition: 'lower(tenkiennghi)='+ ' lower( \''+ tenKienNghi +'\') ' 
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
	                        utils.putfval_string('tenkiennghi', trim(tenKienNghi));
	                        if (isEdit){
	                            //last param
	                            utils.putfval_int_condition('id_kiennghi', row.id_kiennghi);
	                        }else{
                                utils.putfval_int('id_kiennghi', max);
                            }
	                        strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_kiennghi'):utils.genUpdateCmd_PreStatement('tbl_kiennghi','id_kiennghi=?'));
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
	            alert("func_dlg_kiennghi_show have dlg_kiennghi_show " + err);
        	}
        }
    }
</script>

<form id="form_kiennghi_them">
    <table>
        <tr>
            <td><b>Tên kiến nghị: </b></td>
            <td><input name="dlg_kiennghi_them_Ten" id="dlg_kiennghi_them_Ten"
                       type="text" size="25"></td>
        </tr>
    </table>
</form>