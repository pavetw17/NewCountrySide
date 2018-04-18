<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="folder_news">
    <span style="color:#B5250A; text-decoration: underline; font-style: inherit; font-weight: bold;"> ${list[0].ten_phanloai}</span>
    <div class="time-date">
        
    </div>
</div>

<div class="box_news_detail">
    <p class="title_chinhsua">
      ${list[0].tieude}  -  <span style="color:navy;"> ${list[0].ngaytao} </span>
    </p>
    <div class="news-description">
       <c:if test="${list[0].duongdantintuc != ''}">
        	<img alt="" src="${list[0].duongdantintuc}" style="width: 491px; height: 300px;"> 
       </c:if> 
        <div class="noidung_tomtat"> ${list[0].tomtat}</div>
    </div>
    <div class="NoiDung_baiviet" id="nd_bv">
       ${list[0].noidung}
    </div>
</div>