

	  var layer_tinh;
	  var layer_huyen;
	  var layer_xa;
	  var layer_dancu;
	  var layer_thuyvan_polyline;
	  var layer_thuyvan_polygon;
	  var layer_ruong;
	  
	  var layer_ruong_hientrang;
	  var layer_circle;
	  
	  var image_format = 'image/png';
	  var size;

		//.olControlPanel div


OpenLayers.Control.Click = OpenLayers.Class(OpenLayers.Control, {                
    defaultHandlerOptions: {
        'single': false,
        'double': false,
        'pixelTolerance': 0,
        'stopSingle': true,
        'stopDouble': true
    },
    handleRightClicks:true,
    initialize: function(options) {
        this.handlerOptions = OpenLayers.Util.extend(
            {}, this.defaultHandlerOptions
        );
        OpenLayers.Control.prototype.initialize.apply(
            this, arguments
        ); 
        this.handler = new OpenLayers.Handler.Click(
            this, {
            	'rightclick': this.onRightClick,
                'click': this.onClick,
                'dblclick': this.onDblclick 
            }, this.handlerOptions
        );
    }, 

    onRightClick: function(evt) {
 
    },
    onClick: function(evt) {
        /*var output = document.getElementById(this.key + "Output");
        var msg = "click " + evt.xy;
        output.value = output.value + msg + "\r\n";*/
    	//alert('onClick');
    },


    onDblclick: function(evt) {  
        /*var output = document.getElementById(this.key + "Output");
        var msg = "dblclick " + evt.xy;
        output.value = output.value + msg + "\n";*/
    }   

});


function initStyleVectorLayer(){
	//alert( 	request.getParameter("isAtmeldepzai"));
	    /*
 * Layer style
 */
// we want opaque external graphics and non-opaque internal graphics
	g_style_vector_layer = OpenLayers.Util.extend({}, OpenLayers.Feature.Vector.style['default']);
	g_style_vector_layer.strokeColor = "red";
	g_style_vector_layer.fillOpacity = 1;
	g_style_vector_layer.graphicOpacity = 1;
	
   /*Ruộng*/
   g_style_fill_ruong = OpenLayers.Util.extend({}, g_style_vector_layer);
   g_style_fill_ruong.strokeColor = "red";
   g_style_fill_ruong.strokeWidth = 3;
   g_style_fill_ruong.fillColor = "red";//không fill màu
   g_style_fill_ruong.fillOpacity = 1;
   //style_blue.graphicName = "star";
   //style_blue.pointRadius = 10;
   //style_blue.rotation = 45;
   
   /*Cánh đồng*/
   g_style_fill_canhdong = OpenLayers.Util.extend({}, g_style_vector_layer);
   g_style_fill_canhdong.strokeColor = "black";//"#a0a0a0";
   g_style_fill_canhdong.strokeWidth = 5;
   g_style_fill_canhdong.fillColor = "blue";
   
   /*Tỉnh (tìm kiếm)*/
   g_style_fill_tinh = OpenLayers.Util.extend({}, g_style_vector_layer);
   g_style_fill_tinh.strokeColor = "#5500aa";
   g_style_fill_tinh.strokeWidth = 3;
   g_style_fill_tinh.fillColor = "none";
   /*Huyện (tìm kiếm)*/
   g_style_fill_huyen = OpenLayers.Util.extend({}, g_style_vector_layer);
   g_style_fill_huyen.strokeColor = "#5500aa";
   g_style_fill_huyen.strokeWidth = 5;
   g_style_fill_huyen.fillColor = "none";
   //g_style_fill_huyen.strokeDashstyle = "dash";

   /*Xã (tìm kiếm)*/
   g_style_fill_xa = OpenLayers.Util.extend({}, g_style_vector_layer);
   g_style_fill_xa.strokeColor = "#5500aa";
   g_style_fill_xa.strokeWidth = 3;
   g_style_fill_xa.fillColor = "none";
   
   
   /*highlight*/
   g_style_highlight = OpenLayers.Util.extend({}, g_style_vector_layer);
   g_style_highlight.strokeColor = "#00ff00";
   g_style_highlight.strokeWidth = 2;
   g_style_highlight.fillColor = "#00ff00";
   g_style_highlight.fillOpacity = 0.4;
   //g_style_highlight.strokeDashstyle = "dot";//[dot | dash | dashdot | longdash | longdashdot | solid]
   
   /*feature selected*/
   g_style_feature_selected = OpenLayers.Util.extend({}, g_style_vector_layer);
   g_style_feature_selected.strokeColor = "red";
   g_style_feature_selected.strokeWidth = 1;
   g_style_feature_selected.fillColor = "blue";
   g_style_feature_selected.fillOpacity = 0.5;
   
   /*geometry_hide*/
   g_style_geometry_hide = OpenLayers.Util.extend({}, g_style_vector_layer);
   g_style_geometry_hide.strokeColor = "none";
   g_style_geometry_hide.strokeWidth = 1;
   g_style_geometry_hide.fillColor = "white";
   g_style_geometry_hide.fillOpacity =0.051;
   
   g_style_blink_editing_canhdong = OpenLayers.Util.extend({}, g_style_vector_layer);
   g_style_blink_editing_canhdong.strokeColor = "red";
   g_style_blink_editing_canhdong.strokeWidth = 1;
   g_style_blink_editing_canhdong.fillColor = "blue";
   g_style_blink_editing_canhdong.fillOpacity = 0.5;
   
   g_styleError = OpenLayers.Util.extend({}, g_style_vector_layer);
   g_styleError.strokeColor = "red";
   g_styleError.strokeWidth = 1;
   g_styleError.fillColor = "#800000";
   g_styleError.fillOpacity = 0.9;
   g_array_colors.push("#00ff00");//0-255-0
   g_array_colors.push("#ffff00");//255-255-0
   g_array_colors.push("#00ffff");//0-255-255
   g_array_colors.push("#ff00ff");//255-0-255
   g_array_colors.push("#0000ff");//0-0-255
   g_array_colors.push("#800000");//128-0-0
   g_array_colors.push("#0080ff");//0-128-255
   g_array_colors.push("#ff8040");//255-128-40
   g_array_colors.push("#400080");//64-00-128
   g_array_colors.push("#A04040");//160-64-64
   
   g_array_colors.push("#C04000");//192-64-0
   g_array_colors.push("#C00020");//192-0-32
   g_array_colors.push("#20C040");//32-192-64
   g_array_colors.push("#2040C0");//32-64-192
   g_array_colors.push("#C040C0");//192-64-192
}
function setupEventHandler(){
    controls = {
            "stopdouble": new OpenLayers.Control.Click({
               handlerOptions: {
                   "single": true,
                   "double": true,
                   "stopDouble": true
               }
           })
       }; 
	var control;
	for(var key in controls) {
    	control = controls[key];
    	// only to route output here
    	control.key = key;
    	map.addControl(control);
    	control.activate();
		 }
} 

function setupHighlightControl()
{
	    g_highlightCtrl = {
	        selectByClickOrBox:new OpenLayers.Control.SelectFeatureEx(g_layer_vector_ruong, {
        			hover: true,
					highlightOnly: true,
					highlightStyle:g_style_highlight,
					selectedStyle: g_style_feature_selected,
					multipleKey:'shiftKey',
					toggleKey: "shiftKey",
					multiple:false,
					box:true,
					renderIntent: "select",//"temporary",
					eventListeners: {
						//beforefeaturehighlighted: report//,
						//featurehighlighted: report,
						//cwrs_box_dropped:report
						//featureunhighlighted: report
					},
					mousedown:function(){
						g_startBox = true;
						cwrs_debug('mouse down...');
					},
					mouseup:function(){
						g_startBox = false;
					},
					doneSelectByBox: function(bounds, fidExcepted){
				    	//alert('doneSelectByBox:' +fidExcepted);
						//alert(bounds);
				    	OnSelectMultiFeautureByBox(bounds, fidExcepted);
				    },
				    drawMoreWhenHover:function (feature){
				    	if (g_fn_selected == FN_DIEUTRA_CANHDONG){
				    		return getListRuongIDHasSameCanhdongIDWith(feature);
				    	
				    	}
				    	return [];
				    },
				    overCurrentFeature:function(feature){
				    	g_current_feature = feature;  
				    	if ((g_fn_selected == FN_DIEUTRA_RUONG)){
				    		if (g_key_CTR_pressed == true){
				    			try{ 
				    				cwrs_debug('show popup ttgc ruong...');
				    				ShowPopupThongtinGieocay();
				    			} catch(err){
				    				cwrs_debug(err);
				    			}
				    		} else if (g_is_checking_are == true){
				    			showHint((Math.abs(feature.geometry.getArea())/10000).toFixed(2)+' ha',{"id":"9999","timeout": false});
				    		}
				    	}
				    },
				    outCurrentFeature:function(feature){
				    
				    	//g_current_feature = null;
				    },
				    onFeature:function(feature){
				   
				    	g_current_feature = feature;
				    },
				    outOfFeature:function(){
			    	   // g_current_feature = null;
				    }
			
				}
			)//END selectByClickOrBox:new OpenLayers.Control.SelectFeature...
		
	    };

	    for(var key in g_highlightCtrl) {
           map.addControl(g_highlightCtrl[key]);
        }
	    g_highlightCtrl.selectByClickOrBox.select.box = true;
	    
	    if(g_highlightCtrl.selectByClickOrBox.active) {
	    	g_highlightCtrl.selectByClickOrBox.deactivate();
	    	g_highlightCtrl.selectByClickOrBox.activate();
        }
	    
		
	
}

function createTimer(){
	//if (!g_control_enable_timer)
		return;
    
	if (g_fn_editing_canhdong == true){
		var feats = g_layer_vector_ruong.selectedFeatures;
		for (var i = 0; i < feats.length; i++){
			var feat = feats[i];
			
			 var style = g_style_blink_editing_canhdong;
			var canhdong = g_cdm.getCanhdongByID(feat.attributes['pid']);
			 		style.strokeWidth = 4;
			 		style.fillColor = canhdong.getFillColor();
			 		
					var opacityStep = 0.1;
					style.strokeOpacity += g_i;
					if (style.strokeOpacity >= 1.0){
						g_i = -opacityStep;
						style.strokeOpacity += (2*g_i);
					
					} else if (style.strokeOpacity <= 0.3){
						g_i = opacityStep;
						style.strokeOpacity += (2*g_i);
					}
				
					style.fillOpacity = 1;
			 g_layer_vector_ruong.drawFeature(feat, style);
			
		}
	}
	//setTimeout("createTimer()",/*TIMER_DELAY +*/ 100);
	return;

	var featSearchs = g_layer_search.features;
	if (featSearchs.length > 0){
		featSearchs[0].style.strokeColor = "#0000ff";
		featSearchs[0].style.strokeWidth = 8;
		featSearchs[0].style.fillColor = "none";
		//alert('featSearchs.size = '+featSearchs.length);
		//alert('featSearchs[0].style.fillOpacity: '+featSearchs[0].style.fillOpacity);
		var opacityStep = 0.1;
		featSearchs[0].style.strokeOpacity += g_i;
		if (featSearchs[0].style.strokeOpacity >= 1.0){
			g_i = -opacityStep;
			featSearchs[0].style.strokeOpacity += (2*g_i);
		
		} else if (featSearchs[0].style.strokeOpacity <= 0.0){
			g_i = opacityStep;
			featSearchs[0].style.strokeOpacity += (2*g_i);
		}
		g_layer_search.drawFeature(featSearchs[0]);
	}	
	setTimeout("createTimer()",/*TIMER_DELAY +*/ 200);
	
}

function init_map(){
	
 	var bounds = new OpenLayers.Bounds(206467.08, 946402.773, 985787.216, 2587082.211);
    var urlArray = mapserver_addr_map_file;
  	map = new OpenLayers.Map("map", 
 			{
		   Z_INDEX_BASE: {
		        BaseLayer: 100,
		        Overlay:  325,
		        Feature:  725,
		        Popup:  750,
		        Control:  500
		    },
         controls: [],
         maxExtent: bounds,
	 	 maxResolution: 'auto',
	     allOverlays: false,
         numZoomLevels: 12,
         zoom:0
         
     });
 	//


    // allow testing of specific renderers via "?renderer=Canvas", etc
    var renderer = OpenLayers.Util.getParameters(window.location.href).renderer;
    renderer = (renderer) ? [renderer] : OpenLayers.Layer.Vector.prototype.renderers;
   // alert('renderers: ' + renderer);
    if (renderer == null) alert('renderer == null');
 
   // g_layer_vector_ruong = new OpenLayers.Layer.VectorEx("Ruong vector", {isBaseLayer: false},{style: g_style_fill_ruong, renderers: renderer, rendererOptions: {zIndexing: true}});
    g_layer_vector_ruong = new OpenLayers.Layer.Vector(
            "Ruong vector",
            {
                // The zIndex is taken from the zIndex attribute of the features
                styleMap: new OpenLayers.StyleMap({
                   // graphicZIndex: "${zIndex}"//,
                   // externalGraphic: "../img/marker-green.png",
                    //pointRadius: 10
                }),
                isBaseLayer: false,
                // enable the indexer by setting zIndexing to true
                rendererOptions: {zIndexing: true}
            }
        );
    
    g_layer_vector_ruong.displayInLayerSwitcher = false;
    
    g_layer_search = new OpenLayers.Layer.VectorEx("Search", {isBaseLayer: false},{style: g_style_vector_layer, renderers: renderer});
    g_layer_search.displayInLayerSwitcher = false;
    
    g_layer_vector_canhdong = new OpenLayers.Layer.VectorEx("canhdong vector", {isBaseLayer: false},{style: g_style_vector_layer, renderers: renderer});
    g_layer_vector_canhdong.displayInLayerSwitcher = false;
    
    setupHighlightControl();

	map.addControl(new OpenLayers.Control.LayerSwitcher( {
		'ascending' : false 
	}));
	map.addControl(new OpenLayers.Control.HostSwitcher( {
		'ascending' : false 
	}));

 	
	//Hiển thị overview map
	var mapOptions = {
		maxExtent : new OpenLayers.Bounds(206467.08, 946934.706,985787.216,2587082.211),
		projection : "EPSG:4756",
		units : "m"
	};
	
	var overview = new OpenLayers.Control.OverviewMap({
		mapOptions : mapOptions
	});
	map.addControl(overview);
  /**TEST*/
	var url_hientrang = '';//mapserver_url_draw_hientrang.replace('<o>', 'hientrang_ccgl_8050304.map');
/*END TEST*/	 
   layer_ruong = new OpenLayers.Layer.WMS("Đất trồng lúa",urlArray,{layers: 'layer_ruong',	srs: 'EPSG:4756',transparent: true,format: image_format,isBaseLayer: false,visibility: false},{projection:'EPSG:4756'});	
   layer_ruong_hientrang = new OpenLayers.Layer.WMS("Lớp Ruộng Render",url_hientrang,{layers: 'layer_ruong_hientrang',	srs: 'EPSG:4756',transparent: true,format: image_format,isBaseLayer: false,'visibility': false},{projection:'EPSG:4756'});	

   layer_tinh  = new OpenLayers.Layer.WMS("Tỉnh",urlArray,{layers: 'layer_tinh',srs: 'EPSG:4756',/*transparent: true,*/format: image_format,isBaseLayer: true,visibility: false},{'opacity' : 1,projection:'EPSG:4756',singleTile: true});
   layer_huyen = new OpenLayers.Layer.WMS("Huyện",urlArray,{layers: 'layer_huyen',transparent: true,format: image_format,isBaseLayer: false,'visibility': false},{'buffer':4,projection:'EPSG:4756',singleTile: true});
   layer_xa    = new OpenLayers.Layer.WMS("Xã",urlArray,{layers: 'layer_xa' ,transparent: true,format: image_format,isBaseLayer: false,'visibility': false},{projection:'EPSG:4756',singleTile: true});
   layer_dancu    = new OpenLayers.Layer.WMS("Dân cư",urlArray,{layers: 'layer_dancu' ,transparent: 'true',format: image_format,isBaseLayer: false,'visibility': false},{projection:'EPSG:4756',singleTile: true});
   layer_thuyvan_polygon    = new OpenLayers.Layer.WMS("Sông, hồ",urlArray,{layers: 'layer_thuyvan_polygon' ,transparent: 'true',format: image_format,isBaseLayer: false,visibility: 'false'},{projection:'EPSG:4756',singleTile: true});
   layer_thuyvan_polyline    = new OpenLayers.Layer.WMS("Kênh, mương",urlArray,{layers: 'layer_thuyvan_polyline' ,transparent: 'true',format: image_format,isBaseLayer: false,visibility: 'false'},{projection:'EPSG:4756',singleTile: true});
   layer_giaothong    = new OpenLayers.Layer.WMS("Giao thông",urlArray,{layers: 'layer_giaothong' ,transparent: 'true',format: image_format,isBaseLayer: false,visibility: 'false'},{projection:'EPSG:4756',singleTile: true});
   layer_phinongnghiep    = new OpenLayers.Layer.WMS("Đất cây trồng khác",urlArray,{layers: 'layer_phinongnghiep' ,transparent: 'true',format: image_format,isBaseLayer: false,visibility: 'false'},{projection:'EPSG:4756',singleTile: true});
   
   //layer_circle = new OpenLayers.Layer.Vector("Circle Layer");
   layer_circle = new OpenLayers.Layer.VectorEx("Circle vector", {isBaseLayer: false},{style: g_style_vector_layer, renderers: renderer});
   
   
     
   //================================= TEST 2=========================================
   //wmsHighlight = new OpenLayers.Layer.WMS("highlight",urlArray,{layers: 'highlight' ,transparent: 'true',format: image_format,isBaseLayer: false},{projection:'EPSG:4756'});
   //wmsHighlight2 = new OpenLayers.Layer.WMS("highlight",urlArray,{layers: 'highlight' ,transparent: 'true',format: image_format,isBaseLayer: false},{projection:'EPSG:4756'});
   
	//map.addLayers([wmsHighlight2]);
	// highlightSelected(wmsHighlight,wmsHighlight2, isMainHighLight, 0);
//===============================END TEST 2================================		  

	 layer_tinh.displayInLayerSwitcher = false;
	 layer_circle.displayInLayerSwitcher = false;
	 layer_ruong_hientrang.displayInLayerSwitcher = false;
     //wmsHighlight.displayInLayerSwitcher = false;
	 
	 
     //map.addLayers([wmsHighlight]);
     
     layer_tinh.setVisibility(true);
     layer_huyen.setVisibility(false);
     layer_xa.setVisibility(false);
     
     layer_dancu.setVisibility(false);
     layer_thuyvan_polygon.setVisibility(false);
     layer_thuyvan_polyline.setVisibility(false);
     layer_giaothong.setVisibility(false);
     layer_phinongnghiep.setVisibility(false);
     
     layer_ruong.setVisibility(false);
     layer_ruong_hientrang.setVisibility(false);
     //wmsHighlight.setVisibility(true);
     
    
     map.addLayer(layer_tinh);	
     
     map.addLayer(layer_huyen);
     map.addLayer(layer_xa);
     map.addLayer(layer_ruong);	
     map.addLayer(layer_phinongnghiep);
     map.addLayer(layer_thuyvan_polygon);
     map.addLayer(layer_dancu);
     map.addLayer(layer_thuyvan_polyline);
     map.addLayer(layer_giaothong);
    
     
     map.addLayer(layer_circle); 
    

    
    

     map.addLayer(layer_ruong_hientrang);
     

    

     
     map.addLayer(g_layer_vector_ruong);
     map.addLayer(g_layer_search);
     map.addLayer(g_layer_vector_canhdong);
     

   
   
     map.events.register('click', map, OnMapClick);
    // btnMoveMap.events.register('click',map, OnMapClick);
    
  /*Tạo các button control*/  
                var nav = new OpenLayers.Control.Navigation({
		               handleRightClicks: true
		           });
				map.addControl(nav);
				/*nav.handlers.click.callbacks.rightclick = function(evt) { 
					cwrs_debug('nav.rightclick....' + evt.xy.x + ',' + evt.xy.y);
					
				}*/
				g_btnPanningHand = new OpenLayers.Control.Button({
					displayClass:'olControlPanningHand',
					eventListeners:{
						'activate': function(){
							g_ctrSelectDeature.box.deactivate();
							g_btnSelectDeature.deactivate();
						}
						//'deactivate': deactivateMyNavigation
					},
					type: OpenLayers.Control.TYPE_TOOL
				}); 	
				
				g_btnSelectDeature = new OpenLayers.Control.Button({
					displayClass:'olControlDragRectangle',
					eventListeners:{
						'activate': function(){
							g_highlightCtrl.selectByClickOrBox.activate();
							//show menu canh dong neu selectfeat dc chon va show menu edit neu edit dc chon
							showContextMenu(CLASS_CONTEXTMENU_DIEUTRA_CANHDONG);
							resetCanhdongEdition();
						},
						'deactivate': function(){
								g_ctrSelectDeature.box.deactivate();
								g_highlightCtrl.selectByClickOrBox.deactivate();	
						}
					},
					type: OpenLayers.Control.TYPE_TOOL
				}); 
				g_btnSelectDeature.id = 'btn_select_feature';
		
				

				g_ctrSelectDeature = new OpenLayers.Control();
				g_ctrSelectDeature.id = "drag_rectangle";
				OpenLayers.Util.extend(g_ctrSelectDeature, {
				         draw: function () {
				             this.box = new OpenLayers.Handler.Box
				            // new OpenLayers.Handler.RegularPolygon
				            ( g_ctrSelectDeature,
									 {"done": this.notice}, 
									 {sides:4, irregular:true, persist:true}
				             //,    {keyMask: OpenLayers.Handler.MOD_ALT}
				 
				             );
				             this.box.activate();
				            
				         },

				         notice: function (bounds) {

				             OnSelectMultiFeautureByBox(bounds,'');
				            
				            
				         }
				     });   

				   map.addControl(g_ctrSelectDeature);
				   g_ctrSelectDeature.deactivate();
				   
				   
				   
				   g_ctrDragFeature = new OpenLayers.Control.DragFeatureEx(g_layer_vector_ruong,g_style_fill_canhdong,
						   {
							multipleKey:'shiftKey',
							toggleKey: "shiftKey",
							multiple:false,
					   		eventListeners:{
					   			'activate': function(){
					   				//alert('g_fn_editing_canhdong = true');
					   				g_fn_editing_canhdong = true;
			 	
								},
								'deactivate': function(){
									//alert('editing_canhdong = deactivate');
									g_fn_editing_canhdong = false;
								}
					   		},
					          selectedStyle: g_style_feature_selected,
					          getCanhdongByFeat:function(feature){
					  			return g_cdm.getCanhdongByID(feature.attributes['pid']);
					  		  }
				  // g_fn_editing_canhdong
					   
						
							
							});
				   
				   map.addControl(g_ctrDragFeature);
					
					g_btnEditCanhdong = new OpenLayers.Control.Button({
						displayClass:'olControlCanhdongEditing',
						eventListeners:{
							'activate': function(){
								g_ctrDragFeature.activate();
								g_ctrSelectDeature.box.deactivate();
								g_highlightCtrl.selectByClickOrBox.deactivate();
								if(g_isEnableEditCanhdongByAdmin)
								onclick_edit_canhdong();
								else
									msginfo('Chức năng này hiện tại đang được thay đổi. Vui lòng thử lại sau!');
			 	
								},
							'deactivate': function(){
								g_ctrDragFeature.deactivate();
							}
						},
						type: OpenLayers.Control.TYPE_TOOL
					}); 
					g_btnEditCanhdong.id = 'btn_editing_feature';
				   
				   
				   
				   
					/*map.addControl(new OpenLayers.Control.LayerDebugger( {
						'ascending' : false
					}));
				   */
				   
				   g_btnZoomBox = new OpenLayers.Control.ZoomBox(
				            {title:"Zoom box: Selecting it you can zoom on an area by clicking and dragging."});
				   
				   g_btnZoomIn = new OpenLayers.Control.ZoomIn({displayClass:'olControlZoomIn',type: OpenLayers.Control.TYPE_BUTTON});
				   g_btnZoomOut = new OpenLayers.Control.ZoomOut({displayClass:'olControlZoomOut',type: OpenLayers.Control.TYPE_BUTTON});
				  
				   g_controlPanel = new OpenLayers.Control.Panel(
						   {
							   defaultControl: g_btnPanningHand,
							   hideControl:function(control){
								   if (OpenLayers.Util.indexOf(this.controls, control) > -1){
									   OpenLayers.Util.removeItem(this.controls, control);
									   this.redraw();
								   } else {
									  // alert('hey,control ' +control.id+' has hiden!');
								   }
							   } ,
							   showControl:function(control){
								   if (OpenLayers.Util.indexOf(this.controls, control) > -1){
									   //alert('hey,control ' +control.id+' has shown!');
								   } else {

									   this.controls = this.controls.concat(control);
									   this.redraw();
								   }
							   } 
						  }); 
				   
		   
				   g_controlPanel.addControls([
					g_btnPanningHand,
					g_btnZoomIn,
					g_btnZoomOut,
					g_btnZoomBox,
					g_btnSelectDeature,
					g_btnEditCanhdong
					 
		            
		        ]); 
		        
		        map.addControl(g_controlPanel);
		        g_btnPanningHand.activate();
		        
		        g_controlPanel.hideControl(g_btnEditCanhdong);
		        g_controlPanel.hideControl(g_btnSelectDeature);

		        //g_controlPanel.showControl(g_btnEditCanhdong);
		        
				g_controlPanel.moveTo(new OpenLayers.Pixel($(window).width()-10*(24+5),0));
 
               // map.addControl(new OpenLayers.Control.MousePosition());
		        g_debugInfo = new OpenLayers.Control.CWRSDebugInfo(); 
		        g_debugInfo.init(6);
                map.addControl(g_debugInfo);
                g_debugInfo.show('Thông tin debug:');
             	setupEventHandler();

             	map.addControl(new OpenLayers.Control.MouseDefaults());
      
       //map.removeControl(controlPanel);
      if (!map.getCenter()) {
    	  try{
         	 map.zoomToMaxExtent();
    	  }catch(err){}
      }
       

      OpenLayers.Event.observe(document, "keydown", function(evt) {
    	    //var handled = false;
    	    OnKeyDown(evt);
      });
      OpenLayers.Event.observe(document, "keyup", function(evt) {
  	       var handled = false;
  	       OnKeyUp(evt);
      }); 
      
     OpenLayers.Event.observe(document, "mouseup", function(evt) {
    	 // OnMapClick(evt);
 	     OnMouseUp(evt);
     });
     map.events.register('changelayer', null, function(evt){
    	 
    	 if (!layer_tinh.visibility && !layer_huyen.visibility && !layer_xa.visibility){
    		 cwrs_debug('no layer. Set Tinh layer to visibility');
    		 layer_tinh.setVisibility(true);
    	 }
     	 }
     ); 
 
     layer_ruong.events.on({
         moveend: function(e) {
           if (e.zoomChanged) {
        	   if (g_fn_editing_canhdong){
        		   onclick_edit_canhdong();
        	   }
               /*var zoom = parseInt(map.zoom);
               if(zoom >= 14){
                      map.setBaseLayer(map.layers[1]);                        
               }*/
        	  // alert('zoom changed');
        	   cwrs_debug('Total feat selected: '+ g_layer_vector_ruong.selectedFeatures.length)
           }
         }
       }); 
     
     
     map.div.oncontextmenu = function noContextMenu(e) {
         if (OpenLayers.Event.isRightClick(e)){

             onMapRightClick(e);
          }
     }
     createTimer();

     
     onclick_createmap();


   }

