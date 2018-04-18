package com.cwrs.ntk.servlets.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;

import org.json.simple.JSONObject;

import com.cwrs.ntk.common.Utils;
import com.cwrs.ntk.models.TblPhanloaiTintucEntity;
import com.cwrs.ntk.models.TblTintucEntity;

public class DlgTinTucHoatDong {
	
	public Object getDatato_TinTucHoatDongForm(DBOperation dbo, int total, int nRecords, int limit, int offset, String condition, boolean bReturnJSON) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;
        if (total < 0) {
            total = dbo.countObject(TblTintucEntity.TINTUC_TBL, condition);
        }
       /* if (condition != null){
			if (condition.equalsIgnoreCase(""))
				condition = null;
		}*/
        sql = " select "
                + TblTintucEntity.TINTUC_ID + ","
                + TblTintucEntity.TINTUC_TEN + ","
                + TblTintucEntity.TINTUC_NGAY + ","
                + TblTintucEntity.TINTUC_DUONGDAN + ","
                + TblTintucEntity.TINTUC_TOMTAT
                + " from " + TblTintucEntity.TINTUC_TBL
                + ((condition == null) ? "" : (" WHERE " + condition)) + " order by " + TblTintucEntity.TINTUC_ID
                + " desc LIMIT " + limit + " OFFSET " + offset;
       // System.out.println("getDatato_TinTucHoatDongForm sql = " + sql);

        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblTintucEntity.TINTUC_ID, Integer.valueOf(rs.getInt(TblTintucEntity.TINTUC_ID)));
                htbl.put(TblTintucEntity.TINTUC_TEN, rs.getString(TblTintucEntity.TINTUC_TEN));
                htbl.put(TblTintucEntity.TINTUC_TOMTAT, rs.getString(TblTintucEntity.TINTUC_TOMTAT));
                htbl.put(TblTintucEntity.TINTUC_DUONGDAN, (rs.getString(TblTintucEntity.TINTUC_DUONGDAN)== null)? "": rs.getString(TblTintucEntity.TINTUC_DUONGDAN));
                htbl.put(TblTintucEntity.TINTUC_NGAY, Utils.convertInt2DateString(rs.getInt(TblTintucEntity.TINTUC_NGAY)));
                lst.add(htbl);
            }
            if (bReturnJSON) {//Trả về file json
                JSONObject json = new JSONObject();
                json.put("total", total);
                json.put("rows", lst);
                //conn.close();
                return json.toJSONString();
            } else {
                return lst;
            }
        } catch (SQLException e) {
            System.out.println("getDatato_TinTucHoatDongForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatato_TinTucHoatDongForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs, st);
        }
    }
	
	public Object getDatatoEdit_TinTucHoatDongForm(DBOperation dbo, String condition,boolean bReturnJSON) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;

        sql = "SELECT "
        		+ TblTintucEntity.TINTUC_ID + ","
        		+ TblTintucEntity.TINTUC_TBL + "." + TblTintucEntity.TINTUC_ID_PHANLOAI + ","
                + TblTintucEntity.TINTUC_TEN + ","
                + TblTintucEntity.TINTUC_NGAY + ","
                + TblTintucEntity.TINTUC_TOMTAT + ","
                + TblTintucEntity.TINTUC_NOIDUNG + ","
                + TblTintucEntity.TINTUC_DUONGDAN + ","
                + TblPhanloaiTintucEntity.PHANLOAI_TINTUC_TEN	
                
                + " FROM " + TblTintucEntity.TINTUC_TBL
                + " INNER JOIN " + TblPhanloaiTintucEntity.PHANLOAI_TINTUC_TBL 
                + " ON " +  TblTintucEntity.TINTUC_TBL + "." + TblTintucEntity.TINTUC_ID_PHANLOAI 
                + " = " + TblPhanloaiTintucEntity.PHANLOAI_TINTUC_TBL + "." + TblPhanloaiTintucEntity.PHANLOAI_TINTUC_ID
                + ((condition == null) ? "" : (" WHERE " + condition))
                + " limit 1";
       // System.out.println("getDatatoEdit_TinTucHoatDongForm sql = " + sql);
        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblTintucEntity.TINTUC_ID, rs.getString(TblTintucEntity.TINTUC_ID));
                htbl.put(TblTintucEntity.TINTUC_ID_PHANLOAI, rs.getString(TblTintucEntity.TINTUC_ID_PHANLOAI));
                htbl.put(TblTintucEntity.TINTUC_TEN, rs.getString(TblTintucEntity.TINTUC_TEN));
                htbl.put(TblTintucEntity.TINTUC_TOMTAT, rs.getString(TblTintucEntity.TINTUC_TOMTAT));
                htbl.put(TblTintucEntity.TINTUC_NGAY, Utils.convertInt2DateString(rs.getInt(TblTintucEntity.TINTUC_NGAY)));
                htbl.put(TblTintucEntity.TINTUC_NOIDUNG, rs.getString(TblTintucEntity.TINTUC_NOIDUNG));
                htbl.put(TblTintucEntity.TINTUC_DUONGDAN, (rs.getString(TblTintucEntity.TINTUC_DUONGDAN)== null)? "": rs.getString(TblTintucEntity.TINTUC_DUONGDAN));
                htbl.put( TblPhanloaiTintucEntity.PHANLOAI_TINTUC_TEN, rs.getString( TblPhanloaiTintucEntity.PHANLOAI_TINTUC_TEN));
                lst.add(htbl);
            }

            if (bReturnJSON) {//Trả về file json
            	JSONObject json = new JSONObject();
                json.put("rows", lst);
               // System.out.println(json);
                //conn.close();
                return json.toJSONString();
            } else {
            	//System.out.println(lst);
                return lst;
            }
        } catch (SQLException e) {
            System.out.println("getDatatoEdit_TinTucHoatDongForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoEdit_TinTucHoatDongForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs, st);
        }
	}
	
	public ArrayList<TblTintucEntity> getDatato_TinTucHoatDongHome(DBOperation dbo, String condition, boolean bReturnJSON) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<TblTintucEntity> lst = new ArrayList<TblTintucEntity>();
        //ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;
        sql = " select "
                + TblTintucEntity.TINTUC_ID + ","
                + TblTintucEntity.TINTUC_TEN + ","
                + TblTintucEntity.TINTUC_NGAY + ","
                + TblTintucEntity.TINTUC_DUONGDAN + ","
                + TblTintucEntity.TINTUC_TOMTAT
                + " from " + TblTintucEntity.TINTUC_TBL
                + ((condition == null) ? "" : (" WHERE " + condition)) + " order by " + TblTintucEntity.TINTUC_ID  + " desc limit 6 ";
       // System.out.println("getDatato_TinTucHoatDongHome sql = " + sql);

        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
            	TblTintucEntity tt = new TblTintucEntity();
            	tt.setIdTintuc(rs.getInt(TblTintucEntity.TINTUC_ID));
            	tt.setTomtat(rs.getString(TblTintucEntity.TINTUC_TOMTAT));
            	tt.setTieude(rs.getString(TblTintucEntity.TINTUC_TEN));
            	tt.setDuongdantintuc(rs.getString(TblTintucEntity.TINTUC_DUONGDAN));
            	tt.setNgaytao(rs.getInt(TblTintucEntity.TINTUC_NGAY));
            	lst.add(tt);
