<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="540px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nhóm nội dung:</td>
			<td>&nbsp; <span id="spanNoiDungCVCon_lblDeTai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Mã thuyết minh:</td>
			<td >&nbsp; <span id="spanNoiDungCVCon_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tổ chức:</td>
			<td >&nbsp; <span id="spanNoiDungCVCon_lblToChuc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Giai đoạn:</td>
			<td >&nbsp; <span id="spanNoiDungCVCon_lblGiaiDoan"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tên nội dung:</td>
			<td >&nbsp; <span id="spanNoiDungCVCon_lblTenNoiDung"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thời gian bắt đầu:</td>
			<td >&nbsp; <span id="spanNoiDungCVCon_lblTGBatDau"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thời gian kết thúc:</td>
			<td >&nbsp; <span id="spanNoiDungCVCon_lblTGKetThuc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Phần trăm hoàn thành:</td>
			<td >&nbsp; <span id="spanNoiDungCVCon_lblPTHoanThanh"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_noidungcv_con_hienthi (id_noidung){
		$.ajax({
             url: root_href +   HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_OUT_NOIDUNG_THUYETMINH_CON,
                 condition: 'a.id_noidung =' + id_noidung
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('spanNoiDungCVCon_lblDeTai').textContent = jsonObject.rows[0].nhom_noidung;
                 document.getElementById('spanNoiDungCVCon_lblTheLoai').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('spanNoiDungCVCon_lblToChuc').textContent = jsonObject.rows[0]. tentc;
                 document.getElementById('spanNoiDungCVCon_lblGiaiDoan').textContent =  jsonObject.rows[0].tengiaidoan;
                 document.getElementById('spanNoiDungCVCon_lblTenNoiDung').textContent =  jsonObject.rows[0].ten_noidung;
                 document.getElementById('spanNoiDungCVCon_lblTGKetThuc').textContent =  gm.date.Int2DateString(jsonObject.rows[0].thoigian_ketthuc);
                 document.getElementById('spanNoiDungCVCon_lblTGBatDau').textContent =  gm.date.Int2DateString(jsonObject.rows[0].thoigian_batdau);
                 document.getElementById('spanNoiDungCVCon_lblPTHoanThanh').textContent =  jsonObject.rows[0].phantram_hoanthanh;
                 return;
             }});
		 
		 try{
		      $('#dlg_noidungcv_con_hienthi_show').dialog({
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
		      alert("func_dlg_noidungcv_con_hienthi  have dlg_noidungcv_con_hienthi_show " + err);
		    }
	}
</script>