/*function checkNoLayer(){
	 var c =0;
	 for(var i=0;i<map.layers.length;i++) {  
 		 if ((map.layers[i].CLASS_NAME == 'OpenLayers.Layer.WMS') && map.layers[i].visibility && (map.layers[i].CLASS_NAME != 'OpenLayers.Layer.Vector')) { // Refresh visible non base  
               c++;
         }  
	 }
	 if (c == 0) {
		 cwrs_debug('no layer. Set Tinh layer to visibility');
		 layer_tinh.setVisibility(true);
	 }
}*/



function OnKeyDown(evt){
	 //alert (evt.keyCode)
	 //alert('ctr') ;
	 switch (evt.keyCode) {
	    case 17: // CTR
           g_key_CTR_pressed = true; 
           break;
	    case 32: // Space
	    	g_key_SPACE_pressed = true;
	    	//showHint('hhhhh',{"timeout": false})
	    	//ShowDientichRuongViewer()
	       break;   
           
        case 90: // z
           if (evt.metaKey || evt.ctrlKey) {
           	

           }
           break;
        case 27: // esc

           break;
   }

} 
function OnKeyUp(evt){
    //alert(evt.keyCode);
	 switch (evt.keyCode) {
	    case 17: // CTR
	    	//alert('keyup CTR')
           g_key_CTR_pressed = false; 
           if (g_fn_selected == FN_DIEUTRA_RUONG)
           ClosePopupThongtinGieocay();
           break;
	   case 32: // Space
	    	g_key_SPACE_pressed = false;
	    	if (g_is_checking_are == false)
	    		g_is_checking_are = true;
	    	else {
	    		g_is_checking_are = false;
	    		$.Growl.close("9999");
	    	}
	       break;
	   case 36: // Space
		  // g_isEnableEditCanhdongByAdmin = false;
	    	if (g_isEnableEditCanhdongByAdmin == false)
	    		g_isEnableEditCanhdongByAdmin = true;
	    	else {
	    		g_isEnableEditCanhdongByAdmin = false;
	    		//$.Growl.close("9999");
	    	}
	       break;
       case 90: // z
           if (evt.metaKey || evt.ctrlKey) {
           	
           }
           break;
       case 27: // esc

           break;
   }
	 
} 

function getFeatureAtPos(pixel){
	  var lonlat = map.getLonLatFromViewPortPx(pixel);
	  var  x_lon = lonlat.lon;/*x*/
 	  var  y_lat = lonlat.lat;/*y*/
	  var point = new OpenLayers.Geometry.Point(x_lon, y_lat);
      for(var i=0, len = g_layer_vector_ruong.features.length; i<len; ++i) {
              var feature = g_layer_vector_ruong.features[i];
             
              var featureBounds = feature.geometry.getBounds();
                  		var onScreen = featureBounds.containsLonLat(lonlat);
                  		if (onScreen)
                  		{
                 			if (feature.geometry.containsPoint(point)) {
                  		 		return feature;
                        }
                  }

      }
      return null;
}
function getFeatureAtPixelPos(pixel, featExcepted){
	var lonlat = map.getLonLatFromPixel(pixel);
	var  x_lon = lonlat.lon;/*x*/
	var  y_lat = lonlat.lat;/*y*/
	cwrs_debug('lonlat =' + x_lon +','+y_lat);
	var point = new OpenLayers.Geometry.Point(x_lon, y_lat);
	//var _feat = null;
	try{  
		for(var i=0, len = g_layer_vector_ruong.features.length; i<len; ++i) {
           var feature = g_layer_vector_ruong.features[i];
           // _feat= feature;
           if (featExcepted.fid == feature.fid)
        	   continue;
            var featureBounds = feature.geometry.getBounds();
                		var onScreen = featureBounds.containsLonLat(lonlat);
                		if (onScreen)
                		{
               			if (feature.geometry.containsPoint(point)) {
                		 		return feature;
                      }
                }

		}
	}catch(err){
    	//alert(_feat);
    	//alert(_feat.fid)
    }
    return null;
}
var sh =false;
function showContextMenuDelay(pixel){

}
function onMapRightClick(/*OpenLayers.Pixel*/e){
		
	 var mapOffset = $('#map').offset();
    //cwrs_debug("oncontextmenu (Right button) :"+ (e.pageX-mapOffset.left -1) + ',' + (e.pageY -mapOffset.top-1)); // Add the right click menu here
    var pixel = new OpenLayers.Pixel(e.pageX-mapOffset.left -1,e.pageY -mapOffset.top-1)
	
	cwrs_debug('On Map Right Click....' + pixel.x + ',' + pixel.y);
	if (g_fn_editing_canhdong) {
	//deactive_contextmenu();
	
	//hideContextMenu();
	var feat = getFeatureAtPos(pixel);
	if ( feat == null){
		$("#context_menu_edit_canhdong").html(     
			//   "<ul id=\"context_menu_edit_canhdong\" class=\"jeegoocontext cm_default\">"+
			"<div style=\"background:"+ "#000000" + " \">Kết thúc</div> "+
			"<li class=\"icon\" id=\"ctxmenu_editing_saveall\"><span class=\"icon disk\"></span>Lưu những thay đổi</li>"+
			"<li class=\"icon\" id=\"ctxmenu_editing_cancelall\"><span class=\"icon disk\"></span>Hủy</li> "
			//  "</ul>"
    	);
    	showContextMenu(CLASS_CONTEXTMENU_EDIT_CANHDONG);
    	 $('#map').showContextMenu(g_current_ctxmenu,e);
		return;
	} else {
		//alert(feat.fid + ', canhdong_id:' + feat.attributes['pid']);
	}
	
	//lay color canhdong tai vi tri right-click
	var canhdong = g_cdm.getCanhdongByID(feat.attributes['pid']);
    var canhdongColor = canhdong.getFillColor();
    g_selected_feature_editing = feat;
    g_cdm.setFeatureAtRightClick(feat);
    //check neu right-click vao feat da dc chon
      
	
	
	
    if (OpenLayers.Util.indexOf(g_layer_vector_ruong.selectedFeatures, feat) != -1){
    	//get from
    	$("#context_menu_edit_canhdong").html(     
			//   "<ul id=\"context_menu_edit_canhdong\" class=\"jeegoocontext cm_default\">"+
			"<div style=\"background:"+ canhdongColor + " \">Chuyển ruộng từ cánh đồng</div> "+
			"<li class=\"icon\" id=\"ctxmenu_editing_copy\"><span class=\"icon disk\"></span>Chọn những ruộng vừa đánh dấu</li>"+
			"<li class=\"icon\" id=\"ctxmenu_editing_new\"><span class=\"icon disk\"></span>Tạo cánh đồng mới từ những ruộng vừa đánh dấu</li>"+
			"<li class=\"icon\" id=\"ctxmenu_editing_cancel1\"><span class=\"icon disk\"></span>Hủy</li> "
			//  "</ul>"
    	);
    	showContextMenu(CLASS_CONTEXTMENU_EDIT_CANHDONG);
    } else  if (OpenLayers.Util.indexOf(g_layer_vector_ruong.features, feat) != -1){
	//add to
    	$("#context_menu_edit_canhdong").html(     
			//   "<ul id=\"context_menu_edit_canhdong\" class=\"jeegoocontext cm_default\">"+
			"<div style=\"background:"+ canhdongColor + "\">Thêm ruộng vào cánh đồng</div> "+
			"<li class=\"icon\" id=\"ctxmenu_editing_moveto\"><span class=\"icon disk\"></span>Di chuyển ruộng được chọn tới cánh đồng này</li>"+
			"<li class=\"icon\" id=\"ctxmenu_editing_cancel2\"><span class=\"icon disk\"></span>Hủy</li> "
			//  "</ul>"
    	);
    	showContextMenu(CLASS_CONTEXTMENU_EDIT_CANHDONG);
    	
    } else {
    //.appendTo($("#context_menu_edit_canhdong")); //main div
    }
    
	} else if (g_fn_selected == FN_DIEUTRA_CANHDONG){//if (g_fn_editing_canhdong == false)
		var water =getNguonnuocCanhdong();
		//alert(water)
		$('input[name="radio_nuoc"]').each(function(){
			if($(this).val()==water){
				$(this).attr("checked","checked");
			}
		});
		
		var dat =getTinhchatDatCanhdong();
		//alert(water)
		$('input[name="radio_dat"]').each(function(){
			if($(this).val()==dat){
				$(this).attr("checked","checked");
			}
		});
		
		
		
	
	
	} else if (g_fn_selected == FN_DIEUTRA_RUONG){//if (g_fn_editing_canhdong == false)
		var water =getNguonnuocRuong();
		//alert(water)
		$('input[name="radio_nuoc"]').each(function(){
			if($(this).val()==water){
				$(this).attr("checked","checked");
			}
		});
		
		var dat =getTinhchatDatRuong();
		//alert(water)
		$('input[name="radio_dat"]').each(function(){
			if($(this).val()==dat){
				$(this).attr("checked","checked");
			}
		});
	
	
	}
    $('#map').showContextMenu(g_current_ctxmenu,e);
    // alert("Right button click"); // Add the right click menu here
    /*$("#submenu_dtr_ttgc>li ul").hide();
	 $('#submenu_dtr_ttgc').css('display','none');
	 $('#submenu_dtr_ttgc').css({display:none});*/
	 //$("#ctx_menu_title_ruongcanhdong>li ul").css('display','none');
	///check click tai vi tri co ruong duoc chon hay ko
    //setTimeout('showContextMenuDelay('+pixel+')',500);
    //alert('ddd')
}

function OnMouseUp(mouseCode){
	 
	 g_startBox = false;
} 
 
var radius=0;
function renderCircleClick(x_lon,y_lat){
	//	origin,
	//radius,
	//sides,
	//rotation	
	var delay = 25;
	var pointLonLat = new OpenLayers.Geometry.Point(x_lon, y_lat);
	//cwrs_debug('size circle:'+layer_circle.features.length);
	var currentOpacity= 1.0;
	var stepOpacity = 0.1;
	if (layer_circle.features.length>0)
		currentOpacity = layer_circle.features[0].style.strokeOpacity;
	
	if(radius==0) radius = 0.01 * map.getExtent().getHeight();
	
    //polygonControl.handler.setOptions({radius: radius,angle: 0});
	var circul = new OpenLayers.Geometry.Polygon.createRegularPolygon(pointLonLat,radius,40,0);
	var circleStyle = {
	                strokeColor: "#ff0000",
	                //fillColor: "#00ff00",
	                fillOpacity: 0,
	                strokeWidth: 5,
	                strokeOpacity:currentOpacity-stepOpacity,
	                strokeDashstyle: "solid",
	        };
	var addCircul = new OpenLayers.Feature.Vector(circul, null, circleStyle);
	layer_circle.removeAllFeatures();
	layer_circle.addFeatures([ addCircul ]);
	layer_circle.drawFeature(addCircul);
	//cwrs_debug('draw circle..,radius='+radius);
	radius*=1.25;
	if (currentOpacity-stepOpacity >0)
	  setTimeout("renderCircleClick("+x_lon+","+y_lat+")",delay);
	else {
		layer_circle.removeAllFeatures();
		radius=0;
	}
	
}



 function OnMapClick(event){
	// $('#vientham_extruder').css({width:"500px"});
	 //alert('f')
	//  $('#vientham_extruder').find('.content').css({ width: 600});
	//  gm.gui.changePanelOptions("333", {width:580,opacity:0.4}, {})
    
	 //alert('OnMapClick');
	  var lonlat = map.getLonLatFromViewPortPx(event.xy);
	  var pixel = map.getPixelFromLonLat(lonlat);

 	  var  x_lon = lonlat.lon;/*x*/
 	  var  y_lat = lonlat.lat;/*y*/
  
	  var point = new OpenLayers.Geometry.Point(x_lon, y_lat);
	  //renderCircleClick(point);
	  //setTimeout("renderCircleClick("+x_lon+","+y_lat+")",1);
	  renderCircleClick(x_lon,y_lat);
	 
      var pointFeature = new OpenLayers.Feature.Vector(point);
      gm.map.onClick('POINT(' + x_lon + ' ' + y_lat +')','');
 	 if (g_fn_selected == FN_DIEUTRA_XA){
	  		process_onclick_dieutra_xa('POINT(' + x_lon + ' ' + y_lat +')','');
 	 } else  if (g_fn_selected == FN_BAOCAO_HIENTRANGLUA 
 			  || g_fn_selected == FN_BAOCAO_COCAUGIONGLUA 
 			  || g_fn_selected == FN_BAOCAO_THONGTINTHIENTAI
 	          || g_fn_selected == FN_BAOCAO_TIENDOSANXUAT
 	           || g_fn_selected == FN_BAOCAO_THONGTINDICHHAI
 		      || g_fn_selected == FN_BAOCAO_TIENDOTHUHOACH)
 		   //  || g_fn_selected == FN_BAOCAO_BUILDGRAPH)
 	 {
 		   //alert('1');
 		    createReport(g_fn_selected, 'POINT(' + x_lon + ' ' + y_lat +')','');
 	 } else  if (g_fn_selected == FN_DIEUTRA_THITRUONG){
 		//alert('2');
 		process_onclick_dieutra_thitruong('POINT(' + x_lon + ' ' + y_lat +')','');
 	 } 
 	else  if (g_fn_selected == FN_DIEUTRA_THOITIET){
 		//alert('2');
 		process_onclick_dieutra_thoitiet('POINT(' + x_lon + ' ' + y_lat +')','');
 	 } 
	else  if (g_fn_selected == FN_DIEUTRA_THUHOACH){
 		//alert('2');
 		process_onclick_dieutra_thuhoach('POINT(' + x_lon + ' ' + y_lat +')','');
 	 } 
	else  if (g_fn_selected == FN_DIEUTRA_DOTTHIENTAI){
 		//alert('2');
 		process_onclick_dieutra_dotthientai('POINT(' + x_lon + ' ' + y_lat +')','');
 	 }
 	 /**HIỆN TRẠNG*/
 	 else  if (g_fn_selected == FN_MAP_HIENTRANG_CCGL 
			  || g_fn_selected == FN_MAP_HIENTRANG_NUOC 
			  || g_fn_selected == FN_MAP_HIENTRANG_DICHHAI
			  || g_fn_selected == FN_MAP_HIENTRANG_THIENTAI
			  || g_fn_selected == FN_MAP_HIENTRANG_HTL
			  || g_fn_selected == FN_MAP_HIENTRANG_NANGSUAT){

 		 RenderHientrang(g_fn_selected, 'POINT(' + x_lon + ' ' + y_lat +')','');
	 } else if (g_fn_selected ==FN_VIENTHAM){
		
		 //gm.vientham.showDataInfo('POINT(' + x_lon + ' ' + y_lat +')','');
		 gm.vientham.OnMapClick('POINT(' + x_lon + ' ' + y_lat +')','');
		 
	 } else if (g_fn_selected ==FN_BAOCAO_BUILDGRAPH){
		 process_onclick_build_graph('POINT(' + x_lon + ' ' + y_lat +')','');
	 } else if (g_fn_selected ==FN_DUBAO_VT || g_fn_selected ==FN_DUBAO_HCG || g_fn_selected ==FN_DUBAO_HQH){
		
		 gm.dubao.OnMapClick('POINT(' + x_lon + ' ' + y_lat +')','');
		 
	 }
 	 /////////////////////////////////////
 	 /**CHỨC NĂNG BẢN ĐỒ HIỆN TRẠNG*/
 	/* else  if (g_fn_selected == FN_){
  		//alert('2');
  		process_onclick_dieutra_thitruong('POINT(' + x_lon + ' ' + y_lat +')','');
  	 }*/
 	 
 	 
 	 draw_area_on_map(map,g_lanhtho_selected.tinh_id,g_lanhtho_selected.huyen_id,g_lanhtho_selected.xa_id);
 	cwrs_debug('on map click...'+ gm.map.getLanhthoSelected("tinh_id")+','+gm.map.getLanhthoSelected("huyen_id")+','+gm.map.getLanhthoSelected("xa_id"));
 	 return;

 }
 
 function onclick_dieutra_thitruong(){
	    g_fn_selected = FN_DIEUTRA_THITRUONG;
	    g_fn_editing_canhdong = false;
	    resetCanhdongEdition();
		cwrs_debug('user click: điều tra thông tin thị trường...');
		g_controlPanel.hideControl(g_btnEditCanhdong);
        g_controlPanel.hideControl(g_btnSelectDeature);
        
		layer_ruong.setVisibility(false);
		layer_xa.setVisibility(false);
		layer_tinh.setVisibility(false);
		layer_huyen.setVisibility(true);
		layer_ruong_hientrang.setVisibility(false);
		g_btnPanningHand.activate();
		g_highlightCtrl.selectByClickOrBox.unselectAll();
		showContextMenu(CLASS_CONTEXTMENU_DIEUTRA_THITRUONG);
		setCurrentMenu('cdieutra');
		
 }

 function process_onclick_dieutra_thitruong(posWKT){
	 	g_lanhtho_selected.selected = false;
	 
	    var  table = 'tbl_huyen_region';
	    var  id = 'huyen_id';
	 	
	 	 var isCreatedReport = false;
	 	 var jsonData = null;
		 $.ajax({
					url: REPORT_SERVLET ,
					type: "POST",
					data:
				    { 
					  action: ACT_GET_INFO_AREA_CLICKED,
					  position: posWKT,
					  table:table,
					  id:id
					},
					 async:false,
					 error: function (request, status, error) {
					        alert(request.responseText);
					    },
					 success:function(_data) {
						//$('#'+element).html(data);
						 jsonData = _data;
	           	         //alert(jsonData)
						return _data;
				    }});
		 
		 if (jsonData != null){ 
			 var jsonObject = JSON.parse(jsonData);
				//alert(jsonObject.rows[0].ttgc_id);
				// = jsonObject.rows[0].xa_id;
				// = jsonObject.rows[0].xa_ten;
				// = jsonObject.rows[0].huyen_id;
				// = jsonObject.rows[0].huyen_ten;
				// = jsonObject.rows[0].tinh_id;
				// = jsonObject.rows[0].tinh_id;
			 /*alert('click on dieu tra thi truong: huyen_ten='
					 +jsonObject.rows[0].huyen_ten+', xa:'+jsonObject.rows[0].xa_ten+', tinh:'
					 +jsonObject.rows[0].tinh_ten);*/

			 g_lanhtho_selected.tinh_id = jsonObject.rows[0].tinh_id;
			 g_lanhtho_selected.tinh_ten = jsonObject.rows[0].tinh_ten;
			 g_lanhtho_selected.huyen_id = jsonObject.rows[0].huyen_id;
			 g_lanhtho_selected.huyen_ten = jsonObject.rows[0].huyen_ten;
			 g_lanhtho_selected.xa_id = jsonObject.rows[0].xa_id;
			 g_lanhtho_selected.xa_ten = jsonObject.rows[0].xa_ten;
			 g_lanhtho_selected.selected = true;
		 } 
	}
 
 function onclick_dieutra_thoitiet(){
	    g_fn_selected = FN_DIEUTRA_THOITIET;
	    g_fn_editing_canhdong = false;
	    resetCanhdongEdition();
		cwrs_debug('user click: điều tra thông tin thời tiết...');
		g_controlPanel.hideControl(g_btnEditCanhdong);
     g_controlPanel.hideControl(g_btnSelectDeature);
     
		layer_ruong.setVisibility(false);
		layer_xa.setVisibility(false);
		layer_tinh.setVisibility(false);
		layer_huyen.setVisibility(true);
		layer_ruong_hientrang.setVisibility(false);
		g_btnPanningHand.activate();
		g_highlightCtrl.selectByClickOrBox.unselectAll();
		showContextMenu(CLASS_CONTEXTMENU_DIEUTRA_THOITIET);
		setCurrentMenu('cdieutra');
		
}


function process_onclick_dieutra_thoitiet(posWKT){
	 	g_lanhtho_selected.selected = false;
	 
	    var  table = 'tbl_huyen_region';
	    var  id = 'huyen_id';
	 	
	 	 var isCreatedReport = false;
	 	 var jsonData = null;
		 $.ajax({
					url: REPORT_SERVLET ,
					type: "POST",
					data:
				    { 
					  action: ACT_GET_INFO_AREA_CLICKED,
					  position: posWKT,
					  table:table,
					  id:id
					},
					 async:false,
					 error: function (request, status, error) {
					        alert(request.responseText);
					    },
					 success:function(_data) {
						//$('#'+element).html(data);
						 jsonData = _data;
	           	         //alert(jsonData)
						return _data;
				    }});
		 
		 if (jsonData != null){
			 var jsonObject = JSON.parse(jsonData);
				//alert(jsonObject.rows[0].ttgc_id);
				// = jsonObject.rows[0].xa_id;
				// = jsonObject.rows[0].xa_ten;
				// = jsonObject.rows[0].huyen_id;
				// = jsonObject.rows[0].huyen_ten;
				// = jsonObject.rows[0].tinh_id;
				// = jsonObject.rows[0].tinh_id;
			 /*alert('click on dieu tra thi truong: huyen_ten='
					 +jsonObject.rows[0].huyen_ten+', xa:'+jsonObject.rows[0].xa_ten+', tinh:'
					 +jsonObject.rows[0].tinh_ten);*/

			 g_lanhtho_selected.tinh_id = jsonObject.rows[0].tinh_id;
			 g_lanhtho_selected.tinh_ten = jsonObject.rows[0].tinh_ten;
			 g_lanhtho_selected.huyen_id = jsonObject.rows[0].huyen_id;
			 g_lanhtho_selected.huyen_ten = jsonObject.rows[0].huyen_ten;
			 g_lanhtho_selected.xa_id = jsonObject.rows[0].xa_id;
			 g_lanhtho_selected.xa_ten = jsonObject.rows[0].xa_ten;
			 g_lanhtho_selected.selected = true;
		 } 
	}
