<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
    <strong>Bảng biểu cấp kinh phí</strong>
    <input TYPE="BUTTON" NAME="" VALUE="Tìm" style="margin-bottom: 5px;margin-top: 10px; height: 24px"  onclick="XuatHtml(1)">
</div>
<iframe id="dlg_bangbieu_capkinhphi_show_html" scrolling="no" frameborder="0" ></iframe>
<script>
    
  
    var iFrames = $('dlg_bangbieu_capkinhphi_show_html');
	function iResize() {
	
		for (var i = 0, j = iFrames.length; i < j; i++) {
		  iFrames[i].style.height = iFrames[i].contentWindow.document.body.offsetHeight + 'px';}
	    }
	    
    	if ($.browser.safari || $.browser.opera) { 
    	
    	   iFrames.load(function(){
    	       setTimeout(iResize, 0);
           });
        
    	   for (var i = 0, j = iFrames.length; i < j; i++) {
    			var iSource = iFrames[i].src;
    			iFrames[i].src = '';
    			iFrames[i].src = iSource;
           }
           
    	} else {
    	   iFrames.load(function() { 
    	       this.style.height = this.contentWindow.document.body.offsetHeight + 'px';
    	   });
    	}
    	
    	function XuatHtml(maXuat){
    		   try {
    			  $.ajax({
    			        url: root_href + HOME_SERVLET + 'action='+ ACT_GET_DATA_FORM_BANGBIEU_CAPKINHPHI, 
    			        data:{
    			        	maXuat: maXuat,
    			        }, 
    			        async:false,
    			        success:function(jsonData) {
    			        	alert(jsonData);
    			        	//iResize();
    			        	$('#dlg_bangbieu_capkinhphi_show_html').attr('src', "${pageContext.request.contextPath}"+"/"+jsonData);
    					  return;
    			        }});
    		    } catch (err) {
    		      alert("XuatHtml have : " + err);
    		    }
    		  
    	  }
    
  
  
  
  function func_dlg_quanly_bangbieu_capkinhphi() {
	  try{
      $('#dlg_bangbieu_capkinhphi_show').dialog({
        title: "Bảng biểu cấp tiến độ ",
        modal: false, open: function () {
          $(this).dialog('widget').draggable('option', {containment: false});
        },
        height: 450,
        width: 920,
        collapsible: true,
        draggable: true,
        resizable: false,
        position:[230,100],
        buttons: {
          "Đóng": function () {
            $(this).dialog("close");
          }
        },
        close: function () {

        }
      });
    } catch (err) {
      alert("func_dlg_quanly_bangbieu_capkinhphi have dlg_bangbieu_capkinhphi_show: " + err);
    }
  }

 
</script>
    