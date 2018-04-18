/**
 * jQuery EasyUI 1.2.5
 * 
 * Licensed under the GPL terms
 * To use it on other terms please contact us
 *
 * Copyright(c) 2009-2011 stworthy [ stworthy@gmail.com ] 
 * 
 */

/**Parser*/
(function($){
$.parser={auto:true,onComplete:function(_1){
},plugins:["linkbutton","menu","menubutton","splitbutton","progressbar","tree","combobox","combotree","numberbox","validatebox","searchbox","numberspinner","timespinner","calendar","datebox","datetimebox","layout","panel","datagrid","propertygrid","treegrid","tabs","accordion","window","dialog"],parse:function(_2){
var aa=[];
for(var i=0;i<$.parser.plugins.length;i++){
var _3=$.parser.plugins[i];
var r=$(".easyui-"+_3,_2);
if(r.length){
if(r[_3]){
r[_3]();
}else{
aa.push({name:_3,jq:r});
}
}
}
if(aa.length&&window.easyloader){
var _4=[];
for(var i=0;i<aa.length;i++){
_4.push(aa[i].name);
}
easyloader.load(_4,function(){
for(var i=0;i<aa.length;i++){
var _5=aa[i].name;
var jq=aa[i].jq;
jq[_5]();
}
$.parser.onComplete.call($.parser,_2);
});
}else{
$.parser.onComplete.call($.parser,_2);
}
}};
$(function(){
if(!window.easyloader&&$.parser.auto){
$.parser.parse();
}
});
})(jQuery);


 /**resizeable */
 (function($){
var _1=false;
$.fn.resizable=function(_2,_3){
if(typeof _2=="string"){
//return $.fn.resizable.methods[_2](this,_3);
}
function _4(e){
var _5=e.data;
var _6=$.data(_5.target,"resizable").options;
if(_5.dir.indexOf("e")!=-1){
var _7=_5.startWidth+e.pageX-_5.startX;
_7=Math.min(Math.max(_7,_6.minWidth),_6.maxWidth);
_5.width=_7;
}
if(_5.dir.indexOf("s")!=-1){
var _8=_5.startHeight+e.pageY-_5.startY;
_8=Math.min(Math.max(_8,_6.minHeight),_6.maxHeight);
_5.height=_8;
}
if(_5.dir.indexOf("w")!=-1){
_5.width=_5.startWidth-e.pageX+_5.startX;
if(_5.width>=_6.minWidth&&_5.width<=_6.maxWidth){
_5.left=_5.startLeft+e.pageX-_5.startX;
}
}
if(_5.dir.indexOf("n")!=-1){
_5.height=_5.startHeight-e.pageY+_5.startY;
if(_5.height>=_6.minHeight&&_5.height<=_6.maxHeight){
_5.top=_5.startTop+e.pageY-_5.startY;
}
}
};
function _9(e){
var _a=e.data;
var _b=_a.target;
if($.boxModel==true){
$(_b).css({width:_a.width-_a.deltaWidth,height:_a.height-_a.deltaHeight,left:_a.left,top:_a.top});
}else{
$(_b).css({width:_a.width,height:_a.height,left:_a.left,top:_a.top});
}
};
function _c(e){
_1=true;
$.data(e.data.target,"resizable").options.onStartResize.call(e.data.target,e);
return false;
};
function _d(e){
_4(e);
if($.data(e.data.target,"resizable").options.onResize.call(e.data.target,e)!=false){
_9(e);
}
return false;
};
function _e(e){
_1=false;
_4(e,true);
_9(e);
$.data(e.data.target,"resizable").options.onStopResize.call(e.data.target,e);
$(document).unbind(".resizable");
$("body").css("cursor","auto");
return false;
};
return this.each(function(){
var _f=null;
var _10=$.data(this,"resizable");
if(_10){
$(this).unbind(".resizable");
_f=$.extend(_10.options,_2||{});
}else{
_f=$.extend({},$.fn.resizable.defaults,_2||{});
$.data(this,"resizable",{options:_f});
}
if(_f.disabled==true){
return;
}
$(this).bind("mousemove.resizable",{target:this},function(e){
if(_1){
return;
}
var dir=_11(e);
if(dir==""){
$(e.data.target).css("cursor","");
}else{
$(e.data.target).css("cursor",dir+"-resize");
}
}).bind("mousedown.resizable",{target:this},function(e){
var dir=_11(e);
if(dir==""){
return;
}
function _12(css){
var val=parseInt($(e.data.target).css(css));
if(isNaN(val)){
return 0;
}else{
return val;
}
};
var _13={target:e.data.target,dir:dir,startLeft:_12("left"),startTop:_12("top"),left:_12("left"),top:_12("top"),startX:e.pageX,startY:e.pageY,startWidth:$(e.data.target).outerWidth(),startHeight:$(e.data.target).outerHeight(),width:$(e.data.target).outerWidth(),height:$(e.data.target).outerHeight(),deltaWidth:$(e.data.target).outerWidth()-$(e.data.target).width(),deltaHeight:$(e.data.target).outerHeight()-$(e.data.target).height()};
$(document).bind("mousedown.resizable",_13,_c);
$(document).bind("mousemove.resizable",_13,_d);
$(document).bind("mouseup.resizable",_13,_e);
$("body").css("cursor",dir+"-resize");
}).bind("mouseleave.resizable",{target:this},function(e){
$(e.data.target).css("cursor","");
});
function _11(e){
var tt=$(e.data.target);
var dir="";
var _14=tt.offset();
var _15=tt.outerWidth();
var _16=tt.outerHeight();
var _17=_f.edge;
if(e.pageY>_14.top&&e.pageY<_14.top+_17){
dir+="n";
}else{
if(e.pageY<_14.top+_16&&e.pageY>_14.top+_16-_17){
dir+="s";
}
}
if(e.pageX>_14.left&&e.pageX<_14.left+_17){
dir+="w";
}else{
if(e.pageX<_14.left+_15&&e.pageX>_14.left+_15-_17){
dir+="e";
}
}
var _18=_f.handles.split(",");
for(var i=0;i<_18.length;i++){
var _19=_18[i].replace(/(^\s*)|(\s*$)/g,"");
if(_19=="all"||_19==dir){
return dir;
}
}
return "";
};
});
};
$.fn.resizable.methods={options:function(jq){
return $.data(jq[0],"resizable").options;
},enable:function(jq){
return jq.each(function(){
$(this).resizable({disabled:false});
});
},disable:function(jq){
return jq.each(function(){
$(this).resizable({disabled:true});
});
}};
$.fn.resizable.defaults={disabled:false,handles:"n, e, s, w, ne, se, sw, nw, all",minWidth:10,minHeight:10,maxWidth:10000,maxHeight:10000,edge:5,onStartResize:function(e){
},onResize:function(e){
},onStopResize:function(e){
}};
})(jQuery);
 
 /**Panel*/
(function($){
function _1(_2){
_2.each(function(){
$(this).remove();
if($.browser.msie){
this.outerHTML="";
}
});
};
function _3(_4,_5){
var _6=$.data(_4,"panel").options;
var _7=$.data(_4,"panel").panel;
var _8=_7.children("div.panel-header");
var _9=_7.children("div.panel-body");
if(_5){
if(_5.width){
_6.width=_5.width;
}
if(_5.height){
_6.height=_5.height;
}
if(_5.left!=null){
_6.left=_5.left;
}
if(_5.top!=null){
_6.top=_5.top;
}
}
if(_6.fit==true){
var p=_7.parent();
_6.width=p.width();
_6.height=p.height();
}
_7.css({left:_6.left,top:_6.top});
if(!isNaN(_6.width)){
if($.boxModel==true){
_7.width(_6.width-(_7.outerWidth()-_7.width()));
}else{
_7.width(_6.width);
}
}else{
_7.width("auto");
}
if($.boxModel==true){
_8.width(_7.width()-(_8.outerWidth()-_8.width()));
_9.width(_7.width()-(_9.outerWidth()-_9.width()));
}else{
_8.width(_7.width());
_9.width(_7.width());
}
if(!isNaN(_6.height)){
if($.boxModel==true){
_7.height(_6.height-(_7.outerHeight()-_7.height()));
_9.height(_7.height()-_8.outerHeight()-(_9.outerHeight()-_9.height()));
}else{
_7.height(_6.height);
_9.height(_7.height()-_8.outerHeight());
}
}else{
_9.height("auto");
}
_7.css("height","");
_6.onResize.apply(_4,[_6.width,_6.height]);
_7.find(">div.panel-body>div").triggerHandler("_resize");
};
function _a(_b,_c){
var _d=$.data(_b,"panel").options;
var _e=$.data(_b,"panel").panel;
if(_c){
if(_c.left!=null){
_d.left=_c.left;
}
if(_c.top!=null){
_d.top=_c.top;
}
}
_e.css({left:_d.left,top:_d.top});
_d.onMove.apply(_b,[_d.left,_d.top]);
};
function _f(_10){
var _11=$(_10).addClass("panel-body").wrap("<div class=\"panel\"></div>").parent();
_11.bind("_resize",function(){
var _12=$.data(_10,"panel").options;
if(_12.fit==true){
_3(_10);
}
return false;
});
return _11;
};
function _13(_14){
var _15=$.data(_14,"panel").options;
var _16=$.data(_14,"panel").panel;
if(_15.tools&&typeof _15.tools=="string"){
_16.find(">div.panel-header>div.panel-tool .panel-tool-a").appendTo(_15.tools);
}
_1(_16.children("div.panel-header"));
if(_15.title&&!_15.noheader){
var _17=$("<div class=\"panel-header\"><div class=\"panel-title\">"+_15.title+"</div></div>").prependTo(_16);
if(_15.iconCls){
_17.find(".panel-title").addClass("panel-with-icon");
$("<div class=\"panel-icon\"></div>").addClass(_15.iconCls).appendTo(_17);
}
var _18=$("<div class=\"panel-tool\"></div>").appendTo(_17);
if(_15.tools){
if(typeof _15.tools=="string"){
$(_15.tools).children().each(function(){
$(this).addClass($(this).attr("iconCls")).addClass("panel-tool-a").appendTo(_18);
});
}else{
for(var i=0;i<_15.tools.length;i++){
var t=$("<a href=\"javascript:void(0)\"></a>").addClass(_15.tools[i].iconCls).appendTo(_18);
if(_15.tools[i].handler){
t.bind("click",eval(_15.tools[i].handler));
}
}
}
}
if(_15.collapsible){
$("<a class=\"panel-tool-collapse\" href=\"javascript:void(0)\"></a>").appendTo(_18).bind("click",function(){
if(_15.collapsed==true){
_37(_14,true);
}else{
_27(_14,true);
}
return false;
});
}
if(_15.minimizable){
$("<a class=\"panel-tool-min\" href=\"javascript:void(0)\"></a>").appendTo(_18).bind("click",function(){
_42(_14);
return false;
});
}
if(_15.maximizable){
$("<a class=\"panel-tool-max\" href=\"javascript:void(0)\"></a>").appendTo(_18).bind("click",function(){
if(_15.maximized==true){
_46(_14);
}else{
_26(_14);
}
return false;
});
}
if(_15.closable){
$("<a class=\"panel-tool-close\" href=\"javascript:void(0)\"></a>").appendTo(_18).bind("click",function(){
_19(_14);
return false;
});
}
_16.children("div.panel-body").removeClass("panel-body-noheader");
}else{
_16.children("div.panel-body").addClass("panel-body-noheader");
}
};
function _1a(_1b){
var _1c=$.data(_1b,"panel");
if(_1c.options.href&&(!_1c.isLoaded||!_1c.options.cache)){
_1c.isLoaded=false;
var _1d=_1c.panel.find(">div.panel-body");
if(_1c.options.loadingMessage){
_1d.html($("<div class=\"panel-loading\"></div>").html(_1c.options.loadingMessage));
}
$.ajax({url:_1c.options.href,cache:false,success:function(_1e){
_1d.html(_1c.options.extractor.call(_1b,_1e));
if($.parser){
$.parser.parse(_1d);
}
_1c.options.onLoad.apply(_1b,arguments);
_1c.isLoaded=true;
}});
}
};
function _1f(_20){
$(_20).find("div.panel:visible,div.accordion:visible,div.tabs-container:visible,div.layout:visible").each(function(){
$(this).triggerHandler("_resize",[true]);
});
};
function _21(_22,_23){
var _24=$.data(_22,"panel").options;
var _25=$.data(_22,"panel").panel;
if(_23!=true){
if(_24.onBeforeOpen.call(_22)==false){
return;
}
}
_25.show();
_24.closed=false;
_24.minimized=false;
_24.onOpen.call(_22);
if(_24.maximized==true){
_24.maximized=false;
_26(_22);
}
if(_24.collapsed==true){
_24.collapsed=false;
_27(_22);
}
if(!_24.collapsed){
_1a(_22);
_1f(_22);
}
};
function _19(_28,_29){
var _2a=$.data(_28,"panel").options;
var _2b=$.data(_28,"panel").panel;
if(_29!=true){
if(_2a.onBeforeClose.call(_28)==false){
return;
}
}
_2b.hide();
_2a.closed=true;
_2a.onClose.call(_28);
};
function _2c(_2d,_2e){
var _2f=$.data(_2d,"panel").options;
var _30=$.data(_2d,"panel").panel;
if(_2e!=true){
if(_2f.onBeforeDestroy.call(_2d)==false){
return;
}
}
_1(_30);
_2f.onDestroy.call(_2d);
};
function _27(_31,_32){
var _33=$.data(_31,"panel").options;
var _34=$.data(_31,"panel").panel;
var _35=_34.children("div.panel-body");
var _36=_34.children("div.panel-header").find("a.panel-tool-collapse");
if(_33.collapsed==true){
return;
}
_35.stop(true,true);
if(_33.onBeforeCollapse.call(_31)==false){
return;
}
_36.addClass("panel-tool-expand");
if(_32==true){
_35.slideUp("normal",function(){
_33.collapsed=true;
_33.onCollapse.call(_31);
});
}else{
_35.hide();
_33.collapsed=true;
_33.onCollapse.call(_31);
}
};
function _37(_38,_39){
var _3a=$.data(_38,"panel").options;
var _3b=$.data(_38,"panel").panel;
var _3c=_3b.children("div.panel-body");
var _3d=_3b.children("div.panel-header").find("a.panel-tool-collapse");
if(_3a.collapsed==false){
return;
}
_3c.stop(true,true);
if(_3a.onBeforeExpand.call(_38)==false){
return;
}
_3d.removeClass("panel-tool-expand");
if(_39==true){
_3c.slideDown("normal",function(){
_3a.collapsed=false;
_3a.onExpand.call(_38);
_1a(_38);
_1f(_38);
});
}else{
_3c.show();
_3a.collapsed=false;
_3a.onExpand.call(_38);
_1a(_38);
_1f(_38);
}
};
function _26(_3e){
var _3f=$.data(_3e,"panel").options;
var _40=$.data(_3e,"panel").panel;
var _41=_40.children("div.panel-header").find("a.panel-tool-max");
if(_3f.maximized==true){
return;
}
_41.addClass("panel-tool-restore");
if(!$.data(_3e,"panel").original){
$.data(_3e,"panel").original={width:_3f.width,height:_3f.height,left:_3f.left,top:_3f.top,fit:_3f.fit};
}
_3f.left=0;
_3f.top=0;
_3f.fit=true;
_3(_3e);
_3f.minimized=false;
_3f.maximized=true;
_3f.onMaximize.call(_3e);
};
function _42(_43){
var _44=$.data(_43,"panel").options;
var _45=$.data(_43,"panel").panel;
_45.hide();
_44.minimized=true;
_44.maximized=false;
_44.onMinimize.call(_43);
};
function _46(_47){
var _48=$.data(_47,"panel").options;
var _49=$.data(_47,"panel").panel;
var _4a=_49.children("div.panel-header").find("a.panel-tool-max");
if(_48.maximized==false){
return;
}
_49.show();
_4a.removeClass("panel-tool-restore");
var _4b=$.data(_47,"panel").original;
_48.width=_4b.width;
_48.height=_4b.height;
_48.left=_4b.left;
_48.top=_4b.top;
_48.fit=_4b.fit;
_3(_47);
_48.minimized=false;
_48.maximized=false;
$.data(_47,"panel").original=null;
_48.onRestore.call(_47);
};
function _4c(_4d){
var _4e=$.data(_4d,"panel").options;
var _4f=$.data(_4d,"panel").panel;
if(_4e.border==true){
_4f.children("div.panel-header").removeClass("panel-header-noborder");
_4f.children("div.panel-body").removeClass("panel-body-noborder");
}else{
_4f.children("div.panel-header").addClass("panel-header-noborder");
_4f.children("div.panel-body").addClass("panel-body-noborder");
}
_4f.css(_4e.style);
_4f.addClass(_4e.cls);
_4f.children("div.panel-header").addClass(_4e.headerCls);
_4f.children("div.panel-body").addClass(_4e.bodyCls);
};
function _50(_51,_52){
$.data(_51,"panel").options.title=_52;
$(_51).panel("header").find("div.panel-title").html(_52);
};
var TO=false;
var _53=true;
$(window).unbind(".panel").bind("resize.panel",function(){
if(!_53){
return;
}
if(TO!==false){
clearTimeout(TO);
}
TO=setTimeout(function(){
_53=false;
var _54=$("body.layout");
if(_54.length){
_54.layout("resize");
}else{
$("body").children("div.panel,div.accordion,div.tabs-container,div.layout").triggerHandler("_resize");
}
_53=true;
TO=false;
},200);
});
$.fn.panel=function(_55,_56){
if(typeof _55=="string"){
return $.fn.panel.methods[_55](this,_56);
}
_55=_55||{};
return this.each(function(){
var _57=$.data(this,"panel");
var _58;
if(_57){
_58=$.extend(_57.options,_55);
}else{
_58=$.extend({},$.fn.panel.defaults,$.fn.panel.parseOptions(this),_55);
$(this).attr("title","");
_57=$.data(this,"panel",{options:_58,panel:_f(this),isLoaded:false});
}
if(_58.content){
$(this).html(_58.content);
if($.parser){
$.parser.parse(this);
}
}
_13(this);
_4c(this);
if(_58.doSize==true){
_57.panel.css("display","block");
_3(this);
}
if(_58.closed==true||_58.minimized==true){
_57.panel.hide();
}else{
_21(this);
}
});
};
$.fn.panel.methods={options:function(jq){
return $.data(jq[0],"panel").options;
},panel:function(jq){
return $.data(jq[0],"panel").panel;
},header:function(jq){
return $.data(jq[0],"panel").panel.find(">div.panel-header");
},body:function(jq){
return $.data(jq[0],"panel").panel.find(">div.panel-body");
},setTitle:function(jq,_59){
return jq.each(function(){
_50(this,_59);
});
},open:function(jq,_5a){
return jq.each(function(){
_21(this,_5a);
});
},close:function(jq,_5b){
return jq.each(function(){
_19(this,_5b);
});
},destroy:function(jq,_5c){
return jq.each(function(){
_2c(this,_5c);
});
},refresh:function(jq,_5d){
return jq.each(function(){
$.data(this,"panel").isLoaded=false;
if(_5d){
$.data(this,"panel").options.href=_5d;
}
_1a(this);
});
},resize:function(jq,_5e){
return jq.each(function(){
_3(this,_5e);
});
},move:function(jq,_5f){
return jq.each(function(){
_a(this,_5f);
});
},maximize:function(jq){
return jq.each(function(){
_26(this);
});
},minimize:function(jq){
return jq.each(function(){
_42(this);
});
},restore:function(jq){
return jq.each(function(){
_46(this);
});
},collapse:function(jq,_60){
return jq.each(function(){
_27(this,_60);
});
},expand:function(jq,_61){
return jq.each(function(){
_37(this,_61);
});
}};
$.fn.panel.parseOptions=function(_62){
var t=$(_62);
return {width:(parseInt(_62.style.width)||undefined),height:(parseInt(_62.style.height)||undefined),left:(parseInt(_62.style.left)||undefined),top:(parseInt(_62.style.top)||undefined),title:(t.attr("title")||undefined),iconCls:(t.attr("iconCls")||t.attr("icon")),cls:t.attr("cls"),headerCls:t.attr("headerCls"),bodyCls:t.attr("bodyCls"),tools:t.attr("tools"),href:t.attr("href"),loadingMessage:(t.attr("loadingMessage")!=undefined?t.attr("loadingMessage"):undefined),cache:(t.attr("cache")?t.attr("cache")=="true":undefined),fit:(t.attr("fit")?t.attr("fit")=="true":undefined),border:(t.attr("border")?t.attr("border")=="true":undefined),noheader:(t.attr("noheader")?t.attr("noheader")=="true":undefined),collapsible:(t.attr("collapsible")?t.attr("collapsible")=="true":undefined),minimizable:(t.attr("minimizable")?t.attr("minimizable")=="true":undefined),maximizable:(t.attr("maximizable")?t.attr("maximizable")=="true":undefined),closable:(t.attr("closable")?t.attr("closable")=="true":undefined),collapsed:(t.attr("collapsed")?t.attr("collapsed")=="true":undefined),minimized:(t.attr("minimized")?t.attr("minimized")=="true":undefined),maximized:(t.attr("maximized")?t.attr("maximized")=="true":undefined),closed:(t.attr("closed")?t.attr("closed")=="true":undefined)};
};
$.fn.panel.defaults={title:null,iconCls:null,width:"auto",height:"auto",left:null,top:null,cls:null,headerCls:null,bodyCls:null,style:{},href:null,cache:true,fit:false,border:true,doSize:true,noheader:false,content:null,collapsible:false,minimizable:false,maximizable:false,closable:false,collapsed:false,minimized:false,maximized:false,closed:false,tools:null,href:null,loadingMessage:"Loading...",extractor:function(_63){
var _64=/<body[^>]*>((.|[\n\r])*)<\/body>/im;
var _65=_64.exec(_63);
if(_65){
return _65[1];
}else{
return _63;
}
},onLoad:function(){
},onBeforeOpen:function(){
},onOpen:function(){
},onBeforeClose:function(){
},onClose:function(){
},onBeforeDestroy:function(){
},onDestroy:function(){
},onResize:function(_66,_67){
},onMove:function(_68,top){
},onMaximize:function(){
},onRestore:function(){
},onMinimize:function(){
},onBeforeCollapse:function(){
},onBeforeExpand:function(){
},onCollapse:function(){
},onExpand:function(){
}};
})(jQuery);

