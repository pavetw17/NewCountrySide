<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="540px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thể loại đề tài:</td>
			<td>&nbsp; <span id="span_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tên đề tài:</td>
			<td >&nbsp; <span id="span_lblTenDeTai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Lĩnh vực:</td>
			<td >&nbsp; <span id="span_lblLinhVuc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thời gian thực hiện:</td>
			<td >&nbsp; <span id="span_lblThoiGian"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ngày thực hiện:</td>
			<td >&nbsp; <span id="span_lblNgay"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Kinh phí:</td>
			<td >&nbsp; <span id="span_lblKinhPhi"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tình trạng:</td>
			<td >&nbsp; <span id="span_lblTinhTrang"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" language="javascript">
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_qldetai_duan_hienthi(id_detai){
		$.ajax({
             url: root_href + HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_TO_EDIT_DETAI_DUAN,
                 condition: 'id_detai =' + id_detai
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                 document.getElementById('span_lblTheLoai').textContent = jsonObject.rows[0].ten_phannhom_detai;
                 document.getElementById('span_lblTenDeTai').textContent = jsonObject.rows[0].tendt;
                 document.getElementById('span_lblLinhVuc').textContent = jsonObject.rows[0].linhvuckh;
                 document.getElementById('span_lblThoiGian').textContent = jsonObject.rows[0].tgthuchien;
                 document.getElementById('span_lblNgay').textContent =  gm.date.Int2DateString(jsonObject.rows[0].ngaythuchien);
                 document.getElementById('span_lblKinhPhi').textContent =  jsonObject.rows[0].kinhphi + " VND";
                 if(jsonObject.rows[0].tinhtrang == '0'){
                 	 document.getElementById('span_lblTinhTrang').textContent = 'Được phê duyệt' ;
                 }else if(jsonObject.rows[0].tinhtrang == '1'){
                	 document.getElementById('span_lblTinhTrang').textContent = 'Đang thực hiện' ;
                 }else{
                	 document.getElementById('span_lblTinhTrang').textContent = 'Đã nghiệm thu' ;
                 }
                 return;
             }});
		 
		 try{
		      $('#dlg_qldetai_duan_hienthi_show').dialog({
		        title: "Thông tin đề tài dự án ",
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
		      alert("func_dlg_qlvanban_phaply_hienthi have dlg_qlvanban_phaply_hienthi_show " + err);
		    }
	}
</script>