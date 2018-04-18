package com.cwrs.ntk.servlets.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;

import org.json.simple.JSONObject;

import com.cwrs.ntk.models.TblTochucEntity;

/**
 * Created by VN on 3/26/2015.
 */
public class DlgToChuc {
    public DlgToChuc() {
        super();
    }

    public Object getDatato_ToChucForm(DBOperation dbo, int total, int nRecords, int limit, int offset, String condition, boolean bReturnJSON) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;
        if (total < 0) {
            total = dbo.countObject(TblTochucEntity.TOCHUC_TBL, condition); 
        }
        sql = " select "
                + TblTochucEntity.TOCHUC_ID + ","
                + TblTochucEntity.TOCHUC_TEN +","
                + TblTochucEntity.TOCHUC_PHONE + ","
                + TblTochucEntity.TOCHUC_DIACHI + ","
                + TblTochucEntity.TOCHUC_EMAIL + ","
                + TblTochucEntity.TOCHUC_CANBO_DAIHOC + ","
                + TblTochucEntity.TOCHUC_CANBO_THACSI + ","
                + TblTochucEntity.TOCHUC_CANBO_TIENSI 
                + " from " + TblTochucEntity.TOCHUC_TBL
                + ((condition == null) ? "" : (" WHERE " + condition)) + " order by " + TblTochucEntity.TOCHUC_TEN
                + " LIMIT " + limit + " OFFSET " + offset;
        //System.out.println("getDatatoToChucForm sql = " + sql);

        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblTochucEntity.TOCHUC_ID, Integer.valueOf(rs.getInt(TblTochucEntity.TOCHUC_ID)));
                htbl.put(TblTochucEntity.TOCHUC_TEN, rs.getString(TblTochucEntity.TOCHUC_TEN));
                htbl.put(TblTochucEntity.TOCHUC_PHONE, rs.getString(TblTochucEntity.TOCHUC_PHONE));
                htbl.put(TblTochucEntity.TOCHUC_DIACHI, rs.getString(TblTochucEntity.TOCHUC_DIACHI));
                htbl.put(TblTochucEntity.TOCHUC_EMAIL, rs.getString(TblTochucEntity.TOCHUC_EMAIL));
                htbl.put(TblTochucEntity.TOCHUC_CANBO_DAIHOC, rs.getString(TblTochucEntity.TOCHUC_CANBO_DAIHOC));
                htbl.put(TblTochucEntity.TOCHUC_CANBO_THACSI, rs.getString(TblTochucEntity.TOCHUC_CANBO_THACSI));
                htbl.put(TblTochucEntity.TOCHUC_CANBO_TIENSI, rs.getString(TblTochucEntity.TOCHUC_CANBO_TIENSI));
                lst.add(htbl);
            }
            if (bReturnJSON) {//Trả về file json
                JSONObject json = new JSONObject();
                json.put("total", total);
                json.put("rows", lst);
                //conn.close();
                return json.toJSONString();
            }else {
                return lst;
            }
        } catch (SQLException e) {
            System.out.println("getDatatoToChucForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoToChucForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs,st);
        }
    }


    public String getDatatoEdit_ToChucForm(DBOperation dbo, String condition){
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;

        sql =  "SELECT "
                + TblTochucEntity.TOCHUC_ID + ","
                + TblTochucEntity.TOCHUC_TEN + ","
                + TblTochucEntity.TOCHUC_PHONE + ","
                + TblTochucEntity.TOCHUC_DIACHI + ","
                + TblTochucEntity.TOCHUC_EMAIL + ","
                + TblTochucEntity.TOCHUC_CANBO_DAIHOC + ","
                + TblTochucEntity.TOCHUC_CANBO_THACSI + ","
                + TblTochucEntity.TOCHUC_CANBO_TIENSI 
                + " FROM " +  TblTochucEntity.TOCHUC_TBL
                + ((condition == null) ? "" : (" WHERE " + condition))
                + " limit 1";
        System.out.println("getDatatoEdit_ToChucForm sql = " + sql);
        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            if(rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblTochucEntity.TOCHUC_ID, Integer.valueOf(rs.getInt(TblTochucEntity.TOCHUC_ID)));
                htbl.put(TblTochucEntity.TOCHUC_TEN, rs.getString(TblTochucEntity.TOCHUC_TEN));
                htbl.put(TblTochucEntity.TOCHUC_PHONE, rs.getString(TblTochucEntity.TOCHUC_PHONE));
                htbl.put(TblTochucEntity.TOCHUC_DIACHI, rs.getString(TblTochucEntity.TOCHUC_DIACHI));
                htbl.put(TblTochucEntity.TOCHUC_EMAIL, rs.getString(TblTochucEntity.TOCHUC_EMAIL));
                htbl.put(TblTochucEntity.TOCHUC_CANBO_DAIHOC, rs.getString(TblTochucEntity.TOCHUC_CANBO_DAIHOC));
                htbl.put(TblTochucEntity.TOCHUC_CANBO_THACSI, rs.getString(TblTochucEntity.TOCHUC_CANBO_THACSI));
                htbl.put(TblTochucEntity.TOCHUC_CANBO_TIENSI, rs.getString(TblTochucEntity.TOCHUC_CANBO_TIENSI));
                lst.add(htbl);
            }

            JSONObject json = new JSONObject();
            json.put("rows", lst);
            return json.toJSONString();

        } catch (SQLException e) {
            System.out.println("getDatatoEdit_ToChucForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoEdit_ToChucForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs,st);
        }

    }

    public Object getListQuyen2ComboHtml(DBOperation dbo, String condition, boolean bRetHtml){
		Object data;
		Connection conn = dbo.getConnection();
		try {
			//LogWriter.getDBLogger().info(this.userName + " is loading package-package connection data...");
			String sql = null;
			ResultSet rs = null;
			ArrayList<ObjectKV> lstOKV = new ArrayList<ObjectKV>();	
			ArrayList<Object> lst = new ArrayList<Object>();
			sql = " SELECT " + TblTochucEntity.TOCHUC_ID + ","
							 + TblTochucEntity.TOCHUC_TEN + " " +
					" FROM " + TblTochucEntity.TOCHUC_TBL +
					((condition == null) ? "" : (" WHERE " + condition)) ;

			Statement st = conn.createStatement();
			rs = st.executeQuery(sql);
			// Add objects contained in the result set into one
			if (bRetHtml){
				String s = "";
				while (rs.next()) {
					s+=  "<input type=\"checkbox\" name=\"quyen[]\" style=\"margin-right: 10px;\" value="+String.valueOf(rs.getInt(TblTochucEntity.TOCHUC_ID))+ " id="+String.valueOf(rs.getInt(TblTochucEntity.TOCHUC_ID))+ "/>" + rs.getString(TblTochucEntity.TOCHUC_TEN)+" <br> </input>";
				 }
				data = s;

			}else {
			//lstOKV.add(new ObjectKV(String.valueOf(999), "*", true));
				while (rs.next()) {
			       ObjectKV okv1 = new ObjectKV(String.valueOf(rs.getInt(TblTochucEntity.TOCHUC_ID)), rs.getString(TblTochucEntity.TOCHUC_TEN));
			       lstOKV.add(okv1);
			     //System.out.println(okv1.key +", " + okv1.value);
				}
				data =lstOKV;
			}
			//conn.close();
			st.close();
			rs.close();
			return data;
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

}
