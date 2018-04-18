
// Map

Map = function () {
    // members
    this.keyArray = new Array(); // Keys
    this.valArray = new Array(); // Values
    
    this.keyArrayDuplicates = new Array(); // Keys
    this.valArrayDuplicates = new Array(); // Values
    this.indexDuplicates = 0;
    this.indexArrayDuplicates = new Array();
    /*    
    // methods
    this.put = put;
    this.get = get;
    this.size = size;  
    this.clear = clear;
    this.keys = keys;
    this.vals = vals;
    this.showMe = showMe;   
    this.findIt = findIt;
    this.remove = remove;
    this.isEmpty = isEmpty;*/
};

Map.prototype = {

	/* Public */
		put:	function ( key, val ){ return this._put( key, val ); },	
		get:	function ( key ){ return this._get(key); },
		size:	function (){ return this._size(); },
		clear:	function (){ return this._clear(); },
		keys:	function (){ return this._keys(); },
		vals:	function (){ return this._vals(); },
		showMe:	function (){ return this._showMe(); },
		findIt:	function  ( key ){ return this._findIt(key); },

		remove:	function ( key ){ return this._remove(key); },
		isEmpty:	function (){ return this._isEmpty(); },
		removeAt:function ( index ){ return this._removeAt(); },
		sizeDuplicates:function (){ return this._sizeDuplicates(); },
		clearDuplicates:	function (){ return this._clear(); },

	/* Private */
	
		_put:function ( key, val )
		{
		    var elementIndex = this.findIt( key );
        	this.indexDuplicates++;
		    if( elementIndex == (-1) )
		    {
		        this.keyArray.push( key );
		        this.valArray.push( val );
		    }
		    else
		    {
		        this.valArray[ elementIndex ] = val;
		        if (this.valArray[ elementIndex ] == val){
		        	this.keyArrayDuplicates.push(key);
		        	this.valArrayDuplicates.push(val);
		        	this.indexArrayDuplicates.push(val);

		        	this.indexArrayDuplicates.push(this.indexDuplicates);
		        	
		        }
		    }
		   // alert('put:v.size='+val.length)
		},
	/*	_putSkipDoubleElement:function ( key, val )
		{
			 var result = (-1);

			    for( var i = 0; i < this.keyArray.length; i++ )
			    {
			        if( this.keyArray[ i ] == key )
			        {
			            result = i;
			            break;
			        }
			    }
			    return result;
		},*/
		_get:function ( key )
		{
		    var result = null;
		    var elementIndex = this.findIt( key );

		    if( elementIndex != (-1) )
		    {   
		        result = this.valArray[ elementIndex ];
		    }  
		    
		    return result;
		},

		_remove:function ( key )
		{
		    var elementIndex = this.findIt( key );

		    if( elementIndex != (-1) )
		    {
		        this.keyArray = this.keyArray.removeAt(elementIndex);
		        this.valArray = this.valArray.removeAt(elementIndex);
		    }  
		    
		    return ;
		},

		_size:function ()
		{
		    return (this.keyArray.length);  
		},
		_sizeDuplicates:function ()
		{
		    return (this.keyArrayDuplicates.length);  
		},

		_clear:function ()
		{
		    for( var i = 0; i < this.keyArray.length; i++ )
		    {
		        this.keyArray.pop(); this.valArray.pop();   
		    }
		},
		_clearDuplicates:function ()
		{
		    for( var i = 0; i < this.keyArrayDuplicates.length; i++ )
		    {
		        this.keyArrayDuplicates.pop(); this.valArrayDuplicates.pop();   
		    }
		    this.indexArrayDuplicates = 0;
		    
		    
		},
		_isEmpty:function ()
		{
		   if (this.keyArray.length <= 0)
		    {
		        return true;   
		    } else return false;
		    	
		},


		_keys:function ()
		{
		    return (this.keyArray);
		},

		_vals:function ()
		{
		    return (this.valArray);   
		},

		_showMe:function ()
		{
		    var result = "";
		    
		    for( var i = 0; i < this.keyArray.length; i++ )
		    {
		    	var values = "";
		    	var v = this.valArray[i];
		    	
		    		 for( var j = 0; j < v.length; j++ ){
		    			 
		    			 values += v[j];
		    			 values+=",";
		    		}
		        result += "Key: " + this.keyArray[ i ] + "\tValues: " + values + "\n";
		    }
		    return result;
		},

		_findIt:function ( key )
		{
		    var result = (-1);

		    for( var i = 0; i < this.keyArray.length; i++ )
		    {
		        if( this.keyArray[ i ] == key )
		        {
		            result = i;
		            break;
		        }
		    }
		    return result;
		},

		_removeAt:function ( index )
		{
		  var part1 = this.slice( 0, index);
		  var part2 = this.slice( index+1 );

		  return( part1.concat( part2 ) );
		}
};

//Array.prototype.removeAt = removeAt;