<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
  var link_vanban=''; 
  
  $(function() {
	  
	   $('form').submit(function(e){
		    e.preventDefault();
		});
	  
	    $("#dlg_phieu_them_ViTri" ).combobox();
	    $("#dlg_phieu_them_LoaiPhieu" ).combobox();
	    $("#dlg_phieu_them_KienNghi" ).combobox();
	    $("#dlg_phieu_them_ThuyetMinh" ).combobox();
	    $("#dlg_phieu_them_ChuyenGia" ).combobox();

		var btn = document.getElementById('uploadBtn_Phieu');
	
	    var uploader = new ss.SimpleUpload({
	        button: btn,
	        url: root_href + UPLOAD_SERVLET + 'action=' + CODE_UPLOAD,
	        name: 'uploadfile',
	        allowedExtensions: ['jpg', 'jpeg', 'png','doc','docx','xls','xlsx'],
	        data: {
	        	folder: FILE_PHIEU
	        }, 
	        hoverClass: 'hover',
	        focusClass: 'focus',
	        maxSize: 1024, 
	        responseType: 'json',
	        
	        startXHR: function() {
	            progressOuter_Phieu.style.display = 'block'; 
	            this.setProgressBar( progressOuter_Phieu );
	            $('#msgBox_Phieu').show();
	        },
	        onSubmit: function() {
	            msgBox_Phieu.innerHTML = ''; 
	            btn.innerHTML = 'Uploading...'; 
	        },
	        onChange: function( filename, extension, uploadBtn_Phieu ){
	        	$('#msgBox_Phieu').show();
	        },
	        onComplete: function( filename, response ) {  
	            btn.innerHTML = 'Choose Another File';
	            progressOuter_Phieu.style.display = 'none'; 
	            
	            link_vanban = response.link_image;
	            
	            if ( !response ) {
	            	msgBox_Phieu.innerHTML = 'Unable to upload file';
	                return;
	            }
	            
	            if ( response.success === true ) {
	            	msgBox_Phieu.innerHTML = '<strong>' + escapeTags( filename ) + '</strong>' + ' successfully uploaded.'
	            	+ "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_Phieu'+"\",\""+'msgBox_Phieu'+"\"); return false;'><strong> Xóa ảnh</strong></a>";
	            	$('#uploadBtn_Phieu').hide();
	            } else {
	                if ( response.msg )  {
	                    msgBox_Phieu.innerHTML = escapeTags( response.msg );
	                } else {
	                    msgBox_Phieu.innerHTML = 'An error occurred and the upload failed.';
	                }
	            }
	          },
	          onExtError: function( filename, extension ) {
	        	msgBox_Phieu.innerHTML = 'Lỗi: Không đúng định dạng file';  
	          },
	          onSizeError: function( filename, fileSize ){
	        	msgBox_Phieu.innerHTML = 'Lỗi: File phải nhỏ hơn 1 MB';
	          },
	          onError: function() {
	            progressOuter_Phieu.style.display = 'none';
	            msgBox_Phieu.innerHTML = 'onError: Unable to upload file';
	          } 
		});
   	
	    function escapeTags( str ) {
	  	  return String( str )
	  	           .replace( /&/g, '&amp;' )
	  	           .replace( /"/g, '&quot;' )
	  	           .replace( /'/g, '&#39;' )
	  	           .replace( /</g, '&lt;' )
	  	           .replace( />/g, '&gt;' );
	  	}
  });
  

  
   function func_dlg_add_phieu(isEdit) {
    $('#form_phieu_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_CHUYENGIA_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_phieu_them_ChuyenGia');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_KIENNGHI_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_phieu_them_KienNghi');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_phieu_them_ThuyetMinh');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_PHANLOAI_THANHVIEN_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_phieu_them_ViTri');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_PHANLOAI_PHIEU_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_phieu_them_LoaiPhieu');
    
    
    var row;
    var datagrid_id = 'dlg_phieu_show_datagrid';
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_PHIEU,
    	          condition: 'id_phieu =' + row.id_phieu
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          var jsonObject = JSON.parse(jsonData);
    	          //document.getElementById('dlg_phieu_them_ChuyenGia').value = jsonObject.rows[0].id_chuyengia; //not use 
    	          $('#dlg_phieu_them_ChuyenGia').combobox('autocomplete',jsonObject.rows[0].id_chuyengia); 
    	          $('#dlg_phieu_them_ViTri').combobox('autocomplete',jsonObject.rows[0].vitri); 
    	          $('#dlg_phieu_them_LoaiPhieu').combobox('autocomplete',jsonObject.rows[0].id_phanloaiphieu); 
    	          $('#dlg_phieu_them_KienNghi').combobox('autocomplete',jsonObject.rows[0].id_tochuc_trungtuyen); 
    	          $('#dlg_phieu_them_ThuyetMinh').combobox('autocomplete',jsonObject.rows[0].id_thuyetminh_detai); 
    	          document.getElementById('dlg_phieu_them_DiemDG').value = jsonObject.rows[0].diemdanhgia_tonghop;
				  document.getElementById("dlg_phieu_them_GiaiThich").value= jsonObject.rows[0].giaithich_kiennghi;
    			  document.getElementById('dlg_phieu_them_TenPhieu').value = jsonObject.rows[0].tenphieu;
    			  link_vanban = jsonObject.rows[0].noidung_phieu;
    			  if(link_vanban != ''){
    				$('#uploadBtn_Phieu').hide();
    			  	document.getElementById("msgBox_Phieu").innerHTML= (link_vanban).split("/").pop() + "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_Phieu'+"\",\""+'msgBox_Phieu'+"\"); return false;'><strong> Xóa ảnh</strong></a>";;
    	          }
    			  return;
    	        }}); 
       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_phieu_them').style.display = 'none';
    	  $('#form_phieu_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn biên bản','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_phieu_them').dialog({
	        title: "Cập nhật phiếu ",
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
	            var id_chuyengia = $('#dlg_phieu_them_ChuyenGia').val();
	            var diemdanhgia_tonghop = $('#dlg_phieu_them_DiemDG').val();
	            var giaithich_kiennghi = $('#dlg_phieu_them_GiaiThich').val();
	            var id_kiennghi = $('#dlg_phieu_them_KienNghi').val();
	            var vitri = $('#dlg_phieu_them_ViTri').val();
	            var id_phanloaiphieu = $('#dlg_phieu_them_LoaiPhieu').val();
	            var id_tochuc_trungtuyen = $('#dlg_phieu_them_KienNghi').val();
	            var id_thuyetminh_detai = $('#dlg_phieu_them_ThuyetMinh').val();
	            var tenphieu = $('#dlg_phieu_them_TenPhieu').val();
	            
			    if ( kiemtrarong(diemdanhgia_tonghop)    
			    	 || kiemtrarong(giaithich_kiennghi)
			    	 || kiemtrarong(tenphieu) 
			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }   
	            
			    if( $('#msgBox_Phieu').is(':hidden')){
			    	link_vanban =  '';
			    } 
	            
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_int('id_chuyengia', id_chuyengia);
	            utils.putfval_int('vitri', vitri);
	            utils.putfval_int('id_phanloaiphieu', id_phanloaiphieu);
	            utils.putfval_int('id_thuyetminh_detai', id_thuyetminh_detai);
	            utils.putfval_int('diemdanhgia_tonghop', trim(diemdanhgia_tonghop));
	            utils.putfval_string('tenphieu', trim(tenphieu));
	            utils.putfval_string('giaithich_kiennghi', trim(giaithich_kiennghi));
	            utils.putfval_int('id_kiennghi', trim(id_kiennghi));
	            utils.putfval_string('noidung_phieu', link_vanban); 
	            if (isEdit){
	              utils.putfval_int_condition('id_phieu', row.id_phieu);
	            }else{ 
	            	 $.ajax({
                         url: root_href + HOME_SERVLET ,
                         data:
                         {
                           action: ACT_DB_MAX_DATA,
                           tableName:'tbl_phieu',
                           fieldName:'id_phieu' ,
                           condition: null
                         },
                         async:false,
                         success:function(result) {
                           max = parseInt(result)+1 ;
                         }
                       });
	            	 utils.putfval_int('id_phieu', max);
                }
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_phieu'):utils.genUpdateCmd_PreStatement('tbl_phieu','id_phieu=?'));
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
	               	  $('#form_phieu_them').each(function () {
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
	        	  $('#uploadBtn_Phieu').show();
		      	  $('#msgBox_Phieu').hide();

	            }else {
	              msgalert_autoclose('Thông báo','Thao tác không thành công','error');//alert('insert/update multi object FAILED!');
	            }
	
	          },
	          "Đóng": function () {
	        	 if(   (link_vanban != '') && ( $("#dlg_phieu_them_DiemDG").val().length == 0
	        		 || $("#dlg_phieu_them_GiaiThich").val().length == 0	
	        		 || $("#dlg_phieu_them_TenPhieu").val().length == 0 
	        		   )){
	        		 onsubmenu_xoaanh(link_vanban,'uploadBtn_Phieu','msgBox_Phieu');
	        	  }    
	            $(this).dialog("close");
	          }
	        },
	        close: function () {
	        	if(   (link_vanban != '') && ( $("#dlg_phieu_them_DiemDG").val().length == 0
		        		 || $("#dlg_phieu_them_GiaiThich").val().length == 0	
		        		 || $("#dlg_phieu_them_TenPhieu").val().length == 0 
		        		   )){
	        		 	onsubmenu_xoaanh(link_vanban,'uploadBtn_Phieu','msgBox_Phieu');
		         } 
	        }
	      });
	    } catch (err) {
	      alert("func_dlg_phieu_show have dlg_phieu_show " + err);
	    }
   }
} 
</script>

