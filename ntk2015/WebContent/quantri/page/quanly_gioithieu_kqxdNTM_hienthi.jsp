<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="700px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Xã điểm:</td>
			<td>&nbsp; <span id="spanKQXDNTM_lblXaDiem"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tiêu đề:</td>
			<td >&nbsp; <span id="spanKQXDNTM_lblTieuDe"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tình trạng:</td>
			<td >&nbsp; <span id="spanKQXDNTM_lblTinhTrang"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ngày tạo:</td>
			<td >&nbsp; <span id="spanKQXDNTM_lblNgayTao"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tóm tắt:</td>
			<td >&nbsp; <span id="spanKQXDNTM_lblTomTat"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nội dung:</td>
			<td >&nbsp; <span id="spanKQXDNTM_lblNoiDung"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_gioithieu_kqxdNTM_hienthi(id_baiviet){
		$.ajax({
             url: root_href +  HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_GIOITHIEU_KQXDNTM,
                 condition: 'id_baiviet =' + id_baiviet
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('spanKQXDNTM_lblXaDiem').textContent =  jsonObject.rows[0].ten_xadiem;
                 document.getElementById('spanKQXDNTM_lblTinhTrang').textContent =  jsonObject.rows[0].tinhtrang;
                 document.getElementById('spanKQXDNTM_lblNgayTao').textContent =  gm.date.Int2DateString(jsonObject.rows[0].ngaycongbo);
                 document.getElementById('spanKQXDNTM_lblTieuDe').textContent = jsonObject.rows[0].tentieude ;
                 document.getElementById('spanKQXDNTM_lblTomTat').textContent =  jsonObject.rows[0].tomtatnoidung;
                 document.getElementById('spanKQXDNTM_lblNoiDung').textContent = (jsonObject.rows[0].noidungbv).replace(/<\/?[^>]+>/gi, '') ;
                 return;
             }});
		 
		 try{
		      $('#dlg_gioithieu_kqxdNTM_hienthi_show').dialog({
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
		      alert("func_dlg_gioithieu_kqxdNTM_hienthi have dlg_gioithieu_kqxdNTM_hienthi_show " + err);
		    }
	}
</script>