<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
  <%-- jQuery(document).ready(function($) {
       *//* alert(2);*//*
        $.post("/Home_layMenu",{
        }, function(j){
            bandau = parseInt(j);
            if(bandau<0) bandau=0;
            var optInit = {callback: pageselectCallback};
            optInit['items_per_page'] = 5;
            optInit['num_display_entries'] = 4;
            optInit['num_edge_entries'] = 2;
            optInit['prev_text'] = "Previous";
            optInit['next_text'] = "Next";
            optInit['ellipse_text'] = "...";
            $("#Pagination").pagination(bandau, optInit);
        });
    }); --%>
</script>


<!-- <div id="myslidemenu" class="jqueryslidemenu"> -->
<div>
    <ul id="menu_wrap" class="Blue">
        <li class="button"><a href="<%=request.getContextPath()%>/">Trang chủ
           <%--  <img src="<%=request.getContextPath()%>/resources/menu_trangchu/down.gif" class="downarrowclass" style="border:0;"> --%>
        </a></li>
        <li class="button"><a href="<%=request.getContextPath()%>/bando.jsp">Bản đồ</a></li>
        <li class="button"><a href="javascript:void(0)">Liên hệ</a></li>
    </ul>
</div>
<!-- </div> -->
