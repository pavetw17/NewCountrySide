<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="700px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Đề tài:</td>
			<td >&nbsp; <span id="spanDeTaiToChuc_lblDeTai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thuyết minh:</td>
			<td>&nbsp; <span id="spanDeTaiToChuc_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tổ chức:</td>
			<td >&nbsp; <span id="spanDeTaiToChuc_lblToChuc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Mã số đề tài:</td>
			<td >&nbsp; <span id="spanDeTaiToChuc_lblMaSoDeTai"></span>
			</td>
		</tr>
		
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_detai_tochuc_hienthi(id_detai,id_thuyetminhdetai,id_tochuc){
		$.ajax({
             url: root_href +  HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_DETAI_TOCHUC,
                 condition: 'a.id_detai=' + id_detai + ' and a.id_thuyetminhdetai=' + id_thuyetminhdetai + ' and a.id_tochuc=' + id_tochuc
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('spanDeTaiToChuc_lblDeTai').textContent = jsonObject.rows[0].tendt;
                 document.getElementById('spanDeTaiToChuc_lblToChuc').textContent = jsonObject.rows[0].tentc;
                 document.getElementById('spanDeTaiToChuc_lblTheLoai').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('spanDeTaiToChuc_lblMaSoDeTai').textContent =  jsonObject.rows[0].maso;
                 return;
             }});
		 
		 try{
		      $('#dlg_detai_tochuc_hienthi_show').dialog({
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
		      alert("func_dlg_detai_tochuc_hienthi have dlg_detai_tochuc_hienthi_show " + err);
		    }
	}
</script>