function onclick_dieutra_dotthientai(){
    g_fn_selected = FN_DIEUTRA_DOTTHIENTAI;
    g_fn_editing_canhdong = false;
    resetCanhdongEdition();
	cwrs_debug('user click: điều tra đợt thiên tai...');
	g_controlPanel.hideControl(g_btnEditCanhdong);
    g_controlPanel.hideControl(g_btnSelectDeature);
 
	layer_ruong.setVisibility(false);
	layer_xa.setVisibility(false);
	layer_tinh.setVisibility(true);
	layer_huyen.setVisibility(false);
	layer_ruong_hientrang.setVisibility(false);
	g_btnPanningHand.activate();
	g_highlightCtrl.selectByClickOrBox.unselectAll();
	showContextMenu(CLASS_CONTEXTMENU_DIEUTRA_DOTTHIENTAI);
	setCurrentMenu('cdieutra');
	
}


function process_onclick_dieutra_dotthientai(posWKT){
 	g_lanhtho_selected.selected = false;
 
    var  table = 'tbl_huyen_region';
    var  id = 'huyen_id';
 	
 	 var isCreatedReport = false;
 	 var jsonData = null;
	 $.ajax({
				url: REPORT_SERVLET ,
				type: "POST",
				data:
			    { 
				  action: ACT_GET_INFO_AREA_CLICKED,
				  position: posWKT,
				  table:table,
				  id:id
				},
				 async:false,
				 error: function (request, status, error) {
				        alert(request.responseText);
				    },
				 success:function(_data) {
					//$('#'+element).html(data);
					 jsonData = _data;
           	         //alert(jsonData)
					return _data;
			    }});
	 
	 if (jsonData != null){
		 var jsonObject = JSON.parse(jsonData);
			//alert(jsonObject.rows[0].ttgc_id);
			// = jsonObject.rows[0].xa_id;
			// = jsonObject.rows[0].xa_ten;
			// = jsonObject.rows[0].huyen_id;
			// = jsonObject.rows[0].huyen_ten;
			// = jsonObject.rows[0].tinh_id;
			// = jsonObject.rows[0].tinh_id;
		 /*alert('click on dieu tra thi truong: huyen_ten='
				 +jsonObject.rows[0].huyen_ten+', xa:'+jsonObject.rows[0].xa_ten+', tinh:'
				 +jsonObject.rows[0].tinh_ten);*/

		 g_lanhtho_selected.tinh_id = jsonObject.rows[0].tinh_id;
		 g_lanhtho_selected.tinh_ten = jsonObject.rows[0].tinh_ten;
		 g_lanhtho_selected.huyen_id = jsonObject.rows[0].huyen_id;
		 g_lanhtho_selected.huyen_ten = jsonObject.rows[0].huyen_ten;
		 g_lanhtho_selected.xa_id = jsonObject.rows[0].xa_id;
		 g_lanhtho_selected.xa_ten = jsonObject.rows[0].xa_ten;
		 g_lanhtho_selected.selected = true;
	 } 
}


function process_onclick_build_graph(posWKT){
	//getLanhthoClicked('tbl_xa_region','xa_id',posWKT);
	//loadJS('components/lightface_dialog/LightFace.js');
	
//alert($('#map').width())
	/* profileBox = new LightFace.IFrame({
			width: 800, 
			height: $('#map').height(), 
			draggable: true,
			url:'http://www.vnexpress.net',
			title: 'Đồ thị',
			content: '<img src="http://davidwalsh.name/wp-content/themes/walshhub/images/huge-logo.png" style="float:right;margin:0 0 20px 20px;" /><p>This blog is targeted toward all levels of web designers and developers. All web topics are discussed, including <a href="/tutorials/css">CSS</a>, <a href="/tutorials/javascript">JavaScript</a>  (<a href="/tutorials/mootools">MooTools</a>, <a href="/tutorials/dojo">Dojo</a>, and <a href="/tutorials/jquery">jQuery</a>), <a href="/tutorials/html5">HTML5</a>, <a href="/tutorials/php">PHP</a>, and everything else.</p><p style="margin:0;padding:0;">I am a 27 year old Web Developer and MooTools, Dojo, and jQuery JavaScript Consultant working from Madison, Wisconsin. I am a Software Engineer for SitePen, the prestigious JavaScript development shop.</p>',
			buttons: [
				{ title: 'Close', event: function() { this.close(); }, color: 'blue' }
			]
		});

		// Open Sesame!
	 profileBox.open();
	 profileBox.setPosition(0,0);

		//Update Content*/
		
}


function onclick_dieutra_thuhoach(){
	    g_fn_selected = FN_DIEUTRA_THUHOACH;
	    g_fn_editing_canhdong = false;
	    resetCanhdongEdition();
		cwrs_debug('user click: điều tra thông tin thu hoạch...');
		g_controlPanel.hideControl(g_btnEditCanhdong);
    g_controlPanel.hideControl(g_btnSelectDeature);
    
		layer_ruong.setVisibility(false);
		layer_xa.setVisibility(false);
		layer_tinh.setVisibility(true);
		layer_huyen.setVisibility(false);
		layer_ruong_hientrang.setVisibility(false);
		g_btnPanningHand.activate();
		g_highlightCtrl.selectByClickOrBox.unselectAll();
		showContextMenu(CLASS_CONTEXTMENU_DIEUTRA_THUHOACH);
		setCurrentMenu('cdieutra');
		
}

function process_onclick_dieutra_thuhoach(posWKT){
	 	g_lanhtho_selected.selected = false;
	 
	    var  table = 'tbl_huyen_region';
	    var  id = 'huyen_id';
	 	
	 	 var isCreatedReport = false;
	 	 var jsonData = null;
		 $.ajax({
					url: REPORT_SERVLET ,
					type: "POST",
					data:
				    { 
					  action: ACT_GET_INFO_AREA_CLICKED,
					  position: posWKT,
					  table:table,
					  id:id
					},
					 async:false,
					 error: function (request, status, error) {
					        alert(request.responseText);
					    },
					 success:function(_data) {
						//$('#'+element).html(data);
						 jsonData = _data;
	           	         //alert(jsonData)
						return _data;
				    }});
		 
		 if (jsonData != null){
			 var jsonObject = JSON.parse(jsonData);
				//alert(jsonObject.rows[0].ttgc_id);
				// = jsonObject.rows[0].xa_id;
				// = jsonObject.rows[0].xa_ten;
				// = jsonObject.rows[0].huyen_id;
				// = jsonObject.rows[0].huyen_ten;
				// = jsonObject.rows[0].tinh_id;
				// = jsonObject.rows[0].tinh_id;
			    /*alert('click on dieu tra thi truong: huyen_ten='
					 +jsonObject.rows[0].huyen_ten+', xa:'+jsonObject.rows[0].xa_ten+', tinh:'
					 +jsonObject.rows[0].tinh_ten);*/

			 g_lanhtho_selected.tinh_id = jsonObject.rows[0].tinh_id;
			 g_lanhtho_selected.tinh_ten = jsonObject.rows[0].tinh_ten;
			 g_lanhtho_selected.huyen_id = jsonObject.rows[0].huyen_id;
			 g_lanhtho_selected.huyen_ten = jsonObject.rows[0].huyen_ten;
			 g_lanhtho_selected.xa_id = jsonObject.rows[0].xa_id;
			 g_lanhtho_selected.xa_ten = jsonObject.rows[0].xa_ten;
			 g_lanhtho_selected.selected = true;
		 } 
	}

 function process_onclick_dieutra_xa(posWKT){
	 	g_lanhtho_selected.selected = false;
	 
	    var  table = 'tbl_xa_region';
	    var  id = 'xa_id';
        cwrs_debug('process_onclick_dieutra_xa...');
	 	var jsonData = null;
		 $.ajax({
					url: REPORT_SERVLET ,
					type: "POST",
					data:
				    { 
					  action: ACT_GET_INFO_AREA_CLICKED,
					  position: posWKT,
					  table:table,
					  id:id
					},
					 async:false,
					 error: function (request, status, error) {
					        alert(request.responseText);
					    },
					 success:function(_data) {
						//$('#'+element).html(data);
						 jsonData = _data;
						 //alert(jsonData)
						return _data;
				    }});
		 
		 if (jsonData != null){
			 var jsonObject = JSON.parse(jsonData);
			 
				//alert(jsonObject.rows[0].ttgc_id);
				// = jsonObject.rows[0].xa_id;
				// = jsonObject.rows[0].xa_ten;
				// = jsonObject.rows[0].huyen_id;
				// = jsonObject.rows[0].huyen_ten;
				// = jsonObject.rows[0].tinh_id;
				// = jsonObject.rows[0].tinh_id;

			 /*alert('click on dieu tra thi truong: huyen_ten='
					 +jsonObject.rows[0].huyen_ten+', xa:'+jsonObject.rows[0].xa_ten+', tinh:'
					 +jsonObject.rows[0].tinh_ten);*/

			 g_lanhtho_selected.tinh_id = jsonObject.rows[0].tinh_id;
			 g_lanhtho_selected.tinh_ten = jsonObject.rows[0].tinh_ten;
			 g_lanhtho_selected.huyen_id = jsonObject.rows[0].huyen_id;
			 g_lanhtho_selected.huyen_ten = jsonObject.rows[0].huyen_ten;
			 g_lanhtho_selected.xa_id = jsonObject.rows[0].xa_id;
			 g_lanhtho_selected.xa_ten = jsonObject.rows[0].xa_ten;
			 g_lanhtho_selected.selected = true;
			 
			 cwrs_debug('g_lanhtho_selected.xa_ten:'+g_lanhtho_selected.xa_ten);
		 }
			
		 
	}
 
 
 function process_onclick_hientrang_ccgl(posWKT){

	    g_lanhtho_selected.selected = false;
	    var  table = 'tbl_xa_region';
	    var  id = 'xa_id';

	 	var jsonData = null;
		$.ajax({
					url: RENDER_SERVLET ,
					type: "POST",
					data:
				    { 
					  action: ACT_RENDER_MAP_CCGL,
					  position: posWKT,
					  table:table,
					  id:id
					  
					},
					 async:false,

					 success:function(path) {
						//$('#'+element).html(data);
						// jsonData = _data;
						 //alert(jsonData)
						return path;
				    }});
		 
		/* if (jsonData != null){
			 var jsonObject = JSON.parse(jsonData);
			 g_lanhtho_selected.tinh_id = jsonObject.rows[0].tinh_id;
			 g_lanhtho_selected.tinh_ten = jsonObject.rows[0].tinh_ten;
			 g_lanhtho_selected.huyen_id = jsonObject.rows[0].huyen_id;
			 g_lanhtho_selected.huyen_ten = jsonObject.rows[0].huyen_ten;
			 g_lanhtho_selected.xa_id = jsonObject.rows[0].xa_id;
			 g_lanhtho_selected.xa_ten = jsonObject.rows[0].xa_ten;
			 g_lanhtho_selected.selected = true;			 
			 cwrs_debug('g_lanhtho_selected.xa_ten:'+g_lanhtho_selected.xa_ten);
		 }*/
			
		 
	 
 }
 /**
  * REPORT PROCESSING
  */
 function onclick_report_hientranglua(){
	 	g_fn_selected = FN_BAOCAO_HIENTRANGLUA;
	 	g_fn_editing_canhdong = false;
	 	onclick_report();
	 	onclick_createReport(g_fn_selected);
	 	showPanel_report_htl();
	 	showPanel_createdinhdangbc();
	 	layer_ruong_hientrang.setVisibility(false);
	 	cwrs_debug('click report hiện trạng lúa...');
	 	deactivate_dieutra_canhdong();
	 	 openExtruder('baocao_extruder');
	 	setCurrentMenu('cbaocao');
	}
 /*$('#dlg_main_hientrang_textboxdate').datebox({required:false,
	  	formatter:function(date){
	  
		return gDateFormatterDefault.format(date);
	 		   
	 },
	 parser:function(dateStr){
		 return (gm.date.string2Date(dateStr));
	 }  
	}); 
*/
function onclick_report_tiendosanxuat(){
	    g_fn_selected = FN_BAOCAO_TIENDOSANXUAT;
	    g_fn_editing_canhdong = false; 
	    onclick_report();
	    onclick_createReport(g_fn_selected);
	    showPanel_report_tdsx();
	    showPanel_createdinhdangbc();
	    /*setTimeout("createTimer1()",/*TIMER_DELAY + 500);*/
	    layer_ruong_hientrang.setVisibility(false);
	    cwrs_debug('click report tien do san xuat...');
	    deactivate_dieutra_canhdong();
	    openExtruder('baocao_extruder');
	    //gm.gui.createLeftPanelSlave()
	    // gm.gui.changePanelOptions("aaa", {width:280,opacity:0.8}, {})	    
	   //    gm.gui.setSlaveExtruderOptions("aAAAAA")
	  //  gm.gui.openSlaveExtruder();
	  //  gm.gui.panelSlaveExtruder.find(".flapLabel").text("flapOpts");
	    
	    setCurrentMenu('cbaocao');
}
	function onclick_report_cocaugionglua(){
	    g_fn_selected = FN_BAOCAO_COCAUGIONGLUA;
	    g_fn_editing_canhdong = false; 
	    onclick_report();
	    onclick_createReport(g_fn_selected);
	    showPanel_report_ccgl();
	    showPanel_createdinhdangbc();
	    /*setTimeout("createTimer1()",/*TIMER_DELAY + 500);*/
	    layer_ruong_hientrang.setVisibility(false);
	    cwrs_debug('click report cơ cấu giống lúa...');
	    deactivate_dieutra_canhdong();
	    openExtruder('baocao_extruder');
	    setCurrentMenu('cbaocao');
	}
function onclick_report_tiendothuhoach(){
	    g_fn_selected = FN_BAOCAO_TIENDOTHUHOACH;
	    g_fn_editing_canhdong = false; 
	    onclick_report();
	    onclick_createReport(g_fn_selected);
	    showPanel_report_ccgl();
	    showPanel_createdinhdangbc();
	    /*setTimeout("createTimer1()",/*TIMER_DELAY + 500);*/
	    layer_ruong_hientrang.setVisibility(false);
	    cwrs_debug('click report tiến độ thu hoạch...');
	    deactivate_dieutra_canhdong();
	    openExtruder('baocao_extruder');
	    setCurrentMenu('cbaocao');
	}

 function onclick_report_thongtinthientai(){
	    g_fn_selected = FN_BAOCAO_THONGTINTHIENTAI;
	    g_fn_editing_canhdong = false; 
	    onclick_report();
	    onclick_createReport(g_fn_selected);
	    showPanel_report_tt();
	    showPanel_createdinhdangbc();
	    layer_ruong_hientrang.setVisibility(false);
	    cwrs_debug('click report thông tin thiên tai...');
	    deactivate_dieutra_canhdong();
	    openExtruder('baocao_extruder');
	    setCurrentMenu('cbaocao');

	}
 function onclick_report_thongtindichhai(){
	// msginfo("Chức năng đang được cập nhật...Vui lòng thử lại sau <b>18h00 20/05/2012</b>");return;
	    g_fn_selected = FN_BAOCAO_THONGTINDICHHAI;
	    g_fn_editing_canhdong = false; 
	    onclick_report();
	    onclick_createReport(g_fn_selected);
	    showPanel_report_ttdh();
	    showPanel_createdinhdangbc();
	    layer_ruong_hientrang.setVisibility(false);
	    cwrs_debug('click report thông tin dịch hại...');
	    deactivate_dieutra_canhdong();
	    openExtruder('baocao_extruder');
	    setCurrentMenu('cbaocao');

	}
 function onclick_report_tinhhinhthientai(){
		// msginfo("Chức năng đang được cập nhật...Vui lòng thử lại sau <b>18h00 20/05/2012</b>");return;
		    g_fn_selected = FN_BAOCAO_THIENTAI;
		    g_fn_editing_canhdong = false; 
		    onclick_report();
		    onclick_createReport(g_fn_selected);
		    showPanel_report_ttdh();
		    showPanel_createdinhdangbc();
		    layer_ruong_hientrang.setVisibility(false);
		    cwrs_debug('click report thông tin thien tai...');
		    deactivate_dieutra_canhdong();
		    openExtruder('baocao_extruder');
		    setCurrentMenu('cbaocao');

		}
 function autoResize(id){
	    var newheight;
	    var newwidth;

	    if(document.getElementById){
	        newheight=document.getElementById(id).contentWindow.document .body.scrollHeight;
	        newwidth=document.getElementById(id).contentWindow.document .body.scrollWidth;
	    }

	    document.getElementById(id).height= (newheight) + "px";
	    document.getElementById(id).width= (newwidth) + "px";
	}

 function onclick_menu_buildgraph(){
	 
	 	 $('#dlg_report_build_graph').css({margin:" 5px 5px 5px 5px"})
		 $('#dlg_report_build_graph').css({background:"rgb(0, 0, 0)"})
		 $('#dlg_report_build_graph').corner();	
		 $('#dlg_report_build_graph').css({background:"rgba(0, 0, 0, 0.30)"})
		//autoResize('report_build_graph_iframe');
	 	
				 		
	// msginfo("Chức năng đang được cập nhật (bổ sung dịch hại, mật độ sâu, diện tích nhiễm)...Vui lòng thử lại sau 18h00 19/05/2012");//return;
	    g_fn_selected = FN_BAOCAO_BUILDGRAPH;
	    g_fn_editing_canhdong = false;	  
	    onclick_report();
	    onclick_createReport(g_fn_selected);
	  showPanel_graph();
	 //   showPanel_graph_option_loaiDT();
	  //  showPanel_graph_content();
		// showPanel_graph_content_dichhai();
	   //  showPanel_graph_option_kieuDT();
	 //   showPanel_report();
	  //  showPanel_graph();
	    //showPanel_graph_left();
	  //  showPanel_graph_right();
	    layer_ruong_hientrang.setVisibility(false);
	    cwrs_debug('click build graph...');
	    deactivate_dieutra_canhdong();
	    gm.report.graph.onLoad();
	   
	    openExtruder('baocao_extruder');
	   // openExtruder('baocao_build_graph_extruder');


	    setCurrentMenu('cbaocao');

	}
 
 //=================PROCESS FOR BUILD GRAPH
 /**Tao noi dung chu giai theo tuy chon khi xay dung do thi so sanh*/
/* function _onChange_Options_BuildGraph(){
	 getOptionsBuildGraph();
 }
 
 function getOptionsBuildGraph(){
	 var content='Bạn đang xây dựng đồ thị so sánh ';
	 
	 var gl=getCbbValue('dlg_main_graph_cbgionglua');
	 var vuid=getCbbValue('dlg_main_graph_cbvulua');
	 
	 var month=getCbbValue('dlg_main_graph_cbthang');
	 var nam_from=getCbbValue('dlg_main_graph_cbnam1');
	 var nam_to=getCbbValue('dlg_main_graph_cbnam2');
	 var option=0;
	// -Bạn xây dựng đồ thị so sánh diện tích gieo cấy giống  A của vụ đông xuân đến tháng 5 trong N năm lien tục (2002 đến 2012).
	 var type= $('input:radio[name=dlg_main_graph_radio]:checked').val();

         if(type == '1') {
        	 content+='diện tích gieo cấy';
        	 option=1;
         } else if(type == '2') {
        	 content+='diện tích thu hoạch';
        	 option=2;
         } else if(type == '3') {
        	 content+='sản lượng thu hoạch';
        	 option=3;
        } else {
        	
         }
      if (gl!=-1)content+=' giống ' +getCbbText('dlg_main_graph_cbgionglua');
      //else content+='( tất cả các giống) ';
      
      if (vuid!=-1)content+=' của vụ ' +getCbbText('dlg_main_graph_cbvulua');
      //else content+='( tất cả các vụ) ';
      
      if (month!=-1)content+=' tính đến tháng ' +getCbbText('dlg_main_graph_cbthang');
     
      if (nam_from!=-1)content+=' trong ' + (parseInt(nam_to)-parseInt(nam_from)+1)+' năm liên tục('+nam_from+' đến '+nam_to+').';
     
      if (vuid==1){
    	  var cbbmonth_graph='';
    		 for (var i =1; i <= 5; i++)
    			 cbbmonth_graph += ('<option value=\'' + i + '\'>' + i+  '</option>');
    	  var cbbmonth_graph = ('<option value=\'' + -1 + '\'>' + '*'+  '</option>')+cbbmonth_graph;
    	  $('#dlg_main_graph_cbthang').html(cbbmonth_graph);	 
    	  $("#dlg_main_graph_cbthang").val(-1); 
      }else{
    	  var cbbmonth_graph='';
    		 for (var i =1; i <= 12; i++)
    			 cbbmonth_graph += ('<option value=\'' + i + '\'>' + i+  '</option>');
    	  var cbbmonth_graph = ('<option value=\'' + -1 + '\'>' + '*'+  '</option>')+cbbmonth_graph;
    	  $('#dlg_main_graph_cbthang').html(cbbmonth_graph);	
      }

  	 var strJson = '{\"gionglua_id\":'+ gl +',\"vulua_id\":'+vuid+',\"month\":'+month+',\"year_from\":'+nam_from+',\"year_to\":'+nam_to+',\"content\":'+"\""+content+"\""+',\"option\":'+option+'}';
  	 alert(strJson);
  	 return JSON.parse(strJson);
 }
*/

 function onchange_report_ccgl_opts_cavu_cbvulua(){
	 //alert('')
	 var cbbyear = ''; 
	 var cbbyear_dongxuan='';
	 for (var i =0; i >= -10; i--){
		 cbbyear_dongxuan += ('<option value=\'' + (parseInt(g_rtc.year)+i)+'-'+( parseInt(g_rtc.year)+i+1)+ '\'>'+(parseInt(g_rtc.year)+i)+' - '+(parseInt(g_rtc.year)+i+1)+'</option>');
		 cbbyear += ('<option value=\'' + (parseInt(g_rtc.year)+i)+'\'>'+(parseInt(g_rtc.year)+i)+'</option>');

	 }
	var vuid= $("#dlg_main_report_cavu_cbvulua").val();
	if (vuid==1){
		$('#dlg_main_report_cavu_nam').html(cbbyear_dongxuan);
	} else
		$('#dlg_main_report_cavu_nam').html(cbbyear);
	 
	
 }
 function onchange_report_tttt_opts_cavu_cbvulua(){
	 var nam;
	 nam=$("#dlg_main_report_tt_nam").val();
	 if ($('#dlg_main_report_tt_cbvulua').val()==1){//dong xuan
		 var ct= ('<option value=\'' + (parseInt(nam)-1)+'-'+( parseInt(nam))+ '\'>'+(parseInt(nam)-1)+'-'+( parseInt(nam))+'</option>');
		 ct+= ('<option value=\'' + (parseInt(nam))+'-'+( parseInt(nam)+1)+ '\'>'+(parseInt(nam))+'-'+( parseInt(nam)+1)+'</option>');
		 
		 $('#dlg_main_report_tt_cavu_nam').html(ct);
		 $("#dlg_main_report_tt_cavu_nam").attr('disabled',false);

	 } else{
		 $('#dlg_main_report_tt_cavu_nam').html(('<option value=\'' + nam+ '\'>'+nam+'</option>'));
		 $("#dlg_main_report_tt_cavu_nam").attr('disabled',true);
	 }
 }
 function onchange_report_tttt_cbtinh(){
	 var tinh_id, cond;
	 tinh_id = $("#dlg_main_report_tt_cbtinh").val();
	// alert(tinh_id);
	// cond=" dot_loaithientai="+loaitt_id+" AND dot_tinh_id="+g_lanhtho_selected.getIDTinh();
	 cond="dot_tinh_id="+tinh_id;
	// alert(cond);
	 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_DOT_THIENTAI_TO_CBB,cond, TYPE_DATA_HTML_CBB,"*", 'dlg_main_report_tt_cbdot');
	 onchange_report_tttt_cbloaithientai();
	 
 }
 function onchange_report_tttt_cbloaithientai(){
	 var loaitt_id, tinh_id, cond;
	 tinh_id = $("#dlg_main_report_tt_cbtinh").val();
	 loaitt_id = $("#dlg_main_report_tt_cbthientai").val();
	 cond=" dot_loaithientai="+loaitt_id+" AND dot_tinh_id="+tinh_id;
	// alert("cond_cbloaithientai"+cond)
	 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_DOT_THIENTAI_TO_CBB,cond, TYPE_DATA_HTML_CBB,"*", 'dlg_main_report_tt_cbdot');
	 onchange_report_tttt_cbnam();
	 
 }
 

 
 function onchange_hientrang_tttt_cbtinh(){
	 var tinh_id, cond;
	 tinh_id = $("#dlg_main_report_tt_cbtinh").val();
	// alert(tinh_id);
	// cond=" dot_loaithientai="+loaitt_id+" AND dot_tinh_id="+g_lanhtho_selected.getIDTinh();
	 cond="dot_tinh_id="+tinh_id;
	// alert(cond);
	 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_DOT_THIENTAI_TO_CBB,cond, TYPE_DATA_HTML_CBB,"*", 'dlg_main_report_tt_cbdot');
	 onchange_hientrang_tttt_cbloaithientai();
	 
 }
 function onchange_hientrang_tttt_cbloaithientai(){
	 var loaitt_id, tinh_id, cond;
	 tinh_id = $("#dlg_main_hientrang_thientai_cbtinh").val();
	 loaitt_id = $("#dlg_main_hientrang_thientai_cbthientai").val();
	 cond=" dot_loaithientai="+loaitt_id+" AND dot_tinh_id="+tinh_id;
	// alert("cond_cbloaithientai"+cond)
	 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_DOT_THIENTAI_TO_CBB,cond, TYPE_DATA_HTML_CBB,"*", 'dlg_main_hientrang_thientai_cbdot');
	 onchange_hientrang_tttt_cbnam();
	 
 }
 function onchange_main_hientrang_cbthientai(){ //dlg_main_hientrang_cbthientai
	var loaitt_id, cond
	loaitt_id=  $("#dlg_main_hientrang_thientai_cbthientai").val();
	
	 cond=" dot_loaithientai="+loaitt_id+" AND dot_tinh_id="+g_lanhtho_selected.getIDTinh();
	 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_DOT_THIENTAI_TO_CBB,cond, TYPE_DATA_HTML_CBB,"*", 'dlg_main_hientrang_thientai_cbdot');

 }
 
 function onchange_hientrang_tttt_cbnam(){
	 //thay doi du lieu combo option dot
	// $('#dlg_main_report_tt_cbdot').html();
	 var loaitt_id,nam,tinh_id,cond;
	 tinh_id = $("#dlg_main_hientrang_thientai_cbtinh").val();
	 loaitt_id=  $("#dlg_main_hientrang_thientai_cbthientai").val();
	 nam=$("#dlg_main_hientrang_thientai_cbnam").val();
 //alert("nam:"+nam);
	var  jsTime=gm.date.year2JSONDate(nam);
	// alert(jsTime);
	 cond=" dot_loaithientai="+loaitt_id+ " AND dot_ngaybatdau >="+jsTime.sti+" AND dot_ngaybatdau<="+jsTime.eti +" AND dot_tinh_id="+tinh_id;
	 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_DOT_THIENTAI_TO_CBB,cond, TYPE_DATA_HTML_CBB,"*", 'dlg_main_hientrang_thientai_cbdot');
	// alert(cond)
