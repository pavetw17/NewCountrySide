<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	ddaccordion.init({
		headerclass : "headerbar",
		contentclass : "submenu",
		revealtype : "click",
		mouseoverdelay : 200,
		collapseprev : false,
		defaultexpanded : [0,1,2,3], //[ 0 ],
		onemustopen : false,
		animatedefault : false,
		persiststate : true,
		toggleclass : [ "", "selected" ],
		togglehtml : [ "", "", "" ],
		animatespeed : "normal",
		oninit : function(b, a) {
		},
		onopenclose : function(d, b, c, a) {
		}
	});
	ddaccordion.init({
		headerclass : "headerbar2",
		contentclass : "submenu2",
		revealtype : "click",
		mouseoverdelay : 200,
		collapseprev : false,
		defaultexpanded : [],
		onemustopen : false,
		animatedefault : false,
		persiststate : true,
		toggleclass : [ "", "selected" ],
		togglehtml : [ "", "", "" ],
		animatespeed : "normal",
		oninit : function(a, b) {
		},
		onopenclose : function(a, b, c, d) {
		}
	});
</script>
<style type="text/css">
.submenu {
	display: none
}

a.hiddenajaxlink {
	display: none
}
</style>
<div class="box-c">
	<div class="urbangreymenu">
		<h3 class="headerbar">
			<a href="#">Tin tức hoạt động</a>
		</h3>
		<ul class="submenu">
			<c:forEach var="Object_PhanloaiTT" items="${Object_PhanloaiTT}">
			 <li><a href="<%=request.getContextPath()%>/ChuyenTrang?XemTT=${Object_PhanloaiTT.id_phanloai_tintuc}&action=108&page=1">${Object_PhanloaiTT.ten_phanloai}</a></li>
			</c:forEach>
			
			
	    </ul>
		<h3 class="headerbar">
			<a href="#">Bài viết giới thiệu</a>
		</h3>
		<ul class="submenu">
			<li><a href="${pageContext.request.contextPath}/ChuyenTrang?action=114&chude=1&page=1">Kết quả xây dựng NTM</a></li>
			<li><a href="${pageContext.request.contextPath}/ChuyenTrang?action=114&chude=2&page=1">Ứng dụng nghiên cứu ĐTDA</a></li>
	    </ul>
		<h3 class="headerbar">
			<a href="#">Hệ thống văn bản</a>
		</h3>
		
		<ul class="submenu"> 
			<c:forEach var="Object_PhanloaiVB" items="${Object_PhanloaiVB}">
			    <li><a href="<%=request.getContextPath()%>/ChuyenTrang?formVB=${Object_PhanloaiVB.id_phanloai}&action=102&page=1">${Object_PhanloaiVB.loai_vanbanphaply}</a></li>
			</c:forEach>
			<%-- <li><a href="VanBan?formVB=1&action=0&page1">Chương trình KHCN phục vụ xây dựng NTM </a></li>
			<li><a href="VanBan?formVB=2&action=0&page1">Chương trình mục tiêu quốc gia về xây dựng nông thôn mới </a></li> --%>
		</ul>
		<h3 class="headerbar">
			<a href="#">Hoạt động CT KHCN</a>
		</h3>
		<ul class="submenu">
			<li>
				<h3 class="headerbar2">
					<a href="#">Chương trình KHCN phục vụ xây dựng NTM</a>
				</h3>
				<ul class="submenu2">
					<li><a href="ChuyenTrang?action=105&page1">Ý kiến chỉ đạo </a></li>
				</ul>
			</li>
			<!-- <li>
				<h3 class="headerbar2">
					<a href="#">Bộ tiêu chí quốc gia nông thôn mới</a>
				</h3>
				<ul class="submenu2">
					<li><a href="#">Quy hoạch và thực hiện quy hoạch </a></li>
					<li><a href="#">Giao thông </a></li>
					<li><a href="#">Thủy lợi </a></li>
					<li><a href="#">Điện </a></li>
					<li><a href="#">Trường học </a></li>
					<li><a href="#">Cơ sở vật chất văn hóa </a></li>
					<li><a href="#">Chợ nông thôn </a></li>
					<li><a href="#">Bưu điện </a></li>
					<li><a href="#">Nhà ở dân cư </a></li>
					<li><a href="#">Thu nhập </a></li>
					<li><a href="#">Hộ nghèo </a></li>
					<li><a href="#">Cơ cấu lao động </a></li>
					<li><a href="#">Hình thức tổ chức sản xuất </a></li>
					<li><a href="#">Giáo dục </a></li>
					<li><a href="#">Y tế </a></li>
					<li><a href="#">Văn hóa </a></li>
					<li><a href="#">Môi trường </a></li>
					<li><a href="#">Hệ thống tổ chức chính trị xã hội vững
							mạnh </a></li>
					<li><a href="#">An ninh, trật tự xã hội được giữ vững </a></li>
				</ul>
			</li> -->
			<li>
				<h3 class="headerbar2">
					<a href="#">Danh sách đề tài dự án</a>
				</h3>
				<ul class="submenu2">
					<c:forEach var="Object_PhanloaiNhomDeTai" items="${Object_PhanloaiNhomDeTai}">
					 <li><a href="<%=request.getContextPath()%>/ChuyenTrang?XemDeTai=${Object_PhanloaiNhomDeTai.id_phannhom_detai}&action=111&page=1">${Object_PhanloaiNhomDeTai.ten_phannhom_detai}</a></li>
					</c:forEach>
	    		</ul>
			</li>
			<li>
				<h3 class="headerbar2">
					<a href="#">Tìm kiếm đề tài dự án</a>
				</h3>
				<ul class="submenu2">
					<li><a href="javascript:void(0)" onclick="onsubmenu_timkiem_theosanpham(); return false;">Theo sản phẩm</a>  </li>
					<li><a href="javascript:void(0)" onclick="onsubmenu_timkiem_theothoigian(); return false;">Theo thời gian</a>  </li>
					<li><a href="javascript:void(0)" onclick="onsubmenu_timkiem_theoMDHT(); return false;">Theo mức độ hoàn thành</a>  </li>
					<li><a href="javascript:void(0)" onclick="onsubmenu_timkiem_theoTCUD_NTM(); return false;">Theo tiêu chí ứng dụng NTM</a>  </li>
				</ul>
			</li>
		</ul>
		<h3 class="headerbar">
			<a href="#">Báo cáo, biểu đồ</a>
		</h3>

	</div>
