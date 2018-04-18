<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
tinymce.init({
 	//mode : "textareas",
 	mode: "exact",
 	elements:"dlg_tintuchoatdong_them_NoiDung",
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
   	$( "#dlg_tintuchoatdong_them_NgayBanHanh" ).datepicker({
   			dateFormat: "dd/mm/yy",
			changeMonth : true,
			changeYear : true,
			yearRange : '2015:2025',
   	});
   	
	var btn = document.getElementById('uploadBtn_HoatDong');
	
    var uploader = new ss.SimpleUpload({
        button: btn,
        url: root_href + UPLOAD_SERVLET + 'action=' + CODE_UPLOAD,
        name: 'uploadfile',
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        data: {
        	folder: FILE_TINTUCHOATDONG
        }, 
        hoverClass: 'hover',
        focusClass: 'focus',
        maxSize: 1024, 
        responseType: 'json',
        
        startXHR: function() {
            progressOuter_HoatDong.style.display = 'block'; 
            this.setProgressBar( progressBar_HoatDong );
            $('#msgBox_HoatDong').show();
        },
        onSubmit: function() {
            msgBox_HoatDong.innerHTML = ''; 
            btn.innerHTML = 'Uploading...'; 
          
        },
        onChange: function( filename, extension, uploadBtn_HoatDong ){
        	$('#msgBox_HoatDong').show();
        },
        onComplete: function( filename, response ) {  
            btn.innerHTML = 'Choose Another File';
            progressOuter_HoatDong.style.display = 'none'; 
            
            link_vanban = response.link_image;
            
            if ( !response ) {
            	msgBox_HoatDong.innerHTML = 'Unable to upload file';
                return;
            }
            
            if ( response.success === true ) {
            	msgBox_HoatDong.innerHTML = '<strong>' + escapeTags( filename ) + '</strong>' + ' successfully uploaded.'
            	+ "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_HoatDong'+"\",\""+'msgBox_HoatDong'+"\"); return false;'><strong> Xóa ảnh</strong></a>";
            	$('#uploadBtn_HoatDong').hide();
            } else {
                if ( response.msg )  {
                    msgBox_HoatDong.innerHTML = escapeTags( response.msg );

                } else {
                    msgBox_HoatDong.innerHTML = 'An error occurred and the upload failed.';
                }
            }
          },
          onExtError: function( filename, extension ) {
        	msgBox_HoatDong.innerHTML = 'Lỗi: Không đúng định dạng file';  
          },
          onSizeError: function( filename, fileSize ){
        	msgBox_HoatDong.innerHTML = 'Lỗi: File phải nhỏ hơn 1 MB';
          },
          onError: function() {
            progressOuter_HoatDong.style.display = 'none';
            msgBox_HoatDong.innerHTML = 'onError: Unable to upload file';
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
  
   function func_dlg_add_tintuchoatdong(isEdit) {
    $('#form_tintuchoatdong_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TINTUCHOATDONG_TO_CBB, null, TYPE_DATA_HTML_CBB,'*', 'dlg_tintuchoatdong_them_TheLoai');
    var row;
    var datagrid_id = 'dlg_tintuchoatdong_show_datagrid';
    var tenTieuDe = "";
    var combo = "";
    var theLoaiTinTuc = ""; 
    var noidung = "";
    var ngaytao = "";
    var tomtat ="";
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_DS_TINTUCHOATDONG,
    	          condition: 'id_tintuc =' + row.id_tintuc
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          var jsonObject = JSON.parse(jsonData);
    	          document.getElementById('dlg_tintuchoatdong_them_TieuDe').value = jsonObject.rows[0].tieude;
    	          document.getElementById('dlg_tintuchoatdong_them_Tomtat').value = jsonObject.rows[0].tomtat;
    			  document.getElementById('dlg_tintuchoatdong_them_NoiDung').value = jsonObject.rows[0].noidung;
				  if(tinymce.editors.length > 0){ 
					  tinymce.activeEditor.setContent(jsonObject.rows[0].noidung);
				  }
				  document.getElementById("dlg_tintuchoatdong_them_NgayBanHanh").value= jsonObject.rows[0].ngaytao;
    			  document.getElementById('dlg_tintuchoatdong_them_TheLoai').value = jsonObject.rows[0].id_phanloai_tintuc;
    			  link_vanban = jsonObject.rows[0].duongdantintuc;
    			  if(jsonObject.rows[0].duongdantintuc != ''){
    				$('#uploadBtn_HoatDong').hide();
    			  	document.getElementById("msgBox_HoatDong").innerHTML= (jsonObject.rows[0].duongdantintuc).split("/").pop() + "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_HoatDong'+"\",\""+'msgBox_HoatDong'+"\"); return false;'><strong> Xóa ảnh</strong></a>";;
    	          }
    			  return;
    	        }}); 
       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_tintuchoatdong_them').style.display = 'none';
    	  $('#form_tintuchoatdong_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn tin tức','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_tintuchoatdong_them').dialog({
	        title: "Cập nhật tin tức ",
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
	            tenTieuDe = document.getElementById('dlg_tintuchoatdong_them_TieuDe').value;
	            combo = document.getElementById('dlg_tintuchoatdong_them_TheLoai');
			    theLoaiTinTuc = combo.options[combo.selectedIndex].value; 
			    tomtat = document.getElementById('dlg_tintuchoatdong_them_Tomtat').value;
			    noidung = tinymce.get('dlg_tintuchoatdong_them_NoiDung').getContent();
			    ngaytao = document.getElementById("dlg_tintuchoatdong_them_NgayBanHanh").value;
	
			    if (kiemtrarong(tenTieuDe) || kiemtrarong(tomtat) || kiemtrarong(noidung) || theLoaiTinTuc == -1 || !ngaythang(ngaytao)  ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            } 
			    
			    if( $('#msgBox_HoatDong').is(':hidden')){
			    	link_vanban =  '';
			    } 
	            
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_int('id_phanloai_tintuc', theLoaiTinTuc);
	            utils.putfval_string('tomtat', trim(tomtat));
	            utils.putfval_string('tieude', trim(tenTieuDe));
	            utils.putfval_int('ngaytao', gm.date.stringDate2Int(ngaytao));
	            utils.putfval_string('noidung', trim(noidung));
	            utils.putfval_string('duongdantintuc', link_vanban);
	            if (isEdit){
	              //last param
	              utils.putfval_int_condition('id_tintuc', row.id_tintuc);
	            }else {
	            	$.ajax({
						url: root_href + HOME_SERVLET ,
						data:
					    { 
						 action: ACT_DB_MAX_DATA,
						 tableName:'tbl_tintuc',
						  fieldName:'id_tintuc' ,
						  condition: null
						},
						async:false,
						success:function(result) {
							max = parseInt(result)+1 ;
							utils.putfval_int('id_tintuc', max);
						   }
					});
					
				}
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_tintuc'):utils.genUpdateCmd_PreStatement('tbl_tintuc','id_tintuc=?'));
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
	               	  $('#form_tintuchoatdong_them').each(function () {
	               	       this.reset();
	               	  });	 
	                  $('#' + datagrid_id).datagrid('reload');
	                  link_vanban ='';
	                }catch(err){
	                  msgalert_autoclose('Thông báo', err ,'warning');
	                  return;
	                }
	              }
	              if (isEdit) 	$( this ).dialog( "close" );
	              msgalert_autoclose('Thông báo','Cập nhật/Thêm mới thành công','info');
	        	  $('#uploadBtn_HoatDong').show();
		      	  $('#msgBox_HoatDong').hide();

	            }else {
	              msgalert_autoclose('Thông báo','Thao tác không thành công','error');//alert('insert/update multi object FAILED!');
	            }
	
	          },
	          "Đóng": function () {
	        	 if(   (link_vanban != '') && ( $("#dlg_tintuchoatdong_them_TieuDe").val().length == 0
	        		 || $("#dlg_tintuchoatdong_them_Tomtat").val().length == 0	
	        		 || $("#dlg_tintuchoatdong_them_NgayBanHanh").val().length == 0	
	        		 || $("#dlg_tintuchoatdong_them_NoiDung").val().length == 0 
	        		 || $( "#dlg_tintuchoatdong_them_TheLoai" ).val() == -1  )){
	        		 onsubmenu_xoaanh(link_vanban,'uploadBtn_HoatDong','msgBox_HoatDong');
	        	  }    
	            $(this).dialog("close");
	          }
	        },
	        close: function () {
	        	 if(   (link_vanban != '') && ( $("#dlg_tintuchoatdong_them_TieuDe").val().length == 0
	        		 || $("#dlg_tintuchoatdong_them_Tomtat").val().length == 0	
	        		 || $("#dlg_tintuchoatdong_them_NgayBanHanh").val().length == 0	
	        		 || $("#dlg_tintuchoatdong_them_NoiDung").val().length == 0 
	        		 || $( "#dlg_tintuchoatdong_them_TheLoai" ).val() == -1  )){
	        		 	onsubmenu_xoaanh(link_vanban,'uploadBtn_HoatDong','msgBox_HoatDong');
		         } 
	        }
	      });
	    } catch (err) {
	      alert("func_dlg_tintuchoatdong_show have dlg_tintuchoatdong_show " + err);
	    }
   }
} 
</script>