/**Validate box */
(function($){
	function _1(_2){
	$(_2).addClass("validatebox-text");
	};
	function _3(_4){
	var _5=$.data(_4,"validatebox");
	_5.validating=false;
	var _6=_5.tip;
	if(_6){
	_6.remove();
	}
	$(_4).unbind();
	$(_4).remove();
	};
	function _7(_8){
	var _9=$(_8);
	var _a=$.data(_8,"validatebox");
	_a.validating=false;
	_9.unbind(".validatebox").bind("focus.validatebox",function(){
	_a.validating=true;
	_a.value=undefined;
	(function(){
	if(_a.validating){
	if(_a.value!=_9.val()){
	_a.value=_9.val();
	_11(_8);
	}
	setTimeout(arguments.callee,200);
	}
	})();
	}).bind("blur.validatebox",function(){
	_a.validating=false;
	_b(_8);
	}).bind("mouseenter.validatebox",function(){
	if(_9.hasClass("validatebox-invalid")){
	_c(_8);
	}
	}).bind("mouseleave.validatebox",function(){
	_b(_8);
	});
	};
	function _c(_d){
	var _e=$(_d);
	var _f=$.data(_d,"validatebox").message;
	var tip=$.data(_d,"validatebox").tip;
	if(!tip){
	tip=$("<div class=\"validatebox-tip\">"+"<span class=\"validatebox-tip-content\">"+"</span>"+"<span class=\"validatebox-tip-pointer\">"+"</span>"+"</div>").appendTo("body");
	$.data(_d,"validatebox").tip=tip;
	}
	tip.find(".validatebox-tip-content").html(_f);
	tip.css({display:"block",left:_e.offset().left+_e.outerWidth(),top:_e.offset().top});
	};
	function _b(_10){
	var tip=$.data(_10,"validatebox").tip;
	if(tip){
	tip.remove();
	$.data(_10,"validatebox").tip=null;
	}
	};
	function _11(_12){
	var _13=$.data(_12,"validatebox").options;
	var tip=$.data(_12,"validatebox").tip;
	var box=$(_12);
	var _14=box.val();
	function _15(msg){
	$.data(_12,"validatebox").message=msg;
	};
	var _16=box.attr("disabled");
	if(_16==true||_16=="true"){
	return true;
	}
	if(_13.required){
	if(_14==""){
	box.addClass("validatebox-invalid");
	_15(_13.missingMessage);
	_c(_12);
	return false;
	}
	}
	if(_13.validType){
	var _17=/([a-zA-Z_]+)(.*)/.exec(_13.validType);
	var _18=_13.rules[_17[1]];
	if(_14&&_18){
	var _19=eval(_17[2]);
	if(!_18["validator"](_14,_19)){
	box.addClass("validatebox-invalid");
	var _1a=_18["message"];
	if(_19){
	for(var i=0;i<_19.length;i++){
	_1a=_1a.replace(new RegExp("\\{"+i+"\\}","g"),_19[i]);
	}
	}
	_15(_13.invalidMessage||_1a);
	_c(_12);
	return false;
	}
	}
	}
	box.removeClass("validatebox-invalid");
	_b(_12);
	return true;
	};
	$.fn.validatebox=function(_1b,_1c){
	if(typeof _1b=="string"){
	return $.fn.validatebox.methods[_1b](this,_1c);
	}
	_1b=_1b||{};
	return this.each(function(){
	var _1d=$.data(this,"validatebox");
	if(_1d){
	$.extend(_1d.options,_1b);
	}else{
	_1(this);
	$.data(this,"validatebox",{options:$.extend({},$.fn.validatebox.defaults,$.fn.validatebox.parseOptions(this),_1b)});
	}
	_7(this);
	});
	};
	$.fn.validatebox.methods={destroy:function(jq){
	return jq.each(function(){
	_3(this);
	});
	},validate:function(jq){
	return jq.each(function(){
	_11(this);
	});
	},isValid:function(jq){
	return _11(jq[0]);
	}};
	$.fn.validatebox.parseOptions=function(_1e){
	var t=$(_1e);
	return {required:(t.attr("required")?(t.attr("required")=="required"||t.attr("required")=="true"||t.attr("required")==true):undefined),validType:(t.attr("validType")||undefined),missingMessage:(t.attr("missingMessage")||undefined),invalidMessage:(t.attr("invalidMessage")||undefined)};
	};
	$.fn.validatebox.defaults={required:false,validType:null,
		//	missingMessage:"This field is required."
			missingMessage:"Dữ liệu cần thiết"
		,invalidMessage:null,rules:{email:{validator:function(_1f){
	return /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i.test(_1f);
	},message:"Please enter a valid email address."},url:{validator:function(_20){
	return /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(_20);
	},message:"Please enter a valid URL."},length:{validator:function(_21,_22){
	var len=$.trim(_21).length;
	return len>=_22[0]&&len<=_22[1];
	},message:"Please enter a value between {0} and {1}."},remote:{validator:function(_23,_24){
	var _25={};
	_25[_24[1]]=_23;
	var _26=$.ajax({url:_24[0],dataType:"json",data:_25,async:false,cache:false,type:"post"}).responseText;
	return _26=="true";
	},message:"Please fix this field."}}};
	})(jQuery);


/**Combo*/

	(function($){
		function _1(_2,_3){
		var _4=$.data(_2,"combo").options;
		var _5=$.data(_2,"combo").combo;
		var _6=$.data(_2,"combo").panel;
		if(_3){
		_4.width=_3;
		}
		_5.appendTo("body");
		if(isNaN(_4.width)){
		_4.width=_5.find("input.combo-text").outerWidth();
		}
		var _7=0;
		if(_4.hasDownArrow){
		_7=_5.find(".combo-arrow").outerWidth();
		}
		var _3=_4.width-_7;
		if($.boxModel==true){
		_3-=_5.outerWidth()-_5.width();
		}
		_5.find("input.combo-text").width(_3);
		_6.panel("resize",{width:(_4.panelWidth?_4.panelWidth:_5.outerWidth()),height:_4.panelHeight});
		_5.insertAfter(_2);
		};
		function _8(_9){
		var _a=$.data(_9,"combo").options;
		var _b=$.data(_9,"combo").combo;
		if(_a.hasDownArrow){
		_b.find(".combo-arrow").show();
		}else{
		_b.find(".combo-arrow").hide();
		}
		};
		function _c(_d){
		$(_d).addClass("combo-f").hide();
		var _e=$("<span class=\"combo\"></span>").insertAfter(_d);
		var _f=$("<input type=\"text\" class=\"combo-text\">").appendTo(_e);
		$("<span><span class=\"combo-arrow\"></span></span>").appendTo(_e);
		$("<input type=\"hidden\" class=\"combo-value\">").appendTo(_e);
		var _10=$("<div class=\"combo-panel\"></div>").appendTo("body");
		_10.panel({doSize:false,closed:true,style:{position:"absolute",zIndex:10},onOpen:function(){
		$(this).panel("resize");
		}});
		var _11=$(_d).attr("name");
		if(_11){
		_e.find("input.combo-value").attr("name",_11);
		$(_d).removeAttr("name").attr("comboName",_11);
		}
		_f.attr("autocomplete","off");
		return {combo:_e,panel:_10};
		};
		function _12(_13){
		var _14=$.data(_13,"combo").combo.find("input.combo-text");
		_14.validatebox("destroy");
		$.data(_13,"combo").panel.panel("destroy");
		$.data(_13,"combo").combo.remove();
		$(_13).remove();
		};
		function _15(_16){
		var _17=$.data(_16,"combo");
		var _18=_17.options;
		var _19=$.data(_16,"combo").combo;
		var _1a=$.data(_16,"combo").panel;
		var _1b=_19.find(".combo-text");
		var _1c=_19.find(".combo-arrow");
		$(document).unbind(".combo").bind("mousedown.combo",function(e){
		$("div.combo-panel").panel("close");
		});
		_19.unbind(".combo");
		_1a.unbind(".combo");
		_1b.unbind(".combo");
		_1c.unbind(".combo");
		if(!_18.disabled){
		_1a.bind("mousedown.combo",function(e){
		return false;
		});
		_1b.bind("mousedown.combo",function(e){
		e.stopPropagation();
		}).bind("keydown.combo",function(e){
		switch(e.keyCode){
		case 38:
		_18.keyHandler.up.call(_16);
		break;
		case 40:
		_18.keyHandler.down.call(_16);
		break;
		case 13:
		e.preventDefault();
		_18.keyHandler.enter.call(_16);
		return false;
		case 9:
		case 27:
		_25(_16);
		break;
		default:
		if(_18.editable){
		if(_17.timer){
		clearTimeout(_17.timer);
		}
		_17.timer=setTimeout(function(){
		var q=_1b.val();
		if(_17.previousValue!=q){
		_17.previousValue=q;
		_1d(_16);
		_18.keyHandler.query.call(_16,_1b.val());
		_29(_16,true);
		}
		},_18.delay);
		}
		}
		});
		_1c.bind("click.combo",function(){
		if(_1a.is(":visible")){
		_25(_16);
		}else{
		$("div.combo-panel").panel("close");
		_1d(_16);
		}
		_1b.focus();
		//alert('focus 975');
		}).bind("mouseenter.combo",function(){
			//alert('mouseenter 977');
		$(this).addClass("combo-arrow-hover");
		}).bind("mouseleave.combo",function(){
		$(this).removeClass("combo-arrow-hover");
			//alert('mouseleave:981');
		}).bind("mousedown.combo",function(){
			//alert('mousedown:983');
		return false;
		});
		}
		};
		function _1d(_1e){
		var _1f=$.data(_1e,"combo").options;
		var _20=$.data(_1e,"combo").combo;
		var _21=$.data(_1e,"combo").panel;
		if($.fn.window){
		_21.panel("panel").css("z-index",$.fn.window.defaults.zIndex++);
		}
		_21.panel("move",{left:_20.offset().left,top:_22()});
		_21.panel("open");
		_1f.onShowPanel.call(_1e);
		(function(){
		if(_21.is(":visible")){
		_21.panel("move",{left:_23(),top:_22()});
		setTimeout(arguments.callee,200);
		}
		})();
		function _23(){
		var _24=_20.offset().left;
		if(_24+_21.outerWidth()>$(window).width()+$(document).scrollLeft()){
		_24=$(window).width()+$(document).scrollLeft()-_21.outerWidth();
		}
		if(_24<0){
		_24=0;
		}
		return _24;
		};
		function _22(){
		var top=_20.offset().top+_20.outerHeight();
		if(top+_21.outerHeight()>$(window).height()+$(document).scrollTop()){
		top=_20.offset().top-_21.outerHeight();
		}
		if(top<$(document).scrollTop()){
		top=_20.offset().top+_20.outerHeight();
		}
		return top;
		};
		};
		function _25(_26){
		var _27=$.data(_26,"combo").options;
		var _28=$.data(_26,"combo").panel;
		_28.panel("close");
		_27.onHidePanel.call(_26);
		};
		function _29(_2a,_2b){
		var _2c=$.data(_2a,"combo").options;
		var _2d=$.data(_2a,"combo").combo.find("input.combo-text");
		_2d.validatebox(_2c);
		if(_2b){
		_2d.validatebox("validate");
		_2d.trigger("mouseleave");
		}
		};
		function _2e(_2f,_30){
		var _31=$.data(_2f,"combo").options;
		var _32=$.data(_2f,"combo").combo;
		if(_30){
		_31.disabled=true;
		$(_2f).attr("disabled",true);
		_32.find(".combo-value").attr("disabled",true);
		_32.find(".combo-text").attr("disabled",true);
		}else{
		_31.disabled=false;
		$(_2f).removeAttr("disabled");
		_32.find(".combo-value").removeAttr("disabled");
		_32.find(".combo-text").removeAttr("disabled");
		}
		};
		function _33(_34){
		var _35=$.data(_34,"combo").options;
		var _36=$.data(_34,"combo").combo;
		if(_35.multiple){
		_36.find("input.combo-value").remove();
		}else{
		_36.find("input.combo-value").val("");
		}
		_36.find("input.combo-text").val("");
		};
		function _37(_38){
		var _39=$.data(_38,"combo").combo;
		return _39.find("input.combo-text").val();
		};
		function _3a(_3b,_3c){
		var _3d=$.data(_3b,"combo").combo;
		_3d.find("input.combo-text").val(_3c);
		_29(_3b,true);
		$.data(_3b,"combo").previousValue=_3c;
		};
		function _3e(_3f){
		var _40=[];
		var _41=$.data(_3f,"combo").combo;
		_41.find("input.combo-value").each(function(){
		_40.push($(this).val());
		});
		return _40;
		};
		function _42(_43,_44){
		var _45=$.data(_43,"combo").options;
		var _46=_3e(_43);
		var _47=$.data(_43,"combo").combo;
		_47.find("input.combo-value").remove();
		var _48=$(_43).attr("comboName");
		for(var i=0;i<_44.length;i++){
		var _49=$("<input type=\"hidden\" class=\"combo-value\">").appendTo(_47);
		if(_48){
		_49.attr("name",_48);
		}
		_49.val(_44[i]);
		}
		var tmp=[];
		for(var i=0;i<_46.length;i++){
		tmp[i]=_46[i];
		}
		var aa=[];
		for(var i=0;i<_44.length;i++){
		for(var j=0;j<tmp.length;j++){
		if(_44[i]==tmp[j]){
		aa.push(_44[i]);
		tmp.splice(j,1);
		break;
		}
		}
		}
		if(aa.length!=_44.length||_44.length!=_46.length){
		if(_45.multiple){
		_45.onChange.call(_43,_44,_46);
		}else{
			//_45.isFocus1 = true; //tuanna added
			//alert('1114');
		_45.onChange.call(_43,_44[0],_46[0]);
		}
		}
		};
		function _4a(_4b){
		var _4c=_3e(_4b);
		return _4c[0];
		};
		function _4d(_4e,_4f){
		_42(_4e,[_4f]);
		};
		function _50(_51){
		var _52=$.data(_51,"combo").options;
		var fn=_52.onChange;
		_52.onChange=function(){
		};
		if(_52.multiple){
		if(_52.value){
		if(typeof _52.value=="object"){
		_42(_51,_52.value);
		}else{
		_4d(_51,_52.value);
		}
		}else{
		_42(_51,[]);
		}
		}else{
		_4d(_51,_52.value);
		}
		_52.onChange=fn;
		};
		$.fn.combo=function(_53,_54){
		if(typeof _53=="string"){
		return $.fn.combo.methods[_53](this,_54);
		}
		_53=_53||{};
		return this.each(function(){
		var _55=$.data(this,"combo");
		if(_55){
		$.extend(_55.options,_53);
		}else{
		var r=_c(this);
		_55=$.data(this,"combo",{options:$.extend({},$.fn.combo.defaults,$.fn.combo.parseOptions(this),_53),combo:r.combo,panel:r.panel,previousValue:null});
		$(this).removeAttr("disabled");
		}
		$("input.combo-text",_55.combo).attr("readonly",!_55.options.editable);
		_8(this);
		_2e(this,_55.options.disabled);
		_1(this);
		_15(this);
		_29(this);
		_50(this);
		});
		};
		$.fn.combo.methods={options:function(jq){
		return $.data(jq[0],"combo").options;
		},panel:function(jq){
		return $.data(jq[0],"combo").panel;
		},textbox:function(jq){
		return $.data(jq[0],"combo").combo.find("input.combo-text");
		},destroy:function(jq){
		return jq.each(function(){
		_12(this);
		});
		},resize:function(jq,_56){
		return jq.each(function(){
		_1(this,_56);
		});
		},showPanel:function(jq){
		return jq.each(function(){
		_1d(this);
		});
		},hidePanel:function(jq){
		return jq.each(function(){
		_25(this);
		});
		},disable:function(jq){
		return jq.each(function(){
		_2e(this,true);
		_15(this);
		});
		},enable:function(jq){
		return jq.each(function(){
		_2e(this,false);
		_15(this);
		});
		},validate:function(jq){
		return jq.each(function(){
		_29(this,true);
		});
		},isValid:function(jq){
		var _57=$.data(jq[0],"combo").combo.find("input.combo-text");
		return _57.validatebox("isValid");
		},clear:function(jq){
		return jq.each(function(){
		_33(this);
		});
		},getText:function(jq){
		return _37(jq[0]);
		},setText:function(jq,_58){
		return jq.each(function(){
		_3a(this,_58);
		});
		},getValues:function(jq){
		return _3e(jq[0]);
		},setValues:function(jq,_59){
		return jq.each(function(){
		_42(this,_59);
		});
		},getValue:function(jq){
		return _4a(jq[0]);
		},setValue:function(jq,_5a){
		return jq.each(function(){
		_4d(this,_5a);
		});
		}};
		$.fn.combo.parseOptions=function(_5b){
		var t=$(_5b);
		return $.extend({},$.fn.validatebox.parseOptions(_5b),{/*isFocus:t.attr("isFocus"),*/width:(parseInt(_5b.style.width)||undefined),panelWidth:(parseInt(t.attr("panelWidth"))||undefined),panelHeight:(t.attr("panelHeight")=="auto"?"auto":parseInt(t.attr("panelHeight"))||undefined),separator:(t.attr("separator")||undefined),multiple:(t.attr("multiple")?(t.attr("multiple")=="true"||t.attr("multiple")==true||t.attr("multiple")=="multiple"):undefined),editable:(t.attr("editable")?t.attr("editable")=="true":undefined),disabled:(t.attr("disabled")?true:undefined),hasDownArrow:(t.attr("hasDownArrow")?t.attr("hasDownArrow")=="true":undefined),value:(t.val()||undefined),delay:(t.attr("delay")?parseInt(t.attr("delay")):undefined)});
		};
		$.fn.combo.defaults=$.extend({},$.fn.validatebox.defaults,{/*isFocus:false,*/width:"auto",panelWidth:null,panelHeight:200,multiple:false,separator:",",editable:true,disabled:false,hasDownArrow:true,value:"",delay:200,keyHandler:{up:function(){
		},down:function(){
		},enter:function(){
		},query:function(q){
		}},onShowPanel:function(){
		},onHidePanel:function(){
		},onChange:function(_5c,_5d){
		}});
		})(jQuery);

	
