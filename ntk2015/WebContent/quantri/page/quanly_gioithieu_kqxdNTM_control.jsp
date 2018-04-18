<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
tinymce.init({
 	//mode : "textareas",
 	mode: "exact",
 	elements:"dlg_gioithieu_kqxdNTM_them_NoiDung",
 	theme : "advanced",
	plugins : "imagemanager,filemanager,autolink,lists,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave,visualblocks",
	
	convert_urls:true,
	relative_urls:false,
	remove_script_host:false,
	entity_encoding : "raw",
	
	theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
	theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code",
	theme_advanced_buttons3 : "preview,forecolor,backcolor,tablecontrols",
	
	theme_advanced_toolbar_location : "top",
	theme_advanced_toolbar_align : "left",
	theme_advanced_statusbar_location : "bottom",
	theme_advanced_resizing: true,

	style_formats : [
		{title : 'Bold text', inline : 'b'},
		{title : 'Red text', inline : 'span', styles : {color : '#ff0000'}},
		{title : 'Red header', block : 'h1', styles : {color : '#ff0000'}},
		{title : 'Table styles'},
		{title : 'Table row 1', selector : 'tr', classes : 'tablerow1'}
	],
	height : "300",  
	width: "600",
	 setup : function(ed)
     {
         ed.onInit.add(function(ed)
         {
         ed.getBody().style.fontSize = '13px';
         });
     },
});

  var link_vanban=''; 
  $(function() {
	
	var btn = document.getElementById('uploadBtn_GioiThieu_XDNTM');
	
    var uploader = new ss.SimpleUpload({
        button: btn,
        url: root_href + UPLOAD_SERVLET + 'action=' + CODE_UPLOAD,
        name: 'uploadfile',
        allowedExtensions: ['jpg', 'jpeg', 'png','pdf', 'doc','docx'],
        data: {
        	folder: FILE_GIOITHIEU_KQXDNTM
        }, 
        hoverClass: 'hover',
        focusClass: 'focus',
        maxSize: 1024, 
        responseType: 'json',
        
        startXHR: function() {
            progressOuter_GioiThieu_XDNTM.style.display = 'block'; 
            this.setProgressBar( progressBar_GioiThieu_XDNTM );
            $('#msgBox_GioiThieu_XDNTM').show();
        },
        onSubmit: function() {
            msgBox_GioiThieu_XDNTM.innerHTML = ''; 
            btn.innerHTML = 'Uploading...'; 
          
        },
        onChange: function( filename, extension, uploadBtn_GioiThieu_XDNTM ){
        	$('#msgBox_GioiThieu_XDNTM').show();
        },
        onComplete: function( filename, response ) {  
            btn.innerHTML = 'Choose Another File';
            progressOuter_GioiThieu_XDNTM.style.display = 'none'; 
            
            link_vanban = response.link_image;
            
            if ( !response ) {
            	msgBox_GioiThieu_XDNTM.innerHTML = 'Unable to upload file';
                return;
            }
            
            if ( response.success === true ) {
            	msgBox_GioiThieu_XDNTM.innerHTML = '<strong>' + escapeTags( filename ) + '</strong>' + ' successfully uploaded.'
            	+ "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_GioiThieu_XDNTM'+"\",\""+'msgBox_GioiThieu_XDNTM'+"\"); return false;'><strong> Xóa ảnh</strong></a>";
            	$('#uploadBtn_GioiThieu_XDNTM').hide();
            } else {
                if ( response.msg )  {
                    msgBox_GioiThieu_XDNTM.innerHTML = escapeTags( response.msg );

                } else {
                    msgBox_GioiThieu_XDNTM.innerHTML = 'An error occurred and the upload failed.';
                }
            }
          },
          onExtError: function( filename, extension ) {
        	msgBox_GioiThieu_XDNTM.innerHTML = 'Lỗi: Không đúng định dạng file';  
          },
          onSizeError: function( filename, fileSize ){
        	msgBox_GioiThieu_XDNTM.innerHTML = 'Lỗi: File phải nhỏ hơn 1 MB';
          },
          onError: function() {
            progressOuter_GioiThieu_XDNTM.style.display = 'none';
            msgBox_GioiThieu_XDNTM.innerHTML = 'onError: Unable to upload file';
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
  
   function func_dlg_add_gioithieu_kqxdNTM(isEdit) {
    $('#form_gioithieu_kqxdNTM_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_XADIEM_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_gioithieu_kqxdNTM_them_XaDiem');
    var row;
    var datagrid_id = 'dlg_gioithieu_kqxdNTM_show_datagrid';
    var tenTieuDe = "";
    var combo = "";
    var id_xadiem = ""; 
    var noidung = "";
    var ngaycongbo = "";
    var tomtatnoidung ="";
    var tinhtrang ;
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_BAIVIET_GIOITHIEU_NTM,
    	          condition: 'id_baiviet =' + row.id_baiviet
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          var jsonObject = JSON.parse(jsonData);
    	          
    	          document.getElementById('dlg_gioithieu_kqxdNTM_them_TieuDe').value = jsonObject.rows[0].tentieude;
    	          document.getElementById('dlg_gioithieu_kqxdNTM_them_Tomtat').value = jsonObject.rows[0].tomtatnoidung;
    			  document.getElementById('dlg_gioithieu_kqxdNTM_them_NoiDung').value = jsonObject.rows[0].noidungbv;
				  if(tinymce.editors.length > 0){ 
					  tinymce.activeEditor.setContent(jsonObject.rows[0].noidungbv);
				  }
				  document.getElementById("dlg_gioithieu_kqxdNTM_them_NgayBanHanh").value= gm.date.Int2DateString(jsonObject.rows[0].ngaycongbo);
    			  document.getElementById('dlg_gioithieu_kqxdNTM_them_XaDiem').value = jsonObject.rows[0].id_xadiem;
    			  $('input[name="rdb_tinhtrang"][value="' + jsonObject.rows[0].tinhtrang + '"]').prop('checked', true);
    			  
    			  link_vanban = jsonObject.rows[0].noidung;
    			  if(jsonObject.rows[0].noidung != ''){
    				$('#uploadBtn_GioiThieu_XDNTM').hide();
    			  	document.getElementById("msgBox_GioiThieu_XDNTM").innerHTML= (jsonObject.rows[0].noidung).split("/").pop() + "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_GioiThieu_XDNTM'+"\",\""+'msgBox_GioiThieu_XDNTM'+"\"); return false;'><strong> Xóa ảnh</strong></a>";;
    	          }
    			  return;
    	        }}); 
       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_gioithieu_kqxdNTM_them').style.display = 'none';
    	  $('#form_gioithieu_kqxdNTM_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn giới thiệu','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_gioithieu_kqxdNTM_them').dialog({
	        title: "Cập nhật giới thiệu ",
	        open: function () {
	          $(this).dialog('widget').draggable('option', {containment: false});
	        },
	        height: 550,
	        width: 800,
	        collapsible: true,
	        draggable: true,
	        resizable: true,
	        position: [350, 100],
	        modal: true,
	        buttons: {
	          "Cập nhật": function () {
	            tenTieuDe = document.getElementById('dlg_gioithieu_kqxdNTM_them_TieuDe').value;
	            combo = document.getElementById('dlg_gioithieu_kqxdNTM_them_XaDiem');
			    id_xadiem = combo.options[combo.selectedIndex].value; 
			    tomtatnoidung = document.getElementById('dlg_gioithieu_kqxdNTM_them_Tomtat').value;
			    noidung = tinymce.get('dlg_gioithieu_kqxdNTM_them_NoiDung').getContent();
			    ngaycongbo = document.getElementById("dlg_gioithieu_kqxdNTM_them_NgayBanHanh").value;
				tinhtrang = $("input[name='rdb_tinhtrang']:checked").val();
				
			    if (kiemtrarong(tenTieuDe) || kiemtrarong(tomtatnoidung) || kiemtrarong(noidung) || id_xadiem == -1 || !ngaythang(ngaycongbo)  ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }  
			    
			    if( $('#msgBox_GioiThieu_XDNTM').is(':hidden')){
			    	link_vanban =  '';
			    } 
	            
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_int('id_xadiem', id_xadiem);
	            utils.putfval_string('tomtatnoidung', trim(tomtatnoidung));
	            utils.putfval_string('tentieude', trim(tenTieuDe));
	            utils.putfval_int('ngaycongbo', gm.date.stringDate2Int(ngaycongbo));
	            utils.putfval_string('noidungbv', trim(noidung));
	            utils.putfval_string('noidung', link_vanban);
	            utils.putfval_boolean('tinhtrang', tinhtrang);
	            if (isEdit){
	              //last param
	              utils.putfval_int_condition('id_baiviet', row.id_baiviet);
	            }
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_baiviet'):utils.genUpdateCmd_PreStatement('tbl_baiviet','id_baiviet=?'));
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
	               	  $('#form_gioithieu_kqxdNTM_them').each(function () {
	               	       this.reset();
	               	  });	 
	                  $('#' + datagrid_id).datagrid('reload');
	                  link_vanban = '';
	                }catch(err){
	                  msgalert_autoclose('Thông báo', err ,'warning');
	                  return;
	                }
	              }
	              if (isEdit) 	$( this ).dialog( "close" );
	              msgalert_autoclose('Thông báo','Cập nhật/Thêm mới thành công','info');
	        	  $('#uploadBtn_GioiThieu_XDNTM').show();
		      	  $('#msgBox_GioiThieu_XDNTM').hide();

	            }else {
	              msgalert_autoclose('Thông báo','Thao tác không thành công','error');//alert('insert/update multi object FAILED!');
	            }
	
	          },
	          "Đóng": function () {
	        	 if(   (link_vanban != '') && ( $("#dlg_gioithieu_kqxdNTM_them_TieuDe").val().length == 0
	        		 || $("#dlg_gioithieu_kqxdNTM_them_Tomtat").val().length == 0	
	        		 || $("#dlg_gioithieu_kqxdNTM_them_NgayBanHanh").val().length == 0	
	        		 || $("#dlg_gioithieu_kqxdNTM_them_NoiDung").val().length == 0 
	        		 || $( "#dlg_gioithieu_kqxdNTM_them_XaDiem" ).val() == -1  )){
	        		 onsubmenu_xoaanh(link_vanban,'uploadBtn_GioiThieu_XDNTM','msgBox_GioiThieu_XDNTM');
	        	  }    
	            $(this).dialog("close");
	          }
	        },
	        close: function () {
	        	 if(   (link_vanban != '') && ( $("#dlg_gioithieu_kqxdNTM_them_TieuDe").val().length == 0
	        		 || $("#dlg_gioithieu_kqxdNTM_them_Tomtat").val().length == 0	
	        		 || $("#dlg_gioithieu_kqxdNTM_them_NgayBanHanh").val().length == 0	
	        		 || $("#dlg_gioithieu_kqxdNTM_them_NoiDung").val().length == 0 
	        		 || $( "#dlg_gioithieu_kqxdNTM_them_XaDiem" ).val() == -1  )){
	        		 	onsubmenu_xoaanh(link_vanban,'uploadBtn_GioiThieu_XDNTM','msgBox_GioiThieu_XDNTM');
		         } 
	        }
	      });
	    } catch (err) {
	      alert("func_dlg_gioithieu_kqxdNTM_show have dlg_gioithieu_kqxdNTM_show " + err);
	    }
   }
} 
</script>

