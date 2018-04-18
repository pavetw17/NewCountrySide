package com.cwrs.ntk.servlets.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;

import org.json.simple.JSONObject;

import com.cwrs.ntk.models.TblPhanloaiBaocaoEntity;

/**
 * Created by VN on 3/26/2015.
 */
public class DlgPhanLoaiBaoCao {
    public DlgPhanLoaiBaoCao() {
        super();
    }

    public Object getDatatoPhanLoaiBaoCaoForm(DBOperation dbo, int total, int nRecords, int limit, int offset, String condition, boolean bReturnJSON) {
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;
        if (total < 0) {
            total = dbo.countObject(TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_TBL, condition);
        }
        sql = " select "
                + TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_ID + ","
                + TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_TEN 
                + " from " + TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_TBL
                + ((condition == null) ? "" : (" WHERE " + condition)) + " order by " + TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_TEN
                + " LIMIT " + limit + " OFFSET " + offset;
        //System.out.println("getDatatoPhanLoaiBaoCaoForm sql = " + sql);

        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_ID, Integer.valueOf(rs.getInt(TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_ID)));
                htbl.put(TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_TEN, rs.getString(TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_TEN));
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
            System.out.println("getDatatoPhanLoaiBaoCaoForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoPhanLoaiBaoCaoForm Exception: " + e.toString());
            return null;
        } finally {
            dbo.closeEverything(rs,st);
        }
    }


    public String getDatatoEditPhanLoaiBaoCaoForm(DBOperation dbo, String condition){
        Connection conn = dbo.getConnection();
        String sql = null;
        ResultSet rs = null;
        ArrayList<Object> lst = new ArrayList<Object>();
        Statement st = null;

        sql =  "SELECT "
                + TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_ID + ","
                + TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_TEN
                + " FROM " +  TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_TBL
                + ((condition == null) ? "" : (" WHERE " + condition))
                + " limit 1";
        System.out.println("getDatatoEditPhanLoaiBaoCaoForm sql = " + sql);
        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            if(rs.next()) {
                Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
                htbl.put(TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_ID, Integer.valueOf(rs.getInt(TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_ID)));
                htbl.put(TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_TEN, rs.getString(TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_TEN));
                lst.add(htbl);
            }

            JSONObject json = new JSONObject();
            json.put("rows", lst);
            return json.toJSONString();

        } catch (SQLException e) {
            System.out.println("getDatatoEditPhanLoaiBaoCaoForm SQLException: " + e.toString());
            return null;
        } catch (Exception e) {
            System.out.println("getDatatoEditPhanLoaiBaoCaoForm Exception: " + e.toString());
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
			sql = " SELECT " + TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_ID + ","
							 + TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_TEN + " " +
					" FROM " + TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_TBL +
					((condition == null) ? "" : (" WHERE " + condition)) ;

			Statement st = conn.createStatement();
			rs = st.executeQuery(sql);
			// Add objects contained in the result set into one
			if (bRetHtml){
				String s = "";
				while (rs.next()) {
					s+=  "<input type=\"checkbox\" name=\"quyen[]\" style=\"margin-right: 10px;\" value="+String.valueOf(rs.getInt(TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_ID))+ " id="+String.valueOf(rs.getInt(TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_ID))+ "/>" + rs.getString(TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_TEN)+" <br> </input>";
				 }
				data = s;

			}else {
			//lstOKV.add(new ObjectKV(String.valueOf(999), "*", true));
				while (rs.next()) {
			       ObjectKV okv1 = new ObjectKV(String.valueOf(rs.getInt(TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_ID)), rs.getString(TblPhanloaiBaocaoEntity.PHANLOAI_BAOCAO_TEN));
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
