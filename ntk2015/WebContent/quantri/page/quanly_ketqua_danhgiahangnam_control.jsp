<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">

  $(function() {
	  $("#dlg_ketqua_danhgiahangnam_them_XaDiem" ).combobox();
	  $("#dlg_ketqua_danhgiahangnam_them_TieuChi" ).combobox();
  });

  function func_dlg_add_ketqua_danhgiahangnam(isEdit) {
    $('#form_ketqua_danhgiahangnam_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_XADIEM_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_ketqua_danhgiahangnam_them_XaDiem');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TIEUCHI_XD_NTM_CHA_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_ketqua_danhgiahangnam_them_TieuChi');
    var row;
    var datagrid_id = 'dlg_ketqua_danhgiahangnam_show_datagrid';
    var tiendo_hoanthanh = "";
    var combo = "";
    var id_xadiem = ""; 
    var danhgiachonam = "";
    var ngay_danhgia = "";
    var ghichu ="";
    var tieuchi_ungdung_khcn ;
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_KETQUA_DANHGIA_HANGNAM,
    	          condition: 'id =' + row.id
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          var jsonObject = JSON.parse(jsonData);
    	          cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_XADIEM_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_ketqua_danhgiahangnam_them_XaDiem');
    	          cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TIEUCHI_XD_NTM_CHA_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_ketqua_danhgiahangnam_them_TieuChi');
    	        
    	          document.getElementById('dlg_ketqua_danhgiahangnam_them_TienDoHoanThanh').value = jsonObject.rows[0].tiendo_hoanthanh;
    	          document.getElementById('dlg_ketqua_danhgiahangnam_them_Tomtat').value = jsonObject.rows[0].ghichu;
    			  document.getElementById('dlg_ketqua_danhgiahangnam_them_DanhGiaHangNam').value = gm.date.Int2DateString(jsonObject.rows[0].danhgiachonam);
				  document.getElementById("dlg_ketqua_danhgiahangnam_them_NgayDanhGia").value= gm.date.Int2DateString(jsonObject.rows[0].ngay_danhgia);
     	          $('#dlg_ketqua_danhgiahangnam_them_TieuChi').combobox('autocomplete',jsonObject.rows[0].id_tieuchi); 
    	          $('#dlg_ketqua_danhgiahangnam_them_XaDiem').combobox('autocomplete',jsonObject.rows[0].id_xadiem); 
    			  $('input[name="rdb_tieuchi"][value="' + jsonObject.rows[0].tieuchi_ungdung_khcn + '"]').prop('checked', true);
    			  
    			  return;
    	        }}); 
       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_ketqua_danhgiahangnam_them').style.display = 'none';
    	  $('#form_ketqua_danhgiahangnam_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn giới thiệu','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_ketqua_danhgiahangnam_them').dialog({
	        title: "Cập nhật giới thiệu ",
	        open: function () {
	          $(this).dialog('widget').draggable('option', {containment: false});
	        },
	        height: 450,
	        width: 800,
	        collapsible: true,
	        draggable: true,
	        resizable: true,
	        position: [350, 100],
	        modal: true,
	        buttons: {
	          "Cập nhật": function () {
	            tiendo_hoanthanh = document.getElementById('dlg_ketqua_danhgiahangnam_them_TienDoHoanThanh').value;
	            combo = document.getElementById('dlg_ketqua_danhgiahangnam_them_XaDiem');
			    id_xadiem = combo.options[combo.selectedIndex].value; 
	            combo = document.getElementById('dlg_ketqua_danhgiahangnam_them_TieuChi');
			    id_tieuchi = combo.options[combo.selectedIndex].value; 
			    ghichu = document.getElementById('dlg_ketqua_danhgiahangnam_them_Tomtat').value;
			    danhgiachonam = document.getElementById('dlg_ketqua_danhgiahangnam_them_DanhGiaHangNam').value;
			    ngay_danhgia = document.getElementById("dlg_ketqua_danhgiahangnam_them_NgayDanhGia").value;
				tieuchi_ungdung_khcn = $("input[name='rdb_tieuchi']:checked").val();
				
			    if (!isNumber(tiendo_hoanthanh) || kiemtrarong(tiendo_hoanthanh)|| kiemtrarong(ghichu) || kiemtrarong(danhgiachonam) || id_xadiem == -1 || !ngaythang(ngay_danhgia) || id_tieuchi == -1 ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }  
			    
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_int('id_tieuchi', id_tieuchi);
	            utils.putfval_int('id_xadiem', id_xadiem);
	            utils.putfval_string('ghichu', trim(ghichu));
	            utils.putfval_int('tiendo_hoanthanh', trim(tiendo_hoanthanh));
	            utils.putfval_int('ngay_danhgia', gm.date.stringDate2Int(ngay_danhgia));
	            utils.putfval_int('danhgiachonam', gm.date.stringDate2Int(danhgiachonam));
	            utils.putfval_int('tieuchi_ungdung_khcn', tieuchi_ungdung_khcn);
	            if (isEdit){
	              //last param
	              utils.putfval_int_condition('id', row.id);
	            }
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_danhgia_kq_theonam'):utils.genUpdateCmd_PreStatement('tbl_danhgia_kq_theonam','id=?'));
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
	               	  $('#form_ketqua_danhgiahangnam_them').each(function () {
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
	      alert("func_dlg_ketqua_danhgiahangnam_show have dlg_ketqua_danhgiahangnam_show " + err);
	    }
   }
} 
</script>

<form id="form_ketqua_danhgiahangnam_them">
  <table>
  <tr>
      <td><b>Tiêu chí: </b></td>
      <td><select name="dlg_ketqua_danhgiahangnam_them_TieuChi" id="dlg_ketqua_danhgiahangnam_them_TieuChi"></select></td>
    </tr>
  <tr>
      <td><b>Xã điểm: </b></td>
      <td><select name="dlg_ketqua_danhgiahangnam_them_XaDiem" id="dlg_ketqua_danhgiahangnam_them_XaDiem"></select></td>
    </tr>
   <tr>
      <td><b>Tiến độ hoành thành: </b></td>
      <td><input name="dlg_ketqua_danhgiahangnam_them_TienDoHoanThanh" id="dlg_ketqua_danhgiahangnam_them_TienDoHoanThanh"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Ngày đánh giá: </b></td>
      <td><input name="dlg_ketqua_danhgiahangnam_them_NgayDanhGia" id="dlg_ketqua_danhgiahangnam_them_NgayDanhGia" class="datepicker"
                 type="text" size="25"></td>
    </tr>
    <tr>
     <td><b>Tiêu chí ứng dụng KHCN: </b></td>
      <td>  
      <input type="radio" value="1" checked id="rdb_tieuchi" name="rdb_tieuchi" style="width: 16px; height: 16px;">Có
		<input type="radio" value="0" name="rdb_tieuchi" id="rdb_tieuchi" style=" width: 16px; height: 16px; margin-left: 40px;">Không</td>
        
    </tr>
    <tr>
      <td><b>Đánh giá cho năm: </b></td>
      <td><input name="dlg_ketqua_danhgiahangnam_them_DanhGiaHangNam" id="dlg_ketqua_danhgiahangnam_them_DanhGiaHangNam" class="datepicker"
                  type="text" size="25"></td>
    </tr>
    <tr>
     <td><b>Ghi chú: </b></td>
      <td><textarea name="dlg_ketqua_danhgiahangnam_them_Tomtat" id="dlg_ketqua_danhgiahangnam_them_Tomtat"
                 row="20" cols="100" style="width:400px"></textarea></td>
    </tr>
  </table>
</form>