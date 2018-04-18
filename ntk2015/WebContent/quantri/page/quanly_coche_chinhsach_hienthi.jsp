<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="540px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thể loại đề tài:</td>
			<td>&nbsp; <span id="spanCCCS_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Mã thuyết minh:</td>
			<td >&nbsp; <span id="spanCCCS_lblMaSoTM"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tổ chức:</td>
			<td >&nbsp; <span id="spanCCCS_lblToChuc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tên cơ chế:</td>
			<td >&nbsp; <span id="spanCCCS_lblTen"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nội dung:</td>
			<td >&nbsp; <span id="spanCCCS_lblNoiDung"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Mã số:</td>
			<td >&nbsp; <span id="spanCCCS_lblMaSo"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_coche_chinhsach_hienthi(id_coche_chinhsach){
		$.ajax({
             url: root_href +  HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_TO_EDIT_COCHE_CHINHSACH,
                 condition: 'id_coche_chinhsach =' + id_coche_chinhsach
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                
                 document.getElementById('spanCCCS_lblTheLoai').textContent = jsonObject.rows[0].tendt;
                 document.getElementById('spanCCCS_lblMaSoTM').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('spanCCCS_lblToChuc').textContent = jsonObject.rows[0]. tentc;
                 document.getElementById('spanCCCS_lblTen').textContent =  jsonObject.rows[0].ten_coche_chinhsach;
                 document.getElementById('spanCCCS_lblNoiDung').textContent = jsonObject.rows[0].noidung_coche_chinhsach ;
                 document.getElementById('spanCCCS_lblMaSo').textContent = jsonObject.rows[0].maso_coche_chinhsach ;
                 return;
             }});
		 
		 try{
		      $('#dlg_coche_chinhsach_hienthi_show').dialog({
		        title: "Thông tin cơ chế chính sách ",
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
		      alert("func_dlg_coche_chinhsach_hienthi have dlg_coche_chinhsach_hienthi_show " + err);
		    }
	}
</script>