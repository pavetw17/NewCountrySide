<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="540px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Đề tài:</td>
			<td>&nbsp; <span id="spanNoiDungKP_lblDeTai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Mã thuyết minh:</td>
			<td >&nbsp; <span id="spanNoiDungKP_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tổ chức:</td>
			<td >&nbsp; <span id="spanNoiDungKP_lblToChuc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tên nội dung:</td>
			<td >&nbsp; <span id="spanNoiDungKP_lblTenNoiDung"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Đợt:</td>
			<td >&nbsp; <span id="spanNoiDungKP_lblDot"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số tiền:</td>
			<td >&nbsp; <span id="spanNoiDungKP_lblSoTien"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_noidung_capkinhphi_hienthi(id_tiendo_capkinhphi){
		$.ajax({
             url: root_href +   HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_NOIDUNG_CAPKINHPHI,
                 condition: 'a.id_tiendo_capkinhphi =' + id_tiendo_capkinhphi
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('spanNoiDungKP_lblDeTai').textContent = jsonObject.rows[0].tendt;
                 document.getElementById('spanNoiDungKP_lblTheLoai').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('spanNoiDungKP_lblToChuc').textContent = jsonObject.rows[0]. tentc;
                 document.getElementById('spanNoiDungKP_lblTenNoiDung').textContent =  jsonObject.rows[0].ten_noidung;
                 document.getElementById('spanNoiDungKP_lblSoTien').textContent =  jsonObject.rows[0].sotien;
                 document.getElementById('spanNoiDungKP_lblDot').textContent =  jsonObject.rows[0].ghichu;
                 return;
             }});
		 
		 try{
		      $('#dlg_noidung_capkinhphi_hienthi_show').dialog({
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
		      alert("func_dlg_noidung_capkinhphi_hienthi have dlg_noidung_capkinhphi_hienthi_show " + err);
		    }
	}
</script>