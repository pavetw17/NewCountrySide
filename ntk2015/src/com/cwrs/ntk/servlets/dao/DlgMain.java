package com.cwrs.ntk.servlets.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Hashtable;

import org.json.simple.JSONObject;

import com.cwrs.ntk.models.TblTintucEntity;

public class DlgMain {
	  
	public Object getRetrieveDataFromDatabase_Form(DBOperation dbo, int total, int nRecords, int limit, int offset, String condition, boolean bReturnJSON, String[] values,String table,String columnOrder) {
	    	Connection conn = dbo.getConnection();
	        ResultSet rs = null;
	        ArrayList<Object> lst = new ArrayList<Object>();
	        Statement st = null;
	        if (total < 0) {
	            total = dbo.countObject(table, condition);
	        }
	        
	        String sql = "Select ";
	        for(int i=0;i<values.length;i++){
	        	if(i+1 == values.length){
	        		sql += " " + values[i] + " ";
	        	}else{
	        		sql += " " + values[i] + ", ";
	        	}
	        }
	        sql += " from " + table + ((condition == null) ? "" : (" WHERE " + condition)) + ((columnOrder == null) ? "" : (" order by " + columnOrder))
	             + " LIMIT " + limit + " OFFSET " + offset;
	       // System.out.println("getRetrieveDataFromDatabase_Form=" + sql);
	        
	        try {
	        	st = conn.createStatement();
		    	/*for(int i = 0; i < value.length; i++ ){
						pstmt.setString(index[i],value[i]);
		    	}*/
		    	rs = st.executeQuery(sql);
		    	while(rs.next()){
		    		ResultSetMetaData rsmd = rs.getMetaData();
		    		Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
		    		for (int i = 1 ; i < rsmd.getColumnCount()+1; i++){
						String colName = rsmd.getColumnName(i);
						int colType = rsmd.getColumnType(i);
						//System.out.println("colType =" +colType);
						switch(colType){
							case Types.VARCHAR: htbl.put(colName, rs.getString(colName));break;
							case Types.FLOAT:  htbl.put(colName, rs.getFloat(colName));break;
							case Types.BIGINT:  htbl.put(colName, rs.getLong(colName));break;
							case Types.INTEGER:  htbl.put(colName, rs.getInt(colName));break;
							case Types.DOUBLE: htbl.put(colName, rs.getDouble(colName));break;
							case Types.BOOLEAN: htbl.put(colName, rs.getBoolean(colName));break;
							case Types.TIME: htbl.put(colName, rs.getString(colName));break;
							default: htbl.put(colName, rs.getFloat(colName));break;
						}
					}
		    		lst.add(htbl);
		    	}
		    	 if (bReturnJSON) {//Trả về file json
		                JSONObject json = new JSONObject();
		                json.put("total", total);
		                json.put("rows", lst);
		                //System.out.println(json.toJSONString());
		                //conn.close();
		                return json.toJSONString();
		            }else {
		                return lst;
		            }
	        } catch (SQLException e) {
	            System.out.println("getRetrieveDataFromDatabase_Form SQLException: " + e.toString());
	            return null;
	        } catch (Exception e) {
	            System.out.println("getRetrieveDataFromDatabase_Form Exception: " + e.toString());
	            return null;
	        } finally {
	            dbo.closeEverything(rs,st);
	        }
	    }
	    
	
	public Object getRetrieveDataFromDatabase_Home(DBOperation dbo, String condition, boolean bReturnJSON, String[] values,String table,String columnOrder) {
    	Connection conn = dbo.getConnection();
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;
        
        String sql = "Select ";
        for(int i=0;i<values.length;i++){
        	if(i+1 == values.length){
        		sql += " " + values[i] + " ";
        	}else{
        		sql += " " + values[i] + ", ";
        	}
        }
        sql += " from " + table + ((condition == null) ? "" : (" WHERE " + condition)) + ((columnOrder == null) ? "" : (" order by " + columnOrder)) ;
      //  System.out.println("getRetrieveDataFromDatabase_Home=" + sql);
        
        try {
        	st = conn.createStatement();
	    	/*for(int i = 0; i < value.length; i++ ){
					pstmt.setString(index[i],value[i]);
	    	}*/
	    	rs = st.executeQuery(sql);
	    	while(rs.next()){
	    		ResultSetMetaData rsmd = rs.getMetaData();
	    		Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
	    		for (int i = 1 ; i < rsmd.getColumnCount()+1; i++){
					String colName = rsmd.getColumnName(i);
					int colType = rsmd.getColumnType(i);
					//System.out.println("colType =" +colType);
					switch(colType){
						case Types.VARCHAR: htbl.put(colName, rs.getString(colName));break;
						case Types.FLOAT:  htbl.put(colName, rs.getFloat(colName));break;
						case Types.BIGINT:  htbl.put(colName, rs.getLong(colName));break;
						case Types.INTEGER:  htbl.put(colName, rs.getInt(colName));break;
						case Types.DOUBLE: htbl.put(colName, rs.getDouble(colName));break;
						case Types.BOOLEAN: htbl.put(colName, rs.getBoolean(colName));break;
						case Types.TIME: htbl.put(colName, rs.getString(colName));break;
						default: htbl.put(colName, rs.getFloat(colName));break;
					}
				}
	    		lst.add(htbl);
	    	}
	    	 if (bReturnJSON) {//Trả về file json
	                JSONObject json = new JSONObject();
	                json.put("rows", lst);
	               // System.out.println(json.toJSONString());
	                //conn.close();
	                return json.toJSONString();
	            }else {
	            	//  System.out.println(lst);
	                return lst;
	            }
        } catch (SQLException e) {
            System.out.println("getRetrieveDataFromDatabase_Horm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getRetrieveDataFromDatabase_Horm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs,st);
        }
    }
	
	
	public Object getRetrieveDataFromDatabase_PaginationHome(DBOperation dbo, int total, int limit, int offset, String condition, boolean bReturnJSON, String[] values, String table) {
    	Connection conn = dbo.getConnection();
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;
        if (total < 0) {
            total = dbo.countObject(TblTintucEntity.TINTUC_TBL, condition);
        }
        String sql = "Select ";
        for(int i=0;i<values.length;i++){
        	if(i+1 == values.length){
        		sql += " " + values[i] + " ";
        	}else{
        		sql += " " + values[i] + ", ";
        	}
        }
        sql += " from " + table + ((condition == null) ? "" : (" WHERE " + condition))  
        + " LIMIT " + limit + " OFFSET " + offset;
     //   System.out.println("getRetrieveDataFromDatabase_PaginationHome=" + sql);
        
        try {
        	st = conn.createStatement();
	    	/*for(int i = 0; i < value.length; i++ ){
					pstmt.setString(index[i],value[i]);
	    	}*/
	    	rs = st.executeQuery(sql);
	    	while(rs.next()){
	    		ResultSetMetaData rsmd = rs.getMetaData();
	    		Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
	    		for (int i = 1 ; i < rsmd.getColumnCount()+1; i++){
					String colName = rsmd.getColumnName(i);
					int colType = rsmd.getColumnType(i);
					//System.out.println("colType =" +colType);
					switch(colType){
						case Types.VARCHAR: htbl.put(colName, rs.getString(colName));break;
						case Types.FLOAT:  htbl.put(colName, rs.getFloat(colName));break;
						case Types.BIGINT:  htbl.put(colName, rs.getLong(colName));break;
						case Types.INTEGER:  htbl.put(colName, rs.getInt(colName));break;
						case Types.DOUBLE: htbl.put(colName, rs.getDouble(colName));break;
						case Types.BOOLEAN: htbl.put(colName, rs.getBoolean(colName));break;
						case Types.TIME: htbl.put(colName, rs.getString(colName));break;
						default: htbl.put(colName, rs.getFloat(colName));break;
					}
				}
	    		lst.add(htbl);
	    	}
	    	 if (bReturnJSON) {//Trả về file json
	                JSONObject json = new JSONObject();
	                json.put("rows", lst);
	                //System.out.println(json.toJSONString());
	                //conn.close();
	                return json.toJSONString();
	            }else {
	            	//  System.out.println(lst);
	                return lst;
	            }
        } catch (SQLException e) {
            System.out.println("getRetrieveDataFromDatabase_PaginationHome SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getRetrieveDataFromDatabase_PaginationHome Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs,st);
        }
    }
	
	   public String getDatatoEdit_Form(DBOperation dbo, String condition, String[] value,String table){
	        Connection conn = dbo.getConnection();
	        ResultSet rs = null;
	        ArrayList<Object> lst = new ArrayList<Object>();
	        Statement st = null;

	        String sql = "Select ";
	        for(int i=0;i<value.length;i++){
	        	if(i+1 == value.length){
	        		sql += " " + value[i] + " ";
	        	}else{
	        		sql += " " + value[i] + ", ";
	        	}
	        }
	        sql += " from " + table + ((condition == null) ? "" : (" WHERE " + condition)) 
	        	+ " limit 1";
	        //System.out.println("getDatatoEdit_Form=" +sql);
	        
	        try {
	            st = conn.createStatement();
	            rs = st.executeQuery(sql);
	            if(rs.next()) {
	            	ResultSetMetaData rsmd = rs.getMetaData();
		    		Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
		    		for (int i = 1 ; i < rsmd.getColumnCount()+1; i++){
						String colName = rsmd.getColumnName(i);
						int colType = rsmd.getColumnType(i);
						//System.out.println("colType =" +colType);
						switch(colType){
							case Types.VARCHAR: htbl.put(colName, rs.getString(colName));break;
							case Types.FLOAT:  htbl.put(colName, rs.getFloat(colName));break;
							case Types.BIGINT:  htbl.put(colName, rs.getLong(colName));break;
							case Types.INTEGER:  htbl.put(colName, rs.getInt(colName));break;
							case Types.DOUBLE: htbl.put(colName, rs.getDouble(colName));break;
							case Types.BOOLEAN: htbl.put(colName, rs.getBoolean(colName));break;
							case Types.TIME: htbl.put(colName, rs.getString(colName));break;
							default: htbl.put(colName, rs.getFloat(colName));break;
						}
					}
		    		lst.add(htbl);
	            }

	            JSONObject json = new JSONObject();
	            json.put("rows", lst);
	            return json.toJSONString();

	        } catch (SQLException e) {
	            System.out.println("getDatatoEdit_Form SQLException: " + e.toString());
	            return null;
	        } catch (Exception e) {
	            System.out.println("getDatatoEdit_Form Exception: " + e.toString());
	            return null;
	        } finally {
	            dbo.closeEverything(rs,st);
	        }
	    }
	   
	   public Object getDatatoEdit_Home(DBOperation dbo, String condition, String[] value,String table, boolean bReturnJSON){
	        Connection conn = dbo.getConnection();
	        ResultSet rs = null;
	        ArrayList<Object> lst = new ArrayList<Object>();
	        Statement st = null;

	        String sql = "Select ";
	        for(int i=0;i<value.length;i++){
	        	if(i+1 == value.length){
	        		sql += " " + value[i] + " ";
	        	}else{
	        		sql += " " + value[i] + ", ";
	        	}
	        }
	        sql += " from " + table + ((condition == null) ? "" : (" WHERE " + condition)) 
	        	+ " limit 1";
	    //    System.out.println("getDatatoEdit_Form=" +sql);
	        
	        try {
	            st = conn.createStatement();
	            rs = st.executeQuery(sql);
	            if(rs.next()) {
	            	ResultSetMetaData rsmd = rs.getMetaData();
		    		Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
		    		for (int i = 1 ; i < rsmd.getColumnCount()+1; i++){
						String colName = rsmd.getColumnName(i);
						int colType = rsmd.getColumnType(i);
						//System.out.println("colType =" +colType);
						switch(colType){
							case Types.VARCHAR: htbl.put(colName, rs.getString(colName));break;
							case Types.FLOAT:  htbl.put(colName, rs.getFloat(colName));break;
							case Types.BIGINT:  htbl.put(colName, rs.getLong(colName));break;
							case Types.INTEGER:  htbl.put(colName, rs.getInt(colName));break;
							case Types.DOUBLE: htbl.put(colName, rs.getDouble(colName));break;
							case Types.BOOLEAN: htbl.put(colName, rs.getBoolean(colName));break;
							case Types.TIME: htbl.put(colName, rs.getString(colName));break;
							default: htbl.put(colName, rs.getFloat(colName));break;
						}
					}
		    		lst.add(htbl);
	            }

	            if (bReturnJSON) {//Trả về file json
	                JSONObject json = new JSONObject();
	                json.put("rows", lst);
	                //System.out.println(json.toJSONString());
	                //conn.close();
	                return json.toJSONString();
	            }else {
	            	//  System.out.println(lst);
	                return lst;
	            }
	            
	        } catch (SQLException e) {
	            System.out.println("getDatatoEdit_Form SQLException: " + e.toString());
	            return null;
	        } catch (Exception e) {
	            System.out.println("getDatatoEdit_Form Exception: " + e.toString());
	            return null;
	        } finally {
	            dbo.closeEverything(rs,st);
	        }
	    }
}
