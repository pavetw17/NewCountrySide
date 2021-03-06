package com.cwrs.ntk.servlets.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;

import org.json.simple.JSONObject;

import com.cwrs.ntk.common.Utils;
import com.cwrs.ntk.models.TblYkienchidaoEntity;

public class DlgYKienChiDao {

    public Object getDatatoDs_YKienChiDaoForm(DBOperation dbo, int total, int nRecords, int limit, int offset, String condition, boolean bReturnJSON) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;
        if (total < 0) {
            total = dbo.countObject(TblYkienchidaoEntity.YKIEN_CHIDAO_TBL, condition);
        }
        sql = " select "
                + TblYkienchidaoEntity.YKIEN_CHIDAO_ID + ","
                + TblYkienchidaoEntity.YKIEN_CHIDAO_TIEUDE +","
                + TblYkienchidaoEntity.YKIEN_CHIDAO_NGAY +","
                + TblYkienchidaoEntity.YKIEN_CHIDAO_SOKIHIEU 
                + " from " + TblYkienchidaoEntity.YKIEN_CHIDAO_TBL
                + ((condition == null) ? "" : (" WHERE " + condition)) + " order by " + TblYkienchidaoEntity.YKIEN_CHIDAO_TIEUDE
                + " LIMIT " + limit + " OFFSET " + offset;
        //System.out.println("getDatatoDs_YKienChiDaoForm sql = " + sql);

        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblYkienchidaoEntity.YKIEN_CHIDAO_ID, Integer.valueOf(rs.getInt(TblYkienchidaoEntity.YKIEN_CHIDAO_ID)));
                htbl.put(TblYkienchidaoEntity.YKIEN_CHIDAO_TIEUDE, rs.getString(TblYkienchidaoEntity.YKIEN_CHIDAO_TIEUDE));
                htbl.put(TblYkienchidaoEntity.YKIEN_CHIDAO_NGAY, Utils.convertInt2DateString(rs.getInt(TblYkienchidaoEntity.YKIEN_CHIDAO_NGAY)));
                htbl.put(TblYkienchidaoEntity.YKIEN_CHIDAO_SOKIHIEU, rs.getString(TblYkienchidaoEntity.YKIEN_CHIDAO_SOKIHIEU));
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
            System.out.println("getDatatoDs_YKienChiDaoForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoDs_YKienChiDaoForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs, st);
        }
    }

    public Object getDatatoEditDs_YKienChiDaoForm(DBOperation dbo, String condition,boolean bReturnJSON) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;

        sql = "SELECT "
                + TblYkienchidaoEntity.YKIEN_CHIDAO_TIEUDE +","
                + TblYkienchidaoEntity.YKIEN_CHIDAO_NGAY +","
                + TblYkienchidaoEntity.YKIEN_CHIDAO_NOIDUNG +","
                + TblYkienchidaoEntity.YKIEN_CHIDAO_SOKIHIEU +","
                + TblYkienchidaoEntity.YKIEN_CHIDAO_DUONGDAN
                + " from " + TblYkienchidaoEntity.YKIEN_CHIDAO_TBL
                + ((condition == null) ? "" : (" WHERE " + condition))
                + " limit 1";
        System.out.println("getDatatoEditDs_YKienChiDaoForm sql = " + sql);
        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblYkienchidaoEntity.YKIEN_CHIDAO_TIEUDE, rs.getString(TblYkienchidaoEntity.YKIEN_CHIDAO_TIEUDE));
                htbl.put(TblYkienchidaoEntity.YKIEN_CHIDAO_NGAY, Utils.convertInt2DateString(rs.getInt(TblYkienchidaoEntity.YKIEN_CHIDAO_NGAY)));
                htbl.put(TblYkienchidaoEntity.YKIEN_CHIDAO_SOKIHIEU, rs.getString(TblYkienchidaoEntity.YKIEN_CHIDAO_SOKIHIEU));
                htbl.put(TblYkienchidaoEntity.YKIEN_CHIDAO_NOIDUNG, rs.getString(TblYkienchidaoEntity.YKIEN_CHIDAO_NOIDUNG));
                htbl.put(TblYkienchidaoEntity.YKIEN_CHIDAO_DUONGDAN, rs.getString(TblYkienchidaoEntity.YKIEN_CHIDAO_DUONGDAN));
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
            System.out.println("getDatatoEditDs_YKienChiDaoForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoEditDs_YKienChiDaoForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs, st);
        }
    }
}
