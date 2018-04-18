<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<html>
<head>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/stylewebNTM.css" type="text/css" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/reset.css" type="text/css" />
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/menu_trangchu/jqueryslidemenu.css" type="text/css" />
  <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.11.1.min.js" ></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/resources/menu_trangchu/jqueryslidemenu.js" ></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/ddaccordion.js" ></script>
  <title> <tiles:insertAttribute name="title" /> </title>
  <style type="text/css">
  body {
	margin: 0;
	padding: 0
  }
  </style>
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
            <div class="Home_bando">
              <tiles:insertAttribute name="content"/>
            </div>
          </div>
          <div class="Home_footer">
            <tiles:insertAttribute name="footer"/>
          </div>
        </div>
      </div>
</body>
</html>