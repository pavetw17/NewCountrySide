<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
  $(function() {
	    $("#dlg_noidung_capkinhphi_them_TheLoai_Detai" ).combobox();
	    $("#dlg_noidung_capkinhphi_them_TheLoai_TMDetai" ).combobox();
	    $("#dlg_noidung_capkinhphi_them_ToChuc" ).combobox();
	    $("#dlg_noidung_capkinhphi_them_NoiDung" ).combobox();
	    $("#dlg_noidung_capkinhphi_them_Dot" ).combobox();
	    
	    $("#dlg_noidung_capkinhphi_them_TheLoai_Detai").change(function() {
	    	$('#dlg_noidung_capkinhphi_them_TheLoai_TMDetai').next().val('');
			cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TOCHUC_TO_CBB, 'b.id_detai='+ this.value, TYPE_DATA_HTML_CBB,'null', 'dlg_noidung_capkinhphi_them_TheLoai_TMDetai');
	    });
	    
  });
  
   function func_dlg_add_noidung_capkinhphi(isEdit) {
    $('#form_noidung_capkinhphi_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DETAI_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_noidung_capkinhphi_them_TheLoai_Detai');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TOCHUC_DETAI_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_noidung_capkinhphi_them_ToChuc');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_NOIDUNG_THUYETMINH_NHOM_TO_CBB, 'id_noidung_cha is not null', TYPE_DATA_HTML_CBB,'null', 'dlg_noidung_capkinhphi_them_NoiDung');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_KH_CAPKINHPHI_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_noidung_capkinhphi_them_Dot');
    var row;
    var datagrid_id = 'dlg_noidung_capkinhphi_show_datagrid';
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_NOIDUNG_CAPKINHPHI,
    	          condition: 'id_tiendo_capkinhphi=' + row.id_tiendo_capkinhphi  + 'and id_tochuc= '+ row.id_tochuc +' and id_noidung='+ row.id_noidung +' and id_thuyetminhdetai='+ row.id_thuyetminhdetai+' and id_tochuc ='+ row.id_tochuc  
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_noidung_capkinhphi_them_TheLoai_TMDetai');
    	          var jsonObject = JSON.parse(jsonData);
    	          $('#dlg_noidung_capkinhphi_them_TheLoai_Detai').combobox('autocomplete',jsonObject.rows[0].id_detai); 
    	          $('#dlg_noidung_capkinhphi_them_TheLoai_TMDetai').combobox('autocomplete',jsonObject.rows[0].id_thuyetminhdetai); 
    	          $('#dlg_noidung_capkinhphi_them_ToChuc').combobox('autocomplete',jsonObject.rows[0].id_tochuc); 
    	          $('#dlg_noidung_capkinhphi_them_NoiDung').combobox('autocomplete',jsonObject.rows[0].id_noidung); 
    	          $('#dlg_noidung_capkinhphi_them_Dot').combobox('autocomplete',jsonObject.rows[0].id_tiendo_capkinhphi); 
    			  document.getElementById("dlg_noidung_capkinhphi_them_SoTien").value= jsonObject.rows[0].sotien;
    			  return;
    	        }}); 
       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_noidung_capkinhphi_them').style.display = 'none';
    	  $('#form_noidung_capkinhphi_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn nội dung','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_noidung_capkinhphi_them').dialog({
	        title: "Cập nhật kinh phí nội dung ",
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
	            var id_detai = $('#dlg_noidung_capkinhphi_them_TheLoai_Detai').val();
	            var id_thuyetminhdetai  = $('#dlg_noidung_capkinhphi_them_TheLoai_TMDetai').val();
	            var id_tochuc = $('#dlg_noidung_capkinhphi_them_ToChuc').val();
	            var id_noidung = $('#dlg_noidung_capkinhphi_them_NoiDung').val();
	            var id_tiendo_capkinhphi = $('#dlg_noidung_capkinhphi_them_Dot').val();
	            var sotien = $('#dlg_noidung_capkinhphi_them_SoTien').val();
	            
	            
			    if ( kiemtrarong(sotien)   || id_detai == null   ||id_thuyetminhdetai == null || id_tochuc == null || id_tiendo_capkinhphi == null || id_noidung == null
			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }   
	            
			    var check;
			    
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_int('sotien',  sotien);
	            if(!isEdit){ 
                    $.ajax({
                        url: root_href + HOME_SERVLET ,
                        data:
                        {
                            action: ACT_DB_CHECK_DATA_EXISTS,
                            tableName:'tbl_noidung_capkinhphi',
                            fieldName:   'id_tiendo_capkinhphi',
                            condition: 'id_tiendo_capkinhphi=' + id_tiendo_capkinhphi  + 'and id_tochuc= '+ id_tochuc +' and id_noidung='+id_noidung +' and id_thuyetminhdetai='+id_thuyetminhdetai+' and id_tochuc ='+id_tochuc 
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
                 
                }
	            
	            
	            if (isEdit){
	              	utils.putfval_int_condition('id_noidung', row.id_noidung);
	              	utils.putfval_int_condition('id_tiendo_capkinhphi', row.id_tiendo_capkinhphi);
	              	utils.putfval_int_condition('id_detai', row.id_detai);
	              	utils.putfval_int_condition('id_thuyetminhdetai', row.id_thuyetminhdetai);
	              	utils.putfval_int_condition('id_tochuc', row.id_tochuc);
	            }else{
	            	
	 	            utils.putfval_int('id_noidung',  id_noidung);
	 	            utils.putfval_int('id_tiendo_capkinhphi',  id_tiendo_capkinhphi);
	 	            utils.putfval_int('id_detai',  id_detai);
	 	            utils.putfval_int('id_thuyetminhdetai',  id_thuyetminhdetai);
	 	            utils.putfval_int('id_tochuc',  id_tochuc);
	            }
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_noidung_capkinhphi'):utils.genUpdateCmd_PreStatement('tbl_noidung_capkinhphi','id_noidung = ? and id_tiendo_capkinhphi=? and id_detai=? and id_thuyetminhdetai=? and id_tochuc=?'));
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
	               	  $('#form_noidung_capkinhphi_them').each(function () {
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
	      alert("func_dlg_noidung_capkinhphi_show have dlg_noidung_capkinhphi_show " + err);
	    }
   }
} 
</script>

<form id="form_noidung_capkinhphi_them">
  <table>
  <tr>
      <td><b>Đề tài: </b></td>
      <td><select name="dlg_noidung_capkinhphi_them_TheLoai_Detai" id="dlg_noidung_capkinhphi_them_TheLoai_Detai"></select></td>
    </tr>
  <tr>
      <td><b>Thuyết minh đề tài: </b></td>
      <td><select name="dlg_noidung_capkinhphi_them_TheLoai_TMDetai" id="dlg_noidung_capkinhphi_them_TheLoai_TMDetai"></select></td>
    </tr>
   <tr>
   <tr>
      <td><b>Tổ chức: </b></td>
      <td><select name="dlg_noidung_capkinhphi_them_ToChuc" id="dlg_noidung_capkinhphi_them_ToChuc"></select></td>
    </tr>
     <tr>
    <tr>
      <td><b>Tên nội dung: </b></td>
      <td><select name="dlg_noidung_capkinhphi_them_NoiDung" id="dlg_noidung_capkinhphi_them_NoiDung"></select>
      </td>
    </tr>
    <tr>
      <td><b>Đợt: </b></td>
      <td><select name="dlg_noidung_capkinhphi_them_Dot" id="dlg_noidung_capkinhphi_them_Dot"></select>
      </td>
    </tr>
    <tr>
      <td><b>Số tiền: </b></td>
      <td><input name="dlg_noidung_capkinhphi_them_SoTien" id="dlg_noidung_capkinhphi_them_SoTien"
                 type="text" size="25"></td>
    </tr>
  </table>
</form>