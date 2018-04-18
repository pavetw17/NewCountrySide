<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="folder_news">
    <span style="color:#B5250A; text-decoration: underline; font-style: inherit; font-weight: bold;"> ${list[0].ten_phanloai}</span>
    <div class="time-date">
        
    </div>
</div>
<div class="folder_news">
    <span style="color:#B5250A; text-decoration: underline; font-style: inherit; font-weight: bold;">${row_tenthumuc}</span>
</div>
<c:choose>
	<c:when test="${chude =='1'}">
		<div class="box_news_detail">
		    <p class="title_chinhsua">
		      ${list[0].tentieude}  -  <span style="color:navy;"> ${list[0].ngaycongbo} </span> <br> Tỉnh: ${list[0].ten_xadiem}
		    </p>
		    <div class="news-description">
		       <div class="noidung_tomtat"> ${list[0].tomtatnoidung}</div>
		       <c:if test="${list[0].noidung != ''}">
		        	<a href="${pageContext.request.contextPath}/${list[0].noidung}" > Link down</a>
		       </c:if> 
		    </div>
		    <div class="NoiDung_baiviet" id="nd_bv">
		       ${list[0].noidungbv}
		    </div>
		</div>
	</c:when>
	<c:otherwise>
		<div class="box_news_detail">
		    <p class="title_chinhsua">
		      ${list[0].tentieude}  -  <span style="color:navy;"> ${list[0].ngaycongbo} </span> 
		      <br> Tỉnh: <span style="color:navy;">${list[0].ten_xadiem}  </span> 
		      <br> Tên đề tài: <span style="color:navy;">${list[0].tendt}  </span> 
		      <br> Mã số thuyết mình: <span style="color:navy;">${list[0].masodt}  </span> 
		    </p>
		    <div class="news-description">
		       <div class="noidung_tomtat"> ${list[0].tomtatnoidung}</div>
		       <c:if test="${list[0].noidung != ''}">
		        	<a href="${pageContext.request.contextPath}/${list[0].noidung}" > Link down</a>
		       </c:if> 
		    </div>
		    <div class="NoiDung_baiviet" id="nd_bv">
		       ${list[0].noidungbv}
		    </div>
		</div>
	</c:otherwise>
	
	
</c:choose>	