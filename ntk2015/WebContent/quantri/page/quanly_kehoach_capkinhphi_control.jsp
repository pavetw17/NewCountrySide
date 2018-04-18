<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
  $(function() {
	    $("#dlg_kehoach_capkinhphi_them_TheLoai_Detai" ).combobox();
	    $("#dlg_kehoach_capkinhphi_them_TheLoai_TMDetai" ).combobox();
	    $("#dlg_kehoach_capkinhphi_them_ToChuc" ).combobox();
	    
	    $("#dlg_kehoach_capkinhphi_them_TheLoai_Detai").change(function() {
	    	$('#dlg_kehoach_capkinhphi_them_TheLoai_TMDetai').next().val('');
			cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TOCHUC_TO_CBB, 'b.id_detai='+ this.value, TYPE_DATA_HTML_CBB,'null', 'dlg_kehoach_capkinhphi_them_TheLoai_TMDetai');
	    });
	    
  });
  
   function func_dlg_add_kehoach_capkinhphi(isEdit) {
    $('#form_kehoach_capkinhphi_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DETAI_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_kehoach_capkinhphi_them_TheLoai_Detai');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TOCHUC_DETAI_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_kehoach_capkinhphi_them_ToChuc');
   
    var row;
    var datagrid_id = 'dlg_kehoach_capkinhphi_show_datagrid';
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_KH_CAPKINHPHI,
    	          condition: ' id_kh_capkinhphi='+ row.id_kh_capkinhphi 
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_kehoach_capkinhphi_them_TheLoai_TMDetai');
    	          var jsonObject = JSON.parse(jsonData);
    	          //document.getElementById('dlg_kehoach_capkinhphi_them_TheLoai_TMDetai').value = jsonObject.rows[0].id_thuyetminh_detai; //not use 
    	          $('#dlg_kehoach_capkinhphi_them_TheLoai_Detai').combobox('autocomplete',jsonObject.rows[0].id_detai); 
    	          $('#dlg_kehoach_capkinhphi_them_TheLoai_TMDetai').combobox('autocomplete',jsonObject.rows[0].id_thuyetminhdetai); 
    	          $('#dlg_kehoach_capkinhphi_them_ToChuc').combobox('autocomplete',jsonObject.rows[0].id_tochuc); 
    			  document.getElementById('dlg_kehoach_capkinhphi_them_NgayCap').value =  gm.date.Int2DateString(jsonObject.rows[0].ngaydukiencap);
    			  document.getElementById("dlg_kehoach_capkinhphi_them_SoTien").value= jsonObject.rows[0].sotien;
    			  document.getElementById("dlg_kehoach_capkinhphi_them_GhiChu").value= jsonObject.rows[0].ghichu;
    			  return;
    	        }}); 
       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_kehoach_capkinhphi_them').style.display = 'none';
    	  $('#form_kehoach_capkinhphi_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn kế hoạch','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_kehoach_capkinhphi_them').dialog({
	        title: "Cập nhật kinh phí kế hoạch ",
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
	            var id_detai = $('#dlg_kehoach_capkinhphi_them_TheLoai_Detai').val();
	            var id_thuyetminhdetai  = $('#dlg_kehoach_capkinhphi_them_TheLoai_TMDetai').val();
	            var id_tochuc = $('#dlg_kehoach_capkinhphi_them_ToChuc').val();
	            var ngaydukiencap = $('#dlg_kehoach_capkinhphi_them_NgayCap').val();
	            var sotien = $('#dlg_kehoach_capkinhphi_them_SoTien').val();
	            var ghichu = $('#dlg_kehoach_capkinhphi_them_GhiChu').val();
	            
			    if ( kiemtrarong(sotien)   || kiemtrarong(ghichu)   ||id_thuyetminhdetai == null
			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }   
	            
			    var max;var check;
			    
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_int('sotien',  sotien);
	            utils.putfval_string('ghichu',  ghichu);
	            utils.putfval_int('ngaydukiencap',  gm.date.stringDate2Int(ngaydukiencap));
	            utils.putfval_int('id_detai',  id_detai);
	            utils.putfval_int('id_thuyetminhdetai',  id_thuyetminhdetai);
	            utils.putfval_int('id_tochuc',  id_tochuc);
	            if(!isEdit){ 
                    $.ajax({
                        url: root_href + HOME_SERVLET ,
                        data:
                        {
                            action: ACT_DB_CHECK_DATA_EXISTS,
                            tableName:'tbl_kh_capkinhphi',
                            fieldName:   'id_kh_capkinhphi',
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
                            tableName:'tbl_kh_capkinhphi',
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
	              	utils.putfval_int_condition('id_kh_capkinhphi', row.id_kh_capkinhphi);
	            }else{
		           	 $.ajax({
	                     url: root_href + HOME_SERVLET ,
	                     data:
	                     {
	                       action: ACT_DB_MAX_DATA,
	                       tableName:'tbl_kh_capkinhphi',
	                       fieldName:'id_kh_capkinhphi' ,
	                       condition: null
	                     },
	                     async:false,
	                     success:function(result) {
	                       max = parseInt(result)+1 ;
	                     }
	                   });
	            	 utils.putfval_int('id_kh_capkinhphi', max);
	            }
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_kh_capkinhphi'):utils.genUpdateCmd_PreStatement('tbl_kh_capkinhphi','id_kh_capkinhphi=?'));
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
	               	  $('#form_kehoach_capkinhphi_them').each(function () {
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
	      alert("func_dlg_kehoach_capkinhphi_show have dlg_kehoach_capkinhphi_show " + err);
	    }
   }
} 
</script>

<form id="form_kehoach_capkinhphi_them">
  <table>
  <tr>
      <td><b>Đề tài: </b></td>
      <td><select name="dlg_kehoach_capkinhphi_them_TheLoai_Detai" id="dlg_kehoach_capkinhphi_them_TheLoai_Detai"></select></td>
    </tr>
  <tr>
      <td><b>Thuyết minh đề tài: </b></td>
      <td><select name="dlg_kehoach_capkinhphi_them_TheLoai_TMDetai" id="dlg_kehoach_capkinhphi_them_TheLoai_TMDetai"></select></td>
    </tr>
   <tr>
   <tr>
      <td><b>Tổ chức: </b></td>
      <td><select name="dlg_kehoach_capkinhphi_them_ToChuc" id="dlg_kehoach_capkinhphi_them_ToChuc"></select></td>
    </tr>
    <tr>
      <td><b>Ngày dự kiến cấp: </b></td>
      <td><input name="dlg_kehoach_capkinhphi_them_NgayCap" id="dlg_kehoach_capkinhphi_them_NgayCap"
                 type="text" size="25" class="datepicker"></td>
    </tr>
    <tr>
      <td><b>Số tiền: </b></td>
      <td><input name="dlg_kehoach_capkinhphi_them_SoTien" id="dlg_kehoach_capkinhphi_them_SoTien"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Ghi chú: </b></td>
      <td><input name="dlg_kehoach_capkinhphi_them_GhiChu" id="dlg_kehoach_capkinhphi_them_GhiChu"
                 type="text" size="25"></td>
    </tr>
  </table>
</form>