<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="700px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Khu vực:</td>
			<td >&nbsp; <span id="spanTieuChiXD_lblKhuvuc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thể loại tiêu chí:</td>
			<td>&nbsp; <span id="spanTieuChiXD_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tên tiêu chí:</td>
			<td >&nbsp; <span id="spanTieuChiXD_lblTenTieuChi"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nôi dung:</td>
			<td >&nbsp; <span id="spanTieuChiXD_lblNoiDung"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Chỉ tiêu:</td>
			<td >&nbsp; <span id="spanTieuChiXD_lblChiTieu"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_tieuchi_xd_ntm_con_hienthi(id_tieuchi){
		$.ajax({
             url: root_href +  HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_TIEUCHI_XD_NTM_CON,
                 condition: 'id_tieuchi =' + id_tieuchi
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('spanTieuChiXD_lblKhuvuc').textContent =  jsonObject.rows[0].ten_khuvuc;
                 document.getElementById('spanTieuChiXD_lblTheLoai').textContent = jsonObject.rows[0].ten_tieuchi_cha;
                 document.getElementById('spanTieuChiXD_lblTenTieuChi').textContent =  jsonObject.rows[0].ten_tieuchi;
                 document.getElementById('spanTieuChiXD_lblNoiDung').textContent = jsonObject.rows[0].noidung_tieuchi ;
                 document.getElementById('spanTieuChiXD_lblChiTieu').textContent = jsonObject.rows[0].chitieu_phaidat ;
                 return;
             }});
		 
		 try{
		      $('#dlg_tieuchi_xd_ntm_con_hienthi_show').dialog({
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
		      alert("func_dlg_tieuchi_xd_ntm_con_hienthi have dlg_tieuchi_xd_ntm_con_hienthi_show " + err);
		    }
	}
</script>