<form id="form_phieu_them">
  <table>
   <tr>
     <td><b>Loại phiếu: </b></td>
      <td><select name="dlg_phieu_them_LoaiPhieu" id="dlg_phieu_them_LoaiPhieu"></select></textarea></td>
    </tr>
    <tr>
     <td><b>Kiến nghị: </b></td>
      <td><select name="dlg_phieu_them_KienNghi" id="dlg_phieu_them_KienNghi"></select></textarea></td>
    </tr>
    <tr>
     <td><b>Thuyết minh đề tài: </b></td>
      <td><select name="dlg_phieu_them_ThuyetMinh" id="dlg_phieu_them_ThuyetMinh"></select></textarea></td>
    </tr>
  <tr>
      <td><b>Chuyên gia: </b></td>
      <td><select name="dlg_phieu_them_ChuyenGia" id="dlg_phieu_them_ChuyenGia"></select></td>
    </tr>
   <tr>
     <td><b>Vị trí: </b></td>
      <td><select name="dlg_phieu_them_ViTri" id="dlg_phieu_them_ViTri"></select></textarea></td>
    </tr>
    <tr>
      <td><b>Điểm đánh giá </b></td>
      <td><input name="dlg_phieu_them_DiemDG" id="dlg_phieu_them_DiemDG"
                 type="text" size="25"></td>
    </tr>
     <tr>
     <td><b>Giải thích kiến nghị: </b></td>
      <td><textarea name="dlg_phieu_them_GiaiThich" id="dlg_phieu_them_GiaiThich"
                 row="20" cols="100" style="width:400px"></textarea></td>
    </tr>
       <tr>
     <td><b>Tên phiếu: </b></td>
      <td><input name="dlg_phieu_them_TenPhieu" id="dlg_phieu_them_TenPhieu"
                 type="text" size="25"></td>
    </tr>
      <tr>
      <td><b>File phiếu: </b></td>
      <td>  
            <div class="col-xs-2">
              <button id="uploadBtn_Phieu" class="btn btn-large btn-primary">Choose File</button>
            </div>
            <div class="col-xs-10">
          <div id="progressOuter_Phieu" class="progress progress-striped active" style="display:none;">
            <div id="progressOuter_Phieu" class="progress-bar progress-bar-success"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
            </div>
          </div>
            </div>
            <div class="col-xs-10">
              <div id="msgBox_Phieu">
              </div>
            </div>
      </td>
    </tr>
  </table>
</form>