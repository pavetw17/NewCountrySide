<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.lightbox-0.5.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/jquery.lightbox-0.5.css" type="text/css"/>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
ul#gallery2 li img {
  display: block;
  width: 100px;
  height: 100px;
}

ul#gallery2 li {
  float: left;
  padding: 10px 10px 15px 15px;
}

ul#gallery1 li img {
  display: block;
  width: 100px;
  height: 100px;
}

ul#gallery1 li {
  float: left;
  padding: 10px 10px 15px 15px;
}
</style>



<script type="text/javascript">
  $(function() {
  var count_total = 0; <%--chude=2: nghien cuu de tai du an --%>
  $('#gallery1 a').lightBox();
  $('#gallery2 a').lightBox();
  
  $(document).on('change', '#dlg_thumuc_center_1', function() {
	  var id_folder =$("#dlg_thumuc_center_1").val();
	  if(id_folder != 0){
		  $("#photo_gallery1").show();
		  $("#page-selection1").show();
    	  $.ajax({
  	        url: "ChuyenTrang?action=91&thumuc="+this.value+"&chude=1",  
  	        type: "GET",
  	        async:false,
  	        error: function (request, status, error) {
	  	        alert(request.responseText);
	  	      },
	  	    success:function(data) {
	  	    	var jsonObject = JSON.parse(data);
	  	    	count_total = Math.ceil((jsonObject.rows[0].count) / 5) ;
	  	    	//alert(count_total);
	  	    	 $.ajax({
    		         url: "${pageContext.request.contextPath}/ChuyenTrang?action=92&thumuc="+id_folder+"&page=0&chude=1&so_items=5",
    		       }).done(function(data) {
    		    	   var codes = jQuery.parseJSON(data);
	    		    		   //alert( codes.rows);
 	    		    		  $('#gallery1').html('');
	    		    		  $(codes.rows).each(function() {
	    		    			  $("#gallery1").append($("<li ></li>").html(
	  		    		    			"<a href=\"${pageContext.request.contextPath}/"+ this.pathfile + "\" class='thumb'><img src=\"${pageContext.request.contextPath}/"+ this.pathfile + "\" ></a>" ));
	 		
	    		    		  });
	    		    		  $('#gallery1 a').lightBox();
    		       }); 
	  	    }
    	  });
	  }else{
		  $("#photo_gallery1").hide();
		  $("#page-selection1").hide();
	  }
	  
	  $('#page-selection1').bootpag({
		  total: count_total,
		  page: 1
		  }).on("page", function(event, num ){
			  
		       var id_folder =$("#dlg_thumuc_center_1").val();
		       $.ajax({
		         url: "ChuyenTrang?action=92&thumuc="+id_folder+"&page="+ (num-1)+"&chude=1&so_items=5",
		       }).done(function(data) {
    		    	   var codes = jQuery.parseJSON(data);
 		    		  $('#gallery1').html('');
 		    		  $(codes.rows).each(function() {
 		    			  $("#gallery1").append($("<li></li>").html(
		    		    			"<a href=\""+ this.pathfile + "\" class='thumb'><img src=\""+ this.pathfile + "\" ></a>" ));
		
 		    		  });
 		    		  $('#gallery1 a').lightBox();
		    	  });
		       }); 
    });
  
  $(document).on('change', '#dlg_thumuc_center_2', function() {
	  var id_folder =$("#dlg_thumuc_center_2").val();
	  if(id_folder != 0){
		  $("#photo_gallery2").show();
		  $("#page-selection2").show();
    	  $.ajax({
  	        url: "ChuyenTrang?action=91&thumuc="+this.value+"&chude=2",  
  	        type: "GET",
  	        async:false,
  	        error: function (request, status, error) {
	  	        alert(request.responseText);
	  	      },
	  	    success:function(data) {
	  	    	var jsonObject = JSON.parse(data);
	  	    	count_total = Math.ceil((jsonObject.rows[0].count) / 5) ;
	  	    	//alert(count_total);
	  	    	 $.ajax({
    		         url: "${pageContext.request.contextPath}/ChuyenTrang?action=92&thumuc="+id_folder+"&page=0&chude=2&so_items=5",
    		       }).done(function(data) {
    		    	   var codes = jQuery.parseJSON(data);
	    		    		   //alert( codes.rows);
 	    		    		  $('#gallery2').html('');
	    		    		  $(codes.rows).each(function() {
	    		    			  $("#gallery2").append($("<li ></li>").html(
	  		    		    			"<a href=\"${pageContext.request.contextPath}/"+ this.pathfile + "\" class='thumb'><img src=\"${pageContext.request.contextPath}/"+ this.pathfile + "\" ></a>" ));
	 		
	    		    		  });
	    		    		  $('#gallery2 a').lightBox();
    		       }); 
	  	    }
    	  });
	  }else{
		  $("#photo_gallery2").hide();
		  $("#page-selection2").hide();
	  }
	  
	  $('#page-selection2').bootpag({
		  total: count_total,
		  page: 1
		  }).on("page", function(event, num ){
			  
		       var id_folder =$("#dlg_thumuc_center_2").val();
		       $.ajax({
		         url: "ChuyenTrang?action=92&thumuc="+id_folder+"&page="+ (num-1)+"&chude=2&so_items=5",
		       }).done(function(data) {
    		    	   var codes = jQuery.parseJSON(data);
 		    		  $('#gallery2').html('');
 		    		  $(codes.rows).each(function() {
 		    			  $("#gallery2").append($("<li></li>").html(
		    		    			"<a href=\""+ this.pathfile + "\" class='thumb'><img src=\""+ this.pathfile + "\" ></a>" ));
		
 		    		  });
 		    		  $('#gallery2 a').lightBox();
		    	  });
		       }); 
    });
      
  });
  
  
  
