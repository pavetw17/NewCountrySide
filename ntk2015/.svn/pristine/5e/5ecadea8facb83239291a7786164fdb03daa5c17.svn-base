
$(document).ready( initBookmarks );

$(document).ready( initCollapsibleSections );

function deactivetool(){								
	document.body.style.cursor = 'default';
	map.getControl("ZoomIn").box.deactivate();
	map.getControl("ZoomOut").box.deactivate();
	map.events.unregister("click",map,getDynamic);
	map.events.unregister("click",map,getReport);
	map.events.unregister("click",map,getDubao);
	map.events.unregister("click",map,getRender);  
	map.events.unregister("click",map,getInfo);
	map.events.unregister("click",map,getChart);
	panel.activateControl(panel.controls[0]);
};

function initBookmarks () {
	// Table of Contents links
	$("#TOC")
		.find(".tocBtn").click( toggleTOC ).end()
		.find("A").click( scrollToBookmark )
		//.find("A").click( showCollapsibleSection ) // OLD
	;
	// Links in the center pane
	$("DIV.ui-layout-center A[href*=#]").click( scrollToBookmark );
	//.click( showCollapsibleSection );
};

function toggleTOC () {
	var $Btn = $(this);
	var $List = $(this).siblings("UL");
	if ($List.is(":visible")) {
		$List
			.css("width", $List.innerWidth())
			.slideUp('fast', function() {$(this).css("width","auto");})
		;
		$Btn.css({ backgroundImage: 'url("/lib/img/icon_tree_on.gif")' });
	}
	else {
		$List.slideDown('fast');
		$Btn.css({ backgroundImage: 'url("/lib/img/icon_tree_off.gif")' });
	}
};

