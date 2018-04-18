  (function($){
    $.fn.extend({
        center: function () {
            return this.each(function() {
                var top = ($(window).height() - $(this).outerHeight()) / 2;
                var left = ($(window).width() - $(this).outerWidth()) / 2;
                $(this).css({position:'absolute', margin:0, top: (top > 0 ? top : 0)+'px', left: (left > 0 ? left : 0)+'px'});
            });
        }
    }); 
})(jQuery);

(function($){
  
  //GROWL OBJECT
  //--------------------------------------------------------------------


  $.ChartPanel = {

    _growlContainer: null,
    _statsCount: 0,
    
    show: function(message, options){
    
      var settings = $.extend({
        "id": "",
        "icon": false,
        "title": false,
        "message": message,
        "cls": "",
        "speed": 500,
        "timeout": 3000,
        "x":0,
        "y":0
      },options);
     
     if (settings.id == "9999") {
    	// alert("id="+settings.id)
    	// alert($("#"+settings.id).html())
    	 var ct =$("#"+settings.id).html();
    	// if (ct == null)alert('null');
    	 if (ct != null){
    		// alert('new content')
    		 $("#"+settings.id).html(settings.message);
    		 return settings.id;
    	 }
     }
      
      //append status
      this._getContainer().prepend(
        '<div id="'+settings.id+'" class="growlstatus '+settings.cls+'" ><div class="growlstatusclose"></div>'+'gdfgf '+'</div>'
      );
      
    $('#growlcontainer').center();
     /* var top = 120;
      var left = ($(window).width() - $('#growlcontainer').outerWidth()) / 2;
      $('#growlcontainer').css({position:'absolute', margin:0, top: (top > 0 ? top : 0)+'px', left: (left > 0 ? left : 0)+'px'});
*/
      
      var status = $("#"+settings.id);
      
      //bind close button
     /*status.find(".growlstatusclose").bind('click',function(){
        $.ChartPanel.close(settings.id,true,settings.speed);
      });*/
      
      //show title
     /* if(settings.title!==false){
        status.prepend('<div class="growltitle">'+settings.title+'</div>');
      }*/
      
      //show icon
     /* if(settings.icon!==false){
        status.addClass("growlwithicon").addClass("growlicon_"+settings.icon);
      }*/
      
      //status.show("scale",{percent:550, origin:['middle','center']});
      var easing=
      ['easeOutQuad',
      'easeInOutQuad',
      'easeInCubic',
      'easeOutCubic',
      'easeInOutCubic',
      'easeInQuart',
      'easeOutQuart',
      'easeInOutQuart',
      'easeInQuint',
      'easeOutQuint',
      'easeInOutQuint',
      'easeInSine',
      'easeOutSine',
      'easeInOutSine',
      'easeInExpo',
      'easeOutExpo',
      'easeInOutExpo',
      'easeInCirc',
      'easeOutCirc',
      'easeInOutCirc',
      'easeInElastic',
      'easeOutElastic',
      'easeInOutElastic',
      'easeInBack',
      'easeOutBack',
      'easeInOutBack',
      'easeInBounce',
      'easeOutBounce',
      'easeInOutBounce'//28
      ];
    var i=28;
      status.animate({
    	  width: ['800px', easing[iEffect]],
          height: ['400px', easing[i]],
          marginTop: ['-200px',easing[i]],
          marginLeft: ['-400px', easing[i]]
      }
      ,1000,easing[i],
      
      function() {
    	  window.setTimeout(
         function(){
        	 status.animate({
              width: ['50px', easing[i]],
              height: ['50px', easing[i]],
              marginTop: ['-25px', easing[i]],
              marginLeft: ['-25px', easing[i]]
          }, 1000, easing[i]);
          i++;
          if(i>28){i=0;alert('>28')}
      }
          ,2000);
      }
      
      );
    	            
     
      return settings.id;
    },
    
    close: function(id,force,speed){
    
      if(arguments.length==0){
        $(".growlstatus",this._getContainer()).hide().remove();
      }else{
          var status = $("#"+id);

          if(!status.hasClass("growlhover") || force){
            status.animate({opacity:"0.0"}, speed).slideUp(function(){
                  status.remove();
            })
          }
      }
    },
    
    _getContainer: function(){
      
      if(!this._growlContainer) {
        this._growlContainer = $('<div id="growlcontainer"></div>').appendTo("body");
      }
      return this._growlContainer;
    }
  };
})(jQuery);