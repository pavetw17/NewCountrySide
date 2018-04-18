package com.cwrs.ntk.servlets.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;

import org.json.simple.JSONObject;

import com.cwrs.ntk.models.TblPhanloaiPhieuEntity;

/**
 * Created by VN on 3/26/2015.
 */
public class DlgPhanLoaiPhieu {
    public DlgPhanLoaiPhieu() {
        super();
    }

    public Object getDatatoPhanLoaiPhieuForm(DBOperation dbo, int total, int nRecords, int limit, int offset, String condition, boolean bReturnJSON) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;
        if (total < 0) {
            total = dbo.countObject(TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_TBL, condition);
        }
        sql = " select "
                + TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_ID + ","
                + TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_TEN 
                + " from " + TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_TBL
                + ((condition == null) ? "" : (" WHERE " + condition)) + " order by " + TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_TEN
                + " LIMIT " + limit + " OFFSET " + offset;
        //System.out.println("getDatatoPhanLoaiPhieuForm sql = " + sql);

        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_ID, Integer.valueOf(rs.getInt(TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_ID)));
                htbl.put(TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_TEN, rs.getString(TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_TEN));
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
            System.out.println("getDatatoPhanLoaiPhieuForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoPhanLoaiPhieuForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs,st);
        }
    }


    public String getDatatoEditPhanLoaiPhieuForm(DBOperation dbo, String condition){
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;

        sql =  "SELECT "
                + TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_TEN
                + " FROM " +  TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_TBL
                + ((condition == null) ? "" : (" WHERE " + condition))
                + " limit 1";
        System.out.println("getDatatoEditPhanLoaiPhieuForm sql = " + sql);
        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            if(rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_TEN, rs.getString(TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_TEN));
                lst.add(htbl);
            }

            JSONObject json = new JSONObject();
            json.put("rows", lst);
            return json.toJSONString();

        } catch (SQLException e) {
            System.out.println("getDatatoEditPhanLoaiPhieuForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoEditPhanLoaiPhieuForm Exception: " + e.toString());
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
			sql = " SELECT " + TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_ID + ","
							 + TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_TEN + " " +
					" FROM " + TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_TBL +
					((condition == null) ? "" : (" WHERE " + condition)) ;

			Statement st = conn.createStatement();
			rs = st.executeQuery(sql);
			// Add objects contained in the result set into one
			if (bRetHtml){
				String s = "";
				while (rs.next()) {
					s+=  "<input type=\"checkbox\" name=\"quyen[]\" style=\"margin-right: 10px;\" value="+String.valueOf(rs.getInt(TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_ID))+ " id="+String.valueOf(rs.getInt(TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_ID))+ "/>" + rs.getString(TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_TEN)+" <br> </input>";
				 }
				data = s;

			}else {
			//lstOKV.add(new ObjectKV(String.valueOf(999), "*", true));
				while (rs.next()) {
			       ObjectKV okv1 = new ObjectKV(String.valueOf(rs.getInt(TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_ID)), rs.getString(TblPhanloaiPhieuEntity.PHANLOAI_PHIEU_TEN));
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
