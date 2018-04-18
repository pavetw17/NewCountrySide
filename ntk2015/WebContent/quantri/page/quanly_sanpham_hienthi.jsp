<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="540px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thể loại:</td>
			<td>&nbsp; <span id="spanSP_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Mã thuyết minh:</td>
			<td >&nbsp; <span id="spanSP_lblMaSoDT"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tên sản phẩm:</td>
			<td >&nbsp; <span id="spanSP_lblTenSP"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Chỉ tiêu chất lượng:</td>
			<td >&nbsp; <span id="spanSP_lblChiTieu"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Đơn vị đo:</td>
			<td >&nbsp; <span id="spanSP_lblDonViDo"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_sanpham_hienthi(id_sanpham){
		$.ajax({
             url: root_href + HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_TO_EDIT_SANPHAM,
                 condition: 'id_sanpham =' + id_sanpham
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                
                 document.getElementById('spanSP_lblTheLoai').textContent = jsonObject.rows[0].ten_phanloai_sp;
                 document.getElementById('spanSP_lblMaSoDT').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('spanSP_lblTenSP').textContent = jsonObject.rows[0].tensanpham;
                 document.getElementById('spanSP_lblChiTieu').textContent =  jsonObject.rows[0].chitieuchatluong;
                 document.getElementById('spanSP_lblDonViDo').textContent = jsonObject.rows[0].donvido ;
                 return;
             }});
		 
		 try{
		      $('#dlg_sanpham_hienthi_show').dialog({
		        title: "Thông tin sản phẩm ",
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