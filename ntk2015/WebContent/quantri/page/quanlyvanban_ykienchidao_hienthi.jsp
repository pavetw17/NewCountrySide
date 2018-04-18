<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="700px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số kí hiệu:</td>
			<td >&nbsp; <span id="spanYKienChiDao_lblKiHieu"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ngày ban hành:</td>
			<td>&nbsp; <span id="spanYKienChiDao_lblNgayBanHanh"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tên văn bản:</td>
			<td >&nbsp; <span id="spanYKienChiDao_lblTenVanBan"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nôi dung:</td>
			<td >&nbsp; <span id="spanYKienChiDao_lblNoiDung"></span>
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

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_qlvanban_ykienchidao_hienthi(id_ykienchidao){
		$.ajax({
             url: root_href +  HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_TO_EDIT_DS_YKIENCHIDAO,
                 condition: 'id_ykienchidao =' + id_ykienchidao
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('spanYKienChiDao_lblKiHieu').textContent =  jsonObject.rows[0].sokihieu;
                 document.getElementById('spanYKienChiDao_lblNgayBanHanh').textContent = jsonObject.rows[0].ngay_chidao_cohieuluc;
                 document.getElementById('spanYKienChiDao_lblTenVanBan').textContent =  jsonObject.rows[0].tieude;
                 document.getElementById('spanYKienChiDao_lblNoiDung').textContent = jsonObject.rows[0].noidungchidao ;
                 document.getElementById('span_download').textContent =  (jsonObject.rows[0].duongdanykienchidao).split("/").pop();
                 document.getElementById('a_download').href = contextPath + "/"+ jsonObject.rows[0].duongdanykienchidao;
                 return;
             }});
		 
		 try{
		      $('#dlg_qlvanban_ykienchidao_hienthi_show').dialog({
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
		      alert("func_dlg_qlvanban_ykienchidao_hienthi have dlg_qlvanban_ykienchidao_hienthi_show " + err);
		    }
	}
</script>