<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
var fruits = [];
  $(function() {
	    $("#dlg_banghinh_kqxdNTM_them_XaDiem" ).combobox();
	    $("#dlg_banghinh_kqxdNTM_them_Folder" ).combobox();
	    
	    
  });
  
   function func_dlg_add_banghinh_kqxdNTM(isEdit) {
    $('#form_banghinh_kqxdNTM_them').each(function () {
       this.reset();
    });

    var datagrid_id = 'dlg_banghinh_kqxdNTM_show_datagrid';
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_XADIEM_TO_CBB, null , TYPE_DATA_HTML_CBB,'null', 'dlg_banghinh_kqxdNTM_them_XaDiem');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_FOLDER_HINHANH_DETAI_TO_CBB,  ' type_media = 0' , TYPE_DATA_HTML_CBB,'null', 'dlg_banghinh_kqxdNTM_them_Folder')
   
    try {
	      $('#dlg_banghinh_kqxdNTM_them').dialog({
	        title: "Cập nhật băng hình ",
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
	            var id_xadiem = $('#dlg_banghinh_kqxdNTM_them_XaDiem').val();
	            var id_folder = $('#dlg_banghinh_kqxdNTM_them_Folder').val();
	            var tenanh = $('#dlg_banghinh_kqxdNTM_them_Ten').val();
	            
	            var s = $('#dlg_banghinh_kqxdNTM_them_Video').val().replace(/\r?\n/g, '<br />');
	            var fruits = s.split('<br />');
	            
	            if (  fruits.length == 0 || id_folder == null
 			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
 	            }    
	            
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            
	            
	            for(var i = 0; i< fruits.length; i++){
	            utils.putfval_int('id_folder',  id_folder);
	            utils.putfval_int('id_xadiem',  id_xadiem);
	            utils.putfval_string('tenanh',  tenanh);
	            utils.putfval_int('type_media',  0);
	            
	            	utils.putfval_string('pathfile', fruits[i]);
	            }
	             
	            strSQL =  utils.genInsertCmd_PreStatement_MultipleValue('tbl_picture',fruits);
	            
	            //alert('Query =' + strSQL);
	
	            var strListValues = utils.getListValues();
	            //alert(strListValues);
	
	            var strListIDs = '';
	            var sqlTypeOrder = utils.getSQLTypeOrderInQuery();  // get datatypes in SQL sentence
	            //alert('sqlTypeOrder= ' + sqlTypeOrder);
	
	            var ret = cwrs_InsUpdMultiRecord2DB(root_href + HOME_SERVLET, ACT_DB_INSERT_UPDATE_MULTI_OBJECT, null, strSQL, strListValues, sqlTypeOrder, strListIDs, null);
	             if (ret == DB_STR_OK){
	                 try{
	               	  $('#form_banghinh_kqxdNTM_them').each(function () {
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
	      alert("func_dlg_banghinh_kqxdNTM_show have dlg_banghinh_kqxdNTM_show " + err);
	    }
} 
</script>

<form id="form_banghinh_kqxdNTM_them">
  <table>
 
  <tr>
      <td><b>Xã điểm: </b></td>
      <td><select name="dlg_banghinh_kqxdNTM_them_XaDiem" id="dlg_banghinh_kqxdNTM_them_XaDiem"></select></td>
    </tr>
  <tr>
      <td><b>Thư mục: </b></td>
      <td><select name="dlg_banghinh_kqxdNTM_them_Folder" id="dlg_banghinh_kqxdNTM_them_Folder"></select></td>
    </tr>
    <tr>
      <td><b>Tên video: </b></td>
      <td><input name="dlg_banghinh_kqxdNTM_them_Ten" id="dlg_banghinh_kqxdNTM_them_Ten"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Upload: </b></td>
      <td>  <textarea name="dlg_banghinh_kqxdNTM_them_Video" id="dlg_banghinh_kqxdNTM_them_Video" row="20" cols="100" style="width:400px"></textarea>
      </td>
    </tr>
  </table>
</form>