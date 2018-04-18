<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<html>
<head>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/stylewebNTM.css" type="text/css" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/reset.css" type="text/css" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.11.1.min.js" ></script>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/menu_trangchu/jqueryslidemenu.css" type="text/css" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/resources/menu_trangchu/jqueryslidemenu.js" ></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js" ></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.bootpag.min.js" ></script>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/js/bootstrap.min.css" type="text/css" />
  
 
  <title> <tiles:insertAttribute name="title" /> </title>
</head>
<body>

<div class="container_12">
  <div class="grid_12">
    <div class="Home_header">
      <tiles:insertAttribute name="header"/>
    </div>
    <div class="Home_menu">
      <tiles:insertAttribute name="menu"/>
    </div>
    <div class="Home_content">
        <tiles:insertAttribute name="content"/>
    </div>
    <div class="Home_footer">
      <tiles:insertAttribute name="footer"/>
    </div>
  </div>

</div>
</body>
</html>