<form id="form_gioithieu_kqxdNTM_them">
  <table>
  <tr>
      <td><b>Xã điểm: </b></td>
      <td><select name="dlg_gioithieu_kqxdNTM_them_XaDiem" id="dlg_gioithieu_kqxdNTM_them_XaDiem"></select></td>
    </tr>
   <tr>
      <td><b>Tiêu đề: </b></td>
      <td><input name="dlg_gioithieu_kqxdNTM_them_TieuDe" id="dlg_gioithieu_kqxdNTM_them_TieuDe"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Ngày tạo: </b></td>
      <td><input name="dlg_gioithieu_kqxdNTM_them_NgayBanHanh" id="dlg_gioithieu_kqxdNTM_them_NgayBanHanh" class="datepicker"
                 type="text" size="25"></td>
    </tr>
    <tr>
     <td><b>Tình trạng: </b></td>
      <td>  
      <input type="radio" value="true" checked id="rdb_tinhtrang" name="rdb_tinhtrang" style="width: 16px; height: 16px;">Hiện bài
		<input type="radio" value="false" name="rdb_tinhtrang" id="rdb_tinhtrang" style=" width: 16px; height: 16px; margin-left: 40px;">Ẩn bài</td>
        
    </tr>
    <tr>
     <td><b>Tóm tắt: </b></td>
      <td><textarea name="dlg_gioithieu_kqxdNTM_them_Tomtat" id="dlg_gioithieu_kqxdNTM_them_Tomtat"
                 row="20" cols="100" style="width:400px"></textarea></td>
    </tr>
      <tr>
      <td><b>File: </b></td>
      <td>  
            <div class="col-xs-2">
              <button id="uploadBtn_GioiThieu_XDNTM" class="btn btn-large btn-primary">Choose File</button>
            </div>
            <div class="col-xs-10">
          <div id="progressOuter_GioiThieu_XDNTM" class="progress progress-striped active" style="display:none;">
            <div id="progressBar_GioiThieu_XDNTM" class="progress-bar progress-bar-success"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
            </div>
          </div>
            </div>
            <div class="col-xs-10">
              <div id="msgBox_GioiThieu_XDNTM">
              </div>
            </div>
      </td>
    </tr>
    <tr>
      <td><b>Nội dung: </b></td>
      <td><textarea name="dlg_gioithieu_kqxdNTM_them_NoiDung" id="dlg_gioithieu_kqxdNTM_them_NoiDung"
                  cols="40" rows="20" ></textarea></td>
    </tr>
  </table>
</form>