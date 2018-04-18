<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
  $(function() {
  var count_total = 0; <%--chude=2: nghien cuu de tai du an --%>
  
  function getParameterByName(name,url) {
	    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	        results = regex.exec(url);
	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
  }
  
  
  $(document).on('click','.LinkNomal',function(e){
	  e.preventDefault();
	  var url = $(this).attr('href');
	  var chude = getParameterByName('chude',url);
	  $.ajax({
	        url: url,  
	        type: "GET",
	        async:false,
	        error: function (request, status, error) {
	  	        alert(request.responseText);
	  	      },
	  	    success:function(data) {
	  	    	var codes = jQuery.parseJSON(data);
	  	    	if(chude === '1'){
		  	    	$('#video_TitleVideo1').html(codes.rows[0].tenanh);
		  	    	$('#watch_Video1').attr('src',codes.rows[0].pathfile); 
	  	    	}else{
	  	    		$('#video_TitleVideo2').html(codes.rows[0].tenanh);
		  	    	$('#watch_Video2').attr('src',codes.rows[0].pathfile); 
	  	    	}
	  	    }
	  });
  });

  $(document).on('change', '#dlg_thumuc_center_1', function() {
	  var id_folder =$("#dlg_thumuc_center_1").val();
	
	  if(id_folder != 0){
		  $("#video_gallery1").show();
		  $("#page-selection1").show();
    	  $.ajax({
  	        url: "ChuyenTrang?action=81&thumuc="+this.value+"&chude=1",  
  	        type: "GET",
  	        async:false,
  	        error: function (request, status, error) {
	  	        alert(request.responseText);
	  	      },
	  	    success:function(data) {
	  	    	var jsonObject = JSON.parse(data);
	  	    	if(jsonObject.rows[0].count > 0 ){
		  	    	count_total = Math.ceil((jsonObject.rows[0].count) / 5) ;
		  	    	//alert( count_total);
		  	    	 $.ajax({
	    		         url: "${pageContext.request.contextPath}/ChuyenTrang?action=82&thumuc="+id_folder+"&page=0&chude=1&so_items=5",
	    		       }).done(function(data) {
	    		    	   var codes = jQuery.parseJSON(data);
		    		    		   //alert( codes.rows);
	 	    		    		  $('#gallery1').html('');
		    		    		  $(codes.rows).each(function() {
		    		    			  $("#gallery1").append($("<li class='Video_li'></li>").html(
		  		    		    			"<div class='Video_content'><a href=\"${pageContext.request.contextPath}/ChuyenTrang?action=83&chude=1&thumuc="+ this.id_folder +"&so_id=" + this.id_picture + "\" class='LinkNomal'>"+ this.tenanh +"</a></div>" ));
		    		    		  });
	    		       });
	  	    	}else{
	  	    		$('#gallery1').html('');
	  	    		$("#gallery1").append("Không có dữ liệu!");
	  	    	}
	  	    }
    	  });
	  }else{
		  $("#video_gallery1").hide();
		  $("#page-selection1").hide();
	  }
	  
	  $('#page-selection1').bootpag({
		  total: count_total,
		  page: 1
		  }).on("page", function(event, num ){
			  
		       var id_folder =$("#dlg_thumuc_center_1").val();
		       $.ajax({
		         url: "ChuyenTrang?action=82&thumuc="+id_folder+"&page="+ (num-1)+"&chude=1&so_items=5",
		       }).done(function(data) {
    		    	   var codes = jQuery.parseJSON(data);
    		    	   $('#gallery1').html('');
 		    		  $(codes.rows).each(function() {
 		    			  $("#gallery1").append($("<li class='Video_li'></li>").html(
		    		    			"<div class='Video_content'><a href=\"${pageContext.request.contextPath}/ChuyenTrang?action=83&chude=1&thumuc="+ this.id_folder +"&so_id=" + this.id_picture + "\" class='LinkNomal'>"+ this.tenanh +"</a></div>" ));
 		    		  });
		    	  });
		       }); 
    });
  
  
  $(document).on('change', '#dlg_thumuc_center_2', function() {
	  var id_folder =$("#dlg_thumuc_center_2").val();
	  if(id_folder != 0){
		  $("#video_gallery2").show();
		  $("#page-selection2").show();
    	  $.ajax({
  	        url: "ChuyenTrang?action=81&thumuc="+this.value+"&chude=2",  
  	        type: "GET",
  	        async:false,
  	        error: function (request, status, error) {
	  	        alert(request.responseText);
	  	      },
	  	    success:function(data) {
	  	    	var jsonObject = JSON.parse(data);
	  	    	if(jsonObject.rows[0].count > 0 ){
		  	    	count_total = Math.ceil((jsonObject.rows[0].count) / 5) ;
		  	    	//alert( count_total);
		  	    	 $.ajax({
	    		         url: "${pageContext.request.contextPath}/ChuyenTrang?action=82&thumuc="+id_folder+"&page=0&chude=2&so_items=5",
	    		       }).done(function(data) {
	    		    	   var codes = jQuery.parseJSON(data);
		    		    		   //alert( codes.rows);
	 	    		    		  $('#gallery2').html('');
		    		    		  $(codes.rows).each(function() {
		    		    			  $("#gallery2").append($("<li class='Video_li'></li>").html(
		  		    		    			"<div class='Video_content'><a href=\"${pageContext.request.contextPath}/ChuyenTrang?action=83&chude=2&thumuc="+ this.id_folder +"&so_id=" + this.id_picture + "\" class='LinkNomal'>"+ this.tenanh +"</a></div>" ));
		    		    		  });
	    		       });
	  	    	}else{
	  	    		$('#gallery2').html('');
	  	    		$("#gallery2").append("Không có dữ liệu!");
	  	    	}
	  	    }
    	  });
	  }else{
		  $("#video_gallery2").hide();
		  $("#page-selection2").hide();
	  }
	  
	  $('#page-selection2').bootpag({
		  total: count_total,
		  page: 1
		  }).on("page", function(event, num ){
			  
		       var id_folder =$("#dlg_thumuc_center_1").val();
		       $.ajax({
		         url: "ChuyenTrang?action=82&thumuc="+id_folder+"&page="+ (num-1)+"&chude=2&so_items=5",
		       }).done(function(data) {
    		    	   var codes = jQuery.parseJSON(data);
    		    	   $('#gallery2').html('');
 		    		  $(codes.rows).each(function() {
 		    			  $("#gallery2").append($("<li class='Video_li'></li>").html(
		    		    			"<div class='Video_content'><a href=\"${pageContext.request.contextPath}/ChuyenTrang?action=83&chude=2&thumuc="+ this.id_folder +"&so_id=" + this.id_picture + "\" class='LinkNomal'>"+ this.tenanh +"</a></div>" ));
 		    		  });
		    	  });
		       }); 
    });
  
  });
