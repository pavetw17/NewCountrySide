<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	function NhapTimKiem(value) {
		if (this.value == "") {
			return;
		}
		document.onkeydown = function(e) {
			e = (window.event) ? event : e;
			var k = e.keyCode;
			if (k == 13) {
				TimKiem();
				return false;
			}
		};
	}
	function TimKiem() {
		var searchText1 = document.getElementById("txtVB");
		if (searchText1 != null) {
			if (searchText1.value != null && searchText1.value != "" && searchText1.value != "Từ khóa tìm kiếm") {
				window.location.href = "<%=request.getContextPath()%>/ChuyenTrang?tukhoa="
						+ searchText1.value.replace("'","''") + "&action=104&page=1";
			} else {
				alert("Bạn phải nhập từ khóa tìm kiếm!");
			}
		}
	}
</script>


<div class="box-c">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td>
				<div class="box_search_vanban">
					<input type="text" id="txtVB" name="txtVB" value="Từ khóa tìm kiếm"
						onblur="if (this.value=='') this.value='Từ khóa tìm kiếm';"
						onfocus="if (this.value=='Từ khóa tìm kiếm') this.value='';"
						onkeypress="javascript:NhapTimKiem(this.value);">
						<a class="btn_tim" onclick="TimKiem();" href="javascript:;"> Tìm </a>
						
				</div>
			</td>
		</tr>
		</table>
		<c:choose>
		<c:when test="${empty list}">
			<div class="box-c">
			<p><h1 style="font-size: 15px">Không có dữ liệu</h1></p>
			</div>
	</c:when>	
	<c:otherwise>
	<div class="folder_news">
    <span style="color:#B5250A; text-decoration: underline; font-style: inherit; font-weight: bold;">${row_tenthumuc[0].loai_vanbanphaply}</span>
</div>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td style="border: 1px solid #E2E3EA">
				<table width="100%" cellpadding="0" cellspacing="0">
					<tr class="tblHeader_vanban">
						<td width="25%" valign="middle" height="30" nowrap="nowrap"
							align="center" class="headerText">Số/Ký hiệu</td>
						<td width="16%" valign="middle" height="30" nowrap="nowrap"
							align="center" class="headerText">Ngày ban hành</td>
						<td width="59%" valign="middle" height="30" nowrap="nowrap"
							align="center" class="headerText">Tên văn bản</td>
					</tr>

					<c:forEach var="list" items="${list}" varStatus="loopStatus">
						<tr class="${loopStatus.index % 2 == 0 ? 'item_even' : 'item_odd'}">
							<td width="23%" valign="middle" align="left" class="vbText">
								${list.kihieuvanban}</td>
							<td width="16%" valign="middle" align="center" class="vbText">
								${list.ngaybanhanh}</td>
							<td width="50%" valign="middle" align="justify" class="vbText">
								<a href="ChuyenTrang?action=103&sovanban=${list.id_vanbanphaply}"><div class="noidung_vanban_tt"><p>​
								${list.tenvanban} </p></div></a> </td>
						</tr>
					</c:forEach>
					
				</table>
			</td>
		</tr>
	</table>
	<div class="pagination dark">
				<c:if test="${currentPage != 1}">
					<a href="<%=request.getContextPath()%>/${link_page}${currentPage - 1}" class="page dark">Previous</a>
				</c:if>
				<c:choose>
					<c:when test="${tongso_trang < 5}">
						<c:forEach begin="1" end="${tongso_trang}" var="i">
							<c:choose>
								<c:when test="${currentPage eq i}">
									<span class="page dark active">${i}</span>
								</c:when>
								<c:otherwise>
									<a href="<%=request.getContextPath()%>/${link_page}${i}" class="page dark">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${(currentPage <= 3)}">
								<c:forEach begin="1" end="3" var="i">
									<c:choose>
										<c:when test="${currentPage eq i}">
											<span class="page dark active">${i}</span>
										</c:when>
										<c:otherwise>
											<a href="<%=request.getContextPath()%>/${link_page}${i}" class="page dark">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<a class="chamcham">...</a>
								<a href="<%=request.getContextPath()%>/${link_page}${tongso_trang}" class="page dark">${tongso_trang}</a>
							</c:when>
		
							<c:when
								test="${(currentPage > 3) and (tongso_trang - currentPage >= 3)}">
								<a href="1" class="page dark">1</a>
								<a class=" chamcham">...</a>
								<c:forEach begin="${currentPage-1}" end="${currentPage+2}" var="i">
									<c:choose>
										<c:when test="${currentPage eq i}">
											<span class="page dark active">${i}</span>
										</c:when>
										<c:otherwise>
											<a href="<%=request.getContextPath()%>/${link_page}${i}" class="page dark">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<a class=" chamcham">...</a>
								<a href="<%=request.getContextPath()%>/${link_page}${tongso_trang}" class="page dark">${tongso_trang}</a>
							</c:when>
		
							<c:otherwise>
								<a href="tin-tuc-1" class="page dark">1</a>
								<a class=" chamcham">...</a>
								<c:forEach begin="${currentPage-2}" end="${tongso_trang}" var="i">
									<c:choose>
										<c:when test="${currentPage eq i}">
											<span class="page dark active">${i}</span>
										</c:when>
										<c:otherwise>
											<a href="<%=request.getContextPath()%>/${link_page}${i}" class="page dark">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
				<!-- For displaying Next link -->
				<c:if test="${currentPage lt tongso_trang}">
					<a href="<%=request.getContextPath()%>/${link_page}${currentPage + 1}" class="page dark">Next</a>
				</c:if>
			</div>
</c:otherwise>
</c:choose>

</div>