/**combobox*/	
	(function($){
		function _1(_2,_3){
		var _4=$(_2).combo("panel");
		var _5=_4.find("div.combobox-item[value="+_3+"]");
		if(_5.length){
		if(_5.position().top<=0){
		var h=_4.scrollTop()+_5.position().top;
		_4.scrollTop(h);
		}else{
		if(_5.position().top+_5.outerHeight()>_4.height()){
		var h=_4.scrollTop()+_5.position().top+_5.outerHeight()-_4.height();
		_4.scrollTop(h);
		}
		}
		}
		};
		function _6(_7){
		var _8=$(_7).combo("panel");
		var _9=$(_7).combo("getValues");
		var _a=_8.find("div.combobox-item[value="+_9.pop()+"]");
		if(_a.length){
		var _b=_a.prev(":visible");
		if(_b.length){
		_a=_b;
		}
		}else{
		_a=_8.find("div.combobox-item:visible:last");
		}
		var _c=_a.attr("value");
		_d(_7,_c);
		_1(_7,_c);
		};
		function _e(_f){
		var _10=$(_f).combo("panel");
		var _11=$(_f).combo("getValues");
		var _12=_10.find("div.combobox-item[value="+_11.pop()+"]");
		if(_12.length){
		var _13=_12.next(":visible");
		if(_13.length){
		_12=_13;
		}
		}else{
		_12=_10.find("div.combobox-item:visible:first");
		}
		var _14=_12.attr("value");
		_d(_f,_14);
		_1(_f,_14);
		};
		function _d(_15,_16){
		var _17=$.data(_15,"combobox").options;
		var _18=$.data(_15,"combobox").data;
		if(_17.multiple){
		var _19=$(_15).combo("getValues");
		for(var i=0;i<_19.length;i++){
		if(_19[i]==_16){
		return;
		}
		}
		_19.push(_16);
		_1a(_15,_19);
		}else{
		_1a(_15,[_16]);
		}
		for(var i=0;i<_18.length;i++){
		if(_18[i][_17.valueField]==_16){
		_17.onSelect.call(_15,_18[i]);
		return;
		}
		}
		};
		function _1b(_1c,_1d){
		var _1e=$.data(_1c,"combobox").options;
		var _1f=$.data(_1c,"combobox").data;
		var _20=$(_1c).combo("getValues");
		for(var i=0;i<_20.length;i++){
		if(_20[i]==_1d){
		_20.splice(i,1);
		_1a(_1c,_20);
		break;
		}
		}
		for(var i=0;i<_1f.length;i++){
		if(_1f[i][_1e.valueField]==_1d){
		_1e.onUnselect.call(_1c,_1f[i]);
		return;
		}
		}
		};
		function _1a(_21,_22,_23){
		var _24=$.data(_21,"combobox").options;
		var _25=$.data(_21,"combobox").data;
		var _26=$(_21).combo("panel");
		_26.find("div.combobox-item-selected").removeClass("combobox-item-selected");
		var vv=[],ss=[];
		for(var i=0;i<_22.length;i++){
		var v=_22[i];
		var s=v;
		for(var j=0;j<_25.length;j++){
		if(_25[j][_24.valueField]==v){
		s=_25[j][_24.textField];
		break;
		}
		}
		vv.push(v);
		ss.push(s);
		_26.find("div.combobox-item[value="+v+"]").addClass("combobox-item-selected");
		}
		$(_21).combo("setValues",vv);
		if(!_23){
		$(_21).combo("setText",ss.join(_24.separator));
		}
		};
		function _27(_28){
		var _29=$.data(_28,"combobox").options;
		var _2a=[];
		$(">option",_28).each(function(){
		var _2b={};
		_2b[_29.valueField]=$(this).attr("value")!=undefined?$(this).attr("value"):$(this).html();
		_2b[_29.textField]=$(this).html();
		_2b["selected"]=$(this).attr("selected");
		_2a.push(_2b);
		});
		return _2a;
		};
		function _2c(_2d,_2e,_2f){
		var _30=$.data(_2d,"combobox").options;
		var _31=$(_2d).combo("panel");
		$.data(_2d,"combobox").data=_2e;
		var _32=$(_2d).combobox("getValues");
		_31.empty();
		for(var i=0;i<_2e.length;i++){
		var v=_2e[i][_30.valueField];
		var s=_2e[i][_30.textField];
		var _33=$("<div class=\"combobox-item\"></div>").appendTo(_31);
		_33.attr("value",v);
		if(_30.formatter){
		_33.html(_30.formatter.call(_2d,_2e[i]));
		}else{
		_33.html(s);
		}
		if(_2e[i]["selected"]){
		(function(){
		for(var i=0;i<_32.length;i++){
		if(v==_32[i]){
		return;
		}
		}
		_32.push(v);
		})();
		}
		}
		if(_30.multiple){
		_1a(_2d,_32,_2f);
		}else{
		if(_32.length){
		_1a(_2d,[_32[_32.length-1]],_2f);
		}else{
		_1a(_2d,[],_2f);
		}
		}
		_30.onLoadSuccess.call(_2d,_2e);
		$(".combobox-item",_31).hover(function(){
		$(this).addClass("combobox-item-hover");
		},function(){
		$(this).removeClass("combobox-item-hover");
		}).click(function(){
		var _34=$(this);
		if(_30.multiple){
		if(_34.hasClass("combobox-item-selected")){
		_1b(_2d,_34.attr("value"));
		}else{
		_d(_2d,_34.attr("value"));
		}
		}else{
		_d(_2d,_34.attr("value"));
		$(_2d).combo("hidePanel");
		}
		});
		};
		function _35(_36,url,_37,_38){
		var _39=$.data(_36,"combobox").options;
		if(url){
		_39.url=url;
		}
		if(!_39.url){
		return;
		}
		_37=_37||{};
		$.ajax({type:_39.method,url:_39.url,dataType:"json",data:_37,success:function(_3a){
		_2c(_36,_3a,_38);
		},error:function(){
		_39.onLoadError.apply(this,arguments);
		}});
		};
		function _3b(_3c,q){
		var _3d=$.data(_3c,"combobox").options;
		if(_3d.multiple&&!q){
		_1a(_3c,[],true);
		}else{
		_1a(_3c,[q],true);
		}
		if(_3d.mode=="remote"){
		_35(_3c,null,{q:q},true);
		}else{
		var _3e=$(_3c).combo("panel");
		_3e.find("div.combobox-item").hide();
		var _3f=$.data(_3c,"combobox").data;
		for(var i=0;i<_3f.length;i++){
		if(_3d.filter.call(_3c,q,_3f[i])){
		var v=_3f[i][_3d.valueField];
		var s=_3f[i][_3d.textField];
		var _40=_3e.find("div.combobox-item[value="+v+"]");
		_40.show();
		if(s==q){
		_1a(_3c,[v],true);
		_40.addClass("combobox-item-selected");
		}
		}
		}
		}
		};
		function _41(_42){
		var _43=$.data(_42,"combobox").options;
		$(_42).addClass("combobox-f");
		$(_42).combo($.extend({},_43,{onShowPanel:function(){
		$(_42).combo("panel").find("div.combobox-item").show();
		_1(_42,$(_42).combobox("getValue"));
		_43.onShowPanel.call(_42);
		}}));
		};
		$.fn.combobox=function(_44,_45){
		if(typeof _44=="string"){
		var _46=$.fn.combobox.methods[_44];
		if(_46){
		return _46(this,_45);
		}else{
		return this.combo(_44,_45);
		}
		}
		_44=_44||{};
		return this.each(function(){
		var _47=$.data(this,"combobox");
		if(_47){
		$.extend(_47.options,_44);
		_41(this);
		}else{
		_47=$.data(this,"combobox",{options:$.extend({},$.fn.combobox.defaults,$.fn.combobox.parseOptions(this),_44)});
		_41(this);
		_2c(this,_27(this));
		}
		if(_47.options.data){
		_2c(this,_47.options.data);
		}
		_35(this);
		});
		};
		$.fn.combobox.methods={options:function(jq){
		return $.data(jq[0],"combobox").options;
		},getData:function(jq){
		return $.data(jq[0],"combobox").data;
		},setValues:function(jq,_48){
		return jq.each(function(){
		_1a(this,_48);
		});
		},setValue:function(jq,_49){
		return jq.each(function(){
		_1a(this,[_49]);
		});
		},clear:function(jq){
		return jq.each(function(){
		$(this).combo("clear");
		var _4a=$(this).combo("panel");
		_4a.find("div.combobox-item-selected").removeClass("combobox-item-selected");
		});
		},loadData:function(jq,_4b){
		return jq.each(function(){
		_2c(this,_4b);
		});
		},reload:function(jq,url){
		return jq.each(function(){
		_35(this,url);
		});
		},select:function(jq,_4c){
		return jq.each(function(){
		_d(this,_4c);
		});
		},unselect:function(jq,_4d){
		return jq.each(function(){
		_1b(this,_4d);
		});
		}};
		$.fn.combobox.parseOptions=function(_4e){
		var t=$(_4e);
		return $.extend({},$.fn.combo.parseOptions(_4e),{isFocus:t.attr("isFocus"),valueField:t.attr("valueField"),textField:t.attr("textField"),mode:t.attr("mode"),method:(t.attr("method")?t.attr("method"):undefined),url:t.attr("url")});
		};
		$.fn.combobox.defaults=$.extend({},$.fn.combo.defaults,{isFocus:false,valueField:"value",textField:"text",mode:"local",method:"post",url:null,data:null,keyHandler:{up:function(){
		_6(this);
		},down:function(){
		_e(this);
		},enter:function(){
		var _4f=$(this).combobox("getValues");
		$(this).combobox("setValues",_4f);
		$(this).combobox("hidePanel");
		},query:function(q){
		_3b(this,q);
		}},filter:function(q,row){
		var _50=$(this).combobox("options");
		return row[_50.textField].indexOf(q)==0;
		},formatter:function(row){
		var _51=$(this).combobox("options");
		return row[_51.textField];
		},onLoadSuccess:function(){
		},onLoadError:function(){
		},onSelect:function(_52){
		},onUnselect:function(_53){
		}});
		})(jQuery);

	
