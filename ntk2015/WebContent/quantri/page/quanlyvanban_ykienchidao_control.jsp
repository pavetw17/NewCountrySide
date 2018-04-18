<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
  var link_vanban = ""; 
  $(function() {
	  $('form').submit(function(e){
		    e.preventDefault();
		  });
	  
   	$( "#dlg_qlvanban_ykienchidao_them_NgayBanHanh" ).datepicker({
   			dateFormat: "dd/mm/yy",
			changeMonth : true,
			changeYear : true,
			yearRange : '2015:2025',
   	});

   	var btn = document.getElementById('uploadBtn_YKien');
    var uploader = new ss.SimpleUpload({
        button: btn,
        url: root_href + UPLOAD_SERVLET + 'action=' + CODE_UPLOAD,
        name: 'uploadfile',
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif','pdf','doc','docx','xls','xlsx'],
        data: {
        	fileExists: link_vanban,
        	folder: FILE_YKIENCHIDAO
        }, 
        hoverClass: 'hover',
        focusClass: 'focus',
        maxSize: 1024, // kilobytes
        responseType: 'json',
        
        startXHR: function() {
            progressOuter_YKien.style.display = 'block'; // make progress bar visible
            this.setProgressBar( progressBar_YKien );
        },
        onSubmit: function() {
            msgBox_YKien.innerHTML = ''; // empty the message box
            btn.innerHTML = 'Uploading...'; // change button text to "Uploading..."
          },
        onComplete: function( filename, response ) {  
            btn.innerHTML = 'Choose Another File';
            progressOuter_YKien.style.display = 'none'; 
            
            link_vanban = response.link_image;
            
            if ( !response ) {
            	msgBox_YKien.innerHTML = 'Unable to upload file';
                return;
            }
            
            if ( response.success === true ) {
                msgBox_YKien.innerHTML = '<strong>' + escapeTags( filename ) + '</strong>' + ' successfully uploaded.'
            	+ "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_YKien'+"\",\""+'msgBox_YKien'+"\"); return false;'><strong> Xóa ảnh</strong></a>";
            	$('#uploadBtn_QuyTrinh').hide();
            } else {
                if ( response.msg )  {
                    msgBox_YKien.innerHTML = escapeTags( response.msg );

                } else {
                    msgBox_YKien.innerHTML = 'An error occurred and the upload failed.';
                }
            }
          },
          onExtError: function( filename, extension ) {
        	msgBox_YKien.innerHTML = 'Lỗi: Không đúng định dạng file';  
          },
          onSizeError: function( filename, fileSize ){
        	msgBox_YKien.innerHTML = 'Lỗi: File phải nhỏ hơn 1 MB';
          },
          onError: function() {
            progressOuter_YKien.style.display = 'none';
            msgBox_YKien.innerHTML = 'onError: Unable to upload file';
          } 
	});
  });
  
  function escapeTags( str ) {
	  return String( str )
	           .replace( /&/g, '&amp;' )
	           .replace( /"/g, '&quot;' )
	           .replace( /'/g, '&#39;' )
	           .replace( /</g, '&lt;' )
	           .replace( />/g, '&gt;' );
	}
  
  function func_dlg_add_qlvanban_ykienchidao(isEdit) {
    $('#form_qlvanban_ykienchidao_them').each(function () {
       this.reset();
    });

    var row;
    var datagrid_id = 'dlg_qlvanban_ykienchidao_show_datagrid';
    var tenVanBan = "";
    var kihieu = "";
    var noidung = "";
    var ngayVanBan = "";
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
      if(row != null){ 
      $.ajax({
        url: root_href + HOME_SERVLET ,
        data:{
          action: ACT_GET_DATA_TO_EDIT_DS_YKIENCHIDAO,
          condition: 'id_ykienchidao =' + row.id_ykienchidao
        }, 
        async:false,
        success:function(jsonData) {
          var jsonObject = JSON.parse(jsonData);
          document.getElementById('dlg_qlvanban_ykienchidao_them_Ten').value = jsonObject.rows[0].tieude;
          document.getElementById('dlg_qlvanban_ykienchidao_them_SoKiHieu').value = jsonObject.rows[0].sokihieu;
		  document.getElementById('dlg_qlvanban_ykienchidao_them_NoiDung').value = jsonObject.rows[0].noidungchidao;
		  document.getElementById("dlg_qlvanban_ykienchidao_them_NgayBanHanh").value= jsonObject.rows[0].ngay_chidao_cohieuluc;
		  document.getElementById("msgBox_YKien").innerHTML= (jsonObject.rows[0].duongdanykienchidao).split("/").pop();
		  link_vanban = jsonObject.rows[0].duongdanykienchidao;
		  if(link_vanban != ''){
				$('#uploadBtn_YKien').hide();
			  	document.getElementById("msgBox_YKien").innerHTML= (link_vanban).split("/").pop() + "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_YKien'+"\",\""+'msgBox_YKien'+"\"); return false;'><strong> Xóa ảnh</strong></a>";
	          }
		  return;
        }});
      }else{
    	  kiemtraRowNULL = false;
    	  $('#form_qlvanban_ykienchidao_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn ý kiến','error');
      } 
    }
    
    if(kiemtraRowNULL){
    try {
      $('#dlg_qlvanban_ykienchidao_them').dialog({
        title: "Cập nhật loại văn bản ",
        modal: false, open: function () {
          $(this).dialog('widget').draggable('option', {containment: false});
        },
        height: 500,
        width: 500,
        collapsible: true,
        draggable: true,
        resizable: false,
        position: [450, 100],

        buttons: {
          "Cập nhật": function () {
            tenVanBan = document.getElementById('dlg_qlvanban_ykienchidao_them_Ten').value;
		    kihieu = document.getElementById('dlg_qlvanban_ykienchidao_them_SoKiHieu').value;
		    noidung = document.getElementById('dlg_qlvanban_ykienchidao_them_NoiDung').value;
		    ngayVanBan = document.getElementById("dlg_qlvanban_ykienchidao_them_NgayBanHanh").value;
            
		    if (kiemtrarong(tenVanBan) || kiemtrarong(kihieu) || kiemtrarong(noidung) || !ngaythang(ngayVanBan) ){
              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
              return;
            } 

           /*  gm = new GenericManager(true); */
           // alert(gm.date.stringDate2Int(ngayVanBan));
            
		    if( $('#msgBox_YKien').is(':hidden')){
		    	link_vanban =  '';
		    } 
           
            var utils = new Utils();
            var	strSQL;
            utils.clearFieldStorer();
            utils.putfval_string('sokihieu', trim(kihieu));
            utils.putfval_string('tieude', trim(tenVanBan));
            utils.putfval_int('ngay_chidao_cohieuluc', gm.date.stringDate2Int(ngayVanBan));
            utils.putfval_string('noidungchidao', trim(noidung));
            utils.putfval_string('duongdanykienchidao', link_vanban);
            if (isEdit){
              //last param
              utils.putfval_int_condition('id_ykienchidao', row.id_ykienchidao);
            }else {
            	$.ajax({
					url: root_href + HOME_SERVLET ,
					data:
				    { 
					 action: ACT_DB_MAX_DATA,
					 tableName:'tbl_ykienchidao',
					  fieldName:'id_ykienchidao' ,
					  condition: null
					},
					async:false,
					success:function(result) {
						max = parseInt(result)+1 ;
						utils.putfval_int('id_ykienchidao', max);
					   }
				});
				
			}
            
            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_ykienchidao'):utils.genUpdateCmd_PreStatement('tbl_ykienchidao','id_ykienchidao=?'));
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
               	  $('#form_qlvanban_ykienchidao_them').each(function () {
               	       this.reset();
               	       msgBox_YKien.innerHTML = '';
               	  });	 
                  $('#' + datagrid_id).datagrid('load');
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
        		if(    (link_vanban != '')  && ( $("#dlg_qlvanban_ykienchidao_them_Ten").val().length == 0
	 	        		 || $("#dlg_qlvanban_ykienchidao_them_NoiDung").val().length == 0	
	 	        		 || $("#dlg_qlvanban_ykienchidao_them_SoKiHieu").val().length == 0 
	 	        		   )){
	        		 onsubmenu_xoaanh(link_vanban,'uploadBtn_YKien','msgBox_YKien');
	 	        	  }  
            $(this).dialog("close");
          }
        },
        close: function () {
        	if(    (link_vanban != '')  && ( $("#dlg_qlvanban_ykienchidao_them_Ten").val().length == 0
	        		 || $("#dlg_qlvanban_ykienchidao_them_NoiDung").val().length == 0	
	        		 || $("#dlg_qlvanban_ykienchidao_them_SoKiHieu").val().length == 0 
	        		   )){
       		 onsubmenu_xoaanh(link_vanban,'uploadBtn_YKien','msgBox_YKien');
	        	  }  
        }
      });
    } catch (err) {
      alert("func_dlg_qlvanban_ykienchidao_show have dlg_qlvanban_ykienchidao_show " + err);
    }
    }
}
</script>

<form id="form_qlvanban_ykienchidao_them">
  <table>
   <tr>
      <td><b>Số kí hiệu: </b></td>
      <td><input name="dlg_qlvanban_ykienchidao_them_SoKiHieu" id="dlg_qlvanban_ykienchidao_them_SoKiHieu"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Ngày ban hành: </b></td>
      <td><input name="dlg_qlvanban_ykienchidao_them_NgayBanHanh" id="dlg_qlvanban_ykienchidao_them_NgayBanHanh"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Tên văn bản: </b></td>
      <td><input name="dlg_qlvanban_ykienchidao_them_Ten" id="dlg_qlvanban_ykienchidao_them_Ten"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Nội dung: </b></td>
      <td><textarea name="dlg_qlvanban_ykienchidao_them_NoiDung" id="dlg_qlvanban_ykienchidao_them_NoiDung"
                 row="20" cols="50" style="height:80px"></textarea></td>
    </tr>
    <tr>
      <td><b>File đính kèm: </b></td>
      <td>  
            <div class="col-xs-2">
              <button id="uploadBtn_YKien" class="btn btn-large btn-primary">Choose File</button>
            </div>
            <div class="col-xs-10">
          <div id="progressOuter_YKien" class="progress progress-striped active" style="display:none;">
            <div id="progressBar_YKien" class="progress-bar progress-bar-success"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
            </div>
          </div>
            </div>
            <div class="col-xs-10">
              <div id="msgBox_YKien">
              </div>
            </div>
      </td>
    </tr>
  </table>
</form>