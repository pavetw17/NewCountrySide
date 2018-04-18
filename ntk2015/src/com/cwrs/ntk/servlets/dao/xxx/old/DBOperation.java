package com.cwrs.ntk.servlets.dao.xxx.old;



import java.io.IOException;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.LinkedList;
import java.util.List;


import com.cwrs.ntk.servlets.dao.xxx.ObjectKV;
import org.json.simple.JSONObject;

import com.cwrs.dbscl.common.Definitions;
import com.cwrs.dbscl.common.JResult;
import com.cwrs.dbscl.common.Utils;
import com.cwrs.dbscl.dataobject.OTblSau;
import com.cwrs.dbscl.dataobject.TblRuongGieocay;


public class DBOperation {
	
	// Define private variables for each user
	private Hashtable<Object, Object> htblPutField = null;
	Connection conn = null;
	
	/**
	 * Constructor
	 */
	public DBOperation() {
		htblPutField = new Hashtable<Object, Object>();
	}
	 
	public void setConnection(Connection _conn) {
		this.conn = _conn;
	}
	public Connection getConnection() {
		return this.conn;
	}
	public void closeConnection() {
		try {
			this.conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	
	/**
	 * Put key <-> field name and value <-> field data into hash table
	 * 
	 * @param field
	 *            Column name of table object in database
	 * @param value
	 *            Value of column
	 */
	public void putfval(Object field, Object value) {
		if (htblPutField != null) {
			htblPutField.put(field, value);
		}
	}

	/**
	 * Clear all fields contained in hash table
	 */
	public void clearFieldStorer() {
		if (htblPutField != null){
			htblPutField.clear();
		} else {
			//LogWriter.getDBLogger().error("Null pointer at call method clearFieldStorer()");
		}
	}

	/**
	 * Generate a insert SQL statement that depend on input field
	 * 
	 * @param tableName
	 *            : table name in database
	 * @return
	 */
	public String genInsertCmd(String tableName) {
		String szInsSQL = null;
		try {
			if ((htblPutField != null) && (!htblPutField.isEmpty())) {
				String szFields = "";
				String szValues = "";
				Enumeration<Object> enumV = htblPutField.elements();
				Enumeration<Object> enumK = htblPutField.keys();
				while (enumK.hasMoreElements()) {
					szFields += enumK.nextElement();
					szValues += enumV.nextElement();
					if (!enumK.hasMoreElements()) {
						break;
					} else {
						szFields += ",";
						szValues += "','";
					}
				}
				szInsSQL = "INSERT INTO " + tableName + "(" + szFields + ") " +
						   "VALUES('" + szValues + "')";
				if (htblPutField != null) {
					htblPutField.clear();
				}
				return szInsSQL;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return szInsSQL;
	}

	/**
	 * Generate a update SQL statement that depend on input field
	 * 
	 * @param tableName
	 *            : table name in database
	 * @return
	 */
	public String genUpdateCmd(String tableName, String szCondition) {
		String szUpdateSQL = null;
		try {
			if ((htblPutField != null) && (!htblPutField.isEmpty())) {
				String szFieldVal = "";
				Enumeration<Object> enumV = htblPutField.elements();
				Enumeration<Object> enumK = htblPutField.keys();
				while (enumK.hasMoreElements()) {
					szFieldVal += enumK.nextElement() + "='" + enumV.nextElement() + "'";
					if (!enumK.hasMoreElements()) {
						break;
					} else {
						szFieldVal += ",";
					}
				}
				szUpdateSQL = "UPDATE "	+ tableName	+ " SET " + szFieldVal +
							  ((szCondition == null) ? "": (" WHERE " + szCondition));
				if (htblPutField != null) {
					htblPutField.clear();
				}
				return szUpdateSQL;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return szUpdateSQL;
	}
    /**
     * 
     * @param total
     * @param lst
     * @return
     * @throws IOException
     */
	public String getJSON(int total, LinkedList<Object>  lst) throws IOException{
		JSONObject json=new JSONObject();
		StringWriter outx = new StringWriter();
		//json.put("total", total);
	    //json.put("data", lst);
				json.put("", lst);
		json.writeJSONString(outx);
	    System.out.println(outx.toString());
		return (outx.toString());

	}
	
	public String genJSONCombobox(ArrayList<ObjectKV>  lst){
	
			String jsoncb = "";
			jsoncb = "[";
			for (int i = 0; i < lst.size(); i++){
				ObjectKV okv = (ObjectKV)lst.get(i);
				
				jsoncb += "{\"id\":" + "\"" + okv.key + "\"" + ",\"text\":\"" +  okv.value + "\"" + (okv.isThis?",\"selected\":true":"") + "}";
				if (i == lst.size() -1) {
					break;
				} else {
					jsoncb += ",";
				}
				
			}
			jsoncb += "]";
		return (jsoncb);

	}
	
	
	/* create prepared statement */
	/*preStmt = conn.prepareStatement(sqlString,
			ResultSet.TYPE_SCROLL_INSENSITIVE,
			ResultSet.CONCUR_READ_ONLY);
	int length = param.length;
	
	for (int i = 0; i< length; i++){
		 preStmt.setString(i + 1, param[i]);
	}
	
	ResultSet rs = preStmt.executeQuery();
	*/
/**
 * return: >0 successful, else false
 */
/*	public int execInsertUpdatedMultiRecords2DBByClient(String sql, String condition, String strListValues, String strListIDs){
		
		String szSQL;
		ResultSet rs;
		Statement st = null;
		int ret = -1;
		
		try {
			szSQL = sql;
			System.err.println(szSQL);
			st = conn.createStatement();
			
			if (isReturnID){
			    szSQL += " RETURNING " + idName;
				rs = st.executeQuery(sql);
				int insertedID = -1;
				while (rs.next()) {
					insertedID = rs.getInt(1);
						
				}
				st.close();
				rs.close();
				return insertedID;
				
			} else {
				conn.setAutoCommit(false);
				//check sql is multiple query
				sql = sql.trim();
				String[] values = strListValues.split(",");//strListValues like 1,2<o>2,3..
				
				PreparedStatement preStmt = conn.prepareStatement(sql,
						ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_READ_ONLY);
				
				for (int i = 0; i< values.length; i++){
					 preStmt.setString(i + 1, values[i]);
				}
				
				String[] arrayStrSQL = sql.split(Definitions.SQL_QUERY_SEP);
				for (int i = 0; i < arrayStrSQL.length; i++) {
					System.out.println(arrayStrSQL[i]);
				   ret = st.executeUpdate(arrayStrSQL[i]);
				}
				conn.commit();
				st.close();
				return ret;
			}
			
		} catch (SQLException e){
			try {
				if (st != null)
					conn.rollback();
					st.close();
				    
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		return -1;
	}
		
	*/
	/**
	 * 
	 * 
	 */
	public String execInsertUpdatedMultiRecords2DBByClient(String sql, String condition, String strListValues, String sqlTypeOrder, String strListIDs){
		
		System.err.println("sql: "+ sql);
		System.err.println("condition: "+condition);
		System.err.println("List values: "+strListValues);
		System.err.println("sqlTypeOrder: "+sqlTypeOrder);
		System.err.println("List ID: "+strListIDs);
		if (strListIDs == null)
			System.out.println("LULL");
		PreparedStatement preStmt = null;
		String strRet = Definitions.DB_STR_FAILED;
		
		try {

			conn.setAutoCommit(false);
			sql = sql.trim();
			condition = condition.trim();
			strListValues = strListValues.trim();
			sqlTypeOrder = sqlTypeOrder.trim();
			strListIDs = strListIDs.trim();
			

			
			
			preStmt = conn.prepareStatement(sql,
						ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_READ_ONLY);
			
			if (strListIDs.equalsIgnoreCase("") || strListIDs.equalsIgnoreCase("null")){
				
				String[] lstValues = strListValues.split(Definitions.SQL_VALUES_LIST_SEP);//strListValues like 1,2<o>2,3..with 1,2 is list values
				String[] typeOrder = sqlTypeOrder.split(Definitions.SQL_TYPE_SEP);
				for (int i = 0; i< lstValues.length; i++){
					String[] values = lstValues[i].split(Definitions.SQL_VALUES_SEP);
						for (int j = 0; j < values.length; j++){
							if (typeOrder[j].equals(Definitions.SQL_TYPE_INT)){
								preStmt.setInt(j + 1, Integer.valueOf(values[j]));
							} else  if (typeOrder[j].equals(Definitions.SQL_TYPE_LONG)){
								preStmt.setLong(j + 1, Long.valueOf(values[j]));
							} else  if (typeOrder[j].equals(Definitions.SQL_TYPE_STRING)){
								preStmt.setString(j + 1, values[j]);
							} else  if (typeOrder[j].equals(Definitions.SQL_TYPE_FLOAT)){
								preStmt.setFloat(j + 1, Float.valueOf(values[j]));
							} else  if (typeOrder[j].equals(Definitions.SQL_TYPE_DOUBLE)){
								preStmt.setDouble(j + 1, Double.valueOf(values[j]));
							} else {
								throw (new SQLException("UNKNOWN SQL TYPE ORDER:" + typeOrder[j]));
							}
							// preStmt.setObject(j + 1, values[j]);
						}
						preStmt.executeUpdate();
				}
			} else {//insert/update giá trị giống nhau nhưng khác 1 trường (thường để cuối) ( 
				String[] values = strListValues.split(Definitions.SQL_ID_LIST_SEP);//strListValues like: 110,15,25,19
				String[] typeOrder = sqlTypeOrder.split(Definitions.SQL_TYPE_SEP);//like i-l-s
				for (int j = 0; j < typeOrder.length; j++){
					if (typeOrder[j].equals(Definitions.SQL_TYPE_INT)){
						preStmt.setInt(j + 1, Integer.valueOf(values[j]));
					} else  if (typeOrder[j].equals(Definitions.SQL_TYPE_LONG)){
						preStmt.setLong(j + 1, Long.valueOf(values[j]));
					} else  if (typeOrder[j].equals(Definitions.SQL_TYPE_STRING)){
						preStmt.setString(j + 1, values[j]);
					} else  if (typeOrder[j].equals(Definitions.SQL_TYPE_FLOAT)){
						preStmt.setFloat(j + 1, Float.valueOf(values[j]));
					} else  if (typeOrder[j].equals(Definitions.SQL_TYPE_DOUBLE)){
						preStmt.setDouble(j + 1, Double.valueOf(values[j]));
					} else {
						throw (new SQLException("UNKNOWN SQL TYPE ORDER:" + typeOrder[j]));
					}
					// preStmt.setObject(j + 1, values[j]);
				}
				
				String[] lstIDs = strListIDs.split(Definitions.SQL_ID_LIST_SEP);
				for (int i = 0; i< lstIDs.length; i++){
					
					if (typeOrder[typeOrder.length - 1].equals(Definitions.SQL_TYPE_INT)){
						preStmt.setInt(typeOrder.length, Integer.valueOf(lstIDs[i]));
					} else  if (typeOrder[typeOrder.length -1].equals(Definitions.SQL_TYPE_LONG)){
						preStmt.setLong(typeOrder.length, Long.valueOf(lstIDs[i]));
					}
					preStmt.executeUpdate();
				}
				
				
				
			}
			conn.commit();
			preStmt.close();
			return Definitions.DB_STR_OK;
	
		} catch (SQLException e){
			try {
				if (preStmt != null)
					conn.rollback();
					preStmt.close();
				    
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
			strRet = e.getMessage();
		}
		return strRet;
	}
	public int countObject(String tableName, String condition) {
		
		int count = -1;
		String sql = null;
		Statement st = null;
		ResultSet rs = null;
		try {
			if (tableName == null) {
			
				return -1;
			}  
			System.err.println("tableName ="+tableName);
			if (condition != null){
				if (condition.equalsIgnoreCase(""))
					condition = null;
			}
			
			conn.setAutoCommit(false);

			if (tableName != null) {
				
				sql = "SELECT COUNT(*) FROM " + tableName + 
						((condition == null) ? "" : (" WHERE " + condition));
				System.out.println("countObject sql:"+sql);
				st = conn.createStatement();
				rs = st.executeQuery(sql);
				
				while (rs.next()) {
					count = rs.getInt("count");
				}
				st.close();
				rs.close();

			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				st.close();
				rs.close();
				
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			
		} catch (Exception e) {
		   e.printStackTrace();
		}
		return count;
	}
	public JResult execUpdateSQL(String sql)throws SQLException {
		return (asyncExecSQLByClient(sql));
	}
	public JResult asyncExecSQLByClient(String sql) {
		Statement st = null;
		//Connection conn = dbo.getConnection();
		try {

			conn.setAutoCommit(false);
			System.out.println("Asynchronize execution SQL by client sql:"+sql);
			st = conn.createStatement();
			int ret = st.executeUpdate(sql);
			st.close();
			if (ret >= 0){
				conn.commit();
				return (new JResult(Definitions.DB_STR_OK,""));

			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				st.close();
			    conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return (new JResult(Definitions.DB_STR_FAILED,"execute: " +sql +" "+e.getMessage()));
			
		} catch (Exception e) {
		   e.printStackTrace();
		}
		return (new JResult(Definitions.DB_STR_FAILED,"execute: " +sql +" failed"));
		
	}
	public synchronized JResult syncExecSQLByClient(String sql) {
		Statement st = null;
		//Connection conn = dbo.getConnection();
		try {
			conn.setAutoCommit(false);
			System.out.println("Synchronize execution SQL by client sql:"+sql);
			st = conn.createStatement();
			int ret = st.executeUpdate(sql);
			st.close();
			if (ret > 0){
				conn.commit();
				return (new JResult(Definitions.DB_STR_OK,""));
			
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				st.close();
			    conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return (new JResult(Definitions.DB_STR_FAILED,"execute: " +sql +" "+e.getMessage()));
			
		} catch (Exception e) {
		   e.printStackTrace();
		}
		return (new JResult(Definitions.DB_STR_FAILED,"execute: " +sql +" failed"));
	}
	
	public String getDataDynamic(String sql) {
		Statement st = null;
		ArrayList<Object> lst = new ArrayList<Object>();
		JSONObject json = new JSONObject();
		try {
			System.out.println("Dynamic execution SQL by client sql: "+sql);
			st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			while(rs.next()){
				ResultSetMetaData rsmd = rs.getMetaData();
				Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
				for (int i = 1 ; i < rsmd.getColumnCount()+1; i++){
					String colName = rsmd.getColumnName(i);
					int colType = rsmd.getColumnType(i);
					System.out.println("colType =" +colType);
					switch(colType){
						case Types.VARCHAR: htbl.put(colName, rs.getString(colName));break;
						case Types.REAL:
						case Types.FLOAT:  htbl.put(colName, rs.getFloat(colName));break;
						case Types.BIGINT:  htbl.put(colName, rs.getLong(colName));break;
						case Types.INTEGER:  htbl.put(colName, rs.getInt(colName));break;
						case Types.DOUBLE: htbl.put(colName, rs.getDouble(colName));break;
						default: htbl.put(colName, rs.getFloat(colName));break;
			
				
					}
				}
				lst.add(htbl);
			}
			st.close();
			json.put("rows", lst);
			System.out.println("json.toJSONString() :"+json.toJSONString());
			return json.toJSONString();
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				st.close();
			    conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			
		} catch (Exception e) {
		   e.printStackTrace();
		}
		return null;
	}
/**
 * 
 * @param tablename
 *@param insertFields =ttgc_cd_gionglua_id,ttgc_cd_tralua_id,ttgc_cd_phuongphap,ttgc_cd_dientich,ttgc_cd_tyle,ttgc_cd_ngaygieocay
 *@param insertValues =
 *@param updateFields = ttgc_cd_gionglua_id,ttgc_cd_tralua_id,ttgc_cd_phuongphap,ttgc_cd_dientich,ttgc_cd_tyle,ttgc_cd_ngaygieocay,ttgc_cd_id
 *@param updateValues =40,1,'Cay',1.00,0.00,1,206<v>40,1,'Cay',1.00,0.00,1,206<v>
 * @return
 */
	public String execUpdateDataGrid(String tablename,String insertFields,String insertValues,String updateFields,String updateValues,String returnid) {
		Statement st = null;
		ArrayList<Object> lst = new ArrayList<Object>();
		String sql = "";
		String sqlInsert ="";
		String sqlUpdate="";
		boolean hasReturnID = true;
		try {
			conn.setAutoCommit(false);
			st = conn.createStatement();
			int ret = -1;
			if ("null".equalsIgnoreCase(returnid)) hasReturnID = false;
			
			if (insertValues != null && !"null".equalsIgnoreCase(insertValues)&&!"".equalsIgnoreCase(insertValues)){
				if (insertValues.endsWith(",")){
					insertValues = insertValues.substring(0, insertValues.length()-1);
					
				}
				sqlInsert = "INSERT INTO " + tablename+ "("+insertFields+") VALUES " + insertValues+ ((hasReturnID == false)?"":(" "+returnid))+";";
				System.out.println("sqlInsert =" +sqlInsert);
				//st.executeUpdate();
			}
			if (updateValues != null && !"null".equalsIgnoreCase(updateValues)&&!"".equalsIgnoreCase(updateValues)){
				String[] fields = updateFields.split(",");
				String[] values = updateValues.split("<v>");
				System.out.println("updateValues.split(<v>) -> values.length =" +values.length);
				sqlUpdate ="";
				for (int  i = 0; i < values.length; i++){
				  String[] vals = values[i].split(",");
				  sqlUpdate += "UPDATE " + tablename + " SET ";
				  for (int j = 0; j < vals.length-1; j++){
					  sqlUpdate += (fields[j] +"="+  vals[j]);
					  if (j<vals.length-2)
						  sqlUpdate += ","; 
				  }
				  sqlUpdate += (" WHERE " + fields[vals.length-1] +"="+  vals[vals.length-1]); 
				  sqlUpdate+=";";
				}
				System.out.println("sqlUpdate =" +sqlUpdate);
			}
			sql = (sqlInsert + sqlUpdate);
			System.out.println("sql =" +sql);
			//sql="";
			if(hasReturnID){
				ResultSet rs = st.executeQuery(sql);
				int idRetunred =-1;
				while (rs.next()) {
					idRetunred = rs.getInt(1);
				}
				conn.commit();
				st.close();
				return (new JResult(Definitions.DB_STR_OK, idRetunred).create());
			}else{
				ret = st.executeUpdate(sql); 
			}
			
			
			conn.commit();
			st.close();
			return (new JResult(Definitions.DB_STR_OK, "").create());
		} catch (SQLException e) {
			e.printStackTrace();
			try {st.close(); conn.rollback();} catch (SQLException e1) {	e1.printStackTrace();}
			return (new JResult(Definitions.DB_STR_FAILED, e.getMessage()).create());
		} catch (Exception e) {
		   e.printStackTrace();
		   try {st.close(); conn.rollback();} catch (SQLException e1) {	e1.printStackTrace();}
		   return (new JResult(Definitions.DB_STR_FAILED, e.getMessage()).create());
		} 
		
	}
}
