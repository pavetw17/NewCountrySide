package com.cwrs.ntk.servlets.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;

import org.json.simple.JSONObject;

import com.cwrs.ntk.models.TblNhansuEntity;

public class DlgNhanSu {
	public Object getDatato_NhanSuForm(DBOperation dbo, int total, int nRecords, int limit, int offset, String condition, boolean bReturnJSON) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;
        if (total < 0) {
            total = dbo.countObject(TblNhansuEntity.NHANSU_TBL, condition);
        }
        sql = " select "
        		+ TblNhansuEntity.NHANSU_ID + ","
                + TblNhansuEntity.NHANSU_HOTEN + ","
                + TblNhansuEntity.NHANSU_CHUCVU + ","
                
                + "(case "+ TblNhansuEntity.NHANSU_GIOITINH +" when 1 then 'Nam' else 'Nữ' end) as gioitinh" +","
                + TblNhansuEntity.NHANSU_MOBILE 
                + " from " + TblNhansuEntity.NHANSU_TBL
                + ((condition == null) ? "" : (" WHERE " + condition)) + " order by " + TblNhansuEntity.NHANSU_CHUCVU
                + " LIMIT " + limit + " OFFSET " + offset;
        //System.out.println("getDatatoNhanSuForm sql = " + sql);

        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblNhansuEntity.NHANSU_ID, Integer.valueOf(rs.getInt(TblNhansuEntity.NHANSU_ID)));
                htbl.put(TblNhansuEntity.NHANSU_HOTEN, rs.getString(TblNhansuEntity.NHANSU_HOTEN));
                htbl.put(TblNhansuEntity.NHANSU_CHUCVU, rs.getString(TblNhansuEntity.NHANSU_CHUCVU));
                htbl.put(TblNhansuEntity.NHANSU_GIOITINH, rs.getString(TblNhansuEntity.NHANSU_GIOITINH));
                htbl.put(TblNhansuEntity.NHANSU_MOBILE, rs.getString(TblNhansuEntity.NHANSU_MOBILE));
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
            System.out.println("getDatatoNhanSuForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoNhanSuForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs,st);
        }
    }
	
	
	public String getDatato_EditNhanSuForm(DBOperation dbo, String condition){
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;

        sql =  "SELECT "
                + TblNhansuEntity.NHANSU_HOTEN + ","
                + TblNhansuEntity.NHANSU_CHUCVU + ","
                + TblNhansuEntity.NHANSU_GIOITINH + ","
                + TblNhansuEntity.NHANSU_MOBILE + ","
                + TblNhansuEntity.NHANSU_ID_TOCHUC
                + " FROM " +  TblNhansuEntity.NHANSU_TBL 
                + ((condition == null) ? "" : (" WHERE " + condition))
                + " limit 1";
        //System.out.println("getDatato_EditNhanSuForm sql = " + sql);
        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            if(rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblNhansuEntity.NHANSU_HOTEN, rs.getString(TblNhansuEntity.NHANSU_HOTEN));
                htbl.put(TblNhansuEntity.NHANSU_CHUCVU, rs.getString(TblNhansuEntity.NHANSU_CHUCVU));
                htbl.put(TblNhansuEntity.NHANSU_GIOITINH, rs.getString(TblNhansuEntity.NHANSU_GIOITINH));
                htbl.put(TblNhansuEntity.NHANSU_MOBILE, rs.getString(TblNhansuEntity.NHANSU_MOBILE));
                htbl.put(TblNhansuEntity.NHANSU_ID_TOCHUC, rs.getString(TblNhansuEntity.NHANSU_ID_TOCHUC));
                lst.add(htbl);
            }

            JSONObject json = new JSONObject();
            json.put("rows", lst);
            return json.toJSONString();

        } catch (SQLException e) {
            System.out.println("getDatato_EditNhanSuForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatato_EditNhanSuForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs,st);
        }

    }
}
