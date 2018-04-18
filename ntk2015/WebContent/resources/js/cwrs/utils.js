Utils = function(){
	this.mapPutField = new Map();
	this.sqlTypeOrderInQuery = ''; 
	this.dbListValues = ''; 
    // methods
    /*this.createStringWithSeparator = createStringWithSeparator;
    this.putfval_int = putfval_int;
    this.putfval_long = putfval_long;
    this.putfval_string = putfval_string;
    this.putfval_float = putfval_float;
    this.putfval_int_condition = putfval_int_condition;
    this.putfval_string_condition = putfval_string_condition;
    
    this.getSQLTypeOrderInQuery = getSQLTypeOrderInQuery;
    this.getListValues = getListValues;
    this.clearFieldStorer = clearFieldStorer;
    
    this.genInsertCmd = genInsertCmd;
    this.genInsertCmd_PreStatement = genInsertCmd_PreStatement;
    this.genUpdateCmd = genUpdateCmd;
    this.genUpdateCmd_PreStatement = genUpdateCmd_PreStatement;
    */
    
	
};

Utils.prototype = {
		
	createStringWithSeparator:function (array, separator){
	var s = '';
	for (var i = 0; i < array.length; i++){
			s += array[i];
			if (i < (array.length -1)){
				s += separator;
			}
	}
   return s;
   },



/**
 * Put key <-> field name and value <-> field data into hash table
 * 
 * @param field
 *            Column name of table object in database
 * @param value
 *            Value of column
 */
putfval_int:function (field, value) {
	if (this.mapPutField != null) {
		this.mapPutField.put(field, value);
		this.sqlTypeOrderInQuery += SQL_TYPE_INT;
		this.sqlTypeOrderInQuery += SQL_TYPE_SEP;
		
		this.dbListValues += value;
		this.dbListValues += SQL_VALUES_SEP;
	}
},
putfval_long:function (field, value) {
	if (this.mapPutField != null) {
		this.mapPutField.put(field, value);
		this.sqlTypeOrderInQuery += SQL_TYPE_LONG;
		this.sqlTypeOrderInQuery += SQL_TYPE_SEP;
		
		this.dbListValues += value;
		this.dbListValues += SQL_VALUES_SEP;
	}
},
putfval_string:function (field, value) {
	if (this.mapPutField != null) {
		this.mapPutField.put(field, value);
		this.sqlTypeOrderInQuery += SQL_TYPE_STRING;
		this.sqlTypeOrderInQuery += SQL_TYPE_SEP;
		
		this.dbListValues += value;
		this.dbListValues += SQL_VALUES_SEP;
	}
},
putfval_boolean:function (field, value) {
	if (this.mapPutField != null) {
		this.mapPutField.put(field, value);
		this.sqlTypeOrderInQuery += SQL_TYPE_BOOLEAN;
		this.sqlTypeOrderInQuery += SQL_TYPE_SEP;
		
		this.dbListValues += value;
		this.dbListValues += SQL_VALUES_SEP;
	}
},
putfval_time:function (field, value) {
	if (this.mapPutField != null) {
		this.mapPutField.put(field, value);
		this.sqlTypeOrderInQuery += SQL_TYPE_TIME;
		this.sqlTypeOrderInQuery += SQL_TYPE_SEP;
		
		this.dbListValues += value;
		this.dbListValues += SQL_VALUES_SEP;
	}
},
putfval_float:function (field, value) {
	if (this.mapPutField != null) {
		this.mapPutField.put(field, value);
		this.sqlTypeOrderInQuery += SQL_TYPE_FLOAT;
		this.sqlTypeOrderInQuery += SQL_TYPE_SEP;
		
		this.dbListValues += value;
		this.dbListValues += SQL_VALUES_SEP;
	}
},

putfval_string_condition:function (field, value) {
		this.sqlTypeOrderInQuery += SQL_TYPE_STRING;
		this.sqlTypeOrderInQuery += SQL_TYPE_SEP;
		
		this.dbListValues += value;
		this.dbListValues += SQL_VALUES_SEP;
},

putfval_int_condition:function (field, value) {
	if (this.mapPutField != null) {
		//this.mapPutField.put(field, value);
		this.sqlTypeOrderInQuery += SQL_TYPE_INT;
		this.sqlTypeOrderInQuery += SQL_TYPE_SEP;
		
		this.dbListValues += value;
		this.dbListValues += SQL_VALUES_SEP;
	}
},
getSQLTypeOrderInQuery:function (){
	//remove last separator 
	//alert(this.sqlTypeOrderInQuery);
	if (this.sqlTypeOrderInQuery[this.sqlTypeOrderInQuery.length -1] == SQL_TYPE_SEP){
		this.sqlTypeOrderInQuery = this.sqlTypeOrderInQuery.substring(0, this.sqlTypeOrderInQuery.length - 1);
	}
	return this.sqlTypeOrderInQuery;
},

getListValues:function (){
	//remove last separator 
	//alert(this.sqlTypeOrderInQuery);
	if (this.dbListValues[this.dbListValues.length -1] == SQL_VALUES_SEP){
		this.dbListValues = this.dbListValues.substring(0, this.dbListValues.length - 1);
	}
	return this.dbListValues;
},
/**
 * Clear all fields contained in hash table
 */
clearFieldStorer:function () {
	if (this.mapPutField != null){
		this.mapPutField.clear();
		
	} else {
		//LogWriter.getDBLogger().error("Null pointer at call method clearFieldStorer()");
	}
	this.sqlTypeOrderInQuery = '';
	this.dbListValues = '';
},

/**
 * Generate a insert SQL statement that depend on input field
 * 
 * @param tableName
 *            : table name in database
 * @return
 */
genInsertCmd:function (tableName) {
	var szInsSQL = null;
	try {
		if ((this.mapPutField != null) && (!this.mapPutField.isEmpty())) {
			szFields = '';
			szValues = '';
			var enumK = this.mapPutField.keys();
			var enumV = this.mapPutField.vals();
			for (var i = 0; i < enumK.length; i++) {
				szFields += enumK[i];
				szValues += enumV[i];
				if (i < (enumK.length -1)){
					szFields += ",";
					szValues += "','";
				}
			}
			
			szInsSQL = "INSERT INTO " + tableName + "(" + szFields + ") " +
					   "VALUES('" + szValues + "')";
			/*if (this.mapPutField != null) {
				//this.mapPutField.clear();
			}*/
			return szInsSQL;
		}
	} catch (err) {
		alert(err);
		return null;
	}
	return szInsSQL;
},
genInsertCmd_PreStatement:function (tableName) {
	var szInsSQL = null;
	try {
		if ((this.mapPutField != null) && (!this.mapPutField.isEmpty())) {
			szFields = '';
			szValues = '';
			var enumK = this.mapPutField.keys();
			var enumV = this.mapPutField.vals();
			for (var i = 0; i < enumK.length; i++) {
				szFields += enumK[i];
				szValues += '?';//enumV[i];
				if (i < (enumK.length -1)){
					szFields += ",";
					szValues += ",";
				}
			}
			
			szInsSQL = "INSERT INTO " + tableName + "(" + szFields + ") " +
					   "VALUES(" + szValues + ")";
			/*if (this.mapPutField != null) {
				//this.mapPutField.clear();
			}*/
			return szInsSQL;
		}
	} catch (err) {
		alert(err);
		return null;
	}
	return szInsSQL;
},

/**
 * Generate a insert SQL statement that depend on multiple value 
 * 
 * @param tableName
 *            : table name in database
 * @return
 */
genInsertCmd_PreStatement_MultipleValue:function (tableName, valueHinhAnhArray) {
	var szInsSQL = null;
	var valueString = ' values ';
	
	try {
		if ((this.mapPutField != null) && (!this.mapPutField.isEmpty())) {
			szFields = '';
			szValues = '';
			var enumK = this.mapPutField.keys();
			var enumV = this.mapPutField.vals();
			for (var i = 0; i < enumK.length; i++) {
				szFields += enumK[i];
				szValues += '?';//enumV[i];
				if (i < (enumK.length -1)){
					szFields += ",";
					szValues += ",";
				}
			}
			
			for(var i = 0 ; i < valueHinhAnhArray.length ; i++){
				valueString += "(" + szValues +" )" ;
				if(i < valueHinhAnhArray.length -1){
					valueString += ", " ;
				}
			}
			
			szInsSQL = "INSERT INTO " + tableName + "(" + szFields + ") " +
						valueString ;
			/*if (this.mapPutField != null) {
				//this.mapPutField.clear();
			}*/
			return szInsSQL;
		}
	} catch (err) {
		alert(err);
		return null;
	}
	return szInsSQL;
},


/**
 * Generate a update SQL statement that depend on input field
 * 
 * @param tableName
 *            : table name in database
 * @return
 */
genUpdateCmd:function(tableName, szCondition) {
	var szUpdateSQL = null;
	try {
		if ((this.mapPutField != null) && (!this.mapPutField.isEmpty())) {
			szFieldVal = '';
			var enumK = this.mapPutField.keys();
			var enumV = this.mapPutField.vals();
			for (var i = 0; i < enumK.length; i++) {
				szFieldVal += enumK[i] + "='" + enumV[i] + "'";
				
				if (i < (enumK.length -1)){
					szFieldVal += ",";
				}
			}
			szUpdateSQL = "UPDATE "	+ tableName	+ " SET " + szFieldVal +
						  ((szCondition == null) ? "": (" WHERE " + szCondition));
			/*if (this.mapPutField != null) {
				this.mapPutField.clear();
			}*/
			return szUpdateSQL;
		}
	} catch (err) {
		alert(err);
		return null;
	}
	return szUpdateSQL;
},

genUpdateCmd_PreStatement:function (tableName, szCondition) {
	var szUpdateSQL = null;
	try {
		if ((this.mapPutField != null) && (!this.mapPutField.isEmpty())) {
			szFieldVal = '';
			var enumK = this.mapPutField.keys();
			var enumV = this.mapPutField.vals();
			for (var i = 0; i < enumK.length; i++) {
				szFieldVal += enumK[i] + "=?";
				
				if (i < (enumK.length -1)){
					szFieldVal += ",";
				}
			}
			szUpdateSQL = "UPDATE "	+ tableName	+ " SET " + szFieldVal +
						  ((szCondition == null) ? "": (" WHERE " + szCondition));
			/*if (this.mapPutField != null) {
				this.mapPutField.clear();
			}*/
			return szUpdateSQL;
		}
	} catch (err) {
		alert(err);
		return null;
	}
	return szUpdateSQL;
}
};

