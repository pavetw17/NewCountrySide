<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
  $(function() {
	    $("#dlg_noidungcv_con_them_TheLoai_TMDetai" ).combobox();
	    $("#dlg_noidungcv_con_them_ToChuc" ).combobox();
	    $("#dlg_noidungcv_con_them_GiaiDoan" ).combobox();
	    $("#dlg_noidungcv_con_them_TheLoai_NhomNoiDung" ).combobox();
	    
  });
  
   function func_dlg_add_noidungcv_con(isEdit) {
    $('#form_noidungcv_con_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_noidungcv_con_them_ToChuc');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_GIAI_DOAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_noidungcv_con_them_GiaiDoan');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_noidungcv_con_them_TheLoai_TMDetai');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_NOIDUNG_THUYETMINH_NHOM_TO_CBB, 'id_noidung_cha is null', TYPE_DATA_HTML_CBB,'null', 'dlg_noidungcv_con_them_TheLoai_NhomNoiDung');
   
    var row;
    var datagrid_id = 'dlg_noidungcv_con_show_datagrid';
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_NOIDUNG_THUYETMINH_CON,
    	          condition: ' id_noidung='+ row.id_noidung 
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          var jsonObject = JSON.parse(jsonData);
    	          //document.getElementById('dlg_noidungcv_con_them_TheLoai_TMDetai').value = jsonObject.rows[0].id_thuyetminh_detai; //not use 
    	          $('#dlg_noidungcv_con_them_TheLoai_TMDetai').combobox('autocomplete',jsonObject.rows[0].id_thuyetminhdetai); 
    	          $('#dlg_noidungcv_con_them_ToChuc').combobox('autocomplete',jsonObject.rows[0].id_tochuc); 
    	          $('#dlg_noidungcv_con_them_GiaiDoan').combobox('autocomplete',jsonObject.rows[0].id_giaidoan); 
    	          $('#dlg_noidungcv_con_them_TheLoai_NhomNoiDung').combobox('autocomplete',jsonObject.rows[0].id_noidung_cha); 
    			  document.getElementById('dlg_noidungcv_con_them_NoiDung').value =  jsonObject.rows[0].ten_noidung;
    			  document.getElementById('dlg_noidungcv_con_them_TGBatDau').value =  gm.date.Int2DateString(jsonObject.rows[0].thoigian_batdau);
    			  document.getElementById('dlg_noidungcv_con_them_TGKetThuc').value =  gm.date.Int2DateString(jsonObject.rows[0].thoigian_ketthuc);
    			  document.getElementById('dlg_noidungcv_con_them_PTHoanThanh').value =  jsonObject.rows[0].phantram_hoanthanh;
    			  return;
    	        }}); 
       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_noidungcv_con_them').style.display = 'none';
    	  $('#form_noidungcv_con_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn nội dung','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_noidungcv_con_them').dialog({
	        title: "Chọn nội dung ",
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
	            var id_noidung_cha  = $('#dlg_noidungcv_con_them_TheLoai_NhomNoiDung').val();
	            var id_thuyetminh_detai  = $('#dlg_noidungcv_con_them_TheLoai_TMDetai').val();
	            var id_tochuc = $('#dlg_noidungcv_con_them_ToChuc').val();
	            var id_giaidoan = $('#dlg_noidungcv_con_them_GiaiDoan').val();
	            var ten_noidung = $('#dlg_noidungcv_con_them_NoiDung').val();
	            var thoigian_batdau = $('#dlg_noidungcv_con_them_TGBatDau').val();
	            var thoigian_ketthuc = $('#dlg_noidungcv_con_them_TGKetThuc').val();
	            var phantram_hoanthanh = $('#dlg_noidungcv_con_them_PTHoanThanh').val();
	            
			    if ( kiemtrarong(ten_noidung)  || kiemtrarong(thoigian_batdau) || kiemtrarong(thoigian_ketthuc) ||kiemtrarong(phantram_hoanthanh)  
			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }   
	            
			    var max;var check;
			    
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_int('id_thuyetminh_detai',  id_thuyetminh_detai);
	            utils.putfval_int('id_tochuc',  id_tochuc);
	            utils.putfval_int('id_noidung_cha',  id_noidung_cha);
	            utils.putfval_int('id_giaidoan',  id_giaidoan);
	            utils.putfval_int('thoigian_batdau',  gm.date.stringDate2Int(thoigian_batdau));
	            utils.putfval_int('thoigian_ketthuc',  gm.date.stringDate2Int(thoigian_ketthuc));
	            utils.putfval_string('ten_noidung',  ten_noidung);
	            utils.putfval_int('phantram_hoanthanh',  phantram_hoanthanh);
	           
	            if(!isEdit){ 
                    $.ajax({
                        url: root_href + HOME_SERVLET ,
                        data:
                        {
                            action: ACT_DB_CHECK_DATA_EXISTS,
                            tableName:'tbl_noidung_cv',
                            fieldName:   'id_tochuc',
                            condition: ' id_thuyetminh_detai='+id_thuyetminh_detai +' and id_giaidoan='+id_giaidoan 
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
		                       tableName:'tbl_noidung_cv',
		                       fieldName:'id_noidung' ,
		                       condition: null
		                     },
		                     async:false,
		                     success:function(result) {
		                       max = parseInt(result)+1 ;
		                     }
		                   });
		            	 utils.putfval_int('id_noidung', max);
		               }
                }
	            
	            
	            if (isEdit){
	              	utils.putfval_int_condition('id_noidung', row.id_noidung);
	            }
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_noidung_cv'):utils.genUpdateCmd_PreStatement('tbl_noidung_cv','id_noidung=? '));
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
	               	  $('#form_noidungcv_con_them').each(function () {
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
	      alert("func_dlg_noidungcv_con_show have dlg_noidungcv_con_show " + err);
	    }
   }
} 
</script>