//	 alert("cond_cbnam"+cond)
	 //thay doi cbnam cua option ca vu
	/* if ($('#dlg_main_report_tt_cbvulua').val()==1){//dong xuan
		 var ct= ('<option value=\'' + (parseInt(nam)-1)+'-'+( parseInt(nam))+ '\'>'+(parseInt(nam)-1)+'-'+( parseInt(nam))+'</option>');
		 ct+= ('<option value=\'' + (parseInt(nam))+'-'+( parseInt(nam)+1)+ '\'>'+(parseInt(nam))+'-'+( parseInt(nam)+1)+'</option>');
		 
		 $('#dlg_main_report_tt_cavu_nam').html(ct);

	 } else{
		 $('#dlg_main_report_tt_cavu_nam').html(('<option value=\'' + nam+ '\'>'+nam+'</option>'));
	 }
	
	 */
 }
 
 function OnComboLoaiBanDoChange(){ //dlg_main_hientrang_cbthientai
		var loaibd_id, cond;
		loaibd_id=  $("#dlg_rs_cbloaibando").val();
		//ẩn chú giải
		if(loaibd_id=="2")
		$("#div_chugiai_vientham").hide();
		else 
			$("#div_chugiai_vientham").show();
		 cond=" loai_bando_id="+loaibd_id;
		// cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_DOT_THIENTAI_TO_CBB,cond, TYPE_DATA_HTML_CBB,"*", 'dlg_main_hientrang_thientai_cbdot');
		 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_VIENTHAM_TO_CBB, cond, TYPE_DATA_HTML_CBB,'*', 'dlg_rs_cbanh');	
		 
	 }
 function onchange_report_tttt_cbnam(){
	 //thay doi du lieu combo option dot
	// $('#dlg_main_report_tt_cbdot').html();
	 var loaitt_id,nam,tinh_id,cond;
	 tinh_id = $("#dlg_main_report_tt_cbtinh").val();
	 loaitt_id=  $("#dlg_main_report_tt_cbthientai").val();
	 nam=$("#dlg_main_report_tt_nam").val();
	// alert("nam:"+nam);
	var  jsTime=gm.date.year2JSONDate(nam);
//	alert(jsTime);
	 cond=" dot_loaithientai="+loaitt_id+ " AND dot_ngaybatdau >="+jsTime.sti+" AND dot_ngaybatdau<="+jsTime.eti +" AND dot_tinh_id="+tinh_id;
	 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_DOT_THIENTAI_TO_CBB,cond, TYPE_DATA_HTML_CBB,"*", 'dlg_main_report_tt_cbdot');
	// alert(cond)
