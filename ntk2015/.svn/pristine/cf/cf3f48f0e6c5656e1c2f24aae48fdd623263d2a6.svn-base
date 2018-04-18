package com.cwrs.ntk.servlets.dao.xxx;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.cwrs.dbscl.common.Definitions;
import com.cwrs.dbscl.common.TblHuyen;
import com.cwrs.dbscl.common.TblTinh;
import com.cwrs.dbscl.common.Utils;
import com.cwrs.dbscl.common.TblXa;
import com.cwrs.dbscl.dataobject.OTblSau;


public class MainWebGUI {
	static String buffer = null;
	
	/*
		public Object TEST(DBOperation dbo, PrintWriter writeResponse){
			Connection conn = dbo.getConnection();
			ArrayList<Tinh> lstTinh = new ArrayList<Tinh>();
			String sql = null;
			String condition = null;
			ResultSet rs = null;
			sql = "SELECT " + "tinh_id" + ","
			 + "tinh_ten" + " " +
			 " FROM " + "tbl_tinh_region" +
			 ((condition == null) ? "" : (" WHERE " + condition));
 
			Statement st;
			try {
				st = conn.createStatement();
				rs = st.executeQuery(sql);
				while (rs.next()) {
					Tinh tinh = new Tinh();
					tinh.id = rs.getInt("tinh_id");
					tinh.ten= rs.getString("tinh_ten");
					lstTinh.add(tinh);
				
					//System.out.println(okv1.key +", " + okv1.value);
				}
				st.close();
				rs.close();
				//////////////////////////////////
				for (int  i= 0; i< lstTinh.size(); i++){
					
					int idtinh = lstTinh.get(i).id;
					ArrayList<Huyen> lstHuyen = lstTinh.get(i).lstHuyen;
					
					
					sql = "SELECT " + "ten_huyen" + ","
					+ "huyen_id" + " " +
					" FROM " + "tbl_huyen_region" +
					 " WHERE  tinh_id =" +  idtinh;
				
				
					st = conn.createStatement();
					rs = st.executeQuery(sql);
					int inc = 1;
					String incStr ="";
					while (rs.next()) {
						if (inc <10){
							incStr = "0"+ inc;
		 				}else {
							incStr = String.valueOf(inc);
						}
						Huyen huyen = new Huyen();
						huyen.id = String.valueOf(idtinh) + incStr;//rs.getInt("huyen_id");
						huyen.ten= rs.getString("ten_huyen");
						//System.out.println(incStr+ ","+ huyen.ten + "," +huyen.id);
						lstHuyen.add(huyen);
						inc++;
				
					//System.out.println(okv1.key +", " + okv1.value);
					}
					st.close();
					rs.close();
					Thread.sleep(1);		
					
				
				}
				//Update
				conn.setAutoCommit(false);
				st = conn.createStatement();
				
				
				/*for (int  i= 0; i< lstTinh.size(); i++){
					int idTinh = 	lstTinh.get(i).id;
					ArrayList<Huyen> lstHuyen = lstTinh.get(i).lstHuyen;
					for (int  j= 0; j< lstHuyen.size(); j++){	
						dbo.clearFieldStorer();
						dbo.putfval("huyen_id", 0);
						String szSQL = dbo.genUpdateCmd("tbl_huyen_region", "tinh_id="+idTinh);
				
						
						st.executeUpdate(szSQL);
					
						
				
					}	
					
				
				}*/
	/*			 System.out.println("UPDATING..");
				for (int  i= 0; i< lstTinh.size(); i++){
					int idTinh = 	lstTinh.get(i).id;
					ArrayList<Huyen> lstHuyen = lstTinh.get(i).lstHuyen;
					
					for (int  j= 0; j< lstHuyen.size(); j++){	
						dbo.clearFieldStorer();
						//System.out.println(lstHuyen.get(j).id);
						dbo.putfval("huyen_id", lstHuyen.get(j).id);
						if (lstHuyen.get(j).ten.contains("'")){
							System.out.print("change: "+ lstHuyen.get(j).ten);
							lstHuyen.get(j).ten = lstHuyen.get(j).ten.replace("'", "''");
							System.out.println("by: "+ lstHuyen.get(j).ten);
						}
						String szSQL = dbo.genUpdateCmd("tbl_huyen_region", "tinh_id="+idTinh +" AND ten_huyen= '" +  lstHuyen.get(j).ten)+"'";
				       System.out.println(szSQL);
						
						st.executeUpdate(szSQL);
					
						 
				
					}	
					
				
				}
				st.close();
				conn.commit();
				
				System.out.println("UPDATE OK!!!");
				writeResponse.print("UPDATE OK!!!");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			return "ERROR";
		}
*/
	public Object TEST(DBOperation dbo, PrintWriter writeResponse){
		Connection conn = dbo.getConnection();
		ArrayList<TblTinh> lstTinh = new ArrayList<TblTinh>();
		String sql = null;
		String condition = null;
		ResultSet rs = null;
		sql = "SELECT " + "tinh_id" + ","
		 + "tinh_ten" + " " +
		 " FROM " + "tbl_tinh_region" +
		 ((condition == null) ? "" : (" WHERE " + condition));

		Statement st;
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			while (rs.next()) {
				TblTinh tinh = new TblTinh();
				tinh.id = rs.getInt("tinh_id");
				tinh.ten= rs.getString("tinh_ten");
				lstTinh.add(tinh);
			
				//System.out.println(okv1.key +", " + okv1.value);
			}
			st.close();
			rs.close();
			//////////////////////////////////
			for (int  i= 0; i< lstTinh.size(); i++){
				
				int idtinh = lstTinh.get(i).id;
				ArrayList<TblHuyen> lstHuyen = lstTinh.get(i).lstHuyen;
				
				
				sql = "SELECT " + "ten_huyen" + ","
				+ "huyen_id" + " " +
				" FROM " + "tbl_huyen_region" +
				 " WHERE  tinh_id =" +  idtinh;
			
			
				st = conn.createStatement();
				rs = st.executeQuery(sql);

				while (rs.next()) {
					TblHuyen huyen = new TblHuyen();
					huyen.id = String.valueOf(rs.getInt("huyen_id"));
					huyen.ten= rs.getString("ten_huyen");
					//System.out.println(incStr+ ","+ huyen.ten + "," +huyen.id);
					lstHuyen.add(huyen);

				}
				st.close();
				rs.close();
				Thread.sleep(1);		
				
			
			}
			
			
			
			for (int  i= 0; i< lstTinh.size(); i++){
				
			
				String tinh_ten = lstTinh.get(i).ten;
				ArrayList<TblHuyen> lstHuyen = lstTinh.get(i).lstHuyen;
				
				for (int  j= 0; j< lstHuyen.size(); j++){
					String huyen_id = lstHuyen.get(j).id;
					String ten_huyen = lstHuyen.get(j).ten;
					ArrayList<TblXa> lstXa = lstHuyen.get(j).lstXa;
					
					
					if (ten_huyen.contains("'")){
						System.out.print("---change: "+ ten_huyen);
						ten_huyen = ten_huyen.replace("'", "''");
						System.out.println("by: "+ ten_huyen);
					}
					
					sql = "SELECT " + "ten_xa" + ","
					+ "xa_id" + " " +
					" FROM " + "tbl_xa_region" +
					" WHERE  ten_huyen ='" +  ten_huyen + "' AND tinh_ten ='" + tinh_ten +"'"  ;
			
			
					st = conn.createStatement();
					rs = st.executeQuery(sql);

					int inc;
					inc = 1;
					String incStr ="";
					while (rs.next()) {
						if (inc <10){
							incStr = "0"+ inc;
		 				}else {
							incStr = String.valueOf(inc);
						}
						TblXa xa = new TblXa();
						xa.id = "0";// huyen_id + incStr;//rs.getInt("huyen_id");
						xa.ten= rs.getString("ten_xa");
						//System.out.println(incStr+ ","+ huyen.ten + "," +huyen.id);
						lstXa.add(xa);
						inc++;
				
					//System.out.println(okv1.key +", " + okv1.value);
					}
					st.close();
					rs.close();
				}

				Thread.sleep(1);		
				
			
			}
			
			
			
			
			
			
			//Update
			conn.setAutoCommit(false);
			st = conn.createStatement();
			
			
			/*for (int  i= 0; i< lstTinh.size(); i++){
				int idTinh = 	lstTinh.get(i).id;
				ArrayList<Huyen> lstHuyen = lstTinh.get(i).lstHuyen;
				for (int  j= 0; j< lstHuyen.size(); j++){	
					dbo.clearFieldStorer();
					dbo.putfval("huyen_id", 0);
					String szSQL = dbo.genUpdateCmd("tbl_huyen_region", "tinh_id="+idTinh);
			
					
					st.executeUpdate(szSQL);
				
					
			
				}	
				
			
			}*/
			 System.out.println("UPDATING XA...");
			for (int  i= 0; i< lstTinh.size(); i++){
				int tinh_id = lstTinh.get(i).id;
				ArrayList<TblHuyen> lstHuyen = lstTinh.get(i).lstHuyen;
				
				for (int  j= 0; j< lstHuyen.size(); j++){
					ArrayList<TblXa> lstXa = lstHuyen.get(j).lstXa;
					String ten_huyen = lstHuyen.get(j).ten;
			
					if (ten_huyen.contains("'")){
						System.out.print("---change: "+ ten_huyen);
						ten_huyen = ten_huyen.replace("'", "''");
						System.out.println("by: "+ ten_huyen);
					} 
					
					for (int k= 0; k< lstXa.size(); k++){
						String ten_xa = lstXa.get(k).ten;
					  	
						dbo.clearFieldStorer();
						//System.out.println(lstHuyen.get(j).id);
						dbo.putfval("xa_id", lstXa.get(k).id);
						if (ten_xa.contains("'")){
							System.out.print("change: "+ ten_xa);
							ten_xa = ten_xa.replace("'", "''");
							System.out.println(" by: "+ ten_xa);
						}
		
						String szSQL = dbo.genUpdateCmd("tbl_xa_region", "ten_huyen= '" +ten_huyen+"'" + " AND " + "ten_xa ='" + ten_xa +"'"  );
						//System.out.println(szSQL);
						sql = szSQL;
						sql += " RETURNING xa_id" ;
						//st.executeUpdate(sql);
						 rs = st.executeQuery(sql);
						 boolean b = false;
						while (rs.next()) {
							b = true;
							//System.out.println("xa_id updated = "+rs.getInt(1));
							if( (tinh_id == 711)|| (tinh_id == 707)|| (tinh_id == 715)|| (tinh_id == 815)){
							
								System.out.println("tinh_id ="+tinh_id+"xa_id updated = "+rs.getInt(1));
								System.out.println("sql = "+sql);
								
							}
						}
						if (!b)System.err.println("PROBLEM: sql = "+sql);
					  }
					 
			
			 	}	
				
			
			}
			st.close();
			conn.commit();
			
			System.out.println("UPDATE XA OK!!!");
			writeResponse.print("UPDATE XA OK!!!");
		} catch (SQLException e) {
			System.out.println(sql);
			
			
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return "ERROR";
	}



	
	
