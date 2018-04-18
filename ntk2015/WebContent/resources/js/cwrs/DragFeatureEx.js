/* Copyright (c) 2006-2011 by OpenLayers Contributors (see authors.txt for 
 * full list of contributors). Published under the Clear BSD license.  
 * See http://svn.openlayers.org/trunk/openlayers/license.txt for the
 * full text of the license. */


/**
 * @requires OpenLayers/Control.js
 * @requires OpenLayers/Handler/Drag.js
 * @requires OpenLayers/Handler/Feature.js
 */

/**
 * Class: OpenLayers.Control.DragFeature
 * The DragFeature control moves a feature with a drag of the mouse. Create a
 * new control with the <OpenLayers.Control.DragFeature> constructor.
 *
 * Inherits From:
 *  - <OpenLayers.Control>
 */
OpenLayers.Control.DragFeatureEx = OpenLayers.Class(OpenLayers.Control, {

    /**
     * APIProperty: geometryTypes
     * {Array(String)} To restrict dragging to a limited set of geometry types,
     *     send a list of strings corresponding to the geometry class names.
     */
    geometryTypes: null,
    
    /**
     * APIProperty: onStart
     * {Functions_DB} Define this function if you want to know when a drag starts.
     *     The function should expect to receive two arguments: the feature
     *     that is about to be dragged and the pixel location of the mouse.
     *
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>} The feature that is about to be
     *     dragged.
     * pixel - {<OpenLayers.Pixel>} The pixel location of the mouse.
     */
    onStart: function(feature, pixel) {},

    /**
     * APIProperty: onDrag
     * {Functions_DB} Define this function if you want to know about each move of a
     *     feature. The function should expect to receive two arguments: the
     *     feature that is being dragged and the pixel location of the mouse.
     *
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>} The feature that was dragged.
     * pixel - {<OpenLayers.Pixel>} The pixel location of the mouse.
     */
    onDrag: function(feature, pixel) {},

    /**
     * APIProperty: onComplete
     * {Functions_DB} Define this function if you want to know when a feature is
     *     done dragging. The function should expect to receive two arguments:
     *     the feature that is being dragged and the pixel location of the
     *     mouse.
     *
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>} The feature that was dragged.
     * pixel - {<OpenLayers.Pixel>} The pixel location of the mouse.
     */
    onComplete: function(feature, pixel) {},

    /**
     * APIProperty: onEnter
     * {Functions_DB} Define this function if you want to know when the mouse
     *     goes over a feature and thereby makes this feature a candidate
     *     for dragging.
     *
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>} The feature that is ready
     *     to be dragged.
     */
    onEnter: function(feature) {},

    /**
     * APIProperty: onLeave
     * {Functions_DB} Define this function if you want to know when the mouse
     *     goes out of the feature that was dragged.
     *
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>} The feature that was dragged.
     */
    onLeave: function(feature) {},

    /**
     * APIProperty: documentDrag
     * {Boolean} If set to true, mouse dragging will continue even if the
     *     mouse cursor leaves the map viewport. Default is false.
     */
    documentDrag: false,
    
    /**
     * Property: layer
     * {<OpenLayers.Layer.Vector>}
     */
    layer: null,
    
    /**
     * Property: feature
     * {<OpenLayers.Feature.Vector>}
     */
    feature: null,
    
    
    movingFeatures: null,
    /**
     * APIProperty: box
     * {Boolean} Allow feature selection by drawing a box.
     */
    box: true,
    
    style:null,
    selectedStyle:null,

    /**
     * Property: dragCallbacks
     * {Object} The functions that are sent to the drag handler for callback.
     */
    dragCallbacks: {},

    /**
     * Property: featureCallbacks
     * {Object} The functions that are sent to the feature handler for callback.
     */
    featureCallbacks: {},
    
    /**
     * Property: lastPixel
     * {<OpenLayers.Pixel>}
     */
    lastPixel: null,
    
    
    
    
    
    //Added by tuanna
    isDoneMovingEffect:true,
    orginalPixel: null,
    /**
     * Property: multipleKey
     * {String} An event modifier ('altKey' or 'shiftKey') that temporarily sets
     *     the <multiple> property to true.  Default is null.
     */
    multipleKey: 'shiftKey',
    /**
     * Property: toggleKey
     * {String} An event modifier ('altKey' or 'shiftKey') that temporarily sets
     *     the <toggle> property to true.  Default is null.
     */
    toggleKey: 'shiftKey',
    /**
     * APIProperty: multiple
     * {Boolean} Allow selection of multiple geometries.  Default is false.
     */
    multiple: true, 
    
    onUnselect: function() {},

    /**
     * Constructor: OpenLayers.Control.DragFeature
     * Create a new control to drag features.
     *
     * Parameters:
     * layer - {<OpenLayers.Layer.Vector>} The layer containing features to be
     *     dragged.
     * options - {Object} Optional object whose properties will be set on the
     *     control.
     */
    initialize: function(layer, style, options) {
        OpenLayers.Control.prototype.initialize.apply(this, [options]);
        this.layer = layer;
        this.handlers = {
            drag: new OpenLayers.Handler.Drag(
                this, OpenLayers.Util.extend({
                    down: this.downFeature,
                    move: this.moveFeature,
                    up: this.upFeature,
                    out: this.cancel,
                    done: this.doneDragging
                }, this.dragCallbacks), {
                    documentDrag: this.documentDrag
                }
            ),
            feature: new OpenLayers.Handler.Feature(
                this, this.layer, OpenLayers.Util.extend({
                    // 'click' and 'clickout' callback are for the mobile
                    // support: no 'over' or 'out' in touch based browsers.
                    click: this.clickFeature,
                    clickout: this.clickoutFeature,
                    over: this.overFeature,
                    out: this.outFeature
                }, this.featureCallbacks),
                {geometryTypes: this.geometryTypes}
            )
        };
        this.handlers.box = new OpenLayers.Handler.BoxEx(
                this, 
                {
                	start:this.mousedown,
                	done: this.selectBox
                },
                
                {boxDivClassName: "olHandlerBoxSelectFeature"}
            ); 
        this.style = style;
    },
    /**
     * Method: multipleSelect
     * Allow for multiple selected features based on <multiple> property and
     *     <multipleKey> event modifier.
     *
     * Returns:
     * {Boolean} Allow for multiple selected features.
     */
    multipleSelect: function() {
        return this.multiple || (this.handlers.feature.evt &&
                                 this.handlers.feature.evt[this.multipleKey]);
    },
    /**
     * Method: clickFeature
     * Called when the feature handler detects a click-in on a feature.
     *
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>}
     */
    clickFeature: function(feature) {
    	//alert('clickFeature');
    	if	(!this.isDoneMovingEffect)return;//do nothing when moving effect
    	var layer= feature.layer;
    	//neu dang o che de select multi thi check if feat selected -> unselected va nguoc lai
    	if (OpenLayers.Util.indexOf(layer.selectedFeatures, feature) != -1){
    		if (this.multipleSelect()){
    			this.unselect(feature);
    		} else {
    			this.unselectAll();
        		this.select(feature);
    		}
    	} else {
    		if (this.multipleSelect()){
    			this.select(feature);
    		} else {
    			this.unselectAll();
        		this.select(feature);
    		}
    	}
        if (this.handlers.feature.touch && !this.over && this.overFeature(feature)) {
            this.handlers.drag.dragstart(this.handlers.feature.evt);
            // to let the events propagate to the feature handler (click callback)
            this.handlers.drag.stopDown = false;
        }
        cwrs_debug('Total Feat Selected: ' + layer.selectedFeatures.length);
    },

    /**
     * Method: clickoutFeature
     * Called when the feature handler detects a click-out on a feature.
     *
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>}
     */
    clickoutFeature: function(feature) {
    	if	(!this.isDoneMovingEffect)return;//do nothing when moving effect
        if (this.handlers.feature.touch && this.over) {
            this.outFeature(feature);
            this.handlers.drag.stopDown = true;
        }
    },

  

    /**
     * Method: overFeature
     * Called when the feature handler detects a mouse-over on a feature.
     *     This activates the drag handler.
     *
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>} The selected feature.
     *
     * Returns:
     * {Boolean} Successfully activated the drag handler.
     */
    overFeature: function(feature) {
    	
    	if	(!this.isDoneMovingEffect)return;//do nothing when moving effect
    	var layer = feature.layer;
        var activated = false;
        //chỉ active drag box khi over qua feature đã được selected và multi-key ko dc chọn (ko nhấn shift,ctr)
        if (OpenLayers.Util.indexOf(layer.selectedFeatures, feature) != -1 && (!this.multipleSelect())) {
        	if(!this.handlers.drag.dragging) {
        		this.handlers.box.deactivate();
        		
           		this.feature = feature;
            	this.handlers.drag.activate();
            	activated = true;
            	this.over = true;
            	OpenLayers.Element.addClass(this.map.viewPortDiv, this.displayClass + "Over");
            	this.onEnter(feature);
            	 cwrs_debug('deactive: box, activate: drag');
        	} else {
        		if(this.feature.id == feature.id) {
                	this.over = true;
            	} else {
                	this.over = false;
            	}
        	}
        } else {
        	if(!this.handlers.drag.dragging) {
        	this.handlers.drag.deactivate();
        	this.handlers.box.activate();
        	
        	// cwrs_debug('active: box, deactivate: drag');
        	}
        }
       /* cwrs_debug('select at ruộng id: '+ feature.fid + '(cánh đồng id: '
        		+ feature.attributes['pid']);
        */
    	cwrs_debug('Moving over ....' +feature.fid + ',pid: ' + feature.attributes['pid']);
        
        return activated;
    },

    /**
     * Method: downFeature
     * Called when the drag handler detects a mouse-down.
     *
     * Parameters:
     * pixel - {<OpenLayers.Pixel>} Location of the mouse event.
     * Note: down event chỉ xảy ra khi feature đã được selected
     */
    downFeature: function(pixel) {
    	//alert('downFeature');
     if	(!this.isDoneMovingEffect)return;//do nothing when moving effect
    		
    	
        this.lastPixel = pixel;
        this.orginalPixel = pixel;
        this.onStart(this.feature, pixel);
    },
    getCanhdongByFeat:function(feature){
    	
    },
    /**
     * Method: moveFeature
     * Called when the drag handler detects a mouse-move.  Also calls the
     *     optional onDrag method.
     * 
     * Parameters:
     * pixel - {<OpenLayers.Pixel>} Location of the mouse event.
     */
    isShownTooltipMaxRuongMoving:false 
    ,moveFeature: function(pixel) {
    	cwrs_debug('MOVING..' + pixel.x +','+pixel.y )
    	if (this.isShownTooltipMaxRuongMoving == false){
    		showHint('Bạn chỉ có thể di chuyển đồng thời tối đa 3 ruộng!');
    		this.isShownTooltipMaxRuongMoving = true;
    	}
    	var res = this.map.getResolution();
        this.feature.geometry.move(res * (pixel.x - this.lastPixel.x),
                                   res * (this.lastPixel.y - pixel.y));
        //alert('this.feature.attributes[pid] ='+this.feature.attributes['pid']);
       // alert('ok');
       // Utils.startTime();
        var style = this.style;
        if(this.handlers.drag.dragging) {      
            //fill color with feature di qua
        	var feat = getFeatureAtPixelPos(pixel,this.feature);
        	if (feat != null) {
        		cwrs_debug('Over ' + feat.fid)
        		var canhdong = this.getCanhdongByFeat(feat);
        		 style.strokeColor = "red";
        		 style.strokeWidth = 4;
        		 style.fillColor = canhdong.getFillColor();
        		 style.fillOpacity = 1;
        		 //style.strokeDashstyle = "dot";//[dot | dash | dashdot 
            	
        	} else {
        		cwrs_debug('out all ...')
            	var canhdong = this.getCanhdongByFeat(this.feature);
            	this.style.fillColor = canhdong.getFillColor();
            	style = this.style;
        	}
        } else {
        	//
        	cwrs_debug('Done draging')
        	var canhdong = this.getCanhdongByFeat(this.feature);
        	this.style.fillColor = canhdong.getFillColor();
        	style = this.style;
        }
        
        this.layer.drawFeature(this.feature, style);
        this.lastPixel = pixel;
        this.onDrag(this.feature, pixel); 
        
        
      //  OpenLayers.LonLat
       var lonlat = this.feature.geometry.getBounds().getCenterLonLat();
       //cwrs_debug('lonlat:'+lonlat.lon +',' + lonlat.lat)
        var pixel = this.map.getPixelFromLonLat(lonlat);
       //cwrs_debug('pixel:'+pixel.x +',' + pixel.y);
      
        // cwrs_debug('res:'+res)
       // var p = this.feature.geometry.getBounds().getCenterPixel();
       // cwrs_debug('p:'+p.x +',' + p.y)
       // cwrs_debug('res:'+res)
        
    },
     /**
     * Method: upFeature
     * Called when the drag handler detects a mouse-up.
     * 
     * Parameters:
     * pixel - {<OpenLayers.Pixel>} Location of the mouse event.
     */
    upFeature: function(pixel) {
        if(!this.over) {
            this.handlers.drag.deactivate();
        }
    },
    
	__processSlide : function(currentX,currentY,targetX,targetY)
	{				
		// cwrs_debug('moving to pixel:' + currentX + ','+ currentY);
		// Find slide x value
		var slideX = Math.round(Math.abs(Math.max(currentX,targetX) - Math.min(currentX,targetX)) / 10);		
		// Find slide y value
		var slideY = Math.round(Math.abs(Math.max(currentY,targetY) - Math.min(currentY,targetY)) / 10);
		
		if(slideY<3 && Math.abs(slideX)<10)slideY = 3;	// 3 is minimum slide value
		if(slideX<3 && Math.abs(slideY)<10)slideX = 3;	// 3 is minimum slide value
		
		
		if(currentX > targetX) slideX*=-1;	// If current x is larger than target x, make slide value negative<br>
		if(currentY > targetY) slideY*=-1;	// If current y is larger than target x, make slide value negative
		
		// Update currentX and currentY
		currentX = currentX + slideX;	
		currentY = currentY + slideY;

		// If currentX or currentY is close to targetX or targetY, make currentX equal to targetX(or currentY equal to targetY)
		if(Math.max(currentX,targetX) - Math.min(currentX,targetX) < 4)currentX = targetX;
		if(Math.max(currentY,targetY) - Math.min(currentY,targetY) < 4)currentY = targetY;

		// Update CSS position(left and top)
		var pixel = new OpenLayers.Pixel(currentX,currentY);
		if (this.feature == null){
			alert('this.feature == null');
		}
		this.moveFeature(pixel);
		//this.dragObjCloneArray[numId].style.left = currentX + 'px';
		//this.dragObjCloneArray[numId].style.top = currentY + 'px';	
		
		// currentX different than targetX or currentY different than targetY, call this function in again in 5 milliseconds
		if(currentX!=targetX || currentY != targetY){
			window.thisRef = this;
			setTimeout('window.thisRef.__processSlide(' + currentX + ',' + currentY + ',' + targetX + ',' + targetY + ')',5);
		}else{	// Slide completed. Make absolute positioned element invisible and original element visible
			//this.dragObjCloneArray[numId].style.display='none';
			//this.dragDropSourcesArray[numId][0].style.visibility = 'visible';
			//alert('DONE MOVING...');
			this.isDoneMovingEffect = true;
		}		
	},

    /**
     * Method: doneDragging
     * Called when the drag handler is done dragging.
     *
     * Parameters:
     * pixel - {<OpenLayers.Pixel>} The last event pixel location.  If this event
     *     came from a mouseout, this may not be in the map viewport.
     */
    doneDragging: function(pixel) {
        this.onComplete(this.feature, pixel);
        var x = pixel.x;
        var y = pixel.y
        this.isDoneMovingEffect = false;
        this.__processSlide( x,y,this.orginalPixel.x ,this.orginalPixel.y)
        cwrs_debug('doneDragging pixel:' + pixel.x + ','+ pixel.y);
    },

    /**
     * Method: outFeature
     * Called when the feature handler detects a mouse-out on a feature.
     *
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>} The feature that the mouse left.
     */
    outFeature: function(feature) {
        if(!this.handlers.drag.dragging) {
            this.over = false;
            this.handlers.drag.deactivate();
            OpenLayers.Element.removeClass(
                this.map.viewPortDiv, this.displayClass + "Over"
            );
            this.onLeave(feature);
            
            if (this.isDoneMovingEffect){//do nothing when moving effect
            	this.feature = null;
            }
        } else {
            if(this.feature.id == feature.id) {
                this.over = false;
            }
        }
    },
        
    /**
     * Method: cancel
     * Called when the drag handler detects a mouse-out (from the map viewport).
     */
    cancel: function() {
        this.handlers.drag.deactivate();
        this.over = false;
    },
    
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
    
    /**
     * Method: highlight
     * Redraw feature with the select style.
     *
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>} 
     */
    highlight: function(feature, style) {
        var layer = feature.layer;
        var cont = this.events.triggerEvent("beforefeaturehighlighted", {
            feature : feature
        });
        if(cont !== false) {
            feature._prevHighlighter = feature._lastHighlighter;
            feature._lastHighlighter = this.id;
           
            
            var canhdong = g_cdm.getCanhdongByID(feature.attributes['pid']);
            style.strokeColor = "red";
            style.strokeWidth =3;
            style.fillColor= canhdong.getFillColor();
            style.fillOpacity =1;
            
            
        	layer.drawFeature(feature, style);
        this.events.triggerEvent("featurehighlighted", {feature : feature});
       }
    },

    /**
     * Method: unhighlight
     * Redraw feature with the "default" style
     *
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>} 
     * isUnSelect- unhighlight do được gọi từ unselect
     */
    unhighlight: function(feature, isUnSelect) {
        var layer = feature.layer;
        //alert('unhighlight');
        // three cases:
        // 1. there's no other highlighter, in that case _prev is undefined,
        //    and we just need to undef _last
        // 2. another control highlighted the feature after we did it, in
        //    that case _last references this other control, and we just
        //    need to undef _prev
        // 3. another control highlighted the feature before we did it, in
        //    that case _prev references this other control, and we need to
        //    set _last to _prev and undef _prev
        if(feature._prevHighlighter == undefined) {
            delete feature._lastHighlighter;
        } else if(feature._prevHighlighter == this.id) {
            delete feature._prevHighlighter;
        } else {
            feature._lastHighlighter = feature._prevHighlighter;
            delete feature._prevHighlighter;
        }
        var _styleMoreFeature;
        //nếu feature chưa được chọn (tô với style hiden
        if (OpenLayers.Util.indexOf(layer.selectedFeatures, feature) == -1) {
        	//layer.drawFeature(feature, feature.style ||"default");
        	_styleMoreFeature = feature.style ||"default";
        } else {//nếu đặc điểm đã được chọn
        	if (isUnSelect){//được gọi khi unselect -> tô với style hiden
        		_styleMoreFeature = feature.style ||"default";
        		//layer.drawFeature(feature, feature.style ||"default");
        		
        	} else { //nếu feature đang được chọn thì unhighligth với style selected
        		_styleMoreFeature = this.selectedStyle || feature.layer.style ||"default";
           		//layer.drawFeature(feature, _styleMoreFeature);
           		
        	}
        }

        var _style = g_style_fill_canhdong;
		 var canhdong = g_cdm.getCanhdongByID(feature.attributes['pid']);
		 //alert('feature.attributes[pid] ='+ feature.attributes['pid']);
		 _style.strokeWidth = 0.5;
		 _style.fillColor = canhdong.getFillColor();
	
    	layer.drawFeature(feature, _style);
   
        this.events.triggerEvent("featureunhighlighted", {feature : feature});
    },
    /**
     * Method: select
     * Add feature to the layer's selectedFeature array, render the feature as
     * selected, and call the onSelect function.
     * 
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>} 
     */
    select: function(feature) {
        //var cont = this.onBeforeSelect.call(this.scope, feature);
        var layer = feature.layer;
      /*  if(cont !== false) {
            cont = layer.events.triggerEvent("beforefeatureselected", {
                feature: feature
            });*/
          //  if(cont !== false)
            {
           	  layer.selectedFeatures.push(feature);
       
                this.highlight(feature, this.selectedStyle);
                // if the feature handler isn't involved in the feature
                // selection (because the box handler is used or the
                // feature is selected programatically) we fake the
                // feature handler to allow unselecting on click
                if(!this.handlers.feature.lastFeature) {
                    this.handlers.feature.lastFeature = layer.selectedFeatures[0];
                }
                
                //layer.events.triggerEvent("featureselected", {feature: feature});
                //this.events.triggerEvent("cwrs_box_dropped", {feature: feature});
               // this.onSelect.call(this.scope, feature);
            }
       // }
    },

    /**
     * Method: unselect
     * Remove feature from the layer's selectedFeature array, render the feature as
     * normal, and call the onUnselect function.
     *
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>}
     */
    unselect: function(feature) {
        var layer = feature.layer;
        // Store feature style for restoration later
        this.unhighlight(feature, true);//
        OpenLayers.Util.removeItem(layer.selectedFeatures, feature);
        layer.events.triggerEvent("featureunselected", {feature: feature});
        this.onUnselect.call(this.scope, feature);
    },
    unselectAll: function(options) {
        // we'll want an option to supress notification here
        var layers = this.layers || [this.layer];
        var layer, feature;
        for(var l=0; l<layers.length; ++l) {
            layer = layers[l];
            for(var i=layer.selectedFeatures.length-1; i>=0; --i) {
                feature = layer.selectedFeatures[i];
                //if(!options || options.except != feature)
                {
                    this.unselect(feature);
                }
            }
        }
    },
    /**
     * Method: selectBox
     * Callback from the handlers.box set up when <box> selection is true
     *     on.
     *
     * Parameters:
     * position - {<OpenLayers.Bounds> || <OpenLayers.Pixel> }  
     */
    selectBox: function(position) {
    	//this.mouseup();
        if (position instanceof OpenLayers.Bounds) {
            var minXY = this.map.getLonLatFromPixel(
                new OpenLayers.Pixel(position.left, position.bottom)
            );
            var maxXY = this.map.getLonLatFromPixel(
                new OpenLayers.Pixel(position.right, position.top)
            );
            var bounds = new OpenLayers.Bounds(
                minXY.lon, minXY.lat, maxXY.lon, maxXY.lat
            );
            
            // if multiple is false, first deselect currently selected features
            if (!this.multipleSelect()) {
                this.unselectAll();
            }
            cwrs_debug('isMultiSelect = ' + this.multipleSelect());
           //alert('box done')
            // because we're using a box, we consider we want multiple selection
            var prevMultiple = this.multiple;
            this.multiple = true;
            var layers = this.layers || [this.layer];
            var layer;
           
           // var t1 = (new Date()).getTime();
            if (layers.length > 1){
            	alert('Oops, layers.length: ' + layers.length);
            }
           var t1 = (new Date()).getTime();
            for(var l=0; l<layers.length; ++l) {
                layer = layers[l];
                for(var i=0, len = layer.features.length; i<len; ++i) {
                    var feature = layer.features[i];
                    // check if the feature is displayed
                    if (!feature.getVisibility()) {
                    	alert('selectBox: function(position): feature.getVisibility() =false');
                        continue;
                    }

                    if (this.geometryTypes == null || OpenLayers.Util.indexOf(
                        this.geometryTypes, feature.geometry.CLASS_NAME) > -1) {
                    
                        if (OpenLayers.Util.indexOf(layer.selectedFeatures, feature) == -1) {
                        		var featureBounds = feature.geometry.getBounds();
                        		var onScreen = bounds.intersectsBounds(featureBounds);
                        		if (onScreen)
                        		{
                        		 	if (bounds.toGeometry().intersects(feature.geometry)) {
                        		 		// var t1 = (new Date()).getTime();
                        	 			this.select(feature);
                        		 		//var t2 = (new Date()).getTime();
                        	            // var t = t2-t1;
                        	            // cwrs_debug('time: ' + t + '(ms)')
                                 	    //this.select(feature);
                        			    //lstFeatIDSelectedByCurrentBox.push(feature.fid);
                        		    } else {
                        			 cwrs_debug('SKIP...coz feat '+feature.fid + ' was selected');
                        		    }
                        	   }
                        }
                    }
                  
			 		
                }
               // var t2 = (new Date()).getTime();
                //alert(t2-t1);
               // var t = t2-t1;
                //cwrs_debug(t,false);
              //  alert(t);
            }
            var t2 = (new Date()).getTime();
            
	        var t = t2-t1;
	        cwrs_debug('time: ' + t + '(ms)')
            
            
           // this.doneSelectByBox(position, g_Utils.createStringWithSeparator(lstFeatIDSelectedByCurrentBox,COM_TYPE_SEP));
            this.multiple = prevMultiple;
            cwrs_debug('Total Feat Selected: ' + layer.selectedFeatures.length);
            
        }
       
    },
    /**
     * APIMethod: destroy
     * Take care of things that are not handled in superclass
     */
    destroy: function() {
        this.layer = null;
        OpenLayers.Control.prototype.destroy.apply(this, []);
    },

    /**
     * APIMethod: activate
     * Activate the control and the feature handler.
     * 
     * Returns:
     * {Boolean} Successfully activated the control and feature handler.
     */
    activate: function() {
    	this.handlers.feature.activate();
    	if(this.box && this.handlers.box) {
              this.handlers.box.activate();
        }
        return (OpenLayers.Control.prototype.activate.apply(this, arguments));
    },

    /**
     * APIMethod: deactivate
     * Deactivate the control and all handlers.
     * 
     * Returns:
     * {Boolean} Successfully deactivated the control.
     */
    deactivate: function() {
    	this.isShownTooltipMaxRuongMoving = false;
        // the return from the handlers is unimportant in this case
        this.handlers.drag.deactivate();
        this.handlers.feature.deactivate();
        //alert('this.feature = null by deactivate() dragfeture')
        this.feature = null;
        this.dragging = false;
        this.lastPixel = null;
        this.unselectAll();
        if(this.handlers.box) {
            this.handlers.box.deactivate();
        }
        OpenLayers.Element.removeClass(
            this.map.viewPortDiv, this.displayClass + "Over"
        );
        return OpenLayers.Control.prototype.deactivate.apply(this, arguments);
    },
    /**
     * Method: setMap
     * Set the map property for the control and all handlers.
     *
     * Parameters: 
     * map - {<OpenLayers.Map>} The control's map.
     */
    setMap: function(map) {
        this.handlers.drag.setMap(map);
        this.handlers.feature.setMap(map);
        if (this.box) {
            this.handlers.box.setMap(map);
        }
        OpenLayers.Control.prototype.setMap.apply(this, arguments);
    },

    CLASS_NAME: "OpenLayers.Control.DragFeatureEx"
});
