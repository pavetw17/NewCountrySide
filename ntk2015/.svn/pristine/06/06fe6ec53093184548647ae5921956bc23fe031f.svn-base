function WKBParser()
{
};
WKBParser.prototype = {
		readPolygon: function(wkbStream){
			   //read number of ring
			    var nRings = wkbStream.readInt32();	//alert('nRing='+nRings);
			    var arrayLinearRings = [];
				for (var i = 0; i < nRings; i++) 
				{
					//read linear ring
					var nPoints = wkbStream.readInt32();//alert('nPoints'+nPoints);//read number of point
					var arrayPoints = [];
					var j = 0;
					try{
						for ( j = 0; j < nPoints; j++){
							var x = wkbStream.readDouble();
							var y = wkbStream.readDouble();
							var newPoint = new OpenLayers.Geometry.Point(x, y);// alert('newPoint:'+newPoint.x+','+newPoint.y);
							arrayPoints.push(newPoint);
								
						}
						if (!arrayPoints[0].equals(arrayPoints[arrayPoints.length-1]))alert('Điểm đầu không trùng điểm cuối');
			
						/*TEST*/
						/*var s ='';
					 	for (var k =0; k< arrayPoints.length; k++){
						 point = arrayPoints[k];
						 s+=( point.x+' '+point.y);
						 if (k<arrayPoints.length-1)s+=',';
					 	}
					 	alert(s);*/
						/*END TEST*/
						var linear_ring = new OpenLayers.Geometry.LinearRing(arrayPoints);
						arrayLinearRings.push(linear_ring);
						
					}catch(error){ 
						alert(error+':'+j );
					}   
				}
				//var linear_ring = new OpenLayers.Geometry.LinearRing(arrayLinearRings[0]);
				var polygon = new OpenLayers.Geometry.Polygon(arrayLinearRings);
				return polygon;
		},
		readMultiPolygon: function(wkbStream){
			    //count polygon
			    var nPolygons = wkbStream.readInt32();// alert('nPolygons:'+nPolygons);
			   
			    var arrayPolygons = [];
			    for(var i = 0; i < nPolygons; i++){
			    	wkbStream.skip(1);// alert('order='+wkbStream.readInt8());//skip order
			    	wkbStream.skip(4);// alert('type='+wkbStream.readInt32());//skip type
			    	var polygon = this.readPolygon(wkbStream);
			    	arrayPolygons.push(polygon);
			    }
			    return (new OpenLayers.Geometry.MultiPolygon(arrayPolygons));
		},
		getGeometry: function(wkbStream){
				/*	alert("wkbStream.getSize="+wkbStream.getSize());
				var sum =0;
				var sbyte='';
				for (var i =0; i< wkbStream.getSize();i++){
					var byte =wkbStream.readByte();
					sbyte+=byte;
					sbyte+=',';
					sum+=byte;
				}
				alert('sum:'+sum);
				alert('sbyte'+sbyte);
				 */
				//get type
	  		    var byteOrder	= wkbStream.readInt8();//alert('order:'+order);
			    var type		= wkbStream.readInt32();//alert('type:'+type);
			    switch(type){
					case TYPE_GEOMETRY_POLYGON:
						 var polygonFeauture= new OpenLayers.Feature.Vector(this.readPolygon(wkbStream),{zIndex: 0},g_style_geometry_hide);
						 return polygonFeauture;
					case TYPE_GEOMETRY_MULTIPOLYGON:
						 var multiPolygonFeauture= new OpenLayers.Feature.Vector(this.readMultiPolygon(wkbStream),{zIndex: 0},g_style_geometry_hide);
						 return multiPolygonFeauture;
					default:
						alert('GetGeometry():Unknown Geometry Type:'+type);
						break;
				}
		} 
};