<form id="form_noidungcv_con_them">
  <table>
  <tr>
      <td><b>Nhóm nội dung: </b></td>
      <td><select name="dlg_noidungcv_con_them_TheLoai_NhomNoiDung" id="dlg_noidungcv_con_them_TheLoai_NhomNoiDung"></select></td>
    </tr>
  <tr>
      <td><b>Thuyết minh đề tài: </b></td>
      <td><select name="dlg_noidungcv_con_them_TheLoai_TMDetai" id="dlg_noidungcv_con_them_TheLoai_TMDetai"></select></td>
    </tr>
   <tr>
      <td><b>Tổ chức: </b></td>
      <td><select name="dlg_noidungcv_con_them_ToChuc" id="dlg_noidungcv_con_them_ToChuc"></select></td>
    </tr>
   <tr>
      <td><b>Giai đoạn: </b></td>
      <td><select name="dlg_noidungcv_con_them_GiaiDoan" id="dlg_noidungcv_con_them_GiaiDoan"></select></td>
    </tr>
    <tr>
      <td><b>Tên nội dung: </b></td>
      <td><input name="dlg_noidungcv_con_them_NoiDung" id="dlg_noidungcv_con_them_NoiDung"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Thời gian bắt đầu: </b></td>
      <td><input name="dlg_noidungcv_con_them_TGBatDau" id="dlg_noidungcv_con_them_TGBatDau"
                 type="text" size="25" class="datepicker"/></td>
    </tr>
    <tr>
      <td><b>Thời gian kết thúc: </b></td>
      <td><input name="dlg_noidungcv_con_them_TGKetThuc" id="dlg_noidungcv_con_them_TGKetThuc"
                 type="text" size="25" class="datepicker"></td>
    </tr>
    <tr>
      <td><b>Phần trăm hoàn thành: </b></td>
      <td><input name="dlg_noidungcv_con_them_PTHoanThanh" id="dlg_noidungcv_con_them_PTHoanThanh"
                 type="text" size="25"></td>
    </tr>
  </table>
</form>