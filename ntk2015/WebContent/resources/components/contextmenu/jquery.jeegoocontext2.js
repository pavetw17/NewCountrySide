// Copyright (c) 2009 - 2010 Erik van den Berg (http://www.planitworks.nl/jeegoocontext)
// Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) 
// and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
//
// Contributors:
// Denis Evteev
// Roman Imankulov (www.netangels.ru)
//
// Version: 1.3
// Requires jQuery 1.3.2+
(ctxmn =function($){
    this._global = null;
    this._menus = null;

    // Detect overflow.
    this._overflow = function(x, y){
        return {
            width : x - $(window).width() - $(window).scrollLeft(),
            height : y - $(window).height() - $(window).scrollTop()
        };
    };
    
    // Keyboard up/down
    this._onKeyUpDown = function(down){
        if(this._menus[this._global.activeId].currentHover)
        {
            // Hover the first visible menu-item from the next or previous siblings and skip any separator items.
            var prevNext = down ? 
            		this._menus[this._global.activeId].currentHover.nextAll(':not(.' + this._menus[this._global.activeId].separatorClass + '):visible:first') :
            			this._menus[this._global.activeId].currentHover.prevAll(':not(.' + this._menus[this._global.activeId].separatorClass + '):visible:first');
            // If nothing is found, hover the first or last visible sibling.
            if(prevNext.length == 0)
            {
                prevNext = this._menus[this._global.activeId].currentHover.parent().find('> li:visible');
                prevNext = (down ? $(prevNext[0]) : $(prevNext[prevNext.length - 1]));
            }
            prevNext.mouseover();
        }
        else
        {
            // Current hover is null, select the last visible submenu.
            var visibleMenus = $('#' + this._global.activeId + ', #' + this._global.activeId + ' ul').filter(function(){
                return ($(this).is(':visible') && $(this).parents(':hidden').length == 0);
            });
            if(visibleMenus.length > 0)
            {
                // Find all visible menu-items for this menu and hover the first or last visible sibling.
                var visibleItems = $(visibleMenus[visibleMenus.length - 1]).find('> li:visible');
                $(visibleItems[(down ? 0 : (visibleItems.length - 1))]).mouseover();
            }
        }
    };
    
    // Clear all active context.
    this._clearActive = function(){
        for(cm in this._menus)
        {
            $(this._menus[cm].allContext).removeClass(this._global.activeClass);
        } 
    };
    
    // Reset menu.
    this._resetMenu = function(){
        // Hide active menu and it's submenus.
        if(this._global.activeId)$('#' + this._global.activeId).add('#' + this._global.activeId + ' ul').hide(); 
        // Stop key up/down interval.
        clearInterval(this._global.keyUpDown);
        this._global.keyUpDownStop = false;
        // Clear current hover.
        if(this._menus[this._global.activeId])this._menus[this._global.activeId].currentHover = null;
        // Clear active menu.
        this._global.activeId = null;               
		// Unbind click and mouseover functions bound to the document
		$(document).unbind('.jeegoocontext');  
		// Unbind resize event bound to the window.
		$(window).unbind('resize.jeegoocontext');           
    };
    
    this._globalHide = function(e){
    	
        // Invoke onHide callback if set, 'this' refers to the menu.    
		// Discontinue default behavior if callback returns false.       
		if(this._global.activeId && this._menus[this._global.activeId].onHide)
		{
			if(this._menus[this._global.activeId].onHide.apply($('#' + this._global.activeId), [e, this._menus[this._global.activeId].context]) == false)
			{
				alert('hide')
				return false;
			}
		}

		// Default behavior.
		// =================================================== // 

		// Clear active context.
		this._clearActive();  
		// Hide active menu.
		this._resetMenu();
    };
	
	$.fn.jeegoocontext = function(id, options){
        
        if(!this._global) this._global = {};
        if(!this._menus) this._menus = {};
        
        // Always override _global.menuClass if value is provided by options.
        if(options && options.menuClass)this._global.menuClass = options.menuClass;
        // Only set _global.menuClass if not set.
        if(!this._global.menuClass)this._global.menuClass = 'jeegoocontext';
        // Always override _global.activeClass if value is provided by options.
        if(options && options.activeClass)this._global.activeClass = options.activeClass;
        // Only set _global.activeClass if not set.
        if(!this._global.activeClass)this._global.activeClass = 'active';
		
		// Default undefined:
		// livequery, bool
	    // event, string
		// openBelowContext, bool
		// ignoreWidthOverflow, bool
		// ignoreHeightOverflow, bool
		// autoHide, bool
		// onShow, function
		// onHover, function
		// onSelect, function
		// onHide, function
        this._menus[id] = $.extend({
            hoverClass: 'hover',
            submenuClass: 'submenu',
            separatorClass: 'separator',
            operaEvent: 'ctrl+click',
            fadeIn: 200,
            delay: 300,
            keyDelay: 100,
            widthOverflowOffset: 0,
            heightOverflowOffset: 0,
            submenuLeftOffset: 0,
            submenuTopOffset: 0,
            autoAddSubmenuArrows: true,
            startLeftOffset: 0,
            startTopOffset: 0,
            keyboard: true
        }, options || {});
             
        // All context bound to this menu.
        this._menus[id].allContext = this.selector;
        
        // Add mouseover and click handlers to the menu's items.
        $('#' + id).find('li')[this._menus[id].livequery ? 'expire' : 'unbind']('.jeegoocontext')[this._menus[id].livequery ? 'livequery' : 'bind']('mouseover.jeegoocontext', function(e){  

            var $this = this._menus[id].currentHover = $(this);
    
            // Clear hide and show timeouts.
            clearTimeout(this._menus[id].show);
            clearTimeout(this._menus[id].hide);
            
            // Clear all hover state.
            $('#' + id).find('*').removeClass(this._menus[id].hoverClass);
            
            // Set hover state on self, direct children, ancestors and ancestor direct children.
            var $parents = $this.parents('li');
            $this.add($this.find('> *')).add($parents).add($parents.find('> *')).addClass(this._menus[id].hoverClass);
            
            // Invoke onHover callback if set, 'this' refers to the hovered list-item.
            // Discontinue default behavior if callback returns false.  
            var continueDefault = true;                 
            if(this._menus[id].onHover)
            {
                if(this._menus[id].onHover.apply(this, [e, this._menus[id].context]) == false)continueDefault = false;
            }      
            
            // Continue after timeout(timeout is reset on every mouseover).
            if(!this._menus[id].proceed)
            {
            	this._menus[id].show = setTimeout(function(){
            		this._menus[id].proceed = true;
                    $this.mouseover(); 
                }, this._menus[id].delay);
                               
                return false;
            }            
            this._menus[id].proceed = false;

            // Hide all sibling submenu's and deeper level submenu's.
            $this.parent().find('ul').not($this.find('> ul')).hide();
            
            if(!continueDefault)
            {
                e.preventDefault();
                return false;
            }
            
            // Default behavior.
            // =================================================== //       
                
            // Position and fade-in submenu's.
            var $submenu = $this.find('> ul');
            if($submenu.length != 0)
            {
                var offSet = $this.offset();
                	 
                var overflow = this._overflow(
                    (offSet.left + $this.parent().width() + this._menus[id].submenuLeftOffset + $submenu.width() + this._menus[id].widthOverflowOffset), 
                    (offSet.top + this._menus[id].submenuTopOffset + $submenu.height() + this._menus[id].heightOverflowOffset)
                );
				var parentWidth = $submenu.parent().parent().width();
				var y = offSet.top - $this.parent().offset().top;
                $submenu.css(
                    {
                        'left': (overflow.width > 0 && !this._menus[id].ignoreWidthOverflow) ? (-parentWidth - this._menus[id].submenuLeftOffset + 'px') : (parentWidth + this._menus[id].submenuLeftOffset + 'px'),
                        'top': (overflow.height > 0 && !this._menus[id].ignoreHeightOverflow) ? (y - overflow.height + this._menus[id].submenuTopOffset) + 'px' : y + this._menus[id].submenuTopOffset + 'px'
                    }
                );     
                     	            
                $submenu.fadeIn(this._menus[id].fadeIn);   
            }
            e.stopPropagation(); 
        })[this._menus[id].livequery ? 'livequery' : 'bind']('click.jeegoocontext', function(e){
        
            // Invoke onSelect callback if set, 'this' refers to the selected listitem.
            // Discontinue default behavior if callback returns false.
            if(this._menus[id].onSelect)
            {            
                if(this._menus[id].onSelect.apply(this, [e, this._menus[id].context]) == false)
                {
                    return false;
                }
            }
            
            // Default behavior.
            //====================================================//
            
            // Reset menu
            this._resetMenu();
                
            // Clear active state from this context.
            $(this._menus[id].context).removeClass(this._global.activeClass);
            
            e.stopPropagation();
        });
        
        // Determine the event type used to invoke the menu.
        // Event type is a namespaced event so it can be easily unbound later.
        var div = document.createElement('div');
        div.setAttribute('oncontextmenu', '');
        var eventType = this._menus[id].event;
        if(!eventType)
        {
            eventType = (typeof div.oncontextmenu != 'undefined') ? 'contextmenu.jeegoocontext' : this._menus[id].operaEvent + '.jeegoocontext';
        }
        else
        {
            eventType += '.jeegoocontext';
        }
        
        // Searching for the modifier in the event type
        // (e.g. ctrl+click, shift+contextmenu)
        if (eventType.indexOf('+') != -1) 
        {
            var chunks = eventType.split('+', 2);
            this._menus[id].modifier = chunks[0] + 'Key';
            eventType = chunks[1];
        }
        
        // Add menu invocation handler to the context.
        return this[this._menus[id].livequery ? 'livequery' : 'bind'](eventType, function(e){
            // Check for the modifier if any.
			//if (typeof this._menus[id].modifier == 'string' && !e[this._menus[id].modifier]) return;
            
			// Save context(i.e. the current area to which the menu belongs).
        	ctxmn._menus[id].context = this;
            var $menu = $('#' + id);

            // Determine start position.
            var startLeft, startTop;
            if(this._menus[id].openBelowContext)
            {
                var contextOffset = $(this).offset();
                startLeft = contextOffset.left;
                startTop = contextOffset.top + $(this).outerHeight();
            }
            else
            {
                startLeft = e.pageX;
                startTop = e.pageY;
            }
            startLeft += this._menus[id].startLeftOffset;
            startTop += this._menus[id].startTopOffset;

            // Check for overflow and correct menu-position accordingly.         
            var overflow = this._overflow((startLeft + $menu.width() + this._menus[id].widthOverflowOffset), (startTop + $menu.height() + this._menus[id].heightOverflowOffset));         
            if(!this._menus[id].ignoreWidthOverflow && overflow.width > 0) startLeft -= overflow.width;
            // Ignore y-overflow if openBelowContext or if _menus[id].ignoreHeightOverflow
            if(!this._menus[id].openBelowContext && !this._menus[id].ignoreHeightOverflow && overflow.height > 0) 
            {
                startTop -= overflow.height;
            }
                
            // Invoke onShow callback if set, 'this' refers to the menu.
            // Discontinue default behavior if callback returns false.         
            if(this._menus[id].onShow)
            {
                if(this._menus[id].onShow.apply($menu, [e, this._menus[id].context, startLeft, startTop]) == false)
                {
                    return false;
                }
            }

            // Default behavior.
            // =================================================== //

            // Reset last active menu.
            this._resetMenu();

            // Set this id as active menu id.
            this._global.activeId = id;
            
            // Hide current menu and all submenus, on first page load this is neccesary for proper keyboard support.
            $('#' + this._global.activeId).add('#' + this._global.activeId + ' ul').hide();  

            // Clear all active context on page.
            this._clearActive();   
                   
            // Make this context active.
            $(this._menus[id].context).addClass(this._global.activeClass); 
                                   
            // Clear all hover state.
            $menu.find('li, li > *').removeClass(this._menus[id].hoverClass);
               
            // Auto add/delete submenu arrows(spans) if set by options.
            if(this._menus[id].autoAddSubmenuArrows)
            {
                $menu.find('li:has(ul)').not(':has(span.' + this._menus[id].submenuClass + ')').prepend('<span class="' + this._menus[id].submenuClass + '"></span>'); 
                $menu.find('li').not(':has(ul)').find('> span.' + this._menus[id].submenuClass).remove();     
            }
            
            // Fade-in menu at clicked-position.		
            $menu.css({
                'left': startLeft + 'px',
                'top':  startTop + 'px'
            }).fadeIn(this._menus[id].fadeIn);
			
			// If openBelowContext, maintain contextmenu left position on window resize event.
            if(this._menus[id].openBelowContext)
            {
                $(window).bind('resize.jeegoocontext', function(){
                    $('#' + id).css('left', $(this._menus[id].context).offset().left + this._menus[id].startLeftOffset + 'px');
                });
            }
        
			// Bind mouseover, keyup/keydown and click events to the document.
			$(document).bind('mouseover.jeegoocontext', function(e){ 
				// Remove hovers from last-opened submenu and hide any open relatedTarget submenu's after timeout.
				if($(e.relatedTarget).parents('#' + id).length > 0)
				{
					// Clear show submenu timeout.
					clearTimeout(this._menus[id].show);
								   
					var $li = $(e.relatedTarget).parent().find('li');               
					$li.add($li.find('> *')).removeClass(this._menus[id].hoverClass);
					
					// Clear last hovered menu-item.
					this._menus[_global.activeId].currentHover = null;
	
					// Set hide submenu timeout.
					this._menus[id].hide = setTimeout(function(){				    
						$li.find('ul').hide();
						if(this._menus[id].autoHide)this._globalHide(e);
					}, this._menus[id].delay);                             
				}
			}).bind('click.jeegoocontext', this._globalHide);
			
			if(this._menus[id].keyboard)
			{
			    $(document).bind('keydown.jeegoocontext', function(e){
			        switch(e.which)
			        {
			            case 38: //keyup
			            if(this._global.keyUpDownStop)return false;
			            this._onKeyUpDown();
			            this._global.keyUpDown = setInterval(this._onKeyUpDown, this._menus[this._global.activeId].keyDelay);
			            this._global.keyUpDownStop = true;
			            return false;
			            case 39: //keyright
			            if(this._menus[this._global.activeId].currentHover)
			            {
			            	this._menus[this._global.activeId].currentHover.find('ul:visible:first li:visible:first').mouseover(); 
			            }
			            else
			            {
			                var visibleMenus = $('#' + this._global.activeId + ', #' + this._global.activeId + ' ul:visible');
			                if(visibleMenus.length > 0)
			                {
			                    $(visibleMenus[visibleMenus.length - 1]).find(':visible:first').mouseover();
			                }
			            }
			            return false;
			            case 40: //keydown
			            if(this._global.keyUpDownStop)return false;
			            this._onKeyUpDown(true);
			            this._global.keyUpDown = setInterval(function(){
			            	this._onKeyUpDown(true);
			            }, this._menus[this._global.activeId].keyDelay);
			            this._global.keyUpDownStop = true;
			            return false;
			            case 37: //keyleft
			            if(this._menus[this._global.activeId].currentHover)
			            {
			                $(this._menus[this._global.activeId].currentHover.parents('li')[0]).mouseover();
			            }
                        else
                        {
                            var hoveredLi = $('#' + this._global.activeId + ' li.' + this._menus[_global.activeId].hoverClass);
                            if(hoveredLi.length > 0)$(hoveredLi[hoveredLi.length - 1]).mouseover();
                        }
                        return false;
			            case 13: //enter
			            if(this._menus[this._global.activeId].currentHover)
			            {
			            	this._menus[this._global.activeId].currentHover.click();
			            }
			            else
			            {
			            	this._globalHide(e);
			            }
			            break;
			            case 27: //escape
			            	this._globalHide(e);
			            break;
			            default:
			            break;
			        }
			    }).bind('keyup.jeegoocontext', function(e){
			        clearInterval(this._global.keyUpDown);
			        this._global.keyUpDownStop = false;
			    });
			}

            return false;
        });      
    }; 
	
	// Unbind context from context menu.
    $.fn.nojeegoocontext = function(){ 
        this.unbind('.jeegoocontext');
    };
       	   
})(jQuery);