<form id="form_tintuchoatdong_them">
  <table>
  <tr>
      <td><b>Thể loại tin tức: </b></td>
      <td><select name="dlg_tintuchoatdong_them_TheLoai" id="dlg_tintuchoatdong_them_TheLoai"></select></td>
    </tr>
   <tr>
      <td><b>Tiêu đề: </b></td>
      <td><input name="dlg_tintuchoatdong_them_TieuDe" id="dlg_tintuchoatdong_them_TieuDe"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Ngày tạo: </b></td>
      <td><input name="dlg_tintuchoatdong_them_NgayBanHanh" id="dlg_tintuchoatdong_them_NgayBanHanh"
                 type="text" size="25"></td>
    </tr>
     <td><b>Tóm tắt: </b></td>
      <td><textarea name="dlg_tintuchoatdong_them_Tomtat" id="dlg_tintuchoatdong_them_Tomtat"
                 row="20" cols="100" style="width:400px"></textarea></td>
    </tr>
      <tr>
      <td><b>Hình đại diện: </b></td>
      <td>  
            <div class="col-xs-2">
              <button id="uploadBtn_HoatDong" class="btn btn-large btn-primary">Choose File</button>
            </div>
            <div class="col-xs-10">
          <div id="progressOuter_HoatDong" class="progress progress-striped active" style="display:none;">
            <div id="progressBar_HoatDong" class="progress-bar progress-bar-success"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
            </div>
          </div>
            </div>
            <div class="col-xs-10">
              <div id="msgBox_HoatDong">
              </div>
            </div>
      </td>
    </tr>
    <tr>
      <td><b>Nội dung: </b></td>
      <td><textarea name="dlg_tintuchoatdong_them_NoiDung" id="dlg_tintuchoatdong_them_NoiDung"
                  cols="40" rows="20" ></textarea></td>
    </tr>
  </table>
</form>