Utils.sortCanhdong = function(array)
{
	array.sort(function (cd1, cd2){
	    //Compare "a" and "b" in some fashion, and return -1, 0, or 1
	    //-1: Sort "a" to be a lower index than "b"
		// 0: "a" and "b" should be considered equal, and no sorting performed.
		// 1: Sort "b" to be a lower index than "a". 
		//index:0 is lowest
		if (cd1.size() < cd2.size()){
			return  1;
		} else if (cd1.size() > cd2.size()){
			return -1;
		} else
			return  0;
	});
	return array;
};
var g_time_offset = 0;
Utils.startTime = function()
{
	g_time_offset = (new Date()).getTime();
};

Utils.offsetTime = function()
{
	return ((new Date()).getTime()-g_time_offset);
};


Utils.isValidateDMY = function(dateStr)// dd/MM/YYYY 
{
	if(dateStr.indexOf("/") == -1){
		return false;
	}
	dt1 = dateStr.split("/");
	dd1  = parseFloat(dt1[0]).toFixed(0);
	mm1 = parseFloat(dt1[1]).toFixed(0);
	yy1 = parseFloat(dt1[2]).toFixed(0);
	if(isNaN(dd1) || isNaN(mm1) || isNaN(yy1)){
		return false;
	}
	dt2 = gm.date.string2Date(dateStr);
	if (dt2 ==null) return false;
	dd2 = dt2.getDate();
	mm2 = dt2.getMonth()+1;
	yy2 = dt2.getFullYear();
	

	if(dd1==dd2 && mm1==mm2 && yy1==yy2){
	    if (dd1 > 31 || dd2 > 31) return false;
	    if (mm1 > 12 || mm2 > 12) return false;
	    return true;
	} 
	else {
		//alert(dd1+'/'+mm1+'/'+yy1);
		//alert(dd2+'/'+mm2+'/'+yy2);
		return false;
	}

};

Utils.createStringWithSeparator=function(array, separator){
	var s = '';
	for (var i = 0; i < array.length; i++){
			s += array[i];
			if (i < (array.length -1)){
				s += separator;
			}
	}
   return s;
}

