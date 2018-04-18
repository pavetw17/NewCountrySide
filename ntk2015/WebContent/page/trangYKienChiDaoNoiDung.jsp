<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="folder_news">
    <span style="color:#B5250A; text-decoration: underline; font-style: inherit; font-weight: bold;"> Ý kiến chỉ đạo</span>
    <div class="time-date">
        
    </div>
</div>
<div class="box-c"> 
<div class="table_grid_vb">
<table >
	<tbody>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Số hiệu:</td>
			<td>&nbsp; <span id="span_lblSoHieu">${list[0].sokihieu}</span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Tên văn bản:</td>
			<td >&nbsp; <span id="span_lblTenVanBan">${list[0].tieude}</span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Ngày ban hành:</td>
			<td >&nbsp; <span id="span_lblNgayBanHanh">${list[0].ngay_chidao_cohieuluc}</span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Nội dung chỉ đạo:</td>
			<td >&nbsp; <span id="span_lblNoiDung">${list[0].noidungchidao}</span>
			</td>
		</tr>
		<tr>
			<td width="150px" bgcolor="#F2F5A9" class="style1"
				style="font-weight: bold">&nbsp; &nbsp; &nbsp; Download:</td>
			<td >&nbsp;
				<a	id="a_download" href="<%=request.getContextPath()%>/${list[0].duongdanykienchidao}"
					target="_blank"> 
					<span id="span_download">
				<c:set var="duongdan" value="${list[0].duongdanykienchidao}" />
				<c:set var="duongdan_split" value="${fn:split(duongdan,'/')}" />               
				<c:set var="filename" value="${duongdan_split[fn:length(duongdan_split) - 1]}" /> 
				<c:out value="${filename}"/>
				</span>
				</a>
			</td>
		</tr>
		</tbody>
</table></div>
</div>

<div class="box-c">
    <iframe src="http://docs.google.com/viewer?url=<%=request.getContextPath()%>/${list[0].duongdanykienchidao}&embedded=true"
     width="460" height="480"></iframe>
</div>