//	 alert("cond_cbnam"+cond)
	 //thay doi cbnam cua option ca vu
	 if ($('#dlg_main_report_tt_cbvulua').val()==1){//dong xuan
		 var ct= ('<option value=\'' + (parseInt(nam)-1)+'-'+( parseInt(nam))+ '\'>'+(parseInt(nam)-1)+'-'+( parseInt(nam))+'</option>');
		 ct+= ('<option value=\'' + (parseInt(nam))+'-'+( parseInt(nam)+1)+ '\'>'+(parseInt(nam))+'-'+( parseInt(nam)+1)+'</option>');
		 
		 $('#dlg_main_report_tt_cavu_nam').html(ct);

	 } else{
		 $('#dlg_main_report_tt_cavu_nam').html(('<option value=\'' + nam+ '\'>'+nam+'</option>'));
	 }
	
	 
 }
 function onclick_report(){
	if (loadHtml("dlg_report_query","./Dialogs/baocao.html",false, true)) return;
	 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_VULUA_TO_CBB,null, TYPE_DATA_HTML_CBB,"*", 'dlg_main_report_vu2ngay_cbvulua');
	 $('#dlg_main_report_cavu_cbvulua').html($('#dlg_main_report_vu2ngay_cbvulua').html());
	 $('#dlg_main_report_tt_cbvulua').html($('#dlg_main_report_vu2ngay_cbvulua').html());
	 $('#dlg_main_report_tdsx_cbvulua').html($('#dlg_main_report_vu2ngay_cbvulua').html());
	 $('#dlg_main_report_tiendo_cbvulua').html($('#dlg_main_report_vu2ngay_cbvulua').html());
	 $('#dlg_main_graph_cbvulua').html($('#dlg_main_report_vu2ngay_cbvulua').html());
	cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_DOT_THIENTAI_TO_CBB,null, TYPE_DATA_HTML_CBB,"*", 'dlg_main_report_tt_cbdot');
	cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_THIENTAI_TO_CBB,null, TYPE_DATA_HTML_CBB,"*", 'dlg_main_report_tt_cbthientai');
	cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_TINH_TO_CBB,null, TYPE_DATA_HTML_CBB,"Tỉnh/Thành", 'dlg_main_report_tt_cbtinh');

	//	 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_VULUA_TO_CBB,null, TYPE_DATA_HTML_CBB,"*", 'dlg_main_graph_cbvulua');
		
		cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_GIONGLUA_TO_CBB,null, TYPE_DATA_HTML_CBB,"*", 'dlg_main_graph_cbgionglua');
	 var cbbyear = ''; 
	 var cbbyear_dongxuan='';
	 for (var i =0; i >= -10; i--){
		 cbbyear_dongxuan += ('<option value=\'' + (parseInt(g_rtc.year)+i)+'-'+( parseInt(g_rtc.year)+i+1)+ '\'>'+(parseInt(g_rtc.year)+i)+' - '+(parseInt(g_rtc.year)+i+1)+'</option>');
		 cbbyear += ('<option value=\'' + (parseInt(g_rtc.year)+i)+'\'>'+(parseInt(g_rtc.year)+i)+'</option>');
	 }
	 var cbbyear1 = ''; 
	 for (var i =0; i >= -10; i--)
		 cbbyear1 += ('<option value=\'' + (parseInt(g_rtc.year) +i)+ '-'+(parseInt(g_rtc.year) +i+1)+'\'>'+ (parseInt(g_rtc.year) +i)+ '-'+(parseInt(g_rtc.year) +i+1)+'</option>');
	 var cbbmonth = ''; 
	 for (var i =1; i <= 12; i++)
		 cbbmonth += ('<option value=\'' + i + '\'>' + i+  '</option>');

	 var cbbgionglua = ''; 
	 for (var i =1; i <= 10; i++)
		 cbbgionglua += ('<option value=\'' + i + '\'>' + i+  '</option>');
	 
	
	 $('#dlg_main_report_cavu_nam').html(cbbyear);
	 $("#dlg_main_report_cavu_nam").val(g_rtc.year);
	 $('#dlg_main_report_tt_nam').html(cbbyear);
	 $("#dlg_main_report_tt_nam").val(g_rtc.year);
	 $('#dlg_main_report_htl_nam').html(cbbyear);
	 $("#dlg_main_report_htl_nam").val(g_rtc.year);
	 
	 $('#dlg_main_report_htl_thang').html(cbbmonth);	 
	 $("#dlg_main_report_htl_thang").val(g_rtc.month);
	 
     //BUILD GRAPH
	 var cbbyear1_graph='';
	 for (var i =-10; i <= 0; i++)
		 cbbyear1_graph += ('<option value=\'' + (parseInt(g_rtc.year) +i)+ '\'>'+ (parseInt(g_rtc.year) +i)+'</option>');

	 $('#dlg_main_graph_cbnam1').html(cbbyear1_graph);
	 $("#dlg_main_graph_cbnam1").val(g_rtc.year);
	 $('#dlg_main_graph_cbnam2').html(cbbyear);
	 $("#dlg_main_graph_cbnam2").val(g_rtc.year);
	
	 var cbbmonth_graph = ('<option value=\'' + -1 + '\'>' + '*'+  '</option>')+cbbmonth;
	 $('#dlg_main_graph_cbthang').html(cbbmonth_graph);	 
	 $("#dlg_main_graph_cbthang").val(-1);
	 //END BUILD GRAPH
	 
	 
     $("input[name=dlg_main_report_radio]:radio").click(function() { // attack a click event on all radio buttons with name 'radiogroup'
         if($(this).val() == '1') {//check which radio button is clicked 
        	 $('#dlg_main_report_taingay_datebox').datebox('enable'); 
        	 $('#dlg_main_report_vu2ngay_datebox').datebox('disable');
        	 $("#dlg_main_report_vu2ngay_cbvulua").attr('disabled',true);
        	 $("#dlg_main_report_cavu_nam").attr('disabled',true);
        	 $("#dlg_main_report_cavu_cbvulua").attr('disabled',true);
        	 $("#dlg_main_report_tiendo_cbvulua").attr('disabled',true);
        	 $('#dlg_main_report_tiendo_datebox1').datebox('disable');
        	 $('#dlg_main_report_tiendo_datebox2').datebox('disable');
         } else if($(this).val() == '2') {
         	 $('#dlg_main_report_taingay_datebox').datebox('disable');
        	 $("#dlg_main_report_cavu_nam").attr('disabled',true);
        	 $("#dlg_main_report_cavu_cbvulua").attr('disabled',true);    	 
        	 $('#dlg_main_report_vu2ngay_datebox').datebox('enable');
        	 $("#dlg_main_report_vu2ngay_cbvulua").attr('disabled',false);
        	 $("#dlg_main_report_tiendo_cbvulua").attr('disabled',true);
        	 $('#dlg_main_report_tiendo_datebox1').datebox('disable');
        	 $('#dlg_main_report_tiendo_datebox2').datebox('disable');
        	
                 //do something else
         } else if($(this).val() == '3') {
         	 $('#dlg_main_report_taingay_datebox').datebox('disable');
        	 $('#dlg_main_report_vu2ngay_datebox').datebox('disable');
        	 $("#dlg_main_report_vu2ngay_cbvulua").attr('disabled',true);
        	 
        	 $("#dlg_main_report_cavu_nam").attr('disabled',false);
        	 $("#dlg_main_report_cavu_cbvulua").attr('disabled',false);
        	 $("#dlg_main_report_tiendo_cbvulua").attr('disabled',true);
        	 $('#dlg_main_report_tiendo_datebox1').datebox('disable');
        	 $('#dlg_main_report_tiendo_datebox2').datebox('disable');
        	 
         }
     
         else if($(this).val() == '4') {
        	 $('#dlg_main_report_taingay_datebox').datebox('disable'); 
        	 $('#dlg_main_report_vu2ngay_datebox').datebox('disable');
        	 $("#dlg_main_report_vu2ngay_cbvulua").attr('disabled',true);
        	 $("#dlg_main_report_cavu_nam").attr('disabled',true);
        	 $("#dlg_main_report_cavu_cbvulua").attr('disabled',true);
        	 $("#dlg_main_report_tiendo_cbvulua").attr('disabled',false);
        	 $('#dlg_main_report_tiendo_datebox1').datebox('enable');
        	 $('#dlg_main_report_tiendo_datebox2').datebox('enable');
         }
 });
     $("input[name=dlg_main_report_tt_radio]:radio").click(function() { // attack a click event on all radio buttons with name 'radiogroup'
         if($(this).val() == '1') {//check which radio button is clicked 
        
        	 $("#dlg_main_report_tt_cbdot").attr('disabled',false);
        	 $("#dlg_main_report_tt_cavu_nam").attr('disabled',true);
        	 $("#dlg_main_report_tt_cbvulua").attr('disabled',true);
        	 
         } else if($(this).val() == '2') {
        	 $("#dlg_main_report_tt_cbdot").attr('disabled',true);
        	$("#dlg_main_report_tt_cavu_nam").attr('disabled',false);
        	 $("#dlg_main_report_tt_cbvulua").attr('disabled',false);
                 //do something else
         }      
 });
 }
 /*function onclick_graph(){
		if (loadHtml("dlg_report_build_graph","./Dialogs/dothi.html",false, true)) return;
		 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_VULUA_TO_CBB,null, TYPE_DATA_HTML_CBB,"*", 'dlg_main_graph_cbvulua');
	
		cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_GIONGLUA_TO_CBB,null, TYPE_DATA_HTML_CBB,"*", 'dlg_main_graph_cbgionglua');
	//	cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_THIENTAI_TO_CBB,null, TYPE_DATA_HTML_CBB,"*", 'dlg_main_report_tt_cbthientai');
		
	
		 var cbbyear='';
		 for (var i =0; i >= -10; i--){			 
			 cbbyear += ('<option value=\'' + (parseInt(g_rtc.year)+i)+'\'>'+(parseInt(g_rtc.year)+i)+'</option>');
		 }
     	 var cbbmonth = ''; 
		 for (var i =1; i <= 12; i++)
			 cbbmonth += ('<option value=\'' + i + '\'>' + i+  '</option>');

		
		 $('#dlg_main_graph_cbnam1').html(cbbyear);
		 $("#dlg_main_graph_cbnam1").val(g_rtc.year);
		 $('#dlg_main_graph_cbnam2').html(cbbyear);
		 $("#dlg_main_graph_cbnam2").val(g_rtc.year);
			 
		 $('#dlg_main_graph_cbthang').html(cbbmonth);	 
		 $("#dlg_main_graph_cbthang").val(g_rtc.month);
	 }
 */
 function onclick_report_tt(){
	// if (loadHtml("dlg_report_query","./Dialogs/baocao.html",false, true)) return;
	 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_VULUA_TO_CBB,null, TYPE_DATA_HTML_CBB,"*", 'dlg_main_report_tt_cbvulua');
	 $('#dlg_main_report_tt_cbvulua').html($('#dlg_main_report_tt_cbvulua').html());
	 //cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_VULUA_TO_CBB,null, TYPE_DATA_HTML_CBB,"*", 'dlg_main_report_cavu_cbvulua');
	
	 var cbbyear = ''; 
	 for (var i =0; i >= -10; i--)
		 cbbyear += ('<option value=\'' + (parseInt(g_rtc.year) +i)+ '\'>'+(parseInt(g_rtc.year)+i)+'</option>');
	 var cbbmonth = ''; 
	 for (var i =0; i >= 12; i++)
		 cbbmonth += ('<option value=\'' + i + '\'>' + i+  '</option>');


	 $('#dlg_main_report_tt_nam').html(cbbyear);
	 $("#dlg_main_report_tt_nam").val(g_rtc.year);
	 
	 $('#dlg_main_report_tt_thang').html(cbbmonth);
	 $("#dlg_main_report_tt_thang").val(g_rtc.month);
	 
     $("input[name=dlg_main_report_tt_radio]:radio").click(function() { // attack a click event on all radio buttons with name 'radiogroup'
         if($(this).val() == '1') {//check which radio button is clicked 
        
        	 $("#dlg_main_report_tt_cbdot").attr('disabled',false);
        	 $("#dlg_main_report_tt_nam").attr('disabled',true);
        	 $("#dlg_main_report_tt_cbvulua").attr('disabled',true);
        	 
         } else if($(this).val() == '2') {
        	 $("#dlg_main_report_tt_cbdot").attr('disabled',true);
        	 $("#dlg_main_report_tt_nam").attr('disabled',false);
        	 $("#dlg_main_report_tt_cbvulua").attr('disabled',false);
                 //do something else
         }      
 });
 }
 function onclick_giaidoananh(){
	 g_fn_selected = FN_VIENTHAM ;
	 g_fn_editing_canhdong = false;
	 showPanel_createmap();
	 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_VULUA_TO_CBB,null, TYPE_DATA_HTML_CBB, "*", 'rs_htlua_cbbvulua');
	
	 var cbbyear = ''; 
	 var cbbyear_dongxuan = '';
	 for (var i =0; i >= -10; i--)
	 {
		cbbyear += ('<option value=\'' + (parseInt(g_rtc.year) +i+1)+ '\'>'+(parseInt(g_rtc.year)+i+1)+'</option>');
		cbbyear_dongxuan += ('<option value=\'' + (parseInt(g_rtc.year)+i)+ '\'>'+(parseInt(g_rtc.year)+i)+' - '+(parseInt(g_rtc.year)+i+1)+'</option>');

	 }
	 var cbbyear1_graph='';
	 for (var i =-10; i <= 0; i++)
		 cbbyear1_graph += ('<option value=\'' + (parseInt(g_rtc.year) +i)+ '\'>'+ (parseInt(g_rtc.year) +i)+'</option>');

	
	 //$('#rs_htlua_cbbnam').html(cbbyear);
	 //$('#rs_tongdtcacvu_cbbnam').html(cbbyear);
	 $('#rs_htlua_cbbnam').html(cbbyear_dongxuan);
	 $('#rs_tongdtcacvu_cbbnam').html(cbbyear);
	 $("#rs_htlua_cbbnam").val(g_rtc.year);
	 $("#rs_tongdtcacvu_cbbnam").val(g_rtc.year);
	 
	 var currTime=gm.date.getCurrentTime();
		$('#rs_graph_txtdate').val(currTime.day+"/"+currTime.month);
		$('#dlg_rs_graph_cbvu').html($('#rs_htlua_cbbvulua').html());// + ('<option value=\'' + 5+ '\'>'+ 'Cả năm' +'</option>'));	
		
	$('#dlg_rs_graph_cbnam1').html(cbbyear1_graph);
	$('#dlg_rs_graph_cbnam2').html(cbbyear);
	$("#dlg_rs_graph_cbnam1").val(g_rtc.year);
	$("#dlg_rs_graph_cbnam2").val(g_rtc.year);
	
	$("#rs_graph_button").hide();
		

	 gm.vientham.registerEvents();
	 $('#div_content_vientham').css({background:"rgb(0, 0, 0)"})
	 $('#div_content_vientham').corner();	
	 $('#div_content_vientham').css({background:"rgba(0, 0, 0, 0.30)",height:350})
	 
	 $('#div_chugiai_vientham').css({background:"rgb(0, 0, 0)"})
	 $('#div_chugiai_vientham').corner();	
	 $('#div_chugiai_vientham').css({background:"rgba(0, 0, 0, 0.30)",height:180})
	 $("#dlg_rs_txttenchutri").html('');
	 
 }
 /**
  * DU BAO
  *
  */
 function onclick_ppdubao_hamquanhe(){
	 g_fn_selected = FN_DUBAO_HQH;
	 DialogShow('dubao/theoThoigian.html', 650, 550,'dubao1');
 }
 function onclick_ppdubao_hechuyengia(){
	 g_fn_selected = FN_DUBAO_HCG;
	 DialogShow('dubao/hechuyengia.html', 650, 550,'dubao2');
 }
  function onclick_ppdubao_vientham(){
	 g_fn_selected = FN_DUBAO_VT;
	 g_fn_editing_canhdong = false;
	 showPanel_createmap();
	 
	// cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_VULUA_TO_CBB,null, TYPE_DATA_HTML_CBB, null, 'rs_htlua_cbbvulua');
	 showDuBao();
	 gm.dubao.registerEvents();
	

	 $('#div_content_dubao').css({background:"rgb(0, 0, 0)"})
	 $('#div_content_dubao').corner();	
	 $('#div_content_dubao').css({background:"rgba(0, 0, 0, 0.30)",height:200})
	 

	 //$("#dlg_rs_txttenchutri").html('');
		
 }
 /**
  * HIEN TRANG RENDER 
  */
 function onclick_bandohientrang_ccgl(){
	 g_fn_selected = FN_MAP_HIENTRANG_CCGL;
	 g_fn_editing_canhdong = false;
	 showPanel_createmap();
	 onclick_createmap(g_fn_selected);
	 //loadHtml("dlg_report_bandohientrang_query","./Dialogs/bando_hientrang.html");
	 
	 setTimeout("createTimer1()",/*TIMER_DELAY +*/ 500);
	 cwrs_debug('click bản đồ hiện trạng cơ cấu lúa');
	 deactivate_dieutra_canhdong();
	 openExtruder('hientrang_extruder');
	 setCurrentMenu('chientrang');
	
 }
 function createTimer1(){
	 //alert(1);
	 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_TINH_TO_CBB,null, TYPE_DATA_HTML_CBB,"Tỉnh/Thành", 'dlg_main_hientrang_cbtinh');
	 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_TINH_TO_CBB,null, TYPE_DATA_HTML_CBB,"Tỉnh/Thành", 'dlg_main_hientrang_thientai_cbtinh');
	 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_THIENTAI_TO_CBB,null, TYPE_DATA_HTML_CBB,"*", 'dlg_main_hientrang_thientai_cbthientai');
	// cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_TINH_TO_CBB,null, TYPE_DATA_HTML_CBB,"Tỉnh/Thành", 'dlg_main_hientrang_cbdichhai');
	// cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_DOT_THIENTAI_TO_CBB,null, TYPE_DATA_HTML_CBB,"*", 'dlg_main_hientrang_thientai_cbdot');
     cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_SAUHAI_TO_CBB, null,TYPE_DATA_HTML_CBB,'Danh sách sâu hại', 'dlg_main_hientrang_cbdichhai','0o','-');
	 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_BENHHAI_TO_CBB, null,TYPE_DATA_HTML_CBB,'Danh sách bệnh hại', 'dlg_main_hientrang_cbdichhai','1o','-',true);
	 var cbbyear = ''; 
	 for (var i =0; i >= -10; i--)
		 cbbyear += ('<option value=\'' + (parseInt(g_rtc.year) +i)+ '\'>'+(parseInt(g_rtc.year)+i)+'</option>');
	 var cbbmonth = ''; 
	 for (var i =1; i <= 12; i++)
		 cbbmonth += ('<option value=\'' + i + '\'>' + i+  '</option>');

	 var cbbgionglua = ''; 
	 for (var i =1; i <= 10; i++)
		 cbbgionglua += ('<option value=\'' + i + '\'>' + i+  '</option>');
	 

	 $('#dlg_main_hientrang_htl_nam').html(cbbyear);
	 $("#dlg_main_hientrang_htl_nam").val(g_rtc.year);
	 
	 $('#dlg_main_hientrang_thientai_cbnam').html(cbbyear);
	 $("#dlg_main_hientrang_thientai_cbnam").val(g_rtc.year);
	 
	 $('#dlg_main_hientrang_htl_thang').html(cbbmonth);	 
	 $("#dlg_main_hientrang_htl_thang").val(g_rtc.month);
	 
	   $("input[name=dlg_main_hientrang_thientai_radio]:radio").click(function() { // attack a click event on all radio buttons with name 'radiogroup'
	         if($(this).val() == '1') {//check which radio button is clicked 
	       // alert(2);
	        	 $('#dlg_main_hientrang_thientai_textboxdate').datebox('disable');
	        	 $("#dlg_main_hientrang_thientai_cbdot").attr('disabled',false);
	         } else if($(this).val() == '2') { 	 
	        	 $('#dlg_main_hientrang_thientai_textboxdate').datebox('enable');
	        	 $("#dlg_main_hientrang_thientai_cbdot").attr('disabled',true);
	        	
	                 //do something else
	         } 
	     
	       
	 });
	 
 }
 function onclick_bandohientrang_nuoc(){
	 g_fn_selected = FN_MAP_HIENTRANG_NUOC;
	 g_fn_editing_canhdong = false;
	 layer_ruong_hientrang.setVisibility(false);
	 showPanel_createmap();
	 showPanel_createchugiai();
	 //loadHtml("dlg_report_bandohientrang_query","./Dialogs/bando_hientrang.html",false);
	 onclick_createmap(g_fn_selected);	 
	 setTimeout("createTimer1()",/*TIMER_DELAY +*/ 500);
	 cwrs_debug('click bản đồ hiện trạng nước');
	 deactivate_dieutra_canhdong();
	 openExtruder('hientrang_extruder');
	 setCurrentMenu('chientrang');
 }
 function onclick_bandohientrang_htlua(){
	 g_fn_selected = FN_MAP_HIENTRANG_HTL;
	 g_fn_editing_canhdong = false;
	 layer_ruong_hientrang.setVisibility(false);
	 showPanel_createmap();
	 showPanel_createchugiai();
	// loadHtml("dlg_report_bandohientrang_query","./Dialogs/bando_hientrang.html",false);
	 onclick_createmap(g_fn_selected); 
	 setTimeout("createTimer1()",/*TIMER_DELAY +*/ 500);
	 cwrs_debug('click bản đồ hiện trạng lúa');
	 deactivate_dieutra_canhdong();
	 openExtruder('hientrang_extruder');
	 setCurrentMenu('chientrang');
 }
 function onclick_bandohientrang_dichhai(){
	 g_fn_selected = FN_MAP_HIENTRANG_DICHHAI;
	 g_fn_editing_canhdong = false;
	 layer_ruong_hientrang.setVisibility(false);
	 showPanel_createmap();
	 showPanel_createchugiai();
	// loadHtml("dlg_report_bandohientrang_query","./Dialogs/bando_hientrang_dichhai.html",false);
	 onclick_createmap(g_fn_selected);
	 setTimeout("createTimer1()",/*TIMER_DELAY +*/ 500);
	 cwrs_debug('click bản đồ hiện trạng dịch hại');
	 deactivate_dieutra_canhdong();
	 openExtruder('hientrang_extruder');
	 setCurrentMenu('chientrang');
 }
 function onclick_bandohientrang_thientai(){
	 //msginfo("Chức năng đang được sửa chữa...");return;
	 g_fn_selected = FN_MAP_HIENTRANG_THIENTAI;
	 g_fn_editing_canhdong = false;
	 layer_ruong_hientrang.setVisibility(false);
	 showPanel_createmap();
	 showPanel_createchugiai();
	 //loadHtml("dlg_report_bandohientrang_query","./Dialogs/bando_hientrang_thientai.html",false);
	 onclick_createmap(g_fn_selected);
	 setTimeout("createTimer1()",/*TIMER_DELAY +*/ 500);
	 cwrs_debug('click bản đồ hiện trạng thiên tai');
	 deactivate_dieutra_canhdong();
	 openExtruder('hientrang_extruder');
	 setCurrentMenu('chientrang');
 }
 function onclick_bandohientrang_nangsuat(){
	 g_fn_selected = FN_MAP_HIENTRANG_NANGSUAT;
	 g_fn_editing_canhdong = false;
	 layer_ruong_hientrang.setVisibility(false);
	 showPanel_createmap();
	 showPanel_createchugiai();
	 //loadHtml("dlg_report_bandohientrang_query","./Dialogs/bando_hientrang.html",false);
	 onclick_createmap(g_fn_selected);
	 setTimeout("createTimer1()",/*TIMER_DELAY +*/ 500);
	 cwrs_debug('click bản đồ hiện trạng năng suất');
	 deactivate_dieutra_canhdong();
	 openExtruder('hientrang_extruder');
	 setCurrentMenu('chientrang');
 } 
 
 
 /**
  * Tạo báo cáo và hiển thị trên trình duyệt
  * @param fn
  * 		Kiểu thông tin báo cáo: thông tin thiên tai, cơ cấu giống lúa hoặc hiện trạng lúa
  * @param position
  * 	   Vị trí lưu ở dạng WKT(well-known text) của địa phương khi click trên bản đồ.
  * 	   Từ vị trí này sẽ xác định được địa phương (tỉnh,huyện,xã) nào đang được chọn để tạo báo cáo. 
 
  */
 
 function createReport(fn, posWKT){ 
	 var typeReport = null;
	 var strTimeReport;
	 var time_int0 = 0;//int from 01/01/xxxx only used for tdsx
	 var time_int1=0;
	 var time_int2=0; 
	 var vulua =0;
	 var dot = 0;
	 var thientaiid = 0;
	 var option =3;
	 var msgErrors="Không có dữ liệu";

	 //getLanhthoClicked( 'tbl_xa_region','xa_id',posWKT);
	 gm.map.onClick(posWKT);
	 if (fn == FN_BAOCAO_HIENTRANGLUA){
		 typeReport = REPORT_TYPE_HTL;
		 var strYear = getCbbValue("dlg_main_report_htl_nam");
		 var strMonth = getCbbValue("dlg_main_report_htl_thang");
		 
		 var radioSelected = $('input:radio[name=dlg_main_report_htl_radio]:checked').val(); 
			if (radioSelected == 1){
			//	option =1;	
				var jsdate1 = gm.date.stringToJSONDate('01/'+strMonth+'/'+strYear);
				time_int1 = jsdate1.cti;
				time_int2 = time_int1 + 13;
			//	time_int2 = time_int1 + parseInt(getDaysInMonth(strMonth, strYear))-1;
				strTimeReport = "Thời gian: đầu tháng " +strMonth +" năm "+strYear;	
			} else if (radioSelected == 2){
				//option =2;
				var jsdate1 = gm.date.stringToJSONDate('15/'+strMonth+'/'+strYear);
				var jsdate2 = gm.date.stringToJSONDate(gm.date.getDaysInMonth(strMonth, strYear)+'/' +strMonth+'/'+strYear);
				time_int1 = jsdate1.cti;
				time_int2 = jsdate2.cti;
				
				//time_int2 = time_int1 + parseInt(getDaysInMonth(strMonth, strYear))-1;
				strTimeReport = "Thời gian: cuối tháng " +strMonth +" năm "+strYear;	

			} 
			else {
				msginfo('Bạn hãy chọn khoảng thời gian báo cáo trong mục tùy chọn bên trái.');
				return;
			}
		// cwrs_debug("strYear = "+strYear);
		// cwrs_debug("strMonth = "+strMonth);

		//	cwrs_debug("time_int1 = "+time_int1);
		//	cwrs_debug("time_int2 = "+time_int2);
		//	var jsdate2 = stringToJSONDate(strDate2);
	 }
	 else if (fn == FN_BAOCAO_TIENDOSANXUAT){
		 typeReport = REPORT_TYPE_TDSX;
		 vulua = getCbbValue("dlg_main_report_tdsx_cbvulua");
			if(vulua <0){msginfo('Hãy chọn vụ lúa');return;}
			var strDate1 = $('#dlg_main_report_tdsx_datebox1').datebox('getValue');
			var strDate2 = $('#dlg_main_report_tdsx_datebox2').datebox('getValue');

			if (!Utils.isValidateDMY(strDate1)){msginfo('Hãy chọn thời gian bắt đầu để tạo báo cáo');return;}
			if (!Utils.isValidateDMY(strDate2)){msginfo('Hãy chọn thời gian kết thúc để tạo báo cáo');return;}

			var jsdate1 = gm.date.stringToJSONDate(strDate1);
			var jsdate2 = gm.date.stringToJSONDate(strDate2);
			time_int2 = jsdate2.cti;
			time_int1 = jsdate1.cti;
			
			time_int0 = jsdate1.sti-90;
			
				

			
			if (time_int1>=time_int2){msgerror('Thời gian bắt đầu phải trước thời gian kết thúc');return;}

			cwrs_debug("time_int1 = "+time_int1);
			strTimeReport = "Thời gian: Vụ " +getCbbText("dlg_main_report_tdsx_cbvulua");	
			//mau bao cao
			option = -1;
			var radioSelected = $('input:radio[name=dlg_main_report_tdsx_radio]:checked').val(); 
			if(radioSelected == 1) option=1;
			else if(radioSelected == 2) option=2;
			else {
				msginfo("Hãy chọn mẫu báo cáo.");
				return;
			}
			//Tỉnh:.........................................Kỳ báo cáo từ ngày......đến ngày............. .....................vụ...................................................
			//strTimeReport = "Tỉnh: Đầu vụ " +getCbbText("dlg_main_report_vu2ngay_cbvulua") + " đến " + strDate;

			
		 
	 }
	 else if (fn == FN_BAOCAO_THONGTINDICHHAI){
		 typeReport = REPORT_TYPE_TTDH;
			var strDate = $('#dlg_main_report_ttdh_datebox').datebox('getValue');
			//var strDate2 = $('#dlg_main_report_ttdh_datebox2').datebox('getValue');
			if (!Utils.isValidateDMY(strDate)){msginfo('Hãy chọn thời gian bắt đầu để tạo báo cáo');return;}
			//	if (!Utils.isValidateDMY(strDate2)){msginfo('Hãy chọn thời gian kết thúc để tạo báo cáo');return;}
			var jsdate = gm.date.stringToJSONDate(strDate);
		//	alert(jsdate);
			
			 var radioSelected = $('input:radio[name=dlg_main_report_ttdh_radio]:checked').val(); 
				if (radioSelected == 1){
				//	option =1;	
					time_int2 = jsdate.cti;
			
					time_int1 = time_int2 - 7;
					
				//	time_int2 = time_int1 + parseInt(getDaysInMonth(strMonth, strYear))-1;
					strTimeReport = "Thời gian: từ ngày " +gm.date.Int2DateString(time_int1) +" đến "+gm.date.Int2DateString(time_int2);	
					
				} else if (radioSelected == 2){
					//option =2;
					time_int2 = jsdate.cti;
					time_int1 = time_int2 - 30;					
					//time_int2 = time_int1 + parseInt(getDaysInMonth(strMonth, strYear))-1;
					strTimeReport = "Thời gian: từ ngày " +gm.date.Int2DateString(time_int1) +" đến "+gm.date.Int2DateString(time_int2);

				} 
				else {
					msginfo('Bạn hãy chọn khoảng thời gian báo cáo trong mục tùy chọn bên trái.');
					return;
				}			
		//	strTimeReport = "Thời gian: Từ  " + strDate1 +" đến " + strDate2;
		 
	 }
	 else if (fn == FN_BAOCAO_COCAUGIONGLUA){
		 msgErrors='Không tạo được báo cáo:'+'<br>'+'- Không có dữ liệu' ;
		 typeReport = REPORT_TYPE_CCGL;
		 var radioSelected = $('input:radio[name=dlg_main_report_radio]:checked').val(); 
			if (radioSelected == 1){
				vulua = 0;
				option =1;
				var strDate = $('#dlg_main_report_taingay_datebox').datebox('getValue');
				if (!Utils.isValidateDMY(strDate)){msgerror('Hãy chọn thời gian để tạo báo cáo');return;}
				time_int1 = gm.date.stringDate2Int(strDate);
				strTimeReport = "Thời gian: " + strDate;
			} else if (radioSelected == 2){
				option =2;
				vulua = getCbbValue("dlg_main_report_vu2ngay_cbvulua");
				if(vulua <0){msgerror('Hãy chọn vụ lúa');return;}
				var strDate = $('#dlg_main_report_vu2ngay_datebox').datebox('getValue');
				if (!Utils.isValidateDMY(strDate)){msgerror('Hãy chọn thời gian để tạo báo cáo');return;}
				
				var jsdate = gm.date.stringToJSONDate(strDate);
				if (vulua == 1){//dongxuan
					if (jsdate.month <= 6){
						// get max ngay gieo cay t10->t5 nam sau
						time_int1 = jsdate.sti -180;
						var jsdate2 = gm.date.stringToJSONDate("01/05/"+jsdate.year);
						time_int2 = jsdate2.cti;
					//	time_int2 =getMaxDateNgaygieocay(time_int1,time_int2,vulua)+120;						
						var ngaythuhoach_cuoicung =getMaxDateNgaygieocay(time_int1,time_int2,vulua)+120;
						if (jsdate.cti <= ngaythuhoach_cuoicung){
							time_int2 = jsdate.cti;
						} else {
							time_int1 =999999;
						}
						
						
					} else {
				   
						var jsdate1 = gm.date.stringToJSONDate("01/06/"+jsdate.year);
						time_int1 = jsdate1.cti;
						time_int2 = jsdate.cti;
						
						//time_int2 =getMaxDateNgaygieocay(time_int1,time_int2,vulua)+120;
					}
				} else {//hethu,mua,thudong
					time_int1 = jsdate.sti;
					time_int2 = jsdate.eti;
					//tinh ngay thu hoach cuoi cung
					var ngaythuhoach_cuoicung =getMaxDateNgaygieocay(time_int1,time_int2,vulua)+120;
					if (jsdate.cti <= ngaythuhoach_cuoicung){
						time_int2 = jsdate.cti;
					} else {
						time_int1 =999999;
					}
				}
				
				cwrs_debug("time_int1 = "+time_int1);
				strTimeReport = "Thời gian: Đầu vụ " +getCbbText("dlg_main_report_vu2ngay_cbvulua") + " đến " + strDate;
				

			} else if (radioSelected == 3){ 
				option =3;
				vulua = getCbbValue("dlg_main_report_cavu_cbvulua");
				
				var nam = getCbbValue("dlg_main_report_cavu_nam");
				if(vulua <0){msgerror('Hãy chọn vụ lúa');return;}
				
				if(vulua ==1){//dong xuan 
					var arrtime = nam.split("-");
					var t1 = arrtime[0];
					var t2   = arrtime[1];
					
					var strDate1 = '01/10/'+t1;
					var strDate2 = '01/05/'+t2;

					//if (!Utils.isValidateDMY(strDate)){msgerror('Hãy chọn thời gian để tạo báo cáo');return;}
					var jsdate1 = gm.date.stringToJSONDate(strDate1);
					var jsdate2 = gm.date.stringToJSONDate(strDate2);
					time_int2 = jsdate2.cti;
					time_int1 = jsdate1.cti;
					cwrs_debug("time_int1 = "+time_int1);
					strTimeReport = "Thời gian: Vụ " +getCbbText("dlg_main_report_cavu_cbvulua") +' năm '+nam;
					
				} else {
				
					var strDate = '01/01/'+getCbbValue("dlg_main_report_cavu_nam");

					if (!Utils.isValidateDMY(strDate)){msgerror('Hãy chọn thời gian để tạo báo cáo');return;}
					var jsdate = gm.date.stringToJSONDate(strDate);
					time_int2 = jsdate.eti;
					time_int1 = jsdate.sti;
					cwrs_debug("time_int1 = "+time_int1);
					strTimeReport = "Thời gian: Vụ " +getCbbText("dlg_main_report_cavu_cbvulua") +' năm '+nam;			
				}
			} else if (radioSelected == 4){
				option =4;
				vulua = getCbbValue("dlg_main_report_tiendo_cbvulua");
				if(vulua <0){msgerror('Hãy chọn vụ lúa');return;}
				var strDate1 = $('#dlg_main_report_tiendo_datebox1').datebox('getValue');
				var strDate2 = $('#dlg_main_report_tiendo_datebox2').datebox('getValue');
				
				if (!Utils.isValidateDMY(strDate1)){msgerror('Hãy chọn thời gian bắt đầu để tạo báo cáo');return;}
				if (!Utils.isValidateDMY(strDate2)){msgerror('Hãy chọn thời gian kết thúc để tạo báo cáo');return;}	
				var jsdate1 = gm.date.stringToJSONDate(strDate1);
				var jsdate2 = gm.date.stringToJSONDate(strDate2);
				time_int2 = jsdate2.cti;
				time_int1 = jsdate1.cti;
				
				if (time_int1 > time_int2){msgerror('Ngày kết thúc phải lớn hơn ngày bắt đầu');return;}
				cwrs_debug("time_int1 = "+time_int1);
				strTimeReport = "Thời gian: Vụ " +getCbbText("dlg_main_report_tiendo_cbvulua");				
			 			
			} 
			else {
				msginfo('Bạn hãy chọn hình thức báo cáo trong mục tùy chọn bên trái.');
				return;
			}
	 }
	 else if (fn == FN_BAOCAO_TIENDOTHUHOACH){
		 typeReport = REPORT_TYPE_TDTH;
		 var radioSelected = $('input:radio[name=dlg_main_report_radio]:checked').val(); 
			if (radioSelected == 1){
				vulua = 0;
				option =1;
				var strDate = $('#dlg_main_report_taingay_datebox').datebox('getValue');
				if (!Utils.isValidateDMY(strDate)){msgerror('Hãy chọn thời gian để tạo báo cáo');return;}
				time_int1 = gm.date.stringDate2Int(strDate);
				strTimeReport = "Thời gian: " + strDate;
			} else if (radioSelected == 2){
				option =2;
				vulua = getCbbValue("dlg_main_report_vu2ngay_cbvulua");
				if(vulua <0){msgerror('Hãy chọn vụ lúa');return;}
				var strDate = $('#dlg_main_report_vu2ngay_datebox').datebox('getValue');
				if (!Utils.isValidateDMY(strDate)){msgerror('Hãy chọn thời gian để tạo báo cáo');return;}
				
				var jsdate = gm.date.stringToJSONDate(strDate);
				if (vulua == 1){//dongxuan
					if (jsdate.month <= 6){
						// get max ngay gieo cay t10->t5 nam sau
						
						
						
						time_int1 = jsdate.sti-180;
						var jsdate2 = gm.date.stringToJSONDate("01/06/"+jsdate.year);
						time_int2 = jsdate2.cti;
					//	time_int2 =getMaxDateNgaygieocay(time_int1,time_int2,vulua)+120;
						
						var ngaythuhoach_cuoicung =getMaxDateNgaygieocay(time_int1,time_int2,vulua)+120;
						if (jsdate.cti <= ngaythuhoach_cuoicung){
							time_int2 = jsdate.cti;
						} else {
							time_int1 =999999;
						}
						
						
					} else {
				   
						var jsdate1 = gm.date.stringToJSONDate("01/06/"+jsdate.year);
						time_int1 = jsdate1.cti;
						time_int2 = jsdate.cti;
						
						//time_int2 =getMaxDateNgaygieocay(time_int1,time_int2,vulua)+120;
					}
				} else {//hethu,mua,thudong
					time_int1 = jsdate.sti;
					time_int2 = jsdate.eti;
					//tinh ngay thu hoach cuoi cung
					var ngaythuhoach_cuoicung =getMaxDateNgaygieocay(time_int1,time_int2,vulua)+120;
					if (jsdate.cti <= ngaythuhoach_cuoicung){
						time_int2 = jsdate.cti;
					} else {
						time_int1 =999999;
					}
				}
				
				cwrs_debug("time_int1 = "+time_int1);
				strTimeReport = "Thời gian: Đầu vụ " +getCbbText("dlg_main_report_vu2ngay_cbvulua") + " đến " + strDate;
				

				/* option =2;
				vulua = getCbbValue("dlg_main_report_vu2ngay_cbvulua");
				if(vulua <0){msgerror('Hãy chọn vụ lúa');return;}
				var strDate = $('#dlg_main_report_vu2ngay_datebox').datebox('getValue');
				if (!Utils.isValidateDMY(strDate)){msgerror('Hãy chọn thời gian để tạo báo cáo');return;}
				
				var jsdate = stringToJSONDate(strDate);
				time_int2 = jsdate.cti;

				time_int1 = jsdate.sti -180;
				cwrs_debug("time_int1 = "+time_int1);
				strTimeReport = "Thời gian: Đầu vụ " +getCbbText("dlg_main_report_vu2ngay_cbvulua") + " đến " + strDate;
				
*/
			} else if (radioSelected == 3){
				option =3;
				vulua = getCbbValue("dlg_main_report_cavu_cbvulua");
				
				nam = getCbbValue("dlg_main_report_cavu_nam");
				if(vulua <0){msgerror('Hãy chọn vụ lúa');return;}
				
				if(vulua ==1){//dong xuan 
					var arrtime = nam.split("-");
					var t1 = arrtime[0];
					var t2   = arrtime[1];
					
					var strDate1 = '01/10/'+t1;
					var strDate2 = '01/05/'+t2;

					//if (!Utils.isValidateDMY(strDate)){msgerror('Hãy chọn thời gian để tạo báo cáo');return;}
					var jsdate1 = gm.date.stringToJSONDate(strDate1);
					var jsdate2 = gm.date.stringToJSONDate(strDate2);
					time_int2 = jsdate2.cti;
					time_int1 = jsdate1.cti;
					cwrs_debug("time_int1 = "+time_int1);
					strTimeReport = "Thời gian: Vụ " +getCbbText("dlg_main_report_cavu_cbvulua") +' năm '+nam;
					
				} else {
				
					var strDate = '01/01/'+getCbbValue("dlg_main_report_cavu_nam");

					if (!Utils.isValidateDMY(strDate)){msgerror('Hãy chọn thời gian để tạo báo cáo');return;}
					var jsdate = gm.date.stringToJSONDate(strDate);
					time_int2 = jsdate.eti;
					time_int1 = jsdate.sti;
					cwrs_debug("time_int1 = "+time_int1);
					strTimeReport = "Thời gian: Vụ " +getCbbText("dlg_main_report_cavu_cbvulua") +' năm '+nam;			
				}
			
				/*
				option =3;
				vulua = getCbbValue("dlg_main_report_cavu_cbvulua");
				nam = getCbbValue("dlg_main_report_cavu_nam");
				if(vulua <0){msgerror('Hãy chọn vụ lúa');return;}
				var strDate = '01/01/'+getCbbValue("dlg_main_report_cavu_nam");

				if (!Utils.isValidateDMY(strDate)){msgerror('Hãy chọn thời gian để tạo báo cáo');return;}
				var jsdate = stringToJSONDate(strDate);
				time_int2 = jsdate.eti;
				time_int1 = jsdate.sti-180;
				cwrs_debug("time_int1 = "+time_int1);
				strTimeReport = "Thời gian: Vụ " +getCbbText("dlg_main_report_cavu_cbvulua");
				*/				
			} else if (radioSelected == 4){
				option =4;
				vulua = getCbbValue("dlg_main_report_tiendo_cbvulua");
				if(vulua <0){msgerror('Hãy chọn vụ lúa');return;}
				var strDate1 = $('#dlg_main_report_tiendo_datebox1').datebox('getValue');
				var strDate2 = $('#dlg_main_report_tiendo_datebox2').datebox('getValue');
				
				if (!Utils.isValidateDMY(strDate1)){msgerror('Hãy chọn thời gian bắt đầu để tạo báo cáo');return;}
				if (!Utils.isValidateDMY(strDate2)){msgerror('Hãy chọn thời gian kết thúc để tạo báo cáo');return;}	
				var jsdate1 = gm.date.stringToJSONDate(strDate1);
				var jsdate2 = gm.date.stringToJSONDate(strDate2);
				time_int2 = jsdate2.cti;
				time_int1 = jsdate1.cti;
				
				if (time_int1 > time_int2){msgerror('Ngày kết thúc phải lớn hơn ngày bắt đầu');return;}
				cwrs_debug("time_int1 = "+time_int1);
				strTimeReport = "Thời gian: Vụ " +getCbbText("dlg_main_report_tiendo_cbvulua");				
			 			
			} 
			else {
				msginfo('Bạn hãy chọn hình thức báo cáo trong mục tùy chọn bên trái.');
				return;
			}
	 }
	else if (fn == FN_BAOCAO_THONGTINTHIENTAI){
		 typeReport = REPORT_TYPE_TTTT;	
		 
		 thientaiid = getCbbValue("dlg_main_report_tt_cbthientai");
		// alert(thientaiid);
			if(thientaiid <0){msgerror('Hãy chọn loại thiên tai');return;}
		// return;
		var radioSelected_tt = $('input:radio[name=dlg_main_report_tt_radio]:checked').val(); 
			if (radioSelected_tt == 1){		
				option =1;
				vulua=0;
		
				dot = getCbbValue("dlg_main_report_tt_cbdot");
				if(dot <0){msgerror('Hãy chọn đợt thiên tai');return;}

				strTimeReport = "Thời gian:" +getCbbText("dlg_main_report_tt_cbdot");
			} else if (radioSelected_tt == 2){
				option =2;
				dot=0;
				vulua = getCbbValue("dlg_main_report_tt_cbvulua");
				if(vulua <0){msgerror('Hãy chọn vụ lúa');return;}
				if (vulua==1){//dong xuan
					var nam = getCbbValue("dlg_main_report_tt_cavu_nam");
					var arrtime = nam.split("-");
						var t1 = arrtime[0];
						var t2   = arrtime[1];
						
						var strDate1 = '01/10/'+t1;
						var strDate2 = '01/05/'+t2;

						//if (!Utils.isValidateDMY(strDate)){msgerror('Hãy chọn thời gian để tạo báo cáo');return;}
					
						var jsdate1 = gm.date.stringToJSONDate(strDate1);
						var jsdate2 = gm.date.stringToJSONDate(strDate2);
						time_int2 = jsdate2.cti;
						time_int1 = jsdate1.cti;
						cwrs_debug("time_int1 = "+time_int1);
						strTimeReport = "Thời gian: Vụ " +getCbbText("dlg_main_report_tt_cbvulua") +' năm '+nam;
				}else {
					var strDate = '01/01/'+getCbbValue("dlg_main_report_tt_cavu_nam");

					if (!Utils.isValidateDMY(strDate)){msgerror('Hãy chọn thời gian để tạo báo cáo');return;}
					var jsdate = gm.date.stringToJSONDate(strDate);
					time_int2 = jsdate.eti;
					time_int1 = jsdate.sti;
					cwrs_debug("time_int1 = "+time_int1);
					strTimeReport = "Thời gian: Vụ " +getCbbText("dlg_main_report_tt_cbvulua")+ " năm " + getCbbValue("dlg_main_report_tt_cavu_nam");
				}
				
			} else {
				msginfo('Bạn hãy chọn hình thức báo cáo trong mục tùy chọn bên trái.');
				return;
			}
	 }	
	 var page_type = $('input:radio[name=dlg_main_report_radio_trang]:checked').val();
	/*if (page_type == 1){
		REPORT_PAGE_A4_LANDSCAPE
	}*/
	//alert(page_type)
	 //hiden controls
	 g_controlPanel.hideControl(g_btnEditCanhdong);
     g_controlPanel.hideControl(g_btnSelectDeature);
    // g_fn_selected = FN_BAOCAO_HIENTRANGLUA;
	
	var table = '';
	var id = '';

	if (layer_xa.getVisibility()){
		table = 'tbl_xa_region';
		id = 'xa_id';
	} else if (layer_huyen.getVisibility()) {
		table = 'tbl_huyen_region';
		id = 'huyen_id';
	} else {
		table = 'tbl_tinh_region';
		id = 'tinh_id';	
	}
	cwrs_debug(vulua+','+time_int1+','+time_int2);
	 var isCreatedReport = false;
	 var exportPath = '';
	 $.ajax({
				url: REPORT_SERVLET ,
				type: "POST",
				data:
			    { 
				  action: ACT_GEN_REPORT,
				  type: typeReport,
				  position: posWKT,
				  table:table,
				  id:id,
				  option:option,
				  vulua:vulua,
				  dotid:dot, //dot thien tai (used only for thientai report)
				  thientaiid: thientaiid,
				  time0:time_int0,
				  time1:time_int1,
				  time2:time_int2,
				  timereport2show: strTimeReport,
				  pageorient: page_type 
				},
				 async:false,

				 success:function(data) {

					 
						//window.open(url,"Download");
					 //alert('Create report:'+data);
					 if (data != "" && data != "null"){
					  isCreatedReport = true;
					  exportPath = data;
					 }
					
					return data; 
			    }});
		if (isCreatedReport == true){
			
			  /*$.colorbox({href:  exportPath+".html",
			        iframe: true,
			       /* inline: false,
			        html: false,*/
			  //      iframe: true,
			  //      fastIframe: false,
			       /* photo: false,
			        href: false,
			        title: false,
			        rel: false,
			         
			        transition:'fade',
			        width:  '80%', 
			        height: '90%'});*/
			  var url = exportPath+".html";
				window.open(url,"Download");
		} else {
			msgalert('Thông báo',msgErrors,'warning');
			// msgalert('Thông báo','Không tạo được báo cáo:'+'<br>'+'- Không có dữ liệu' +'<br>- Vụ lúa này đã được thu hoạch hết<br>','warning');
			// msgalert('Thông báo','Xảy ra lỗi trong khi tạo báo cáo (không có dữ liệu hoặc dữ liệu không hợp lệ)','warning');

		}
	 
 }
 function createReportThientai(){
     
	 var typeReport = null;
	 var strTimeReport;
	 var time_int0 = 0;//int from 01/01/xxxx only used for tdsx
	 var time_int1=0;
	 var time_int2=0; 
	 var vulua =0;
	 var dot = 0;
	 var thientaiid = 0;
	 var option =3;
	 var msgErrors="";
	 var page_type = $('input:radio[name=dlg_main_report_radio_trang]:checked').val();

	 typeReport = REPORT_TYPE_TTTT;
	 var table = '';
	 var id = '';

	 if (layer_xa.getVisibility()){
			table = 'tbl_xa_region';
			id = 'xa_id';
		} else if (layer_huyen.getVisibility()) {
			table = 'tbl_huyen_region';
			id = 'huyen_id';
		} else {
			table = 'tbl_tinh_region';
			id = 'tinh_id';	
		}
	 var radioSelected_tt = $('input:radio[name=dlg_main_report_tt_radio]:checked').val(); 
		if (radioSelected_tt == 1){		
			option =1;
			vulua=0;
			dot = getCbbValue("dlg_main_report_tt_cbdot");
			if(dot <0){msgerror('Hãy chọn đợt thiên tai');return;}

			strTimeReport = "Thời gian:" +getCbbText("dlg_main_report_tt_cbdot");
		} else if (radioSelected_tt == 2){
			option =2;
			dot=0;
			vulua = getCbbValue("dlg_main_report_tt_cbvulua");
			if(vulua <0){msgerror('Hãy chọn vụ lúa');return;}
			if (vulua==1){//dong xuan
				var nam = getCbbValue("dlg_main_report_tt_cavu_nam");
				var arrtime = nam.split("-");
					var t1 = arrtime[0];
					var t2 = arrtime[1];
					
					var strDate1 = '01/10/'+t1;
					var strDate2 = '01/05/'+t2;

					//if (!Utils.isValidateDMY(strDate)){msgerror('Hãy chọn thời gian để tạo báo cáo');return;}
					var jsdate1 = gm.date.stringToJSONDate(strDate1);
					var jsdate2 = gm.date.stringToJSONDate(strDate2);
					time_int2 = jsdate2.cti;
					time_int1 = jsdate1.cti;
					cwrs_debug("time_int1 = "+time_int1);
					strTimeReport = "Thời gian: Vụ " +getCbbText("dlg_main_report_tt_cbvulua") +' năm '+nam;
			}else {
				var strDate = '01/01/'+getCbbValue("dlg_main_report_tt_cavu_nam");

				if (!Utils.isValidateDMY(strDate)){msgerror('Hãy chọn thời gian để tạo báo cáo');return;}
				var jsdate = gm.date.stringToJSONDate(strDate);
				time_int2 = jsdate.eti;
				time_int1 = jsdate.sti;
				cwrs_debug("time_int1 = "+time_int1);
				strTimeReport = "Thời gian: Vụ " +getCbbText("dlg_main_report_tt_cbvulua")+ " năm " + getCbbValue("dlg_main_report_tt_cavu_nam");
			}
			
		} else {
			msginfo('Bạn hãy chọn hình thức báo cáo trong mục tùy chọn bên trái.');
			return;
		}
		 var page_type = $('input:radio[name=dlg_main_report_radio_trang]:checked').val();			
		//alert(g_lanhtho_selected.poswkt)
		 var isCreatedReport = false;
		 var exportPath = '';
		 $.ajax({
					url: REPORT_SERVLET ,
					type: "POST",
					data:
				    { 
					  action: ACT_GEN_REPORT,
					  type: typeReport,
					  position: g_lanhtho_selected.poswkt,
					  table:table,
					  id:id,
					  option:option,
					  vulua:vulua,
					  thientaiid:thientaiid,
					  dotid:dot, //dot thien tai (used only for thientai report)
					  time0:time_int0,
					  time1:time_int1,
					  time2:time_int2,
					  timereport2show: strTimeReport,
					  pageorient: page_type 
					},
					 async:false,

					 success:function(data) {

						 
							//window.open(url,"Download");
						 //alert('Create report:'+data);
						 if (data != "" && data != "null"){
						  isCreatedReport = true;
						  exportPath = data;
						 }
						
						return data; 
				    }});
			if (isCreatedReport == true){
				
				  $.colorbox({href:  exportPath+".html",
				        iframe: true,
				       /* inline: false,
				        html: false,*/
				        iframe: true,
				        fastIframe: false,
				       /* photo: false,
				        href: false,
				        title: false,
				        rel: false,*/
				         
				        transition:'fade',
				        width:  '80%', 
				        height: '90%'});
				  var url = exportPath+".html";
					window.open(url,"Download");
			} else {
				msgalert('Thông báo',msgErrors,'warning');
				// msgalert('Thông báo','Không tạo được báo cáo:'+'<br>'+'- Không có dữ liệu' +'<br>- Vụ lúa này đã được thu hoạch hết<br>','warning');
				// msgalert('Thông báo','Xảy ra lỗi trong khi tạo báo cáo (không có dữ liệu hoặc dữ liệu không hợp lệ)','warning');

			}

 }
 /**
  * Tạo báo cáo và hiển thị trên trình duyệt
  * @param fn
  * 		Kiểu thông tin báo cáo: thông tin thiên tai, cơ cấu giống lúa hoặc hiện trạng lúa
  * @param position
  * 	   Vị trí lưu ở dạng WKT(well-known text) của địa phương khi click trên bản đồ.
  * 	   Từ vị trí này sẽ xác định được địa phương (tỉnh,huyện,xã) nào đang được chọn để tạo báo cáo. 
  */
 function RenderHientrang(fn, posWKT){	 
	 var actionRender = null;
	 var sau_id = -1;
	 var benh_id= -1;
	 var thientai_id = -1;	
	 var time_int1=-1;
	 var time_int2 =-1;
	 var dot = -1;
	// var dot = 0;
	 var option =3;
	 var vuluaid=-1;
	 var time_hientrang_str="";
	 getLanhthoClicked( 'tbl_xa_region','xa_id',posWKT);
	 if (fn == FN_MAP_HIENTRANG_CCGL){		 
		 var condition;
		 actionRender = ACT_RENDER_MAP_CCGL;
		 time_hientrang_str = $('#dlg_main_hientrang_textboxdate').datebox('getValue');
		
		 if(gm.map.getLanhthoSelected("xa_id")>0){
			 condition = "tbl_ruong_region.xa_id =" + gm.map.getLanhthoSelected("xa_id");
		 }else if( gm.map.getLanhthoSelected("huyen_id")>0){
			 condition = "tbl_ruong_region.huyen_id =" + gm.map.getLanhthoSelected("huyen_id");
		 }else if(gm.map.getLanhthoSelected("tinh_id")>0){
			 condition = "tbl_ruong_region.tinh_id =" + gm.map.getLanhthoSelected("tinh_id") ;
		 }
		 //alert(condition);
		 var jsTime=getTimeRange2CreateHientrangCCGL(gm.date.stringDate2Int(time_hientrang_str),condition);

	
		 if (jsTime ==null){
			 return;
		 }
		 time_int1=jsTime.time_int1;
		 time_int2=jsTime.time_int2;
		 vuluaid=jsTime.vuluaid;
		// alert(vuluaid)
		// alert(time_int1+'-'+time_int2)
	 } else if (fn == FN_MAP_HIENTRANG_DICHHAI){
		 actionRender = ACT_RENDER_MAP_DICHHAI;
		 //kiểm tra sâu/bệnh
		 time_hientrang_str = $('#dlg_main_hientrang_dichhai_textboxdate').datebox('getValue');	 
		 var combo = document.getElementById("dlg_main_hientrang_cbdichhai");
		 var dichhai_id = combo.options[combo.selectedIndex].value;	
		 var  array_id=dichhai_id.split('o');
		   if (array_id[0]==0)
		    {
			    sau_id=array_id[1];
			    benh_id=0;
			    cwrs_debug('');
			}
		   else 
		    {
			    benh_id=array_id[1];
			    sau_id=0;
			}
		 cwrs_debug('sau_id='+ sau_id +', benh_id='+benh_id);
	 } else if (fn == FN_MAP_HIENTRANG_HTL){
       // alert('aaa');
		 actionRender = ACT_RENDER_MAP_HTL;
		 
		// var time_hientrang_str = $('#dlg_main_hientrang_textboxdate').datebox('getValue');		
		 var strYear = getCbbValue("dlg_main_hientrang_htl_nam");
		 var strMonth = getCbbValue("dlg_main_hientrang_htl_thang");
		 
		 var radioSelected = $('input:radio[name=dlg_main_hientrang_htl_radio]:checked').val(); 
			if (radioSelected == 1){
			//	option =1;	
				var jsdate1 = gm.date.stringToJSONDate('01/'+strMonth+'/'+strYear);
				time_int1 = jsdate1.cti;
				time_int2 = time_int1 + 13;
			//	time_int2 = time_int1 + parseInt(getDaysInMonth(strMonth, strYear))-1;
		//		alert('time_int1_1'+ time_int1);
		//		alert('time_int2_1'+ time_int2);
			} else if (radioSelected == 2){
				//option =2;
				var jsdate1 = gm.date.stringToJSONDate('15/'+strMonth+'/'+strYear);
				var jsdate2 = gm.date.stringToJSONDate(gm.date.getDaysInMonth(strMonth, strYear)+'/' +strMonth+'/'+strYear);
				time_int1 = jsdate1.cti;
				time_int2 = jsdate2.cti;
		//		alert('time_int1_2'+ time_int1);
		//		alert('time_int2_2'+ time_int2);
				//time_int2 = time_int1 + parseInt(getDaysInMonth(strMonth, strYear))-1;
				
			} 
			else {
				msginfo('Bạn hãy chọn khoảng thời gian báo cáo trong mục tùy chọn bên trái.');
				return;
			}
		// alert('strMonth:'+strMonth);
		// cwrs_debug("strYear = "+strYear);
		// cwrs_debug("strMonth = "+strMonth);
			//time_hientrang_str = stringToJSONDate('01/'+strMonth+'/'+strYear);
			//alert('time_hientrang_str:'+time_hientrang_str.cti);
			//time_int1 = time_hientrang_str.cti;
			//time_int2 = time_int1 + parseInt(getDaysInMonth(strMonth, strYear));
			time_hientrang_str="01/01/2012";
	 } else if (fn == FN_MAP_HIENTRANG_THIENTAI){
		// return;
		 var combo = document.getElementById("dlg_main_hientrang_thientai_cbthientai");
		 thientai_id = combo.options[combo.selectedIndex].value;
		 if(thientai_id <0){msgerror('Hãy chọn loại thiên tai');return;}
		 cwrs_debug('thientai_id='+ thientai_id);
		 actionRender = ACT_RENDER_MAP_THIENTAI;
		 var radioSelected_tt = $('input:radio[name=dlg_main_hientrang_thientai_radio]:checked').val(); 
		// alert("radioSelected_tt"+ radioSelected_tt);
			if (radioSelected_tt == 1){		
				option =1;
				//dot = getCbbValue("dlg_main_hientrang_thientai_cbdot");
				 var combo = document.getElementById("dlg_main_hientrang_thientai_cbdot");
				 dot = combo.options[combo.selectedIndex].value;
				// alert('dot1'+dot);
			//    var	 dot_thientai= combo.options[combo.selectedIndex].text;
				if(dot <0){msgerror('Hãy chọn đợt thiên tai');return;}
				//var strDate = $('#dlg_main_report_vu2ngay_datebox').datebox('getValue');
				//if (!Utils.isValidateDMY(strDate)){msgerror('Hãy chọn thời gian để tạo báo cáo');return;}
				
				//var jsdate = stringToJSONDate(strDate);
			//	time_int2 = jsdate.cti;

				//time_int1 = jsdate.sti -180;
				//cwrs_debug("time_int1 = "+time_int1);
				

			} else if (radioSelected_tt == 2){
				option =2;
				//dot=0;
				time_hientrang_str = $('#dlg_main_hientrang_thientai_textboxdate').datebox('getValue');
			    if (!Utils.isValidateDMY(time_hientrang_str)){msgerror('Hãy chọn thời gian để tạo bản đồ ');return;}		
				
			} else {
				msginfo('Bạn hãy chọn hình thức thiết lập bản đồ trong mục tùy chọn bên trái.');
				return;
			}
			time_hientrang_str="01/01/2012";
	 } else if (fn == FN_MAP_HIENTRANG_NUOC){
		 
		 actionRender = ACT_RENDER_MAP_NUOC;
		 time_hientrang_str = $('#dlg_main_hientrang_textboxdate').datebox('getValue');
	 }  else if (fn == FN_MAP_HIENTRANG_NANGSUAT){
		 
		 actionRender = ACT_RENDER_MAP_NANGSUAT;
		 time_hientrang_str = $('#dlg_main_hientrang_textboxdate').datebox('getValue');
	 } 
	 
	//var time_hientrang_str = $('#dlg_main_hientrang_textboxdate').datebox('getValue');
	time_hientrang_str = time_hientrang_str.trim();
	//alert(time_hientrang_str);
	if (time_hientrang_str == ''){
		 msgalert('Thông báo','Bạn hãy chọn thời gian','warning');
			return;
	} 
	
	var time_hientrang_int = gm.date.stringDate2Int(time_hientrang_str);
	//alert('time_report_int ='+time_report_int);
	    
	 
	 //hiden controls
	 g_controlPanel.hideControl(g_btnEditCanhdong);
     g_controlPanel.hideControl(g_btnSelectDeature);
    // g_fn_selected = FN_BAOCAO_HIENTRANGLUA;
	
	var table = '';
	var id = '';
	if (layer_xa.getVisibility()){
		table = 'tbl_xa_region';
		id = 'xa_id';
	} else if (layer_huyen.getVisibility()) {
		table = 'tbl_huyen_region';
		id = 'huyen_id';
	} else {
		table = 'tbl_tinh_region';
		id = 'tinh_id';	
	}
	// alert('dot2'+dot);

	
	//$("#").text(value);
	/*and*/
	//$("#dlg_main_report_textboxdate").html(value);
	 var isRendered = false;
	 var mapFile = '';
	 $.ajax({
				url: RENDER_SERVLET ,
				type: "POST",
				data:
			    { 
				  action: actionRender,
				  position: posWKT,
				  table:table,
				  id:id,
				  vuluaid:vuluaid,
				  time:time_hientrang_int,
				  option:option, //only used for thientai
				  dot:dot,//only used for thientai
				  time_int1:time_int1,//only used for htl
				  time_int2:time_int2,//only used for htl
				  sau_id:sau_id,//only for fn = FN_MAP_HIENTRANG_DICHHAI
				  benh_id:benh_id, //only for fn = FN_MAP_HIENTRANG_DICHHAI
				  thientai_id:thientai_id //only for fn = FN_MAP_HIENTRANG_THIENTAI
				},
				 async:false,
				 success:function(data) {
					 //window.open(url,"Download");
					 //alert('Create report:'+data);
					 if (data != "" && data != "null"){
						 isRendered = true;
					    var jsonObject = JSON.parse(data);
					    mapFile = jsonObject.data[0].map_file;
					    //alert(mapFile);
					    g_div_chugiai_flip = jsonObject.data[0].div;
					    
					    $('#div_hientrang_chugiai').html(g_div_chugiai_flip);					 
					    showPanel_createchugiai();
					    // alert(g_div_chugiai_flip);
					    //cwrs_debug("map file created: "+ mapFile);
					 }
					
					return data;  
			    }});
		if (isRendered == true){
			
			var url = mapserver_url_draw_hientrang.replace('<o>', mapFile);
			//msginfo('Tạo bản đồ hiện trạng thành công!');
			ShowMessageCreateMapSuccess('Bản đồ hiện trạng đang được tạo...');
			var currentime = new Date().getTime();
		 	layer_ruong_hientrang.url = url+'&random='+currentime;
		 	// cwrs_debug("map file url: "+ url);
 		    //alert("map file url: "+ layer_ruong_hientrang.url);
		 	layer_ruong_hientrang.redraw();
		 	layer_ruong_hientrang.setVisibility(true);

		} else {
			 msgwarning('Xảy ra lỗi trong khi xây dựng bản đồ hiện trạng (không có dữ liệu hoặc dữ liệu không hợp lệ)');

		}
	 
 } 
 function renderHientrangThientai(){	 
	 var actionRender = null;

	 var thientai_id = -1;	
	 var dot = 0;
	 var vuluaid=-1;
	 var time_hientrang_str="";
		
		 var combo = document.getElementById("dlg_main_hientrang_cbthientai");
		 thientai_id = combo.options[combo.selectedIndex].value;
		 if(thientai_id <0){msgerror('Hãy chọn loại thiên tai');return;}
		 cwrs_debug('thientai_id='+ thientai_id);
		 actionRender = ACT_RENDER_MAP_THIENTAI;
		 var radioSelected_tt = $('input:radio[name=dlg_main_hientrang_thientai_radio]:checked').val(); 
			if (radioSelected_tt == 1){		
				option =1;
				dot = getCbbValue("dlg_main_hientrang_thientai_cbdot");
				if(dot <0){msgerror('Hãy chọn đợt thiên tai');return;}
				//var strDate = $('#dlg_main_report_vu2ngay_datebox').datebox('getValue');
				//if (!Utils.isValidateDMY(strDate)){msgerror('Hãy chọn thời gian để tạo báo cáo');return;}
				
				//var jsdate = stringToJSONDate(strDate);
			//	time_int2 = jsdate.cti;

				//time_int1 = jsdate.sti -180;
				//cwrs_debug("time_int1 = "+time_int1);
				

			} else if (radioSelected_tt == 2){
				option =2;
				dot=0;
				time_hientrang_str = $('#dlg_main_hientrang_thientai_textboxdate').datebox('getValue');
			    if (!Utils.isValidateDMY(time_hientrang_str)){msgerror('Hãy chọn thời gian để tạo bản đồ ');return;}		
				
			} else {
				msginfo('Bạn hãy chọn hình thức thiết lập bản đồ trong mục tùy chọn bên trái.');
				return;
			}

	 
	//var time_hientrang_str = $('#dlg_main_hientrang_textboxdate').datebox('getValue');
	time_hientrang_str = time_hientrang_str.trim();
	//alert(time_hientrang_str);
	if (time_hientrang_str == ''){
		 msgalert('Thông báo','Bạn hãy chọn thời gian','warning');
			return;
	} 
	
	var time_hientrang_int = gm.date.stringDate2Int(time_hientrang_str);
	//alert('time_report_int ='+time_report_int);
	    
	 
	 //hiden controls
	 g_controlPanel.hideControl(g_btnEditCanhdong);
     g_controlPanel.hideControl(g_btnSelectDeature);
    // g_fn_selected = FN_BAOCAO_HIENTRANGLUA;
	
	var table = '';
	var id = '';
	if (layer_xa.getVisibility()){
		table = 'tbl_xa_region';
		id = 'xa_id';
	} else if (layer_huyen.getVisibility()) {
		table = 'tbl_huyen_region';
		id = 'huyen_id';
	} else {
		table = 'tbl_tinh_region';
		id = 'tinh_id';	
	}

	 var isRendered = false;
	 var mapFile = '';
	 $.ajax({
				url: RENDER_SERVLET ,
				type: "POST",
				data:
			    { 
				  action: actionRender,
				  position: g_lanhtho_selected.poswkt,
				  table:table,
				  id:id,
				  vuluaid:vuluaid,
				  time:time_hientrang_int,
				  thientai_id:thientai_id //only for fn = FN_MAP_HIENTRANG_THIENTAI
				},
				 async:false,
				 success:function(data) {
					 //window.open(url,"Download");
					 //alert('Create report:'+data);
					 if (data != "" && data != "null"){
						 isRendered = true;
					    var jsonObject = JSON.parse(data);
					    mapFile = jsonObject.data[0].map_file;
					    //alert(mapFile);
					    g_div_chugiai_flip = jsonObject.data[0].div;
					    
					    $('#div_hientrang_chugiai').html(g_div_chugiai_flip);					 
					    showPanel_createchugiai();
					    // alert(g_div_chugiai_flip);
					    //cwrs_debug("map file created: "+ mapFile);
					 }
					
					return data;  
			    }});
		if (isRendered == true){
			
			var url = mapserver_url_draw_hientrang.replace('<o>', mapFile);
			//msginfo('Tạo bản đồ hiện trạng thành công!');
			ShowMessageCreateMapSuccess('Bản đồ hiện trạng đang được tạo...');
		 	layer_ruong_hientrang.url = url;
		 	// cwrs_debug("map file url: "+ url);
 		//alert("map file url: "+ url);
		 	layer_ruong_hientrang.redraw();
		 	layer_ruong_hientrang.setVisibility(true);

		} else {
			 msgwarning('Xảy ra lỗi trong khi xây dựng bản đồ hiện trạng (không có dữ liệu hoặc dữ liệu không hợp lệ)');

		}
	 
 } 
