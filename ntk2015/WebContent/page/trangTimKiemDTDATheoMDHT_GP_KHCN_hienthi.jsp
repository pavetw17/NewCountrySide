<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	
<table style="border-spacing: inherit; border-collapse: collapse" border="1" width="540px">
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thể loại đề tài:</td>
			<td>&nbsp; <span id="spanGPKHCN_lblTheLoai"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Mã thuyết minh:</td>
			<td >&nbsp; <span id="spanGPKHCN_lblQuyTrinhTM"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tổ chức:</td>
			<td >&nbsp; <span id="spanGPKHCN_lblToChuc"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tên giải pháp:</td>
			<td >&nbsp; <span id="spanGPKHCN_GiaiPhap"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nội dung:</td>
			<td >&nbsp; <span id="spanGPKHCN_lblNoiDung"></span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Quy trình:</td>
			<td >&nbsp; <span id="spanGPKHCN_lblQuyTrinh"></span>
			</td>
		</tr>
		</tbody>
</table>

<script type="text/javascript" >
	var contextPath = "${pageContext.request.contextPath}" ;
	function func_dlg_giaiphap_khcn_hienthi(id_giaiphap_khcn){
		$.ajax({
             url: HOME_SERVLET ,
             data:{
                 action: ACT_GET_DATA_TO_EDIT_GIAIPHAP_KHCN,
                 condition: 'id_giaiphap_khcn =' + id_giaiphap_khcn
             },
             async:false,
             success:function(jsonData) {
                 var jsonObject = JSON.parse(jsonData);
                
                 document.getElementById('spanGPKHCN_lblTheLoai').textContent = jsonObject.rows[0].tendt;
                 document.getElementById('spanGPKHCN_lblQuyTrinhTM').textContent = jsonObject.rows[0].masodt;
                 document.getElementById('spanGPKHCN_lblToChuc').textContent = jsonObject.rows[0]. tentc;
                 document.getElementById('spanGPKHCN_GiaiPhap').textContent =  jsonObject.rows[0].ten_giaiphap_khcn;
                 document.getElementById('spanGPKHCN_lblNoiDung').textContent = jsonObject.rows[0].noidung_giaiphap_khcn ;
                 document.getElementById('spanGPKHCN_lblQuyTrinh').textContent = jsonObject.rows[0].quytrinh_thuc_hien ;
                 return;
             }});
		 
		 try{
		      $('#dlg_timkiem_dtda_sp_hienthi_show').dialog({
		        title: "Thông tin giải pháp ",
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
		      alert("func_dlg_giaiphap_khcn_hienthi have dlg_timkiem_dtda_sp_hienthi_show " + err);
		    }
	}
</script>