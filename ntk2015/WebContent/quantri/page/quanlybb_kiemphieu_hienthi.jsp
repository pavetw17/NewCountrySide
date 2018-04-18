<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table style="border-spacing: inherit; border-collapse: collapse" border="1"
	width="540">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Đề tài:</td>
			<td>&nbsp; <span id="span_dlg_bb_kiemphieu_them_TheLoai_Detai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số phiều phát ra:</td>
			<td >&nbsp; <span id="span_dlg_bb_kiemphieu_them_SoPhieuPhatRa"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số phiều thu về:</td>
			<td >&nbsp; <span id="span_dlg_bb_kiemphieu_them_SoPhieuThuVe"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số phiều hợp lệ:</td>
			<td >&nbsp; <span id="span_dlg_bb_kiemphieu_them_SoPhieuHopLe"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số phiếu không hợp lệ:</td>
			<td >&nbsp; <span id="span_dlg_bb_kiemphieu_them_SoPhieuKhongHopLe"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ngày:</td>
			<td >&nbsp; <span id="span_dlg_bb_kiemphieu_them_Ngay"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Điểm trung bình: </td>
			<td >&nbsp; <span id="span_dlg_bb_kiemphieu_them_DTB"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tên File: </td>
			<td >&nbsp; <span id="span_dlg_bb_kiemphieu_them_TenFileB"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; File biên bản:</td>
			<td >&nbsp;
				<a	id="a_download"
					target="_blank"> <span id="span_download"></span>
				</a>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" language="javascript">
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_bb_kiemphieu_hienthi(id_thuyetminh_detai){
		$.ajax({
             url: root_href + HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_BIENBAN_KIEMPHIEU,
                 condition: 'a.id_thuyetminh_detai =' + id_thuyetminh_detai
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('span_dlg_bb_kiemphieu_them_TheLoai_Detai').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('span_dlg_bb_kiemphieu_them_SoPhieuPhatRa').textContent = jsonObject.rows[0].sophieu_phatra;
                 document.getElementById('span_dlg_bb_kiemphieu_them_SoPhieuThuVe').textContent = jsonObject.rows[0].sophieu_thuve;
                 document.getElementById('span_dlg_bb_kiemphieu_them_SoPhieuHopLe').textContent = jsonObject.rows[0].sophieu_hople;
                 document.getElementById('span_dlg_bb_kiemphieu_them_SoPhieuKhongHopLe').textContent = jsonObject.rows[0].sophieu_khonghople;
                 document.getElementById('span_dlg_bb_kiemphieu_them_TenFileB').textContent =  jsonObject.rows[0].tenfile;
                 document.getElementById('span_dlg_bb_kiemphieu_them_DTB').textContent =  jsonObject.rows[0].diemtb;
                 document.getElementById('span_dlg_bb_kiemphieu_them_Ngay').textContent =  gm.date.Int2DateString(jsonObject.rows[0].ngay);
                 document.getElementById('span_download').textContent =  (jsonObject.rows[0].file_bienban).split("/").pop();
                 document.getElementById('a_download').href = contextPath + "/"+ jsonObject.rows[0].file_bienban;
                 return;
             }});
		 
		 try{
		      $('#dlg_bb_kiemphieu_hienthi_show').dialog({
		        title: "Thông tin biên bản ",
		        modal: true, open: function () {
		          $(this).dialog('widget').draggable('option', {containment: false});
		        },
		        height: 480,
		        width: 580,
		        collapsible: true,
		        draggable: true,
		        resizable: false,
		        position:[530,100],
		        buttons: {
		          "Đóng": function () {
		            $(this).dialog("close");
		          }
		        },
		        close: function () {
		        }
		      });
		    } catch (err) {
		      alert("func_dlg_bb_kiemphieu_hienthi have dlg_bb_kiemphieu_hienthi_show " + err);
		    }
	}
</script>