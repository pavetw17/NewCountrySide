<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
  $(function() {
	    $("#dlg_sanpham_them_TheLoai_SanPham" ).combobox();
	    $("#dlg_sanpham_them_TheLoai_TMDetai" ).combobox();
	    
	    $('form').submit(function(e){
		    e.preventDefault();
		  });
  });
  
   function func_dlg_add_sanpham(isEdit) {
    $('#form_sanpham_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_PHANLOAI_SANPHAM_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_sanpham_them_TheLoai_SanPham');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_sanpham_them_TheLoai_TMDetai');
   
    var row;
    var datagrid_id = 'dlg_sanpham_show_datagrid';
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_SANPHAM,
    	          condition: ' id_sanpham='+ row.id_sanpham 
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          var jsonObject = JSON.parse(jsonData);
    	          //document.getElementById('dlg_sanpham_them_TheLoai_TMDetai').value = jsonObject.rows[0].id_thuyetminh_detai; //not use 
    	          $('#dlg_sanpham_them_TheLoai_SanPham').combobox('autocomplete',jsonObject.rows[0].id_loaisp); 
    	          $('#dlg_sanpham_them_TheLoai_TMDetai').combobox('autocomplete',jsonObject.rows[0].id_thuyetminh_detai); 
    			  document.getElementById('dlg_sanpham_them_TenSP').value =  jsonObject.rows[0].tensanpham;
    			  document.getElementById('dlg_sanpham_them_CTCL').value =  jsonObject.rows[0].chitieuchatluong;
    			  document.getElementById('dlg_sanpham_them_DonViDo').value =  jsonObject.rows[0].donvido;
    			  return;
    	        }}); 
       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_sanpham_them').style.display = 'none';
    	  $('#form_sanpham_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn sản phẩm','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_sanpham_them').dialog({
	        title: "Cập nhật sản phẩm ",
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
	            var id_loaisp = $('#dlg_sanpham_them_TheLoai_SanPham').val();
	            var id_thuyetminh_detai  = $('#dlg_sanpham_them_TheLoai_TMDetai').val();
	            var tensanpham = $('#dlg_sanpham_them_TenSP').val();
	            var chitieuchatluong = $('#dlg_sanpham_them_CTCL').val();
	            var donvido = $('#dlg_sanpham_them_DonViDo').val();
	            
			    if ( kiemtrarong(tensanpham)   || kiemtrarong(chitieuchatluong) || kiemtrarong(donvido) 
			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }   
	            
			    var max;var check;
			    
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_string('tensanpham',  tensanpham);
	            utils.putfval_string('chitieuchatluong',  chitieuchatluong);
	            utils.putfval_string('donvido',  donvido);
	            utils.putfval_int('id_loaisp',  id_loaisp);
	            utils.putfval_int('id_thuyetminh_detai',  id_thuyetminh_detai);
	           
	            if (isEdit){
	              	utils.putfval_int_condition('id_sanpham', row.id_sanpham);
	            }else{
	            	 $.ajax({
                         url: root_href + HOME_SERVLET ,
                         data:
                         {
                           action: ACT_DB_MAX_DATA,
                           tableName:'tbl_sanpham',
                           fieldName:'id_sanpham' ,
                           condition: null
                         },
                         async:false,
                         success:function(result) {
                           max = parseInt(result)+1 ;
                         }
                       });
	            	 utils.putfval_int('id_sanpham', max);
	            }
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_sanpham'):utils.genUpdateCmd_PreStatement('tbl_sanpham','id_sanpham=?'));
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
	               	  $('#form_sanpham_them').each(function () {
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
	      alert("func_dlg_sanpham_show have dlg_sanpham_show " + err);
	    }
   }
} 
</script>

<form id="form_sanpham_them">
  <table>
  <tr>
      <td><b>Loai sản phẩm: </b></td>
      <td><select name="dlg_sanpham_them_TheLoai_SanPham" id="dlg_sanpham_them_TheLoai_SanPham"></select></td>
    </tr>
  <tr>
      <td><b>Thuyết minh đề tài: </b></td>
      <td><select name="dlg_sanpham_them_TheLoai_TMDetai" id="dlg_sanpham_them_TheLoai_TMDetai"></select></td>
    </tr>
   <tr>
   <tr>
      <td><b>Tên sản phẩm: </b></td>
      <td><input name="dlg_sanpham_them_TenSP" id="dlg_sanpham_them_TenSP"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Chỉ tiêu chất lượng: </b></td>
      <td><input name="dlg_sanpham_them_CTCL" id="dlg_sanpham_them_CTCL"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Đơn vị đo: </b></td>
      <td><input name="dlg_sanpham_them_DonViDo" id="dlg_sanpham_them_DonViDo"
                 type="text" size="25"></td>
    </tr>
  </table>
</form>