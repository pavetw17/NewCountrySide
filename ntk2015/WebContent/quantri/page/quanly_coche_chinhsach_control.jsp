<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
var link_vanban=''; 
  $(function() {
	    $("#dlg_coche_chinhsach_them_TheLoai_Detai" ).combobox();
	    $("#dlg_coche_chinhsach_them_TheLoai_TMDetai" ).combobox();
	    $("#dlg_coche_chinhsach_them_ToChuc" ).combobox();
	    
	    $("#dlg_coche_chinhsach_them_TheLoai_Detai").change(function() {
	    	$('#dlg_coche_chinhsach_them_TheLoai_TMDetai').next().val('');
			cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TOCHUC_TO_CBB, 'b.id_detai='+ this.value, TYPE_DATA_HTML_CBB,'null', 'dlg_coche_chinhsach_them_TheLoai_TMDetai');
	    });
	    
var btn = document.getElementById('uploadBtn_CoChe');
		
	    var uploader = new ss.SimpleUpload({
	        button: btn,
	        url: root_href + UPLOAD_SERVLET + 'action=' + CODE_UPLOAD,
	        name: 'uploadfile',
	        allowedExtensions: ['jpg', 'jpeg', 'png','doc','docx','xls','xlsx'],
	        data: {
	        	folder: FILE_COCHECHINHSACH
	        }, 
	        hoverClass: 'hover',
	        focusClass: 'focus',
	        maxSize: 1024, 
	        responseType: 'json',
	        
	        startXHR: function() {
	            progressOuter_CoChe.style.display = 'block'; 
	            this.setProgressBar( progressBar_CoChe );
	            $('#msgBox_CoChe').show();
	        },
	        onSubmit: function() {
	            msgBox_CoChe.innerHTML = ''; 
	            btn.innerHTML = 'Uploading...'; 
	        },
	        onChange: function( filename, extension, uploadBtn_CoChe ){
	        	$('#msgBox_CoChe').show();
	        },
	        onComplete: function( filename, response ) {  
	            btn.innerHTML = 'Choose Another File';
	            progressOuter_CoChe.style.display = 'none'; 
	            
	            link_vanban = response.link_image;
	            
	            if ( !response ) {
	            	msgBox_CoChe.innerHTML = 'Unable to upload file';
	                return;
	            }
	            
	            if ( response.success === true ) {
	            	msgBox_CoChe.innerHTML = '<strong>' + escapeTags( filename ) + '</strong>' + ' successfully uploaded.'
	            	+ "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_CoChe'+"\",\""+'msgBox_CoChe'+"\"); return false;'><strong> Xóa ảnh</strong></a>";
	            	$('#uploadBtn_CoChe').hide();
	            } else {
	                if ( response.msg )  {
	                    msgBox_CoChe.innerHTML = escapeTags( response.msg );
	                } else {
	                    msgBox_CoChe.innerHTML = 'An error occurred and the upload failed.';
	                }
	            }
	          },
	          onExtError: function( filename, extension ) {
	        	msgBox_CoChe.innerHTML = 'Lỗi: Không đúng định dạng file';  
	          },
	          onSizeError: function( filename, fileSize ){
	        	msgBox_CoChe.innerHTML = 'Lỗi: File phải nhỏ hơn 1 MB';
	          },
	          onError: function() {
	            progressOuter_CoChe.style.display = 'none';
	            msgBox_CoChe.innerHTML = 'onError: Unable to upload file';
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
  
   function func_dlg_add_coche_chinhsach(isEdit) {
    $('#form_coche_chinhsach_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DETAI_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_coche_chinhsach_them_TheLoai_Detai');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TOCHUC_DETAI_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_coche_chinhsach_them_ToChuc');
   
    var row;
    var datagrid_id = 'dlg_coche_chinhsach_show_datagrid';
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_COCHE_CHINHSACH,
    	          condition: ' id_coche_chinhsach='+ row.id_coche_chinhsach 
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_coche_chinhsach_them_TheLoai_TMDetai');
    	          var jsonObject = JSON.parse(jsonData);
    	          //document.getElementById('dlg_coche_chinhsach_them_TheLoai_TMDetai').value = jsonObject.rows[0].id_thuyetminh_detai; //not use 
    	          $('#dlg_coche_chinhsach_them_TheLoai_Detai').combobox('autocomplete',jsonObject.rows[0].id_detai); 
    	          $('#dlg_coche_chinhsach_them_TheLoai_TMDetai').combobox('autocomplete',jsonObject.rows[0].id_thuyetminh_detai); 
    	          $('#dlg_coche_chinhsach_them_ToChuc').combobox('autocomplete',jsonObject.rows[0].id_tochuc); 
    			  document.getElementById("dlg_coche_chinhsach_them_Ten").value= jsonObject.rows[0].ten_coche_chinhsach;
    			  document.getElementById("dlg_coche_chinhsach_them_NoiDung").value= jsonObject.rows[0].noidung_coche_chinhsach;
    			  document.getElementById("dlg_coche_chinhsach_them_MaSo").value= jsonObject.rows[0].maso_coche_chinhsach;
    			  document.getElementById("dlg_coche_chinhsach_them_TenFile").value= jsonObject.rows[0].tenfile;
    			  document.getElementById("dlg_coche_chinhsach_them_TuKhoa").value= jsonObject.rows[0].tukhoa;
    			  link_vanban = jsonObject.rows[0].filenoidung;
    			  if(link_vanban != ''){
    				$('#uploadBtn_CoChe').hide();
    			  	document.getElementById("msgBox_CoChe").innerHTML= (link_vanban).split("/").pop() + "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_CoChe'+"\",\""+'msgBox_CoChe'+"\"); return false;'><strong> Xóa ảnh</strong></a>";
    	          }
    			  return;
    	        }}); 
       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_coche_chinhsach_them').style.display = 'none';
    	  $('#form_coche_chinhsach_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn cơ chế','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_coche_chinhsach_them').dialog({
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
	            var id_detai = $('#dlg_coche_chinhsach_them_TheLoai_Detai').val();
	            var id_thuyetminh_detai  = $('#dlg_coche_chinhsach_them_TheLoai_TMDetai').val();
	            var id_tochuc = $('#dlg_coche_chinhsach_them_ToChuc').val();
	            var ten_coche_chinhsach = $('#dlg_coche_chinhsach_them_Ten').val();
	            var noidung_coche_chinhsach = $('#dlg_coche_chinhsach_them_NoiDung').val();
	            var maso_coche_chinhsach = $('#dlg_coche_chinhsach_them_MaSo').val();
	            var tukhoa = $('#dlg_coche_chinhsach_them_TuKhoa').val();
	            var tenfile =  $('#dlg_coche_chinhsach_them_TenFile').val();
			    if ( kiemtrarong(ten_coche_chinhsach)   || kiemtrarong(noidung_coche_chinhsach)   ||id_thuyetminh_detai == null
			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }   
	            
			    if( $('#msgBox_CoChe').is(':hidden')){
			    	link_vanban =  '';
			    } 
			    
			    var max;var check;
			    
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_string('ten_coche_chinhsach',  ten_coche_chinhsach);
	            utils.putfval_string('noidung_coche_chinhsach',  noidung_coche_chinhsach);
	            utils.putfval_string('maso_coche_chinhsach',  maso_coche_chinhsach);
	            utils.putfval_string('tukhoa',  tukhoa);
	            utils.putfval_string('tenfile',  tenfile);
	            utils.putfval_int('id_detai',  id_detai);
	            utils.putfval_int('id_thuyetminh_detai',  id_thuyetminh_detai);
	            utils.putfval_int('id_tochuc',  id_tochuc);
	            utils.putfval_string('filenoidung', link_vanban);
	            if(!isEdit){ 
                    $.ajax({
                        url: root_href + HOME_SERVLET ,
                        data:
                        {
                            action: ACT_DB_CHECK_DATA_EXISTS,
                            tableName:'tbl_coche_chinhsach',
                            fieldName:   'id_coche_chinhsach',
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
                            tableName:'tbl_coche_chinhsach',
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
	              	utils.putfval_int_condition('id_coche_chinhsach', row.id_coche_chinhsach);
	            }else{
		           	 $.ajax({
	                     url: root_href + HOME_SERVLET ,
	                     data:
	                     {
	                       action: ACT_DB_MAX_DATA,
	                       tableName:'tbl_coche_chinhsach',
	                       fieldName:'id_coche_chinhsach' ,
	                       condition: null
	                     },
	                     async:false,
	                     success:function(result) {
	                       max = parseInt(result)+1 ;
	                     }
	                   });
	            	 utils.putfval_int('id_coche_chinhsach', max);
	            }
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_coche_chinhsach'):utils.genUpdateCmd_PreStatement('tbl_coche_chinhsach','id_coche_chinhsach=?'));
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
	               	  $('#form_coche_chinhsach_them').each(function () {
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
	        	  if(   ((link_vanban != '') ) && ( $("#dlg_coche_chinhsach_them_Ten").val().length == 0
		 	        		 || $("#dlg_coche_chinhsach_them_MaSo").val().length == 0	
		 	        		 || $("#dlg_coche_chinhsach_them_TuKhoa").val().length == 0 
		 	        		   )){
		 	        		 onsubmenu_xoaanh(link_vanban,'uploadBtn_CoChe','msgBox_CoChe');
		 	        	  } 
	            $(this).dialog("close");
	          }
	        },
	        close: function () {
	        	if(   ((link_vanban != '') ) && ( $("#dlg_coche_chinhsach_them_Ten").val().length == 0
	 	        		 || $("#dlg_coche_chinhsach_them_MaSo").val().length == 0	
	 	        		 || $("#dlg_coche_chinhsach_them_TuKhoa").val().length == 0 
	 	        		   )){
	 	        		 onsubmenu_xoaanh(link_vanban,'uploadBtn_CoChe','msgBox_CoChe');
	 	        	  } 
	        }
	      });
	    } catch (err) {
	      alert("func_dlg_coche_chinhsach_show have dlg_coche_chinhsach_show " + err);
	    }
   }
} 
</script>

<form id="form_coche_chinhsach_them">
  <table>
  <tr>
      <td><b>Đề tài: </b></td>
      <td><select name="dlg_coche_chinhsach_them_TheLoai_Detai" id="dlg_coche_chinhsach_them_TheLoai_Detai"></select></td>
    </tr>
  <tr>
      <td><b>Thuyết minh đề tài: </b></td>
      <td><select name="dlg_coche_chinhsach_them_TheLoai_TMDetai" id="dlg_coche_chinhsach_them_TheLoai_TMDetai"></select></td>
    </tr>
   <tr>
   <tr>
      <td><b>Tổ chức: </b></td>
      <td><select name="dlg_coche_chinhsach_them_ToChuc" id="dlg_coche_chinhsach_them_ToChuc"></select></td>
    </tr>
    <tr>
      <td><b>Tên: </b></td>
      <td><input name="dlg_coche_chinhsach_them_Ten" id="dlg_coche_chinhsach_them_Ten"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Nội dung: </b></td>
      <td><input name="dlg_coche_chinhsach_them_NoiDung" id="dlg_coche_chinhsach_them_NoiDung"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Mã số: </b></td>
      <td><input name="dlg_coche_chinhsach_them_MaSo" id="dlg_coche_chinhsach_them_MaSo"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Tên file: </b></td>
      <td><input name="dlg_coche_chinhsach_them_TenFile" id="dlg_coche_chinhsach_them_TenFile"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Từ khóa: </b></td>
      <td><input name="dlg_coche_chinhsach_them_TuKhoa" id="dlg_coche_chinhsach_them_TuKhoa"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>File: </b></td>
      <td>  
            <div class="col-xs-2">
              <button id="uploadBtn_CoChe" class="btn btn-large btn-primary">Choose File</button>
            </div>
            <div class="col-xs-10">
          <div id="progressOuter_CoChe" class="progress progress-striped active" style="display:none;">
            <div id="progressBar_CoChe" class="progress-bar progress-bar-success"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
            </div>
          </div>
            </div>
            <div class="col-xs-10">
              <div id="msgBox_CoChe">
              </div>
            </div>
      </td>
    </tr>
  </table>
</form>