function onclick_dieutra_ruong(){
		cwrs_debug('user click: điều tra ruộng...');
		//msginfo('Hệ thống đang nâng cấp chức năng này. Vui lại thử lại sau vài giờ nữa.');
		//return;
		deactivate_dieutra_canhdong();
		activate_dieutra_ruong();
		layer_ruong.setVisibility(true);
		layer_xa.setVisibility(false);
		layer_huyen.setVisibility(false);
		layer_ruong_hientrang.setVisibility(false);
		g_fn_selected = FN_DIEUTRA_RUONG;
		g_highlightCtrl.selectByClickOrBox.unselectAll();
		g_btnSelectDeature.activate();
		g_btnPanningHand.deactivate();
		showContextMenu(CLASS_CONTEXTMENU_DIEUTRA_RUONG);
		setCurrentMenu('cdieutra');
	}
function onclick_dieutra_canhdong(){
	setCurrentMenu('cdieutra');
		cwrs_debug('user click: điều tra cánh đồng...');
		//msginfo('Hệ thống đang nâng cấp chức năng này. Vui lại thử lại sau vài giờ nữa.');
		//return;
		
		deactivate_dieutra_canhdong();
		if (g_xa_id_by_search != -1) 
		   activate_dieutra_canhdong();
		else {
			showHint('Chức năng này chỉ kích hoạt khi bạn tìm kiếm đến cấp xã!');
		}
		g_fn_editing_canhdong = false;
        
		//reset list canhdong
		g_list_canhdong =[];
		g_cdm.setListCanhdong([]);
       
	
		layer_ruong.setVisibility(true);
		layer_xa.setVisibility(false);
		layer_ruong_hientrang.setVisibility(false);
		g_fn_selected = FN_DIEUTRA_CANHDONG;
		//unselect những ruộng id đã được chọn
		g_highlightCtrl.selectByClickOrBox.unselectAll();
		g_btnSelectDeature.activate();
		
		showContextMenu(CLASS_CONTEXTMENU_DIEUTRA_CANHDONG);
		//load dữ liệu cánh đồng: số cánh đồng và danh sách ruộng thuộc cánh đồng
		var t1 = (new Date()).getTime();

		if (g_xa_id_by_search != -1)
		 $.ajax({
			 	url:MAIN_SERVLET,
				data:
			    { 
				  action: ACT_GET_DATA_CANHDONG_FOR_XA,
				  xa_id:g_xa_id_by_search,
				  hasGeometry:false
				},
				 async:true,
				 error: function (request, status, error) {
				        alert(request.responseText);
				    },
				 success:function(_data) {
				  	  if (_data != 'null'){
					  		 
				  		  
				  		  var t2 = (new Date()).getTime();
		                  var data = _data.split(SEP_TEXT_AND_BINARY);
		                  //format: [canhdong_id1][,][list_ruong_id1][SEP-> '-'][canhdong_id2][,][list_ruong_id2]...[SEP-> '-']
		                  //ví dụ: 10,5,6-5,8,9-
		                  var textData = data[0];
		                  var binaryGeom = data[1];// alert('binaryGeom:'+binaryGeom)
		                  
		                  //parse text data
		                  var lstCanhdong = textData.split(SEP_COM_TYPE);//lstCanhdong là 1 mảng phần tử:[canhdong_id1][,][list_ruong_id1]
		                  
		                  for (var i = 0; i < lstCanhdong.length - 1; i++){//lấy từ 0 < (canhdong.length - 1) để bỏ '-' cuối cùng
		                	  var canhdong = lstCanhdong[i];
		                	  //alert('canhdong='+canhdong);
		                	  var element_canhdong = canhdong.split(',');
		                	  //alert('element_canhdong.size='+element_canhdong.length); 
		                	  
		                	  var canhdong_id = element_canhdong[0];
		                	  //alert('canhdong_id='+canhdong_id); 
		                  	
		                	  var ruongIDArray = [];
		                	  for (var j = 1; j < element_canhdong.length; j++){//
		                		  //alert('element_canhdong[j]='+element_canhdong[j]); 
		                		  ruongIDArray.push(element_canhdong[j]);
		                		  //set canh dong id cho mỗi ruộng feature được load trước đó
		                		  for (var k = 0; k < g_layer_vector_ruong.features.length; k++){
		                			  if (g_layer_vector_ruong.features[k].fid == element_canhdong[j]){
		                				  g_layer_vector_ruong.features[k].attributes['pid'] = canhdong_id;
		                			  }
		                		  }
		                	  }
		                	  //alert('put:_lstID.size='+_lstID.length)
		                	 
		                	  var oCanhdong = new Canhdong();
		                	  oCanhdong.setID(canhdong_id);
		                	 // oCanhdong.setFillColor(color);
		                	  oCanhdong.setRuongIDArray(ruongIDArray);
		                	 
		                	  g_cdm.getListCanhdong().push(oCanhdong);
  
		                  }
		                  //sort g_list_canhdong: cánh đồng có nhiều ruộng nhất ở đầu
		                  Utils.sortCanhdong(g_cdm.getListCanhdong());
		                  //Phân bố màu cho mỗi cánh đồng
		                  var c =0;//index color in cache for canhdong
		                  for(var  i = 0; i < g_cdm.getListCanhdong().length; i++){
		                	  var color;
		                	  
		                	 
		                	  if (c < g_array_colors.length){
		                		  color = g_array_colors[c];
		                		  c++;
		                	  } else {
		                		  color = 'white';
		                	  }
		                	  g_cdm.getListCanhdong()[i].setFillColor(color);
		                  }
		                  

		                  // alert(g_list_canhdong.showMe());
		          		  var t3 = (new Date()).getTime();
		          		  cwrs_debug('Load data for cánh đồng...takes ' + (t2-t1) +'(ms)');
		          		  cwrs_debug('Total cánh đồng: ' + g_cdm.getListCanhdong().length);
		   	              cwrs_debug('Parsing takes : ' + (t3-t2) + '(ms)');
		   	           
		   	             /* var s ='';
		   	              for(var  i = 0; i < g_list_canhdong.length; i++){
		             	 
		             	  s += g_cdm.getListCanhdong()[i].getFillColor()+'<br>';
		   	              }
		   	              alert('s='+s);*/
		                 //alert('textData: '+textData);
		                 //alert('binaryGeom: '+binaryGeom);
		   	              cwrs_debug('already for editing canh dong...');
		   	              if (g_acc_signedin == true)
		   	              enable_edit_canhdong();
				  	  }
			    }
		   });
		
		
	}
	function onclick_dieutra_xa(){
		cwrs_debug('user click: điều tra xã...');
		g_fn_editing_canhdong = false;
		g_controlPanel.hideControl(g_btnEditCanhdong);
        g_controlPanel.hideControl(g_btnSelectDeature);
        
		layer_ruong.setVisibility(false);
		layer_xa.setVisibility(true);
		layer_ruong_hientrang.setVisibility(false);
		g_fn_selected = FN_DIEUTRA_XA;
		
		g_btnPanningHand.activate();
		g_highlightCtrl.selectByClickOrBox.unselectAll();
		showContextMenu(CLASS_CONTEXTMENU_DIEUTRA_XA);
		
		deactivate_dieutra_canhdong();
		setCurrentMenu('cdieutra');
		
	}
	
 function isFeatureIDExisted(layer_vector, id){
	 var t1= (new Date()).getTime();
	// var lstFeatureID = [];
	 var features = layer_vector.features;
	 for(var i=0; i<features.length; i++) {
		 if (features[i].fid == id)
			 return true;

	 }
	/* var feature = new OpenLayers.Feature.Vector(
				   geometry,null,g_style_fill_huyen );
				 g_layer_vector_ruong.addFeatures([feature]);
				 
	*/			 
	 var t = (new Date()).getTime() - t1;
	 //lstFeatureID = feature.attributes.intersectsWith;
		// alert('isFeatureIDExisted():'+t+'(ms)');
		
		 return false;
 }
 function parseFeatureFromBinary_Ruong(binaryStream){
	 
	 	cwrs_debug('parsing feature from binary stream...');
		 // Create the Binary Reader
		var wkbParser = new WKBParser();
		//var wkbStream = new BinaryReader(result);
		var wkbStream = new BinaryReader(binaryStream);
		 
		// alert('time to load data:'+ ((new Date()).getTime()-measure_time)+'(ms)');
		// alert('size:'+wkbStream.getSize());
		var t_parse_bin= (new Date()).getTime();
		var cFeat =0;
    		while(wkbStream.getPosition() < wkbStream.getSize())
		{	
    			//get id
    			var id  = wkbStream.readInt32();// alert(id);
    			if (id < 0) break;
    			//get geometry
				var geomFeature = wkbParser.getGeometry(wkbStream);
				//g_list_ruong_selected.put(id, geomFeature);
			 	/*var feature = new OpenLayers.Feature.Vector(
 			OpenLayers.Geometry.fromWKT(result),null,g_style_fill_huyen
	 	);*/
				geomFeature.fid = id;
		   	 	g_layer_vector_ruong.addFeatures([geomFeature], true);//false -> không vẽ ngay
		    	//g_layer_vector_ruong.drawFeature(geomFeature);
		    	cFeat++;
		    	//g_layer_vector_ruong.eraseFeatures([geomFeature]);

		    	
		}
    		cwrs_debug('total features: ' + g_layer_vector_ruong.features.length + '...');
    //	alert('parse '+ g_layer_vector_ruong.features.length+ 'feature(s)-'+ c+ ' id(s) takes:'+((new Date()).getTime()-t_parse_bin)+'(ms)');
    // alert('parse '+ cFeat + 'feature(s) takes:'+((new Date()).getTime()-t_parse_bin)+'(ms)');
		
 }
 function parseFeatureFromBinary_Canhdong(binaryStream){
	 // Create the Binary Reader
	var wkbParser = new WKBParser();
	//var wkbStream = new BinaryReader(result);
	var wkbStream = new BinaryReader(binaryStream);
	 
	// alert('time to load data:'+ ((new Date()).getTime()-measure_time)+'(ms)');
	// alert('size:'+wkbStream.getSize());
	//var t_parse_bin= (new Date()).getTime();
	var cFeat =0;
		while(wkbStream.getPosition() < wkbStream.getSize())
	{	
			//get id
			var id  = wkbStream.readInt32();// alert(id);
			if (id < 0) break;
			//get geometry
			var geomFeature = wkbParser.getGeometry(wkbStream);
			geomFeature.fid = id;
	   	 	g_layer_vector_canhdong.addFeatures([geomFeature], true);//false -> không vẽ ngay

	}
//	alert('parse '+ g_layer_vector_ruong.features.length+ 'feature(s)-'+ c+ ' id(s) takes:'+((new Date()).getTime()-t_parse_bin)+'(ms)');
// alert('parse '+ cFeat + 'feature(s) takes:'+((new Date()).getTime()-t_parse_bin)+'(ms)');
	
}
 function precache_feature_geometry(condition){
	 
	// cwrs_debug('pre-caching feature geometry...');
	 
	 var type = TYPE_GEOMETRY_WKB;
	 //clear cache before
	 g_layer_vector_ruong.destroyFeatures(g_layer_vector_ruong.features);

	 
	 $.post(MAIN_SERVLET ,									
			    {  
				  action: ACT_PRECACHE_GEOMETRY,
				  table:'tbl_ruong_region',
				  id:'ruong_id',
				  condition: condition,
				  type:type,
				  fidExcepted:''
		
				},
			    function(binaryStream) {
					//alert('precache ok');
					//cwrs_debug('...OK!');
					
		            if (type == TYPE_GEOMETRY_WKB) {
		                	parseFeatureFromBinary_Ruong(binaryStream);
			           		
	           		} else {
							 //alert(result);
							 var feature = new OpenLayers.Feature.Vector(
							 OpenLayers.Geometry.fromWKT(result),null,g_style_fill_huyen );
						     g_layer_vector_ruong.addFeatures([feature]);
			 			     //g_layer_vector_ruong.drawFeature(feature);
			 			 
			 			     g_layer_search.removeAllFeatures();
						     //Tạo và vẽ mới
						     g_layer_search.addFeatures([feature]);
						     g_layer_search.drawFeature(feature);
					}
			      // measure_time = (new Date()).getTime()-measure_time;
		  		  // alert(measure_time+'(ms)');
				  //alert(result);
		          // alert('selectedFeatures =' + g_layer_vector_ruong.selectedFeatures.length);
					return binaryStream;
			    });
	 
 }

 
 function OnClick_DieutraCanhdong(x_lon, y_lat)
	 {
   var error,complete,beforeSend;
	   
	   $.ajax({
		   	url: (MAIN_SERVLET + 'action='+ ACT_GET_LIST_RUONGID_SAME_CANHDONG+"&x="+x_lon +"&y="+y_lat),
		   	type: "POST",
		    success: function(data, textStatus, jqXHR) {
        if (data ==''){
        	data = '0';
        } else {
        	//clear array
        	g_list_ruong_selected = [];
        	g_list_ruong_selected.length = 0;
        	//alert(data);
	    	var array = data.split(',');
	    	
	    	for (var i = 0; i < array.length; i++){
	    		g_list_ruong_selected.push(array[i]);
	    	}
	    	//alert('g_list_ruong_selected.length='+g_list_ruong_selected.length);
	    	highlightSelected(wmsHighlight,wmsHighlight2,isMainHighLight, data);
        }
	 }
  }); 
	   
	}
 
 

 
 var report = function(e) {
	 //alert(e.type+','+ e.fid);
     //OpenLayers.Console.log(e.type, e.feature.id);
 };
 
 function getWKTFromBounds(bounds){
	 var size_x = bounds.right - bounds.left;
	 var size_y = bounds.bottom - bounds.top;
	 if (isNaN(size_x) || isNaN(size_y)){
		 alert('N a N');
		 return;
	 }
	 var geomWKT;
	 
 	    var lonlat_leftbottom = map.getLonLatFromPixel(new OpenLayers.Pixel(bounds.left, bounds.bottom)); 
 		var lonlat_righttop = map.getLonLatFromPixel(new OpenLayers.Pixel(bounds.right, bounds.top)); 
 		
 		  //alert((bounds.right - bounds.left)+','+(bounds.bottom - bounds.top)) ;
	    if (size_x < MIN_DRAG_RECT_ALLOWED && size_y < MIN_DRAG_RECT_ALLOWED){
	    	//alert('abort');
	    	var x = (lonlat_leftbottom.lon + lonlat_righttop.lon)/2;
	    	var y = (lonlat_leftbottom.lat + lonlat_righttop.lat)/2;
	    	geomWKT = 'POINT('+x +' ' + y +')';
	    	return geomWKT;
	    }

 			//Tạo polygon từ bounds
 			var lstPoints = [];
 			lstPoints.push(new OpenLayers.Geometry.Point(lonlat_leftbottom.lon.toFixed(4), lonlat_righttop.lat.toFixed(4)));
 			lstPoints.push(new OpenLayers.Geometry.Point(lonlat_righttop.lon.toFixed(4), lonlat_righttop.lat.toFixed(4)));
 			lstPoints.push(new OpenLayers.Geometry.Point(lonlat_righttop.lon.toFixed(4), lonlat_leftbottom.lat.toFixed(4)));
 			lstPoints.push(new OpenLayers.Geometry.Point(lonlat_leftbottom.lon.toFixed(4), lonlat_leftbottom.lat.toFixed(4)));
 			//lstPoints.push(new OpenLayers.Geometry.Point(lonlat_leftbottom.lon.toFixed(4), lonlat_righttop.lat.toFixed(4)));
 			var linear_ring = new OpenLayers.Geometry.LinearRing(lstPoints);
		    var box = new OpenLayers.Geometry.Polygon([linear_ring]);
		    
	        //var box = bounds.toGeometry();
		    var boxFeature = new OpenLayers.Feature.Vector(box);
		    var formatWKT = new OpenLayers.Format.WKT();
 			geomWKT = formatWKT.write(boxFeature);
 			//alert(geomWKT);
 			return geomWKT;
 }
 function OnSelectMultiFeautureByBox(bounds, fidExcepted){
	 
	 //cwrs_debug();
	 //alert('OnSelectMultiFeautureByBox')
	 
	 if (g_fn_selected == FN_DIEUTRA_RUONG || g_fn_selected == FN_DIEUTRA_CANHDONG){
 			//alert('geomWKT='+geomWKT);
		 	//var geomWKT = getWKTFromBounds(bounds);
     			 
	 }
	 
 }  

 function updateCanhdongColorState(listCanhdong){
	 //alert('updateCanhdongColorState:'+listCanhdong.length);
	 for (var i = 0; i < g_layer_vector_ruong.features.length; i++){
		 var feature = g_layer_vector_ruong.features[i];
		 var style = g_style_fill_canhdong;
		 var canhdong = g_cdm.getCanhdongByID(feature.attributes['pid'],listCanhdong);
		 //alert('feature.attributes[pid] ='+ feature.attributes['pid']);
		 		style.strokeWidth = 0.5;
		 		style.fillColor = canhdong.getFillColor();
		 		style.fillOpacity = 0.8;
		 		//style.graphicZIndex = 0;
		 		//style.backgroundGraphicZIndex = i;
		 		
			// alert( style.fillColor);
		 	//cwrs_debug('style.z-index: '+style.graphicZIndex);
		 g_layer_vector_ruong.drawFeature(feature, style);
	 }
 }
 /**Fire when user click on edit button*/
 function onclick_edit_canhdong(){
	 //set context menu
	 showContextMenu(CLASS_CONTEXTMENU_EDIT_CANHDONG);
	 //sort list cánh đồng theo thứ tự giảm dần khi so sánh số ruộng trong mỗi cánh đồng
	 //clone info of canhdong
	 test_comp_canhdong();
	 g_cdm.setListCanhdongClone(owl.deepCopy(g_cdm.getListCanhdong()));
	 test_comp_canhdong();
	 updateCanhdongColorState(g_cdm.getListCanhdong());


 }
 
 
 
 
 /**
  * Lấy danh sách những ruộng có canhdong_id 
  * @param: id
  * 	id của ruộng
  */
 function getArrayRuongIDHasCanhdongID(canhdong_id){
	 
	 if (g_fn_selected == FN_DIEUTRA_CANHDONG){
	
		 for (var i = 0 ; i < g_cdm.getListCanhdong().length; i++){
			 var canhdong = g_cdm.getListCanhdong()[i];
				 if (canhdong_id == canhdong.getID()){
					 return canhdong.getRuongIDArray();
				 }
		 }
		 
	 } else {
		 return [];
	 }
	 return [];
 }
 /**
  * Lấy danh sách những ruộng có cùng canhdong_id voi ruong 'id'
  * @param: id
  * 	id của ruộng
  */
 function getListRuongIDHasSameCanhdongIDWith(feature){
	 
	 if (g_fn_selected == FN_DIEUTRA_CANHDONG){
		 
		 var canhdong_id = feature.attributes['pid'];
		
		 for (var i = 0 ; i < g_cdm.getListCanhdong().length; i++){
			 var canhdong = g_cdm.getListCanhdong()[i];
				 if (canhdong_id == canhdong.getID()){
					 return canhdong.getRuongIDArray();
				 }
		 }
		 
	 } else {
		 return [];
	 }
	 return [];
 }
 
 /*
 function removeItem(array, item){
	    for(var i in array){
	        if(array[i]==item){
	            array.splice(i,1);
	            break;
	            }
	    }
}
*/
 function test_comp_canhdong(title){
	 return;
	 try{
	 var s ='';
	 var s1='';
	 if (g_cdm.getListCanhdong().length != g_cdm.getListCanhdongClone().length)alert('ListCanhdong().length != ListCanhdongClone().length')
	 for (var i =0; i< g_cdm.getListCanhdong().length; i++){
		 s+='cd:'+g_cdm.getListCanhdong()[i].getID();
		 s+=',n='+g_cdm.getListCanhdong()[i].getRuongIDArray().length;
		 s+=',';

		 
	 }
	 for (var i =0; i< g_cdm.getListCanhdongClone().length; i++){
			
	 s1+='cd:'+g_cdm.getListCanhdongClone()[i].getID();
	 s1+=',n='+g_cdm.getListCanhdongClone()[i].getRuongIDArray().length;
	 s1+=',';
	 }
	// alert(title+':\n'+s+'\n'+s1)
	 }catch(err){alert(err)}
 }
 function onedit_canhdong_moveto(){
	 cwrs_debug('moving ruong to canhdong: '+ g_selected_feature_editing.attributes['pid']);
	 g_cdm.move(g_layer_vector_ruong.selectedFeatures, g_cdm.getFeatureAtRightClick().attributes['pid'], g_cdm.getListCanhdongClone());
	 test_comp_canhdong();
	 //alert(getListFeaturesIDSelected().length)
	 updateCanhdongColorState(g_cdm.getListCanhdongClone());
 }
 
