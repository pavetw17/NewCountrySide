<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
var link_vanban=''; 
  $(function() {
	    $("#dlg_phanvon_hangmuc_them_TheLoai_Detai" ).combobox();
	    $("#dlg_phanvon_hangmuc_them_TheLoai_TMDetai" ).combobox();
	    $("#dlg_phanvon_hangmuc_them_ToChuc" ).combobox();
	    
	    $("#dlg_phanvon_hangmuc_them_TheLoai_Detai").change(function() {
	    	$('#dlg_phanvon_hangmuc_them_TheLoai_TMDetai').next().val('');
			cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TOCHUC_TO_CBB, 'b.id_detai='+ this.value, TYPE_DATA_HTML_CBB,'null', 'dlg_phanvon_hangmuc_them_TheLoai_TMDetai');
	    });
	    
	    var btn = document.getElementById('uploadBtn_PhanVon');
		
	    var uploader = new ss.SimpleUpload({
	        button: btn,
	        url: root_href + UPLOAD_SERVLET + 'action=' + CODE_UPLOAD,
	        name: 'uploadfile',
	        allowedExtensions: ['jpg', 'jpeg', 'png','doc','docx','xls','xlsx'],
	        data: {
	        	folder: FILE_PHANBOVON
	        }, 
	        hoverClass: 'hover',
	        focusClass: 'focus',
	        maxSize: 1024, 
	        responseType: 'json',
	        
	        startXHR: function() {
	            progressOuter_PhanVon.style.display = 'block'; 
	            this.setProgressBar( progressBar_PhanVon );
	            $('#msgBox_PhanVon').show();
	        },
	        onSubmit: function() {
	            msgBox_PhanVon.innerHTML = ''; 
	            btn.innerHTML = 'Uploading...'; 
	        },
	        onChange: function( filename, extension, uploadBtn_PhanVon ){
	        	$('#msgBox_PhanVon').show();
	        },
	        onComplete: function( filename, response ) {  
	            btn.innerHTML = 'Choose Another File';
	            progressOuter_PhanVon.style.display = 'none'; 
	            
	            link_vanban = response.link_image;
	            
	            if ( !response ) {
	            	msgBox_PhanVon.innerHTML = 'Unable to upload file';
	                return;
	            }
	            
	            if ( response.success === true ) {
	            	msgBox_PhanVon.innerHTML = '<strong>' + escapeTags( filename ) + '</strong>' + ' successfully uploaded.'
	            	+ "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_PhanVon'+"\",\""+'msgBox_PhanVon'+"\"); return false;'><strong> Xóa ảnh</strong></a>";
	            	$('#uploadBtn_PhanVon').hide();
	            } else {
	                if ( response.msg )  {
	                    msgBox_PhanVon.innerHTML = escapeTags( response.msg );
	                } else {
	                    msgBox_PhanVon.innerHTML = 'An error occurred and the upload failed.';
	                }
	            }
	          },
	          onExtError: function( filename, extension ) {
	        	msgBox_PhanVon.innerHTML = 'Lỗi: Không đúng định dạng file';  
	          },
	          onSizeError: function( filename, fileSize ){
	        	msgBox_PhanVon.innerHTML = 'Lỗi: File phải nhỏ hơn 1 MB';
	          },
	          onError: function() {
	            progressOuter_PhanVon.style.display = 'none';
	            msgBox_PhanVon.innerHTML = 'onError: Unable to upload file';
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
  
   function func_dlg_add_phanvon_hangmuc(isEdit) {
    $('#form_phanvon_hangmuc_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DETAI_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_phanvon_hangmuc_them_TheLoai_Detai');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TOCHUC_DETAI_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_phanvon_hangmuc_them_ToChuc');
   
    var row;
    var datagrid_id = 'dlg_phanvon_hangmuc_show_datagrid';
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_PHANBOVON_THEOHANGMUC,
    	          condition: ' id_tieuchi='+ row.id_tieuchi 
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_phanvon_hangmuc_them_TheLoai_TMDetai');
    	          var jsonObject = JSON.parse(jsonData);
    	          //document.getElementById('dlg_phanvon_hangmuc_them_TheLoai_TMDetai').value = jsonObject.rows[0].id_thuyetminh_detai; //not use 
    	          $('#dlg_phanvon_hangmuc_them_TheLoai_Detai').combobox('autocomplete',jsonObject.rows[0].id_detai); 
    	          $('#dlg_phanvon_hangmuc_them_TheLoai_TMDetai').combobox('autocomplete',jsonObject.rows[0].id_thuyetminhdetai); 
    	          $('#dlg_phanvon_hangmuc_them_ToChuc').combobox('autocomplete',jsonObject.rows[0].id_tochuc); 
    			  document.getElementById('dlg_phanvon_hangmuc_them_NoiDung').value =  jsonObject.rows[0].noidung_tieuchi;
    			  document.getElementById("dlg_phanvon_hangmuc_them_TenFile").value= jsonObject.rows[0].tenfile;
    			  document.getElementById("dlg_phanvon_hangmuc_them_TuKhoa").value= jsonObject.rows[0].tukhoa;
    			  link_vanban = jsonObject.rows[0].filenoidung;
    			  if(link_vanban != ''){
    				$('#uploadBtn_PhanVon').hide();
    			  	document.getElementById("msgBox_PhanVon").innerHTML= (link_vanban).split("/").pop() + "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_PhanVon'+"\",\""+'msgBox_PhanVon'+"\"); return false;'><strong> Xóa ảnh</strong></a>";
    	          }
    			  return;
    	        }}); 
    	  

       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_phanvon_hangmuc_them').style.display = 'none';
    	  $('#form_phanvon_hangmuc_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn tổ chức','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_phanvon_hangmuc_them').dialog({
	        title: "Cập nhật vốn theo hạng mục ",
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
	            var id_detai = $('#dlg_phanvon_hangmuc_them_TheLoai_Detai').val();
	            var id_thuyetminhdetai  = $('#dlg_phanvon_hangmuc_them_TheLoai_TMDetai').val();
	            var id_tochuc = $('#dlg_phanvon_hangmuc_them_ToChuc').val();
	            var noidung_tieuchi = $('#dlg_phanvon_hangmuc_them_NoiDung').val();
	            var tenfile = $('#dlg_phanvon_hangmuc_them_TenFile').val();
	            var tukhoa = $('#dlg_phanvon_hangmuc_them_TuKhoa').val();
	            
			    if (kiemtrarong(noidung_tieuchi) || kiemtrarong(tenfile)   || kiemtrarong(tukhoa)   ||id_thuyetminhdetai == null
			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }   
	            
			    if( $('#msgBox_PhanVon').is(':hidden')){
			    	link_vanban =  '';
			    } 
			    
			    var max;var check;
			    
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_string('tenfile',  tenfile);
	            utils.putfval_string('tukhoa',  tukhoa);
	            utils.putfval_string('noidung_tieuchi',  noidung_tieuchi);
	            utils.putfval_int('id_detai',  id_detai);
	            utils.putfval_int('id_thuyetminhdetai',  id_thuyetminhdetai);
	            utils.putfval_int('id_tochuc',  id_tochuc);
	            utils.putfval_string('filenoidung', link_vanban);
	            if(!isEdit){ 
                    $.ajax({
                        url: root_href + HOME_SERVLET ,
                        data:
                        {
                            action: ACT_DB_CHECK_DATA_EXISTS,
                            tableName:'tbl_phanbovon_theohangmuc',
                            fieldName:   'id_tieuchi',
                            condition: ' id_detai='+id_detai +' and id_thuyetminhdetai='+id_thuyetminhdetai+' and id_tochuc ='+id_tochuc 
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
                            tableName:'tbl_phanbovon_theohangmuc',
                            fieldName:'id_tochuc' ,
                            condition: ' id_detai='+id_detai +' and id_thuyetminhdetai='+id_thuyetminhdetai+' and id_tochuc ='+id_tochuc 
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
	              	utils.putfval_int_condition('id_tieuchi', row.id_tieuchi);
	            }else{
		           	 $.ajax({
	                     url: root_href + HOME_SERVLET ,
	                     data:
	                     {
	                       action: ACT_DB_MAX_DATA,
	                       tableName:'tbl_phanbovon_theohangmuc',
	                       fieldName:'id_tieuchi' ,
	                       condition: null
	                     },
	                     async:false,
	                     success:function(result) {
	                       max = parseInt(result)+1 ;
	                     }
	                   });
	            	 utils.putfval_int('id_tieuchi', max);
	            }
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_phanbovon_theohangmuc'):utils.genUpdateCmd_PreStatement('tbl_phanbovon_theohangmuc','id_tieuchi=?'));
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
	               	  $('#form_phanvon_hangmuc_them').each(function () {
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
	        	  if(   (link_vanban != '') && ( $("#dlg_phanvon_hangmuc_them_NoiDung").val().length == 0
	 	        		 || $("#dlg_phanvon_hangmuc_them_TenFile").val().length == 0	
	 	        		 || $("#dlg_phanvon_hangmuc_them_TuKhoa").val().length == 0 
	 	        		   )){
	 	        		 onsubmenu_xoaanh(link_vanban,'uploadBtn_PhanVon','msgBox_PhanVon');
	 	        	  }    
	            $(this).dialog("close");
	          }
	        },
	        close: function () {
	        	if(   (link_vanban != '') && ( $("#dlg_phanvon_hangmuc_them_NoiDung").val().length == 0
	 	        		 || $("#dlg_phanvon_hangmuc_them_TenFile").val().length == 0	
	 	        		 || $("#dlg_phanvon_hangmuc_them_TuKhoa").val().length == 0 
	 	        		   )){
	        				onsubmenu_xoaanh(link_vanban,'uploadBtn_PhanVon','msgBox_PhanVon');
	 	        	  }  
	        }
	      });
	    } catch (err) {
	      alert("func_dlg_phanvon_hangmuc_show have dlg_phanvon_hangmuc_show " + err);
	    }
   }
} 
</script>

<form id="form_phanvon_hangmuc_them">
  <table>
  <tr>
      <td><b>Đề tài: </b></td>
      <td><select name="dlg_phanvon_hangmuc_them_TheLoai_Detai" id="dlg_phanvon_hangmuc_them_TheLoai_Detai"></select></td>
    </tr>
  <tr>
      <td><b>Thuyết minh đề tài: </b></td>
      <td><select name="dlg_phanvon_hangmuc_them_TheLoai_TMDetai" id="dlg_phanvon_hangmuc_them_TheLoai_TMDetai"></select></td>
    </tr>
   <tr>
   <tr>
      <td><b>Tổ chức: </b></td>
      <td><select name="dlg_phanvon_hangmuc_them_ToChuc" id="dlg_phanvon_hangmuc_them_ToChuc"></select></td>
    </tr>
    <tr>
      <td><b>Nội dung: </b></td>
      <td><input name="dlg_phanvon_hangmuc_them_NoiDung" id="dlg_phanvon_hangmuc_them_NoiDung"
                 type="text" size="25" ></td>
    </tr>
    <tr>
      <td><b>Từ khóa: </b></td>
      <td><input name="dlg_phanvon_hangmuc_them_TuKhoa" id="dlg_phanvon_hangmuc_them_TuKhoa"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Tên file: </b></td>
      <td><input name="dlg_phanvon_hangmuc_them_TenFile" id="dlg_phanvon_hangmuc_them_TenFile"
                 type="text" size="25"></td>
    </tr>
     <tr>
      <td><b>File: </b></td>
      <td>  
            <div class="col-xs-2">
              <button id="uploadBtn_PhanVon" class="btn btn-large btn-primary">Choose File</button>
            </div>
            <div class="col-xs-10">
          <div id="progressOuter_PhanVon" class="progress progress-striped active" style="display:none;">
            <div id="progressBar_PhanVon" class="progress-bar progress-bar-success"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
            </div>
          </div>
            </div>
            <div class="col-xs-10">
              <div id="msgBox_PhanVon">
              </div>
            </div>
      </td>
    </tr>
  </table>
</form>