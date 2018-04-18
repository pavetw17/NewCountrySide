<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
var link_vanban=''; 
var link_QuyTrinh=''; 
  $(function() {
	    $("#dlg_giaiphap_khcn_them_TheLoai_Detai" ).combobox();
	    $("#dlg_giaiphap_khcn_them_TheLoai_TMDetai" ).combobox();
	    $("#dlg_giaiphap_khcn_them_ToChuc" ).combobox();
	    
	    $("#dlg_giaiphap_khcn_them_TheLoai_Detai").change(function() {
	    	$('#dlg_giaiphap_khcn_them_TheLoai_TMDetai').next().val('');
			cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TOCHUC_TO_CBB, 'b.id_detai='+ this.value, TYPE_DATA_HTML_CBB,'null', 'dlg_giaiphap_khcn_them_TheLoai_TMDetai');
	    });
	    
	    var btn = document.getElementById('uploadBtn_GiaiPhap');
	    var uploader = new ss.SimpleUpload({
	        button: btn,
	        url: root_href + UPLOAD_SERVLET + 'action=' + CODE_UPLOAD,
	        name: 'uploadfile',
	        allowedExtensions: ['jpg', 'jpeg', 'png','doc','docx','xls','xlsx'],
	        data: {
	        	folder: FILE_GIAIPHAPKHCN
	        }, 
	        hoverClass: 'hover',
	        focusClass: 'focus',
	        maxSize: 1024, 
	        responseType: 'json',
	        
	        startXHR: function() {
	            progressOuter_GiaiPhap.style.display = 'block'; 
	            this.setProgressBar( progressBar_GiaiPhap );
	            $('#msgBox_GiaiPhap').show();
	        },
	        onSubmit: function() {
	            msgBox_GiaiPhap.innerHTML = ''; 
	            btn.innerHTML = 'Uploading...'; 
	        },
	        onChange: function( filename, extension, uploadBtn ){
	        	$('#msgBox_GiaiPhap').show();
	        },
	        onComplete: function( filename, response ) {  
	            btn.innerHTML = 'Choose Another File';
	            progressOuter_GiaiPhap.style.display = 'none'; 
	            
	            link_vanban = response.link_image;
	            
	            if ( !response ) {
	            	msgBox_GiaiPhap.innerHTML = 'Unable to upload file';
	                return;
	            }
	            
	            if ( response.success === true ) {
	            	msgBox_GiaiPhap.innerHTML = '<strong>' + escapeTags( filename ) + '</strong>' + ' successfully uploaded.'
	            	+ "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_GiaiPhap'+"\",\""+'msgBox_GiaiPhap'+"\"); return false;'><strong> Xóa ảnh</strong></a>";
	            	$('#uploadBtn_GiaiPhap').hide();
	            } else {
	                if ( response.msg )  {
	                    msgBox_GiaiPhap.innerHTML = escapeTags( response.msg );
	                } else {
	                    msgBox_GiaiPhap.innerHTML = 'An error occurred and the upload failed.';
	                }
	            }
	          },
	          onExtError: function( filename, extension ) {
	        	msgBox_GiaiPhap.innerHTML = 'Lỗi: Không đúng định dạng file';  
	          },
	          onSizeError: function( filename, fileSize ){
	        	msgBox_GiaiPhap.innerHTML = 'Lỗi: File phải nhỏ hơn 1 MB';
	          },
	          onError: function() {
	            progressOuter_GiaiPhap.style.display = 'none';
	            msgBox_GiaiPhap.innerHTML = 'onError: Unable to upload file';
	          } 
		});
	    
	    
	    var btn_QuyTrinh = document.getElementById('uploadBtn_QuyTrinh');
	    var uploader = new ss.SimpleUpload({
	        button: btn_QuyTrinh,
	        url: root_href + UPLOAD_SERVLET + 'action=' + CODE_UPLOAD,
	        name: 'uploadfile',
	        allowedExtensions: ['jpg', 'jpeg', 'png','doc','docx','xls','xlsx'],
	        data: {
	        	folder: FILE_GIAIPHAPKHCN
	        }, 
	        hoverClass: 'hover',
	        focusClass: 'focus',
	        maxSize: 1024, 
	        responseType: 'json',
	        
	        startXHR: function() {
	            progressOuter_QuyTrinh.style.display = 'block'; 
	            this.setProgressBar( progressBar_QuyTrinh );
	            $('#msgBox_QuyTrinh').show();
	        },
	        onSubmit: function() {
	        	msgBox_QuyTrinh.innerHTML = ''; 
	            btn_QuyTrinh.innerHTML = 'Uploading...'; 
	        },
	        onChange: function( filename, extension, uploadBtn ){
	        	$('#msgBox_QuyTrinh').show();
	        },
	        onComplete: function( filename, response ) {  
	        	btn_QuyTrinh.innerHTML = 'Choose Another File';
	            progressOuter_QuyTrinh.style.display = 'none'; 
	            
	            link_QuyTrinh = response.link_image;
	            
	            if ( !response ) {
	            	msgBox_QuyTrinh.innerHTML = 'Unable to upload file';
	                return;
	            }
	            
	            if ( response.success === true ) {
	            	msgBox_QuyTrinh.innerHTML = '<strong>' + escapeTags( filename ) + '</strong>' + ' successfully uploaded.'
	            	+ "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_QuyTrinh+"\",\""+'uploadBtn_QuyTrinh'+"\",\""+'msgBox_QuyTrinh'+"\"); return false;'><strong> Xóa ảnh</strong></a>";
	            	$('#uploadBtn_QuyTrinh').hide();
	            } else {
	                if ( response.msg )  {
	                	msgBox_QuyTrinh.innerHTML = escapeTags( response.msg );
	                } else {
	                	msgBox_QuyTrinh.innerHTML = 'An error occurred and the upload failed.';
	                }
	            }
	          },
	          onExtError: function( filename, extension ) {
	        	  msgBox_QuyTrinh.innerHTML = 'Lỗi: Không đúng định dạng file';  
	          },
	          onSizeError: function( filename, fileSize ){
	        	  msgBox_QuyTrinh.innerHTML = 'Lỗi: File phải nhỏ hơn 1 MB';
	          },
	          onError: function() {
	            progressOuter_QuyTrinh.style.display = 'none';
	            msgBox_QuyTrinh.innerHTML = 'onError: Unable to upload file';
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
  
   function func_dlg_add_giaiphap_khcn(isEdit) {
    $('#form_giaiphap_khcn_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DETAI_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_giaiphap_khcn_them_TheLoai_Detai');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TOCHUC_DETAI_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_giaiphap_khcn_them_ToChuc');
   
    var row;
    var datagrid_id = 'dlg_giaiphap_khcn_show_datagrid';
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_GIAIPHAP_KHCN,
    	          condition: ' id_giaiphap_khcn='+ row.id_giaiphap_khcn 
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_giaiphap_khcn_them_TheLoai_TMDetai');
    	          var jsonObject = JSON.parse(jsonData);
    	          //document.getElementById('dlg_giaiphap_khcn_them_TheLoai_TMDetai').value = jsonObject.rows[0].id_thuyetminh_detai; //not use 
    	          $('#dlg_giaiphap_khcn_them_TheLoai_Detai').combobox('autocomplete',jsonObject.rows[0].id_detai); 
    	          $('#dlg_giaiphap_khcn_them_TheLoai_TMDetai').combobox('autocomplete',jsonObject.rows[0].id_thuyetminh_detai); 
    	          $('#dlg_giaiphap_khcn_them_ToChuc').combobox('autocomplete',jsonObject.rows[0].id_tochuc); 
    			  document.getElementById('dlg_giaiphap_khcn_them_TenGP').value =  jsonObject.rows[0].ten_giaiphap_khcn;
    			  document.getElementById('dlg_giaiphap_khcn_them_NoiDung').value =  jsonObject.rows[0].noidung_giaiphap_khcn;
    			  document.getElementById("dlg_giaiphap_khcn_them_TenFileGP").value= jsonObject.rows[0].tenfile_giaiphap;
    			  document.getElementById("dlg_giaiphap_khcn_them_TenFileQT").value= jsonObject.rows[0].tenfile_quytrinh;
    			  document.getElementById("dlg_giaiphap_khcn_them_TuKhoa").value= jsonObject.rows[0].tukhoa;
    			  document.getElementById("dlg_giaiphap_khcn_them_QuyTrinh").value= jsonObject.rows[0].quytrinh_thuc_hien;
    			  link_vanban = jsonObject.rows[0].file_giaiphap;
    			  if(link_vanban != ''){
    				$('#uploadBtn_GiaiPhap').hide();
    			  	document.getElementById("msgBox_GiaiPhap").innerHTML= (link_vanban).split("/").pop() + "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_GiaiPhap'+"\",\""+'msgBox_GiaiPhap'+"\"); return false;'><strong> Xóa ảnh</strong></a>";
    	          }
    			  link_QuyTrinh = jsonObject.rows[0].file_quytrinh;
    			  if(link_QuyTrinh != ''){
    				$('#uploadBtn_QuyTrinh').hide();
    			  	document.getElementById("msgBox_QuyTrinh").innerHTML= (link_QuyTrinh).split("/").pop() + "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_QuyTrinh+"\",\""+'uploadBtn_QuyTrinh'+"\",\""+'msgBox_QuyTrinh'+"\"); return false;'><strong> Xóa ảnh</strong></a>";
    	          }
    			  return;
    	        }}); 
    	  

       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_giaiphap_khcn_them').style.display = 'none';
    	  $('#form_giaiphap_khcn_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn giải pháp','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_giaiphap_khcn_them').dialog({
	        title: "Cập nhật  ",
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
	            var id_detai = $('#dlg_giaiphap_khcn_them_TheLoai_Detai').val();
	            var id_thuyetminh_detai  = $('#dlg_giaiphap_khcn_them_TheLoai_TMDetai').val();
	            var id_tochuc = $('#dlg_giaiphap_khcn_them_ToChuc').val();
	            var ten_giaiphap_khcn = $('#dlg_giaiphap_khcn_them_TenGP').val();
	            var noidung_giaiphap_khcn = $('#dlg_giaiphap_khcn_them_NoiDung').val();
	            var quytrinh_thuc_hien = $('#dlg_giaiphap_khcn_them_QuyTrinh').val();
	            var tenfile_quytrinh = $('#dlg_giaiphap_khcn_them_TenFileQT').val();
	            var tenfile_giaiphap = $('#dlg_giaiphap_khcn_them_TenFileGP').val();
	            var tukhoa = $('#dlg_giaiphap_khcn_them_TuKhoa').val();
	            
			    if (kiemtrarong(ten_giaiphap_khcn) || kiemtrarong(noidung_giaiphap_khcn)   || kiemtrarong(tukhoa) || kiemtrarong(quytrinh_thuc_hien) ||id_thuyetminh_detai == null
			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }   
	            
			    if( $('#msgBox_GiaiPhap').is(':hidden')){
			    	link_vanban =  '';
			    } 
			    
			    if( $('#msgBox_QuyTrinh').is(':hidden')){
			    	link_QuyTrinh =  '';
			    } 
			    
			    var max;var check;
			    
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_string('ten_giaiphap_khcn',  ten_giaiphap_khcn);
	            utils.putfval_string('quytrinh_thuc_hien',  quytrinh_thuc_hien);
	            utils.putfval_string('tenfile_giaiphap',  tenfile_giaiphap);
	            utils.putfval_string('tenfile_quytrinh',  tenfile_quytrinh);
	            utils.putfval_string('tukhoa',  tukhoa);
	            utils.putfval_string('noidung_giaiphap_khcn',  noidung_giaiphap_khcn);
	            utils.putfval_int('id_detai',  id_detai);
	            utils.putfval_int('id_thuyetminh_detai',  id_thuyetminh_detai);
	            utils.putfval_int('id_tochuc',  id_tochuc);
	            utils.putfval_string('file_giaiphap', link_vanban);
	            utils.putfval_string('file_quytrinh', link_QuyTrinh);
	            if(!isEdit){ 
                    $.ajax({
                        url: root_href + HOME_SERVLET ,
                        data:
                        {
                            action: ACT_DB_CHECK_DATA_EXISTS,
                            tableName:'tbl_giaiphap_khcn',
                            fieldName:   'id_giaiphap_khcn',
                            condition: ' id_detai='+id_detai +' and id_thuyetminh_detai='+id_thuyetminh_detai+' and id_tochuc ='+id_tochuc 
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
                }else{ 
                   /*  $.ajax({
                        url: root_href + HOME_SERVLET ,
                        data:
                        {
                            action: ACT_DB_CHECK_DATA_EXISTS,
                            tableName:'tbl_giaiphap_khcn',
                            fieldName:'id_tochuc' ,
                            condition: ' id_detai='+id_detai +' and id_thuyetminh_detai='+id_thuyetminh_detai+' and id_tochuc ='+id_tochuc 
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
                    } */
                }
	            
	            
	            if (isEdit){
	              	utils.putfval_int_condition('id_giaiphap_khcn', row.id_giaiphap_khcn);
	            }else{
		           	 $.ajax({
	                     url: root_href + HOME_SERVLET ,
	                     data:
	                     {
	                       action: ACT_DB_MAX_DATA,
	                       tableName:'tbl_giaiphap_khcn',
	                       fieldName:'id_giaiphap_khcn' ,
	                       condition: null
	                     },
	                     async:false,
	                     success:function(result) {
	                       max = parseInt(result)+1 ;
	                     }
	                   });
	            	 utils.putfval_int('id_giaiphap_khcn', max);
	            }
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_giaiphap_khcn'):utils.genUpdateCmd_PreStatement('tbl_giaiphap_khcn','id_giaiphap_khcn=?'));
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
	               	  $('#form_giaiphap_khcn_them').each(function () {
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
	        	  if(   ((link_vanban != '') || (link_QuyTrinh != '')) && ( $("#dlg_giaiphap_khcn_them_TenGP").val().length == 0
	 	        		 || $("#dlg_giaiphap_khcn_them_TenFileGP").val().length == 0	
	 	        		 || $("#dlg_giaiphap_khcn_them_TuKhoa").val().length == 0 
	 	        		   )){
	 	        		 onsubmenu_xoaanh(link_vanban,'uploadBtn_GiaiPhap','msgBox_GiaiPhap');
	 	        		 onsubmenu_xoaanh(link_QuyTrinh,'uploadBtn_QuyTrinh','msgBox_QuyTrinh');
	 	        	  }    
	            $(this).dialog("close");
	          }
	        },
	        close: function () {
	        	if(   ((link_vanban != '') || (link_QuyTrinh != '')) && ( $("#dlg_giaiphap_khcn_them_TenGP").val().length == 0
	 	        		 || $("#dlg_giaiphap_khcn_them_TenFileGP").val().length == 0	
	 	        		 || $("#dlg_giaiphap_khcn_them_TuKhoa").val().length == 0 
	 	        		   )){
	        		 onsubmenu_xoaanh(link_vanban,'uploadBtn_GiaiPhap','msgBox_GiaiPhap');
 	        		 onsubmenu_xoaanh(link_QuyTrinh,'uploadBtn_QuyTrinh','msgBox_QuyTrinh');
	 	        	  }  
	        }
	      });
	    } catch (err) {
	      alert("func_dlg_giaiphap_khcn_show have dlg_giaiphap_khcn_show " + err);
	    }
   }
} 
</script>

<form id="form_giaiphap_khcn_them">
  <table>
  <tr>
      <td><b>Đề tài: </b></td>
      <td><select name="dlg_giaiphap_khcn_them_TheLoai_Detai" id="dlg_giaiphap_khcn_them_TheLoai_Detai"></select></td>
    </tr>
  <tr>
      <td><b>Thuyết minh đề tài: </b></td>
      <td><select name="dlg_giaiphap_khcn_them_TheLoai_TMDetai" id="dlg_giaiphap_khcn_them_TheLoai_TMDetai"></select></td>
    </tr>
   <tr>
   <tr>
      <td><b>Tổ chức: </b></td>
      <td><select name="dlg_giaiphap_khcn_them_ToChuc" id="dlg_giaiphap_khcn_them_ToChuc"></select></td>
    </tr>
    <tr>
      <td><b>Tên giải pháp: </b></td>
      <td><input name="dlg_giaiphap_khcn_them_TenGP" id="dlg_giaiphap_khcn_them_TenGP"
                 type="text" size="25" ></td>
    </tr>
    <tr>
      <td><b>Nội dung: </b></td>
      <td><input name="dlg_giaiphap_khcn_them_NoiDung" id="dlg_giaiphap_khcn_them_NoiDung"
                 type="text" size="25" ></td>
    </tr>
    <tr>
      <td><b>Quy trình: </b></td>
      <td><input name="dlg_giaiphap_khcn_them_QuyTrinh" id="dlg_giaiphap_khcn_them_QuyTrinh"
                 type="text" size="25" ></td>
    </tr>
    <tr>
      <td><b>Từ khóa: </b></td>
      <td><input name="dlg_giaiphap_khcn_them_TuKhoa" id="dlg_giaiphap_khcn_them_TuKhoa"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Tên file giải pháp: </b></td>
      <td><input name="dlg_giaiphap_khcn_them_TenFileGP" id="dlg_giaiphap_khcn_them_TenFileGP"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Tên file quy trình: </b></td>
      <td><input name="dlg_giaiphap_khcn_them_TenFileQT" id="dlg_giaiphap_khcn_them_TenFileQT"
                 type="text" size="25"></td>
    </tr>
      <tr>
      <td><b>File giải pháp: </b></td>
      <td>  
            <div class="col-xs-2">
              <button id="uploadBtn_GiaiPhap" class="btn btn-large btn-primary">Choose File</button>
            </div>
            <div class="col-xs-10">
          <div id="progressOuter_GiaiPhap" class="progress progress-striped active" style="display:none;">
            <div id="progressBar_GiaiPhap" class="progress-bar progress-bar-success"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
            </div>
          </div>
            </div>
            <div class="col-xs-10">
              <div id="msgBox_GiaiPhap">
              </div>
            </div>
      </td>
    </tr> 
    <tr>
      <td><b>File quy trình: </b></td>
      <td>  
            <div class="col-xs-2">
              <button id="uploadBtn_QuyTrinh" class="btn btn-large btn-primary">Choose File</button>
            </div>
            <div class="col-xs-10">
          <div id="progressOuter_QuyTrinh" class="progress progress-striped active" style="display:none;">
            <div id="progressBar_QuyTrinh" class="progress-bar progress-bar-success"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
            </div>
          </div>
            </div>
            <div class="col-xs-10">
              <div id="msgBox_QuyTrinh">
              </div>
            </div>
      </td>
    </tr> 
  </table>
</form>