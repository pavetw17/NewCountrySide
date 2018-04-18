<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="700px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Đề tài:</td>
			<td>&nbsp; <span id="spanKQNCDTDA_lblDeTai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thuyết minh đề tài:</td>
			<td >&nbsp; <span id="spanKQNCDTDA_lblThuyetMinh"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tổ chức:</td>
			<td >&nbsp; <span id="spanKQNCDTDA_lblToChuc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Xã điểm:</td>
			<td >&nbsp; <span id="spanKQNCDTDA_lblXaDiem"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tình trạng:</td>
			<td >&nbsp; <span id="spanKQNCDTDA_lblTinhTrang"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tiêu đề:</td>
			<td >&nbsp; <span id="spanKQNCDTDA_lblTieuDe"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ngày tạo:</td>
			<td >&nbsp; <span id="spanKQNCDTDA_lblNgayTao"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tóm tắt:</td>
			<td >&nbsp; <span id="spanKQNCDTDA_lblTomTat"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nội dung:</td>
			<td >&nbsp; <span id="spanKQNCDTDA_lblNoiDung"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_gioithieu_kqncDTDA_hienthi(id_baiviet){
		$.ajax({
             url: root_href +  HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_GIOITHIEU_KQNCDTDA,
                 condition: 'id_baiviet =' + id_baiviet
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                
                 document.getElementById('spanKQNCDTDA_lblDeTai').textContent = jsonObject.rows[0].tendt;
                 document.getElementById('spanKQNCDTDA_lblThuyetMinh').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('spanKQNCDTDA_lblToChuc').textContent = jsonObject.rows[0].tentc;
                 document.getElementById('spanKQNCDTDA_lblXaDiem').textContent =  jsonObject.rows[0].ten_xadiem;
                 document.getElementById('spanKQNCDTDA_lblTinhTrang').textContent =  jsonObject.rows[0].tinhtrang;
                 document.getElementById('spanKQNCDTDA_lblNgayTao').textContent =  gm.date.Int2DateString(jsonObject.rows[0].ngaycongbo);
                 document.getElementById('spanKQNCDTDA_lblTieuDe').textContent = jsonObject.rows[0].tentieude ;
                 document.getElementById('spanKQNCDTDA_lblTomTat').textContent =  jsonObject.rows[0].tomtatnoidung;
                 document.getElementById('spanKQNCDTDA_lblNoiDung').textContent = (jsonObject.rows[0].noidungbv).replace(/<\/?[^>]+>/gi, '') ;
                 return;
             }});
		 
		 try{
		      $('#dlg_gioithieu_kqncDTDA_hienthi_show').dialog({
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
		      alert("func_dlg_gioithieu_kqncDTDA_hienthi have dlg_gioithieu_kqncDTDA_hienthi_show " + err);
		    }
	}
</script>