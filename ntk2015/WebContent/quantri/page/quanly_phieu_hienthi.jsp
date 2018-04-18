<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="540px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Loại phiếu:</td>
			<td>&nbsp; <span id="spanQLP_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Kiến nghị:</td>
			<td >&nbsp; <span id="spanQLP_lblKienNghi"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thuyết minh đề tài:</td>
			<td >&nbsp; <span id="spanQLP_lblTMDT"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Chuyên gia:</td>
			<td >&nbsp; <span id="spanQLP_lblChuyenGia"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Vị trí:</td>
			<td >&nbsp; <span id="spanQLP_lblViTri"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Điểm đánh giá:</td>
			<td >&nbsp; <span id="spanQLP_lblDiemDG"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Giải thích kiển nghị:</td>
			<td >&nbsp; <span id="spanQLP_lblGiaiThich"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tên phiếu:</td>
			<td >&nbsp; <span id="spanQLP_lblTenPhieu"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; File:</td>
			<td >&nbsp;
				<a	id="a_download"
					target="_blank"> <span id="spanQLP_download"></span>
				</a>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_phieu_hienthi(id_phieu){
		$.ajax({
             url: root_href +  HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_PHIEU,
                 condition: 'id_phieu =' + id_phieu
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('spanQLP_lblTheLoai').textContent = jsonObject.rows[0].ten_phanloai_phieu;
                 document.getElementById('spanQLP_lblKienNghi').textContent = jsonObject.rows[0].tenkiennghi;
                 document.getElementById('spanQLP_lblTMDT').textContent = jsonObject.rows[0]. masodt;
                 document.getElementById('spanQLP_lblChuyenGia').textContent = jsonObject.rows[0].hoten ;
                 document.getElementById('spanQLP_lblViTri').textContent = jsonObject.rows[0].vitri ;
                 document.getElementById('spanQLP_lblDiemDG').textContent = jsonObject.rows[0].diemdanhgia_tonghop ;
                 document.getElementById('spanQLP_lblGiaiThich').textContent = jsonObject.rows[0].giaithich_kiennghi ;
                 document.getElementById('spanQLP_lblTenPhieu').textContent = jsonObject.rows[0].tenphieu ;
                 document.getElementById('spanQLP_download').textContent =  (jsonObject.rows[0].noidung_phieu).split("/").pop();
                 document.getElementById('a_download').href = contextPath + "/"+ jsonObject.rows[0].noidung_phieu;
                 return;
             }});
		 
		 try{
		      $('#dlg_phieu_hienthi_show').dialog({
		        title: "Thông tin phiếu ",
		        modal: true, open: function () {
		          $(this).dialog('widget').draggable('option', {containment: false});
		        },
		        height: 480,
		        width: 580,
		        collapsible: true,
		        draggable: true,
		        resizable: false,
		        position:[400,300],
		        buttons: {
		          "Đóng": function () {
		            $(this).dialog("close");
		          }
		        },
		        close: function () {
		        }
		      });
		    } catch (err) {
		      alert("func_dlg_phieu_hienthi have dlg_phanvon_hangmuc_hienthi_show " + err);
		    }
	}
</script>