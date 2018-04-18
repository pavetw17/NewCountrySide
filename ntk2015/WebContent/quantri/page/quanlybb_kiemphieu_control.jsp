<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
  var link_vanban=''; 
  
  $(function() {
	  
	  $('form').submit(function(e){
		    e.preventDefault();
		  });
	  
	    $("#dlg_bb_kiemphieu_them_TheLoai_Detai" ).combobox();
	  
   	
		var btn = document.getElementById('uploadBtn_KP');
	
	    var uploader = new ss.SimpleUpload({
	        button: btn,
	        url: root_href + UPLOAD_SERVLET + 'action=' + CODE_UPLOAD,
	        name: 'uploadfile',
	        allowedExtensions: ['jpg', 'jpeg', 'png','doc','docx','xls','xlsx'],
	        data: {
	        	folder: FILE_BB_KIEMPHIEU
	        }, 
	        hoverClass: 'hover',
	        focusClass: 'focus',
	        maxSize: 1024, 
	        responseType: 'json',
	        
	        startXHR: function() {
	            progressOuter_KP.style.display = 'block'; 
	            this.setProgressBar( progressBar_KP );
	            $('#msgBox_KP').show();
	        },
	        onSubmit: function() {
	            msgBox_KP.innerHTML = ''; 
	            btn.innerHTML = 'Uploading...'; 
	        },
	        onChange: function( filename, extension, uploadBtn_KP ){
	        	$('#msgBox_KP').show();
	        },
	        onComplete: function( filename, response ) {  
	            btn.innerHTML = 'Choose Another File';
	            progressOuter_KP.style.display = 'none'; 
	            
	            link_vanban = response.link_image;
	            
	            if ( !response ) {
	            	msgBox_KP.innerHTML = 'Unable to upload file';
	                return;
	            }
	            
	            if ( response.success === true ) {
	            	msgBox_KP.innerHTML = '<strong>' + escapeTags( filename ) + '</strong>' + ' successfully uploaded.'
	            	+ "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_KP'+"\",\""+'msgBox_KP'+"\"); return false;'><strong> Xóa ảnh</strong></a>";
	            	$('#uploadBtn_KP').hide();
	            } else {
	                if ( response.msg )  {
	                    msgBox_KP.innerHTML = escapeTags( response.msg );
	                } else {
	                    msgBox_KP.innerHTML = 'An error occurred and the upload failed.';
	                }
	            }
	          },
	          onExtError: function( filename, extension ) {
	        	msgBox_KP.innerHTML = 'Lỗi: Không đúng định dạng file';  
	          },
	          onSizeError: function( filename, fileSize ){
	        	msgBox_KP.innerHTML = 'Lỗi: File phải nhỏ hơn 1 MB';
	          },
	          onError: function() {
	            progressOuter_KP.style.display = 'none';
	            msgBox_KP.innerHTML = 'onError: Unable to upload file';
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
  

  
   function func_dlg_add_bb_kiemphieu(isEdit) {
    $('#form_bb_kiemphieu_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_THUYETMINH_DETAI_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_bb_kiemphieu_them_TheLoai_Detai');
   
    var row;
    var datagrid_id = 'dlg_bb_kiemphieu_show_datagrid';
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_BIENBAN_KIEMPHIEU,
    	          condition: 'id_thuyetminh_detai =' + row.id_thuyetminh_detai
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          var jsonObject = JSON.parse(jsonData);
    	          //document.getElementById('dlg_bb_kiemphieu_them_TheLoai_Detai').value = jsonObject.rows[0].id_thuyetminh_detai; //not use 
    	          $('#dlg_bb_kiemphieu_them_TheLoai_Detai').combobox('autocomplete',jsonObject.rows[0].id_thuyetminh_detai); 
    	          document.getElementById('dlg_bb_kiemphieu_them_SoPhieuPhatRa').value = jsonObject.rows[0].sophieu_phatra;
    			  document.getElementById('dlg_bb_kiemphieu_them_SoPhieuThuVe').value =  jsonObject.rows[0].sophieu_thuve;
				  document.getElementById("dlg_bb_kiemphieu_them_SoPhieuHopLe").value= jsonObject.rows[0].sophieu_hople;
				  document.getElementById("dlg_bb_kiemphieu_them_SoPhieuKhongHopLe").value= jsonObject.rows[0].sophieu_khonghople;
    			  document.getElementById('dlg_bb_kiemphieu_them_Ngay').value = gm.date.Int2DateString(jsonObject.rows[0].ngay);
    			  document.getElementById('dlg_bb_kiemphieu_them_DTB').value = jsonObject.rows[0].diemtb;
    			  document.getElementById('dlg_bb_kiemphieu_them_TenFile').value = jsonObject.rows[0].tenfile;
    			  link_vanban = jsonObject.rows[0].file_bienban;
    			  if(link_vanban != ''){
    				$('#uploadBtn_KP').hide();
    			  	document.getElementById("msgBox_KP").innerHTML= (link_vanban).split("/").pop() + "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_KP'+"\",\""+'msgBox_KP'+"\"); return false;'><strong> Xóa ảnh</strong></a>";;
    	          }
    			  return;
    	        }}); 
       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_bb_kiemphieu_them').style.display = 'none';
    	  $('#form_bb_kiemphieu_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn biên bản','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_bb_kiemphieu_them').dialog({
	        title: "Cập nhật biên bản ",
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
	            var id_thuyetminh_detai = $('#dlg_bb_kiemphieu_them_TheLoai_Detai').val();
	            var sophieu_phatra = $('#dlg_bb_kiemphieu_them_SoPhieuPhatRa').val();
	            var sophieu_thuve = $('#dlg_bb_kiemphieu_them_SoPhieuThuVe').val();
	            var sophieu_hople = $('#dlg_bb_kiemphieu_them_SoPhieuHopLe').val();
	            var sophieu_khonghople = $('#dlg_bb_kiemphieu_them_SoPhieuKhongHopLe').val();
	            var ngay = $('#dlg_bb_kiemphieu_them_Ngay').val();
	            var diemtb = $('#dlg_bb_kiemphieu_them_DTB').val();
	            var tenfile = $('#dlg_bb_kiemphieu_them_TenFile').val();
	            
			    if ( kiemtrarong(sophieu_phatra)  || kiemtrarong(sophieu_thuve)  
			    		|| kiemtrarong(sophieu_hople) || kiemtrarong(sophieu_khonghople)
			    	 || kiemtrarong(diemtb) || kiemtrarong(ngay)  || kiemtrarong(diemtb)
			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }   
	            
	            var intRegex = /^\d+$/;
			    if(!intRegex.test(sophieu_phatra) || !intRegex.test(sophieu_thuve) || 
			       !intRegex.test(sophieu_hople) || !intRegex.test(sophieu_khonghople)	||
			       !intRegex.test(diemtb)	||
			    		parseInt(sophieu_thuve) > parseInt(sophieu_phatra)  ){
			    	  msgalert_autoclose('Thông báo','Số nhập vào không đúng!','warning');
		              return;
			    }
			    
			    if( $('#msgBox_KP').is(':hidden')){
			    	link_vanban =  '';
			    } 
	            
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_int('sophieu_phatra',  sophieu_phatra);
	            utils.putfval_int('sophieu_thuve',  sophieu_thuve);
	            utils.putfval_int('sophieu_hople',  sophieu_hople);
	            utils.putfval_int('sophieu_khonghople',  sophieu_khonghople);
	            utils.putfval_int('diemtb',  diemtb);
	            utils.putfval_string('tenfile', trim(tenfile));
	            utils.putfval_string('file_bienban', link_vanban); 
	            utils.putfval_int('ngay',  gm.date.stringDate2Int(ngay));
	            if (isEdit){
	              utils.putfval_int_condition('id_thuyetminh_detai', row.id_thuyetminh_detai);
	            }else{ 
                    $.ajax({
                        url: root_href + HOME_SERVLET ,
                        data:
                        {
                            action: ACT_DB_CHECK_DATA_EXISTS,
                            tableName:'tbl_bienban_kiemphieu',
                            fieldName:'id_thuyetminh_detai' ,
                            condition: 'id_thuyetminh_detai='+ id_thuyetminh_detai
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
                        msgalert_autoclose('Thông báo',' Đề tài này đã tồn tại!','warning');
                        return;
                    }
                }
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_bienban_kiemphieu'):utils.genUpdateCmd_PreStatement('tbl_bienban_kiemphieu','id_thuyetminh_detai=?'));
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
	               	  $('#form_bb_kiemphieu_them').each(function () {
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
	        	  $('#uploadBtn_KP').show();
		      	  $('#msgBox_KP').hide();

	            }else {
	              msgalert_autoclose('Thông báo','Thao tác không thành công','error');//alert('insert/update multi object FAILED!');
	            }
	
	          },
	          "Đóng": function () {
	        	 if(   (link_vanban != '') && ( $("#dlg_bb_kiemphieu_them_SoPhieuPhatRa").val().length == 0
	        		 || $("#dlg_bb_kiemphieu_them_SoPhieuThuVe").val().length == 0	
	        		 || $("#dlg_bb_kiemphieu_them_SoPhieuHopLe").val().length == 0	
	        		 || $("#dlg_bb_kiemphieu_them_SoPhieuKhongHopLe").val().length == 0 
	        		 || $("#dlg_bb_kiemphieu_them_Ngay").val().length == 0 
	        		 || $("#dlg_bb_kiemphieu_them_TenFile").val().length == 0 
	        		 || $("#dlg_bb_kiemphieu_them_DTB").val().length == 0 
	        		   )){
	        		 onsubmenu_xoaanh(link_vanban,'uploadBtn_KP','msgBox_KP');
	        	  }    
	            $(this).dialog("close");
	          }
	        },
	        close: function () {
	        	 if(   (link_vanban != '') && ( $("#dlg_bb_kiemphieu_them_SoPhieuPhatRa").val().length == 0
		        		 || $("#dlg_bb_kiemphieu_them_SoPhieuThuVe").val().length == 0	
		        		 || $("#dlg_bb_kiemphieu_them_SoPhieuHopLe").val().length == 0	
		        		 || $("#dlg_bb_kiemphieu_them_SoPhieuKhongHopLe").val().length == 0 
		        		 || $("#dlg_bb_kiemphieu_them_Ngay").val().length == 0 
		        		 || $("#dlg_bb_kiemphieu_them_TenFile").val().length == 0 
		        		 || $("#dlg_bb_kiemphieu_them_DTB").val().length == 0 
	        			 )){
	        		 	onsubmenu_xoaanh(link_vanban,'uploadBtn_KP','msgBox_KP');
		         } 
	        }
	      });
	    } catch (err) {
	      alert("func_dlg_bb_kiemphieu_show have dlg_bb_kiemphieu_show " + err);
	    }
   }
} 
</script>

<form id="form_bb_kiemphieu_them">
  <table>
  <tr>
      <td><b>Đề tài: </b></td>
      <td><select name="dlg_bb_kiemphieu_them_TheLoai_Detai" id="dlg_bb_kiemphieu_them_TheLoai_Detai"></select></td>
    </tr>
   <tr>
      <td><b>Số phiếu phát ra: </b></td>
      <td><input name="dlg_bb_kiemphieu_them_SoPhieuPhatRa" id="dlg_bb_kiemphieu_them_SoPhieuPhatRa"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Số phiếu thu về: </b></td>
      <td><input name="dlg_bb_kiemphieu_them_SoPhieuThuVe" id="dlg_bb_kiemphieu_them_SoPhieuThuVe"
                 type="text" size="25"></td>
    </tr>
    <tr>
     <td><b>Số phiều hợp lệ: </b></td>
      <td><input name="dlg_bb_kiemphieu_them_SoPhieuHopLe" id="dlg_bb_kiemphieu_them_SoPhieuHopLe"
                 type="text" size="25"></td>
    </tr>
     <td><b>Số phiều không hợp lệ: </b></td>
      <td><input name="dlg_bb_kiemphieu_them_SoPhieuKhongHopLe" id="dlg_bb_kiemphieu_them_SoPhieuKhongHopLe"
                 type="text" size="25">
                </td>
    </tr>
    <tr>
     <td><b>Ngày: </b></td>
      <td><input name="dlg_bb_kiemphieu_them_Ngay" id="dlg_bb_kiemphieu_them_Ngay"
          class="datepicker"       type="text" size="25"></td>
    </tr>
     <tr>
     <td><b>Điểm trung bình: </b></td>
      <td><input name="dlg_bb_kiemphieu_them_DTB" id="dlg_bb_kiemphieu_them_DTB"
                 type="text" size="25"></textarea></td>
    </tr>
    <tr>
     <td><b>Tên file: </b></td>
      <td><input name="dlg_bb_kiemphieu_them_TenFile" id="dlg_bb_kiemphieu_them_TenFile"
                 type="text" size="25"></td>
    </tr>
      <tr>
      <td><b>File biên bản: </b></td>
      <td>  
            <div class="col-xs-2">
              <button id="uploadBtn_KP" class="btn btn-large btn-primary">Choose File</button>
            </div>
            <div class="col-xs-10">
          <div id="progressOuter_KP" class="progress progress-striped active" style="display:none;">
            <div id="progressBar_KP" class="progress-bar progress-bar-success"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
            </div>
          </div>
            </div>
            <div class="col-xs-10">
              <div id="msgBox_KP">
              </div>
            </div>
      </td>
    </tr>
  </table>
</form>