</script>

<div class="Anh_content">
  <p class="Video_TitleVideo">Nông thôn mới: 
   <select  name="dlg_thumuc_center_1" id="dlg_thumuc_center_1"> 
  		<option selected="selected" value="0">--- Chọn thư mục ---</option>
  		<c:forEach var="thumuc_center" items="${thumuc_center}">
       		 <option value="${thumuc_center.id_folder}" >${thumuc_center.foldername}</option>
   	    </c:forEach>
   </select> </p>
  
  
  	<div class="photo_gallery1" id="photo_gallery1">
	   <ul id="gallery1">
	   		<c:forEach var="anh_NTM" items="${anh_NTM}">
	      	   <li><a href="${anh_NTM.pathfile}" class="thumb">
	      	   <img src="${anh_NTM.pathfile}"></a></li>
	      	</c:forEach>
	    </ul><div style="clear: both"> </div> 
    </div>
    <div id="page-selection1"></div>
</div>

<div class="Anh_content">
  <p class="Video_TitleVideo">Ứng dụng nghiên cứu đề tài 
  <select  name="dlg_thumuc_center_2" id="dlg_thumuc_center_2"> 
  		<option selected="selected" value="0">--- Chọn thư mục ---</option>
  		<c:forEach var="thumuc_center" items="${thumuc_center}">
       		 <option value="${thumuc_center.id_folder}" >${thumuc_center.foldername}</option>
   	    </c:forEach> 
  </select> </p>
  
  
  	<div class="photo_gallery2" id="photo_gallery2">
	   <ul id="gallery2">
	   	<c:forEach var="anh_KQNC" items="${anh_KQNC}">
	      	   <li><a href="${anh_KQNC.pathfile}" class="thumb">
	      	   <img src="${anh_KQNC.pathfile}"></a></li>
	      	</c:forEach>
	   </ul><div style="clear: both"> </div> 
    </div>
    <div id="page-selection2"></div>
</div>
