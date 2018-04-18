<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="700px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thể loại tin tức:</td>
			<td>&nbsp; <span id="spanTTHD_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tiêu đề:</td>
			<td >&nbsp; <span id="spanTTHD_lblTieuDe"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ngày tạo:</td>
			<td >&nbsp; <span id="spanTTHD_lblNgayTao"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tóm tắt:</td>
			<td >&nbsp; <span id="spanTTHD_lblTomTat"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nội dung:</td>
			<td >&nbsp; <span id="spanTTHD_lblNoiDung"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_tintuchoatdong_hienthi(id_tintuc){
		$.ajax({
             url: root_href +  HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_TINTUCHOATDONG,
                 condition: 'id_tintuc =' + id_tintuc
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                
                 document.getElementById('spanTTHD_lblTheLoai').textContent = jsonObject.rows[0].ten_phanloai;
                 document.getElementById('spanTTHD_lblTieuDe').textContent = jsonObject.rows[0].tieude;
                 document.getElementById('spanTTHD_lblNgayTao').textContent = gm.date.Int2DateString(jsonObject.rows[0].ngaytao);
                 document.getElementById('spanTTHD_lblTomTat').textContent =  jsonObject.rows[0].tomtat;
                 document.getElementById('spanTTHD_lblNoiDung').textContent = (jsonObject.rows[0].noidung).replace(/<\/?[^>]+>/gi, '') ;
                 return;
             }});
		 
		 try{
		      $('#dlg_tintuchoatdong_hienthi_show').dialog({
		        title: "Thông tin tin tức hoạt động ",
		        modal: true, open: function () {
		          $(this).dialog('widget').draggable('option', {containment: false});
		        },
		        height: 520,
		        width: 700,
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
		      alert("func_dlg_tintuchoatdong_hienthi have dlg_tintuchoatdong_hienthi_show " + err);
		    }
	}
</script>