<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html><!--[if IE 8]>
<html lang="en" class="ie8"></html><![endif]--><!--[if IE 9]>
<html lang="en" class="ie9"></html><![endif]--><!--[if !IE]><!-->
<html lang="en"><!--<![endif]-->
<head>
  <meta charset="utf-8"/>
  <title>Blank Page</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
  <meta content="" name="description"/>
  <meta content="" name="author"/>
  <link href="<%=request.getContextPath()%>/quantri/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="<%=request.getContextPath()%>/quantri/assets/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet"/>
  <link href="<%=request.getContextPath()%>/quantri/assets/bootstrap/css/bootstrap-fileupload.css" rel="stylesheet"/>
  <link href="<%=request.getContextPath()%>/quantri/assets/font/font-awesome.min.css" rel="stylesheet"/>
  <link href="<%=request.getContextPath()%>/quantri/css/style.min.css" rel="stylesheet"/>
  <link href="<%=request.getContextPath()%>/quantri/css/style_responsive.css" rel="stylesheet"/>
  <link href="<%=request.getContextPath()%>/quantri/css/style_default.css" rel="stylesheet" id="style_color"/>
  <link href="<%=request.getContextPath()%>/quantri/css/jquery-ui-timepicker-addon.min.css" rel="stylesheet"/>
  <%-- <link href="assets/fancybox/source/jquery.fancybox.css" rel="stylesheet"/>
   <link rel="stylesheet" type="text/css" href="assets/uniform/css/uniform.default.css"/>--%>



  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <title> <tiles:insertAttribute name="title" /> </title>
</head>

<body class="fixed-top">
<tiles:insertAttribute name="header"/>
<div id="container" class="row-fluid">
  <div id="sidebar" class="nav-collapse collapse">
    <tiles:insertAttribute name="left"/>
  </div>
  <div id="main-content">
    <tiles:insertAttribute name="content"/>
  </div>
</div>
<div id="footer">
  <tiles:insertAttribute name="footer"/>
</div>
<script src="<%=request.getContextPath()%>/quantri/js/jquery-1.8.3.min.js"></script> 
<script src="<%=request.getContextPath()%>/quantri/assets/bootstrap/js/bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/quantri/js/jquery.blockui.js"></script>
<!--[if lt IE 9]>
<script src="../../quantri/js/excanvas.js"></script>
<script src="../../quantri/js/respond.js"></script><![endif]-->
<script type="text/javascript" src="<%=request.getContextPath()%>/quantri/assets/chosen-bootstrap/chosen/chosen.jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/quantri/assets/uniform/jquery.uniform.min.js"></script>
<script src="<%=request.getContextPath()%>/quantri/js/scripts.js"></script>




<!-- Datagrid  -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/components/datagrid/easyui.css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/components/datagrid/jquery.easyui.datagrid.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/components/datagrid/jquery.easyui.window.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/components/datagrid/icon.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/jquery-ui-1.10.4.min.css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-ui-1.8.23.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/quantri/js/jquery-ui-timepicker-addon.min.js"></script>

<!-- Core -->
<%--
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/lib/jquery-ui-1.8.16.min.base.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/lib/jquery-ui-1.8.16.min.more.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/lib/jquery.layout.1.3.0.js"></script>--%>

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/cwrs/utils.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/cwrs/Map.js"></script>  <%--use for utils.js--%>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/cwrs/definitions.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/cwrs/dialogs.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/cwrs/validate.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/bvtv/check.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/lib/JsSimpleDateFormat.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/cwrs/classes.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/cwrs/global.js"></script>  <%-- hien thong bao --%>

<!-- Zebra -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/components/zebra/css/zebra_dialog.css" media="screen" />
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/components/zebra/zebra_dialog.js"></script>


<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/SimpleAjaxUploader.min.js"></script>
 <script type='text/javascript' src='<%=request.getContextPath()%>/resources/tiny_mce/tiny_mce.js'></script>

<script>

$(document).ready(function () {
	gm = new GenericManager(true);  
	App.init();
	
	$(document).on('focus',".datepicker", function(){
		$(this).datepicker({
				dateFormat: "dd/mm/yy",
				changeMonth : true,
				changeYear : true,
				yearRange : '2015:2025',
		}).attr("readonly","readonly");
	});
	 
	$(document).on('submit',"form", function(e){
		  e.preventDefault();
	});
	
	$.widget( "ui.combobox", {
		 _create: function() {
		        var self = this,
		            select = this.element.hide(),
		            selected = select.children(":selected"),
		            value = selected.val() ? selected.text() : "";
		        var input = this.input = $("<input style='width:300px; border-bottom-left-radius:0px ;border-top-left-radius:0px; margin-bottom: 10px;'>").insertAfter(select).val(value).autocomplete({
		            delay: 0,
		            minLength: 0,
		            source: function(request, response) {
		                var matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i");
		                response(select.children("option").map(function() {
		                    var text = $(this).text();
		                    if (this.value && (!request.term || matcher.test(text))) return {
		                        label: text.replace(
		                        new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + $.ui.autocomplete.escapeRegex(request.term) + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>"),
		                        value: text,
		                        option: this
		                    };
		                }));
		            },
		            select: function(event, ui) {
		                ui.item.option.selected = true;
		                self._trigger("selected", event, {
		                    item: ui.item.option
		                });
		                select.trigger("change"); 
		            },
		            change: function(event, ui) {
		                if (!ui.item) {
		                    var matcher = new RegExp("^" + $.ui.autocomplete.escapeRegex($(this).val()) + "$", "i"),
		                        valid = false;
		                    select.children("option").each(function() {
		                        if ($(this).text().match(matcher)) {
		                            this.selected = valid = true;
		                            return false;
		                        }
		                    });
		                    if (!valid) {
		                        // remove invalid value, as it didn't match anything
		                        $(this).val("");
		                        select.val("");
		                        input.data("autocomplete").term = "";
		                        return false;
		                    }
		                }
		            }
		        }).addClass("ui-widget ui-widget-content ui-corner-left");

		        input.data("autocomplete")._renderItem = function(ul, item) {
		            return $("<li></li>").data("item.autocomplete", item).append("<a>" + item.label + "</a>").appendTo(ul);
		        };

		       <%-- this.button = $("<button type='button'>&nbsp;</button>").attr("tabIndex", -1).attr("title", "Show All Items").insertAfter(input).button({
		            icons: {
		                primary: "ui-icon-triangle-1-s"
		            },
		            text: false
		        }).removeClass("ui-corner-all").addClass("ui-corner-right ui-button-icon").click(function() {
		            // close if already visible
		            if (input.autocomplete("widget").is(":visible")) {
		                input.autocomplete("close");
		                return;
		            }

		            // work around a bug (likely same cause as #5265)
		            $(this).blur();

		            // pass empty string as value to search for, displaying all results
		            input.autocomplete("search", "");
		            input.focus();
		        }); --%>
		    },

		    destroy: function() {
		        this.input.remove();
		        this.button.remove();
		        this.element.show();
		        $.Widget.prototype.destroy.call(this);
		    },
		    autocomplete : function(value) {
		        this.element.val(value);
		        var selected = this.element.children(":selected");
		        value = selected.val() ? selected.text() : "";
		        this.input.val(value);
		    }
		
	}); 
	
});</script>

</body>