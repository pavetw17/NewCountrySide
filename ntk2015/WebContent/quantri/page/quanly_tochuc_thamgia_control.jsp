<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
  $(function() {
	    $("#dlg_tochuc_thamgia_them_TheLoai_Detai" ).combobox();
	    $("#dlg_tochuc_thamgia_them_TheLoai_TMDetai" ).combobox();
	    $("#dlg_tochuc_thamgia_them_ToChuc" ).combobox();
	    $("#dlg_tochuc_thamgia_them_PLKQ" ).combobox();
	    $("#dlg_tochuc_thamgia_them_VaiTro" ).combobox();
	    
	    $("#dlg_tochuc_thamgia_them_TheLoai_Detai").change(function() {
	    	$('#dlg_tochuc_thamgia_them_TheLoai_TMDetai').next().val('');
			cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, 'id_detai='+ this.value, TYPE_DATA_HTML_CBB,'null', 'dlg_tochuc_thamgia_them_TheLoai_TMDetai');
	    });
  });
  
   function func_dlg_add_tochuc_thamgia(isEdit) {
    $('#form_tochuc_thamgia_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DUAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_tochuc_thamgia_them_TheLoai_Detai');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_tochuc_thamgia_them_ToChuc');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_PHANLOAI_KQ_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_tochuc_thamgia_them_PLKQ');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_VAITRO_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_tochuc_thamgia_them_VaiTro');
   
    var row;
    var datagrid_id = 'dlg_tochuc_thamgia_show_datagrid';
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_TOCHUC_THAMGIA,
    	          condition: 'id_tochuc_thamgia_detai =' + row.id_tochuc_thamgia_detai
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	        	cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_tochuc_thamgia_them_TheLoai_TMDetai');
    	          var jsonObject = JSON.parse(jsonData);
    	          //document.getElementById('dlg_tochuc_thamgia_them_TheLoai_TMDetai').value = jsonObject.rows[0].id_thuyetminh_detai; //not use 
    	          $('#dlg_tochuc_thamgia_them_TheLoai_Detai').combobox('autocomplete',jsonObject.rows[0].id_detai); 
    	          $('#dlg_tochuc_thamgia_them_TheLoai_TMDetai').combobox('autocomplete',jsonObject.rows[0].id_thuyetminhdetai); 
    	          $('#dlg_tochuc_thamgia_them_ToChuc').combobox('autocomplete',jsonObject.rows[0].id_tochuc); 
    	          $('#dlg_tochuc_thamgia_them_PLKQ').combobox('autocomplete',jsonObject.rows[0].id_phanloaiketqua); 
    	          $('#dlg_tochuc_thamgia_them_VaiTro').combobox('autocomplete',jsonObject.rows[0].id_vaitro); 
    			  document.getElementById('dlg_tochuc_thamgia_them_SoCBDH').value =  jsonObject.rows[0].so_canbo_dh_thamgia;
				  document.getElementById("dlg_tochuc_thamgia_them_SoCBThS").value= jsonObject.rows[0].so_canbo_ths_thamgia;
				  document.getElementById("dlg_tochuc_thamgia_them_SoCBTS").value= jsonObject.rows[0].so_canbo_ts_thamgia;
    			  document.getElementById('dlg_tochuc_thamgia_them_NhaXuong').value = jsonObject.rows[0].nha_xuong;
    			  document.getElementById('dlg_tochuc_thamgia_them_TrangTB').value = jsonObject.rows[0].trangthietbi;
    			  document.getElementById('dlg_tochuc_thamgia_them_KinhNghiem').value = jsonObject.rows[0].kinhnghiem_thanhtuu_khcn;
    			  return;
    	        }}); 
       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_tochuc_thamgia_them').style.display = 'none';
    	  $('#form_tochuc_thamgia_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn tổ chức','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_tochuc_thamgia_them').dialog({
	        title: "Cập nhật biên bản ",
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
	            var id_detai = $('#dlg_tochuc_thamgia_them_TheLoai_Detai').val();
	            var id_thuyetminhdetai  = $('#dlg_tochuc_thamgia_them_TheLoai_TMDetai').val();
	            var id_tochuc = $('#dlg_tochuc_thamgia_them_ToChuc').val();
	            var id_phanloaiketqua = $('#dlg_tochuc_thamgia_them_PLKQ').val();
	            var id_vaitro = $('#dlg_tochuc_thamgia_them_VaiTro').val();
	            var so_canbo_dh_thamgia = $('#dlg_tochuc_thamgia_them_SoCBDH').val();
	            var so_canbo_ths_thamgia = $('#dlg_tochuc_thamgia_them_SoCBThS').val();
	            var so_canbo_ts_thamgia = $('#dlg_tochuc_thamgia_them_SoCBTS').val();
	            var nha_xuong = $('#dlg_tochuc_thamgia_them_NhaXuong').val();
	            var trangthietbi = $('#dlg_tochuc_thamgia_them_TrangTB').val();
	            var kinhnghiem_thanhtuu_khcn = $('#dlg_tochuc_thamgia_them_KinhNghiem').val();
	            
			    if ( kiemtrarong(so_canbo_dh_thamgia)  || kiemtrarong(so_canbo_ths_thamgia)  
			    		|| kiemtrarong(so_canbo_ts_thamgia) || kiemtrarong(nha_xuong)
			    	 || kiemtrarong(trangthietbi) || kiemtrarong(kinhnghiem_thanhtuu_khcn)  || id_thuyetminhdetai == null
			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }   
	            
			    var max;var check;
	            var intRegex = /^\d+$/;
			    if(!intRegex.test(so_canbo_dh_thamgia) || !intRegex.test(so_canbo_ths_thamgia) || 
			       !intRegex.test(so_canbo_ts_thamgia)  ){
			    	  msgalert_autoclose('Thông báo','Nhập số vào không đúng!','warning');
		              return;
			    }
			    
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_int('id_detai',  id_detai);
	            utils.putfval_int('id_thuyetminhdetai',  id_thuyetminhdetai);
	            utils.putfval_int('id_tochuc',  id_tochuc);
	            utils.putfval_int('id_phanloaiketqua',  id_phanloaiketqua);
	            utils.putfval_int('id_vaitro',  id_vaitro);
	            utils.putfval_int('so_canbo_dh_thamgia',  so_canbo_dh_thamgia);
	            utils.putfval_int('so_canbo_ths_thamgia',  so_canbo_ths_thamgia);
	            utils.putfval_int('so_canbo_ts_thamgia',  so_canbo_ts_thamgia);
	            utils.putfval_string('nha_xuong',  nha_xuong);
	            utils.putfval_string('trangthietbi',  trangthietbi);
	            utils.putfval_string('kinhnghiem_thanhtuu_khcn',  kinhnghiem_thanhtuu_khcn);
	           
	            if(!isEdit){ 
                    $.ajax({
                        url: root_href + HOME_SERVLET ,
                        data:
                        {
                            action: ACT_DB_CHECK_DATA_EXISTS,
                            tableName:'tbl_tochuc_thamgia',
                            fieldName:'id_tochuc_thamgia_detai' ,
                            condition: 'id_thuyetminhdetai='+ id_thuyetminhdetai + ' and id_tochuc='+ id_tochuc 
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
                    }else{
                        $.ajax({
                            url: root_href + HOME_SERVLET ,
                            data:
                            {
                              action: ACT_DB_MAX_DATA,
                              tableName:'tbl_tochuc_thamgia',
                              fieldName:'id_tochuc_thamgia_detai' ,
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
                            tableName:'tbl_tochuc_thamgia',
                            fieldName:'id_tochuc_thamgia_detai' ,
                            condition: 'id_thuyetminhdetai='+ id_thuyetminhdetai + ' and id_tochuc='+ id_tochuc 
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
                }
	            
	            
	            if (isEdit){
	              utils.putfval_int_condition('id_tochuc_thamgia_detai', row.id_tochuc_thamgia_detai);
	            }else{ 
                  utils.putfval_int('id_tochuc_thamgia_detai',max);
                }
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_tochuc_thamgia'):utils.genUpdateCmd_PreStatement('tbl_tochuc_thamgia','id_tochuc_thamgia_detai=?'));
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
	               	  $('#form_tochuc_thamgia_them').each(function () {
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
	        		 	onsubmenu_xoaanh(link_vanban);
	        }
	      });
	    } catch (err) {
	      alert("func_dlg_tochuc_thamgia_show have dlg_tochuc_thamgia_show " + err);
	    }
   }
} 
</script>

<form id="form_tochuc_thamgia_them">
  <table>
  <tr>
      <td><b>Đề tài: </b></td>
      <td><select name="dlg_tochuc_thamgia_them_TheLoai_Detai" id="dlg_tochuc_thamgia_them_TheLoai_Detai"></select></td>
    </tr>
  <tr>
      <td><b>Thuyết minh đề tài: </b></td>
      <td><select name="dlg_tochuc_thamgia_them_TheLoai_TMDetai" id="dlg_tochuc_thamgia_them_TheLoai_TMDetai"></select></td>
    </tr>
   <tr>
   <tr>
      <td><b>Tổ chức: </b></td>
      <td><select name="dlg_tochuc_thamgia_them_ToChuc" id="dlg_tochuc_thamgia_them_ToChuc"></select></td>
    </tr>
    <tr>
      <td><b>Phân loại kết quả: </b></td>
      <td><select name="dlg_tochuc_thamgia_them_PLKQ" id="dlg_tochuc_thamgia_them_PLKQ"></select></td>
    </tr>
    <tr>
      <td><b>Vai trò: </b></td>
      <td><select name="dlg_tochuc_thamgia_them_VaiTro" id="dlg_tochuc_thamgia_them_VaiTro"></select></td>
    </tr>
    <tr>
      <td><b>Số cán bộ đại học: </b></td>
      <td><input name="dlg_tochuc_thamgia_them_SoCBDH" id="dlg_tochuc_thamgia_them_SoCBDH"
                 type="text" size="25"></td>
    </tr>
    <tr>
     <td><b>Số cán bộ thạc sĩ: </b></td>
      <td><input name="dlg_tochuc_thamgia_them_SoCBThS" id="dlg_tochuc_thamgia_them_SoCBThS"
                 type="text" size="25"></td>
    </tr>
    <tr>
     <td><b>Số cán bộ tiến sĩ: </b></td>
      <td><input name="dlg_tochuc_thamgia_them_SoCBTS" id="dlg_tochuc_thamgia_them_SoCBTS"
                 type="text" size="25">
                </td>
    </tr>
    <tr>
     <td><b>Nhà xưởng: </b></td>
      <td><textarea name="dlg_tochuc_thamgia_them_NhaXuong" id="dlg_tochuc_thamgia_them_NhaXuong"
               cols="40" rows="4" ></textarea></td>
    </tr>
     <tr>
     <td><b>Trang thiết bị: </b></td>
      <td><textarea name="dlg_tochuc_thamgia_them_TrangTB" id="dlg_tochuc_thamgia_them_TrangTB"
               cols="40" rows="4" ></textarea></td>
    </tr>
    <tr>
     <td><b>Kinh nghiệm: </b></td>
      <td><textarea name="dlg_tochuc_thamgia_them_KinhNghiem" id="dlg_tochuc_thamgia_them_KinhNghiem"
               cols="40" rows="4" ></textarea></td>
    </tr>
     
  </table>
</form>