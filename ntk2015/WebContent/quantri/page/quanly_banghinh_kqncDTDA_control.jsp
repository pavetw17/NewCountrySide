<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
var fruits = [];
  $(function() {
	    $("#dlg_banghinh_kqncDTDA_them_TheLoai_Detai" ).combobox();
	    $("#dlg_banghinh_kqncDTDA_them_TheLoai_TMDetai" ).combobox();
	    $("#dlg_banghinh_kqncDTDA_them_XaDiem" ).combobox();
	    $("#dlg_banghinh_kqncDTDA_them_ToChuc" ).combobox();
	    $("#dlg_banghinh_kqncDTDA_them_Folder" ).combobox();
	    
	    $("#dlg_banghinh_kqncDTDA_them_TheLoai_Detai").change(function() {
	    	$('#dlg_banghinh_kqncDTDA_them_TheLoai_TMDetai').next().val('');
			cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TOCHUC_TO_CBB, 'b.id_detai='+ this.value, TYPE_DATA_HTML_CBB,'null', 'dlg_banghinh_kqncDTDA_them_TheLoai_TMDetai');
			cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_FOLDER_HINHANH_DETAI_TO_CBB, 'id_detai='+ this.value + ' and type_media = 0' , TYPE_DATA_HTML_CBB,'null', 'dlg_banghinh_kqncDTDA_them_Folder');
	    });
	    
  });
  
   function func_dlg_add_banghinh_kqncDTDA(isEdit) {
    $('#form_banghinh_kqncDTDA_them').each(function () {
       this.reset();
    });

    var datagrid_id = 'dlg_banghinh_kqncDTDA_show_datagrid';
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DETAI_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_banghinh_kqncDTDA_them_TheLoai_Detai');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TOCHUC_DETAI_TOCHUC_TO_CBB, null , TYPE_DATA_HTML_CBB,'null', 'dlg_banghinh_kqncDTDA_them_ToChuc');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_XADIEM_TO_CBB, null , TYPE_DATA_HTML_CBB,'null', 'dlg_banghinh_kqncDTDA_them_XaDiem');
    
   
    try {
	      $('#dlg_banghinh_kqncDTDA_them').dialog({
	        title: "Cập nhật băng hìnhh ",
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
	            var id_detai = $('#dlg_banghinh_kqncDTDA_them_TheLoai_Detai').val();
	            var id_thuyetminhdetai  = $('#dlg_banghinh_kqncDTDA_them_TheLoai_TMDetai').val();
	            var id_tochuc = $('#dlg_banghinh_kqncDTDA_them_ToChuc').val();
	            var id_xadiem = $('#dlg_banghinh_kqncDTDA_them_XaDiem').val();
	            var id_folder = $('#dlg_banghinh_kqncDTDA_them_Folder').val();
	            var tenanh = $('#dlg_banghinh_kqncDTDA_them_Ten').val();
	            
	            var s = $('#dlg_banghinh_kqncDTDA_them_Video').val().replace(/\r?\n/g, '<br />');
	            var fruits = s.split('<br />');
	            
	            if (  fruits.length == 0 || id_thuyetminhdetai == null || id_folder == null
 			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
 	            }    
	            
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            
	            
	            for(var i = 0; i< fruits.length; i++){
	            utils.putfval_int('id_detai',  id_detai);
	            utils.putfval_int('id_thuyetminhdetai',  id_thuyetminhdetai);
	            utils.putfval_int('id_tochuc',  id_tochuc);
	            utils.putfval_int('id_folder',  id_folder);
	            utils.putfval_int('id_xadiem',  id_xadiem);
	            utils.putfval_string('tenanh',  tenanh);
	            utils.putfval_int('type_media',  0);
	            
	            	utils.putfval_string('pathfile', fruits[i]);
	            }
	             
	            strSQL =  utils.genInsertCmd_PreStatement_MultipleValue('tbl_picture_detai',fruits);
	            
	            //alert('Query =' + strSQL);
	
	            var strListValues = utils.getListValues();
	            //alert(strListValues);
	
	            var strListIDs = '';
	            var sqlTypeOrder = utils.getSQLTypeOrderInQuery();  // get datatypes in SQL sentence
	            //alert('sqlTypeOrder= ' + sqlTypeOrder);
	
	            var ret = cwrs_InsUpdMultiRecord2DB(root_href + HOME_SERVLET, ACT_DB_INSERT_UPDATE_MULTI_OBJECT, null, strSQL, strListValues, sqlTypeOrder, strListIDs, null);
	             if (ret == DB_STR_OK){
	                 try{
	               	  $('#form_banghinh_kqncDTDA_them').each(function () {
	               	       this.reset();
	               	  });
	               	  fruits = [];
	                  $('#' + datagrid_id).datagrid('reload');
	                }catch(err){
	                  msgalert_autoclose('Thông báo', err ,'warning');
	                  return;
	                }
	              
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
	      alert("func_dlg_banghinh_kqncDTDA_show have dlg_banghinh_kqncDTDA_show " + err);
	    }
} 
</script>

<form id="form_banghinh_kqncDTDA_them">
  <table>
  <tr>
      <td><b>Đề tài: </b></td>
      <td><select name="dlg_banghinh_kqncDTDA_them_TheLoai_Detai" id="dlg_banghinh_kqncDTDA_them_TheLoai_Detai"></select></td>
  </tr>
  <tr>
      <td><b>Thuyết minh đề tài: </b></td>
      <td><select name="dlg_banghinh_kqncDTDA_them_TheLoai_TMDetai" id="dlg_banghinh_kqncDTDA_them_TheLoai_TMDetai"></select></td>
    </tr>
  <tr>
  <tr>
      <td><b>Tổ chức: </b></td>
      <td><select name="dlg_banghinh_kqncDTDA_them_ToChuc" id="dlg_banghinh_kqncDTDA_them_ToChuc"></select></td>
    </tr>
  <tr>
      <td><b>Xã điểm: </b></td>
      <td><select name="dlg_banghinh_kqncDTDA_them_XaDiem" id="dlg_banghinh_kqncDTDA_them_XaDiem"></select></td>
    </tr>
  <tr>
      <td><b>Thư mục: </b></td>
      <td><select name="dlg_banghinh_kqncDTDA_them_Folder" id="dlg_banghinh_kqncDTDA_them_Folder"></select></td>
    </tr>
    <tr>
      <td><b>Tên video: </b></td>
      <td><input name="dlg_banghinh_kqncDTDA_them_Ten" id="dlg_banghinh_kqncDTDA_them_Ten"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Upload: </b></td>
      <td>  <textarea name="dlg_banghinh_kqncDTDA_them_Video" id="dlg_banghinh_kqncDTDA_them_Video" row="20" cols="100" style="width:400px"></textarea>
      </td>
    </tr>
  </table>
</form>