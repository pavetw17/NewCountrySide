<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="700px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Đề tài:</td>
			<td >&nbsp; <span id="spanToChucThamGia_lblDeTai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thuyết minh:</td>
			<td>&nbsp; <span id="spanToChucThamGia_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tổ chức:</td>
			<td >&nbsp; <span id="spanToChucThamGia_lblToChuc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Phân loại kết quả:</td>
			<td >&nbsp; <span id="spanToChucThamGia_lblPhanLoaiKQ"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Vai trò:</td>
			<td >&nbsp; <span id="spanToChucThamGia_lblVaiTro"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số cán bộ đại học:</td>
			<td >&nbsp; <span id="spanToChucThamGia_lblDaiHoc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số cán bộ thạc sĩ:</td>
			<td >&nbsp; <span id="spanToChucThamGia_lblThacSi"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số cán bộ tiến sĩ:</td>
			<td >&nbsp; <span id="spanToChucThamGia_lblTienSi"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nhà xưởng:</td>
			<td >&nbsp; <span id="spanToChucThamGia_lblNhaXuong"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Trang thiết bị:</td>
			<td >&nbsp; <span id="spanToChucThamGia_lblTrangThietBi"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Kinh nghiệm:</td>
			<td >&nbsp; <span id="spanToChucThamGia_lblKinhnghiem"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_tochuc_thamgia_hienthi(id_tochuc_thamgia_detai){
		$.ajax({
             url: root_href +  HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_TOCHUC_THAMGIA,
                 condition: 'id_tochuc_thamgia_detai=' + id_tochuc_thamgia_detai
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('spanToChucThamGia_lblDeTai').textContent =  jsonObject.rows[0].tendt;
                 document.getElementById('spanToChucThamGia_lblTheLoai').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('spanToChucThamGia_lblToChuc').textContent = jsonObject.rows[0].tentc;
                 document.getElementById('spanToChucThamGia_lblPhanLoaiKQ').textContent = jsonObject.rows[0].ten_phanloai;
                 document.getElementById('spanToChucThamGia_lblVaiTro').textContent =  jsonObject.rows[0].ten_vaitro;
                 document.getElementById('spanToChucThamGia_lblDaiHoc').textContent =  jsonObject.rows[0].so_canbo_dh_thamgia;
                 document.getElementById('spanToChucThamGia_lblThacSi').textContent =  jsonObject.rows[0].so_canbo_ths_thamgia;
                 document.getElementById('spanToChucThamGia_lblTienSi').textContent =  jsonObject.rows[0].so_canbo_ts_thamgia;
                 document.getElementById('spanToChucThamGia_lblNhaXuong').textContent =  jsonObject.rows[0].nha_xuong;
                 document.getElementById('spanToChucThamGia_lblTrangThietBi').textContent =  jsonObject.rows[0].trangthietbi;
                 document.getElementById('spanToChucThamGia_lblKinhnghiem').textContent =  jsonObject.rows[0].kinhnghiem_thanhtuu_khcn;
                 return;
             }});
		 
		 try{
		      $('#dlg_tochuc_thamgia_hienthi_show').dialog({
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
		      alert("func_dlg_tochuc_thamgia_hienthi have dlg_tochuc_thamgia_hienthi_show " + err);
		    }
	}
</script>