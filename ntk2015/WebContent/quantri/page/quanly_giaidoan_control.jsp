<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
  var link_vanban=''; 
  
  $(function() {
	  $('form').submit(function(e){
		    e.preventDefault();
		  });
	  
	    $("#dlg_giaidoan_them_ThuyetMinh" ).combobox();
  });
  

  
   function func_dlg_add_giaidoan(isEdit) {
    $('#form_giaidoan_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_giaidoan_them_ThuyetMinh');
    
    var row;
    var datagrid_id = 'dlg_giaidoan_show_datagrid';
    var kiemtraRowNULL = true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_GIAIDOAN,
    	          condition: 'id_giaidoan =' + row.id_giaidoan
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          var jsonObject = JSON.parse(jsonData);
    	          //document.getElementById('dlg_giaidoan_them_ChuyenGia').value = jsonObject.rows[0].id_chuyengia; //not use 
    	          $('#dlg_giaidoan_them_ThuyetMinh').combobox('autocomplete',jsonObject.rows[0].id_thuyetminh_detai); 
    	          document.getElementById('dlg_giaidoan_them_TenGD').value = jsonObject.rows[0].tengiaidoan;
				  document.getElementById("dlg_giaidoan_them_NoiDung").value= jsonObject.rows[0].noidung;
    			  document.getElementById('dlg_giaidoan_them_TuNgay').value = gm.date.Int2DateString(jsonObject.rows[0].tungay);
    			  document.getElementById('dlg_giaidoan_them_DenNgay').value = gm.date.Int2DateString(jsonObject.rows[0].denngay);
    			  return;
    	        }}); 
       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_giaidoan_them').style.display = 'none';
    	  $('#form_giaidoan_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn giai đoạn','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_giaidoan_them').dialog({
	        title: "Cập nhật giai đoạn ",
	        open: function () {
	          $(this).dialog('widget').draggable('option', {containment: false});
	        },
	        height: 500,
	        width: 550,
	        collapsible: true,
	        draggable: true,
	        resizable: true,
	        position: [400, 100],
	        modal: true,
	        buttons: {
	          "Cập nhật": function () {
	            var tengiaidoan = $('#dlg_giaidoan_them_TenGD').val();
	            var noidung = $('#dlg_giaidoan_them_NoiDung').val();
	            var id_thuyetminh_detai = $('#dlg_giaidoan_them_ThuyetMinh').val();
	            var tungay = $('#dlg_giaidoan_them_TuNgay').val();
	            var denngay = $('#dlg_giaidoan_them_DenNgay').val();
	            
			    if ( kiemtrarong(tengiaidoan)    
			    	 || kiemtrarong(noidung)
			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }   
	            
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_int('id_thuyetminh_detai', id_thuyetminh_detai);
	            utils.putfval_string('noidung', trim(noidung));
	            utils.putfval_string('tengiaidoan', trim(tengiaidoan));
	            utils.putfval_int('tungay', gm.date.stringDate2Int(tungay));
	            utils.putfval_int('denngay', gm.date.stringDate2Int(denngay));
	            if (isEdit){
	              utils.putfval_int_condition('id_giaidoan', row.id_giaidoan);
	            }else{ 
	            	 $.ajax({
                         url: root_href + HOME_SERVLET ,
                         data:
                         {
                           action: ACT_DB_MAX_DATA,
                           tableName:'tbl_giaidoan',
                           fieldName:'id_giaidoan' ,
                           condition: null
                         },
                         async:false,
                         success:function(result) {
                           max = parseInt(result)+1 ;
                         }
                       });
	            	 utils.putfval_int('id_giaidoan', max);
                }
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_giaidoan'):utils.genUpdateCmd_PreStatement('tbl_giaidoan','id_giaidoan=?'));
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
	               	  $('#form_giaidoan_them').each(function () {
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
	      alert("func_dlg_giaidoan_show have dlg_giaidoan_show " + err);
	    }
   }
} 
</script>

<form id="form_giaidoan_them">
  <table>
  <tr>
     <td><b>Thuyết minh đề tài: </b></td>
      <td><select name="dlg_giaidoan_them_ThuyetMinh" id="dlg_giaidoan_them_ThuyetMinh"></select></textarea></td>
    </tr>
    <tr>
      <td><b>Tên giai đoạn </b></td>
      <td><input name="dlg_giaidoan_them_TenGD" id="dlg_giaidoan_them_TenGD"
                 type="text" size="25"></td>
    </tr>
     <tr>
     <td><b>Nội dung: </b></td>
      <td><textarea name="dlg_giaidoan_them_NoiDung" id="dlg_giaidoan_them_NoiDung"
                 row="20" cols="100" style="width:400px"></textarea></td>
    </tr>
       <tr>
     <td><b>Từ ngày: </b></td>
      <td><input name="dlg_giaidoan_them_TuNgay" id="dlg_giaidoan_them_TuNgay" class="datepicker"
                 type="text" size="25"></td>
    </tr>
     <tr>
     <td><b>Đến ngày: </b></td>
      <td><input name="dlg_giaidoan_them_DenNgay" id="dlg_giaidoan_them_DenNgay" class="datepicker"
                 type="text" size="25"></td>
    </tr>
      
  </table>
</form>