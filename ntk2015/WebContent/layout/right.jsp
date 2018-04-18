<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/easy-responsive-tabs.css" type="text/css"/>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/jquery.lightbox-0.5.css" type="text/css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/easyResponsiveTabs.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.lightbox-0.5.js"></script>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
    $(document).ready(function () {
        $('#horizontalTab').easyResponsiveTabs({
            type: 'default',
            width: 'auto',
            fit: true,
            closed: 'accordion',
            activate: function (event) {
                var $tab = $(this);
                var $info = $('#tabInfo');
                var $name = $('span', $info);
                $name.text($tab.text());
                $info.show();
            }
        });
    });

    $(function() {
        $('#gallery a').lightBox();
    });
</script>



<div class="box-c">
	 <div class="box-tinmoi">
	        <div class="title">
	            <span>Tin mới</span>
	        </div>
	        <ul>
	            <marquee height="180px" direction="up" scrollamount="3" onmouseover="this.stop();"  onmouseout="this.start();">
<c:forEach var="list" items="${ArrayList_TinMoi}">
	                <li>
	                    <a href="${pageContext.request.contextPath}/ChuyenTrang?action=109&thumuc=${list.id_tintuc}&sotintuc=${list.id_tintuc}">
	                    ${list.tieude}
	                    </a>
	                </li>
</c:forEach>
	            </marquee>
	        </ul>
	    </div>
</div>

<div class="box-c">
    <div class="widget">
        <div id="horizontalTab" >
            <ul class="resp-tabs-list">
                <li>Video Clip</li>
                <li>Thư viện ảnh</li>
            </ul>
                <div class="resp-tabs-container">
                    <div><!-- div 1 start-->
                    <c:forEach var="list" items="${Object_Video}" varStatus="loopStatus">
                    
                    <c:choose>
      					<c:when test="${loopStatus.index=='0'}">
		      					<div class="tabbed_content" >
		                            <span class="Home_videoclip_left" style="float: left">Video</span>
		                            <span class="Home_videoclip_right"> <a href="${pageContext.request.contextPath}/ChuyenTrang?action=80&chude=1"> Xem tất cả </a>  </span>
		                            <iframe width="220" height="148" style="padding-top: 10px;"
		                                    src="${list.pathfile}" frameborder="0" allowfullscreen></iframe>
		                        </div>
		                      <div class="clsPaging">
		                <ul>
		                <li class="list-video"><a href="${pageContext.request.contextPath}/ChuyenTrang?action=80&thumuc=${list.id_folder}&so_id=${list.id_picture}">
                                ${list.tenanh}</a></li>
				        </c:when>

      					<c:otherwise>
       						 <li class="list-video"><a href="${pageContext.request.contextPath}/ChuyenTrang?action=80&thumuc=${list.id_folder}&so_id=${list.id_picture}">
                                ${list.tenanh}</a></li>
      					</c:otherwise>
					</c:choose>
                          
                       </c:forEach>
                </ul>
            </div>
                    </div><!-- div 1 end -->

                    <div >
                        <div class="tabbed_content" >
                            <span class="Home_videoclip_left" style="float: left">Album ảnh</span>
                            <span class="Home_videoclip_right"> <a href="ChuyenTrang?action=90"> Xem tất
                                cả </a>  </span>

                        </div>
                        <div class="Home_middle">
                            <div class="Home_show-slide" id="gallery">
                            
                             <c:forEach var="list" items="${Object_Picture}" varStatus="loopStatus">
                                <div class="Home_thumbnail-show">
                                    <a title="" href="${pageContext.request.contextPath}/${list.pathfile}" >
                                        <img class="example-image" src="${pageContext.request.contextPath}/${list.pathfile}"></a>
                                </div>
                             
                             </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
    </div>
</div>

