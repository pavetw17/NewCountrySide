<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<html>
<head>
 <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/stylewebNTM.css" type="text/css" />
 <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/reset.css" type="text/css" />
 <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/jquery-ui-1.10.4.min.css"/>

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.11.1.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-ui-1.10.4.custom.min.js"></script>

<!-- Datagrid  -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/components/datagrid/easyui.css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/components/datagrid/jquery.easyui.datagrid.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/components/datagrid/jquery.easyui.window.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/components/datagrid/icon.css"/>
 
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/cwrs/definitions.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/cwrs/dialogs.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/lib/JsSimpleDateFormat.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/cwrs/classes.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/cwrs/global.js"></script>  

 <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/menu_trangchu/jqueryslidemenu.css" type="text/css" />
 <script type="text/javascript" src="<%=request.getContextPath()%>/resources/menu_trangchu/jqueryslidemenu.js" ></script>
 <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/ddaccordion.js" ></script>


<script>
 
 $(document).ready(function () {
	gm = new GenericManager(true);  
 });

</script>
 
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
            <div class="Home_col_left">
              <tiles:insertAttribute name="left"/>
            </div>
            <div class="Home_col_center">
              <div id="Home_col_center">
              	<tiles:insertAttribute name="content"/>
              </div>
                <div id="dlg_timkiem_dtda_sp_hienthi_show"></div>
            </div>
            <div class="Home_col_right">
              <tiles:insertAttribute name="right"/>
            </div>
          </div>
          <div class="Home_footer">
            <tiles:insertAttribute name="footer"/>
          </div>
        </div>
      </div>
</body>
</html>