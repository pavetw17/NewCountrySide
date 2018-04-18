<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="540px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Đề tài:</td>
			<td>&nbsp; <span id="spanTDCapKinhPhi_lblDeTai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Mã thuyết minh:</td>
			<td >&nbsp; <span id="spanTDCapKinhPhi_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tổ chức:</td>
			<td >&nbsp; <span id="spanTDCapKinhPhi_lblToChuc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ngày dự kiến:</td>
			<td >&nbsp; <span id="spanTDCapKinhPhi_lblNgayDuKien"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số tiền:</td>
			<td >&nbsp; <span id="spanTDCapKinhPhi_lblSoTien"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ghi chú:</td>
			<td >&nbsp; <span id="spanTDCapKinhPhi_lblGhiChu"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_tiendo_capkinhphi_hienthi(id_tiendo_capkinhphi){
		$.ajax({
             url: root_href +   HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_TD_CAPKINHPHI,
                 condition: 'id_tiendo_capkinhphi =' + id_tiendo_capkinhphi
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('spanTDCapKinhPhi_lblDeTai').textContent = jsonObject.rows[0].tendt;
                 document.getElementById('spanTDCapKinhPhi_lblTheLoai').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('spanTDCapKinhPhi_lblToChuc').textContent = jsonObject.rows[0]. tentc;
                 document.getElementById('spanTDCapKinhPhi_lblNgayDuKien').textContent =  gm.date.Int2DateString(jsonObject.rows[0].ngaycap);
                 document.getElementById('spanTDCapKinhPhi_lblSoTien').textContent =  jsonObject.rows[0].sotien;
                 document.getElementById('spanTDCapKinhPhi_lblGhiChu').textContent =  jsonObject.rows[0].ghichu;
                 return;
             }});
		 
		 try{
		      $('#dlg_tiendo_capkinhphi_hienthi_show').dialog({
		        title: "Thông tin chi tiết ",
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
		      alert("func_dlg_tiendo_capkinhphi_hienthi have dlg_tiendo_capkinhphi_hienthi_show " + err);
		    }
	}
</script>