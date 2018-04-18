<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="700px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Đề tài:</td>
			<td >&nbsp; <span id="spanKHCapKinhPhi_lblDeTai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thuyết minh:</td>
			<td>&nbsp; <span id="spanKHCapKinhPhi_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tổ chức:</td>
			<td >&nbsp; <span id="spanKHCapKinhPhi_lblToChuc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ngày dự kiến:</td>
			<td >&nbsp; <span id="spanKHCapKinhPhi_lblNgayDuKien"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số tiền:</td>
			<td >&nbsp; <span id="spanKHCapKinhPhi_lblSoTien"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ghi chú:</td>
			<td >&nbsp; <span id="spanKHCapKinhPhi_lblGhiChu"></span>
			</td>
		</tr>
		
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_kehoach_capkinhphi_hienthi(id_kh_capkinhphi){
		$.ajax({
             url: root_href +  HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_KH_CAPKINHPHI,
                 condition: 'id_kh_capkinhphi=' + id_kh_capkinhphi 
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('spanKHCapKinhPhi_lblDeTai').textContent = jsonObject.rows[0].tendt;
                 document.getElementById('spanKHCapKinhPhi_lblToChuc').textContent = jsonObject.rows[0].tentc;
                 document.getElementById('spanKHCapKinhPhi_lblTheLoai').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('spanKHCapKinhPhi_lblNgayDuKien').textContent =  gm.date.Int2DateString(jsonObject.rows[0].ngaydukiencap);
                 document.getElementById('spanKHCapKinhPhi_lblSoTien').textContent =  jsonObject.rows[0].sotien;
                 document.getElementById('spanKHCapKinhPhi_lblGhiChu').textContent =  jsonObject.rows[0].ghichu;
                 return;
             }});
		 
		 try{
		      $('#dlg_kehoach_capkinhphi_hienthi_show').dialog({
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
		      alert("func_dlg_kehoach_capkinhphi_hienthi have dlg_kehoach_capkinhphi_hienthi_show " + err);
		    }
	}
</script>