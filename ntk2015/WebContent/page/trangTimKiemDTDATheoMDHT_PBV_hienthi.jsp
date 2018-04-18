<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="540px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thể loại đề tài:</td>
			<td>&nbsp; <span id="spanPBV_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Mã thuyết minh:</td>
			<td >&nbsp; <span id="spanPBV_lblQuyTrinhTM"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tổ chức:</td>
			<td >&nbsp; <span id="spanPBV_lblToChuc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nội dung:</td>
			<td >&nbsp; <span id="spanPBV_lblNoiDung"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_phanbovon_hienthi(id_tieuchi){
		$.ajax({
             url: HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_TO_EDIT_PHANBOVON_THEOHANGMUC,
                 condition: 'id_tieuchi =' + id_tieuchi
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('spanPBV_lblTheLoai').textContent = jsonObject.rows[0].tendt;
                 document.getElementById('spanPBV_lblQuyTrinhTM').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('spanPBV_lblToChuc').textContent = jsonObject.rows[0]. tentc;
                 document.getElementById('spanPBV_lblNoiDung').textContent = jsonObject.rows[0].noidung_tieuchi ;
                 return;
             }});
		 
		 try{
		      $('#dlg_timkiem_dtda_sp_hienthi_show').dialog({
		        title: "Thông tin phân bổ vốn ",
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
		      alert("func_dlg_phanbovon_hienthi have dlg_timkiem_dtda_sp_hienthi_show " + err);
		    }
	}
</script>