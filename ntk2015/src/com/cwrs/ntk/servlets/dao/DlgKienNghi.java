package com.cwrs.ntk.servlets.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;

import org.json.simple.JSONObject;

import com.cwrs.ntk.models.TblKiennghiEntity;

public class DlgKienNghi {

    public Object getDatatoKienNghiForm(DBOperation dbo, int total, int nRecords, int limit, int offset, String condition, boolean bReturnJSON) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;
        if (total < 0) {
            total = dbo.countObject(TblKiennghiEntity.KIENNGHI_TBL, condition);
        }
        sql = " select "
                + TblKiennghiEntity.KIENNGHI_ID + ","
                + TblKiennghiEntity.KIENNGHI_TEN 
                + " from " + TblKiennghiEntity.KIENNGHI_TBL
                + ((condition == null) ? "" : (" WHERE " + condition)) + " order by " + TblKiennghiEntity.KIENNGHI_TEN
                + " LIMIT " + limit + " OFFSET " + offset;
        //System.out.println("getDatatoDs_PhanLoaiVanBanForm sql = " + sql);

        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblKiennghiEntity.KIENNGHI_ID, Integer.valueOf(rs.getInt(TblKiennghiEntity.KIENNGHI_ID)));
                htbl.put(TblKiennghiEntity.KIENNGHI_TEN, rs.getString(TblKiennghiEntity.KIENNGHI_TEN));
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
            System.out.println("getDatatoKienNghiForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoKienNghiForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs, st);
        }
    }

    public String getDatatoEditKienNghiForm(DBOperation dbo, String condition) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;

        sql = "SELECT "
                + TblKiennghiEntity.KIENNGHI_ID + ","
                + TblKiennghiEntity.KIENNGHI_TEN
                + " FROM " + TblKiennghiEntity.KIENNGHI_TBL
                + ((condition == null) ? "" : (" WHERE " + condition))
                + " limit 1";
        System.out.println("getDatatoEditDs_PhanLoaiVanBanForm sql = " + sql);
        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblKiennghiEntity.KIENNGHI_ID, Integer.valueOf(rs.getInt(TblKiennghiEntity.KIENNGHI_ID)));
                htbl.put(TblKiennghiEntity.KIENNGHI_TEN, rs.getString(TblKiennghiEntity.KIENNGHI_TEN));
                lst.add(htbl);
            }

            JSONObject json = new JSONObject();
            json.put("rows", lst);
            return json.toJSONString();

        } catch (SQLException e) {
            System.out.println("getDatatoEditKienNghiForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoEditKienNghiForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs, st);
        }
    }
    
    public Object getDatatoDs_PhanTinTucHome(DBOperation dbo, String condition, boolean bReturnJSON) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;
        sql = " select "
                + TblKiennghiEntity.KIENNGHI_ID + ","
                + TblKiennghiEntity.KIENNGHI_TEN 
                + " from " + TblKiennghiEntity.KIENNGHI_TBL
                + ((condition == null) ? "" : (" WHERE " + condition)) + " order by " + TblKiennghiEntity.KIENNGHI_TEN;
        //System.out.println("getDatatoDs_PhanLoaiVanBanForm sql = " + sql);

        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblKiennghiEntity.KIENNGHI_ID, Integer.valueOf(rs.getInt(TblKiennghiEntity.KIENNGHI_ID)));
                htbl.put(TblKiennghiEntity.KIENNGHI_TEN, rs.getString(TblKiennghiEntity.KIENNGHI_TEN));
                lst.add(htbl);
            }
            if (bReturnJSON) {//Trả về file json
                JSONObject json = new JSONObject();
                json.put("rows", lst);
                //conn.close();
                System.out.println(json);
                
                return json.toJSONString();
            } else {
                return lst;
            }
        } catch (SQLException e) {
            System.out.println("getDatatoDs_PhanTinTucHome SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoDs_PhanTinTucHome Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs, st);
        }
    }
}
