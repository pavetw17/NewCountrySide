<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	function NhapTimKiem_NTM(value) {
		if (this.value == "") {
			return;
		}
		document.onkeydown = function(e) {
			e = (window.event) ? event : e;
			var k = e.keyCode;
			if (k == 13) {
				TimKiem_NTM();
				return false;
			}
		};
	}
	
	function NhapTimKiem_DTDA(value) {
		if (this.value == "") {
			return;
		}
		document.onkeydown = function(e) {
			e = (window.event) ? event : e;
			var k = e.keyCode;
			if (k == 13) {
				TimKiem_DTDA();
				return false;
			}
		};
	}
	
	function TimKiem_NTM() {
		var searchText1 = document.getElementById("txtVB");
		if (searchText1 != null) {
			if (searchText1.value != null && searchText1.value != "" && searchText1.value != "Từ khóa tìm kiếm") {
				window.location.href = "${pageContext.request.contextPath}/ChuyenTrang?tukhoa="
						+ searchText1.value.replace("'","''") + "&action=116&page=1&chude=1";
			} else {
				alert("Bạn phải nhập từ khóa tìm kiếm!");
			}
		}
	}
	function TimKiem_DTDA() {
		var searchText1 = document.getElementById("txtVB");
		if (searchText1 != null) {
			if (searchText1.value != null && searchText1.value != "" && searchText1.value != "Từ khóa tìm kiếm") {
				window.location.href = "${pageContext.request.contextPath}/ChuyenTrang?tukhoa="
						+ searchText1.value.replace("'","''") + "&action=116&page=1&chude=2";
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
			<c:choose>
				<c:when test="${chude =='1'}">
						<div class="box_search_vanban">
							<input type="text" id="txtVB" name="txtVB" value="Từ khóa tìm kiếm"
								style="width: 350px; height: 26px;"
								onblur="if (this.value=='') this.value='Từ khóa tìm kiếm';"
								onfocus="if (this.value=='Từ khóa tìm kiếm') this.value='';"
								onkeypress="javascript:NhapTimKiem_NTM(this.value);"> 
								
								<a class="btn_tim" onclick="TimKiem_NTM();" href="javascript:;"> Tìm </a>
								
								
						</div>
				</c:when>
				<c:otherwise>
						<div class="box_search_vanban">
							<input type="text" id="txtVB" name="txtVB" value="Từ khóa tìm kiếm"
								style="width: 350px; height: 26px;"
								onblur="if (this.value=='') this.value='Từ khóa tìm kiếm';"
								onfocus="if (this.value=='Từ khóa tìm kiếm') this.value='';"
								onkeypress="javascript:NhapTimKiem_DTDA(this.value);"> 
								<a class="btn_tim" onclick="TimKiem_DTDA();" href="javascript:;"> Tìm </a>
								
						</div>
				</c:otherwise>
			 </c:choose>	
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
    <span style="color:#B5250A; text-decoration: underline; font-style: inherit; font-weight: bold;">${row_tenthumuc}</span>
</div>
 <c:forEach var="list" items="${list}">

	<div class="box_new_lever_2">
	
       <p class="title">
            <a href="${pageContext.request.contextPath}/ChuyenTrang?action=115&sogioithieu=${list.id_baiviet}&chude=${chude}">${list.tentieude}</a>
        </p>
        <p class="normal">
            </p><div class="ms-rteFontFace-3 ms-rteFontSize-3" style="text-align:justify">
            <span >
            ${list.tomtatnoidung}&nbsp;</span></div>
        <p></p> 
	</div>
</c:forEach> 
<div class="pagination dark">
				<c:if test="${currentPage != 1}">
					<a href="${pageContext.request.contextPath}/${link_page}${currentPage - 1}" class="page dark">Previous</a>
				</c:if>
				<c:choose>
					<c:when test="${tongso_trang < 5}">
						<c:forEach begin="1" end="${tongso_trang}" var="i">
							<c:choose>
								<c:when test="${currentPage eq i}">
									<span class="page dark active">${i}</span>
								</c:when>
								<c:otherwise>
									<a href="${pageContext.request.contextPath}/${link_page}${i}" class="page dark">${i}</a>
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
											<a href="${pageContext.request.contextPath}/${link_page}${i}" class="page dark">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<a class="chamcham">...</a>
								<a href="${pageContext.request.contextPath}/${link_page}${tongso_trang}" class="page dark">${tongso_trang}</a>
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
											<a href="${pageContext.request.contextPath}/${link_page}${i}" class="page dark">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<a class=" chamcham">...</a>
								<a href="${pageContext.request.contextPath}/${link_page}${tongso_trang}" class="page dark">${tongso_trang}</a>
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
											<a href="${pageContext.request.contextPath}/${link_page}${i}" class="page dark">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
				<!-- For displaying Next link -->
				<c:if test="${currentPage lt tongso_trang}">
					<a href="${pageContext.request.contextPath}/${link_page}${currentPage + 1}" class="page dark">Next</a>
				</c:if>
			</div>
</c:otherwise>
</c:choose>

</div>
