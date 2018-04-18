<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="folder_news">
    <span style="color:#B5250A; text-decoration: underline; font-style: inherit; font-weight: bold;"> ${list[0].ten_phannhom_detai}</span>
    <div class="time-date">
        
    </div>
</div>
<div class="box-c"> 
<div class="table_grid_vb">
<table >
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tên đề tài:</td>
			<td>&nbsp; <span id="span_lblSoHieu">${list[0].tendt}</span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Lĩnh vực:</td>
			<td >&nbsp; <span id="span_lblNgayBanHanh">${list[0].linhvuckh}</span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Thời gian:</td>
			<td >&nbsp; <span id="span_lblNoiDung">${list[0].tgthuchien}</span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Kinh phí:</td>
			<td >&nbsp; <span id="span_lblTenVanBan">${list[0].kinhphi}</span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nhóm đề tài:</td>
			<td >&nbsp; <span id="span_lblLoaiVanBan">${list[0].id_phannhom_detai_duan}</span>
			</td>
		</tr>
</table></div>
</div>

