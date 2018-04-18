<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
  $(function() {
	    $("#dlg_hinhanh_thumuc_them_TheLoai_Detai" ).combobox();
	    $("#dlg_hinhanh_thumuc_them_XaDiem" ).combobox();
  });
  
   function func_dlg_add_hinhanh_thumuc(isEdit) {
    $('#form_hinhanh_thumuc_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DUAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_hinhanh_thumuc_them_TheLoai_Detai');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_XADIEM_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_hinhanh_thumuc_them_XaDiem');
   
    var row;
    var datagrid_id = 'dlg_hinhanh_thumuc_show_datagrid';
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_THUMUC,
    	          condition: ' id_folder='+ row.id_folder 
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          var jsonObject = JSON.parse(jsonData);
    	          //document.getElementById('dlg_hinhanh_thumuc_them_XaDiem').value = jsonObject.rows[0].id_xadiem; //not use 
    	          $('#dlg_hinhanh_thumuc_them_TheLoai_Detai').combobox('autocomplete',jsonObject.rows[0].id_detai); 
    	          $('#dlg_hinhanh_thumuc_them_XaDiem').combobox('autocomplete',jsonObject.rows[0].id_xadiem); 
    			  document.getElementById("dlg_hinhanh_thumuc_them_Ten").value= jsonObject.rows[0].foldername;
    			  $("#dlg_hinhanh_thumuc_them_Loai").val(jsonObject.rows[0].type_media);
    			  return;
    	        }}); 
       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_hinhanh_thumuc_them').style.display = 'none';
    	  $('#form_hinhanh_thumuc_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn cơ chế','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_hinhanh_thumuc_them').dialog({
	        title: "Cập nhật cơ chế ",
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
	            var id_detai = $('#dlg_hinhanh_thumuc_them_TheLoai_Detai').val();
	            var id_xadiem  = $('#dlg_hinhanh_thumuc_them_XaDiem').val();
	            var foldername = $('#dlg_hinhanh_thumuc_them_Ten').val();
	            var type_media = $('#dlg_hinhanh_thumuc_them_Loai').val();
			   
	            if ( kiemtrarong(foldername)   
			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }   
	            
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_string('foldername',  foldername);
	            utils.putfval_int('id_detai',  id_detai);
	            utils.putfval_int('id_xadiem',  id_xadiem);
	            utils.putfval_int('type_media',  type_media);
	            
	            if (isEdit){
	              	utils.putfval_int_condition('id_folder', row.id_folder);
	            }
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_picture_folder'):utils.genUpdateCmd_PreStatement('tbl_picture_folder','id_folder=?'));
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
	               	  $('#form_hinhanh_thumuc_them').each(function () {
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
	      alert("func_dlg_hinhanh_thumuc_show have dlg_hinhanh_thumuc_show " + err);
	    }
   }
} 
</script>

<form id="form_hinhanh_thumuc_them">
  <table>
  <tr>
      <td><b>Đề tài: </b></td>
      <td><select name="dlg_hinhanh_thumuc_them_TheLoai_Detai" id="dlg_hinhanh_thumuc_them_TheLoai_Detai"></select></td>
    </tr>
  <tr>
      <td><b>Xã điểm: </b></td>
      <td><select name="dlg_hinhanh_thumuc_them_XaDiem" id="dlg_hinhanh_thumuc_them_XaDiem"></select></td>
    </tr>
   <tr>
    <tr>
      <td><b>Tên: </b></td>
      <td><input name="dlg_hinhanh_thumuc_them_Ten" id="dlg_hinhanh_thumuc_them_Ten"
                 type="text" size="25"></td>
    </tr>
     <tr>
      <td><b>Loại: </b></td>
      <td><select name="dlg_hinhanh_thumuc_them_Loai" id="dlg_hinhanh_thumuc_them_Loai">
      		<option value="0">Băng hình</option>
      		<option value="1">Hình ảnh</option>
      	</select>
      </td>
    </tr>
   <tr>
  </table>
</form>