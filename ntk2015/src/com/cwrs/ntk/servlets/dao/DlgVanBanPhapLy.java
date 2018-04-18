package com.cwrs.ntk.servlets.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;

import org.json.simple.JSONObject;

import com.cwrs.ntk.common.Utils;
import com.cwrs.ntk.models.TblPhanloaiVanbanEntity;
import com.cwrs.ntk.models.TblVanbanphaplyEntity;

public class DlgVanBanPhapLy {
	
	public Object getDatatoDs_VanBanPhapLyForm(DBOperation dbo, int total, int nRecords, int limit, int offset, String condition, boolean bReturnJSON) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;
        if (total < 0) {
            total = dbo.countObject(TblVanbanphaplyEntity.VANBAN_PHAPLY_TBL, condition);
        }
       /* if (condition != null){
			if (condition.equalsIgnoreCase(""))
				condition = null;
		}*/
        sql = " select "
                + TblVanbanphaplyEntity.VANBAN_PHAPLY_ID + ","
                + TblVanbanphaplyEntity.VANBAN_PHAPLY_TEN + ","
                + TblVanbanphaplyEntity.VANBAN_PHAPLY_KIHIEU + ","
                + TblVanbanphaplyEntity.VANBAN_PHAPLY_NGAYBANHANH
                + " from " + TblVanbanphaplyEntity.VANBAN_PHAPLY_TBL
                + ((condition == null) ? "" : (" WHERE " + condition)) + " order by " + TblVanbanphaplyEntity.VANBAN_PHAPLY_TEN
                + " LIMIT " + limit + " OFFSET " + offset;
        //System.out.println("getDatatoDs_VanBanPhapLyForm sql = " + sql);

        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblVanbanphaplyEntity.VANBAN_PHAPLY_ID, Integer.valueOf(rs.getInt(TblVanbanphaplyEntity.VANBAN_PHAPLY_ID)));
                htbl.put(TblVanbanphaplyEntity.VANBAN_PHAPLY_TEN, rs.getString(TblVanbanphaplyEntity.VANBAN_PHAPLY_TEN));
                htbl.put(TblVanbanphaplyEntity.VANBAN_PHAPLY_KIHIEU, rs.getString(TblVanbanphaplyEntity.VANBAN_PHAPLY_KIHIEU));
                htbl.put(TblVanbanphaplyEntity.VANBAN_PHAPLY_NGAYBANHANH, Utils.convertInt2DateString(rs.getInt(TblVanbanphaplyEntity.VANBAN_PHAPLY_NGAYBANHANH)));
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
            System.out.println("getDatatoDs_VanBanPhapLyForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoDs_VanBanPhapLyForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs, st);
        }
    }
	
	public Object getDatatoEditDs_VanBanPhapLyForm(DBOperation dbo, String condition,boolean bReturnJSON) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;

        sql = "SELECT "
        		+ TblVanbanphaplyEntity.VANBAN_PHAPLY_ID + ","
        		+ TblVanbanphaplyEntity.VANBAN_PHAPLY_TBL + "." + TblVanbanphaplyEntity.VANBAN_PHAPLY_ID_PHANLOAI + ","
                + TblVanbanphaplyEntity.VANBAN_PHAPLY_KIHIEU + ","
                + TblVanbanphaplyEntity.VANBAN_PHAPLY_TEN + ","
                + TblVanbanphaplyEntity.VANBAN_PHAPLY_NGAYBANHANH + ","
                + TblVanbanphaplyEntity.VANBAN_PHAPLY_NOIDUNG + ","
                + TblVanbanphaplyEntity.VANBAN_PHAPLY_DUONGDAN + ","
                + TblPhanloaiVanbanEntity.PHANLOAI_VANBAN_TEN 	
                
                + " FROM " + TblVanbanphaplyEntity.VANBAN_PHAPLY_TBL
                + " INNER JOIN " + TblPhanloaiVanbanEntity.PHANLOAI_VANBAN_TBL 
                + " ON " +  TblVanbanphaplyEntity.VANBAN_PHAPLY_TBL + "." + TblVanbanphaplyEntity.VANBAN_PHAPLY_ID_PHANLOAI 
                + " = " + TblPhanloaiVanbanEntity.PHANLOAI_VANBAN_TBL + "." + TblPhanloaiVanbanEntity.PHANLOAI_VANBAN_ID
                + ((condition == null) ? "" : (" WHERE " + condition))
                + " limit 1";
        //System.out.println("getDatatoEditDs_VanBanPhapLyForm sql = " + sql);
        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblVanbanphaplyEntity.VANBAN_PHAPLY_ID, rs.getString(TblVanbanphaplyEntity.VANBAN_PHAPLY_ID));
                htbl.put(TblVanbanphaplyEntity.VANBAN_PHAPLY_ID_PHANLOAI, rs.getString(TblVanbanphaplyEntity.VANBAN_PHAPLY_ID_PHANLOAI));
                htbl.put(TblVanbanphaplyEntity.VANBAN_PHAPLY_KIHIEU, rs.getString(TblVanbanphaplyEntity.VANBAN_PHAPLY_KIHIEU));
                htbl.put(TblVanbanphaplyEntity.VANBAN_PHAPLY_TEN, rs.getString(TblVanbanphaplyEntity.VANBAN_PHAPLY_TEN));
                htbl.put(TblVanbanphaplyEntity.VANBAN_PHAPLY_NGAYBANHANH, Utils.convertInt2DateString(rs.getInt(TblVanbanphaplyEntity.VANBAN_PHAPLY_NGAYBANHANH)));
                htbl.put(TblVanbanphaplyEntity.VANBAN_PHAPLY_NOIDUNG, rs.getString(TblVanbanphaplyEntity.VANBAN_PHAPLY_NOIDUNG));
                htbl.put(TblVanbanphaplyEntity.VANBAN_PHAPLY_DUONGDAN, rs.getString(TblVanbanphaplyEntity.VANBAN_PHAPLY_DUONGDAN));
                htbl.put(TblPhanloaiVanbanEntity.PHANLOAI_VANBAN_TEN , rs.getString(TblPhanloaiVanbanEntity.PHANLOAI_VANBAN_TEN));
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
            System.out.println("getDatatoEditDs_VanBanPhapLyForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoEditDs_VanBanPhapLyForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs, st);
        }
	}
}
