<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    function func_dlg_add_thuyetminh_detai(isEdit) {
     	$( "#dlg_thuyetminh_detai_them_TG" ).datepicker({
   			dateFormat: "dd/mm/yy",
			changeMonth : true,
			changeYear : true,
			yearRange : '2015:2025',
   	});
    	
    	cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DUAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_thuyetminh_detai_them_TheLoai');
        $('#form_thuyetminh_detai_them').each(function () {
            this.reset();
        });
        var row;
        var datagrid_id = 'dlg_thuyetminh_detai_show_datagrid';
        var kiemtraRowNULL = true;
        if (isEdit) {
            row = $('#' + datagrid_id).datagrid('getSelected');
            if(row != null){
            $.ajax({
                url: root_href + HOME_SERVLET ,
                data:{
                    action: ACT_GET_DATA_TO_EDIT_THUYETMINH_DETAI,
                    condition: 'id_thuyetminh_detai_duan =' + row.id_thuyetminh_detai_duan
                },
                async:false,
                success:function(jsonData) {
                    var jsonObject = JSON.parse(jsonData);
                    document.getElementById('dlg_thuyetminh_detai_them_ID').value = jsonObject.rows[0].masodt;
                    document.getElementById('dlg_thuyetminh_detai_them_MT').value = jsonObject.rows[0].muctieu_detai;
                    document.getElementById('dlg_thuyetminh_detai_them_TT').value = jsonObject.rows[0].tinhtrangdt;
                    document.getElementById('dlg_thuyetminh_detai_them_TG').value = gm.date.Int2DateString(jsonObject.rows[0].ngaybatdau);
                    document.getElementById('dlg_thuyetminh_detai_them_TheLoai').value = jsonObject.rows[0].id_detai;
                    return;
                }});
            }else{
            	kiemtraRowNULL = false;
	           	$('#form_thuyetminh_detai_them').hide();
	           	msgalert_autoclose('Thông báo','Chọn đề tài','error');
            }
        }
        if(kiemtraRowNULL){
	        try {
	            $('#dlg_thuyetminh_detai_them').dialog({
	                title: "Cập nhật đề tài ",
	                modal: false, open: function () {
	                    $(this).dialog('widget').draggable('option', {containment: false});
	                },
	                height: 370,
	                width: 400,
	                collapsible: true,
	                draggable: true,
	                resizable: false,
	                position: [450, 100],
	
	                buttons: {
	                    "Cập nhật": function () {
	                        var masodt = document.getElementById('dlg_thuyetminh_detai_them_ID').value;
	                        var muctieu_detai  = document.getElementById('dlg_thuyetminh_detai_them_MT').value;
	                        
	                        var ngaybatdau = document.getElementById('dlg_thuyetminh_detai_them_TG').value;
	                        var combo = document.getElementById('dlg_thuyetminh_detai_them_TheLoai');
	                        var theLoaiDeTai = combo.options[combo.selectedIndex].value; 
	                        combo = document.getElementById('dlg_thuyetminh_detai_them_TT');
	                        var tinhtrangdt =  combo.options[combo.selectedIndex].value;
	                        
	                        if (theLoaiDeTai == -1 || kiemtrarong(masodt) || kiemtrarong(ngaybatdau) ){
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
	                                    tableName:'tbl_thuyetminh_detai_duan',
	                                    fieldName:'id_thuyetminh_detai_duan',
	                                    condition: 'id_thuyetminh_detai_duan='+ masodt 
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
	                                    tableName:'tbl_thuyetminh_detai_duan',
	                                    fieldName:'id_thuyetminh_detai_duan',
	                                    condition: 'id_thuyetminh_detai_duan='+ masodt 
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
	                        utils.putfval_string('masodt', trim(masodt));             
	                        utils.putfval_string('muctieu_detai', trim(muctieu_detai));             
	                        utils.putfval_int('ngaybatdau', gm.date.stringDate2Int(ngaybatdau));             
	                        utils.putfval_int('tinhtrangdt', trim(tinhtrangdt));             
	                        utils.putfval_int('id_detai', trim(theLoaiDeTai));             
	                        if (isEdit){
	                            //last param
	                            utils.putfval_int_condition('id_thuyetminh_detai_duan', row.id_thuyetminh_detai_duan);
	                        }else{
	                        	$.ajax({
	            					url: root_href + HOME_SERVLET ,
	            					data:
	            				    { 
	            					 action: ACT_DB_MAX_DATA,
	            					 tableName:'tbl_thuyetminh_detai_duan',
	            					  fieldName:'id_thuyetminh_detai_duan' ,
	            					  condition: null
	            					},
	            					async:false,
	            					success:function(result) {
	            						max = parseInt(result)+1 ;
	            						utils.putfval_int('id_thuyetminh_detai_duan', max);
	            					   }
	            				});
	                        }
	                        strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_thuyetminh_detai_duan'):utils.genUpdateCmd_PreStatement('tbl_thuyetminh_detai_duan','id_thuyetminh_detai_duan=?'));
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
	                                	 $('#form_thuyetminh_detai_them').each(function () {
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
	            alert("func_dlg_thuyetminh_detai_show have dlg_thuyetminh_detai_show " + err);
	        }
        }
    }
</script>

<form id="form_thuyetminh_detai_them">
    <table>
      <tr>
      <td><b>Thể loại đề tài: </b></td>
      <td><select name="dlg_thuyetminh_detai_them_TheLoai" id="dlg_thuyetminh_detai_them_TheLoai"></select></td>
    </tr>
        <tr>
            <td><b>Mã thuyết minh đề tài: </b></td>
            <td><input name="dlg_thuyetminh_detai_them_ID" id="dlg_thuyetminh_detai_them_ID"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Mục tiêu đề tài: </b></td>
            <td><input name="dlg_thuyetminh_detai_them_MT" id="dlg_thuyetminh_detai_them_MT"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Ngày bắt đầu: </b></td>
            <td><input name="dlg_thuyetminh_detai_them_TG" id="dlg_thuyetminh_detai_them_TG"
                       type="text" size="25"></td>
        </tr>
        <tr>
            <td><b>Tình trạng: </b></td>
            <td>
            <select name="dlg_thuyetminh_detai_them_TT" id="dlg_thuyetminh_detai_them_TT">
            	<option value="0">Đang tuyển chọn</option>
            	<option value="1">Đang thực hiện</option>
            </select>
           <!--  <input name="dlg_thuyetminh_detai_them_TT" id="dlg_thuyetminh_detai_them_TT"
                       type="text" size="25"> --></td>
        </tr>
    </table>
</form>