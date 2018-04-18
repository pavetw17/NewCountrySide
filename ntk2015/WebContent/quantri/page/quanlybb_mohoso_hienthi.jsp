<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table style="border-spacing: inherit; border-collapse: collapse" border="1"
	width="540">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Đề tài:</td>
			<td>&nbsp; <span id="span_dlg_bb_mohoso_them_TheLoai_Detai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Quyết định thành lập:</td>
			<td >&nbsp; <span id="span_dlg_bb_mohoso_them_QuyetDinh"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ngày ra quyết định:</td>
			<td >&nbsp; <span id="span_dlg_bb_mohoso_them_NgayRaQD"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Địa điểm:</td>
			<td >&nbsp; <span id="span_dlg_bb_mohoso_them_DiaDiem"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thời gian mở hồ sơ:</td>
			<td >&nbsp; <span id="span_dlg_bb_mohoso_them_TGMoHoSo"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tổng số hồ sơ:</td>
			<td >&nbsp; <span id="span_dlg_bb_mohoso_them_TongHS"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số hồ sơ hợp lệ: </td>
			<td >&nbsp; <span id="span_dlg_bb_mohoso_them_SoHoSoHopLe"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thời gian ký biên bản: </td>
			<td >&nbsp; <span id="span_dlg_bb_mohoso_them_TGKyBB"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ngày ký biên bản: </td>
			<td >&nbsp; <span id="span_dlg_bb_mohoso_them_NgayKyBB"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" 
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; File biên bản:</td>
			<td >&nbsp;
				<a	id="a_download"
					target="_blank"> <span id="span_download"></span>
				</a>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" language="javascript">
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_bb_mohoso_hienthi(id_detai){
		$.ajax({
             url: root_href + HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_BIENBAN_MOHOSO,
                 condition: 'a.id_detai =' + id_detai
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('span_dlg_bb_mohoso_them_TheLoai_Detai').textContent = jsonObject.rows[0].tendt;
                 document.getElementById('span_dlg_bb_mohoso_them_QuyetDinh').textContent = jsonObject.rows[0].qd_thanhlaphoidong;
                 document.getElementById('span_dlg_bb_mohoso_them_NgayRaQD').textContent = gm.date.Int2DateString(jsonObject.rows[0].ngay_ra_quyetdinh);
                 document.getElementById('span_dlg_bb_mohoso_them_DiaDiem').textContent = jsonObject.rows[0].diadiem;
                 document.getElementById('span_dlg_bb_mohoso_them_TGMoHoSo').textContent =  gm.date.Int2DateString(jsonObject.rows[0].thoigian_mohoso);
                 document.getElementById('span_dlg_bb_mohoso_them_TGKyBB').textContent =  jsonObject.rows[0].thoigian_kibienban;
                 document.getElementById('span_dlg_bb_mohoso_them_NgayKyBB').textContent =  gm.date.Int2DateString(jsonObject.rows[0].ngay_kibienban);
                 document.getElementById('span_dlg_bb_mohoso_them_SoHoSoHopLe').textContent =  jsonObject.rows[0].tongso_hoso;
                 document.getElementById('span_dlg_bb_mohoso_them_TongHS').textContent =  jsonObject.rows[0].so_hoso_hople;
                 document.getElementById('span_download').textContent =  (jsonObject.rows[0].duongdanhoso).split("/").pop();
                 document.getElementById('a_download').href = contextPath + "/"+ jsonObject.rows[0].duongdanhoso;
                 return;
             }});
		 
		 try{
		      $('#dlg_bb_mohoso_hienthi_show').dialog({
		        title: "Thông tin biên bản ",
		        modal: true, open: function () {
		          $(this).dialog('widget').draggable('option', {containment: false});
		        },
		        height: 480,
		        width: 580,
		        collapsible: true,
		        draggable: true,
		        resizable: false,
		        position:[530,100],
		        buttons: {
		          "Đóng": function () {
		            $(this).dialog("close");
		          }
		        },
		        close: function () {
		        }
		      });
		    } catch (err) {
		      alert("func_dlg_bb_mohoso_hienthi have dlg_bb_mohoso_hienthi_show " + err);
		    }
	}
</script>