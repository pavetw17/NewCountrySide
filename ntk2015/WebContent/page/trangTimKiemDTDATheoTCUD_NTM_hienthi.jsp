<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="540px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thể loại:</td>
			<td>&nbsp; <span id="spanTCUD_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Mã thuyết minh:</td>
			<td >&nbsp; <span id="spanTCUD_lblMaSoDT"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tên tiêu chí:</td>
			<td >&nbsp; <span id="spanTCUD_lblTenTC"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tên xã điểm:</td>
			<td >&nbsp; <span id="spanTCUD_lblTenXaDiem"></span>
			</td>
		</tr>
		
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_timkiem_tcud_NTM_hienthi(id_tieuchi,id_thuyetminh_detai,id_xadiem){
		$.ajax({
             url:  HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_TO_EDIT_DTDA_THEO_TIEUCHIUNGDUNG_NTM,
                 condition: 'a.id_tieuchi =' + id_tieuchi + " and a.id_thuyetminh_detai=" + id_thuyetminh_detai + " and a.id_xadiem="+ id_xadiem,
                 IdTieuchi: id_tieuchi
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                
                 document.getElementById('spanTCUD_lblTheLoai').textContent = jsonObject.rows[0].ten_tieuchi_cha;
                 document.getElementById('spanTCUD_lblMaSoDT').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('spanTCUD_lblTenTC').textContent = jsonObject.rows[0].ten_tieuchi;
                 document.getElementById('spanTCUD_lblTenXaDiem').textContent =  jsonObject.rows[0].ten_xadiem;
                 return;
             }});
		 
		 try{
		      $('#dlg_timkiem_dtda_sp_hienthi_show').dialog({
		        title: "Thông tin tiêu chí ",
		        modal: true, open: function () {
		          $(this).dialog('widget').draggable('option', {containment: false});
		        },
		        height: 480,
		        width: 580,
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
		      alert("func_dlg_qlvanban_phaply_hienthi have dlg_qlvanban_phaply_hienthi_show " + err);
		    }
	}
</script>