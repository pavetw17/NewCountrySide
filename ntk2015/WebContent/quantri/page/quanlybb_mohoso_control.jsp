<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
  var link_vanban=''; 
  
  $(function() {
 	  $('form').submit(function(e){
	    e.preventDefault();
	  });
	 
 	 $("#dlg_bb_mohoso_them_TheLoai_Detai" ).combobox();
 	 $('#dlg_bb_mohoso_them_TGKyBB').datepicker('disable').attr("readonly","readonly").timepicker();

	   	
		var btn = document.getElementById('uploadBtn_MHS');
	
	    var uploader = new ss.SimpleUpload({
	        button: btn,
	        url: root_href + UPLOAD_SERVLET + 'action=' + CODE_UPLOAD,
	        name: 'uploadfile',
	        allowedExtensions: ['jpg', 'jpeg', 'png','doc','docx','xls','xlsx'],
	        data: {
	        	folder: FILE_BB_MOHOSO
	        }, 
	        hoverClass: 'hover',
	        focusClass: 'focus',
	        maxSize: 1024, 
	        responseType: 'json',
	        
	        startXHR: function() {
	            progressOuter_MHS.style.display = 'block'; 
	            this.setProgressBar( progressBar_MHS );
	            $('#msgBox_MHS').show();
	        },
	        onSubmit: function() {
	            msgBox_MHS.innerHTML = ''; 
	            btn.innerHTML = 'Uploading...'; 
	        },
	        onChange: function( filename, extension, uploadBtn_MHS ){
	        	$('#msgBox_MHS').show();
	        },
	        onComplete: function( filename, response ) {  
	            btn.innerHTML = 'Choose Another File';
	            progressOuter_MHS.style.display = 'none'; 
	            
	            link_vanban = response.link_image;
	            
	            if ( !response ) {
	            	msgBox_MHS.innerHTML = 'Unable to upload file';
	                return;
	            }
	            
	            if ( response.success === true ) {
	            	msgBox_MHS.innerHTML = '<strong>' + escapeTags( filename ) + '</strong>' + ' successfully uploaded.'
	            	+ "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_MHS'+"\",\""+'msgBox_MHS'+"\"); return false;'><strong> Xóa ảnh</strong></a>";
	            	$('#uploadBtn_MHS').hide();
	            } else {
	                if ( response.msg )  {
	                    msgBox_MHS.innerHTML = escapeTags( response.msg );
	                } else {
	                    msgBox_MHS.innerHTML = 'An error occurred and the upload failed.';
	                }
	            }
	          },
	          onExtError: function( filename, extension ) {
	        	msgBox_MHS.innerHTML = 'Lỗi: Không đúng định dạng file';  
	          },
	          onSizeError: function( filename, fileSize ){
	        	msgBox_MHS.innerHTML = 'Lỗi: File phải nhỏ hơn 1 MB';
	          },
	          onError: function() {
	            progressOuter_MHS.style.display = 'none';
	            msgBox_MHS.innerHTML = 'onError: Unable to upload file';
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
  

  
   function func_dlg_add_bb_mohoso(isEdit) {
    $('#form_bb_mohoso_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DUAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_bb_mohoso_them_TheLoai_Detai');
   
    var row;
    var datagrid_id = 'dlg_bb_mohoso_show_datagrid';
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_BIENBAN_MOHOSO,
    	          condition: 'id_detai =' + row.id_detai
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          var jsonObject = JSON.parse(jsonData);
    	          //document.getElementById('dlg_bb_mohoso_them_TheLoai_Detai').value = jsonObject.rows[0].id_detai; //not use 
    	          $('#dlg_bb_mohoso_them_TheLoai_Detai').combobox('autocomplete',jsonObject.rows[0].id_detai); 
    	          document.getElementById('dlg_bb_mohoso_them_QuyetDinh').value = jsonObject.rows[0].qd_thanhlaphoidong;
    			  document.getElementById('dlg_bb_mohoso_them_NgayRaQD').value =  gm.date.Int2DateString(jsonObject.rows[0].ngay_ra_quyetdinh);
				  document.getElementById("dlg_bb_mohoso_them_DiaDiem").value= jsonObject.rows[0].diadiem;
    			  document.getElementById('dlg_bb_mohoso_them_TGMoHoSo').value = gm.date.Int2DateString(jsonObject.rows[0].thoigian_mohoso);
    			  document.getElementById('dlg_bb_mohoso_them_TongHS').value = jsonObject.rows[0].tongso_hoso;
    			  document.getElementById('dlg_bb_mohoso_them_SoHoSoHopLe').value = jsonObject.rows[0].so_hoso_hople;
    			  document.getElementById('dlg_bb_mohoso_them_TGKyBB').value = jsonObject.rows[0].thoigian_kibienban;
    			  document.getElementById('dlg_bb_mohoso_them_NgayKyBB').value = gm.date.Int2DateString(jsonObject.rows[0].ngay_kibienban);
    			  link_vanban = jsonObject.rows[0].duongdanhoso;
    			  if(link_vanban != ''){
    				$('#uploadBtn_MHS').hide();
    			  	document.getElementById("msgBox_MHS").innerHTML= (link_vanban).split("/").pop() + "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_MHS'+"\",\""+'msgBox_MHS'+"\"); return false;'><strong> Xóa ảnh</strong></a>";;
    	          }
    			  return;
    	        }}); 
       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_bb_mohoso_them').style.display = 'none';
    	  $('#form_bb_mohoso_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn biên bản','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_bb_mohoso_them').dialog({
	        title: "Cập nhật biên bản ",
	        open: function () {
	          $(this).dialog('widget').draggable('option', {containment: false});
	        },
	        height: 550,
	        width: 550,
	        collapsible: true,
	        draggable: true,
	        resizable: true,
	        position: [500, 100],
	        modal: true,
	        buttons: {
	          "Cập nhật": function () {
	            var id_detai = $('#dlg_bb_mohoso_them_TheLoai_Detai').val();
	            var qd_thanhlaphoidong = $('#dlg_bb_mohoso_them_QuyetDinh').val();
	            var ngay_ra_quyetdinh = $('#dlg_bb_mohoso_them_NgayRaQD').val();
	            var diadiem = $('#dlg_bb_mohoso_them_DiaDiem').val();
	            var thoigian_mohoso  = $('#dlg_bb_mohoso_them_TGMoHoSo').val();
	            var tongso_hoso = $('#dlg_bb_mohoso_them_TongHS').val();
	            var so_hoso_hople = $('#dlg_bb_mohoso_them_SoHoSoHopLe').val();
	            var thoigian_kibienban = $('#dlg_bb_mohoso_them_TGKyBB').val();
	            var ngay_kibienban = $('#dlg_bb_mohoso_them_NgayKyBB').val();
	            
			    if ( kiemtrarong(qd_thanhlaphoidong)  || kiemtrarong(ngay_kibienban)  
			    	 || kiemtrarong(ngay_ra_quyetdinh) || kiemtrarong(diadiem)
			    	 || kiemtrarong(thoigian_mohoso) || kiemtrarong(tongso_hoso)
			    	 || kiemtrarong(so_hoso_hople) 
			    	 || kiemtrarong(thoigian_kibienban) 
			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }   
	            
	            var intRegex = /^\d+$/;
			    if(!intRegex.test(tongso_hoso) || !intRegex.test(so_hoso_hople) || parseInt(tongso_hoso) < parseInt(so_hoso_hople)  ){
			    	  msgalert_autoclose('Thông báo','Số nhập vào không đúng!','warning');
		              return;
			    }
			    
			    if( $('#msgBox_MHS').is(':hidden')){
			    	link_vanban =  '';
			    } 
	            
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_int('id_detai', id_detai);
	            utils.putfval_time('thoigian_kibienban', thoigian_kibienban);
	            utils.putfval_int('tongso_hoso', tongso_hoso);
	            utils.putfval_int('so_hoso_hople', so_hoso_hople);
	            utils.putfval_int('ngay_ra_quyetdinh', gm.date.stringDate2Int(ngay_ra_quyetdinh));
	            utils.putfval_string('qd_thanhlaphoidong', trim(qd_thanhlaphoidong));
	            utils.putfval_string('duongdanhoso', link_vanban);
	            utils.putfval_string('diadiem', trim(diadiem));
	            utils.putfval_int('ngay_kibienban', gm.date.stringDate2Int(ngay_kibienban));
	            utils.putfval_int('thoigian_mohoso',  gm.date.stringDate2Int(thoigian_mohoso));
	            if (isEdit){
	              utils.putfval_int_condition('id_detai', row.id_detai);
	            }else{ 
                    $.ajax({
                        url: root_href + HOME_SERVLET ,
                        data:
                        {
                            action: ACT_DB_CHECK_DATA_EXISTS,
                            tableName:'tbl_bienban_mohoso',
                            fieldName:'id_detai' ,
                            condition: 'id_detai='+ id_detai
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
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_bienban_mohoso'):utils.genUpdateCmd_PreStatement('tbl_bienban_mohoso','id_detai=?'));
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
	               	  $('#form_bb_mohoso_them').each(function () {
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
	        	  $('#uploadBtn_MHS').show();
		      	  $('#msgBox_MHS').hide();

	            }else {
	              msgalert_autoclose('Thông báo','Thao tác không thành công','error');//alert('insert/update multi object FAILED!');
	            }
	
	          },
	          "Đóng": function () {
	        	 if(   (link_vanban != '') && ( $("#dlg_bb_mohoso_them_QuyetDinh").val().length == 0
	        		 || $("#dlg_bb_mohoso_them_DiaDiem").val().length == 0	
	        		 || $("#dlg_bb_mohoso_them_TongHS").val().length == 0	
	        		 || $("#dlg_bb_mohoso_them_SoHoSoHopLe").val().length == 0 
	        		   )){
	        		 onsubmenu_xoaanh(link_vanban,'uploadBtn_MHS','msgBox_MHS');
	        	  }    
	            $(this).dialog("close");
	          }
	        },
	        close: function () {
	        	if(   (link_vanban != '') && ( $("#dlg_bb_mohoso_them_QuyetDinh").val().length == 0
		        		 || $("#dlg_bb_mohoso_them_DiaDiem").val().length == 0	
		        		 || $("#dlg_bb_mohoso_them_TongHS").val().length == 0	
		        		 || $("#dlg_bb_mohoso_them_SoHoSoHopLe").val().length == 0 
		        		   )){
	        		 	onsubmenu_xoaanh(link_vanban,'uploadBtn_MHS','msgBox_MHS');
		         } 
	        }
	      });
	    } catch (err) {
	      alert("func_dlg_bb_mohoso_show have dlg_bb_mohoso_show " + err);
	    }
   }
} 
</script>

<form id="form_bb_mohoso_them">
  <table>
  <tr>
      <td><b>Đề tài: </b></td>
      <td><select name="dlg_bb_mohoso_them_TheLoai_Detai" id="dlg_bb_mohoso_them_TheLoai_Detai"></select></td>
    </tr>
   <tr>
      <td><b>Quyết định thành lập: </b></td>
      <td><input name="dlg_bb_mohoso_them_QuyetDinh" id="dlg_bb_mohoso_them_QuyetDinh"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Ngày ra quyết định: </b></td>
      <td><input name="dlg_bb_mohoso_them_NgayRaQD" id="dlg_bb_mohoso_them_NgayRaQD" class="datepicker"
                 type="text" size="25"></td>
    </tr>
    <tr>
     <td><b>Địa điểm: </b></td>
      <td><input name="dlg_bb_mohoso_them_DiaDiem" id="dlg_bb_mohoso_them_DiaDiem"
                 type="text" size="25"></td>
    </tr>
    <tr>
     <td><b>Thời gian mở hồ sơ: </b></td>
      <td><input name="dlg_bb_mohoso_them_TGMoHoSo" id="dlg_bb_mohoso_them_TGMoHoSo" class="datepicker"
                 type="text" size="25"></td>
    </tr>
     <tr>
     <td><b>Tổng số hồ sơ: </b></td>
      <td><input name="dlg_bb_mohoso_them_TongHS" id="dlg_bb_mohoso_them_TongHS"
                 type="text" size="25"></textarea></td>
    </tr>
    <tr>
     <td><b>Số hồ sơ hợp lệ: </b></td>
      <td><input name="dlg_bb_mohoso_them_SoHoSoHopLe" id="dlg_bb_mohoso_them_SoHoSoHopLe"
                 type="text" size="25"></textarea></td>
    </tr>
    <tr>
     <td><b>Thời gian ký biên bản: </b></td>
      <td><input name="dlg_bb_mohoso_them_TGKyBB" id="dlg_bb_mohoso_them_TGKyBB"
                 type="text" size="25"></textarea></td>
    </tr>
    <tr>
     <td><b>Ngày ký biên bản: </b></td>
       <td><input name="dlg_bb_mohoso_them_NgayKyBB" id="dlg_bb_mohoso_them_NgayKyBB" class="datepicker"
                 type="text" size="25"></textarea></td>
    </tr>
      <tr>
      <td><b>File biên bản: </b></td>
      <td>  
            <div class="col-xs-2">
              <button id="uploadBtn_MHS" class="btn btn-large btn-primary">Choose File</button>
            </div>
            <div class="col-xs-10">
          <div id="progressOuter_MHS" class="progress progress-striped active" style="display:none;">
            <div id="progressBar_MHS" class="progress-bar progress-bar-success"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
            </div>
          </div>
            </div>
            <div class="col-xs-10">
              <div id="msgBox_MHS">
              </div>
            </div>
      </td>
    </tr>
  </table>
</form>