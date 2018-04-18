<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
var link_vanban=''; 
var fruits = [];
  $(function() {
	    $("#dlg_hinhanh_kqxdNTM_them_XaDiem" ).combobox();
	    $("#dlg_hinhanh_kqxdNTM_them_Folder" ).combobox();
	    
	    var chuoi ='';
		var btn = document.getElementById('uploadBtn_HinhAnh_kqxdNTM');
		var count = 0;
	    var uploader = new ss.SimpleUpload({
	        button: btn,
	        url: root_href + UPLOAD_SERVLET + 'action=' + CODE_UPLOAD,
	        name: 'uploadfile',
	        allowedExtensions: ['jpg', 'jpeg', 'png','doc','docx','xls','xlsx'],
	        data: {
	        	folder: FILE_HINHANH_KETQUA_NTM
	        }, 
	        hoverClass: 'hover',
	        focusClass: 'focus',
	        maxSize: 1024, 
	        responseType: 'json',
	        multiple: true,
	        startXHR: function() {
	            progressOuter_HinhAnh_kqxdNTM.style.display = 'block'; 
	            this.setProgressBar( progressBar_HinhAnh_kqxdNTM );
	            $('#msgBox_HinhAnh_kqxdNTM').show();
	        },
	        onSubmit: function(filename, extension) {
	            msgBox_HinhAnh_kqxdNTM.innerHTML = ''; 
	            btn.innerHTML = 'Uploading...'; 
	         // Create the elements of our progress bar
	            var progress = document.createElement('div'), // container for progress bar
	                bar = document.createElement('div'), // actual progress bar
	                fileSize = document.createElement('div'), // container for upload file size
	                wrapper = document.createElement('div'), // container for this progress bar
	                progressBox = document.getElementById('progressBar_HinhAnh_kqxdNTM'); // on page container for progress bars

	            // Assign each element its corresponding class
	            progress.className = 'progress';
	            bar.className = 'bar';            
	            fileSize.className = 'size';
	            wrapper.className = 'wrapper';

	            // Assemble the progress bar and add it to the page
	            progress.appendChild(bar); 
	            wrapper.innerHTML = '<div class="name">'+filename+'</div>'; // filename is passed to onSubmit()
	            wrapper.appendChild(fileSize);
	            wrapper.appendChild(progress);                                       
	            progressBox.appendChild(wrapper); // just an element on the page to hold the progress bars    

	            // Assign roles to the elements of the progress bar
	            this.setProgressBar(bar); // will serve as the actual progress bar
	            this.setFileSizeBox(fileSize); // display file size beside progress bar
	            this.setProgressContainer(wrapper); // designate the containing div to be removed after upload
	        },
	        onChange: function( filename, extension, uploadBtn_HinhAnh_kqxdNTM ){
	        	$('#msgBox_HinhAnh_kqxdNTM').show();
	        },
	        onComplete: function( filename, response ) {  
	            btn.innerHTML = 'Choose Another File';
	            progressOuter_HinhAnh_kqxdNTM.style.display = 'none'; 
	            link_vanban = response.link_image;
	            
	            fruits.push(response.link_image);
	           
	            if ( !response ) {
	            	msgBox_HinhAnh_kqxdNTM.innerHTML = 'Unable to upload file';
	                return;
	            }
	            
	            if ( response.success === true ) {
	            	chuoi += "<div id=\""+ 'uploadhinh'+count +"\"><strong>" + escapeTags( filename ) + '</strong>' + ' successfully uploaded.'
	            	+ "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+''+"\",\""+ 'uploadhinh'+count +"\"); return false;'><strong> Xóa ảnh</strong></a></div>";
	            	count++;
	            } else {
	                if ( response.msg )  {
	                    msgBox_HinhAnh_kqxdNTM.innerHTML = escapeTags( response.msg );
	                } else {
	                    msgBox_HinhAnh_kqxdNTM.innerHTML = 'An error occurred and the upload failed.';
	                }
	            }
	            msgBox_HinhAnh_kqxdNTM.innerHTML = chuoi;
	          },
	          onExtError: function( filename, extension ) {
	        	msgBox_HinhAnh_kqxdNTM.innerHTML = 'Lỗi: Không đúng định dạng file';  
	          },
	          onSizeError: function( filename, fileSize ){
	        	msgBox_HinhAnh_kqxdNTM.innerHTML = 'Lỗi: File phải nhỏ hơn 1 MB';
	          },
	          onError: function() {
	            progressOuter_HinhAnh_kqxdNTM.style.display = 'none';
	            msgBox_HinhAnh_kqxdNTM.innerHTML = 'onError: Unable to upload file';
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
  
   function func_dlg_add_hinhanh_kqxdNTM(isEdit) {
    $('#form_hinhanh_kqxdNTM_them').each(function () {
       this.reset();
    });

    var datagrid_id = 'dlg_hinhanh_kqxdNTM_show_datagrid';
	cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_FOLDER_HINHANH_DETAI_TO_CBB, ' type_media = 1', TYPE_DATA_HTML_CBB,'*', 'dlg_hinhanh_kqxdNTM_them_Folder');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_XADIEM_TO_CBB, null , TYPE_DATA_HTML_CBB,'*', 'dlg_hinhanh_kqxdNTM_them_XaDiem');
    
   
    try {
	      $('#dlg_hinhanh_kqxdNTM_them').dialog({
	        title: "Cập nhật hìnhh ảnh ",
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
	            var id_xadiem = $('#dlg_hinhanh_kqxdNTM_them_XaDiem').val();
	            var id_folder = $('#dlg_hinhanh_kqxdNTM_them_Folder').val();
	            
			    if (  fruits.length == 0 
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
	            utils.putfval_int('type_media',  1);
	            
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
	               	  $('#form_hinhanh_kqxdNTM_them').each(function () {
	               	       this.reset();
	               	  });
	               	  fruits = [];
	               	  $('#msgBox_HinhAnh_kqxdNTM').hide();
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
	        	  if( fruits.length > 0 &&  ($("#dlg_hinhanh_kqxdNTM_them_XaDiem").val() == -1 ||  $("#dlg_hinhanh_kqxdNTM_them_Folder").val() == -1 )){
	 	        		for(var i=0;i<fruits.length;i++){
	 	        		 	onsubmenu_xoaanh(fruits[i],'','');
	 	        		}
    	  		  } 
	              $(this).dialog("close");
	          }
	        },
	        close: function () {
	        	  if( fruits.length > 0 &&  ($("#dlg_hinhanh_kqxdNTM_them_XaDiem").val() == -1 ||  $("#dlg_hinhanh_kqxdNTM_them_Folder").val() == -1 )){
	 	        		for(var i=0;i<fruits.length;i++){
	 	        		 	onsubmenu_xoaanh(fruits[i],'','');
	 	        		}
      	  		  } 
	        }
	      });
	    } catch (err) {
	      alert("func_dlg_hinhanh_kqxdNTM_show have dlg_hinhanh_kqxdNTM_show " + err);
	    }
} 
</script>

<form id="form_hinhanh_kqxdNTM_them">
  <table>
  <tr>
      <td><b>Xã điểm: </b></td>
      <td><select name="dlg_hinhanh_kqxdNTM_them_XaDiem" id="dlg_hinhanh_kqxdNTM_them_XaDiem"></select></td>
    </tr>
  <tr>
      <td><b>Thư mục: </b></td>
      <td><select name="dlg_hinhanh_kqxdNTM_them_Folder" id="dlg_hinhanh_kqxdNTM_them_Folder"></select></td>
    </tr>
   <tr>
    <tr>
      <td><b>Úp ảnh: </b></td>
      <td>  
            <div class="col-xs-2">
              <button id="uploadBtn_HinhAnh_kqxdNTM" class="btn btn-large btn-primary">Choose File</button>
            </div>
            <div class="col-xs-10">
          <div id="progressOuter_HinhAnh_kqxdNTM" class="progress progress-striped active" style="display:none;">
            <div id="progressBar_HinhAnh_kqxdNTM" class="progress-bar progress-bar-success"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
            </div>
          </div>
            </div>
            <div class="col-xs-10">
              <div id="msgBox_HinhAnh_kqxdNTM">
              </div>
            </div>
      </td>
    </tr>
  </table>
</form>