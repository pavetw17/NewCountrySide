<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="700px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thuyết minh:</td>
			<td>&nbsp; <span id="spanNhanSuThamGia_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tổ chức:</td>
			<td >&nbsp; <span id="spanNhanSuThamGia_lblToChuc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nhân sự:</td>
			<td >&nbsp; <span id="spanNhanSuThamGia_lblNhanSu"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Vai trò:</td>
			<td >&nbsp; <span id="spanNhanSuThamGia_lblVaiTro"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nội dung tham gia:</td>
			<td >&nbsp; <span id="spanNhanSuThamGia_lblNoiDungThamGia"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số tháng tham gia:</td>
			<td >&nbsp; <span id="spanNhanSuThamGia_lblSoThangThamGia"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_nhansu_thamgia_hienthi(id_nhansu_detai){
		$.ajax({
             url: root_href +  HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_NHANSU_THAMGIA,
                 condition: 'id_nhansu_detai=' + id_nhansu_detai
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('spanNhanSuThamGia_lblTheLoai').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('spanNhanSuThamGia_lblToChuc').textContent = jsonObject.rows[0].tentc;
                 document.getElementById('spanNhanSuThamGia_lblNhanSu').textContent = jsonObject.rows[0].hoten;
                 document.getElementById('spanNhanSuThamGia_lblVaiTro').textContent =  jsonObject.rows[0].ten_vaitro;
                 document.getElementById('spanNhanSuThamGia_lblNoiDungThamGia').textContent =  jsonObject.rows[0].noidungthamgia;
                 document.getElementById('spanNhanSuThamGia_lblSoThangThamGia').textContent =  jsonObject.rows[0].sothangthamgia;
                 return;
             }});
		 
		 try{
		      $('#dlg_nhansu_thamgia_hienthi_show').dialog({
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
		      alert("func_dlg_nhansu_thamgia_hienthi have dlg_nhansu_thamgia_hienthi_show " + err);
		    }
	}
</script>