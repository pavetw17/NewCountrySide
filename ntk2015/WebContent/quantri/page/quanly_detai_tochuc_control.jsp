<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
  $(function() {
	    $("#dlg_detai_tochuc_them_TheLoai_Detai" ).combobox();
	    $("#dlg_detai_tochuc_them_TheLoai_TMDetai" ).combobox();
	    $("#dlg_detai_tochuc_them_ToChuc" ).combobox();
	    
	    $("#dlg_detai_tochuc_them_TheLoai_Detai").change(function() {
	    	$('#dlg_detai_tochuc_them_TheLoai_TMDetai').next().val('');
			cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, 'id_detai='+ this.value, TYPE_DATA_HTML_CBB,'null', 'dlg_detai_tochuc_them_TheLoai_TMDetai');
	    });
  });
  
   function func_dlg_add_detai_tochuc(isEdit) {
    $('#form_detai_tochuc_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DUAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_detai_tochuc_them_TheLoai_Detai');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_detai_tochuc_them_ToChuc');
   
    var row;
    var datagrid_id = 'dlg_detai_tochuc_show_datagrid';
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_DETAI_TOCHUC,
    	          condition: ' id_detai='+ row.id_detai +' and id_thuyetminhdetai='+ row.id_thuyetminhdetai+' and id_tochuc ='+ row.id_tochuc 
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_detai_tochuc_them_TheLoai_TMDetai');
    	          var jsonObject = JSON.parse(jsonData);
    	          //document.getElementById('dlg_detai_tochuc_them_TheLoai_TMDetai').value = jsonObject.rows[0].id_thuyetminh_detai; //not use 
    	          $('#dlg_detai_tochuc_them_TheLoai_Detai').combobox('autocomplete',jsonObject.rows[0].id_detai); 
    	          $('#dlg_detai_tochuc_them_TheLoai_TMDetai').combobox('autocomplete',jsonObject.rows[0].id_thuyetminhdetai); 
    	          $('#dlg_detai_tochuc_them_ToChuc').combobox('autocomplete',jsonObject.rows[0].id_tochuc); 
    			  document.getElementById('dlg_detai_tochuc_them_MaSo').value =  jsonObject.rows[0].maso;
    			  return;
    	        }}); 
       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_detai_tochuc_them').style.display = 'none';
    	  $('#form_detai_tochuc_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn tổ chức','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_detai_tochuc_them').dialog({
	        title: "Cập nhật đề tài tổ chức ",
	        open: function () {
	          $(this).dialog('widget').draggable('option', {containment: false});
	        },
	        height: 500,
	        width: 550,
	        collapsible: true,
	        draggable: true,
	        resizable: true,
	        position: [300, 100],
	        modal: true,
	        buttons: {
	          "Cập nhật": function () {
	            var id_detai = $('#dlg_detai_tochuc_them_TheLoai_Detai').val();
	            var id_thuyetminhdetai  = $('#dlg_detai_tochuc_them_TheLoai_TMDetai').val();
	            var id_tochuc = $('#dlg_detai_tochuc_them_ToChuc').val();
	            var maso = $('#dlg_detai_tochuc_them_MaSo').val();
	            
			    if ( kiemtrarong(maso)   || id_thuyetminhdetai == null
			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }   
	            
			    var max;var check;
			    
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_string('maso',  maso);
	           
	            if(!isEdit){ 
                    $.ajax({
                        url: root_href + HOME_SERVLET ,
                        data:
                        {
                            action: ACT_DB_CHECK_DATA_EXISTS,
                            tableName:'tbl_detai_tochuc',
                            fieldName:   'id_tochuc',
                            condition: ' id_detai='+id_detai +' and id_thuyetminhdetai='+id_thuyetminhdetai+' and id_tochuc ='+id_tochuc 
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
                        msgalert_autoclose('Thông báo',' Số liệu này đã tồn tại không được trùng!','warning');
                        return;
                    }
                }else{ 
                   /*  $.ajax({
                        url: root_href + HOME_SERVLET ,
                        data:
                        {
                            action: ACT_DB_CHECK_DATA_EXISTS,
                            tableName:'tbl_detai_tochuc',
                            fieldName:'id_tochuc' ,
                            condition: ' id_detai='+id_detai +' and id_thuyetminhdetai='+id_thuyetminhdetai+' and id_tochuc ='+id_tochuc 
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
                        msgalert_autoclose('Thông báo',' Số liệu này đã tồn tại không được trùng!','warning');
                        return;
                    } */
                }
	            
	            
	            if (isEdit){
	              	utils.putfval_int_condition('id_detai', row.id_detai);
	              	utils.putfval_int_condition('id_thuyetminhdetai', row.id_thuyetminhdetai);
	              	utils.putfval_int_condition('id_tochuc', row.id_tochuc);
	            }else{
	                utils.putfval_int('id_detai',  id_detai);
		            utils.putfval_int('id_thuyetminhdetai',  id_thuyetminhdetai);
		            utils.putfval_int('id_tochuc',  id_tochuc);
	            }
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_detai_tochuc'):utils.genUpdateCmd_PreStatement('tbl_detai_tochuc','id_detai=? and id_thuyetminhdetai=? and id_tochuc=?'));
	            //alert('Query =' + strSQL);
	
	            var strListValues = utils.getListValues();
	            //alert(strListValues);
	
	            var strListIDs = '';
	            var sqlTypeOrder = utils.getSQLTypeOrderInQuery();  // get datatypes in SQL sentence
	            //alert('sqlTypeOrder= ' + sqlTypeOrder);
	
	            var ret = cwrs_InsUpdMultiRecord2DB(root_href + HOME_SERVLET, ACT_DB_INSERT_UPDATE_MULTI_OBJECT, null, strSQL, strListValues, sqlTypeOrder, strListIDs, null);
	            if (ret == DB_STR_OK){
	              if (isEdit){
	                $('#' + datagrid_id).datagrid('reload');  //alert('insert/update multi object OK');
	              }else {
	                try{
	               	  $('#form_detai_tochuc_them').each(function () {
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
	      alert("func_dlg_detai_tochuc_show have dlg_detai_tochuc_show " + err);
	    }
   }
} 
</script>

<form id="form_detai_tochuc_them">
  <table>
  <tr>
      <td><b>Đề tài: </b></td>
      <td><select name="dlg_detai_tochuc_them_TheLoai_Detai" id="dlg_detai_tochuc_them_TheLoai_Detai"></select></td>
    </tr>
  <tr>
      <td><b>Thuyết minh đề tài: </b></td>
      <td><select name="dlg_detai_tochuc_them_TheLoai_TMDetai" id="dlg_detai_tochuc_them_TheLoai_TMDetai"></select></td>
    </tr>
   <tr>
   <tr>
      <td><b>Tổ chức: </b></td>
      <td><select name="dlg_detai_tochuc_them_ToChuc" id="dlg_detai_tochuc_them_ToChuc"></select></td>
    </tr>
    <tr>
      <td><b>Mã số đề tài: </b></td>
      <td><input name="dlg_detai_tochuc_them_MaSo" id="dlg_detai_tochuc_them_MaSo"
                 type="text" size="25"></td>
    </tr>
  </table>
</form>