/**Datagrid*/
	(function($){
		function _1(a,o){
		for(var i=0,_2=a.length;i<_2;i++){
		if(a[i]==o){
		return i;
		}
		}
		return -1;
		};
		function _3(a,o,id){
		if(typeof o=="string"){
		for(var i=0,_4=a.length;i<_4;i++){
		if(a[i][o]==id){
		a.splice(i,1);
		return;
		}
		}
		}else{
		var _5=_1(a,o);
		if(_5!=-1){
		a.splice(_5,1);
		}
		}
		};
		function _6(_7,_8){
		var _9=$.data(_7,"datagrid").options;
		var _a=$.data(_7,"datagrid").panel;
		if(_8){
		if(_8.width){
		_9.width=_8.width;
		}
		if(_8.height){
		_9.height=_8.height;
		}
		}
		if(_9.fit==true){
		var p=_a.panel("panel").parent();
		_9.width=p.width();
		_9.height=p.height();
		}
		_a.panel("resize",{width:_9.width,height:_9.height});
		};
		function _b(_c){
		var _d=$.data(_c,"datagrid").options;
		var dc=$.data(_c,"datagrid").dc;
		var _e=$.data(_c,"datagrid").panel;
		var _f=_e.width();
		var _10=_e.height();
		var _11=dc.view;
		var _12=dc.view1;
		var _13=dc.view2;
		var _14=_12.children("div.datagrid-header");
		var _15=_13.children("div.datagrid-header");
		var _16=_14.find("table");
		var _17=_15.find("table");
		_11.width(_f);
		var _18=_14.children("div.datagrid-header-inner").show();
		_12.width(_18.find("table").width());
		if(!_d.showHeader){
		_18.hide();
		}
		_13.width(_f-_12.outerWidth());
		_12.children("div.datagrid-header,div.datagrid-body,div.datagrid-footer").width(_12.width());
		_13.children("div.datagrid-header,div.datagrid-body,div.datagrid-footer").width(_13.width());
		var hh;
		_14.css("height","");
		_15.css("height","");
		_16.css("height","");
		_17.css("height","");
		hh=Math.max(_16.height(),_17.height());
		_16.height(hh);
		_17.height(hh);
		if($.boxModel==true){
		_14.height(hh-(_14.outerHeight()-_14.height()));
		_15.height(hh-(_15.outerHeight()-_15.height()));
		}else{
		_14.height(hh);
		_15.height(hh);
		}
		if(_d.height!="auto"){
		var _19=_10-_13.children("div.datagrid-header").outerHeight(true)-_13.children("div.datagrid-footer").outerHeight(true)-_e.children("div.datagrid-toolbar").outerHeight(true)-_e.children("div.datagrid-pager").outerHeight(true);
		_12.children("div.datagrid-body").height(_19);
		_13.children("div.datagrid-body").height(_19);
		}
		_11.height(_13.height());
		_13.css("left",_12.outerWidth());
		};
		function _1a(_1b){
		var _1c=$(_1b).datagrid("getPanel");
		var _1d=_1c.children("div.datagrid-mask");
		if(_1d.length){
		_1d.css({width:_1c.width(),height:_1c.height()});
		var msg=_1c.children("div.datagrid-mask-msg");
		msg.css({left:(_1c.width()-msg.outerWidth())/2,top:(_1c.height()-msg.outerHeight())/2});
		}
		};
		function _1e(_1f,_20){
		var _21=$.data(_1f,"datagrid").data.rows;
		var _22=$.data(_1f,"datagrid").options;
		var dc=$.data(_1f,"datagrid").dc;
		if(!dc.body1.is(":empty")){
		if(_20>=0){
		_23(_20);
		}else{
		for(var i=0;i<_21.length;i++){
		_23(i);
		}
		if(_22.showFooter){
		var _24=$(_1f).datagrid("getFooterRows")||[];
		for(var i=0;i<_24.length;i++){
		_23(i,"footer");
		}
		_b(_1f);
		}
		}
		}
		if(_22.height=="auto"){
		var _25=dc.body1.parent();
		var _26=dc.body2;
		var _27=0;
		var _28=0;
		_26.children().each(function(){
		var c=$(this);
		if(c.is(":visible")){
		_27+=c.outerHeight();
		if(_28<c.outerWidth()){
		_28=c.outerWidth();
		}
		}
		});
		if(_28>_26.width()){
		_27+=18;
		}
		_25.height(_27);
		_26.height(_27);
		dc.view.height(dc.view2.height());
		}
		dc.body2.triggerHandler("scroll");
		function _23(_29,_2a){
		_2a=_2a||"body";
		var tr1=_22.finder.getTr(_1f,_29,_2a,1);
		var tr2=_22.finder.getTr(_1f,_29,_2a,2);
		tr1.css("height","");
		tr2.css("height","");
		var _2b=Math.max(tr1.height(),tr2.height());
		tr1.css("height",_2b);
		tr2.css("height",_2b);
		};
		};
		function _2c(_2d,_2e){
		function _2f(_30){
		var _31=[];
		$("tr",_30).each(function(){
		var _32=[];
		$("th",this).each(function(){
		var th=$(this);
		var col={title:th.html(),align:th.attr("align")||"left",sortable:th.attr("sortable")=="true"||false,checkbox:th.attr("checkbox")=="true"||false};
		if(th.attr("field")){
		col.field=th.attr("field");
		}
		if(th.attr("formatter")){
		col.formatter=eval(th.attr("formatter"));
		}
		if(th.attr("styler")){
		col.styler=eval(th.attr("styler"));
		}
		if(th.attr("editor")){
		var s=$.trim(th.attr("editor"));
		if(s.substr(0,1)=="{"){
		col.editor=eval("("+s+")");
		}else{
		col.editor=s;
		}
		}
		if(th.attr("rowspan")){
		col.rowspan=parseInt(th.attr("rowspan"));
		}
		if(th.attr("colspan")){
		col.colspan=parseInt(th.attr("colspan"));
		}
		if(th.attr("width")){
		col.width=parseInt(th.attr("width"))||100;
		}
		if(th.attr("hidden")){
		col.hidden=true;
		}
		if(th.attr("resizable")){
		col.resizable=th.attr("resizable")=="true";
		}
		_32.push(col);
		});
		_31.push(_32);
		});
		return _31;
		};
		var _33=$("<div class=\"datagrid-wrap\">"+"<div class=\"datagrid-view\">"+"<div class=\"datagrid-view1\">"+"<div class=\"datagrid-header\">"+"<div class=\"datagrid-header-inner\"></div>"+"</div>"+"<div class=\"datagrid-body\">"+"<div class=\"datagrid-body-inner\"></div>"+"</div>"+"<div class=\"datagrid-footer\">"+"<div class=\"datagrid-footer-inner\"></div>"+"</div>"+"</div>"+"<div class=\"datagrid-view2\">"+"<div class=\"datagrid-header\">"+"<div class=\"datagrid-header-inner\"></div>"+"</div>"+"<div class=\"datagrid-body\"></div>"+"<div class=\"datagrid-footer\">"+"<div class=\"datagrid-footer-inner\"></div>"+"</div>"+"</div>"+"<div class=\"datagrid-resize-proxy\"></div>"+"</div>"+"</div>").insertAfter(_2d);
		_33.panel({doSize:false});
		_33.panel("panel").addClass("datagrid").bind("_resize",function(e,_34){
		var _35=$.data(_2d,"datagrid").options;
		if(_35.fit==true||_34){
		_6(_2d);
		setTimeout(function(){
		if($.data(_2d,"datagrid")){
		_36(_2d);
		}
		},0);
		}
		return false;
		});
		$(_2d).hide().appendTo(_33.children("div.datagrid-view"));
		var _37=_2f($("thead[frozen=true]",_2d));
		var _38=_2f($("thead[frozen!=true]",_2d));
		var _39=_33.children("div.datagrid-view");
		var _3a=_39.children("div.datagrid-view1");
		var _3b=_39.children("div.datagrid-view2");
		return {panel:_33,frozenColumns:_37,columns:_38,dc:{view:_39,view1:_3a,view2:_3b,body1:_3a.children("div.datagrid-body").children("div.datagrid-body-inner"),body2:_3b.children("div.datagrid-body"),footer1:_3a.children("div.datagrid-footer").children("div.datagrid-footer-inner"),footer2:_3b.children("div.datagrid-footer").children("div.datagrid-footer-inner")}};
		};
		function _3c(_3d){
		var _3e={total:0,rows:[]};
		var _3f=_40(_3d,true).concat(_40(_3d,false));
		$(_3d).find("tbody tr").each(function(){
		_3e.total++;
		var col={};
		for(var i=0;i<_3f.length;i++){
		col[_3f[i]]=$("td:eq("+i+")",this).html();
		}
		_3e.rows.push(col);
		});
		return _3e;
		};
		function _41(_42){
		var _43=$.data(_42,"datagrid").options;
		var dc=$.data(_42,"datagrid").dc;
		var _44=$.data(_42,"datagrid").panel;
		_44.panel($.extend({},_43,{doSize:false,onResize:function(_45,_46){
		_1a(_42);
		setTimeout(function(){
		if($.data(_42,"datagrid")){
		_b(_42);
		_76(_42);
		_43.onResize.call(_44,_45,_46);
		}
		},0);
		},onExpand:function(){
		_b(_42);
		_1e(_42);
		_43.onExpand.call(_44);
		}}));
		var _47=dc.view1;
		var _48=dc.view2;
		var _49=_47.children("div.datagrid-header").children("div.datagrid-header-inner");
		var _4a=_48.children("div.datagrid-header").children("div.datagrid-header-inner");
		_4b(_49,_43.frozenColumns,true);
		_4b(_4a,_43.columns,false);
		_49.css("display",_43.showHeader?"block":"none");
		_4a.css("display",_43.showHeader?"block":"none");
		_47.find("div.datagrid-footer-inner").css("display",_43.showFooter?"block":"none");
		_48.find("div.datagrid-footer-inner").css("display",_43.showFooter?"block":"none");
		if(_43.toolbar){
		if(typeof _43.toolbar=="string"){
		$(_43.toolbar).addClass("datagrid-toolbar").prependTo(_44);
		$(_43.toolbar).show();
		}else{
		$("div.datagrid-toolbar",_44).remove();
		var tb=$("<div class=\"datagrid-toolbar\"></div>").prependTo(_44);
		for(var i=0;i<_43.toolbar.length;i++){
		var btn=_43.toolbar[i];
		if(btn=="-"){
		$("<div class=\"datagrid-btn-separator\"></div>").appendTo(tb);
		}else{
		var _4c=$("<a href=\"javascript:void(0)\"></a>");
		_4c[0].onclick=eval(btn.handler||function(){
		});
		_4c.css("float","left").appendTo(tb).linkbutton($.extend({},btn,{plain:true}));
		}
		}
		}
		}else{
		$("div.datagrid-toolbar",_44).remove();
		}
		$("div.datagrid-pager",_44).remove();
		if(_43.pagination){
		var _4d=$("<div class=\"datagrid-pager\"></div>").appendTo(_44);
		_4d.pagination({pageNumber:_43.pageNumber,pageSize:_43.pageSize,pageList:_43.pageList,onSelectPage:function(_4e,_4f){
		_43.pageNumber=_4e;
		_43.pageSize=_4f;
		_125(_42);
		}});
		_43.pageSize=_4d.pagination("options").pageSize;
		}
		function _4b(_50,_51,_52){
		if(!_51){
		return;
		}
		$(_50).show();
		$(_50).empty();
		var t=$("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tbody></tbody></table>").appendTo(_50);
		for(var i=0;i<_51.length;i++){
		var tr=$("<tr></tr>").appendTo($("tbody",t));
		var _53=_51[i];
		for(var j=0;j<_53.length;j++){
		var col=_53[j];
		var _54="";
		if(col.rowspan){
		_54+="rowspan=\""+col.rowspan+"\" ";
		}
		if(col.colspan){
		_54+="colspan=\""+col.colspan+"\" ";
		}
		var td=$("<td "+_54+"></td>").appendTo(tr);
		if(col.checkbox){
		td.attr("field",col.field);
		$("<div class=\"datagrid-header-check\"></div>").html("<input type=\"checkbox\"/>").appendTo(td);
		}else{
		if(col.field){
		td.attr("field",col.field);
		//[B]14122011 -added by tuanna
		td.append("<div class=\"datagrid-cell\"><span></span><span class=\"datagrid-sort-icon\"></span></div>");
		
		/*if(col.alignH != undefined)
			td.append("<div class=\"datagrid-cell\"><span  style=\"text-align:center; float:"+col.alignH+"\"></span><span  style=\"text-align:center;float:"+col.alignH+"\"class=\"datagrid-sort-icon \"></span></div>");
		else
			td.append("<div class=\"datagrid-cell\"><span></span><span class=\"datagrid-sort-icon\"></span></div>");
		//[E]14122011 -added by tuanna
		
		*/
		$("span",td).html(col.title);
		$("span.datagrid-sort-icon",td).html("&nbsp;");
		var _55=td.find("div.datagrid-cell");
		if(col.resizable==false){
		_55.attr("resizable","false");
		}
		col.boxWidth=$.boxModel?(col.width-(_55.outerWidth()-_55.width())):col.width;
		_55.width(col.boxWidth);
		//[B]14122011 -added by tuanna
		//_55.css("text-align",(col.align||"left"));//orginal
		_55.css("text-align",((col.alignH != undefined)?col.alignH:(col.align||"left")));
		//[E]14122011 -added by tuanna
		}else{
		$("<div class=\"datagrid-cell-group\"></div>").html(col.title).appendTo(td);
		}
		}
		if(col.hidden){
		td.hide();
		}
		}
		}
		if(_52&&_43.rownumbers){
		var td=$("<td rowspan=\""+_43.frozenColumns.length+"\"><div class=\"datagrid-header-rownumber\"></div></td>");
		if($("tr",t).length==0){
		td.wrap("<tr></tr>").parent().appendTo($("tbody",t));
		}else{
		td.prependTo($("tr:first",t));
		}
		}
		};
		};
		function _56(_57){
		var _58=$.data(_57,"datagrid").options;
		var _59=$.data(_57,"datagrid").data;
		var tr=_58.finder.getTr(_57,"","allbody");
		tr.unbind(".datagrid").bind("mouseenter.datagrid",function(){
		var _5a=$(this).attr("datagrid-row-index");
		_58.finder.getTr(_57,_5a).addClass("datagrid-row-over");
		}).bind("mouseleave.datagrid",function(){
		var _5b=$(this).attr("datagrid-row-index");
		_58.finder.getTr(_57,_5b).removeClass("datagrid-row-over");
		}).bind("click.datagrid",function(){
		var _5c=$(this).attr("datagrid-row-index");
		if(_58.singleSelect==true){
		_66(_57);
		_67(_57,_5c);
		}else{
		if($(this).hasClass("datagrid-row-selected")){
		_68(_57,_5c);
		}else{
		_67(_57,_5c);
		}
		}
		if(_58.onClickRow){
		_58.onClickRow.call(_57,_5c,_59.rows[_5c]);
		}
		}).bind("dblclick.datagrid",function(){
		var _5d=$(this).attr("datagrid-row-index");
		if(_58.onDblClickRow){
		_58.onDblClickRow.call(_57,_5d,_59.rows[_5d]);
		}
		}).bind("contextmenu.datagrid",function(e){
		var _5e=$(this).attr("datagrid-row-index");
		if(_58.onRowContextMenu){
		_58.onRowContextMenu.call(_57,e,_5e,_59.rows[_5e]);
		}
		});
		tr.find("td[field]").unbind(".datagrid").bind("click.datagrid",function(){
		var _5f=$(this).parent().attr("datagrid-row-index");
		var _60=$(this).attr("field");
		var _61=_59.rows[_5f][_60];
		_58.onClickCell.call(_57,_5f,_60,_61);
		}).bind("dblclick.datagrid",function(){
		var _62=$(this).parent().attr("datagrid-row-index");
		var _63=$(this).attr("field");
		var _64=_59.rows[_62][_63];
		_58.onDblClickCell.call(_57,_62,_63,_64);
		});
		tr.find("div.datagrid-cell-check input[type=checkbox]").unbind(".datagrid").bind("click.datagrid",function(e){
		var _65=$(this).parent().parent().parent().attr("datagrid-row-index");
		if(_58.singleSelect){
		_66(_57);
		_67(_57,_65);
		}else{
		if($(this).is(":checked")){
		_67(_57,_65);
		}else{
		_68(_57,_65);
		}
		}
		e.stopPropagation();
		});
		};
		function _69(_6a){
		var _6b=$.data(_6a,"datagrid").panel;
		var _6c=$.data(_6a,"datagrid").options;
		var dc=$.data(_6a,"datagrid").dc;
		var _6d=dc.view.find("div.datagrid-header");
		_6d.find("td:has(div.datagrid-cell)").unbind(".datagrid").bind("mouseenter.datagrid",function(){
		$(this).addClass("datagrid-header-over");
		}).bind("mouseleave.datagrid",function(){
		$(this).removeClass("datagrid-header-over");
		}).bind("contextmenu.datagrid",function(e){
		var _6e=$(this).attr("field");
		_6c.onHeaderContextMenu.call(_6a,e,_6e);
		});
		_6d.find("input[type=checkbox]").unbind(".datagrid").bind("click.datagrid",function(){
		if(_6c.singleSelect){
		return false;
		}
		if($(this).is(":checked")){
		_ba(_6a);
		}else{
		_b8(_6a);
		}
		});
		dc.body2.unbind(".datagrid").bind("scroll.datagrid",function(){
		dc.view1.children("div.datagrid-body").scrollTop($(this).scrollTop());
		dc.view2.children("div.datagrid-header").scrollLeft($(this).scrollLeft());
		dc.view2.children("div.datagrid-footer").scrollLeft($(this).scrollLeft());
		});
		function _6f(_70,_71){
		_70.unbind(".datagrid");
		if(!_71){
		return;
		}
		_70.bind("click.datagrid",function(e){
		var _72=$(this).parent().attr("field");
		var opt=_7d(_6a,_72);
		if(!opt.sortable){
		return;
		}
		_6c.sortName=_72;
		_6c.sortOrder="asc";
		var c="datagrid-sort-asc";
		if($(this).hasClass("datagrid-sort-asc")){
		c="datagrid-sort-desc";
		_6c.sortOrder="desc";
		}
		_6d.find("div.datagrid-cell").removeClass("datagrid-sort-asc datagrid-sort-desc");
		$(this).addClass(c);
		if(_6c.remoteSort){
		_125(_6a);
		}else{
		var _73=$.data(_6a,"datagrid").data;
		_a3(_6a,_73);
		}
		if(_6c.onSortColumn){
		_6c.onSortColumn.call(_6a,_6c.sortName,_6c.sortOrder);
		}
		});
		};
		_6f(_6d.find("div.datagrid-cell"),true);
		_6d.find("div.datagrid-cell").each(function(){
		$(this).resizable({handles:"e",disabled:($(this).attr("resizable")?$(this).attr("resizable")=="false":false),minWidth:25,onStartResize:function(e){
		_6d.css("cursor","e-resize");
		dc.view.children("div.datagrid-resize-proxy").css({left:e.pageX-$(_6b).offset().left-1,display:"block"});
		_6f($(this),false);
		},onResize:function(e){
		dc.view.children("div.datagrid-resize-proxy").css({display:"block",left:e.pageX-$(_6b).offset().left-1});
		return false;
		},onStopResize:function(e){
		_6d.css("cursor","");
		var _74=$(this).parent().attr("field");
		var col=_7d(_6a,_74);
		col.width=$(this).outerWidth();
		col.boxWidth=$.boxModel==true?$(this).width():$(this).outerWidth();
		_36(_6a,_74);
		_76(_6a);
		setTimeout(function(){
		_6f($(e.data.target),true);
		},0);
		dc.view2.children("div.datagrid-header").scrollLeft(dc.body2.scrollLeft());
		dc.view.children("div.datagrid-resize-proxy").css("display","none");
		_6c.onResizeColumn.call(_6a,_74,col.width);
		}});
		});
		dc.view1.children("div.datagrid-header").find("div.datagrid-cell").resizable({onStopResize:function(e){
		_6d.css("cursor","");
		var _75=$(this).parent().attr("field");
		var col=_7d(_6a,_75);
		col.width=$(this).outerWidth();
		col.boxWidth=$.boxModel==true?$(this).width():$(this).outerWidth();
		_36(_6a,_75);
		dc.view2.children("div.datagrid-header").scrollLeft(dc.body2.scrollLeft());
		dc.view.children("div.datagrid-resize-proxy").css("display","none");
		_b(_6a);
		_76(_6a);
		setTimeout(function(){
		_6f($(e.data.target),true);
		},0);
		_6c.onResizeColumn.call(_6a,_75,col.width);
		}});
		};
		function _76(_77){
		var _78=$.data(_77,"datagrid").options;
		var dc=$.data(_77,"datagrid").dc;
		if(!_78.fitColumns){
		return;
		}
		var _79=dc.view2.children("div.datagrid-header");
		var _7a=0;
		var _7b;
		var _7c=_40(_77,false);
		for(var i=0;i<_7c.length;i++){
		var col=_7d(_77,_7c[i]);
		if(!col.hidden&&!col.checkbox){
		_7a+=col.width;
		_7b=col;
		}
		}
		var _7e=_79.children("div.datagrid-header-inner").show();
		var _7f=_79.width()-_79.find("table").width()-_78.scrollbarSize;
		var _80=_7f/_7a;
		if(!_78.showHeader){
		_7e.hide();
		}
		for(var i=0;i<_7c.length;i++){
		var col=_7d(_77,_7c[i]);
		if(!col.hidden&&!col.checkbox){
		var _81=Math.floor(col.width*_80);
		_82(col,_81);
		_7f-=_81;
		}
		}
		_36(_77);
		if(_7f){
		_82(_7b,_7f);
		_36(_77,_7b.field);
		}
		function _82(col,_83){
		col.width+=_83;
		col.boxWidth+=_83;
		_79.find("td[field=\""+col.field+"\"] div.datagrid-cell").width(col.boxWidth);
		};
		};
		function _36(_84,_85){
		var _86=$.data(_84,"datagrid").panel;
		var _87=$.data(_84,"datagrid").options;
		var dc=$.data(_84,"datagrid").dc;
		if(_85){
		fix(_85);
		}else{
		var _88=dc.view1.children("div.datagrid-header").add(dc.view2.children("div.datagrid-header"));
		_88.find("td[field]").each(function(){
		fix($(this).attr("field"));
		});
		}
		_8b(_84);
		setTimeout(function(){
		_1e(_84);
		_94(_84);
		},0);
		function fix(_89){
		var col=_7d(_84,_89);
		var bf=_87.finder.getTr(_84,"","allbody").add(_87.finder.getTr(_84,"","allfooter"));
		bf.find("td[field=\""+_89+"\"]").each(function(){
		var td=$(this);
		var _8a=td.attr("colspan")||1;
		if(_8a==1){
		td.find("div.datagrid-cell").width(col.boxWidth);
		td.find("div.datagrid-editable").width(col.width);
		}
		});
		};
		};
		function _8b(_8c){
		var _8d=$.data(_8c,"datagrid").panel;
		var dc=$.data(_8c,"datagrid").dc;
		var _8e=dc.view1.children("div.datagrid-header").add(dc.view2.children("div.datagrid-header"));
		_8d.find("div.datagrid-body td.datagrid-td-merged").each(function(){
		var td=$(this);
		var _8f=td.attr("colspan")||1;
		var _90=td.attr("field");
		var _91=_8e.find("td[field=\""+_90+"\"]");
		var _92=_91.width();
		for(var i=1;i<_8f;i++){
		_91=_91.next();
		_92+=_91.outerWidth();
		}
		var _93=td.children("div.datagrid-cell");
		if($.boxModel==true){
		_93.width(_92-(_93.outerWidth()-_93.width()));
		}else{
		_93.width(_92);
		}
		});
		};
		function _94(_95){
		var _96=$.data(_95,"datagrid").panel;
		_96.find("div.datagrid-editable").each(function(){
		var ed=$.data(this,"datagrid.editor");
		if(ed.actions.resize){
		ed.actions.resize(ed.target,$(this).width());
		}
		});
		};
		function _7d(_97,_98){
		var _99=$.data(_97,"datagrid").options;
		if(_99.columns){
		for(var i=0;i<_99.columns.length;i++){
		var _9a=_99.columns[i];
		for(var j=0;j<_9a.length;j++){
		var col=_9a[j];
		if(col.field==_98){
		return col;
		}
		}
		}
		}
		if(_99.frozenColumns){
		for(var i=0;i<_99.frozenColumns.length;i++){
		var _9a=_99.frozenColumns[i];
		for(var j=0;j<_9a.length;j++){
		var col=_9a[j];
		if(col.field==_98){
		return col;
		}
		}
		}
		}
		return null;
		};
		function _40(_9b,_9c){
		var _9d=$.data(_9b,"datagrid").options;
		var _9e=(_9c==true)?(_9d.frozenColumns||[[]]):_9d.columns;
		if(_9e.length==0){
		return [];
		}
		var _9f=[];
		function _a0(_a1){
		var c=0;
		var i=0;
		while(true){
		if(_9f[i]==undefined){
		if(c==_a1){
		return i;
		}
		c++;
		}
		i++;
		}
		};
		function _a2(r){
		var ff=[];
		var c=0;
		for(var i=0;i<_9e[r].length;i++){
		var col=_9e[r][i];
		if(col.field){
		ff.push([c,col.field]);
		}
		c+=parseInt(col.colspan||"1");
		}
		for(var i=0;i<ff.length;i++){
		ff[i][0]=_a0(ff[i][0]);
		}
		for(var i=0;i<ff.length;i++){
		var f=ff[i];
		_9f[f[0]]=f[1];
		}
		};
		for(var i=0;i<_9e.length;i++){
		_a2(i);
		}
		return _9f;
		};
		function _a3(_a4,_a5){
			try{
		var _a6=$.data(_a4,"datagrid").options;
		var dc=$.data(_a4,"datagrid").dc;
		var _a7=$.data(_a4,"datagrid").panel;
		var _a8=$.data(_a4,"datagrid").selectedRows;
		_a5=_a6.loadFilter.call(_a4,_a5);
		var _a9=_a5.rows;
		$.data(_a4,"datagrid").data=_a5;
		if(_a5.footer){
		$.data(_a4,"datagrid").footer=_a5.footer;
		}
		if(!_a6.remoteSort){
		var opt=_7d(_a4,_a6.sortName);
		if(opt){
		var _aa=opt.sorter||function(a,b){
		return (a>b?1:-1);
		};
		_a5.rows.sort(function(r1,r2){
		return _aa(r1[_a6.sortName],r2[_a6.sortName])*(_a6.sortOrder=="asc"?1:-1);
		});
		}
		}
		if(_a6.view.onBeforeRender){
		_a6.view.onBeforeRender.call(_a6.view,_a4,_a9);
		}
		_a6.view.render.call(_a6.view,_a4,dc.body2,false);
		_a6.view.render.call(_a6.view,_a4,dc.body1,true);
		if(_a6.showFooter){
		_a6.view.renderFooter.call(_a6.view,_a4,dc.footer2,false);
		_a6.view.renderFooter.call(_a6.view,_a4,dc.footer1,true);
		}
		if(_a6.view.onAfterRender){
		_a6.view.onAfterRender.call(_a6.view,_a4);
		}
		_a6.onLoadSuccess.call(_a4,_a5);
		var _ab=_a7.children("div.datagrid-pager");
		if(_ab.length){
		if(_ab.pagination("options").total!=_a5.total){
		_ab.pagination({total:_a5.total});
		}
		}
		_1e(_a4);
		_56(_a4);
		dc.body2.triggerHandler("scroll");
		if(_a6.idField){
		for(var i=0;i<_a9.length;i++){
		if(_ac(_a9[i])){
		_ce(_a4,_a9[i][_a6.idField]);
		}
		}
		}
			}catch(err){}//tuanna added
		function _ac(row){
		for(var i=0;i<_a8.length;i++){
		if(_a8[i][_a6.idField]==row[_a6.idField]){
		_a8[i]=row;
		return true;
		}
		}
		return false;
		};
		};
		function _ad(_ae,row){
		var _af=$.data(_ae,"datagrid").options;
		var _b0=$.data(_ae,"datagrid").data.rows;
		if(typeof row=="object"){
		return _1(_b0,row);
		}else{
		for(var i=0;i<_b0.length;i++){
		if(_b0[i][_af.idField]==row){
		return i;
		}
		}
		return -1;
		}
		};
		function _b1(_b2){
		var _b3=$.data(_b2,"datagrid").options;
		var _b4=$.data(_b2,"datagrid").data;
		if(_b3.idField){
		return $.data(_b2,"datagrid").selectedRows;
		}else{
		var _b5=[];
		_b3.finder.getTr(_b2,"","selected",2).each(function(){
		var _b6=parseInt($(this).attr("datagrid-row-index"));
		_b5.push(_b4.rows[_b6]);
		});
		return _b5;
		}
		};
		function _66(_b7){
		_b8(_b7);
		var _b9=$.data(_b7,"datagrid").selectedRows;
		_b9.splice(0,_b9.length);
		};
		function _ba(_bb){
		var _bc=$.data(_bb,"datagrid").options;
		var _bd=$.data(_bb,"datagrid").data.rows;
		var _be=$.data(_bb,"datagrid").selectedRows;
		var tr=_bc.finder.getTr(_bb,"","allbody").addClass("datagrid-row-selected");
		var _bf=tr.find("div.datagrid-cell-check input[type=checkbox]");
		$.fn.prop?_bf.prop("checked",true):_bf.attr("checked",true);
		for(var _c0=0;_c0<_bd.length;_c0++){
		if(_bc.idField){
		(function(){
		var row=_bd[_c0];
		for(var i=0;i<_be.length;i++){
		if(_be[i][_bc.idField]==row[_bc.idField]){
		return;
		}
		}
		_be.push(row);
		})();
		}
		}
		_bc.onSelectAll.call(_bb,_bd);
		};
		function _b8(_c1){
		var _c2=$.data(_c1,"datagrid").options;
		var _c3=$.data(_c1,"datagrid").data;
		var _c4=$.data(_c1,"datagrid").selectedRows;
		var tr=_c2.finder.getTr(_c1,"","selected").removeClass("datagrid-row-selected");
		var _c5=tr.find("div.datagrid-cell-check input[type=checkbox]");
		$.fn.prop?_c5.prop("checked",false):_c5.attr("checked",false);
		if(_c2.idField){
		for(var _c6=0;_c6<_c3.rows.length;_c6++){
		_3(_c4,_c2.idField,_c3.rows[_c6][_c2.idField]);
		}
		}
		_c2.onUnselectAll.call(_c1,_c3.rows);
		};
		function _67(_c7,_c8){
		var dc=$.data(_c7,"datagrid").dc;
		var _c9=$.data(_c7,"datagrid").options;
		var _ca=$.data(_c7,"datagrid").data;
		var _cb=$.data(_c7,"datagrid").selectedRows;
		if(_c8<0||_c8>=_ca.rows.length){
		return;
		}
		if(_c9.singleSelect==true){
		_66(_c7);
		}
		var tr=_c9.finder.getTr(_c7,_c8);
		if(!tr.hasClass("datagrid-row-selected")){
		tr.addClass("datagrid-row-selected");
		var ck=$("div.datagrid-cell-check input[type=checkbox]",tr);
		$.fn.prop?ck.prop("checked",true):ck.attr("checked",true);
		if(_c9.idField){
		var row=_ca.rows[_c8];
		(function(){
		for(var i=0;i<_cb.length;i++){
		if(_cb[i][_c9.idField]==row[_c9.idField]){
		return;
		}
		}
		_cb.push(row);
		})();
		}
		}
		_c9.onSelect.call(_c7,_c8,_ca.rows[_c8]);
		var _cc=dc.view2.children("div.datagrid-header").outerHeight();
		var _cd=dc.body2;
		var top=tr.position().top-_cc;
		if(top<=0){
		_cd.scrollTop(_cd.scrollTop()+top);
		}else{
		if(top+tr.outerHeight()>_cd.height()-18){
		_cd.scrollTop(_cd.scrollTop()+top+tr.outerHeight()-_cd.height()+18);
		}
		}
		};
		function _ce(_cf,_d0){
		var _d1=$.data(_cf,"datagrid").options;
		var _d2=$.data(_cf,"datagrid").data;
		if(_d1.idField){
		var _d3=-1;
		for(var i=0;i<_d2.rows.length;i++){
		if(_d2.rows[i][_d1.idField]==_d0){
		_d3=i;
		break;
		}
		}
		if(_d3>=0){
		_67(_cf,_d3);
		}
		}
		};
		function _68(_d4,_d5){
		var _d6=$.data(_d4,"datagrid").options;
		var dc=$.data(_d4,"datagrid").dc;
		var _d7=$.data(_d4,"datagrid").data;
		var _d8=$.data(_d4,"datagrid").selectedRows;
		if(_d5<0||_d5>=_d7.rows.length){
		return;
		}
		var tr=_d6.finder.getTr(_d4,_d5);
		var ck=tr.find("div.datagrid-cell-check input[type=checkbox]");
		tr.removeClass("datagrid-row-selected");
		$.fn.prop?ck.prop("checked",false):ck.attr("checked",false);
		var row=_d7.rows[_d5];
		if(_d6.idField){
		_3(_d8,_d6.idField,row[_d6.idField]);
		}
		_d6.onUnselect.call(_d4,_d5,row);
		};
		function _d9(_da,_db){
		var _dc=$.data(_da,"datagrid").options;
		var tr=_dc.finder.getTr(_da,_db);
		var row=_dc.finder.getRow(_da,_db);
		if(tr.hasClass("datagrid-row-editing")){
		return;
		}
		if(_dc.onBeforeEdit.call(_da,_db,row)==false){
		return;
		}
		tr.addClass("datagrid-row-editing");
		_dd(_da,_db);
		_94(_da);
		tr.find("div.datagrid-editable").each(function(){
		var _de=$(this).parent().attr("field");
		var ed=$.data(this,"datagrid.editor");
		ed.actions.setValue(ed.target,row[_de]);
		});
		_df(_da,_db);
		};
		function _e0(_e1,_e2,_e3){
		var _e4=$.data(_e1,"datagrid").options;
		var _e5=$.data(_e1,"datagrid").updatedRows;
		var _e6=$.data(_e1,"datagrid").insertedRows;
		var tr=_e4.finder.getTr(_e1,_e2);
		var row=_e4.finder.getRow(_e1,_e2);
		if(!tr.hasClass("datagrid-row-editing")){
		return;
		}
		if(!_e3){
		if(!_df(_e1,_e2)){
		return;
		}
		var _e7=false;
		var _e8={};
		tr.find("div.datagrid-editable").each(function(){
		var _e9=$(this).parent().attr("field");
		var ed=$.data(this,"datagrid.editor");
		var _ea=ed.actions.getValue(ed.target);
		if(row[_e9]!=_ea){
		row[_e9]=_ea;
		_e7=true;
		_e8[_e9]=_ea;
		}
		});
		if(_e7){
		if(_1(_e6,row)==-1){
		if(_1(_e5,row)==-1){
		_e5.push(row);
		}
		}
		}
		}
		tr.removeClass("datagrid-row-editing");
		_eb(_e1,_e2);
		$(_e1).datagrid("refreshRow",_e2);
		if(!_e3){
		_e4.onAfterEdit.call(_e1,_e2,row,_e8);
		}else{
		_e4.onCancelEdit.call(_e1,_e2,row);
		}
		};
		function _ec(_ed,_ee){
		var _ef=$.data(_ed,"datagrid").options;
		var tr=_ef.finder.getTr(_ed,_ee);
		var _f0=[];
		tr.children("td").each(function(){
		var _f1=$(this).find("div.datagrid-editable");
		if(_f1.length){
		var ed=$.data(_f1[0],"datagrid.editor");
		_f0.push(ed);
		}
		});
		return _f0;
		};
		function _f2(_f3,_f4){
		var _f5=_ec(_f3,_f4.index);
		for(var i=0;i<_f5.length;i++){
		if(_f5[i].field==_f4.field){
		return _f5[i];
		}
		}
		return null;
		};
		function _dd(_f6,_f7){
		var _f8=$.data(_f6,"datagrid").options;
		var tr=_f8.finder.getTr(_f6,_f7);
		tr.children("td").each(function(){
		var _f9=$(this).find("div.datagrid-cell");
		var _fa=$(this).attr("field");
		var col=_7d(_f6,_fa);
		if(col&&col.editor){
		var _fb,_fc;
		if(typeof col.editor=="string"){
		_fb=col.editor;
		}else{
		_fb=col.editor.type;
		_fc=col.editor.options;
		}
		var _fd=_f8.editors[_fb];
		if(_fd){
		var _fe=_f9.html();
		var _ff=_f9.outerWidth();
		_f9.addClass("datagrid-editable");
		if($.boxModel==true){
		_f9.width(_ff-(_f9.outerWidth()-_f9.width()));
		}
		_f9.html("<table border=\"0\" cellspacing=\"0\" cellpadding=\"1\"><tr><td></td></tr></table>");
		_f9.children("table").attr("align",col.align);
		_f9.children("table").bind("click dblclick contextmenu",function(e){
		e.stopPropagation();
		});
		$.data(_f9[0],"datagrid.editor",{actions:_fd,target:_fd.init(_f9.find("td"),_fc),field:_fa,type:_fb,oldHtml:_fe});
		}
		}
		});
		_1e(_f6,_f7);
		};
		function _eb(_100,_101){
		var opts=$.data(_100,"datagrid").options;
		var tr=opts.finder.getTr(_100,_101);
		tr.children("td").each(function(){
		var cell=$(this).find("div.datagrid-editable");
		if(cell.length){
		var ed=$.data(cell[0],"datagrid.editor");
		if(ed.actions.destroy){
		ed.actions.destroy(ed.target);
		}
		cell.html(ed.oldHtml);
		$.removeData(cell[0],"datagrid.editor");
		var _102=cell.outerWidth();
		cell.removeClass("datagrid-editable");
		if($.boxModel==true){
		cell.width(_102-(cell.outerWidth()-cell.width()));
		}
		}
		});
		};
		function _df(_103,_104){
		var tr=$.data(_103,"datagrid").options.finder.getTr(_103,_104);
		if(!tr.hasClass("datagrid-row-editing")){
		return true;
		}
		var vbox=tr.find(".validatebox-text");
		vbox.validatebox("validate");
		vbox.trigger("mouseleave");
		var _105=tr.find(".validatebox-invalid");
		return _105.length==0;
		};
		function _106(_107,_108){
		var _109=$.data(_107,"datagrid").insertedRows;
		var _10a=$.data(_107,"datagrid").deletedRows;
		var _10b=$.data(_107,"datagrid").updatedRows;
		if(!_108){
		var rows=[];
		rows=rows.concat(_109);
		rows=rows.concat(_10a);
		rows=rows.concat(_10b);
		return rows;
		}else{
		if(_108=="inserted"){
		return _109;
		}else{
		if(_108=="deleted"){
		return _10a;
		}else{
		if(_108=="updated"){
		return _10b;
		}
		}
		}
		}
		return [];
		};
		function _10c(_10d,_10e){
		var opts=$.data(_10d,"datagrid").options;
		var data=$.data(_10d,"datagrid").data;
		var _10f=$.data(_10d,"datagrid").insertedRows;
		var _110=$.data(_10d,"datagrid").deletedRows;
		var _111=$.data(_10d,"datagrid").selectedRows;
		$(_10d).datagrid("cancelEdit",_10e);
		var row=data.rows[_10e];
		if(_1(_10f,row)>=0){
		_3(_10f,row);
		}else{
		_110.push(row);
		}
		_3(_111,opts.idField,data.rows[_10e][opts.idField]);
		opts.view.deleteRow.call(opts.view,_10d,_10e);
		if(opts.height=="auto"){
		_1e(_10d);
		}
		};
		function _112(_113,_114){
		var view=$.data(_113,"datagrid").options.view;
		var _115=$.data(_113,"datagrid").insertedRows;
		view.insertRow.call(view,_113,_114.index,_114.row);
		_56(_113);
		_115.push(_114.row);
		};
		function _116(_117,row){
		var view=$.data(_117,"datagrid").options.view;
		var _118=$.data(_117,"datagrid").insertedRows;
		view.insertRow.call(view,_117,null,row);
		_56(_117);
		_118.push(row);
		};
		function _119(_11a){
		var data=$.data(_11a,"datagrid").data;
		var rows=data.rows;
		var _11b=[];
		for(var i=0;i<rows.length;i++){
		_11b.push($.extend({},rows[i]));
		}
		$.data(_11a,"datagrid").originalRows=_11b;
		$.data(_11a,"datagrid").updatedRows=[];
		$.data(_11a,"datagrid").insertedRows=[];
		$.data(_11a,"datagrid").deletedRows=[];
		};
		function _11c(_11d){
		var data=$.data(_11d,"datagrid").data;
		var ok=true;
		for(var i=0,len=data.rows.length;i<len;i++){
		if(_df(_11d,i)){
		_e0(_11d,i,false);
		}else{
		ok=false;
		}
		}
		if(ok){
		_119(_11d);
		}
		};
		function _11e(_11f){
		var opts=$.data(_11f,"datagrid").options;
		var _120=$.data(_11f,"datagrid").originalRows;
		var _121=$.data(_11f,"datagrid").insertedRows;
		var _122=$.data(_11f,"datagrid").deletedRows;
		var _123=$.data(_11f,"datagrid").selectedRows;
		var data=$.data(_11f,"datagrid").data;
		for(var i=0;i<data.rows.length;i++){
		_e0(_11f,i,true);
		}
		var _124=[];
		for(var i=0;i<_123.length;i++){
		_124.push(_123[i][opts.idField]);
		}
		_123.splice(0,_123.length);
		data.total+=_122.length-_121.length;
		data.rows=_120;
		_a3(_11f,data);
		for(var i=0;i<_124.length;i++){
		_ce(_11f,_124[i]);
		}
		_119(_11f);
		};
		function _125(_126,_127){
		var opts=$.data(_126,"datagrid").options;
		if(_127){
		opts.queryParams=_127;
		}
		if(!opts.url){
		return;
		}
		var _128=$.extend({},opts.queryParams);
		if(opts.pagination){
		$.extend(_128,{page:opts.pageNumber,rows:opts.pageSize});
		}
		if(opts.sortName){
		$.extend(_128,{sort:opts.sortName,order:opts.sortOrder});
		}
		if(opts.onBeforeLoad.call(_126,_128)==false){
		return;
		}
		$(_126).datagrid("loading");
		setTimeout(function(){
		_129();
		},0);
		function _129(){
		$.ajax({type:opts.method,url:opts.url,data:_128,dataType:"json",success:function(data){
		setTimeout(function(){
		$(_126).datagrid("loaded");
		},0);
		_a3(_126,data);
		setTimeout(function(){
		_119(_126);
		},0);
		},error:function(){
		setTimeout(function(){
		$(_126).datagrid("loaded");
		},0);
		if(opts.onLoadError){
		opts.onLoadError.apply(_126,arguments);
		}
		}});
		};
		};
		function _12a(_12b,_12c){
		var opts=$.data(_12b,"datagrid").options;
		var rows=$.data(_12b,"datagrid").data.rows;
		_12c.rowspan=_12c.rowspan||1;
		_12c.colspan=_12c.colspan||1;
		if(_12c.index<0||_12c.index>=rows.length){
		return;
		}
		if(_12c.rowspan==1&&_12c.colspan==1){
		return;
		}
		var _12d=rows[_12c.index][_12c.field];
		var tr=opts.finder.getTr(_12b,_12c.index);
		var td=tr.find("td[field=\""+_12c.field+"\"]");
		td.attr("rowspan",_12c.rowspan).attr("colspan",_12c.colspan);
		td.addClass("datagrid-td-merged");
		for(var i=1;i<_12c.colspan;i++){
		td=td.next();
		td.hide();
		rows[_12c.index][td.attr("field")]=_12d;
		}
		for(var i=1;i<_12c.rowspan;i++){
		tr=tr.next();
		var td=tr.find("td[field=\""+_12c.field+"\"]").hide();
		rows[_12c.index+i][td.attr("field")]=_12d;
		for(var j=1;j<_12c.colspan;j++){
		td=td.next();
		td.hide();
		rows[_12c.index+i][td.attr("field")]=_12d;
		}
		}
		setTimeout(function(){
		_8b(_12b);
		},0);
		};
		$.fn.datagrid=function(_12e,_12f){
		if(typeof _12e=="string"){
		return $.fn.datagrid.methods[_12e](this,_12f);
		}
		_12e=_12e||{};
		return this.each(function(){
		var _130=$.data(this,"datagrid");
		var opts;
		if(_130){
		opts=$.extend(_130.options,_12e);
		_130.options=opts;
		}else{
		opts=$.extend({},$.extend({},$.fn.datagrid.defaults,{queryParams:{}}),$.fn.datagrid.parseOptions(this),_12e);
		$(this).css("width","").css("height","");
		var _131=_2c(this,opts.rownumbers);
		if(!opts.columns){
		opts.columns=_131.columns;
		}
		if(!opts.frozenColumns){
		opts.frozenColumns=_131.frozenColumns;
		}
		$.data(this,"datagrid",{options:opts,panel:_131.panel,dc:_131.dc,selectedRows:[],data:{total:0,rows:[]},originalRows:[],updatedRows:[],insertedRows:[],deletedRows:[]});
		}
		_41(this);
		if(!_130){
		var data=_3c(this);
		if(data.total>0){
		_a3(this,data);
		_119(this);
		}
		}
		_6(this);
		if(opts.url){
		_125(this);
		}
		_69(this);
		});
		};
		var _132={text:{init:function(_133,_134){
		var _135=$("<input type=\"text\" class=\"datagrid-editable-input\">").appendTo(_133);
		//alert('line 2786');
		return _135;
		},getValue:function(_136){
		return $(_136).val();
		},setValue:function(_137,_138){
		$(_137).val(_138);
		},resize:function(_139,_13a){
		var _13b=$(_139);
		if($.boxModel==true){
		_13b.width(_13a-(_13b.outerWidth()-_13b.width()));
		}else{
		_13b.width(_13a);
		}
		}},textarea:{init:function(_13c,_13d){
		var _13e=$("<textarea class=\"datagrid-editable-input\"></textarea>").appendTo(_13c);
		return _13e;
		},getValue:function(_13f){
		return $(_13f).val();
		},setValue:function(_140,_141){
		$(_140).val(_141);
		},resize:function(_142,_143){
		var _144=$(_142);
		if($.boxModel==true){
		_144.width(_143-(_144.outerWidth()-_144.width()));
		}else{
		_144.width(_143);
		}
		}},checkbox:{init:function(_145,_146){
		var _147=$("<input type=\"checkbox\">").appendTo(_145);
		_147.val(_146.on);
		_147.attr("offval",_146.off);
		return _147;
		},getValue:function(_148){
		if($(_148).is(":checked")){
		return $(_148).val();
		}else{
		return $(_148).attr("offval");
		}
		},setValue:function(_149,_14a){
		var _14b=false;
		if($(_149).val()==_14a){
		_14b=true;
		}
		$.fn.prop?$(_149).prop("checked",_14b):$(_149).attr("checked",_14b);
		}},numberbox:{init:function(_14c,_14d){
		var _14e=$("<input type=\"text\" class=\"datagrid-editable-input\">").appendTo(_14c);
		//alert('line 2832')
		_14e.numberbox(_14d);
		return _14e;
		},destroy:function(_14f){
		$(_14f).numberbox("destroy");
		},getValue:function(_150){
		return $(_150).numberbox("getValue");
		},setValue:function(_151,_152){
		$(_151).numberbox("setValue",_152);
		},resize:function(_153,_154){
		var _155=$(_153);
		if($.boxModel==true){
		_155.width(_154-(_155.outerWidth()-_155.width()));
		}else{
		_155.width(_154);
		}
		}},validatebox:{init:function(_156,_157){
		var _158=$("<input type=\"text\" class=\"datagrid-editable-input\">").appendTo(_156);
		//alert('line 2850');
		_158.validatebox(_157);
		return _158;
		},destroy:function(_159){
		$(_159).validatebox("destroy");
		},getValue:function(_15a){
		return $(_15a).val();
		},setValue:function(_15b,_15c){
		$(_15b).val(_15c);
		},resize:function(_15d,_15e){
		var _15f=$(_15d);
		if($.boxModel==true){
		_15f.width(_15e-(_15f.outerWidth()-_15f.width()));
		}else{
		_15f.width(_15e);
		}
		}},datebox:{init:function(_160,_161){
		var _162=$("<input type=\"text\">").appendTo(_160);
		//alert('line 2868');
		_162.datebox(_161);
		return _162;
		},destroy:function(_163){
		$(_163).datebox("destroy");
		},getValue:function(_164){
		return $(_164).datebox("getValue");
		},setValue:function(_165,_166){
		$(_165).datebox("setValue",_166);
		},resize:function(_167,_168){
		$(_167).datebox("resize",_168);
		}},combobox:{init:function(_169,_16a){
		var _16b=$("<input type=\"text\">").appendTo(_169);
		//alert('line 2881');
		_16b.combobox(_16a||{});
		return _16b;
		},destroy:function(_16c){
		$(_16c).combobox("destroy");
		},getValue:function(_16d){
		return $(_16d).combobox("getValue");
		},setValue:function(_16e,_16f){
		$(_16e).combobox("setValue",_16f);
		},resize:function(_170,_171){
		$(_170).combobox("resize",_171);
		}},combotree:{init:function(_172,_173){
		var _174=$("<input type=\"text\">").appendTo(_172);
		//alert('line 2894');
		_174.combotree(_173);
		return _174;
		},destroy:function(_175){
		$(_175).combotree("destroy");
		},getValue:function(_176){
		return $(_176).combotree("getValue");
		},setValue:function(_177,_178){
		$(_177).combotree("setValue",_178);
		},resize:function(_179,_17a){
		$(_179).combotree("resize",_17a);
		}}};
		$.fn.datagrid.methods={options:function(jq){
		var _17b=$.data(jq[0],"datagrid").options;
		var _17c=$.data(jq[0],"datagrid").panel.panel("options");
		var opts=$.extend(_17b,{width:_17c.width,height:_17c.height,closed:_17c.closed,collapsed:_17c.collapsed,minimized:_17c.minimized,maximized:_17c.maximized});
		var _17d=jq.datagrid("getPager");
		if(_17d.length){
		var _17e=_17d.pagination("options");
		$.extend(opts,{pageNumber:_17e.pageNumber,pageSize:_17e.pageSize});
		}
		return opts;
		},getPanel:function(jq){
		return $.data(jq[0],"datagrid").panel;
		},getPager:function(jq){
		return $.data(jq[0],"datagrid").panel.find("div.datagrid-pager");
		},getColumnFields:function(jq,_17f){
		return _40(jq[0],_17f);
		},getColumnOption:function(jq,_180){
		return _7d(jq[0],_180);
		},resize:function(jq,_181){
		return jq.each(function(){
		_6(this,_181);
		});
		},load:function(jq,_182){
		return jq.each(function(){
		var opts=$(this).datagrid("options");
		opts.pageNumber=1;
		var _183=$(this).datagrid("getPager");
		_183.pagination({pageNumber:1});
		_125(this,_182);
		});
		},reload:function(jq,_184){
		return jq.each(function(){
		_125(this,_184);
		});
		},reloadFooter:function(jq,_185){
		return jq.each(function(){
		var opts=$.data(this,"datagrid").options;
		var view=$(this).datagrid("getPanel").children("div.datagrid-view");
		var _186=view.children("div.datagrid-view1");
		var _187=view.children("div.datagrid-view2");
		if(_185){
		$.data(this,"datagrid").footer=_185;
		}
		if(opts.showFooter){
		opts.view.renderFooter.call(opts.view,this,_187.find("div.datagrid-footer-inner"),false);
		opts.view.renderFooter.call(opts.view,this,_186.find("div.datagrid-footer-inner"),true);
		if(opts.view.onAfterRender){
		opts.view.onAfterRender.call(opts.view,this);
		}
		$(this).datagrid("fixRowHeight");
		}
		});
		},loading:function(jq){
		return jq.each(function(){
		var opts=$.data(this,"datagrid").options;
		$(this).datagrid("getPager").pagination("loading");
		if(opts.loadMsg){
		var _188=$(this).datagrid("getPanel");
		$("<div class=\"datagrid-mask\" style=\"display:block\"></div>").appendTo(_188);
		$("<div class=\"datagrid-mask-msg\" style=\"display:block\"></div>").html(opts.loadMsg).appendTo(_188);
		_1a(this);
		}
		});
		},loaded:function(jq){
		return jq.each(function(){
		$(this).datagrid("getPager").pagination("loaded");
		var _189=$(this).datagrid("getPanel");
		_189.children("div.datagrid-mask-msg").remove();
		_189.children("div.datagrid-mask").remove();
		});
		},fitColumns:function(jq){
		return jq.each(function(){
		_76(this);
		});
		},fixColumnSize:function(jq){
		return jq.each(function(){
		_36(this);
		});
		},fixRowHeight:function(jq,_18a){
		return jq.each(function(){
		_1e(this,_18a);
		});
		},loadData:function(jq,data){
		return jq.each(function(){
		_a3(this,data);
		_119(this);
		});
		},getData:function(jq){
		return $.data(jq[0],"datagrid").data;
		},getRows:function(jq){
		return $.data(jq[0],"datagrid").data.rows;
		},getFooterRows:function(jq){
		return $.data(jq[0],"datagrid").footer;
		},getRowIndex:function(jq,id){
		return _ad(jq[0],id);
		},getSelected:function(jq){
		var rows=_b1(jq[0]);
		return rows.length>0?rows[0]:null;
		},getSelections:function(jq){
		return _b1(jq[0]);
		},clearSelections:function(jq){
		return jq.each(function(){
		_66(this);
		});
		},selectAll:function(jq){
		return jq.each(function(){
		_ba(this);
		});
		},unselectAll:function(jq){
		return jq.each(function(){
		_b8(this);
		});
		},selectRow:function(jq,_18b){
		return jq.each(function(){
		_67(this,_18b);
		});
		},selectRecord:function(jq,id){
		return jq.each(function(){
		_ce(this,id);
		});
		},unselectRow:function(jq,_18c){
		return jq.each(function(){
		_68(this,_18c);
		});
		},beginEdit:function(jq,_18d){
		return jq.each(function(){
		_d9(this,_18d);
		});
		},endEdit:function(jq,_18e){
		return jq.each(function(){
		_e0(this,_18e,false);
		});
		},cancelEdit:function(jq,_18f){
		return jq.each(function(){
		_e0(this,_18f,true);
		});
		},getEditors:function(jq,_190){
		return _ec(jq[0],_190);
		},getEditor:function(jq,_191){
		return _f2(jq[0],_191);
		},refreshRow:function(jq,_192){
		return jq.each(function(){
		var opts=$.data(this,"datagrid").options;
		opts.view.refreshRow.call(opts.view,this,_192);
		});
		},validateRow:function(jq,_193){
		return _df(jq[0],_193);
		},updateRow:function(jq,_194){
		return jq.each(function(){
		var opts=$.data(this,"datagrid").options;
		opts.view.updateRow.call(opts.view,this,_194.index,_194.row);
		});
		},appendRow:function(jq,row){
		return jq.each(function(){
		_116(this,row);
		});
		},insertRow:function(jq,_195){
		return jq.each(function(){
		_112(this,_195);
		});
		},deleteRow:function(jq,_196){
		return jq.each(function(){
		_10c(this,_196);
		});
		},getChanges:function(jq,_197){
		return _106(jq[0],_197);
		},acceptChanges:function(jq){
		return jq.each(function(){
		_11c(this);
		});
		},rejectChanges:function(jq){
		return jq.each(function(){
		_11e(this);
		});
		},mergeCells:function(jq,_198){
		return jq.each(function(){
		_12a(this,_198);
		});
		},showColumn:function(jq,_199){
		return jq.each(function(){
		var _19a=$(this).datagrid("getPanel");
		_19a.find("td[field=\""+_199+"\"]").show();
		$(this).datagrid("getColumnOption",_199).hidden=false;
		$(this).datagrid("fitColumns");
		});
		},hideColumn:function(jq,_19b){
		return jq.each(function(){
		var _19c=$(this).datagrid("getPanel");
		_19c.find("td[field=\""+_19b+"\"]").hide();
		$(this).datagrid("getColumnOption",_19b).hidden=true;
		$(this).datagrid("fitColumns");
		});
		}};
		$.fn.datagrid.parseOptions=function(_19d){
		var t=$(_19d);
		return $.extend({},$.fn.panel.parseOptions(_19d),{fitColumns:(t.attr("fitColumns")?t.attr("fitColumns")=="true":undefined),striped:(t.attr("striped")?t.attr("striped")=="true":undefined),nowrap:(t.attr("nowrap")?t.attr("nowrap")=="true":undefined),rownumbers:(t.attr("rownumbers")?t.attr("rownumbers")=="true":undefined),singleSelect:(t.attr("singleSelect")?t.attr("singleSelect")=="true":undefined),pagination:(t.attr("pagination")?t.attr("pagination")=="true":undefined),pageSize:(t.attr("pageSize")?parseInt(t.attr("pageSize")):undefined),pageNumber:(t.attr("pageNumber")?parseInt(t.attr("pageNumber")):undefined),pageList:(t.attr("pageList")?eval(t.attr("pageList")):undefined),remoteSort:(t.attr("remoteSort")?t.attr("remoteSort")=="true":undefined),sortName:t.attr("sortName"),sortOrder:t.attr("sortOrder"),showHeader:(t.attr("showHeader")?t.attr("showHeader")=="true":undefined),showFooter:(t.attr("showFooter")?t.attr("showFooter")=="true":undefined),scrollbarSize:(t.attr("scrollbarSize")?parseInt(t.attr("scrollbarSize")):undefined),loadMsg:(t.attr("loadMsg")!=undefined?t.attr("loadMsg"):undefined),idField:t.attr("idField"),toolbar:t.attr("toolbar"),url:t.attr("url"),rowStyler:(t.attr("rowStyler")?eval(t.attr("rowStyler")):undefined)});
		};
		var _19e={render:function(_19f,_1a0,_1a1){
		var opts=$.data(_19f,"datagrid").options;
		var rows=$.data(_19f,"datagrid").data.rows;
		var _1a2=$(_19f).datagrid("getColumnFields",_1a1);
		if(_1a1){
		if(!(opts.rownumbers||(opts.frozenColumns&&opts.frozenColumns.length))){
		return;
		}
		}
		var _1a3=["<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tbody>"];
		for(var i=0;i<rows.length;i++){
		var cls=(i%2&&opts.striped)?"class=\"datagrid-row-alt\"":"";
		var _1a4=opts.rowStyler?opts.rowStyler.call(_19f,i,rows[i]):"";
		var _1a5=_1a4?"style=\""+_1a4+"\"":"";
		_1a3.push("<tr datagrid-row-index=\""+i+"\" "+cls+" "+_1a5+">");
		_1a3.push(this.renderRow.call(this,_19f,_1a2,_1a1,i,rows[i]));
		_1a3.push("</tr>");
		}
		_1a3.push("</tbody></table>");
		$(_1a0).html(_1a3.join(""));
		},renderFooter:function(_1a6,_1a7,_1a8){
		var opts=$.data(_1a6,"datagrid").options;
		var rows=$.data(_1a6,"datagrid").footer||[];
		var _1a9=$(_1a6).datagrid("getColumnFields",_1a8);
		var _1aa=["<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tbody>"];
		for(var i=0;i<rows.length;i++){
		_1aa.push("<tr datagrid-row-index=\""+i+"\">");
		_1aa.push(this.renderRow.call(this,_1a6,_1a9,_1a8,i,rows[i]));
		_1aa.push("</tr>");
		}
		_1aa.push("</tbody></table>");
		$(_1a7).html(_1aa.join(""));
		},renderRow:function(_1ab,_1ac,_1ad,_1ae,_1af){
		var opts=$.data(_1ab,"datagrid").options;
		var cc=[];
		if(_1ad&&opts.rownumbers){
		var _1b0=_1ae+1;
		if(opts.pagination){
		_1b0+=(opts.pageNumber-1)*opts.pageSize;
		}
		cc.push("<td class=\"datagrid-td-rownumber\"><div class=\"datagrid-cell-rownumber\">"+_1b0+"</div></td>");
		}
		for(var i=0;i<_1ac.length;i++){
		var _1b1=_1ac[i];
		var col=$(_1ab).datagrid("getColumnOption",_1b1);
		if(col){
		var _1b2=col.styler?(col.styler(_1af[_1b1],_1af,_1ae)||""):"";
		var _1b3=col.hidden?"style=\"display:none;"+_1b2+"\"":(_1b2?"style=\""+_1b2+"\"":"");
		cc.push("<td field=\""+_1b1+"\" "+_1b3+">");
		var _1b3="width:"+(col.boxWidth)+"px;";
		_1b3+="text-align:"+(col.align||"left")+";";
		_1b3+=opts.nowrap==false?"white-space:normal;":"";
		cc.push("<div style=\""+_1b3+"\" ");
		if(col.checkbox){
		cc.push("class=\"datagrid-cell-check ");
		}else{
		cc.push("class=\"datagrid-cell ");
		}
		cc.push("\">");
		if(col.checkbox){
		cc.push("<input type=\"checkbox\"/>");
		}else{
		if(col.formatter){
		cc.push(col.formatter(_1af[_1b1],_1af,_1ae));
		}else{
		cc.push(_1af[_1b1]);
		}
		}
		cc.push("</div>");
		cc.push("</td>");
		}
		}
		return cc.join("");
		},refreshRow:function(_1b4,_1b5){
		var row={};
		var _1b6=$(_1b4).datagrid("getColumnFields",true).concat($(_1b4).datagrid("getColumnFields",false));
		for(var i=0;i<_1b6.length;i++){
		row[_1b6[i]]=undefined;
		}
		var rows=$(_1b4).datagrid("getRows");
		$.extend(row,rows[_1b5]);
		this.updateRow.call(this,_1b4,_1b5,row);
		},updateRow:function(_1b7,_1b8,row){
		var opts=$.data(_1b7,"datagrid").options;
		var rows=$(_1b7).datagrid("getRows");
		var tr=opts.finder.getTr(_1b7,_1b8);
		for(var _1b9 in row){
		rows[_1b8][_1b9]=row[_1b9];
		var td=tr.children("td[field=\""+_1b9+"\"]");
		var cell=td.find("div.datagrid-cell");
		var col=$(_1b7).datagrid("getColumnOption",_1b9);
		if(col){
		var _1ba=col.styler?col.styler(rows[_1b8][_1b9],rows[_1b8],_1b8):"";
		td.attr("style",_1ba||"");
		if(col.hidden){
		td.hide();
		}
		if(col.formatter){
		cell.html(col.formatter(rows[_1b8][_1b9],rows[_1b8],_1b8));
		//alert('3202,col.formatter');
		}else{
		cell.html(rows[_1b8][_1b9]);
		}
		}
		}
		var _1ba=opts.rowStyler?opts.rowStyler.call(_1b7,_1b8,rows[_1b8]):"";
		tr.attr("style",_1ba||"");
		$(_1b7).datagrid("fixRowHeight",_1b8);
		},insertRow:function(_1bb,_1bc,row){
		var opts=$.data(_1bb,"datagrid").options;
		var dc=$.data(_1bb,"datagrid").dc;
		var data=$.data(_1bb,"datagrid").data;
		if(_1bc==undefined||_1bc==null){
		_1bc=data.rows.length;
		}
		if(_1bc>data.rows.length){
		_1bc=data.rows.length;
		}
		for(var i=data.rows.length-1;i>=_1bc;i--){
		opts.finder.getTr(_1bb,i,"body",2).attr("datagrid-row-index",i+1);
		var tr=opts.finder.getTr(_1bb,i,"body",1).attr("datagrid-row-index",i+1);
		if(opts.rownumbers){
		tr.find("div.datagrid-cell-rownumber").html(i+2);
		}
		}
		var _1bd=$(_1bb).datagrid("getColumnFields",true);
		var _1be=$(_1bb).datagrid("getColumnFields",false);
		var tr1="<tr datagrid-row-index=\""+_1bc+"\">"+this.renderRow.call(this,_1bb,_1bd,true,_1bc,row)+"</tr>";
		var tr2="<tr datagrid-row-index=\""+_1bc+"\">"+this.renderRow.call(this,_1bb,_1be,false,_1bc,row)+"</tr>";
		if(_1bc>=data.rows.length){
		if(data.rows.length){
		opts.finder.getTr(_1bb,"","last",1).after(tr1);
		opts.finder.getTr(_1bb,"","last",2).after(tr2);
		}else{
		dc.body1.html("<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tbody>"+tr1+"</tbody></table>");
		dc.body2.html("<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tbody>"+tr2+"</tbody></table>");
		}
		}else{
		opts.finder.getTr(_1bb,_1bc+1,"body",1).before(tr1);
		opts.finder.getTr(_1bb,_1bc+1,"body",2).before(tr2);
		}
		data.total+=1;
		data.rows.splice(_1bc,0,row);
		this.refreshRow.call(this,_1bb,_1bc);
		},deleteRow:function(_1bf,_1c0){
		var opts=$.data(_1bf,"datagrid").options;
		var data=$.data(_1bf,"datagrid").data;
		opts.finder.getTr(_1bf,_1c0).remove();
		for(var i=_1c0+1;i<data.rows.length;i++){
		opts.finder.getTr(_1bf,i,"body",2).attr("datagrid-row-index",i-1);
		var tr1=opts.finder.getTr(_1bf,i,"body",1).attr("datagrid-row-index",i-1);
		if(opts.rownumbers){
		tr1.find("div.datagrid-cell-rownumber").html(i);
		}
		}
		data.total-=1;
		data.rows.splice(_1c0,1);
		},onBeforeRender:function(_1c1,rows){
		},onAfterRender:function(_1c2){
		var opts=$.data(_1c2,"datagrid").options;
		if(opts.showFooter){
		var _1c3=$(_1c2).datagrid("getPanel").find("div.datagrid-footer");
		_1c3.find("div.datagrid-cell-rownumber,div.datagrid-cell-check").css("visibility","hidden");
		}
		}};
		$.fn.datagrid.defaults=$.extend({},$.fn.panel.defaults,{frozenColumns:null,columns:null,fitColumns:false,toolbar:null,striped:false,method:"post",nowrap:true,idField:null,url:null,loadMsg:"Đang xử lý...",rownumbers:false,singleSelect:false,pagination:false,pageNumber:1,pageSize:10,pageList:[10,20,30,40,50],queryParams:{},sortName:null,sortOrder:"asc",remoteSort:true,showHeader:true,showFooter:false,scrollbarSize:18,rowStyler:function(_1c4,_1c5){
		},loadFilter:function(data){
		//	try{
		if(typeof data.length=="number"&&typeof data.splice=="function"){
		return {total:data.length,rows:data};
		}else{
		return data;
		}
		//	}catch(err){alert('aaaa')}
		},editors:_132,finder:{getTr:function(_1c6,_1c7,type,_1c8){
		type=type||"body";
		_1c8=_1c8||0;
		var dc=$.data(_1c6,"datagrid").dc;
		var opts=$.data(_1c6,"datagrid").options;
		if(_1c8==0){
		var tr1=opts.finder.getTr(_1c6,_1c7,type,1);
		var tr2=opts.finder.getTr(_1c6,_1c7,type,2);
		return tr1.add(tr2);
		}else{
		if(type=="body"){
		return (_1c8==1?dc.body1:dc.body2).find(">table>tbody>tr[datagrid-row-index="+_1c7+"]");
		}else{
		if(type=="footer"){
		return (_1c8==1?dc.footer1:dc.footer2).find(">table>tbody>tr[datagrid-row-index="+_1c7+"]");
		}else{
		if(type=="selected"){
		return (_1c8==1?dc.body1:dc.body2).find(">table>tbody>tr.datagrid-row-selected");
		}else{
		if(type=="last"){
		return (_1c8==1?dc.body1:dc.body2).find(">table>tbody>tr:last[datagrid-row-index]");
		}else{
		if(type=="allbody"){
		return (_1c8==1?dc.body1:dc.body2).find(">table>tbody>tr[datagrid-row-index]");
		}else{
		if(type=="allfooter"){
		return (_1c8==1?dc.footer1:dc.footer2).find(">table>tbody>tr[datagrid-row-index]");
		}
		}
		}
		}
		}
		}
		}
		},getRow:function(_1c9,_1ca){
		return $.data(_1c9,"datagrid").data.rows[_1ca];
		}},view:_19e,onBeforeLoad:function(_1cb){
		},onLoadSuccess:function(){
		},onLoadError:function(){
		},onClickRow:function(_1cc,_1cd){
		},onDblClickRow:function(_1ce,_1cf){
		},onClickCell:function(_1d0,_1d1,_1d2){
		},onDblClickCell:function(_1d3,_1d4,_1d5){
		},onSortColumn:function(sort,_1d6){
		},onResizeColumn:function(_1d7,_1d8){
		},onSelect:function(_1d9,_1da){
		},onUnselect:function(_1db,_1dc){
		},onSelectAll:function(rows){
		},onUnselectAll:function(rows){
		},onBeforeEdit:function(_1dd,_1de){
		},onAfterEdit:function(_1df,_1e0,_1e1){
		},onCancelEdit:function(_1e2,_1e3){
		},onHeaderContextMenu:function(e,_1e4){
		},onRowContextMenu:function(e,_1e5,_1e6){
		}});
		})(jQuery);

