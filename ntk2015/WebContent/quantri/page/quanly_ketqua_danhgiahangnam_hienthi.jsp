<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="700px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tiêu chí:</td>
			<td >&nbsp; <span id="spanKQDanhGia_lblTieuChi"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Xã điểm:</td>
			<td>&nbsp; <span id="spanKQDanhGia_lblXaDiem"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tiến độ hoàn thành:</td>
			<td >&nbsp; <span id="spanKQDanhGia_lblTienDoHoanThanh"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ngày đánh giá:</td>
			<td >&nbsp; <span id="spanKQDanhGia_lblNgayDanhGia"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tiêu chí ứng dụng KHCN:</td>
			<td >&nbsp; <span id="spanKQDanhGia_lblTieuChiUngDung"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Đánh giá cho năm:</td>
			<td >&nbsp; <span id="spanKQDanhGia_lblDanhGia"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ghi chú:</td>
			<td >&nbsp; <span id="spanKQDanhGia_lblGhiChu"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_ketqua_danhgiahangnam_hienthi(id){
		$.ajax({
             url: root_href +  HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_KETQUA_DANHGIA_HANGNAM,
                 condition: 'id =' + id
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('spanKQDanhGia_lblXaDiem').textContent =  jsonObject.rows[0].ten_xadiem;
                 document.getElementById('spanKQDanhGia_lblTieuChi').textContent =  jsonObject.rows[0].ten_tieuchi;
                 document.getElementById('spanKQDanhGia_lblNgayDanhGia').textContent =  gm.date.Int2DateString(jsonObject.rows[0].ngay_danhgia);
                 document.getElementById('spanKQDanhGia_lblTienDoHoanThanh').textContent =  jsonObject.rows[0].tiendo_hoanthanh;
                 document.getElementById('spanKQDanhGia_lblTieuChiUngDung').textContent = jsonObject.rows[0].tieuchi_ungdung_khcn ;
                 document.getElementById('spanKQDanhGia_lblDanhGia').textContent =  gm.date.Int2DateString(jsonObject.rows[0].danhgiachonam);
                 document.getElementById('spanKQDanhGia_lblGhiChu').textContent = jsonObject.rows[0].ghichu ;
                 return;
             }});
		 
		 try{
		      $('#dlg_ketqua_danhgiahangnam_hienthi_show').dialog({
		        title: "Thông tin chi tiết ",
		        modal: true, open: function () {
		          $(this).dialog('widget').draggable('option', {containment: false});
		        },
		        height: 450,
		        width: 800,
		        collapsible: true,
		        draggable: true,
		        resizable: false,
		        position:[500,100],
		        buttons: {
		          "Đóng": function () {
		            $(this).dialog("close");
		          }
		        },
		        close: function () {
		        }
		      });
		    } catch (err) {
		      alert("func_dlg_ketqua_danhgiahangnam_hienthi have dlg_ketqua_danhgiahangnam_hienthi_show " + err);
		    }
	}
</script>