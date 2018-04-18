<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table style="border-spacing: inherit; border-collapse: collapse" border="1"
	width="540">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Đề tài:</td>
			<td>&nbsp; <span id="span_dlg_bb_hophoidong_them_TheLoai_Detai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Quyết định thành lập:</td>
			<td >&nbsp; <span id="span_dlg_bb_hophoidong_them_QuyetDinh"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ngày ra quyết định:</td>
			<td >&nbsp; <span id="span_dlg_bb_hophoidong_them_NgayRaQD"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Địa điểm:</td>
			<td >&nbsp; <span id="span_dlg_bb_hophoidong_them_DiaDiem"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thời gian:</td>
			<td >&nbsp; <span id="span_dlg_bb_hophoidong_them_ThoiGian"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số thành viên có mặt:</td>
			<td >&nbsp; <span id="span_dlg_bb_hophoidong_them_TVCoMatn"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tổng số thành viên:</td>
			<td >&nbsp; <span id="span_dlg_bb_hophoidong_them_TongTV"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nội dung làm việc:</td>
			<td >&nbsp; <span id="span_dlg_bb_hophoidong_them_NoiDung"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thư ký:</td>
			<td >&nbsp; <span id="span_dlg_bb_hophoidong_them_ThuKy"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Trưởng ban kiểm phiếu:</td>
			<td >&nbsp; <span id="span_dlg_bb_hophoidong_them_TruongBan"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Kiểm phiếu 01:</td>
			<td >&nbsp; <span id="span_dlg_bb_hophoidong_them_KiemPhieu01"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Kiểm phiếu 02:</td>
			<td >&nbsp; <span id="span_dlg_bb_hophoidong_them_KiemPhieu02"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tổ chức trúng tuyển:</td>
			<td >&nbsp; <span id="span_dlg_bb_hophoidong_them_ToChuc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Chủ tịch hội đồng:</td>
			<td >&nbsp; <span id="span_dlg_bb_hophoidong_them_ChuTich"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tên file:</td>
			<td >&nbsp; <span id="span_dlg_bb_hophoidong_them_TenFile"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; File biên bản:</td>
			<td >&nbsp;
				<a	id="a_download"
					target="_blank"> <span id="span_download"></span>
				</a>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Kết luận:</td>
			<td >&nbsp; <span id="span_dlg_bb_hophoidong_them_KetLuan"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" language="javascript">
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_bb_hophoidong_hienthi(id_detai){
		$.ajax({
             url: root_href + HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_BIENBAN_HOPHOIDONG,
                 condition: 'a.id_detai =' + id_detai
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('span_dlg_bb_hophoidong_them_TheLoai_Detai').textContent = jsonObject.rows[0].tendt;
                 document.getElementById('span_dlg_bb_hophoidong_them_QuyetDinh').textContent = jsonObject.rows[0].quyetdinh_thanhlap_hoidong;
                 document.getElementById('span_dlg_bb_hophoidong_them_NgayRaQD').textContent = gm.date.Int2DateString(jsonObject.rows[0].ngay_ra_quyetdinh);
                 document.getElementById('span_dlg_bb_hophoidong_them_DiaDiem').textContent = jsonObject.rows[0].diadiem;
                 document.getElementById('span_dlg_bb_hophoidong_them_ThoiGian').textContent =  gm.date.Int2DateString(jsonObject.rows[0].thoigian);
                 document.getElementById('span_dlg_bb_hophoidong_them_TVCoMatn').textContent =  jsonObject.rows[0].sothanhvien_hoidong_comat;
                 document.getElementById('span_dlg_bb_hophoidong_them_TongTV').textContent =  jsonObject.rows[0].tongso_thanhvien_hoidong;
                 document.getElementById('span_dlg_bb_hophoidong_them_NoiDung').textContent =  jsonObject.rows[0].noidunglamviec;
                 document.getElementById('span_dlg_bb_hophoidong_them_ThuKy').textContent =  jsonObject.rows[0].ten_thuki;
                 document.getElementById('span_dlg_bb_hophoidong_them_TruongBan').textContent =  jsonObject.rows[0].ten_truongbankiemphieu;
                 document.getElementById('span_dlg_bb_hophoidong_them_KiemPhieu01').textContent =  jsonObject.rows[0].ten_thanhvienkiemphieu01;
                 document.getElementById('span_dlg_bb_hophoidong_them_KiemPhieu02').textContent =  jsonObject.rows[0].ten_thanhvienkiemphieu02;
                 document.getElementById('span_dlg_bb_hophoidong_them_ToChuc').textContent =  jsonObject.rows[0].tentc;
                 document.getElementById('span_dlg_bb_hophoidong_them_ChuTich').textContent =  jsonObject.rows[0].ten_chutich_hoidong;
                 document.getElementById('span_dlg_bb_hophoidong_them_TenFile').textContent =  jsonObject.rows[0].tenfile;
                 document.getElementById('span_dlg_bb_hophoidong_them_KetLuan').textContent =  jsonObject.rows[0].ketluan;
                 document.getElementById('span_download').textContent =  (jsonObject.rows[0].file_bienban).split("/").pop();
                 document.getElementById('a_download').href = contextPath + "/"+ jsonObject.rows[0].file_bienban;
                 return;
             }});
		 
		 try{
		      $('#dlg_bb_hophoidong_hienthi_show').dialog({
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
		      alert("func_dlg_bb_hophoidong_hienthi have dlg_bb_hophoidong_hienthi_show " + err);
		    }
	}
</script>