/**Pagination*/
(function($){
	function _1(_2){
	var _3=$.data(_2,"pagination").options;
	var _4=$(_2).addClass("pagination").empty();
	var t=$("<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tr></tr></table>").appendTo(_4);
	var tr=$("tr",t);
	if(_3.showPageList){
	var ps=$("<select class=\"pagination-page-list\"></select>");
	for(var i=0;i<_3.pageList.length;i++){
	var _5=$("<option></option>").text(_3.pageList[i]).appendTo(ps);
	if(_3.pageList[i]==_3.pageSize){
	_5.attr("selected","selected");
	}
	}
	$("<td></td>").append(ps).appendTo(tr);
	_3.pageSize=parseInt(ps.val());
	$("<td><div class=\"pagination-btn-separator\"></div></td>").appendTo(tr);
	}
	$("<td><a href=\"javascript:void(0)\" icon=\"pagination-first\"></a></td>").appendTo(tr);
	$("<td><a href=\"javascript:void(0)\" icon=\"pagination-prev\"></a></td>").appendTo(tr);
	$("<td><div class=\"pagination-btn-separator\"></div></td>").appendTo(tr);
	$("<span style=\"padding-left:6px;\"></span>").html(_3.beforePageText).wrap("<td></td>").parent().appendTo(tr);
	$("<td><input class=\"pagination-num\" type=\"text\" value=\"1\" size=\"2\"></td>").appendTo(tr);
	$("<span style=\"padding-right:6px;\"></span>").wrap("<td></td>").parent().appendTo(tr);
	$("<td><div class=\"pagination-btn-separator\"></div></td>").appendTo(tr);
	$("<td><a href=\"javascript:void(0)\" icon=\"pagination-next\"></a></td>").appendTo(tr);
	$("<td><a href=\"javascript:void(0)\" icon=\"pagination-last\"></a></td>").appendTo(tr);
	if(_3.showRefresh){
	$("<td><div class=\"pagination-btn-separator\"></div></td>").appendTo(tr);
	$("<td><a href=\"javascript:void(0)\" icon=\"pagination-load\"></a></td>").appendTo(tr);
	}
	if(_3.buttons){
	$("<td><div class=\"pagination-btn-separator\"></div></td>").appendTo(tr);
	for(var i=0;i<_3.buttons.length;i++){
	var _6=_3.buttons[i];
	if(_6=="-"){
	$("<td><div class=\"pagination-btn-separator\"></div></td>").appendTo(tr);
	}else{
	var td=$("<td></td>").appendTo(tr);
	$("<a href=\"javascript:void(0)\"></a>").addClass("l-btn").css("float","left").text(_6.text||"").attr("icon",_6.iconCls||"").bind("click",eval(_6.handler||function(){
	})).appendTo(td).linkbutton({plain:true});
	}
	}
	}
	$("<div class=\"pagination-info\"></div>").appendTo(_4);
	$("<div style=\"clear:both;\"></div>").appendTo(_4);
	$("a[icon^=pagination]",_4).linkbutton({plain:true});
	_4.find("a[icon=pagination-first]").unbind(".pagination").bind("click.pagination",function(){
	if(_3.pageNumber>1){
	_b(_2,1);
	}
	});
	_4.find("a[icon=pagination-prev]").unbind(".pagination").bind("click.pagination",function(){
	if(_3.pageNumber>1){
	_b(_2,_3.pageNumber-1);
	}
	});
	_4.find("a[icon=pagination-next]").unbind(".pagination").bind("click.pagination",function(){
	var _7=Math.ceil(_3.total/_3.pageSize);
	if(_3.pageNumber<_7){
	_b(_2,_3.pageNumber+1);
	}
	});
	_4.find("a[icon=pagination-last]").unbind(".pagination").bind("click.pagination",function(){
	var _8=Math.ceil(_3.total/_3.pageSize);
	if(_3.pageNumber<_8){
	_b(_2,_8);
	}
	});
	_4.find("a[icon=pagination-load]").unbind(".pagination").bind("click.pagination",function(){
	if(_3.onBeforeRefresh.call(_2,_3.pageNumber,_3.pageSize)!=false){
	_b(_2,_3.pageNumber);
	_3.onRefresh.call(_2,_3.pageNumber,_3.pageSize);
	}
	});
	_4.find("input.pagination-num").unbind(".pagination").bind("keydown.pagination",function(e){
	if(e.keyCode==13){
	var _9=parseInt($(this).val())||1;
	_b(_2,_9);
	}
	});
	_4.find(".pagination-page-list").unbind(".pagination").bind("change.pagination",function(){
	_3.pageSize=$(this).val();
	_3.onChangePageSize.call(_2,_3.pageSize);
	var _a=Math.ceil(_3.total/_3.pageSize);
	_b(_2,_3.pageNumber);
	});
	};
	function _b(_c,_d){
	var _e=$.data(_c,"pagination").options;
	var _f=Math.ceil(_e.total/_e.pageSize)||1;
	var _10=_d;
	if(_d<1){
	_10=1;
	}
	if(_d>_f){
	_10=_f;
	}
	_e.pageNumber=_10;
	_e.onSelectPage.call(_c,_10,_e.pageSize);
	_11(_c);
	};
	function _11(_12){
	var _13=$.data(_12,"pagination").options;
	var _14=Math.ceil(_13.total/_13.pageSize)||1;
	var num=$(_12).find("input.pagination-num");
	num.val(_13.pageNumber);
	num.parent().next().find("span").html(_13.afterPageText.replace(/{pages}/,_14));
	var _15=_13.displayMsg;
	if (_13.total == 0){
		_15=_15.replace(/{from}/,'');
		_15=_15.replace(/{to}/,'');
		_15=_15.replace(/{total}/,'Không có dữ liệu');
	} else {
		_15=_15.replace(/{from}/,'Hiển thị '+(_13.pageSize*(_13.pageNumber-1)+1) + ' - ');
		_15=_15.replace(/{to}/,Math.min(_13.pageSize*(_13.pageNumber),_13.total));
		_15=_15.replace(/{total}/,' / '+_13.total + ' bản ghi');
	}
	$(_12).find(".pagination-info").html(_15);
	$("a[icon=pagination-first],a[icon=pagination-prev]",_12).linkbutton({disabled:(_13.pageNumber==1)});
	$("a[icon=pagination-next],a[icon=pagination-last]",_12).linkbutton({disabled:(_13.pageNumber==_14)});
	if(_13.loading){
	$(_12).find("a[icon=pagination-load]").find(".pagination-load").addClass("pagination-loading");
	}else{
	$(_12).find("a[icon=pagination-load]").find(".pagination-load").removeClass("pagination-loading");
	}
	};
	function _16(_17,_18){
	var _19=$.data(_17,"pagination").options;
	_19.loading=_18;
	if(_19.loading){
	$(_17).find("a[icon=pagination-load]").find(".pagination-load").addClass("pagination-loading");
	}else{
	$(_17).find("a[icon=pagination-load]").find(".pagination-load").removeClass("pagination-loading");
	}
	};
	$.fn.pagination=function(_1a,_1b){
	if(typeof _1a=="string"){
	return $.fn.pagination.methods[_1a](this,_1b);
	}
	_1a=_1a||{};
	return this.each(function(){
	var _1c;
	var _1d=$.data(this,"pagination");
	if(_1d){
	_1c=$.extend(_1d.options,_1a);
	}else{
	_1c=$.extend({},$.fn.pagination.defaults,_1a);
	$.data(this,"pagination",{options:_1c});
	}
	_1(this);
	_11(this);
	});
	};
	$.fn.pagination.methods={options:function(jq){
	return $.data(jq[0],"pagination").options;
	},loading:function(jq){
	return jq.each(function(){
	_16(this,true);
	});
	},loaded:function(jq){
	return jq.each(function(){
	_16(this,false);
	});
	}};
	$.fn.pagination.defaults={total:1,pageSize:10,pageNumber:1,pageList:[10,20,30,50],loading:false,buttons:null,showPageList:true,showRefresh:true,onSelectPage:function(_1e,_1f){
	},onBeforeRefresh:function(_20,_21){
	},onRefresh:function(_22,_23){
	},onChangePageSize:function(_24){
	},beforePageText:"Trang",afterPageText:"/ {pages}",displayMsg:"{from}{to}{total}"};
	})(jQuery);

	
	
	
