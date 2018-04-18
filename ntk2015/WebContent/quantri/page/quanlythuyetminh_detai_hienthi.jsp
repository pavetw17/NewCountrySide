<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="540px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thể loại đề tài:</td>
			<td>&nbsp; <span id="spanMDHT_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Mã thuyết minh:</td>
			<td >&nbsp; <span id="spanMDHT_lblMaSoDT"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Muc tiêu đề tài:</td>
			<td >&nbsp; <span id="spanMDHT_lblMucTieu"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ngày bắt đầu:</td>
			<td >&nbsp; <span id="spanMDHT_lblNgay"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tình trạng:</td>
			<td >&nbsp; <span id="spanMDHT_lblTinhTrang"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_qlthuyetminh_detai_hienthi(id_thuyetminh_detai_duan){
		$.ajax({
             url: root_href + HOME_SERVLET ,
             data:{
                 action:   ACT_GET_DATA_TO_EDIT_THUYETMINH_DETAI,
                 condition: 'id_thuyetminh_detai_duan =' + id_thuyetminh_detai_duan
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                
                 document.getElementById('spanMDHT_lblTheLoai').textContent = jsonObject.rows[0].tendt;
                 document.getElementById('spanMDHT_lblMaSoDT').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('spanMDHT_lblMucTieu').textContent = jsonObject.rows[0].muctieu_detai;
                 document.getElementById('spanMDHT_lblNgay').textContent =  gm.date.Int2DateString(jsonObject.rows[0].ngaybatdau);
                 if(jsonObject.rows[0].tinhtrangdt == '0'){
                 	 document.getElementById('spanMDHT_lblTinhTrang').textContent = 'Được tuyển chọn' ;
                 }else if(jsonObject.rows[0].tinhtrang == '1'){
                	 document.getElementById('spanMDHT_lblTinhTrang').textContent = 'Đang thực hiện' ;
                 } 
                 return;
             }});
		 
		 try{
		      $('#dlg_qlthuyetminh_detai_hienthi_show').dialog({
		        title: "Thông tin thuyết minh đề tài ",
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