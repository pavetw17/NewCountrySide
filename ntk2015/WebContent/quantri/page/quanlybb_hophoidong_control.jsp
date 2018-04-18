<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
  var link_vanban=''; 
  
  $(function() {
	  
	  $('form').submit(function(e){
		    e.preventDefault();
		  });
	  
	    $("#dlg_bb_hophoidong_them_ThuKy" ).combobox();
	    $("#dlg_bb_hophoidong_them_KiemPhieu01" ).combobox();
	    $("#dlg_bb_hophoidong_them_KiemPhieu02" ).combobox();
	    $("#dlg_bb_hophoidong_them_ToChuc" ).combobox();
	    $("#dlg_bb_hophoidong_them_ChuTich" ).combobox();
	    $("#dlg_bb_hophoidong_them_TruongBan" ).combobox();
	    $("#dlg_bb_hophoidong_them_TheLoai_Detai" ).combobox();

		var btn = document.getElementById('uploadBtn_HHD');
	
	    var uploader = new ss.SimpleUpload({
	        button: btn,
	        url: root_href + UPLOAD_SERVLET + 'action=' + CODE_UPLOAD,
	        name: 'uploadfile',
	        allowedExtensions: ['jpg', 'jpeg', 'png','doc','docx','xls','xlsx'],
	        data: {
	        	folder: FILE_BB_HOPHOIDONG
	        }, 
	        hoverClass: 'hover',
	        focusClass: 'focus',
	        maxSize: 1024, 
	        responseType: 'json',
	        
	        startXHR: function() {
	            progressOuter_HHD.style.display = 'block'; 
	            this.setProgressBar( progressBar_HHD );
	            $('#msgBox_HHD').show();
	        },
	        onSubmit: function() {
	            msgBox_HHD.innerHTML = ''; 
	            btn.innerHTML = 'Uploading...'; 
	        },
	        onChange: function( filename, extension, uploadBtn_HHD ){
	        	$('#msgBox_HHD').show();
	        },
	        onComplete: function( filename, response ) {  
	            btn.innerHTML = 'Choose Another File';
	            progressOuter_HHD.style.display = 'none'; 
	            
	            link_vanban = response.link_image;
	            
	            if ( !response ) {
	            	msgBox_HHD.innerHTML = 'Unable to upload file';
	                return;
	            }
	            
	            if ( response.success === true ) {
	            	msgBox_HHD.innerHTML = '<strong>' + escapeTags( filename ) + '</strong>' + ' successfully uploaded.'
	            	+ "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_HHD'+"\",\""+'msgBox_HHD'+"\"); return false;'><strong> Xóa ảnh</strong></a>";
	            	$('#uploadBtn_HHD').hide();
	            } else {
	                if ( response.msg )  {
	                    msgBox_HHD.innerHTML = escapeTags( response.msg );
	                } else {
	                    msgBox_HHD.innerHTML = 'An error occurred and the upload failed.';
	                }
	            }
	          },
	          onExtError: function( filename, extension ) {
	        	msgBox_HHD.innerHTML = 'Lỗi: Không đúng định dạng file';  
	          },
	          onSizeError: function( filename, fileSize ){
	        	msgBox_HHD.innerHTML = 'Lỗi: File phải nhỏ hơn 1 MB';
	          },
	          onError: function() {
	            progressOuter_HHD.style.display = 'none';
	            msgBox_HHD.innerHTML = 'onError: Unable to upload file';
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
  

  
   function func_dlg_add_bb_hophoidong(isEdit) {
    $('#form_bb_hophoidong_them').each(function () {
       this.reset();
    });

    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_DETAI_DUAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_bb_hophoidong_them_TheLoai_Detai');
    cwrs_Data2ComboBox(root_href + HOME_SERVLET, ACT_GET_TOCHUC_TO_CBB, null, TYPE_DATA_HTML_CBB,'null', 'dlg_bb_hophoidong_them_ToChuc');
   
    var cars = ["dlg_bb_hophoidong_them_ThuKy", "dlg_bb_hophoidong_them_KiemPhieu01", "dlg_bb_hophoidong_them_KiemPhieu02","dlg_bb_hophoidong_them_ChuTich","dlg_bb_hophoidong_them_TruongBan"];
    cwrs_Data2ComboBox_arrayElement(root_href + HOME_SERVLET, ACT_GET_CHUYENGIA_TO_CBB, null, TYPE_DATA_HTML_CBB,'null',cars);
    
    var row;
    var datagrid_id = 'dlg_bb_hophoidong_show_datagrid';
    var kiemtraRowNULL =true ;
    if (isEdit) {
      row = $('#' + datagrid_id).datagrid('getSelected');
       if(row != null){ 
    	  $.ajax({
    	        url: root_href + HOME_SERVLET ,
    	        data:{
    	          action: ACT_GET_DATA_TO_EDIT_BIENBAN_HOPHOIDONG,
    	          condition: 'id_detai =' + row.id_detai
    	        }, 
    	        async:false,
    	        success:function(jsonData) {
    	          var jsonObject = JSON.parse(jsonData);
    	          //document.getElementById('dlg_bb_hophoidong_them_TheLoai_Detai').value = jsonObject.rows[0].id_detai; //not use 
    	          $('#dlg_bb_hophoidong_them_TheLoai_Detai').combobox('autocomplete',jsonObject.rows[0].id_detai); 
    	          $('#dlg_bb_hophoidong_them_ThuKy').combobox('autocomplete',jsonObject.rows[0].id_thuki); 
    	          $('#dlg_bb_hophoidong_them_TruongBan').combobox('autocomplete',jsonObject.rows[0].id_truongbankiemphieu); 
    	          $('#dlg_bb_hophoidong_them_KiemPhieu01').combobox('autocomplete',jsonObject.rows[0].id_thanhvienkiemphieu01); 
    	          $('#dlg_bb_hophoidong_them_KiemPhieu02').combobox('autocomplete',jsonObject.rows[0].id_thanhvienkiemphieu02); 
    	          $('#dlg_bb_hophoidong_them_ToChuc').combobox('autocomplete',jsonObject.rows[0].id_tochuc_trungtuyen); 
    	          $('#dlg_bb_hophoidong_them_ChuTich').combobox('autocomplete',jsonObject.rows[0].id_chutich_hoidong); 
    	          document.getElementById('dlg_bb_hophoidong_them_QuyetDinh').value = jsonObject.rows[0].quyetdinh_thanhlap_hoidong;
    			  document.getElementById('dlg_bb_hophoidong_them_NgayRaQD').value =  gm.date.Int2DateString(jsonObject.rows[0].ngay_ra_quyetdinh);
				  document.getElementById("dlg_bb_hophoidong_them_DiaDiem").value= jsonObject.rows[0].diadiem;
    			  document.getElementById('dlg_bb_hophoidong_them_ThoiGian').value = gm.date.Int2DateString(jsonObject.rows[0].thoigian);
    			  document.getElementById('dlg_bb_hophoidong_them_TVCoMat').value = jsonObject.rows[0].sothanhvien_hoidong_comat;
    			  document.getElementById('dlg_bb_hophoidong_them_TongTV').value = jsonObject.rows[0].tongso_thanhvien_hoidong;
    			  document.getElementById('dlg_bb_hophoidong_them_NoiDung').value = jsonObject.rows[0].noidunglamviec;
    			  document.getElementById('dlg_bb_hophoidong_them_KetLuan').value = jsonObject.rows[0].ketluan;
    			  document.getElementById('dlg_bb_hophoidong_them_TenFile').value = jsonObject.rows[0].tenfile;
    			  link_vanban = jsonObject.rows[0].file_bienban;
    			  if(link_vanban != ''){
    				$('#uploadBtn_HHD').hide();
    			  	document.getElementById("msgBox_HHD").innerHTML= (link_vanban).split("/").pop() + "<a href='javascript:void(0)' onclick='onsubmenu_xoaanh(\""+link_vanban+"\",\""+'uploadBtn_HHD'+"\",\""+'msgBox_HHD'+"\"); return false;'><strong> Xóa ảnh</strong></a>";;
    	          }
    			  return;
    	        }}); 
       }else{
    	  kiemtraRowNULL = false;
    	 // document.getElementById('form_bb_hophoidong_them').style.display = 'none';
    	  $('#form_bb_hophoidong_them').hide();
    	  msgalert_autoclose('Thông báo','Chọn biên bản','error');
      } 
    }
     //alert(kiemtraNULL);
     if(kiemtraRowNULL){
	    try {
	      $('#dlg_bb_hophoidong_them').dialog({
	        title: "Cập nhật biên bản ",
	        open: function () {
	          $(this).dialog('widget').draggable('option', {containment: false});
	        },
	        height: 550,
	        width: 950,
	        collapsible: true,
	        draggable: true,
	        resizable: true,
	        position: [100, 100],
	        modal: true,
	        buttons: {
	          "Cập nhật": function () {
	            var id_detai = $('#dlg_bb_hophoidong_them_TheLoai_Detai').val();
	            var quyetdinh_thanhlap_hoidong = $('#dlg_bb_hophoidong_them_QuyetDinh').val();
	            var ngay_ra_quyetdinh = $('#dlg_bb_hophoidong_them_NgayRaQD').val();
	            var diadiem = $('#dlg_bb_hophoidong_them_DiaDiem').val();
	            var thoigian = $('#dlg_bb_hophoidong_them_ThoiGian').val();
	            var sothanhvien_hoidong_comat = $('#dlg_bb_hophoidong_them_TVCoMat').val();
	            var tongso_thanhvien_hoidong = $('#dlg_bb_hophoidong_them_TongTV').val();
	            var id_thuki = $('#dlg_bb_hophoidong_them_ThuKy').val();
	            var noidunglamviec = $('#dlg_bb_hophoidong_them_NoiDung').val();
	            var id_truongbankiemphieu = $('#dlg_bb_hophoidong_them_TruongBan').val();
	            var id_thanhvienkiemphieu01 = $('#dlg_bb_hophoidong_them_KiemPhieu01').val();
	            var id_thanhvienkiemphieu02 = $('#dlg_bb_hophoidong_them_KiemPhieu02').val();
	            var id_tochuc_trungtuyen = $('#dlg_bb_hophoidong_them_ToChuc').val();
	            var id_chutich_hoidong = $('#dlg_bb_hophoidong_them_ChuTich').val();
	            var tenfile = $('#dlg_bb_hophoidong_them_TenFile').val();
	            var ketluan = $('#dlg_bb_hophoidong_them_KetLuan').val();
	            
			    if ( kiemtrarong(quyetdinh_thanhlap_hoidong)  || kiemtrarong(noidunglamviec)  
			    		|| kiemtrarong(ngay_ra_quyetdinh) || kiemtrarong(diadiem)
			    	 || kiemtrarong(thoigian) || kiemtrarong(sothanhvien_hoidong_comat)
			    	 || kiemtrarong(tongso_thanhvien_hoidong) 
			    	 || kiemtrarong(tenfile) || kiemtrarong(ketluan) 
			    ){
	              msgalert_autoclose('Thông báo','Không được bỏ trống hoặc chưa chọn hoặc không đúng định dạng!','warning');
	              return;
	            }   
	            
	            var intRegex = /^\d+$/;
			    if(!intRegex.test(sothanhvien_hoidong_comat) || !intRegex.test(tongso_thanhvien_hoidong) || parseInt(sothanhvien_hoidong_comat) > parseInt(tongso_thanhvien_hoidong)  ){
			    	  msgalert_autoclose('Thông báo','Số nhập vào không đúng!','warning');
		              return;
			    }
			    
			    if( $('#msgBox_HHD').is(':hidden')){
			    	link_vanban =  '';
			    } 
	            
	            var utils = new Utils();
	            var	strSQL;
	            utils.clearFieldStorer();
	            utils.putfval_int('id_detai', id_detai);
	            utils.putfval_int('id_thuki', id_thuki);
	            utils.putfval_int('sothanhvien_hoidong_comat', sothanhvien_hoidong_comat);
	            utils.putfval_int('tongso_thanhvien_hoidong', tongso_thanhvien_hoidong);
	            utils.putfval_int('ngay_ra_quyetdinh', gm.date.stringDate2Int(ngay_ra_quyetdinh));
	            utils.putfval_int('id_tochuc_trungtuyen', id_tochuc_trungtuyen);
	            utils.putfval_int('id_thanhvienkiemphieu01', id_thanhvienkiemphieu01);
	            utils.putfval_int('id_thanhvienkiemphieu02', id_thanhvienkiemphieu02);
	            utils.putfval_int('id_chutich_hoidong', id_chutich_hoidong);
	            utils.putfval_int('id_truongbankiemphieu', id_truongbankiemphieu);
	            utils.putfval_string('quyetdinh_thanhlap_hoidong', trim(quyetdinh_thanhlap_hoidong));
	            utils.putfval_string('ketluan', trim(ketluan));
	            utils.putfval_string('tenfile', trim(tenfile));
	            utils.putfval_string('diadiem', trim(diadiem));
	            utils.putfval_string('noidunglamviec', trim(noidunglamviec));
	            utils.putfval_string('file_bienban', link_vanban); 
	            utils.putfval_int('thoigian',  gm.date.stringDate2Int(thoigian));
	            if (isEdit){
	              utils.putfval_int_condition('id_detai', row.id_detai);
	            }else{ 
                    $.ajax({
                        url: root_href + HOME_SERVLET ,
                        data:
                        {
                            action: ACT_DB_CHECK_DATA_EXISTS,
                            tableName:'tbl_bienban_hophoidong',
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
	            
	            strSQL = (!isEdit?utils.genInsertCmd_PreStatement('tbl_bienban_hophoidong'):utils.genUpdateCmd_PreStatement('tbl_bienban_hophoidong','id_detai=?'));
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
	               	  $('#form_bb_hophoidong_them').each(function () {
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
	        	  $('#uploadBtn_HHD').show();
		      	  $('#msgBox_HHD').hide();

	            }else {
	              msgalert_autoclose('Thông báo','Thao tác không thành công','error');//alert('insert/update multi object FAILED!');
	            }
	
	          },
	          "Đóng": function () {
	        	 if(   (link_vanban != '') && ( $("#dlg_bb_hophoidong_them_QuyetDinh").val().length == 0
	        		 || $("#dlg_bb_hophoidong_them_DiaDiem").val().length == 0	
	        		 || $("#dlg_bb_hophoidong_them_TVCoMat").val().length == 0	
	        		 || $("#dlg_bb_hophoidong_them_TongTV").val().length == 0 
	        		 || $("#dlg_bb_hophoidong_them_NoiDung").val().length == 0 
	        		 || $("#dlg_bb_hophoidong_them_TenFile").val().length == 0 
	        		 || $("#dlg_bb_hophoidong_them_KetLuan").val().length == 0 
	        		   )){
	        		 onsubmenu_xoaanh(link_vanban,'uploadBtn_HHD','msgBox_HHD');
	        	  }    
	            $(this).dialog("close");
	          }
	        },
	        close: function () {
	        	 if(   (link_vanban != '') && ( $("#dlg_bb_hophoidong_them_QuyetDinh").val().length == 0
		        		 || $("#dlg_bb_hophoidong_them_DiaDiem").val().length == 0	
		        		 || $("#dlg_bb_hophoidong_them_TVCoMat").val().length == 0	
		        		 || $("#dlg_bb_hophoidong_them_TongTV").val().length == 0 
		        		 || $("#dlg_bb_hophoidong_them_NoiDung").val().length == 0 
		        		 || $("#dlg_bb_hophoidong_them_TenFile").val().length == 0 
		        		 || $("#dlg_bb_hophoidong_them_KetLuan").val().length == 0   )){
	        		 	onsubmenu_xoaanh(link_vanban,'uploadBtn_HHD','msgBox_HHD');
		         } 
	        }
	      });
	    } catch (err) {
	      alert("func_dlg_bb_hophoidong_show have dlg_bb_hophoidong_show " + err);
	    }
   }
} 
</script>

<form id="form_bb_hophoidong_them">
  <table>
  <tr>
      <td><b>Đề tài: </b></td>
      <td><select name="dlg_bb_hophoidong_them_TheLoai_Detai" id="dlg_bb_hophoidong_them_TheLoai_Detai"></select></td>
    </tr>
   <tr>
      <td><b>Quyết định thành lập: </b></td>
      <td><input name="dlg_bb_hophoidong_them_QuyetDinh" id="dlg_bb_hophoidong_them_QuyetDinh"
                 type="text" size="25"></td>
    </tr>
    <tr>
      <td><b>Ngày ra quyết định: </b></td>
      <td><input name="dlg_bb_hophoidong_them_NgayRaQD" id="dlg_bb_hophoidong_them_NgayRaQD"
           class="datepicker"    type="text" size="25"></td>
    </tr>
    <tr>
     <td><b>Địa điểm: </b></td>
      <td><textarea name="dlg_bb_hophoidong_them_DiaDiem" id="dlg_bb_hophoidong_them_DiaDiem"
                 row="20" cols="100" style="width:400px"></textarea></td>
    </tr>
    <tr>
     <td><b>Thời gian: </b></td>
      <td><input name="dlg_bb_hophoidong_them_ThoiGian" id="dlg_bb_hophoidong_them_ThoiGian"
            class="datepicker"     type="text" size="25"></td>
    </tr>
     <tr>
     <td><b>Số thành viên có mặt: </b></td>
      <td><input name="dlg_bb_hophoidong_them_TVCoMat" id="dlg_bb_hophoidong_them_TVCoMat"
                 type="text" size="25"></textarea></td>
    </tr>
    <tr>
     <td><b>Tổng số thành viên: </b></td>
      <td><input name="dlg_bb_hophoidong_them_TongTV" id="dlg_bb_hophoidong_them_TongTV"
                 type="text" size="25"></textarea></td>
    </tr>
     <tr>
     <td><b>Nội dung làm việc: </b></td>
      <td><textarea name="dlg_bb_hophoidong_them_NoiDung" id="dlg_bb_hophoidong_them_NoiDung"
                 row="20" cols="100" style="width:400px"></textarea></td>
    </tr>
    <tr>
     <td><b>Thư ký: </b></td>
      <td><select  name="dlg_bb_hophoidong_them_ThuKy" id="dlg_bb_hophoidong_them_ThuKy"></select></textarea></td>
    </tr>
    <tr>
     <td><b>Trưởng ban kiểm phiếu: </b></td>
      <td><select name="dlg_bb_hophoidong_them_TruongBan" id="dlg_bb_hophoidong_them_TruongBan"></select></textarea></td>
    </tr>
    <tr>
     <td><b>Kiểm phiếu 01: </b></td>
      <td><select name="dlg_bb_hophoidong_them_KiemPhieu01" id="dlg_bb_hophoidong_them_KiemPhieu01"></select></textarea></td>
    </tr>
    <tr>
     <td><b>Kiểm phiếu 02: </b></td>
      <td><select name="dlg_bb_hophoidong_them_KiemPhieu02" id="dlg_bb_hophoidong_them_KiemPhieu02"></select></textarea></td>
    </tr>
    <tr>
     <td><b>Tổ chức trúng tuyển: </b></td>
      <td><select name="dlg_bb_hophoidong_them_ToChuc" id="dlg_bb_hophoidong_them_ToChuc"></select></textarea></td>
    </tr>
    <tr>
     <td><b>Chủ tịch hội đồng: </b></td>
      <td><select name="dlg_bb_hophoidong_them_ChuTich" id="dlg_bb_hophoidong_them_ChuTich"></select></textarea></td>
    </tr>
       <tr>
     <td><b>Tên file: </b></td>
      <td><input name="dlg_bb_hophoidong_them_TenFile" id="dlg_bb_hophoidong_them_TenFile"
                 type="text" size="25"></td>
    </tr>
      <tr>
      <td><b>File biên bản: </b></td>
      <td>  
            <div class="col-xs-2">
              <button id="uploadBtn_HHD" class="btn btn-large btn-primary">Choose File</button>
            </div>
            <div class="col-xs-10">
          <div id="progressOuter_HHD" class="progress progress-striped active" style="display:none;">
            <div id="progressBar_HHD" class="progress-bar progress-bar-success"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
            </div>
          </div>
            </div>
            <div class="col-xs-10">
              <div id="msgBox_HHD">
              </div>
            </div>
      </td>
    </tr>
    <tr>
      <td><b>Kết luận: </b></td>
      <td><textarea name="dlg_bb_hophoidong_them_KetLuan" id="dlg_bb_hophoidong_them_KetLuan"
                 row="20" cols="100" style="width:400px"></textarea></td>
    </tr>
  </table>
</form>