function scrollToBookmark ( hash ) {
	// if triggered by A.click binding...
	if (hash == undefined || hash == '')
		return true;
	else if (typeof hash != 'string') {
		if (location.pathname.replace(/^\//,'') != this.pathname.replace(/^\//,'')
			|| location.hostname != this.hostname
		)
			return true;
		else {
			hash = this.hash;
			if (!hash || !hash.length) return true;
		}
	}

	// make sure section is 'open'
	showCollapsibleSection( hash );

	var $Pane	= $('.ui-layout-center');
	var $Target = $(hash);
	$Target = $Target.length && $Target || $('[name='+ hash.slice(1) +']');
	if ($Target.length) {
		var targetTop = $Target.offset().top;
		var paneTop = $Pane.offset().top;
		// absolute scrolling - ALWAYS from the top!
		//$Pane.animate({ scrollTop: targetTop +'px' }, 1000, 'linear', function(){
		// relative scrolling
		$Pane.animate({ scrollTop: '+='+ (targetTop - paneTop) +'px' }, 1000, 'linear', function(){
			self.location.replace( hash ); // make sure we scroll ALL the way!
		});
		return false; // cancel normal hyperlink
	}
};

function closeAllSections () {
	$('DIV.collapsible').hide();
	$('SPAN.expander')
		.removeClass("expander_open")
		.addClass("expander_closed")
	;
	return false; // cancel hyperlink
};

function openAllSections () {
	$('DIV.collapsible').show();
	$('SPAN.expander')
		.removeClass("expander_closed")
		.addClass("expander_open")
	;
	return false; // cancel hyperlink
};

function showCollapsibleSection (hash) {
	if (pageLayout && pageLayout.state.west.isSliding)
		pageLayout.close('west', true, true); // close Contents after selection - 2nd true = noAnimation
	var
		id = (typeof hash=="string" ? hash : $(this).attr("href"))
	,	$Heading = $( id )
	,	$Section = $Heading.next()
	;
	if ($Heading.attr("tagName") != "H2")
		$Section = $Heading.parent().prev("H2").next(); // find main topic (H2)
	$Section.show(); // make sure section is not collapsed
};

function toggleCollapsibleSection () {
	var
		bookmark	= "#"+ this.id
	,	$Button		= $(this).children("SPAN.expander")
	,	$Section	= $(this).next()
	,	isVisible	= $Section.is(":visible")
	;
	$Button.removeClass("expander_open expander_closed");
	$Button.addClass(isVisible ? "expander_closed" : "expander_open");
	if (isVisible) {
		// use the cssWidth() if available - else use *inaccurate* innerWidth() method
		var innerWidth = (pageLayout) ? pageLayout.cssWidth($Section) : $Section.innerWidth()-6; // remove 2x3px padding
		$Section.css("width", innerWidth);
	}
	else
		self.location.replace( bookmark ); // scroll heading to top of page
	$Section.slideToggle('slow', function(){
		$Section.css("width","auto"); // RESET width
		if (!isVisible) self.location.replace( bookmark ); // scroll heading AGAIN
	}); 
};

function initCollapsibleSections () {
	$("DIV.collapsible")
		.hide()
		.prev("H2")
			.prepend("<span class='expander expander_closed' title='Expand/Collapse'></span>")
			.css({ cursor: "pointer" })
			.attr("title","Expand/Collapse")
			.hover(
				function() { $(this).next().addClass("highlightCollapsible"); }
			,	function() { $(this).next().removeClass("highlightCollapsible"); }
			)
			.click( toggleCollapsibleSection )
	;
};

function DialogShow(url, width, height,idtext) {
	var left = (screen.width - width) / 2;
	var top = (screen.height - height) / 2;
	var params = "width=" + width + ", height=" + height;
	params += ", top=" + top + ", left=" + left;
	params += ", directories=no";
	params += ", location=no";
	params += ", menubar=yes";
	params += ", resizable=yes";
	params += ", scrollbars=yes";
	params += ", status=no";
	params += ", toolbar=yes";
	win = window.open(url, idtext, params, "_blank");
	if (window.focus) {
		win.focus();
	}
};

function showLoading() {
    var x = ($(window).width() - 32) / 2;
    var y = ($(window).height() - 32) / 2;
    $("#loading").css({left: x+'px',top: y+'px'});
    $("#loading").show();
};
function hideLoading() {
    $("#loading").hide();
};

function showHide (id)
{
	var style = document.getElementById(id).style;
	if (style.visibility == "hidden")		
		style.visibility = "visible";
	else
		style.visibility = "hidden";
} 

function cwrs_InitDialog(dlgName, dlgHtml){$("#"+ dlgName).load(dlgHtml, function(response, status, xhr){if (status == "error"){}});};
var getHuonggio = function(txtHuonggio){var index=-1;if(txtHuonggio == "Không có gió"){index=0;}else if(txtHuonggio == "Bắc"){index=1;}else if(txtHuonggio == "Nam"){index=2;}else if(txtHuonggio == "Đông"){index=3;}else if(txtHuonggio == "Tây"){index=4;}else if(txtHuonggio == "Đông Bắc"){index=5;}else if(txtHuonggio == "Tây Bắc"){index=6;}else if(txtHuonggio == "Đông Nam"){index=7;}else if(txtHuonggio == "Tây Nam"){index=8;}return index;};
var getToday = function(){var currentTime = new Date(); var month = parseInt(currentTime.getMonth() + 1); month = month <= 9 ? "0"+month : month; var day = currentTime.getDate(); day = day <= 9 ? "0"+day : day; var year = currentTime.getFullYear(); return day+"/"+month + "/"+year;};
var getTralua = function(txtTra){var index=-1;if(txtTra == "Trà sớm"){index=0;}else if(txtTra == "Trà chính vụ"){index=1;}else if(txtTra == "Trà muộn"){index=2;}return index;};
var getCachbon = function(txtCachbon){var index=-1;if(txtCachbon == "Bón lót"){index=1;}else if(txtCachbon == "Bón thúc 1"){index=2;}else if(txtCachbon == "Bón thúc 2"){index=3;}return index;};
var getVulua = function(txtVu){var index=-1;if(txtVu == "Đông xuân"){index=0;}else if(txtVu == "Hè thu"){index=1;}else if(txtVu == "Mùa"){index=2;}else if(txtVu == "Thu đông"){index=3;}return index;};