/**LinkButton */
(function($){
	function _1(_2){
	var _3=$.data(_2,"linkbutton").options;
	$(_2).empty();
	$(_2).addClass("l-btn");
	if(_3.id){
	$(_2).attr("id",_3.id);
	}else{
	$.fn.removeProp?$(_2).removeProp("id"):$(_2).removeAttr("id");
	}
	if(_3.plain){
	$(_2).addClass("l-btn-plain");
	}else{
	$(_2).removeClass("l-btn-plain");
	}
	if(_3.text){
	$(_2).html(_3.text).wrapInner("<span class=\"l-btn-left\">"+"<span class=\"l-btn-text\">"+"</span>"+"</span>");
	if(_3.iconCls){
	$(_2).find(".l-btn-text").addClass(_3.iconCls).css("padding-left","20px");
	}
	}else{
	$(_2).html("&nbsp;").wrapInner("<span class=\"l-btn-left\">"+"<span class=\"l-btn-text\">"+"<span class=\"l-btn-empty\"></span>"+"</span>"+"</span>");
	if(_3.iconCls){
	$(_2).find(".l-btn-empty").addClass(_3.iconCls);
	}
	}
	$(_2).unbind(".linkbutton").bind("focus.linkbutton",function(){
	if(!_3.disabled){
	$(this).find("span.l-btn-text").addClass("l-btn-focus");
	}
	}).bind("blur.linkbutton",function(){
	$(this).find("span.l-btn-text").removeClass("l-btn-focus");
	});
	_4(_2,_3.disabled);
	};
	function _4(_5,_6){
	var _7=$.data(_5,"linkbutton");
	if(_6){
	_7.options.disabled=true;
	var _8=$(_5).attr("href");
	if(_8){
	_7.href=_8;
	$(_5).attr("href","javascript:void(0)");
	}
	if(_5.onclick){
	_7.onclick=_5.onclick;
	_5.onclick=null;
	}
	$(_5).addClass("l-btn-disabled");
	}else{
	_7.options.disabled=false;
	if(_7.href){
	$(_5).attr("href",_7.href);
	}
	if(_7.onclick){
	_5.onclick=_7.onclick;
	}
	$(_5).removeClass("l-btn-disabled");
	}
	};
	$.fn.linkbutton=function(_9,_a){
	if(typeof _9=="string"){
	return $.fn.linkbutton.methods[_9](this,_a);
	}
	_9=_9||{};
	return this.each(function(){
	var _b=$.data(this,"linkbutton");
	if(_b){
	$.extend(_b.options,_9);
	}else{
	$.data(this,"linkbutton",{options:$.extend({},$.fn.linkbutton.defaults,$.fn.linkbutton.parseOptions(this),_9)});
	$(this).removeAttr("disabled");
	}
	_1(this);
	});
	};
	$.fn.linkbutton.methods={options:function(jq){
	return $.data(jq[0],"linkbutton").options;
	},enable:function(jq){
	return jq.each(function(){
	_4(this,false);
	});
	},disable:function(jq){
	return jq.each(function(){
	_4(this,true);
	});
	}};
	$.fn.linkbutton.parseOptions=function(_c){
	var t=$(_c);
	return {id:t.attr("id"),disabled:(t.attr("disabled")?true:undefined),plain:(t.attr("plain")?t.attr("plain")=="true":undefined),text:$.trim(t.html()),iconCls:(t.attr("icon")||t.attr("iconCls"))};
	};
	$.fn.linkbutton.defaults={id:null,disabled:false,plain:false,text:"",iconCls:null};
	})(jQuery);