function onedit_canhdong_saveall(){
	
	//alert('save all')
	 var mapCanhdongChanged = g_cdm.getCanhdongChanged();
	if (mapCanhdongChanged.size() <=0){
		msginfo('Không có thay đổi trong tiểu vùng (cánh đồng) này.');
	} else {
		msgconfirm('Thông báo','Lưu tất cả những thay đổi trong tiểu vùng (cánh đồng) này?',function(r){
			if (r){
				  var lstValues ='';
				  var lstIDs = '';
				  var utils = new Utils();
				  for (var i = 0; i < mapCanhdongChanged.size(); i++){
					  lstIDs+= mapCanhdongChanged.keys()[i];
					  lstIDs+= SQL_COMMA_SEP;
					  //alert('g_cdm.getListCanhdongClone().size ='+g_cdm.getListCanhdongClone().length);
					  for (var j = 0 ;j <g_cdm.getListCanhdongClone().length; j++){
						  var canhdong = g_cdm.getListCanhdongClone()[j];
						  if (canhdong.getID() == mapCanhdongChanged.keys()[i]){
							  lstValues += utils.createStringWithSeparator(canhdong.getRuongIDArray(),SQL_COMMA_SEP);//tạo list id ko có ',' ở cuối-> added trên servlet
							  lstValues += SQL_VALUES_LIST_SEP;
							 // alert('000');
						  }
					  }
				  }
				  var lstCD ='';
				  for (var j = 0 ;j < g_cdm.getListCanhdongClone().length; j++){
					  var canhdong = g_cdm.getListCanhdongClone()[j];
				      lstCD += canhdong.getID();
				      lstCD+=',';
				  }
				 // alert(lstCD);
				//alert('lstValues.size ='+lstValues);
				//alert('lstIDs ='+lstIDs);
				//alert('lstValues ='+lstValues);
				  
				  /*ELSE title
				  END;
				  */
				var jr = JResultFailed;	
				$.ajax({
						url:MAIN_SERVLET ,
						data:
					    { 
						  action: ACT_UPDATE_EDITING_CANHDONG,
						  ids: lstIDs,
					      values: lstValues,
					      tinh_id:g_tinh_id_by_search,
					      huyen_id:g_huyen_id_by_search,
					      xa_id:g_xa_id_by_search,
					      tablename:"tbl_canhdong_region"
						},
						async:false,
						
						success:function(jsonDataResult) {
							jr = JSON.parse(jsonDataResult);
							if(jr.code == DB_STR_OK)
								jr.success = true;
							else
								jr.success = false;
						}
					});
				if (jr.success){
					//remove canhdongid from g_cdm.getListCanhdongClone()
					msginfo('Cập nhật thành công!.');
					g_layer_vector_ruong.selectedFeatures = [];
					g_cdm.reset();
					g_cdm.setListCanhdongClone([]);
					onclick_dieutra_canhdong();
					 
					//update to main g_cdm.getListCanhdong()
				}else{
					msgerror(jr.msg);
					g_layer_vector_ruong.selectedFeatures = [];
					g_cdm.reset();
					g_cdm.setListCanhdongClone([]);
					g_cdm.setListCanhdongClone(owl.deepCopy(g_cdm.getListCanhdong()));
				}
				return jr;
			}
		});
	}
	 //this is trick
	 //cancelSelectRuongInEditCanhdong();//unselected all feature and refresh
	 //OnEditCanhdong();
	 
	 //update to database

	// alert(mapCanhdongChanged.keys().length);
	// alert('mapCanhdongChanged.size()='+mapCanhdongChanged.size());

	
}
function onedit_canhdong_cancelall(){
	var mapCanhdongChanged = g_cdm.getCanhdongChanged();
	if (mapCanhdongChanged.size() <=0){
		//msginfo('Không có thay đổi trong tiểu vùng (cánh đồng) này.');
	} else {
		msgconfirm('Thông báo','Hủy tất cả những thay đổi trong tiểu vùng (cánh đồng) này?',function(r){
			if (r){
				var errors =''; 
				//g_cdm.setListCanhdongClone([]);
				g_cdm.setListCanhdongClone(owl.deepCopy(g_cdm.getListCanhdong()));
				test_comp_canhdong('before rollback')
				//test_comp_canhdong()
				for (var i =0; i< g_cdm.getListCanhdong().length;i++){
					var canhdong = g_cdm.getListCanhdong()[i];
					var arrayRuongID =  canhdong.getRuongIDArray();
					
					for (var j = 0; j < arrayRuongID.length; j++){//
					  //alert('element_canhdong[j]='+element_canhdong[j]); 
						var feat = g_layer_vector_ruong.getFeatureByFid(arrayRuongID[j]);
						if (feat == null){
							errors +='null=getFeatureByFid('+arrayRuongID[j]+')'+': cd_id= '+canhdong.getID()+',index=' +j+',ruongid='+ arrayRuongID[j];
							errors += ';'
							
						  continue;
						}								
						feat.attributes['pid']=canhdong.getID();

				  }
				}
				test_comp_canhdong('after rollback')
				updateCanhdongColorState(g_cdm.getListCanhdong());
				g_layer_vector_ruong.selectedFeatures = [];
				g_cdm.reset();
				g_cdm.setListCanhdongClone([]);
				g_cdm.setListCanhdongClone(owl.deepCopy(g_cdm.getListCanhdong()));
		
				if (errors !='')
					msgwarning("Thao tác thành công. Tuy nhiên có một vài dữ liệu không hợp lệ. Vui lòng sao chép thông báo lỗi sau và gửi email tới <b>dbscl.cwrs@gmail.com</b>:"+errors);
				//alert('cancel all')
				test_comp_canhdong()
			}

	});
	}
	
	
}
 /**
  * Di chuyển ruộng giữa các cánh đồng
  * @param: 
  * 	
  */
