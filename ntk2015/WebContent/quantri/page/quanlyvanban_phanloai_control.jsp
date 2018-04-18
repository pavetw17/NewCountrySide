<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
  function func_dlg_add_qlvanban_phanloai(isEdit) {
    var row;
    var datagrid_id = 'dlg_qlvanban_phanloai_show_datagrid';
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
      if(row != null){ 
	      $.ajax({
	        url: root_href + HOME_SERVLET ,
	        data:{
	          action: ACT_GET_DATA_TO_EDIT_DS_PHANLOAIVANBAN,
	          condition: 'id_phanloai =' + row.id_phanloai
	        },
	        async:false,
	        success:function(jsonData) {
	          var jsonObject = JSON.parse(jsonData);
	          document.getElementById('dlg_qlvanban_phanloai_them_Ten').value = jsonObject.rows[0].loai_vanbanphaply;
	          return;
	        }});
      }else{
    	  kiemtraRowNULL = false;
     	 // document.getElementById('form_tintuchoatdong_them').style.display = 'none';
     	  $('#form_qlvanban_phanloai_them').hide();
     	  msgalert_autoclose('Thông báo','Chọn văn bản','error');
       } 
    }
    if(kiemtraRowNULL){
    try {
      $('#dlg_qlvanban_phanloai_them').dialog({
        title: "Cập nhật loại văn bản ",
        modal: false, open: function () {
          $(this).dialog('widget').draggable('option', {containment: false});
        },
        height: 200,
        width: 400,
        collapsible: true,
        draggable: true,
        resizable: false,
        position: [450, 100],

        buttons: {
          "Cập nhật": function () {
            var tenLoaiVanBan = document.getElementById('dlg_qlvanban_phanloai_them_Ten').value;

            if (kiemtrarong(tenLoaiVanBan) ){
              msgalert_autoclose('Thông báo','Không được bỏ trống','warning');
              return;
            }

            var max;
            var check;
            if(!isEdit){ //add
              $.ajax({
                url: root_href + HOME_SERVLET ,
                data:
                {
                  action: ACT_DB_CHECK_DATA_EXISTS,
                  tableName:'tbl_phanloai_vanban',
                  fieldName:'loai_vanbanphaply' ,
                  condition: 'lower(loai_vanbanphaply)='+ ' lower(\''+tenLoaiVanBan+'\') '
                },
                async:false,
                success:function(result) {
                  if (result == DB_STR_OK){
                    check=true;
                  }
                  else {
                    check=false; //not exists
                  }
                  return;
                }
              });
              if (check == true){
                msgalert_autoclose('Thông báo',' Số liệu này đã tồn tại!','warning');
                return;
              } else{
                $.ajax({
                  url: root_href + HOME_SERVLET ,
                  data:
                  {
                    action: ACT_DB_MAX_DATA,
                    tableName:'tbl_phanloai_vanban',
                    fieldName:'id_phanloai' ,
                    condition: null
                  },
                  async:false,
                  success:function(result) {
                    max = parseInt(result)+1 ;
                  }
                });
              }
            }else{ //edit
              $.ajax({
                url: root_href + QUYEN_SERVLET ,
                data:
                {
                  action: ACT_DB_CHECK_DATA_EXISTS,
                  tableName:'tbl_phanloai_vanban',
                  fieldName:'loai_vanbanphaply' ,
                  condition: 'lower(loai_vanbanphaply)='+ ' lower( \''+ tenLoaiVanBan +'\') '
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
            utils.putfval_string('loai_vanbanphaply', trim(tenLoaiVanBan));
           
            if (isEdit){
              //last param
              utils.putfval_int_condition('id_phanloai', row.id_phanloai);
            }
            else{
              utils.putfval_int('id_phanloai', max);
            }

            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_phanloai_vanban'):utils.genUpdateCmd_PreStatement('tbl_phanloai_vanban','id_phanloai=?'));
            /*alert('Query =' + strSQL);*/

            var strListValues = utils.getListValues();
            /* alert(strListValues);*/

            var strListIDs = '';
            var sqlTypeOrder = utils.getSQLTypeOrderInQuery();  // get datatypes in SQL sentence
            //alert('sqlTypeOrder= ' + sqlTypeOrder);

            var ret = cwrs_InsUpdMultiRecord2DB(root_href + HOME_SERVLET, ACT_DB_INSERT_UPDATE_MULTI_OBJECT, null, strSQL, strListValues, sqlTypeOrder, strListIDs, null);
            if (ret == DB_STR_OK){
              if (isEdit){
                $('#' + datagrid_id).datagrid('reload');  //alert('insert/update multi object OK');
              }else {
                try{
                  $('#' + datagrid_id).datagrid('load');
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
        /* close: function () {

        } */
      });
    } catch (err) {
      alert("func_dlg_qlvanban_phanloai_show have dlg_qlvanban_phanloai_show " + err);
    }
  }
}
</script>
<form id="form_qlvanban_phanloai_them">
  <table>
    <tr>
      <td><b>Tên loại văn bản: </b></td>
      <td><input name="dlg_qlvanban_phanloai_them_Ten" id="dlg_qlvanban_phanloai_them_Ten"
                 type="text" size="25"></td>
    </tr>
  </table>
</form>