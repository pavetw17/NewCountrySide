<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table style="border-spacing: inherit; border-collapse: collapse" border="1"
	width="540">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số hiệu:</td>
			<td>&nbsp; <span id="span_lblSoHieu"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tên văn bản:</td>
			<td >&nbsp; <span id="span_lblTenVanBan"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ngày ban hành:</td>
			<td >&nbsp; <span id="span_lblNgayBanHanh"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nội dung văn bản:</td>
			<td >&nbsp; <span id="span_lblNoiDung"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Loại văn bản:</td>
			<td >&nbsp; <span id="span_lblLoaiVanBan"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Download:</td>
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
	function func_dlg_qlvanban_phaply_hienthi(id_vanbanphaply){
		$.ajax({
             url: root_href + HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_TO_EDIT_DS_VANBANPHAPLY,
                 condition: 'id_vanbanphaply =' + id_vanbanphaply
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('span_lblSoHieu').textContent = jsonObject.rows[0].kihieuvanban;
                 document.getElementById('span_lblTenVanBan').textContent = jsonObject.rows[0].tenvanban;
                 document.getElementById('span_lblNgayBanHanh').textContent = jsonObject.rows[0].ngaybanhanh;
                 document.getElementById('span_lblNoiDung').textContent = jsonObject.rows[0].noidungvanban;
                 document.getElementById('span_lblLoaiVanBan').textContent =  jsonObject.rows[0].loai_vanbanphaply;
                 document.getElementById('span_download').textContent =  (jsonObject.rows[0].duongdanvanban).split("/").pop();
                 document.getElementById('a_download').href = contextPath + "/"+ jsonObject.rows[0].duongdanvanban;
                 return;
             }});
		 
		 try{
		      $('#dlg_qlvanban_phaply_hienthi_show').dialog({
		        title: "Thông tin văn bản pháp lý ",
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
		      alert("func_dlg_qlvanban_phaply_hienthi have dlg_qlvanban_phaply_hienthi_show " + err);
		    }
	}
</script>