/* function moveRuong2Canhdong(srcFeats, canhdong_id){
	 
	 var mapCanhdongChanged = new Map();
	 //dest
	 var canhdongDest = getCanhdongByID(canhdong_id);
	 mapCanhdongChanged.put(canhdongDest.getID(),"");
	 //alert('1) ' +mapCanhdongChanged.size())
	 for (var  i = 0; i < srcFeats.length; i++){
		  var feat = srcFeats[i];
		  canhdongDest.getRuongIDArray().push(feat.fid);
		  
		  //remove id from src
		 // alert('cd id =' + feat.attributes['pid']);
		  var srcCanhdong = getCanhdongByID(feat.attributes['pid']);
		  removeItem(srcCanhdong.getRuongIDArray(),feat.fid);
		  if (srcCanhdong.getID()!=0){
			  mapCanhdongChanged.put(srcCanhdong.getID(),"");
		  }
		//  alert(i+ ') '+srcCanhdong.getID() + ' size ='+mapCanhdongChanged.size())
		  
		  //change canh dong id for src
		  feat.attributes['pid'] = canhdongDest.getID();

		  
	 }
	 return mapCanhdongChanged;
 }*/
 
 function onCreateNewCanhdong(){
	 
	 if (g_lanhtho_search_selected.xa_id == -1) return;
	 //create new canh dong
	/* 
	 var newCanhdongID = getNewValueOfField('tbl_canhdong_region','canhdong_id');
	 var newGID = getNewValueOfField('tbl_canhdong_region','gid');
	// alert(newGID);
	 
	 var dbhelper = new Utils();
	 dbhelper.clearFieldStorer();
	 
	 dbhelper.putfval_int('gid', newGID);
	 dbhelper.putfval_int('tinh_id', g_lanhtho_search_selected.tinh_id);
	 dbhelper.putfval_int('huyen_id', g_lanhtho_search_selected.huyen_id);
	 dbhelper.putfval_int('xa_id', g_lanhtho_search_selected.xa_id);
	 dbhelper.putfval_int('canhdong_id', newCanhdongID);
	 dbhelper.putfval_string('ruong_id', '');
	 dbhelper.putfval_int('canhdong_nuoc', '1');
	 var strSQL = dbhelper.genInsertCmd('tbl_canhdong_region');
	 if (cwrs_execSQLDirectly2DB(MAIN_SERVLET, strSQL) != DB_STR_FAILED){
		 cwrs_debug('created new canhdong: '+ newCanhdongID);
		 g_selected_feature_editing = new  OpenLayers.Feature.Vector();
		 g_selected_feature_editing.attributes['pid'] = newCanhdongID;
		 var newcd = new Canhdong();
		 newcd.setID(newCanhdongID);
		 newcd.setRuongIDArray([]);
		 g_cdm.getListCanhdong().push(newcd);
		 onDoneEditCanhdong();
		 msgalert('Thông báo','Tạo mới cánh đồng thành công! Vui lòng nhấn F5 trước khi thực hiện thao tác khác.','information');
	 }*/
	 var c = g_cdm.countCanhdongNew( g_cdm.getListCanhdongClone());
	 if (c >0){msginfo('Một cánh đồng đã được tạo mới. Bạn chỉ có thể tạo mới một cánh đồng tại một thời điểm.');return;}
	 if(g_layer_vector_ruong.selectedFeatures.length >0){
		 //var min = g_cdm.getMinCanhdongID();
		 var min = g_cdm.getMinCanhdongID( g_cdm.getListCanhdongClone());
		// alert('min id in canhdong ='+min);
		 min = min -1;
		// alert('new id canhdong ='+min);
		 var newCanhdong = new Canhdong();
		 newCanhdong.setID(min);
		 newCanhdong.setFillColor("#ff0000");
		 g_cdm.addCanhdong(newCanhdong, g_cdm.getListCanhdongClone());
		 
		 g_cdm.move(g_layer_vector_ruong.selectedFeatures, newCanhdong.getID(), g_cdm.getListCanhdongClone());
		 test_comp_canhdong();
		// alert(getListFeaturesIDSelected().length)
		 updateCanhdongColorState(g_cdm.getListCanhdongClone());
	 }
 }
 
 /**
  * 
  * @returns {Array}
  */
 function getListXaIDHasSameSinhthai(sinhthai_field_name,huyen_id,xa_id){
	 var listXaID=[];
		$.ajax({
			url:MAIN_SERVLET ,
			data:
		    { 
			 action: ACT_GET_LIST_XAID_SAME_SINHTHAI,
			 sinhthai_field_name:sinhthai_field_name,
			 xa_id:xa_id,
			 huyen_id:huyen_id

			},
			async:false,
			success:function(jsonData) {
				var jsonObject = JSON.parse(jsonData);
				//alert(jsonObject.rows.length);
				for (var i=0; i< jsonObject.rows.length;i++){
					listXaID.push(jsonObject.rows[i].xa_id);
				}
				return;
			   }
		});
		return listXaID;
 }
 
 /**
  * Xác định số ruộng (feature) hiện tại được chọn
  * @returns
  */
 function getTotalFeaturesSelected(){
	 return g_layer_vector_ruong.selectedFeatures.length;
 }
 /**
  * 
  * @returns {Array}
  */
 function getListFeaturesIDSelected(){
	 var _lstIDs = [];
	 var _featSelected = g_layer_vector_ruong.selectedFeatures;
	 for (var i = 0; i < _featSelected.length; i++) {
		 _lstIDs.push(_featSelected[i].fid);
	 }
	 return _lstIDs;
 }
 function getListRuongSelected(){
	
	 return g_layer_vector_ruong.selectedFeatures;
	
 }
 function getDientichXa(){
		var total_dt = 0;
		//alert('canhdong_id='+cdObj.getID());
		//alert('cdObj.getRuongIDArray().length='+cdObj.getRuongIDArray().length);
		for (var i =0; i < g_layer_vector_ruong.features.length; i++){
			var feat = g_layer_vector_ruong.features[i];
			total_dt += Math.abs(feat.geometry.getArea());
		}
		return parseFloat(total_dt/10000);
}
 /***
  * 
  * @returns Array of canhdong_id
  */
 function getCanhdongIDSelected(){
	 var mapIDs =  new Map();
	 var _featSelected = g_layer_vector_ruong.selectedFeatures;
	 for (var i = 0; i < _featSelected.length; i++) {
		 mapIDs.put(_featSelected[i].attributes['pid'], 0);
	 }
	 return mapIDs.keys();
 }
 /**
  * 
  * @param canhdong_id
  * @returns {Number} dien tich (ha)
  */
 function getDientichCanhdong(canhdong_id){
	var cdObj = getCanhdongByID(canhdong_id);
	var total_dt = 0;
	//alert('canhdong_id='+cdObj.getID());
	//alert('cdObj.getRuongIDArray().length='+cdObj.getRuongIDArray().length);
	for (var i =0; i < cdObj.getRuongIDArray().length; i++){
		var feat = g_layer_vector_ruong.getFeatureByFid(cdObj.getRuongIDArray()[i]);
		//if (feat ==null)alert('null for cdObj.getRuongIDArray()[i]='+cdObj.getRuongIDArray()[i]);
		//alert('ruongid=' + cdObj.getRuongIDArray()[i])
		//total_dt += Math.abs(feat.geometry.getGeodesicArea(map.getProjectionObject()));
		if (feat==null) continue;
		total_dt += Math.abs(feat.geometry.getArea());
	}
	return parseFloat(total_dt/10000);
 }
 function getCanhdongByID(id){
   
	 for (var i = 0; i < g_cdm.getListCanhdong().length; i++) {
		 if (g_cdm.getListCanhdong()[i].getID() == id){
			 return g_cdm.getListCanhdong()[i];
		 }
	 }
	 return (new Canhdong());
 }
 function getCanhdongByIDClone(id){
		
	 for (var i = 0; i < g_cdm.getListCanhdongClone().length; i++) {
		 if (g_cdm.getListCanhdongClone()[i].getID() == id){
			 return g_cdm.getListCanhdongClone()[i];
		 }
	 }
	 return (new Canhdong());
 }
 
 function cancelSelectRuongInEditCanhdong(){
	 
	   var layers = g_layer_vector_ruong;
       var layer, feature;
       for(var l=0; l<layers.length; ++l) {
           layer = layers[l];
           for(var i=layer.selectedFeatures.length-1; i>=0; --i) {
               feature = layer.selectedFeatures[i];
               //if(!options || options.except != feature)
               {
            	   layer.unselect(feature);
               }
           }
       }
	 //reset
       onclick_edit_canhdong();
	 
 }
 

/*RESET FUNCTIONS*/
function resetCanhdongEdition(){
	isCopied = false;
	g_fn_editing_canhdong = false;
	g_selected_feature_editing = null;
	//remove all selected
	for (var i = 0; i < g_layer_vector_ruong.features.length; i++){
		g_layer_vector_ruong.drawFeature(g_layer_vector_ruong.features[i],g_style_geometry_hide);
		
	}
	//alert('redraw all');
	//g_ctrDragFeature.unselectAll();
	//g_ctrDragFeature.deactivate();
	g_btnEditCanhdong.deactivate();
	g_layer_vector_ruong.eraseFeatures(g_layer_vector_ruong.selectedFeatures);
	g_layer_vector_ruong.selectedFeatures = [];
	
	
	
	
} 
/**RENDER */
 function render(layer){
	 
	 var requestLayer ='LAYERS=' + 'layer_tinh';
	 //mapserver_url_redraw: http://....&'
	 var v1 ='&v1=101,103,104,106';
	 var v2 ='&v2=209,211,213,215';
	 var v3 ='&v3=401,403,405,407';
	 var str = layer.getFullRequestString( {
		 id_tinh:1000,
		 v1:'101,103,104,106',
	 	 v2:'209,211,213,215',
	     v3:'401,403,405,407',
	     color:'255 255 0'
		 
	 } );
	 
	 str += ('&'+ 'map.layer[layer_tinh].class[0].style[0]=COLOR+0+0+0');
	 layer.setVisibility(false);
	 var url = str;
	// alert(url);
	 //re-render
	 layer.url = url;
	 layer.redraw();
	 layer.setVisibility(true);
	 
 }
 
 function enable_edit_canhdong(){
	 g_controlPanel.showControl(g_btnEditCanhdong);
 }
 function deactivate_dieutra_canhdong(){
	 
	 g_btnSelectDeature.deactivate();
	 g_btnZoomBox.deactivate();
	 g_btnEditCanhdong.deactivate();
	 g_btnPanningHand.activate();
	 resetCanhdongEdition();
	 g_controlPanel.hideControl(g_btnEditCanhdong);
	 switch(g_fn_selected){
	 case FN_MAP_HIENTRANG_CCGL:
	 case FN_MAP_HIENTRANG_NUOC:
	 case FN_MAP_HIENTRANG_HTL:
	 case FN_MAP_HIENTRANG_DICHHAI:
	 case FN_MAP_HIENTRANG_THIENTAI:
	 case FN_MAP_HIENTRANG_NANGSUAT:break;
	 default:
		 layer_ruong.setVisibility(false);
		 break;
	 }
     
 }
 function activate_dieutra_canhdong(){
	 g_controlPanel.showControl(g_btnSelectDeature);
	 g_btnSelectDeature.activate();
	 g_btnPanningHand.deactivate();
	 resetCanhdongEdition();
	 g_controlPanel.hideControl(g_btnEditCanhdong);
     layer_ruong.setVisibility(true);	 
 }
 function deactivate_dieutra_ruong(){
	 g_btnSelectDeature.deactivate();
	 g_btnPanningHand.activate();
	 switch(g_fn_selected){
	 case FN_MAP_HIENTRANG_CCGL:
	 case FN_MAP_HIENTRANG_NUOC:
	 case FN_MAP_HIENTRANG_HTL:
	 case FN_MAP_HIENTRANG_DICHHAI:
	 case FN_MAP_HIENTRANG_THIENTAI:
	 case FN_MAP_HIENTRANG_NANGSUAT:
	 default:
		 layer_ruong.setVisibility(false);
		 break;
	 }
    
 }
 function activate_dieutra_ruong(){
	 g_controlPanel.showControl(g_btnSelectDeature);
	 g_btnSelectDeature.activate();
	 g_btnPanningHand.deactivate();
     layer_ruong.setVisibility(true);
 }
 //olControlPanel
 function olControlPanel(){

 }
 function onclick_createmap(fn){
	loadHtml("dlg_bandohientrang_query","./Dialogs/bando.html",false,true);
	 $('#dlg_main_ccgl').hide();
	 $('#dlg_main_htl').hide();
	 $('#dlg_main_hientrang_lua').hide();
	 $('#dlg_main_nuoc').hide();
	 $('#dlg_main_thientai').hide();
	 $('#dlg_main_dichhai').hide();
	 $('#dlg_main_nsl').hide();
	 $('#dlg_main_hientrang_dichhai').hide();
	 $('#dlg_main_hientrang_thientai').hide();
	 $('#dlg_main_hientrang').hide();
	 if (fn == FN_MAP_HIENTRANG_CCGL){	
		 $('#dlg_main_ccgl').show();
		 $('#dlg_main_hientrang').show();
		 $('#div_hientrang_chugiai').css('margin-top','140px');
	 } else if (fn == FN_MAP_HIENTRANG_HTL){
		 $('#dlg_main_htl').show(); 
		 $('#dlg_main_hientrang_lua').show(); 
		 $('#div_hientrang_chugiai').css('margin-top','140px');		 
	 }else if (fn == FN_MAP_HIENTRANG_NANGSUAT){
		 $('#dlg_main_nsl').show(); 
		 $('#dlg_main_hientrang').show(); 
		 $('#div_hientrang_chugiai').css('margin-top','140px');
	 }
	 else if (fn == FN_MAP_HIENTRANG_NUOC){
		 $('#dlg_main_nuoc').show();
		 $('#dlg_main_hientrang').show();
		 $('#div_hientrang_chugiai').css('margin-top','140px');
	 }
	 else if (fn == FN_MAP_HIENTRANG_DICHHAI){   
		 $('#dlg_main_dichhai').show();
		 $('#dlg_main_hientrang_dichhai').show();
		 $('#div_hientrang_chugiai').css('margin-top','180px');
	 }
	 else if (fn == FN_MAP_HIENTRANG_THIENTAI){
		 $('#dlg_main_thientai').show();
		 $('#dlg_main_hientrang_thientai').show();
		
		 $('#div_hientrang_chugiai').css('margin-top','240px');
		 $('#div_hientrang_chugiai').css('width','500px');

	 }
 }
 
 function onclick_createReport(fn){
		loadHtml("dlg_report_query","./Dialogs/baocao.html",false,true);
		$('#dlg_main_report_CCGL').hide();
		 $('#dlg_main_report_TT').hide();
		 $('#dlg_main_report_HTL').hide();	
		 $('#dlg_main_report_TDSX').hide();
		 $('#dlg_main_report_TTDH').hide();
		 $('#dlg_main_report_DDBAOCAO').hide();
		 $('#dlg_main_graph').hide();
		 if (fn == FN_BAOCAO_HIENTRANGLUA){
			 $('#dlg_main_report_HTL').show();
			 $('#dlg_main_report_DDBAOCAO').show();
		 } else if (fn == FN_BAOCAO_COCAUGIONGLUA){
			 $('#dlg_main_report_CCGL').show();
			 $('#dlg_main_report_DDBAOCAO').show();
		 } else if (fn == FN_BAOCAO_THONGTINTHIENTAI){
			 $('#dlg_main_report_TT').show();		
			 $('#dlg_main_report_DDBAOCAO').show();
		 }
		 else if (fn == FN_BAOCAO_TIENDOSANXUAT){
			 $('#dlg_main_report_TDSX').show();		
			 $('#dlg_main_report_DDBAOCAO').show();
		 }
		 else if (fn == FN_BAOCAO_THONGTINDICHHAI){
			 $('#dlg_main_report_TTDH').show();		
			 $('#dlg_main_report_DDBAOCAO').show();
		 }
		 else if (fn == FN_BAOCAO_TIENDOTHUHOACH){
			 $('#dlg_main_report_CCGL').show();		
			 $('#dlg_main_report_DDBAOCAO').show();
		 }
		 else if (fn == FN_BAOCAO_BUILDGRAPH){
			 $('#dlg_main_graph').show();		
			// $('#dlg_main_report_DINHDANG_BAOCAO').show();
		 }
		 
	 }
function showPanel_createmap(){ 
	 
	 $('#dlg_bandohientrang_query').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_bandohientrang_query').corner();	
	 $('#dlg_bandohientrang_query').css({background:"rgba(0, 0, 0, 0.30)"})
	
}
function showPanel_createchugiai(){
	 
	// $('#div_chugiai_content').css({background:"rgb(0, 0, 0)"})
	 $('#div_chugiai_content').corner();	
	 if (g_fn_selected==FN_MAP_HIENTRANG_CCGL)
		 $('#div_chugiai_content').css({background:"rgba(0,0,0, 0.20)"})
	 else
		 $('#div_chugiai_content').css({background:"rgba(255,0,0, 0.20)"})
	
}

function showPanel_createdinhdangbc(){
	 
	 $('#dlg_main_report_DDBAOCAO').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_report_DDBAOCAO').corner();	
	 $('#dlg_main_report_DDBAOCAO').css({background:"rgba(0, 0, 0, 0.30)"})
	
}

function showPanel_report(){ 
/*	 
<<<<<<< .mine
	 $('#dlg_report_query').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_report_query').corner();	
	 $('#dlg_report_query').css({background:"rgba(2, 0, 0, 0.990)"})
=======
	 $('#dlg_main_report_CCGL').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_report_CCGL').corner();	
	 $('#dlg_main_report_CCGL').css({background:"rgba(2, 0, 0, 0.30)"})
>>>>>>> .r961*/
	}
function showPanel_report_ccgl(){ 
	 
	 $('#dlg_main_report_CCGL').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_report_CCGL').corner();	
	 $('#dlg_main_report_CCGL').css({background:"rgba(2, 0, 0, 0.30)"})
	}
function showPanel_report_tt(){ 
	 
	 $('#dlg_main_report_TT').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_report_TT').corner();	
	 $('#dlg_main_report_TT').css({background:"rgba(2, 0, 0, 0.30)"})
	}
function showPanel_report_htl(){ 
	 
	 $('#dlg_main_report_HTL').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_report_HTL').corner();	
	 $('#dlg_main_report_HTL').css({background:"rgba(2, 0, 0, 0.30)"})
	}

function showPanel_report_tdsx(){ 
	 
	 $('#dlg_main_report_TDSX').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_report_TDSX').corner();	
	 $('#dlg_main_report_TDSX').css({background:"rgba(2, 0, 0, 0.30)"})
	}

function showPanel_report_ttdh(){ 
	 
	 $('#dlg_main_report_TTDH').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_report_TTDH').corner();	
	 $('#dlg_main_report_TTDH').css({background:"rgba(2, 0, 0, 0.30)"})
	}
function showPanel_graph(){ 
	 
	 $('#dlg_main_graph_option_loaiDT').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_graph_option_loaiDT').corner();	
	 $('#dlg_main_graph_option_loaiDT').css({background:"rgba(0, 0, 0, 0.30)"})
	 
	  $('#dlg_main_graph_gieocaythuhoach').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_graph_gieocaythuhoach').corner();	
	 $('#dlg_main_graph_gieocaythuhoach').css({background:"rgba(0, 0, 0, 0.30)"})
	 
	 $('#dlg_main_graph_dichhai').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_graph_dichhai').corner();	
	 $('#dlg_main_graph_dichhai').css({background:"rgba(0, 0, 0, 0.30)"})
	 
	 	 $('#dlg_main_graph_option_kieuDT').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_graph_option_kieuDT').corner();	
	 $('#dlg_main_graph_option_kieuDT').css({background:"rgba(0, 0, 0, 0.30)"})
	 
	 
	
	}
function showPanel_graph_option_loaiDT(){ 
	 
	 $('#dlg_main_graph_option_loaiDT').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_graph_option_loaiDT').corner();	
	 $('#dlg_main_graph_option_loaiDT').css({background:"rgba(0, 0, 0, 0.30)"})
	}
function showPanel_graph_content(){ 
	 
	 $('#dlg_main_graph_gieocaythuhoach').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_graph_gieocaythuhoach').corner();	
	 $('#dlg_main_graph_gieocaythuhoach').css({background:"rgba(0, 0, 0, 0.30)"})
	}
function showPanel_graph_content_dichhai(){ 
	 
	 $('#dlg_main_graph_dichhai').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_graph_dichhai').corner();	
	 $('#dlg_main_graph_dichhai').css({background:"rgba(0, 0, 0, 0.30)"})
	}
function showPanel_graph_option_kieuDT(){ 
	 
	 $('#dlg_main_graph_option_kieuDT').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_graph_option_kieuDT').corner();	
	 $('#dlg_main_graph_option_kieuDT').css({background:"rgba(0, 0, 0, 0.30)"})
	}
function showPanel_graph_left(){ 
	 
	 $('#dlg_main_graph_left').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_graph_left').corner();	
	 $('#dlg_main_graph_left').css({background:"rgba(0, 0, 0, 0.30)"})
	}
function showPanel_graph_right(){ 
	 
	 $('#dlg_main_graph_right').css({background:"rgb(0, 0, 0)"})
	 $('#dlg_main_graph_right').corner();	
	 $('#dlg_main_graph_right').css({background:"rgba(0, 0, 0, 0.30)"})
	}
function showPanel_heft_add(){ 
	 
	 $('#heft_add').css({background:"rgb(0, 0, 0)"})
	 $('#heft_add').corner();	
	 $('#heft_add').css({background:"rgba(0, 0, 0, 0.30)"})
	
}
function showPanel_heft_content(){ 
	 
	 $('#heft_content').css({background:"rgb(0, 0, 0)"})
	 $('#heft_content').corner();	
	 $('#heft_content').css({background:"rgba(0, 0, 0, 0.30)"})
	
}

