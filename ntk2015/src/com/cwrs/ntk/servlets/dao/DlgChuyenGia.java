package com.cwrs.ntk.servlets.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;

import org.json.simple.JSONObject;

import com.cwrs.ntk.models.TblChuyengiaEntity;

/**
 * Created by VN on 3/26/2015.
 */
public class DlgChuyenGia {
    public DlgChuyenGia() {
        super();
    }

    public Object getDatatoChuyenGiaForm(DBOperation dbo, int total, int nRecords, int limit, int offset, String condition, boolean bReturnJSON) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;
        if (total < 0) {
            total = dbo.countObject(TblChuyengiaEntity.CHUYENGIA_TBL, condition); 
        }
        sql = " select "
                + TblChuyengiaEntity.CHUYENGIA_ID + ","
                + TblChuyengiaEntity.CHUYENGIA_CHUCVU + ","
                + TblChuyengiaEntity.CHUYENGIA_DIENTHOAI + ","
                + TblChuyengiaEntity.CHUYENGIA_DONVI_CONGTAC + ","
                + TblChuyengiaEntity.CHUYENGIA_HOTEN 
                + " from " + TblChuyengiaEntity.CHUYENGIA_TBL
                + ((condition == null) ? "" : (" WHERE " + condition)) + " order by " + TblChuyengiaEntity.CHUYENGIA_HOTEN
                + " LIMIT " + limit + " OFFSET " + offset;
        System.out.println("getDatatoChuyenGiaForm sql = " + sql);

        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblChuyengiaEntity.CHUYENGIA_ID, Integer.valueOf(rs.getInt(TblChuyengiaEntity.CHUYENGIA_ID)));
                htbl.put(TblChuyengiaEntity.CHUYENGIA_HOTEN, rs.getString(TblChuyengiaEntity.CHUYENGIA_HOTEN));
                htbl.put(TblChuyengiaEntity.CHUYENGIA_CHUCVU, rs.getString(TblChuyengiaEntity.CHUYENGIA_CHUCVU));
                htbl.put(TblChuyengiaEntity.CHUYENGIA_DIENTHOAI, rs.getString(TblChuyengiaEntity.CHUYENGIA_DIENTHOAI));
                htbl.put(TblChuyengiaEntity.CHUYENGIA_DONVI_CONGTAC, rs.getString(TblChuyengiaEntity.CHUYENGIA_DONVI_CONGTAC));
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
            System.out.println("getDatatoChuyenGiaForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoChuyenGiaForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs,st);
        }
    }


    public String getDatatoEditChuyenGiaForm(DBOperation dbo, String condition){
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;

        sql =  "SELECT "
                + TblChuyengiaEntity.CHUYENGIA_ID + ","
                 + TblChuyengiaEntity.CHUYENGIA_CHUCVU + ","
                + TblChuyengiaEntity.CHUYENGIA_DIENTHOAI + ","
                + TblChuyengiaEntity.CHUYENGIA_DONVI_CONGTAC + ","
                + TblChuyengiaEntity.CHUYENGIA_HOTEN 
                + " FROM " +  TblChuyengiaEntity.CHUYENGIA_TBL
                + ((condition == null) ? "" : (" WHERE " + condition))
                + " limit 1";
       // System.out.println("getDatatoEditChuyenGiaForm sql = " + sql);
        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            if(rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblChuyengiaEntity.CHUYENGIA_ID, Integer.valueOf(rs.getInt(TblChuyengiaEntity.CHUYENGIA_ID)));
                htbl.put(TblChuyengiaEntity.CHUYENGIA_HOTEN, rs.getString(TblChuyengiaEntity.CHUYENGIA_HOTEN));
                htbl.put(TblChuyengiaEntity.CHUYENGIA_CHUCVU, rs.getString(TblChuyengiaEntity.CHUYENGIA_CHUCVU));
                htbl.put(TblChuyengiaEntity.CHUYENGIA_DIENTHOAI, rs.getString(TblChuyengiaEntity.CHUYENGIA_DIENTHOAI));
                htbl.put(TblChuyengiaEntity.CHUYENGIA_DONVI_CONGTAC, rs.getString(TblChuyengiaEntity.CHUYENGIA_DONVI_CONGTAC));
                lst.add(htbl);
            }

            JSONObject json = new JSONObject();
            json.put("rows", lst);
            return json.toJSONString();

        } catch (SQLException e) {
            System.out.println("getDatatoEditChuyenGiaForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoEditChuyenGiaForm Exception: " + e.toString());
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
			sql = " SELECT " + TblChuyengiaEntity.CHUYENGIA_ID + ","
							 + TblChuyengiaEntity.CHUYENGIA_HOTEN + " " +
					" FROM " + TblChuyengiaEntity.CHUYENGIA_TBL +
					((condition == null) ? "" : (" WHERE " + condition)) ;

			Statement st = conn.createStatement();
			rs = st.executeQuery(sql);
			// Add objects contained in the result set into one
			if (bRetHtml){
				String s = "";
				while (rs.next()) {
					s+=  "<input type=\"checkbox\" name=\"quyen[]\" style=\"margin-right: 10px;\" value="+String.valueOf(rs.getInt(TblChuyengiaEntity.CHUYENGIA_ID))+ " id="+String.valueOf(rs.getInt(TblChuyengiaEntity.CHUYENGIA_ID))+ "/>" + rs.getString(TblChuyengiaEntity.CHUYENGIA_HOTEN)+" <br> </input>";
				 }
				data = s;

			}else {
			//lstOKV.add(new ObjectKV(String.valueOf(999), "*", true));
				while (rs.next()) {
			       ObjectKV okv1 = new ObjectKV(String.valueOf(rs.getInt(TblChuyengiaEntity.CHUYENGIA_ID)), rs.getString(TblChuyengiaEntity.CHUYENGIA_HOTEN));
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
