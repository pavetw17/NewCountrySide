package com.cwrs.dbscl.vientham;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;

import org.json.simple.JSONObject;

import com.cwrs.dbscl.common.Utils;
import com.cwrs.dbscl.dataobject.TblCanhdongNangsuat;
import com.cwrs.ntk.servlets.dao.xxx.old.DBOperation;

public class VienthamOperation {

	public String getVienthamImageInfo(DBOperation dbo, String imageid, String condition){
		Connection conn = dbo.getConnection();
		try {
			//LogWriter.getDBLogger().info(this.userName + " is loading package-package connection data...");
			String sql = null;
			ResultSet rs = null;
			ArrayList<Object> lst = new ArrayList<Object>();

			//tbl_ttgc_ruong_tmp
			sql =  "SELECT "+
					TblVienthamImageInfoVO.VT_ID + ","+ 
					TblVienthamImageInfoVO.VT_TENCHUYENGIA + ","+ 
					
					TblVienthamImageInfoVO.VT_NGAYBATDAU + ","+ 
					TblVienthamImageInfoVO.VT_NGAYKETTHUC+ ","+ 
					TblVienthamImageInfoVO.VT_DOPHANGIAI+ ","+ 
					TblVienthamImageInfoVO.VT_TENBANG+ ","+ 
					TblVienthamImageInfoVO.VT_GHICHU+ ","+
					TblVienthamImageInfoVO.VT_TULIEU+ 
				
	     		
	     		" FROM " +  TblVienthamImageInfoVO.VT_TBL + ((condition == null) ? "" : (" WHERE " + condition));

	     		Statement st = conn.createStatement();
				rs = st.executeQuery(sql);

				int count = 0;
				JSONObject json = new JSONObject();
				while (rs.next()) {
					Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
					htbl.put(TblVienthamImageInfoVO.VT_ID, rs.getInt(TblVienthamImageInfoVO.VT_ID));
					htbl.put(TblVienthamImageInfoVO.VT_TENCHUYENGIA, rs.getString(TblVienthamImageInfoVO.VT_TENCHUYENGIA));
					htbl.put(TblVienthamImageInfoVO.VT_NGAYBATDAU, rs.getInt(TblVienthamImageInfoVO.VT_NGAYBATDAU));
					htbl.put(TblVienthamImageInfoVO.VT_NGAYKETTHUC, rs.getInt(TblVienthamImageInfoVO.VT_NGAYKETTHUC));
					htbl.put(TblVienthamImageInfoVO.VT_DOPHANGIAI, rs.getFloat(TblVienthamImageInfoVO.VT_DOPHANGIAI));
					htbl.put(TblVienthamImageInfoVO.VT_TULIEU, rs.getString(TblVienthamImageInfoVO.VT_TULIEU));
					htbl.put(TblVienthamImageInfoVO.VT_TENBANG, rs.getString(TblVienthamImageInfoVO.VT_TENBANG));
					htbl.put(TblVienthamImageInfoVO.VT_GHICHU, rs.getString(TblVienthamImageInfoVO.VT_GHICHU));
					htbl.put("time", Utils.convertInt2DateString(rs.getInt(TblVienthamImageInfoVO.VT_NGAYBATDAU))+" đến " +Utils.convertInt2DateString(rs.getInt(TblVienthamImageInfoVO.VT_NGAYKETTHUC)));
					
					lst.add(htbl);
					count++;
				}
				json.put("rows", lst);
				//conn.close();
				st.close();
				rs.close();
				return json.toJSONString();

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
