package com.cwrs.ntk.servlets.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;

import org.json.simple.JSONObject;

import com.cwrs.ntk.models.TblTaikhoanEntity;

public class DlgTaiKhoan {
	public Object getDatatoDanhSachTaiKhoanForm(DBOperation dbo, int total, int nRecords, int limit, int offset, String condition, boolean bReturnJSON) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;
        if (total < 0) {
            total = dbo.countObject(TblTaikhoanEntity.TAIKHOAN_TBL, condition);
        }
        sql = " select "
                + TblTaikhoanEntity.TAIKHOAN_ID + ","
                + TblTaikhoanEntity.TAIKHOAN_TENTK + ","
                + TblTaikhoanEntity.TAIKHOAN_MATKHAU
                + " from " + TblTaikhoanEntity.TAIKHOAN_TBL
                + ((condition == null) ? "" : (" WHERE " + condition)) + " order by " + TblTaikhoanEntity.TAIKHOAN_TENTK
                + " LIMIT " + limit + " OFFSET " + offset;
        //System.out.println("getDatatoDanhSachTaiKhoanForm sql = " + sql);

        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblTaikhoanEntity.TAIKHOAN_ID, Integer.valueOf(rs.getInt(TblTaikhoanEntity.TAIKHOAN_ID)));
                htbl.put(TblTaikhoanEntity.TAIKHOAN_TENTK, rs.getString(TblTaikhoanEntity.TAIKHOAN_TENTK));
                htbl.put(TblTaikhoanEntity.TAIKHOAN_MATKHAU, rs.getString(TblTaikhoanEntity.TAIKHOAN_MATKHAU));
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
            System.out.println("getDatatoDanhSachTaiKhoanForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoDanhSachTaiKhoanForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs,st);
        }
    }
	
	
	public String getDatatoEditDanhSachTaiKhoanForm(DBOperation dbo, String condition){
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;

        sql =  "SELECT "
                + TblTaikhoanEntity.TAIKHOAN_IDQUYEN 
                + " FROM " +  TblTaikhoanEntity.TAIKHOAN_TBL
                + ((condition == null) ? "" : (" WHERE " + condition))
                + " limit 1";
        System.out.println("getDatatoEditDanhSachTaiKhoanForm sql = " + sql);
        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            if(rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblTaikhoanEntity.TAIKHOAN_IDQUYEN, rs.getString(TblTaikhoanEntity.TAIKHOAN_IDQUYEN));
                lst.add(htbl);
            }

            JSONObject json = new JSONObject();
            json.put("rows", lst);
            return json.toJSONString();

        } catch (SQLException e) {
            System.out.println("getDatatoEditDanhSachTaiKhoanForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoEditDanhSachTaiKhoanForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs,st);
        }
    }
	
	public TblTaikhoanEntity dangNhap(DBOperation dbo, String username, String password) {
		 Connection conn = dbo.getConnection();
	        String sql = null;
	        ResultSet rs = null;
	        ArrayList<Object> lst = new ArrayList<Object>();
	        PreparedStatement pstmt = null;
	    	TblTaikhoanEntity tblTaikhoanEntity = null;
			try {
				pstmt = conn
						.prepareStatement("select id_taikhoan, tentk "
								+ " from tbl_taikhoan where tentk = ? and matkhau=? limit 1");
				pstmt.setString(1, username);
				pstmt.setString(2, password);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					tblTaikhoanEntity = new TblTaikhoanEntity();
					tblTaikhoanEntity.setIdTaikhoan(rs.getInt("id_taikhoan"));
					tblTaikhoanEntity.setTentk(rs.getString("tentk"));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				dbo.closeEverything(rs,pstmt);
			}
		    return tblTaikhoanEntity;
	}
	
}