/**
 *propertygrid
 * 
 */
(function($){
	function _1(_2){
	var _3=$.data(_2,"propertygrid").options;
	$(_2).datagrid($.extend({},_3,{view:(_3.showGroup?_4:undefined),onClickRow:function(_5,_6){
	if(_3.editIndex!=_5){
	var _7=$(this).datagrid("getColumnOption","value");
	_7.editor=_6.editor;
	_8(_3.editIndex);
	$(this).datagrid("beginEdit",_5);
	$(this).datagrid("getEditors",_5)[0].target.focus();
	_3.editIndex=_5;
	}
	_3.onClickRow.call(_2,_5,_6);
	}}));
	$(_2).datagrid("getPanel").panel("panel").addClass("propertygrid");
	$(_2).datagrid("getPanel").find("div.datagrid-body").unbind(".propertygrid").bind("mousedown.propertygrid",function(e){
	e.stopPropagation();
	});
	$(document).unbind(".propertygrid").bind("mousedown.propertygrid",function(){
	_8(_3.editIndex);
	_3.editIndex=undefined;
	});
	function _8(_9){
	if(_9==undefined){
	return;
	}
	var t=$(_2);
	if(t.datagrid("validateRow",_9)){
	t.datagrid("endEdit",_9);
	}else{
	t.datagrid("cancelEdit",_9);
	}
	};
	};
	$.fn.propertygrid=function(_a,_b){
	if(typeof _a=="string"){
	var _c=$.fn.propertygrid.methods[_a];
	if(_c){
	return _c(this,_b);
	}else{
	return this.datagrid(_a,_b);
	}
	}
	_a=_a||{};
	return this.each(function(){
	var _d=$.data(this,"propertygrid");
	if(_d){
	$.extend(_d.options,_a);
	}else{
	$.data(this,"propertygrid",{options:$.extend({},$.fn.propertygrid.defaults,$.fn.propertygrid.parseOptions(this),_a)});
	}
	_1(this);
	});
	};
	$.fn.propertygrid.methods={};
	$.fn.propertygrid.parseOptions=function(_e){
	var t=$(_e);
	return $.extend({},$.fn.datagrid.parseOptions(_e),{showGroup:(t.attr("showGroup")?t.attr("showGroup")=="true":undefined)});
	};
	var _4=$.extend({},$.fn.datagrid.defaults.view,{render:function(_f,_10,_11){
	var _12=$.data(_f,"datagrid").options;
	var _13=$.data(_f,"datagrid").data.rows;
	var _14=$(_f).datagrid("getColumnFields",_11);
	var _15=[];
	var _16=0;
	var _17=this.groups;
	for(var i=0;i<_17.length;i++){
	var _18=_17[i];
	_15.push("<div class=\"datagrid-group\" group-index="+i+">");
	_15.push("<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"height:100%\"><tbody>");
	_15.push("<tr>");
	_15.push("<td style=\"border:0;\">");
	if(!_11){
	_15.push("<span>");
	_15.push(_12.groupFormatter.call(_f,_18.fvalue,_18.rows));
	_15.push("</span>");
	}
	_15.push("</td>");
	_15.push("</tr>");
	_15.push("</tbody></table>");
	_15.push("</div>");
	_15.push("<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tbody>");
	for(var j=0;j<_18.rows.length;j++){
	var cls=(_16%2&&_12.striped)?"class=\"datagrid-row-alt\"":"";
	var _19=_12.rowStyler?_12.rowStyler.call(_f,_16,_18.rows[j]):"";
	var _1a=_19?"style=\""+_19+"\"":"";
	_15.push("<tr datagrid-row-index=\""+_16+"\" "+cls+" "+_1a+">");
	_15.push(this.renderRow.call(this,_f,_14,_11,_16,_18.rows[j]));
	_15.push("</tr>");
	_16++;
	}
	_15.push("</tbody></table>");
	}
	$(_10).html(_15.join(""));
	},onAfterRender:function(_1b){
	var _1c=$.data(_1b,"datagrid").options;
	var _1d=$(_1b).datagrid("getPanel").find("div.datagrid-view");
	var _1e=_1d.children("div.datagrid-view1");
	var _1f=_1d.children("div.datagrid-view2");
	$.fn.datagrid.defaults.view.onAfterRender.call(this,_1b);
	if(_1c.rownumbers||_1c.frozenColumns.length){
	var _20=_1e.find("div.datagrid-group");
	}else{
	var _20=_1f.find("div.datagrid-group");
	}
	$("<td style=\"border:0\"><div class=\"datagrid-row-expander datagrid-row-collapse\" style=\"width:25px;height:16px;cursor:pointer\"></div></td>").insertBefore(_20.find("td"));
	_1d.find("div.datagrid-group").each(function(){
	var _21=$(this).attr("group-index");
	$(this).find("div.datagrid-row-expander").bind("click",{groupIndex:_21},function(e){
	var _22=_1d.find("div.datagrid-group[group-index="+e.data.groupIndex+"]");
	if($(this).hasClass("datagrid-row-collapse")){
	$(this).removeClass("datagrid-row-collapse").addClass("datagrid-row-expand");
	_22.next("table").hide();
	}else{
	$(this).removeClass("datagrid-row-expand").addClass("datagrid-row-collapse");
	_22.next("table").show();
	}
	$(_1b).datagrid("fixRowHeight");
	});
	});
	},onBeforeRender:function(_23,_24){
	var _25=$.data(_23,"datagrid").options;
	var _26=[];
	for(var i=0;i<_24.length;i++){
	var row=_24[i];
	var _27=_28(row[_25.groupField]);
	if(!_27){
	_27={fvalue:row[_25.groupField],rows:[row],startRow:i};
	_26.push(_27);
	}else{
	_27.rows.push(row);
	}
	}
	function _28(_29){
	for(var i=0;i<_26.length;i++){
	var _2a=_26[i];
	if(_2a.fvalue==_29){
	return _2a;
	}
	}
	return null;
	};
	this.groups=_26;
	var _2b=[];
	for(var i=0;i<_26.length;i++){
	var _27=_26[i];
	for(var j=0;j<_27.rows.length;j++){
	_2b.push(_27.rows[j]);
	}
	}
	$.data(_23,"datagrid").data.rows=_2b;
	}});
	$.fn.propertygrid.defaults=$.extend({},$.fn.datagrid.defaults,{singleSelect:true,remoteSort:false,fitColumns:true,loadMsg:"",frozenColumns:[[{field:"f",width:16,resizable:false}]],columns:[[{field:"name",title:"Name",width:100,sortable:true},{field:"value",title:"Value",width:100,resizable:false}]],showGroup:false,groupField:"group",groupFormatter:function(_2c){
	return _2c;
	}});
	})(jQuery);



