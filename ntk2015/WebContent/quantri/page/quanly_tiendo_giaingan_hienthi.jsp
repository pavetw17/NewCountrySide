<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="540px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Đề tài:</td>
			<td>&nbsp; <span id="spanTDGiaiNgan_lblDeTai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Mã thuyết minh:</td>
			<td >&nbsp; <span id="spanTDGiaiNgan_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tổ chức:</td>
			<td >&nbsp; <span id="spanTDGiaiNgan_lblToChuc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nội dung:</td>
			<td >&nbsp; <span id="spanTDGiaiNgan_lblNoiDung"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ngày cấp:</td>
			<td >&nbsp; <span id="spanTDGiaiNgan_lblNgayDuKien"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số tiền:</td>
			<td >&nbsp; <span id="spanTDGiaiNgan_lblSoTien"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ghi chú:</td>
			<td >&nbsp; <span id="spanTDGiaiNgan_lblGhiChu"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_tiendo_giaingan_hienthi(id_tiendogiaingan){
		$.ajax({
             url: root_href +   HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_TIENDO_GIAINGAN,
                 condition: 'id_tiendogiaingan =' + id_tiendogiaingan
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('spanTDGiaiNgan_lblDeTai').textContent = jsonObject.rows[0].tendt;
                 document.getElementById('spanTDGiaiNgan_lblTheLoai').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('spanTDGiaiNgan_lblToChuc').textContent = jsonObject.rows[0]. tentc;
                 document.getElementById('spanTDGiaiNgan_lblNgayDuKien').textContent =  gm.date.Int2DateString(jsonObject.rows[0].ngaygiaingan);
                 document.getElementById('spanTDGiaiNgan_lblNoiDung').textContent =  jsonObject.rows[0].ten_noidung;
                 document.getElementById('spanTDGiaiNgan_lblSoTien').textContent =  jsonObject.rows[0].sotien;
                 document.getElementById('spanTDGiaiNgan_lblGhiChu').textContent =  jsonObject.rows[0].ghichu;
                 return;
             }});
		 
		 try{
		      $('#dlg_tiendo_giaingan_hienthi_show').dialog({
		        title: "Thông tin chi tiết ",
		        modal: true, open: function () {
		          $(this).dialog('widget').draggable('option', {containment: false});
		        },
		        height: 480,
		        width: 580,
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
		      alert("func_dlg_tiendo_giaingan_hienthi have dlg_tiendo_giaingan_hienthi_show " + err);
		    }
	}
</script>