//                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
//                htbl.put(TblTintucEntity.TINTUC_ID, Integer.valueOf(rs.getInt(TblTintucEntity.TINTUC_ID)));
//                htbl.put(TblTintucEntity.TINTUC_TEN, rs.getString(TblTintucEntity.TINTUC_TEN));
//                htbl.put(TblTintucEntity.TINTUC_TOMTAT, rs.getString(TblTintucEntity.TINTUC_TOMTAT));
//                htbl.put(TblTintucEntity.TINTUC_NGAY, Utils.convertInt2DateString(rs.getInt(TblTintucEntity.TINTUC_NGAY)));
//                lst.add(htbl);
            }
           /* if (bReturnJSON) {//Trả về file json
                JSONObject json = new JSONObject();
                json.put("rows", lst);
                //conn.close();
                return json.toJSONString();
            } else {*/
                return lst;
           // }
        } catch (SQLException e) {
            System.out.println("getDatato_TinTucHoatDongHome SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatato_TinTucHoatDongHome Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs, st);
        }
	}

	public Object getData_TinMoiHome(DBOperation dbo, int limit, int offset, String condition, boolean bReturnJSON) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;
        sql = " select "
                + TblTintucEntity.TINTUC_ID + ","
                + TblTintucEntity.TINTUC_TEN 
                + " from " + TblTintucEntity.TINTUC_TBL
                + ((condition == null) ? "" : (" WHERE " + condition)) + " order by " + TblTintucEntity.TINTUC_ID
                + " LIMIT " + limit + " OFFSET " + offset;
       // System.out.println("getData_TinMoiHome sql = " + sql);

        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblTintucEntity.TINTUC_ID, Integer.valueOf(rs.getInt(TblTintucEntity.TINTUC_ID)));
                htbl.put(TblTintucEntity.TINTUC_TEN, rs.getString(TblTintucEntity.TINTUC_TEN));
                lst.add(htbl);
            }
            if (bReturnJSON) {//Trả về file json
                JSONObject json = new JSONObject();
                json.put("rows", lst);
                //conn.close();
                return json.toJSONString();
            } else {
                return lst;
            }
        } catch (SQLException e) {
            System.out.println("getData_TinMoiHome SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getData_TinMoiHome Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs, st);
        }
    }
}