</div>

<script>
  function loadHtml(div, html, async, loadonce){
    if (async == undefined) {
      async = true;
    }
    if (loadonce == undefined) loadonce = false;
    if (loadonce){
      var content = $('#'+div).html();
      content = content.trim();
      // alert(content);
      if (content != ''){ return true;}
    }
    $.ajax({ 
      url: html ,
      type: "GET",
      async:async,
      error: function (request, status, error) {
        alert(request.responseText);
      },
      success:function(_data) {
        //alert(_data);
        $("#"+ div).html(_data);
        return _data;
      }
    });

  }
 
  function onsubmenu_timkiem_theosanpham(){
    loadHtml("Home_col_center","./page/trangTimKiemDTDATheoSP.jsp", false);
    func_dlg_detai_duan_sp_show();
  }
  
  function onsubmenu_timkiem_theothoigian(){
	    loadHtml("Home_col_center","./page/trangTimKiemDTDATheoTG.jsp", false);
	    func_dlg_detai_duan_TG_show();
  }
  
  function onsubmenu_timkiem_theoMDHT(){
	    loadHtml("Home_col_center","./page/trangTimKiemDTDATheoMDHT.jsp", false);
	    func_dlg_detai_duan_MDHT_show();
  }
  
  function onsubmenu_timkiem_theoTCUD_NTM(){
	    loadHtml("Home_col_center","./page/trangTimKiemDTDATheoTCUD_NTM.jsp", false);
	    func_dlg_detai_duan_TCUD_NTM_show();
  }
  </script>
