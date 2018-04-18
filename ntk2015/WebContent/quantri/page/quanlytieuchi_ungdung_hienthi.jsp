<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="700px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tiêu chí:</td>
			<td >&nbsp; <span id="spanTieuChiUD_lblTieuChi"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thuyết minh:</td>
			<td>&nbsp; <span id="spanTieuChiUD_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Xã điểm:</td>
			<td >&nbsp; <span id="spanTieuChiUD_lblXaDiem"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_tieuchi_ungdung_hienthi(id_tieuchi,id_thuyetminh_detai,id_xadiem){
		$.ajax({
             url: root_href +  HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_TIEUCHI_DETAI_DUAN,
                 condition: 'a.id_tieuchi =' + id_tieuchi + " and a.id_xadiem=" + id_xadiem + " and a.id_thuyetminh_detai=" + id_thuyetminh_detai,
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('spanTieuChiUD_lblTieuChi').textContent =  jsonObject.rows[0].ten_tieuchi;
                 document.getElementById('spanTieuChiUD_lblTheLoai').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('spanTieuChiUD_lblXaDiem').textContent =  jsonObject.rows[0].ten_xadiem;
                 return;
             }});
		 
		 try{
		      $('#dlg_tieuchi_ungdung_hienthi_show').dialog({
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
		      alert("func_dlg_tieuchi_ungdung_hienthi have dlg_tieuchi_ungdung_hienthi_show " + err);
		    }
	}
</script>