</script>
<div>
			<br>
			<div>
			    <strong>Nông thôn mới:</strong>
			    <select name="dlg_thumuc_center_1" id="dlg_thumuc_center_1">
			    <option selected="selected" value="0">--- Chọn thư mục ---</option>
			    	<c:forEach var="thumuc_center" items="${thumuc_center}">
			       		 <option value="${thumuc_center.id_folder}" >${thumuc_center.foldername}</option>
			   	    </c:forEach>
			    </select>
			</div>
			<div>
			    <c:forEach var="list" items="${video_NTM}" varStatus="loopStatus">
				      <c:choose>
					       <c:when test="${loopStatus.index=='0'}">
								<div class="Video_album_left" >
									  <div class="Video_content_video">
									    <p class="Video_TitleVideo" id="video_TitleVideo1">${list.tenanh}</p>
									    <br>
									  	<iframe id="watch_Video1"width="600" height="400" src="${list.pathfile}" frameborder="0" allowfullscreen></iframe>
									  </div>
								</div>
								<br>
							<br>
							<div class="Video_album_right">
								 <div class="Video_formstyle">
								   <span id="VideoID_Label1">Các video theo thư mục</span>
								 </div>
								 <div id="video_gallery1" style="height: 370px; width: 272px ; margin: 5px 0 0 0 ">
								    <ul id="gallery1">
								     <li class="Video_li">
								     		<div class="Video_content"><a class="LinkNomal" href="${pageContext.request.contextPath}/ChuyenTrang?action=83&thumuc=${list.id_folder}&so_id=${list.id_picture}&chude=1">
				                                ${list.tenanh}</a>
				                                </div>
				                         </li>
					      </c:when>
								      <c:otherwise>
									      <li class="Video_li"> <div class="Video_content">
									          <a class="LinkNomal" href="${pageContext.request.contextPath}/ChuyenTrang?action=83&thumuc=${list.id_folder}&so_id=${list.id_picture}&chude=1">${list.tenanh}</a>
									     </div> </li>
								      </c:otherwise>
				      </c:choose>
			 	</c:forEach>
				    </ul>
				    </div>
				    </div>
			</div>
 			<div id="page-selection1"></div>
</div>

<div>
		 <div style="float: left;">
		    <strong>Ứng dụng nghiên cứu đề tài:</strong>
		    <select name="dlg_thumuc_center_2" id="dlg_thumuc_center_2">
		    <option selected="selected" value="0">--- Chọn thư mục ---</option>
		    	<c:forEach var="thumuc_center" items="${thumuc_center}">
		       		 <option value="${thumuc_center.id_folder}" >${thumuc_center.foldername}</option>
		   	    </c:forEach>
		    </select>
		</div>  
		<c:forEach var="list" items="${video_KQNC}" varStatus="loopStatus">
			      <c:choose>
				       <c:when test="${loopStatus.index=='0'}">
							<div class="Video_album_left" >
								  <div class="Video_content_video">
								    <p class="Video_TitleVideo" id="video_TitleVideo2">${list.tenanh}</p>
								    <br>
								  	<iframe id="watch_Video2"width="600" height="400" src="${list.pathfile}" frameborder="0" allowfullscreen></iframe>
								  </div>
							</div>
							<br>
						<br>
						<div class="Video_album_right">
							 <div class="Video_formstyle">
							   <span id="VideoID_Label2">Các video theo thư mục</span>
							 </div>
							 <div id="video_gallery2" style="height: 370px; width: 272px ; margin: 5px 0 0 0 ">
							    <ul id="gallery2">
							     <li class="Video_li">
							     <div class="Video_content"><a class="LinkNomal" href="${pageContext.request.contextPath}/ChuyenTrang?action=83&thumuc=${list.id_folder}&so_id=${list.id_picture}&chude=2">
			                                ${list.tenanh}</a>
			                                </div></li>
				      </c:when>
							      <c:otherwise>
								      <li class="Video_li"> <div class="Video_content">
								          <a class="LinkNomal" href="${pageContext.request.contextPath}/ChuyenTrang?action=83&thumuc=${list.id_folder}&so_id=${list.id_picture}&chude=2">${list.tenanh}</a>
								     </div> </li>
							      </c:otherwise>
			      </c:choose>
 		</c:forEach>
				 </ul>
				     </div>
				    </div>
		 <div id="page-selection2"></div> 
		</div>