	public String getListIDRuongCungCanhDongOnMap(DBOperation dbo,float x, float y){
		
		Connection conn = dbo.getConnection();
		String sql = null;
		ResultSet rs = null;
		//SELECT id_ruong,ten_xa,ten_huyen,ten_tinh  from tbl_ruong_region where ST_Intersects(the_geom , ST_GeomFromText('POINT(542284 1121393)')) = 't'
		//::geometry
		try {
		String query = //"SELECT ST_Intersects((select the_geom from tbl_ruong_region where gid=37), ('SRID=4756;POINT("+x +" " + y +")'))";   
		
		"SELECT id_ruong,canhdong_id,ten_xa,ten_huyen,ten_tinh  from tbl_ruong_region where ST_Intersects(the_geom , ST_GeomFromText('POINT(" + x + " " + y +")',4756)) = 't'";
		System.out.println(query);
		Statement st = conn.createStatement();
		rs = st.executeQuery(query);
		int canhdong_id = -1;
		int ruong_id = -1;
		while (rs.next()) {
			canhdong_id = rs.getInt("canhdong_id");
			ruong_id = rs.getInt("id_ruong");
		}
		System.out.println("ruong_id=" +ruong_id +",canhdong_id = "+canhdong_id);
		query = "SELECT id_ruong FROM tbl_ruong_region WHERE canhdong_id =" + canhdong_id;
		rs = st.executeQuery(query);
		String lstIDRuong = "";
		while (rs.next()) {
			lstIDRuong += rs.getInt("id_ruong");
			lstIDRuong +=",";
		}
		System.out.println(lstIDRuong);
		if (lstIDRuong.contains(",")){
		    lstIDRuong = lstIDRuong.substring(0,lstIDRuong.lastIndexOf(","));
		}
		if (lstIDRuong.equalsIgnoreCase("")){
			lstIDRuong = String.valueOf(ruong_id);
		}
        System.out.println("lstIDRuong =" +lstIDRuong);
		st.close();
		rs.close();
		return lstIDRuong;
	} catch (SQLException e) {
		//LogWriter.getDBLogger().error(
		//		"Get package-package connection failed. Exception: " + e.getMessage());
		//throw e;
		e.printStackTrace();
		return null;
	} catch (Exception e) {
		//LogWriter.getDBLogger().error(
		//		"Get package-package connection failed. Exception: " + e.getMessage());
		//throw e;
		e.printStackTrace();
		return null;
	}
	}
	public String getDataCanhdongForXa(DBOperation dbo, int xa_id, boolean hasGeometry){
		System.out.println("getDataCanhdongForXa: "+ xa_id);
		Connection conn = dbo.getConnection();
		ResultSet rs = null;
		Statement st = null;
		String data = "";
		byte[] binData={};//used for get binary data
		String textData = ""; //contains canhdong_id,list ruong id
		try {
		String query = "SELECT canhdong_id,ruong_id"+ (hasGeometry?",ST_AsBinary(the_geom,'NDR') AS geom":"") + "  FROM tbl_canhdong_region WHERE xa_id ="+xa_id;
		System.out.println(query);
		st = conn.createStatement();
		rs = st.executeQuery(query);
		while (rs.next()) {
			String lstRuongID  = rs.getString("ruong_id");
			int canhdong_id = rs.getInt("canhdong_id");
			if (canhdong_id == 65969) System.err.println("AAAAAAAAAAAAAAAAAAAAA: " +lstRuongID);
			//remove dấu ',' ở cuối lstRuongID
			if ("null".equalsIgnoreCase(lstRuongID) || (lstRuongID == null)){
				System.err.println("lstRuongID = null.Skipped!");
				continue;
			}
			lstRuongID = lstRuongID.trim();
			if (lstRuongID.equalsIgnoreCase("") || lstRuongID.equalsIgnoreCase(",")) continue;
			System.err.println(lstRuongID);
			lstRuongID = lstRuongID.substring(0, lstRuongID.length() - 1);
			textData += (canhdong_id + ","+lstRuongID);
			if (hasGeometry){
				byte[] geomBytes =rs.getBytes("geom");
				binData = Utils.concatByteArrays(binData, geomBytes);
			} 
			textData += Definitions.COM_TYPE_SEP;
		 
			
		}
		//at here: textData like '1017,1990-1012,1984,1986-'
		String strGeometries = new String(binData,"ISO-8859-1");
		data = textData + Definitions.SEP_TEXT_AND_BINARY + strGeometries;
		
		System.out.println("textData=" +textData);
		//System.out.println("strGeometries=" +strGeometries);
		st.close();
		rs.close();
		return data;
	} catch (SQLException e) {
		try {
			st.close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		//LogWriter.getDBLogger().error(
		//		"Get package-package connection failed. Exception: " + e.getMessage());
		//throw e;
		e.printStackTrace();
		return e.getMessage();
	} catch (Exception e) {
		//LogWriter.getDBLogger().error(
		//		"Get package-package connection failed. Exception: " + e.getMessage());
		//throw e;
		e.printStackTrace(); 
		return Utils.parseException(e);
	}
	}
	
	
	
	public String getBoundingBox(DBOperation dbo, int tinhID, int huyenID, int xaID){
		
		String strBoundingBox = "";
		
		Connection conn = dbo.getConnection();
		try {
			//LogWriter.getDBLogger().info(this.userName + " is loading package-package connection data...");
			String sql = null;
			ResultSet rs = null;
			//ArrayList<ObjectKV> lstOKV = new ArrayList<ObjectKV>();
			// WHERE  ma_xa = 30514
			String condition = null;
			String tblName = "";
			if (xaID > 0){
				tblName = "tbl_xa_region";
				condition = "xa_id="+ xaID;
			} else if (huyenID > 0){
				tblName = "tbl_huyen_region";
				condition = "huyen_id="+ huyenID;
			} else if (tinhID > 0){
				tblName = "tbl_tinh_region";
				condition = "tinh_id="+ tinhID;
			} else tblName = null;
			
			if (tblName != null){
				sql = " SELECT  st_box2d(the_geom) as box FROM " + tblName
					 	+ ((condition == null) ? "" : (" WHERE " + condition));
				System.out.println(sql);
				Statement st = conn.createStatement();
				rs = st.executeQuery(sql);
				// Add objects contained in the result set into one
				//lstOKV.add(new ObjectKV(String.valueOf(999), "*", true));
				while (rs.next()) {
					// ObjectKV okv1 = new ObjectKV(String.valueOf(rs.getInt("ma_xa")), rs.getString("ten_xa"));
					// lstOKV.add(okv1);
					strBoundingBox = rs.getString("box");
					strBoundingBox = strBoundingBox.replace("BOX(", "");
					strBoundingBox = strBoundingBox.replace(")", "");
					strBoundingBox = strBoundingBox.trim();
					strBoundingBox = strBoundingBox.replaceAll(" ", ",");
					//String s[] = strBoundingBox.split(",");
				
					//strBoundingBox.replace(target, replacement)
				
					System.out.println(strBoundingBox);
				}
				st.close();
				rs.close();
			}
			return strBoundingBox;
		} catch (SQLException e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			e.printStackTrace();
			return null;
		} catch (Exception e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			e.printStackTrace();
			return null;
		}
	}
public String getGeometryOfTinhHuyenXa(DBOperation dbo, int tinhID, int huyenID, int xaID, int type){
		
		String strGeometry = "";
		
		Connection conn = dbo.getConnection();
		String sql = null;
		ResultSet rs = null;
		Statement st = null;
		String condition = null;
		String tblName = "";
		try {
			if (xaID > 0){
				tblName = "tbl_xa_region";
				condition = "xa_id="+ xaID;
			} else if (huyenID > 0){
				tblName = "tbl_huyen_region";
				condition = "huyen_id="+ huyenID;
			} else if (tinhID > 0){
				tblName = "tbl_tinh_region";
				condition = "tinh_id="+ tinhID;
			} else tblName = null;
			
			if (tblName != null){
				
				sql = "SELECT "+ (type == Definitions.TYPE_GEOMETRY_WKB?"ST_AsBinary":"ST_AsText")+"(the_geom) AS geom FROM "+ tblName
				+ ((condition == null) ? "" : (" WHERE " + condition));

				st = conn.createStatement();
				
				System.out.println("getGeometryOfTinhHuyenXa: "+sql);
				rs = st.executeQuery(sql);

				while (rs.next()) {
					if (type == Definitions.TYPE_GEOMETRY_WKB){
					    byte[] bytes = rs.getBytes("geom");
					    strGeometry = new String(bytes);
					} else {
						strGeometry = rs.getString("geom");
					}
				}
				st.close();
				rs.close();
			}
			return strGeometry;
		}catch (Exception e) {
			try {
				st.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
			return null;
		}
	}
	public String getPreCachedGeometry(DBOperation dbo,String condition, int type, String idName, String tableName, String fidExcepted){
		Connection conn = dbo.getConnection();
		String strGeometry = null;
		ResultSet rs = null;
		Statement st = null;
	    ArrayList<Integer> lstFID = new ArrayList<Integer>();
		byte[] binData={};//used for get binary data
		if (buffer!=null) {
			System.err.println("Buffer cached...return it now :)");
			return buffer;
		}
		
		if (!fidExcepted.equalsIgnoreCase("")){
			String[] fids= fidExcepted.split(Definitions.COM_TYPE_SEP);
	    		for (int i = 0; i< fids.length; i++){
	    			lstFID.add(Integer.valueOf(fids[i]));
	    		}
		}
		//type = Definitions.TYPE_GEOMETRY_WKT;
		try {
			if (idName.equalsIgnoreCase("")||idName.equalsIgnoreCase("null")){ 
				idName = "";
			}else {
				idName = idName+" AS id,";
			}
			 
			if (condition.equalsIgnoreCase("null") ||condition.equalsIgnoreCase(""))
				condition = null;
			
			String query ="SELECT "+ idName + (type == Definitions.TYPE_GEOMETRY_WKB?"ST_AsBinary(the_geom,'NDR') ":"ST_AsText(the_geom) ")+" AS geom FROM "+ tableName+ ((condition == null) ? "" : (" WHERE " + condition));
			System.out.println(query);
			//Utils.setMeasuretTimeStart("start query");
			st = conn.createStatement();
			//st.setFetchDirection( ResultSet.CONCUR_READ_ONLY);
			//System.out.println("st.getFetchDirection() ="+st.getFetchDirection());
			st.setFetchSize(100);
			//System.out.println("st.getFetchSize() ="+st.getFetchSize());
			//conn.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);
			//System.out.println("conn.getTransactionIsolation()="+conn.getTransactionIsolation());
			
	        st.execute("begin");
	        st.execute("declare wkb_cursor binary cursor for " + query);
	       
			rs = st.executeQuery("fetch forward all in wkb_cursor");
			
			//rs = st.executeQuery(query);
			//Utils.printMeasure();
			
			Utils.setMeasuretTimeStart("precache reading resultset");
			strGeometry = "";
			while (rs.next()) {
				if (type == Definitions.TYPE_GEOMETRY_WKB){
					
					int id = rs.getInt("id");
					int size = lstFID.size();
					boolean ignored = false;
					for (int i = 0; i < size; i++){
						if (lstFID.get(i).intValue() == id){
							lstFID.remove(i);
							ignored = true;
							
							break;
						}
					}
					if (ignored) {
						System.out.println("fid: "+ id + " has loaded. Skip now...");
						continue;
					}
					byte[] geomBytes =rs.getBytes("geom");
				    //strGeometry = new String(geomBytes,"ISO-8859-1");//encode with ISO-8859-1 is VERY IMPORTANT
					byte[] idBytes = Utils.intToByteArray(id, Definitions.TYPE_LITTLEENDIAN_NDR);
					/*byte[] data = Utils.concatByteArrays(idBytes, geomBytes);
					binData = Utils.concatByteArrays(binData, data);
					 */
					
					binData = Utils.concatByteArrays(binData, idBytes, geomBytes);
					//System.err.println("Get geometry as binary...length =" + geomBytes.length);
					//strGeometry += new String(data);//,"ISO-8859-1");
					//Utils.printMeasure();
			    	//System.err.println("Convert to string...length =" + strGeometry.length());
			    
				} else {
					int id = rs.getInt("id");
					String szGeom = id+":"+rs.getString("geom");
					strGeometry += szGeom;
					//System.out.println(strGeometry);
					//System.err.println("Get geometry as string...length =" + strGeometry.length());
				}
			}
			Utils.printMeasure();
			if (type == Definitions.TYPE_GEOMETRY_WKB){
				strGeometry = new String(binData,"ISO-8859-1");
			}
			
			st.execute("end");
			st.close();
			rs.close();
			/*try {
				BufferedWriter out = new BufferedWriter(new FileWriter("S:\\geom.txt"));
				out.write(strGeometry);
	
				out.close();
				}
				catch (IOException e)
				{
				System.out.println("Exception ");
				}*/
			if (buffer ==null){
				System.err.println("Buffer not cached...do it now!");
				//buffer = new String(strGeometry);
			}
			return strGeometry;
		} catch (SQLException e) {
		//LogWriter.getDBLogger().error(
		//		"Get package-package connection failed. Exception: " + e.getMessage());
		//throw e;
		try {
			st.execute("end");
			st.close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		e.printStackTrace();
		return null;
	 } catch (Exception e) {
		
		//LogWriter.getDBLogger().error(
		//		"Get package-package connection failed. Exception: " + e.getMessage());
		//throw e;
		e.printStackTrace();
		return null;
	 }
	
	
	
	}
	public String getGeometryByIntersection(DBOperation dbo,String geomWKT, int type, String idName, String tableName, String fidExcepted){
		
		Connection conn = dbo.getConnection();
		String strGeometry = null;
		ResultSet rs = null;
		Statement st = null;
	    ArrayList<Integer> lstFID = new ArrayList<Integer>();
		byte[] binData={};//used for get binary data
		if (buffer!=null) {
			System.err.println("Buffer cached...return it now :)");
			return buffer;
		}
		
		if (!fidExcepted.equalsIgnoreCase("")){
			String[] fids= fidExcepted.split(Definitions.COM_TYPE_SEP);
	    		for (int i = 0; i< fids.length; i++){
	    			lstFID.add(Integer.valueOf(fids[i]));
	    		}
		}
		//type = Definitions.TYPE_GEOMETRY_WKT;
		try {
			if (idName.equalsIgnoreCase("")||idName.equalsIgnoreCase("null")){ 
				idName = "";
			}else {
				idName = idName+" AS id,";
			}
			 
			
			String query = //"SELECT ST_Intersects((select the_geom from tbl_ruong_region where gid=37), ('SRID=4756;POINT("+x +" " + y +")'))";   

							"SELECT "+ idName + (type == Definitions.TYPE_GEOMETRY_WKB?"ST_AsBinary(the_geom,'NDR') ":"ST_AsText(the_geom) ")+" AS geom FROM "+ tableName+" WHERE ST_Intersects(the_geom , ST_GeomFromText('"+geomWKT+"',4756)) = 't'";
			
			
			//query ="SELECT ruong_id AS id,ST_AsBinary(the_geom,'NDR')  AS geom FROM tbl_ruong_region WHERE ST_Intersects(the_geom , ST_GeomFromText('POLYGON((512799.2303 1161928.9122,544587.3945 1161928.9122,544587.3945 1147139.1336,512799.2303 1147139.1336,512799.2303 1161928.9122))')) = 't'";
			System.out.println(query);
			//Utils.setMeasuretTimeStart("start query");
			st = conn.createStatement();
			//st.setFetchDirection( ResultSet.CONCUR_READ_ONLY);
			//System.out.println("st.getFetchDirection() ="+st.getFetchDirection());
			st.setFetchSize(100);
			//System.out.println("st.getFetchSize() ="+st.getFetchSize());
			//conn.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);
			//System.out.println("conn.getTransactionIsolation()="+conn.getTransactionIsolation());
			
	        st.execute("begin");
	        st.execute("declare wkb_cursor binary cursor for " + query);
	       
			rs = st.executeQuery("fetch forward all in wkb_cursor");
			
			//rs = st.executeQuery(query);
			//Utils.printMeasure();
			
			Utils.setMeasuretTimeStart("reading resultset");
			strGeometry = "";
			while (rs.next()) {
				if (type == Definitions.TYPE_GEOMETRY_WKB){
					
					int id = rs.getInt("id");
					int size = lstFID.size();
					boolean ignored = false;
					for (int i = 0; i < size; i++){
						if (lstFID.get(i).intValue() == id){
							lstFID.remove(i);
							ignored = true;
							
							break;
						}
					}
					if (ignored) {
						System.out.println("fid: "+ id + " has loaded. Skip now...");
						continue;
					}
					byte[] geomBytes =rs.getBytes("geom");
				    //strGeometry = new String(geomBytes,"ISO-8859-1");//encode with ISO-8859-1 is VERY IMPORTANT
					byte[] idBytes = Utils.intToByteArray(id, Definitions.TYPE_LITTLEENDIAN_NDR);
					/*byte[] data = Utils.concatByteArrays(idBytes, geomBytes);
					binData = Utils.concatByteArrays(binData, data);
					 */
					
					binData = Utils.concatByteArrays(binData, idBytes, geomBytes);
					//System.err.println("Get geometry as binary...length =" + geomBytes.length);
					//strGeometry += new String(data);//,"ISO-8859-1");
					//Utils.printMeasure();
			    	//System.err.println("Convert to string...length =" + strGeometry.length());
			    
				} else {
					int id = rs.getInt("id");
					String szGeom = id+":"+rs.getString("geom");
					strGeometry += szGeom;
					//System.out.println(strGeometry);
					//System.err.println("Get geometry as string...length =" + strGeometry.length());
				}
			}
			Utils.printMeasure();
			if (type == Definitions.TYPE_GEOMETRY_WKB){
				strGeometry = new String(binData,"ISO-8859-1");
			}
			
			st.execute("end");
			st.close();
			rs.close();
			/*try {
				BufferedWriter out = new BufferedWriter(new FileWriter("S:\\geom.txt"));
				out.write(strGeometry);
	
				out.close();
				}
				catch (IOException e)
				{
				System.out.println("Exception ");
				}*/
			if (buffer ==null){
				System.err.println("Buffer not cached...do it now!");
				//buffer = new String(strGeometry);
			}
			return strGeometry;
		} catch (SQLException e) {
		//LogWriter.getDBLogger().error(
		//		"Get package-package connection failed. Exception: " + e.getMessage());
		//throw e;
		try {
			st.execute("end");
			st.close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		e.printStackTrace();
		return null;
	 } catch (Exception e) {
		
		//LogWriter.getDBLogger().error(
		//		"Get package-package connection failed. Exception: " + e.getMessage());
		//throw e;
		e.printStackTrace();
		return null;
	 }
   }
public String getIDByIntersection(DBOperation dbo,String geomWKT, String idName, String name, String tableName){
		
		Connection conn = dbo.getConnection();
		String strGeometry = null;
		ResultSet rs = null;
		Statement st = null;
		//type = Definitions.TYPE_GEOMETRY_WKT;
		try {
			if (idName.equalsIgnoreCase("")||idName.equalsIgnoreCase("null")){ 
				idName = "";
			}else {
				idName = idName+" AS id,";
			}
			String query = "SELECT "+ idName + name +",huyen_id" + " FROM " + tableName+" WHERE ST_Intersects(the_geom , ST_GeomFromText('"+geomWKT+"',4756)) = 't'";
			
			
			//query ="SELECT ruong_id AS id,ST_AsBinary(the_geom,'NDR')  AS geom FROM tbl_ruong_region WHERE ST_Intersects(the_geom , ST_GeomFromText('POLYGON((512799.2303 1161928.9122,544587.3945 1161928.9122,544587.3945 1147139.1336,512799.2303 1147139.1336,512799.2303 1161928.9122))')) = 't'";
			System.out.println(query);
			//Utils.setMeasuretTimeStart("start query");
			st = conn.createStatement();
		     
			rs = st.executeQuery(query);
			
			//rs = st.executeQuery(query);
			//Utils.printMeasure();
			
			Utils.setMeasuretTimeStart("reading resultset");
			strGeometry = "";
			int id = -1;
			String strName ="";
			int huyen_id = -1;
			while (rs.next()) {
				id = rs.getInt("id");
				strName = rs.getString(name);
				huyen_id =  rs.getInt("huyen_id");
			}
			strGeometry = String.valueOf(id)+','+strName ;
			rs.close();
			query = "SELECT huyen_id as id,ten_huyen as name FROM tbl_huyen_region WHERE huyen_id=" + huyen_id;
			
			rs = st.executeQuery(query);
			
			strName = "";
			while (rs.next()) {
				id = rs.getInt("id");
				strName = rs.getString("name");
			}
			
			
			strGeometry = strGeometry + ',' +String.valueOf(id)+','+strName ;
			System.out.println(strGeometry);
			st.close();
			rs.close();

			return strGeometry;
		} catch (SQLException e) {
		try {
		
			st.close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		e.printStackTrace();
		return null;
	 } catch (Exception e) {
		e.printStackTrace();
		return null;
	 }
   }
	
	
	public String getGeometryByIntersection2(DBOperation dbo,String geomWKT, int type, String idName, String tableName){
		
		Connection conn = dbo.getConnection();
		String strGeometry = null;
		ResultSet rs = null;
		Statement st = null;
		try {
			if (idName.equalsIgnoreCase("")||idName.equalsIgnoreCase("null")){ 
				idName = "";
			}else {
				idName = idName+" AS id";
			}
			
			Utils.setMeasuretTimeStart("");
			String query = //"SELECT ST_Intersects((select the_geom from tbl_ruong_region where gid=37), ('SRID=4756;POINT("+x +" " + y +")'))";   

							"SELECT "+ idName +" FROM "+ tableName+" WHERE ST_Intersects(the_geom , ST_GeomFromText('"+geomWKT+"',4756)) = 't'";
			System.out.println(query);
			st = conn.createStatement();
			
	        st.execute("begin");
	        st.execute("declare wkb_cursor binary cursor for " + query);
			rs = st.executeQuery("fetch forward all in wkb_cursor");
			

			//rs = st.executeQuery(query);
			strGeometry = "";
			int c = 0;
			while (rs.next()) {
				if (type == Definitions.TYPE_GEOMETRY_WKB){
					int id = rs.getInt("id");
					//byte[] geomBytes =rs.getBytes("geom");
					//strGeometry = new String(geomBytes,"ISO-8859-1");//encode with ISO-8859-1 is VERY IMPORTANT
					byte[] idBytes = Utils.intToByteArray(id, Definitions.TYPE_LITTLEENDIAN_NDR);
					//byte[] data = Utils.concatByteArrays(idBytes, geomBytes);
	
					//System.err.println("Get geometry as binary...length =" + geomBytes.length);
					strGeometry += new String(idBytes,"ISO-8859-1");
			    	//System.err.println("Convert to string...length =" + strGeometry.length());
			    
				} else {
					int id = rs.getInt("id");
					String szGeom = id+":"+rs.getString("geom");
					strGeometry += szGeom;
					System.out.println(strGeometry);
					//System.err.println("Get geometry as string...length =" + strGeometry.length());
				}
				c++;
			}
			System.err.println("count =" +c);
			Utils.printMeasure();
			st.execute("end");
			st.close();
			rs.close();
			try {
				BufferedWriter out = new BufferedWriter(new FileWriter("S:\\geom.txt"));
				out.write(strGeometry);
	
				out.close();
				}
				catch (IOException e)
				{
				System.out.println("Exception ");
				}
			return strGeometry;
		} catch (SQLException e) {
		//LogWriter.getDBLogger().error(
		//		"Get package-package connection failed. Exception: " + e.getMessage());
		//throw e;
		try {
			st.execute("end");
			st.close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		e.printStackTrace();
		return null;
	 } catch (Exception e) {
		
		//LogWriter.getDBLogger().error(
		//		"Get package-package connection failed. Exception: " + e.getMessage());
		//throw e;
		e.printStackTrace();
		return null;
	 }
   }
	 
}