/**numberbox*/
(function($){
	function _1(_2){
	var v=$("<input type=\"hidden\">").insertAfter(_2);
	var _3=$(_2).attr("name");
	if(_3){
	v.attr("name",_3);
	$(_2).removeAttr("name").attr("numberboxName",_3);
	}
	return v;
	};
	function _4(_5){
	var _6=$.data(_5,"numberbox").options;
	var fn=_6.onChange;
	_6.onChange=function(){
		//alert('3780:onchange')
	};
	_7(_5,_6.parser.call(_5,_6.value));
	_6.onChange=fn;
	};
	function _8(_9){
	return $.data(_9,"numberbox").field.val();
	};
	function _isFocus(_9){
		alert($.data(_9,"numberbox").isFocus)
		return $.data(_9,"numberbox").isFocus;
		};
	function _7(_a,_b){
	var _c=$.data(_a,"numberbox");
	var _d=_c.options;
	var _e=_8(_a);
	_b=_d.parser.call(_a,_b);
	_d.value=_b;
	_c.field.val(_b);

	$(_a).val(_d.formatter.call(_a,_b));
	//alert('3798: val='+_b+_e)
	if(_e!=_b){
		
	_d.onChange.call(_a,_b,_e);
	}
	};
	function _f(_10){
	var _11=$.data(_10,"numberbox").options;
	$(_10).unbind(".numberbox").bind("keypress.numberbox",function(e){
		//setTimeout("$.data(this,\"numberbox\").options.onKeyPressed.call()",250);//atmel added this

	if(e.which==45){
	return true;
	}
	if(e.which==46){
	return true;
	}else{
	if((e.which>=48&&e.which<=57&&e.ctrlKey==false&&e.shiftKey==false)||e.which==0||e.which==8){
		//[B] atmel added
		$(this).delay(100).queue(function(){ 
			//$.data(this,"datagrid").data.rows;
			_11.onKeyPressed.call(_10,e.which,$(this).val()); 
			  $(this).dequeue(); 
		});
		//[E] atmel added
	return true;
	}else{
	if(e.ctrlKey==true&&(e.which==99||e.which==118)){
	return true;
	}else{
	return false;
	}
	}
	}
	
	}).bind("paste.numberbox",function(){
	if(window.clipboardData){
	var s=clipboardData.getData("text");
	if(!/\D/.test(s)){
	return true;
	}else{
	return false;
	}
	}else{
	return false;
	}
	}).bind("dragenter.numberbox",function(){
	return false;
	}).bind("blur.numberbox",function(){
	_7(_10,$(this).val());
	$(this).val(_11.formatter.call(_10,_8(_10)));
		$.data(this,"numberbox").options.isFocus=false;//tuanna added 26122011
	}).bind("focus.numberbox",function(){
	var vv=_8(_10);
	if($(this).val()!=vv){
	$(this).val(vv);
	//alert('3846:this.val ='+$(this).val())
	}
	$.data(this,"numberbox").options.isFocus=true;//tuanna added 26122011
	});
	};
	function _12(_13){
	if($.fn.validatebox){
	var _14=$.data(_13,"numberbox").options;
	$(_13).validatebox(_14);
	}
	};
	function _15(_16,_17){
	var _18=$.data(_16,"numberbox").options;
	if(_17){
	_18.disabled=true;
	$(_16).attr("disabled",true);
	}else{
	_18.disabled=false;
	$(_16).removeAttr("disabled");
	}
	};
	$.fn.numberbox=function(_19,_1a){
	if(typeof _19=="string"){
	var _1b=$.fn.numberbox.methods[_19];
	if(_1b){
	return _1b(this,_1a);
	}else{
	return this.validatebox(_19,_1a);
	}
	}
	_19=_19||{};
	return this.each(function(){
	var _1c=$.data(this,"numberbox");
	if(_1c){
	$.extend(_1c.options,_19);
	}else{
	_1c=$.data(this,"numberbox",{options:$.extend({},$.fn.numberbox.defaults,$.fn.numberbox.parseOptions(this),_19),field:_1(this)});
	$(this).removeAttr("disabled");
	$(this).css({imeMode:"disabled"});
	}
	_15(this,_1c.options.disabled);
	_f(this);
	_12(this);
	_4(this);
	});
	};
	$.fn.numberbox.methods={options:function(jq){
	return $.data(jq[0],"numberbox").options;
	},destroy:function(jq){
	return jq.each(function(){
	$.data(this,"numberbox").field.remove();
	$(this).validatebox("destroy");
	$(this).remove();
	});
	},disable:function(jq){
	return jq.each(function(){
	_15(this,true);
	});
	},enable:function(jq){
	return jq.each(function(){
	_15(this,false);
	});
	},fix:function(jq){
	return jq.each(function(){
	_7(this,$(this).val());
	});
	},setValue:function(jq,_1d){
	return jq.each(function(){
	_7(this,_1d);
	});
	},getValue:function(jq){
	return _8(jq[0]);
	}
	,isFocus:function(jq){
		return _isFocus(jq[0]);
		}
	,getValueNow:function(jq){
		return _8($(this));
		}
	,clear:function(jq){
	return jq.each(function(){
	var _1e=$.data(this,"numberbox");
	_1e.field.val("");
	$(this).val("");
	});
	}};
	$.fn.numberbox.parseOptions=function(_1f){
	var t=$(_1f);
	return $.extend({},$.fn.validatebox.parseOptions(_1f),{isFocus:(t.attr("isFocus")?true:undefined),disabled:(t.attr("disabled")?true:undefined),value:(t.val()||undefined),min:(t.attr("min")=="0"?0:parseFloat(t.attr("min"))||undefined),max:(t.attr("max")=="0"?0:parseFloat(t.attr("max"))||undefined),precision:(parseInt(t.attr("precision"))||undefined),decimalSeparator:(t.attr("decimalSeparator")?t.attr("decimalSeparator"):undefined),groupSeparator:(t.attr("groupSeparator")?t.attr("groupSeparator"):undefined),prefix:(t.attr("prefix")?t.attr("prefix"):undefined),suffix:(t.attr("suffix")?t.attr("suffix"):undefined)});
	};
	$.fn.numberbox.defaults=$.extend({},$.fn.validatebox.defaults,{isFocus:false,disabled:false,value:"",min:null,max:null,precision:0,decimalSeparator:".",groupSeparator:"",prefix:"",suffix:"",
	formatter:function(_20){
	if(!_20){
	return _20;
	}
	_20=_20+"";
	var _21=$(this).numberbox("options");
	var s1=_20,s2="";
	var _22=_20.indexOf(".");
	if(_22>=0){
	s1=_20.substring(0,_22);
	s2=_20.substring(_22+1,_20.length);
	}
	if(_21.groupSeparator){
	var p=/(\d+)(\d{3})/;
	while(p.test(s1)){
	s1=s1.replace(p,"$1"+_21.groupSeparator+"$2");
	}
	}
	if(s2){
	return _21.prefix+s1+_21.decimalSeparator+s2+_21.suffix;
	}else{
	return _21.prefix+s1+_21.suffix;
	}
	}
	,parser:function(s){
	s=s+"";
	var _23=$(this).numberbox("options");
	if(_23.groupSeparator){
	s=s.replace(new RegExp("\\"+_23.groupSeparator,"g"),"");
	}
	if(_23.decimalSeparator){
	s=s.replace(new RegExp("\\"+_23.decimalSeparator,"g"),".");
	}
	if(_23.prefix){
	s=s.replace(new RegExp("\\"+$.trim(_23.prefix),"g"),"");
	}
	if(_23.suffix){
	s=s.replace(new RegExp("\\"+$.trim(_23.suffix),"g"),"");
	}
	s=s.replace(/\s/g,"");
	var val=parseFloat(s).toFixed(_23.precision);
	if(isNaN(val)){
	val="";
	}else{
	if(typeof (_23.min)=="number"&&val<_23.min){
	val=_23.min.toFixed(_23.precision);
	}else{
	if(typeof (_23.max)=="number"&&val>_23.max){
	val=_23.max.toFixed(_23.precision);
	}
	}
	}
	
	return val;
	},onChange:function(_24,_25){
		//alert('3973:onchange')
	},
	onChange:function(_24,_25){
		//alert('3973:onchange')
	},
	
	//[B] atmel added
	validator: function(value, param){
       
	},
	invalidMessage:'Tỷ lệ (%) lớn hơn 100%'
	,
	onKeyPressed:function(key,value){
	}
	//[E] atmel added
	});
	})(jQuery);


