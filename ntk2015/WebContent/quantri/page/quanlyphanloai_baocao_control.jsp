<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_dlg_add_phanloai_baocao(isEdit) {
        $('#form_phanloai_baocao_them').each(function () {
            this.reset();
        });

        $('form').submit(function(e){
		    e.preventDefault();
		  });
        
        var row;
        var datagrid_id = 'dlg_phanloai_baocao_show_datagrid';
        var kiemtraRowNULL = true ;
        if (isEdit) {
        	row = $('#' + datagrid_id).datagrid('getSelected');
        	if(row != null){    
	            $.ajax({
	                url: root_href + HOME_SERVLET ,
	                data:{
	                    action: ACT_GET_DATA_TO_EDIT_PHANLOAI_BAOCAO,
	                    condition: 'id_phanloaibaocao =' + row.id_phanloaibaocao
	                },
	                async:false,
	                success:function(jsonData) {
	                    var jsonObject = JSON.parse(jsonData);
	                    <%-- id_test = jsonObject.rows[0].id_phanloaibaocao; --%>
	                    document.getElementById('dlg_phanloai_baocao_them_Ten').value = jsonObject.rows[0].tenphanloai;
	                    return;
	                }});
        	}else{
        		kiemtraRowNULL = false;
	           	$('#form_phanloai_baocao_them').hide();
	           	msgalert_autoclose('Thông báo','Chọn tin tức','error');
        	}
        }
        if(kiemtraRowNULL){
        	try {
                $('#dlg_phanloai_baocao_them').dialog({
                    title: "Cập nhật báo cáo ",
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
                            var tenBC = document.getElementById('dlg_phanloai_baocao_them_Ten').value;

                            if (kiemtrarong(tenBC) ){
                                msgalert_autoclose('Thông báo','Không được bỏ trống','warning');
                                return;
                            }
                          
                            var check;  var max;
                            if(!isEdit){ 
                                $.ajax({
                                    url: root_href + HOME_SERVLET ,
                                    data:
                                    {
                                        action: ACT_DB_CHECK_DATA_EXISTS,
                                        tableName:'tbl_phanloai_baocao',
                                        fieldName:'tenphanloai' ,
                                        condition: 'lower(tenphanloai)='+ ' lower(\''+tenBC+'\') ' 
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
                                    msgalert_autoclose('Thông báo',' Số liệu này đã tồn tại, mã báo cáo hay tên báo cáo không được trùng!','warning');
                                    return;
                                }else{
                                    $.ajax({
                                        url: root_href + HOME_SERVLET ,
                                        data:
                                        {
                                          action: ACT_DB_MAX_DATA,
                                          tableName:'tbl_phanloai_baocao',
                                          fieldName:'id_phanloaibaocao' ,
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
                                        tableName:'tbl_phanloai_baocao',
                                        fieldName:'tenphanloai' ,
                                        condition: 'lower(tenphanloai)='+ ' lower( \''+ tenBC +'\') ' 
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
                                    msgalert_autoclose('Thông báo',' Số liệu này đã tồn tại, mã báo cáo hay tên báo cáo không được trùng!','warning');
                                    return;
                                }
                            }
                            var utils = new Utils();
                            var	strSQL;
                          
                            utils.clearFieldStorer();
                            utils.putfval_string('tenphanloai', trim(tenBC));
                            if (isEdit){
                                //last param
                                utils.putfval_int_condition('id_phanloaibaocao', row.id_phanloaibaocao);
                            }else{
                                utils.putfval_int('id_phanloaibaocao', max);
                            }

                            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_phanloai_baocao'):utils.genUpdateCmd_PreStatement('tbl_phanloai_baocao','id_phanloaibaocao=?'));
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
                                    	  $('#form_phanloai_baocao_them').each(function () {
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
                alert("func_dlg_phanloai_baocao_show have dlg_phanloai_baocao_show " + err);
            }
        }       
    }
</script>

<form id="form_phanloai_baocao_them">
    <table>
        <tr>
            <td><b>Tên báo cáo: </b></td>
            <td><input name="dlg_phanloai_baocao_them_Ten" id="dlg_phanloai_baocao_them_Ten"
                       type="text" size="25"></td>
        </tr>
    </table>
</form>