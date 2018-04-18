<%--
  Created by IntelliJ IDEA.
  User: VN
  Date: 1/7/2015
  Time: 3:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:out value="${Object_TinTucHoatDong}"  escapeXml="false"/>


	<div class="box-c">
		<div class="box-news">
			<div class="box-title">
				<a	href="${pageContext.request.contextPath}/ChuyenTrang?action=114&page=1&chude=1">
					<span style="text-transform: uppercase; color: #E70404;"> <b>Kết quả xây dựng NTM</b></span>
				</a>
			</div> 
			<div class="box-content">
			<c:forEach var="Object_GioiThieu_NTM" items="${Object_GioiThieu_NTM}" varStatus="loopStatus" >
				<c:choose>
					<c:when test="${loopStatus.index=='0'}">
								<div class="first">
									<p class="title">
										<a href="${pageContext.request.contextPath}/ChuyenTrang?action=115&sogioithieu=${Object_GioiThieu_NTM.id_baiviet}&chude=1">
											${Object_GioiThieu_NTM.tentieude}</a>
									</p>
									<div style="text-align: justify">
										<b	style="font-family: Verdana,Arial,sans-serif; font-size: 11pt;">
										<span style="color: black"></span></b>
									</div>
									<div style="text-align: justify">
										<span class="ms-rteFontSize-3"> </span>
									</div>
									<p></p>
								</div>
						 <ul>
					 </c:when>
					 <c:otherwise>
						 		<li><a href="${pageContext.request.contextPath}/ChuyenTrang?action=115&sogioithieu=${Object_GioiThieu_NTM.id_baiviet}&chude=1">${Object_GioiThieu_NTM.tentieude}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
						 </ul>
			</div>
		</div>
   </div>
   
	<div class="box-c">
		<div class="box-news">
			<div class="box-title">
				<a	href="<%=request.getContextPath()%>/ChuyenTrang?action=114&page=1&chude=2">
					<span style="text-transform: uppercase; color: #E70404;"> <b>Ứng dụng nghiên cứu ĐTDA</b></span>
				</a>
			</div> 
			<div class="box-content">
			<c:forEach var="Object_GioiThieu_DTDA" items="${Object_GioiThieu_DTDA}" varStatus="loopStatus" >
				<c:choose>
					<c:when test="${loopStatus.index=='0'}">
								<div class="first">
									<p class="title">
										<a href="${pageContext.request.contextPath}/ChuyenTrang?action=115&sogioithieu=${Object_GioiThieu_DTDA.id_baiviet}&chude=2">
											${Object_GioiThieu_DTDA.tentieude}</a>
									</p>
									<div style="text-align: justify">
										<b	style="font-family: Verdana,Arial,sans-serif; font-size: 11pt;">
										<span style="color: black"></span></b>
									</div>
									<div style="text-align: justify">
										<span class="ms-rteFontSize-3"> </span>
									</div>
									<p></p>
								</div>
						 <ul>
					 </c:when>
					 <c:otherwise>
						 		<li><a href="${pageContext.request.contextPath}/ChuyenTrang?action=115&sogioithieu=${Object_GioiThieu_DTDA.id_baiviet}&chude=2">${Object_GioiThieu_DTDA.tentieude}</a></li>
					</c:otherwise>
				</c:choose>
					
			</c:forEach>
						 </ul>
				</div>
		</div>
   </div>
   
 


<%-- <c:forEach var="Object_PhanloaiTT" items="${Object_PhanloaiTT}">
	<div class="box-c">
		<div class="box-news">
			<div class="box-title">
				<a
					href="<%=request.getContextPath()%>/ChuyenTrang?action=109&sotintuc=${Object_PhanloaiTT.id_phanloai_tintuc}">
					<span style="text-transform: uppercase; color: #E70404;"> <b>${Object_PhanloaiTT.ten_phanloai}</b></span>
				</a>
			</div> --%>
			
			<%-- <c:set var="size" value="${fn:length(Object_PhanloaiTT)}" />
				<c:out value="${Object_TinTucHoatDong2}" /> --%>
				<%-- <div class="box-c">
	</div>
</c:forEach>
 --%>

<%-- 
<div class="box-c">
	<div class="box-news">

		<div class="box-title">
			<a href="/ChuyenTrang?action=trangXemNoiDung"><span
				style="text-transform: uppercase; color: #E70404;"><b>
						Tin nổi bật</b></span></a>
		</div>

		<div class="box-content">
			<div class="first">
				<a href="/ChuyenTrang?action=trangXemNoiDung"><img alt=""
					height="226" src="/resources/uploads/DSC_7242_JPG.jpg" width="300"></a>
				<p class="title">
					<a href="/ChuyenTrang?action=trangXemNoiDung">Cổng TTĐT Chính
						phủ: Phấn đấu phục vụ Chính phủ, nhân dân tốt hơn</a>
				</p>
				<p class="description"></p>
				<div style="text-align: justify">
					<b
						style="font-family: Segoe UI; font-size: 11pt; background-color: window"><span
						style="color: black">Ủy viên Trung ương Đảng, Bí thư Đảng
							ủy, Bộ trưởng-Chủ nhiệm VPCP Nguyễn Văn Nên đã đến quán triệt và
							chỉ đạo Cổng TTĐT Chính phủ tại Hội nghị triển khai nhiệm vụ công
							tác năm 2015 của đơn vị tổ chức ngày 17/12/2014.</span></b>
				</div>
				<div style="text-align: justify">
					<span class="ms-rteFontSize-3"> </span>
				</div>
				​
				<p></p>
			</div>
			<ul>
				<li><a
					href="/ct/news/Lists/TinNongMoi/View_Detail.aspx?ItemID=248">Tổng
						Thanh tra Chính phủ Huỳnh Phong Tranh làm việc tại Kiên Giang</a></li>
			</ul>
		</div>
	</div>
</div>
 --%>