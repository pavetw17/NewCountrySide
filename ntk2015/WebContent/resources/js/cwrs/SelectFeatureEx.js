/* Copyright (c) 2006-2011 by OpenLayers Contributors (see authors.txt for 
 * full list of contributors). Published under the Clear BSD license.  
 * See http://svn.openlayers.org/trunk/openlayers/license.txt for the
 * full text of the license. */


/**
 * @requires OpenLayers/Control.js
 * @requires OpenLayers/Feature/Vector.js
 * @requires OpenLayers/Handler/Feature.js
 * @requires OpenLayers/Layer/Vector/RootContainer.js
 */

/**
 * Class: OpenLayers.Control.SelectFeature
 * The SelectFeature control selects vector features from a given layer on 
 * click or hover. 
 *
 * Inherits from:
 *  - <OpenLayers.Control>
 */
OpenLayers.Control.SelectFeatureEx = OpenLayers.Class(OpenLayers.Control, {

    /**
     * Constant: EVENT_TYPES
     *
     * Supported event types:
     *  - *beforefeaturehighlighted* Triggered before a feature is highlighted
     *  - *featurehighlighted* Triggered when a feature is highlighted
     *  - *featureunhighlighted* Triggered when a feature is unhighlighted
     */
    EVENT_TYPES: ["beforefeaturehighlighted", "featurehighlighted", "featureunhighlighted","cwrs_box_dropped"],
    
    /**
     * Property: multipleKey
     * {String} An event modifier ('altKey' or 'shiftKey') that temporarily sets
     *     the <multiple> property to true.  Default is null.
     */
    multipleKey: null,
    
    /**
     * Property: toggleKey
     * {String} An event modifier ('altKey' or 'shiftKey') that temporarily sets
     *     the <toggle> property to true.  Default is null.
     */
    toggleKey: null,
    
    /**
     * APIProperty: multiple
     * {Boolean} Allow selection of multiple geometries.  Default is false.
     */
    multiple: false, 

    /**
     * APIProperty: clickout
     * {Boolean} Unselect features when clicking outside any feature.
     *     Default is true.
     */
    clickout: true,

    /**
     * APIProperty: toggle
     * {Boolean} Unselect a selected feature on click.  Default is false.  Only
     *     has meaning if hover is false.
     */
    toggle: false,

    /**
     * APIProperty: hover
     * {Boolean} Select on mouse over and deselect on mouse out.  If true, this
     * ignores clicks and only listens to mouse moves.
     */
    hover: false,

    /**
     * APIProperty: highlightOnly
     * {Boolean} If true do not actually select features (that is place them in 
     * the layer's selected features array), just highlight them. This property
     * has no effect if hover is false. Defaults to false.
     */
    highlightOnly: false,
    
    /**
     * APIProperty: box
     * {Boolean} Allow feature selection by drawing a box.
     */
    box: false,
    
    /**
     * Property: onBeforeSelect 
     * {Functions_DB} Optional function to be called before a feature is selected.
     *     The function should expect to be called with a feature.
     */
    onBeforeSelect: function() {},
    
    /**
     * APIProperty: onSelect 
     * {Functions_DB} Optional function to be called when a feature is selected.
     *     The function should expect to be called with a feature.
     */
    onSelect: function() {},

    /**
     * APIProperty: onUnselect
     * {Functions_DB} Optional function to be called when a feature is unselected.
     *     The function should expect to be called with a feature.
     */
    onUnselect: function() {},
    
    /**
     * Property: scope
     * {Object} The scope to use with the onBeforeSelect, onSelect, onUnselect
     *     callbacks. If null the scope will be this control.
     */
    scope: null,

    /**
     * APIProperty: geometryTypes
     * {Array(String)} To restrict selecting to a limited set of geometry types,
     *     send a list of strings corresponding to the geometry class names.
     */
    geometryTypes: null,

    /**
     * Property: layer
     * {<OpenLayers.Layer.Vector>} The vector layer with a common renderer
     * root for all layers this control is configured with (if an array of
     * layers was passed to the constructor), or the vector layer the control
     * was configured with (if a single layer was passed to the constructor).
     */
    layer: null,
    
    /**
     * Property: layers
     * {Array(<OpenLayers.Layer.Vector>)} The layers this control will work on,
     * or null if the control was configured with a single layer
     */
    layers: null,
    
    /**
     * APIProperty: callbacks
     * {Object} The functions that are sent to the handlers.feature for callback
     */
    callbacks: null,
    
    /**
     * APIProperty: highlightStyle 
     * {Object} Hash of styles
     */
    highlightStyle: null,
    
    selectedStyle: null,
     
    
    /**
     * Property: renderIntent
     * {String} key used to retrieve the select style from the layer's
     * style map.
     */
    renderIntent: "select",

    /**
     * Property: handlers
     * {Object} Object with references to multiple <OpenLayers.Handler>
     *     instances.
     */
    handlers: null,

    /**
     * Constructor: OpenLayers.Control.SelectFeature
     * Create a new control for selecting features.
     *
     * Parameters:
     * layers - {<OpenLayers.Layer.Vector>}, or an array of vector layers. The
     *     layer(s) this control will select features from.
     * options - {Object} 
     */
    initialize: function(layers, options) {
        // concatenate events specific to this control with those from the base
        this.EVENT_TYPES =
            OpenLayers.Control.SelectFeature.prototype.EVENT_TYPES.concat(
            OpenLayers.Control.prototype.EVENT_TYPES
        );
        OpenLayers.Control.prototype.initialize.apply(this, [options]);
        
        if(this.scope === null) {
            this.scope = this;
        }
        this.initLayer(layers);
        var callbacks = {
            click: this.clickFeature,
            clickout: this.clickoutFeature
        };
        if (this.hover) {
            callbacks.over = this.overFeature;
            callbacks.out = this.outFeature;
        }
             
        this.callbacks = OpenLayers.Util.extend(callbacks, this.callbacks);
        this.handlers = {
            feature: new OpenLayers.Handler.Feature(
                this, this.layer, this.callbacks,
                {geometryTypes: this.geometryTypes}
            )
        };

        if (this.box) {
            this.handlers.box = new OpenLayers.Handler.BoxEx(
                this, 
                {
                	start:this.mousedown,
                	done: this.selectBox
                },
                
                {boxDivClassName: "olHandlerBoxSelectFeature"}
            ); 
        }
    },
    mousedown:function(e){
    	
    },
    mouseup:function(){
    	
    },
    onFeature:function(){
    	
    },
    outOfFeature:function(){
    	
    },
    /**
     * Method: initLayer
     * Assign the layer property. If layers is an array, we need to use
     *     a RootContainer.
     *
     * Parameters:
     * layers - {<OpenLayers.Layer.Vector>}, or an array of vector layers.
     */
    initLayer: function(layers) {
        if(OpenLayers.Util.isArray(layers)) {
            this.layers = layers;
            this.layer = new OpenLayers.Layer.Vector.RootContainer(
                this.id + "_container", {
                    layers: layers
                }
            );
        } else {
            this.layer = layers;
        }
    },
    
    /**
     * Method: destroy
     */
    destroy: function() {
        if(this.active && this.layers) {
            this.map.removeLayer(this.layer);
        }
        OpenLayers.Control.prototype.destroy.apply(this, arguments);
        if(this.layers) {
            this.layer.destroy();
        }
    },

    /**
     * Method: activate
     * Activates the control.
     * 
     * Returns:
     * {Boolean} The control was effectively activated.
     */
    activate: function () {
        if (!this.active) {
            if(this.layers) {
                this.map.addLayer(this.layer);
            }
            this.handlers.feature.activate();
            if(this.box && this.handlers.box) {
                this.handlers.box.activate();
            }
        }
        return OpenLayers.Control.prototype.activate.apply(
            this, arguments
        );
    },

    /**
     * Method: deactivate
     * Deactivates the control.
     * 
     * Returns:
     * {Boolean} The control was effectively deactivated.
     */
    deactivate: function () {
        if (this.active) {
            this.handlers.feature.deactivate();
            if(this.handlers.box) {
                this.handlers.box.deactivate();
            }
            if(this.layers) {
                this.map.removeLayer(this.layer);
            }
        }
        return OpenLayers.Control.prototype.deactivate.apply(
            this, arguments
        );
    },

    /**
     * Method: unselectAll
     * Unselect all selected features.  To unselect all except for a single
     *     feature, set the options.except property to the feature.
     *
     * Parameters:
     * options - {Object} Optional configuration object.
     */
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
     * Method: clickFeature
     * Called on click in a feature
     * Only responds if this.hover is false.
     *
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>} 
     */
    clickFeature: function(feature) {
    	//alert('clickFeature');
    	this.onFeature(feature);
    	cwrs_debug('Click on feature: ' + feature.fid);
    	var layer = feature.layer;
    	var moreFeatutes = this.drawMoreWhenHover(feature);
        //if(!this.hover)
        {
            var selected = (OpenLayers.Util.indexOf(
            feature.layer.selectedFeatures, feature) > -1);
            if(selected) {
            	 //cwrs_debug('feature selected: ' + feature.fid);
                if(this.toggleSelect()) {
                	//cwrs_debug('unselect feature: ' + feature.fid);
                    //this.unselect(feature);
                    if (moreFeatutes.length > 0){
                		for (var i = 0; i < moreFeatutes.length; i++){
                			 //cwrs_debug('highlight featute: '+ moreFeatutes[i].fid);
                			 this.unselect(layer.getFeatureByFid(moreFeatutes[i]));
                			
                		}
                	} else {
                		this.unselect(feature);
                	}
                } else if(!this.multipleSelect()) {
                	//cwrs_debug('unselectAll feature: ' + feature.fid);
                    this.unselectAll({except: feature});
                }  
            } else {
                if(!this.multipleSelect()) {
                	//cwrs_debug('unselectAll feature2: ' + feature.fid);
                    this.unselectAll({except: feature});
                }
               //
                //cwrs_debug('select feature: ' + feature.fid);
                
            	if (moreFeatutes.length > 0){
            		for (var i = 0; i < moreFeatutes.length; i++){
            			 //cwrs_debug('highlight featute: '+ moreFeatutes[i].fid);
            			 this.select(layer.getFeatureByFid(moreFeatutes[i]));
            			
            		}
            	} else {
            		this.select(feature);
            	}
                
            	//this.select(feature);
            }
        }
         cwrs_debug('Total Feat Selected: ' + layer.selectedFeatures.length);
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
     * Method: toggleSelect
     * Event should toggle the selected state of a feature based on <toggle>
     *     property and <toggleKey> event modifier.
     *
     * Returns:
     * {Boolean} Toggle the selected state of a feature.
     */
    toggleSelect: function() {
        return this.toggle || (this.handlers.feature.evt &&
                               this.handlers.feature.evt[this.toggleKey]);
    },

    /**
     * Method: clickoutFeature
     * Called on click outside a previously clicked (selected) feature.
     * Only responds if this.hover is false.
     *
     * Parameters:
     * feature - {<OpenLayers.Vector.Feature>} 
     */
    clickoutFeature: function(feature) {
    	this.outOfFeature();
        if(!this.hover && this.clickout) {
            this.unselectAll();
            this.outCurrentFeature(feature);
        }
    },

    overCurrentFeature:function(feature) {
    	//return feature;
    },
    outCurrentFeature:function(feature) {
    	//return feature;
    },
    /**
     * Method: overFeature
     * Called on over a feature.
     * Only responds if this.hover is true.
     *
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>} 
     */
    overFeature: function(feature) {
    
        var layer = feature.layer;
        this.overCurrentFeature(feature);
        //alert('overFeature');
        this.onFeature(feature);
        cwrs_debug('select at ruộng id: '+ feature.fid + '(cánh đồng id: '+ feature.attributes['pid']+')');
     
        if(this.hover && !g_startBox) {//disable hover highlight khi kéo thả box 
        	
            if(this.highlightOnly) {
           	  /*  var feats = feature.layer.selectedFeatures;
           	    cwrs_debug('feats='+feats.length,false);
           	    for (var i = 0 ;i < feats.length; i++)
                this.highlight(feats[i]);*/
            	var moreFeatutes = this.drawMoreWhenHover(feature);
            	if (moreFeatutes.length > 0){
            		for (var i = 0; i < moreFeatutes.length; i++){
            			 this.highlight(layer.getFeatureByFid(moreFeatutes[i]), this.highlightStyle);
            			
            		}
            	} else {
            		this.highlight(feature, this.highlightStyle);
            	}
            		
           	  
            } else if(OpenLayers.Util.indexOf(
                layer.selectedFeatures, feature) == -1) 
            		{
                //this.select(feature);
            }
        }
    },

    /**
     * Method: outFeature
     * Called on out of a selected feature.
     * Only responds if this.hover is true.
     *
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>} 
     */
    outFeature: function(feature) {
    	var layer = feature.layer;
    	
    	   this.outCurrentFeature(feature);
    	   this.outOfFeature();
        if(this.hover) {
            if(this.highlightOnly) {
                // we do nothing if we're not the last highlighter of the
                // feature
                if(feature._lastHighlighter == this.id) {
                    // if another select control had highlighted the feature before
                    // we did it ourself then we use that control to highlight the
                    // feature as it was before we highlighted it, else we just
                    // unhighlight it
  /*ATMLE ERROR*/                 /* if(feature._prevHighlighter &&
                       feature._prevHighlighter != this.id) {
                        delete feature._lastHighlighter;
                        var control = this.map.getControl(
                            feature._prevHighlighter);
                        if(control) {
                            control.highlight(feature);
                        }
                    } else 
                    	*/
                    {
                    	/*var moreFeatutes = this.drawMoreWhenHover(feature);
                    	if (moreFeatutes.length > 0){
                    		for (var i = 0; i < moreFeatutes.length; i++){
                    			this.unhighlight(layer.getFeatureByFid(moreFeatutes[i]), false);
                    		}
                    	} else
                    		this.unhighlight(feature,false);
                    	*/
                        //this.unhighlight(feature , false);
                       	var moreFeatutes = this.drawMoreWhenHover(feature);
                    	if (moreFeatutes.length > 0){
                    		for (var i = 0; i < moreFeatutes.length; i++){
                    			 //cwrs_debug('unhighlight featute: '+ moreFeatutes[i].fid);
                    			 this.unhighlight(layer.getFeatureByFid(moreFeatutes[i]), false /*isUnselect*/);
                    			
                    		}
                    	} else {
                    		this.unhighlight(feature, false /*isUnselect*/);
                    	}
                    }
                }
            } else {
                //this.unselect(feature);
            }
        }
    },

    /**
     * Method: highlight
     * Redraw feature with the select style.
     *
     * Parameters:
     * feature - {<OpenLayers.Feature.Vector>} 
     */
    highlight: function(feature, style) {
    	if (feature == null) return;
        var layer = feature.layer;
        var cont = this.events.triggerEvent("beforefeaturehighlighted", {
            feature : feature
        });
        if(cont !== false) {
            feature._prevHighlighter = feature._lastHighlighter;
            feature._lastHighlighter = this.id;
          	/*var moreFeatutes = this.drawMoreWhenHover(feature);
        	if (moreFeatutes.length > 0){
        		for (var i = 0; i < moreFeatutes.length; i++){
        			 cwrs_debug('highlight featute: '+ moreFeatutes[i].fid);
        			 layer.drawFeature(layer.getFeatureByFid(moreFeatutes[i]), style);
        			
        		}
        	} else {
        		 cwrs_debug('highlight featute: '+ feature.fid);
        		layer.drawFeature(feature, style);
        	}*/
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
    	if (feature == null) return;
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
        //layer.drawFeature(feature, _styleMoreFeature);
      	/*var moreFeatutes = this.drawMoreWhenHover(feature);
    	if (moreFeatutes.length > 0){
    		for (var i = 0; i < moreFeatutes.length; i++){
    			 cwrs_debug('unhighlight featute: '+ moreFeatutes[i].fid);
    			 layer.drawFeature(layer.getFeatureByFid(moreFeatutes[i]), _styleMoreFeature);
    		}
    	} else{
    		 cwrs_debug('unhighlight featute: '+ feature.fid);
    		 layer.drawFeature(feature, _styleMoreFeature);
    	}*/
    	layer.drawFeature(feature, _styleMoreFeature);
   
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
    	if(feature == null){
    		cwrs_debug('ERROR: select feature null');
    		return;
    	}
        var cont = this.onBeforeSelect.call(this.scope, feature);
        var layer = feature.layer;
        if(cont !== false) {
            cont = layer.events.triggerEvent("beforefeatureselected", {
                feature: feature
            });
            if(cont !== false) {
              /*	var moreFeatutes = this.drawMoreWhenHover(feature);
            	if (moreFeatutes.length > 0){
            		for (var i = 0; i < moreFeatutes.length; i++){
            			layer.selectedFeatures.push(layer.getFeatureByFid(moreFeatutes[i]));
            		}
            	} else
            		  layer.selectedFeatures.push(feature);*/
            	  // cwrs_debug('push & highlight feat:'+feature.fid);
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
                this.onSelect.call(this.scope, feature);
            }
        }
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
    
    /**
     * Method: selectBox
     * Callback from the handlers.box set up when <box> selection is true
     *     on.
     *
     * Parameters:
     * position - {<OpenLayers.Bounds> || <OpenLayers.Pixel> }  
     */
    selectBox: function(position) {
    	this.mouseup();
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
            
           //alert('box done')
            // because we're using a box, we consider we want multiple selection
            var prevMultiple = this.multiple;
            this.multiple = true;
            var layers = this.layers || [this.layer];
            var layer;
            var lstFeatIDSelectedByCurrentBox = [];
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
                        		 		var moreFeatutes = this.drawMoreWhenHover(feature);
                        		 		if (moreFeatutes.length > 0){
                        		 			for (var i = 0; i < moreFeatutes.length; i++){
                                 			
                        		 				var feat = layer.getFeatureByFid(moreFeatutes[i]);
                        		 				if(feat == null){
                        		 		    		cwrs_debug('ERROR: select null of moreFeatutes[i]:'+moreFeatutes[i]);
                        		 		    		continue;
                        		 		    	}
                        		 				this.select(feat);
                        		 				//cwrs_debug('adding feat: '+ feat.fid);
                                 			
                        		 			}
                        		 		} else {
                        		 			this.select(feature);
                        		 		}
                        		 		//var t2 = (new Date()).getTime();
                        	            
                        	           // var t = t2-t1;
                        	           // cwrs_debug('time: ' + t + '(ms)')
                                 	//this.select(feature);
                        			lstFeatIDSelectedByCurrentBox.push(feature.fid);
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
            
            
            this.doneSelectByBox(position, g_Utils.createStringWithSeparator(lstFeatIDSelectedByCurrentBox,COM_TYPE_SEP));
            this.multiple = prevMultiple;
            cwrs_debug('Total Feat Selected: ' + layer.selectedFeatures.length);
            
        }
       
    },
    doneSelectByBox: function(position, strListID){
    	
    },
    /** 
     * Method: setMap
     * Set the map property for the control. 
     * 
     * Parameters:
     * map - {<OpenLayers.Map>} 
     */
    setMap: function(map) {
        this.handlers.feature.setMap(map);
        if (this.box) {
            this.handlers.box.setMap(map);
        }
        OpenLayers.Control.prototype.setMap.apply(this, arguments);
    },
    
    /**
     * APIMethod: setLayer
     * Attach a new layer to the control, overriding any existing layers.
     *
     * Parameters:
     * layers - Array of {<OpenLayers.Layer.Vector>} or a single
     *     {<OpenLayers.Layer.Vector>}
     */
    setLayer: function(layers) {
        var isActive = this.active;
        this.unselectAll();
        this.deactivate();
        if(this.layers) {
            this.layer.destroy();
            this.layers = null;
        }
        this.initLayer(layers);
        this.handlers.feature.layer = this.layer;
        if (isActive) {
            this.activate();
        }
    },
    
    CLASS_NAME: "OpenLayers.Control.SelectFeatureEx"
});
