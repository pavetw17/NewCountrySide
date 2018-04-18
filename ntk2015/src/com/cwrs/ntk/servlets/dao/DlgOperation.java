package com.cwrs.ntk.servlets.dao;

import com.cwrs.ntk.common.Definitions;
import com.cwrs.ntk.common.ErrorNotifier;
import com.cwrs.ntk.common.JResult;
import com.cwrs.ntk.common.Utils;

import javax.servlet.http.HttpServletRequest;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


public class DlgOperation {
	
	
/**
 * Load data to combobox
 * @param dbo
 * @param tableName 
 * 			tên bảng trong cơ sở dữ liệu của đối tượng 
 * @param idField
 * 			tên trường id trong csdl    
 * @param nameField
 * 			tên trường trong csdl sẽ được hiển thị trong combobox
 * @param condition
 * 			điều kiện sql để lấy dữ liệu
 * @param topSymbol
 * 			thêm hoặc không thêm ký hiệu 'all' trong combobox (hiện tại là '*')
 * @param retType
 * 		    kiểu dữ liệu trả về (html hoặc json)
 * @return
 */

private String getData2Combobox(DBOperation dbo, String tableName, String idField, String nameField, String condition, String topSymbol,
		String prefix_to_id, //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name,  int retType, String sortClause){
		String data = null;
		Statement st = null;
		ResultSet rs = null;
		Connection conn = dbo.getConnection();
		try {
			String sql = null;
			ArrayList<ObjectKV> lstOKV = new ArrayList<ObjectKV>();
			if ("".equalsIgnoreCase(condition) || "null".equalsIgnoreCase(condition)){
				condition = null;
			}
			if(sortClause != null && !"null".equalsIgnoreCase(sortClause)){				
			
			}
			else{
				sortClause = "";
			}
			sql = " SELECT " + idField   + ","
							 + nameField + 
				  " FROM "   + tableName +
				  ((condition == null) ? "" : (" WHERE " + condition)) + " " + sortClause;
			System.out.println("sql"+sql);
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			
			if (prefix_to_id == null){
				
				prefix_to_id = "";
			}
			else
				
				;//prefix_to_id = prefix_to_id.trim();
			
			if (prefix_to_name == null)
				prefix_to_name = "";
			else
				;//prefix_to_name = prefix_to_name.trim();
			
			if (retType == Definitions.TYPE_DATA_HTML_CBB){
				String s = "";
				
				if (topSymbol != null && !"null".equalsIgnoreCase(topSymbol)){
					s = "<option selected=\"true\" value="+ "\""+ prefix_to_id +"-1"+ "\">" + topSymbol +"</option>";
				}
				while (rs.next()) {
				 s+= "<option value="+ "\""+ prefix_to_id + rs.getInt(idField)+ "\">" +prefix_to_name+ rs.getString(nameField)+"</option>";
				}
				data = s;
			}else {//json
				System.out.println("TOPSYMBOL = " + topSymbol);
				if (topSymbol != null && !"null".equalsIgnoreCase(topSymbol)){
			        lstOKV.add(new ObjectKV(String.valueOf(-1), topSymbol, true));
				}
				while (rs.next()) {
			       ObjectKV okv1 = new ObjectKV((prefix_to_id+String.valueOf(rs.getInt(idField))), (prefix_to_name+rs.getString(nameField)));
			       lstOKV.add(okv1);
				}
				if (lstOKV.size() > 0)lstOKV.get(0).setSelected(true);
				data = dbo.genJSONCombobox(lstOKV);
			}
			
			st.close();
			rs.close();
			return data;
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				st.close();
				rs.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

private String getData2Combobox_NoiChuoiName(DBOperation dbo, String tableName, String idField, String nameField, String condition, String topSymbol,
		String prefix_to_id, //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name,  int retType, String sortClause,String idNameFiled, String getNameFiled){
		String data = null;
		Statement st = null;
		ResultSet rs = null;
		Connection conn = dbo.getConnection();
		try {
			String sql = null;
			ArrayList<ObjectKV> lstOKV = new ArrayList<ObjectKV>();
			if ("".equalsIgnoreCase(condition) || "null".equalsIgnoreCase(condition)){
				condition = null;
			}
			if(sortClause != null && !"null".equalsIgnoreCase(sortClause)){				
			
			}
			else{
				sortClause = "";
			}
			sql = " SELECT " + idField   + ","
							 + nameField + 
				  " FROM "   + tableName +
				  ((condition == null) ? "" : (" WHERE " + condition)) + " " + sortClause;
			System.out.println("sql"+sql);
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			
			if (prefix_to_id == null){
				
				prefix_to_id = "";
			}
			else
				
				;//prefix_to_id = prefix_to_id.trim();
			
			if (prefix_to_name == null)
				prefix_to_name = "";
			else
				;//prefix_to_name = prefix_to_name.trim();
			
			if (retType == Definitions.TYPE_DATA_HTML_CBB){
				String s = "";
				
				if (topSymbol != null && !"null".equalsIgnoreCase(topSymbol)){
					s = "<option selected=\"true\" value="+ "\""+ prefix_to_id +"-1"+ "\">" + topSymbol +"</option>";
				}
				while (rs.next()) {
				 s+= "<option value="+ "\""+ prefix_to_id + rs.getInt(idNameFiled)+ "\">" +prefix_to_name+ rs.getString(getNameFiled)+"</option>";
				}
				data = s;
			}else {//json
				System.out.println("TOPSYMBOL = " + topSymbol);
				if (topSymbol != null && !"null".equalsIgnoreCase(topSymbol)){
			        lstOKV.add(new ObjectKV(String.valueOf(-1), topSymbol, true));
				}
				while (rs.next()) {
			       ObjectKV okv1 = new ObjectKV((prefix_to_id+String.valueOf(rs.getInt(idField))), (prefix_to_name+rs.getString(nameField)));
			       lstOKV.add(okv1);
				}
				if (lstOKV.size() > 0)lstOKV.get(0).setSelected(true);
				data = dbo.genJSONCombobox(lstOKV);
			}
			
			st.close();
			rs.close();
			return data;
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				st.close();
				rs.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}




private String getData3Combobox(DBOperation dbo, String tableName, String idField, String nameField1,  String nameField2,String nameField3,String condition, String topSymbol,
		String prefix_to_id, //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name,  int retType, String sortClause){
		String data = null;
		Statement st = null;
		ResultSet rs = null;
		Connection conn = dbo.getConnection();
		try {
			String sql = null;
			ArrayList<ObjectKV> lstOKV = new ArrayList<ObjectKV>();
			if ("".equalsIgnoreCase(condition) || "null".equalsIgnoreCase(condition)){
				condition = null;
			}
			if(sortClause != null && !"null".equalsIgnoreCase(sortClause)){				
			
			}
			else{
				sortClause = "";
			}
			sql = " SELECT " + idField   + ","
							 + nameField1 + ","
							 + nameField2 + ","
							 + nameField3 +
				  " FROM "   + tableName +
				  ((condition == null) ? "" : (" WHERE " + condition)) + " " + sortClause;
			System.out.println("getData3Combobox SQL: "+sql);
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			 System.out.println("sql="+ sql);
			if (prefix_to_id == null){
				
				prefix_to_id = "";
			}
			else
				
				;//prefix_to_id = prefix_to_id.trim();
			
			if (prefix_to_name == null)
				prefix_to_name = "";
			else
				;//prefix_to_name = prefix_to_name.trim();
			
			if (retType == Definitions.TYPE_DATA_HTML_CBB){
				String s = "";
				
				if (topSymbol != null && !"null".equalsIgnoreCase(topSymbol)){
					s = "<option selected=\"true\" value="+ "\""+ prefix_to_id +"-1"+ "\">" + topSymbol +"</option>";
				}
				while (rs.next()) {
				 s+= "<option value="+ "\""+ prefix_to_id + rs.getInt(idField)+ "\">" +prefix_to_name+ rs.getString(nameField1)+" ( "+ Utils.convertInt2DateString(rs.getInt(nameField2)) +" đến " + (rs.getInt(nameField3)==0?"---":Utils.convertInt2DateString(rs.getInt(nameField3)))+" )"+"</option>";
				
				}
				data = s;
				
			}else {//json
				System.out.println("TOPSYMBOL = " + topSymbol);
				if (topSymbol != null && !"null".equalsIgnoreCase(topSymbol)){
			        lstOKV.add(new ObjectKV(String.valueOf(-1), topSymbol, true));
				}
				while (rs.next()) {
			       ObjectKV okv1 = new ObjectKV((prefix_to_id+String.valueOf(rs.getInt(idField))), (prefix_to_name+rs.getString(nameField1)));
			       lstOKV.add(okv1);
				}
				if (lstOKV.size() > 0)lstOKV.get(0).setSelected(true);
				data = dbo.genJSONCombobox(lstOKV);
			}
			
			st.close();
			rs.close();
			return data;
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				st.close();
				rs.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
private String getDataVientham2Combobox(DBOperation dbo, String tableName, String tableName1,String idField, String nameField1,  String nameField2, String nameField3,String joinField1,String joinField2,String condition, String topSymbol,
		String prefix_to_id, //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name,  int retType, String sortClause){
		String data = null;
		Statement st = null;
		ResultSet rs = null;
		Connection conn = dbo.getConnection();
		try {
			String sql = null;
			ArrayList<ObjectKV> lstOKV = new ArrayList<ObjectKV>();
			if ("".equalsIgnoreCase(condition) || "null".equalsIgnoreCase(condition)){
				condition = null;
			}
			if(sortClause != null && !"null".equalsIgnoreCase(sortClause)){				
			
			}
			else{
				sortClause = "";
			}
			sql = " SELECT " + idField   + ","
							 + nameField2 + ","
							 + nameField3 + ","
							 + joinField1 +
				  " FROM "   + tableName +
				  " INNER JOIN  "+tableName1+ 
				  " ON " + nameField1+ " = "+ joinField2+
				  ((condition == null) ? "" : (" WHERE " + condition)) + " " + sortClause;
			System.out.println("getData3Combobox SQL: "+sql);
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			 System.out.println("sql="+ sql);
			if (prefix_to_id == null){
				
				prefix_to_id = "";
			}
			else
				
				;//prefix_to_id = prefix_to_id.trim();
			
			if (prefix_to_name == null)
				prefix_to_name = "";
			else
				;//prefix_to_name = prefix_to_name.trim();
			
			if (retType == Definitions.TYPE_DATA_HTML_CBB){
				String s = "";
				
				if (topSymbol != null && !"null".equalsIgnoreCase(topSymbol)){
					s = "<option selected=\"true\" value="+ "\""+ prefix_to_id +"-1"+ "\">" + topSymbol +"</option>";
				}
				while (rs.next()) {
				 s+= "<option value="+ "\""+ prefix_to_id + rs.getInt(idField)+ "\">" +prefix_to_name+ rs.getString(joinField1)+" ( "+ rs.getString(nameField2) +" ) " +"</option>";
				
				}
				data = s;
				
			}else {//json
				System.out.println("TOPSYMBOL = " + topSymbol);
				if (topSymbol != null && !"null".equalsIgnoreCase(topSymbol)){
			        lstOKV.add(new ObjectKV(String.valueOf(-1), topSymbol, true));
				}
				while (rs.next()) {
			       ObjectKV okv1 = new ObjectKV((prefix_to_id+String.valueOf(rs.getInt(idField))), (prefix_to_name+rs.getString(nameField1)));
			       lstOKV.add(okv1);
				}
				if (lstOKV.size() > 0)lstOKV.get(0).setSelected(true);
				data = dbo.genJSONCombobox(lstOKV);
			}
			
			st.close();
			rs.close();
			return data;
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				st.close();
				rs.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
    public String getGionglua2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_lua",//table name
    						"lua_id", //id field,
    						"lua_ten",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol, 
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						null//type returned
    						);
    }
    public String getTralua2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_tra",//table name
    						"tra_id", //id field,
    						"tra_ten",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						" order by tra_id"//type returned
    						);
    }
    public String getVulua2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_vulua",//table name
    						"vulua_id", //id field,
    						"vulua_ten",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						" order by vulua_id"//type returned
    						);
    }
    public String getLoailua2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_loailua",//table name
    						"loailua_id", //id field,
    						"loailua_ten",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						" order by loailua_id"//type returned
    						);
    }
    public String getBenhhai2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_benh",//table name
    						"benh_id", //id field,
    						"benh_ten",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						null//type returned
    						);
    }
    public String getHientrang2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_hientrang",//table name
    						"hientrang_id", //id field, 
    						"hientrang_ten",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						" order by hientrang_id"//type returned
    						);
    }
    public String getGDSTLua2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_sinhtruong_lua",//table name
    						"sinhtruong_lua_id", //id field,
    						"sinhtruong_lua_mota",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						" order by sinhtruong_lua_id"//type returned
    						);
    }
    public String getHientrangLua2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_hientrang",//table name
    						"hientrang_id", //id field,
    						"hientrang_ten",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						" order by hientrang_id"//type returned
    						);
    }
    public String getSauhai2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_sau",//table name
    						"sau_id", //id field,
    						"sau_ten",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						null//type returned
    						);
    }
    public String getTuoiSau2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tblmotatuoisau",//table name
    						"id_tuoisau", //id field,
    						"mota",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						" order by id_tuoisau"//type returned
    						);
    }
    public String getXa2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_xa_region",//table name
    						"xa_id", //id field,
    						"ten_xa",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						" order by ten_xa"//type returned
    						);
    }
    public String getHuyen2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_huyen_region",//table name
    						"huyen_id", //id field,
    						"ten_huyen",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						" order by ten_huyen"//type returned
    						);
    }
    public String getTinh2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_tinh_region",//table name
    						"tinh_id", //id field,
    						"ten_tinh",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						" order by ten_tinh"//type returned
    						);
    }
    public String getThientai2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_thientai",//table name
    						"thientai_id", //id field,
    						"thientai_ten",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						null//type returned
    						);
    }
    public String getThiendich2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_thiendich",//table name
    						"thiendich_id", //id field,
    						"thiendich_ten",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						null//type returned
    						);
    }
    public String getMucdoTheoLoaiThientai2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_capdo_thientai",//table name
    						"capdo_id", //id field,
    						"capdo_ten",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						" order by capdo_id"//type returned
    						);
    }    
    
    public String getCachBonPhan2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_cachbonphan",//table name
    						"cachbonphan_id", //id field,
    						"cachbonphan_mota",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						null//type returned
    						);
    }    
    
    public String getHuongGio2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_huonggio",//table name
    						"huonggio_id", //id field,
    						"huonggio_ten",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						null//type returned
    						);
    }    
    
    public String getTenThuoc2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_thuoc",//table name
    						"thuoc_id", //id field,
    						"thuoc_ten",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						null//type returned
    						);
    }    
    
    public String getDotThienTai2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_dot_thientai",//table name
    						"dot_id", //id field,
    						"dot_ten",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						null//type returned
    						);
    }    
    
    public String getLoaiPhan2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_phan",//table name
    						"phan_id", //id field,
    						"phan_ten",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						null//type returned
    						);
    }    
    public String getLoaiBando2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData2Combobox(
    						dbo,//DBOperation
    						"tbl_loai_bando",//table name
    						"loai_bando_id", //id field,
    						"loai_bando_ten",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						null//type returned
    						);
    }    
    
    public String getVientham2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getDataVientham2Combobox(
    						dbo,//DBOperation
			
    						"tbl_vientham",//table name
    						"tbl_loai_bando",//table name1
    						"id", //id field, 
    						"loai_bando",//name field1,
    						"ghi_chu",//name field2,
    						"ngayketthuc",//name field3,   						
    						"loai_bando_ten",//join field1,
    						"loai_bando_id",//join field1, 
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						" order by id"//type returned
    						);
    }


    public String getDotThientai3Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	return getData3Combobox(
    						dbo,//DBOperation
 				
    						"tbl_dot_thientai",//table name
    						"dot_id", //id field, 
    						"dot_ten",//name field,
    						"dot_ngaybatdau",//name field,
    						"dot_ngayketthuc",//name field,
    						condition,//condition,
    						topSymbol,//topSymbol,
    						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
    						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
    						retType,
    						" order by dot_ngaybatdau DESC"//type returned
    						);
    }
    public JResult deleteObject(DBOperation dbo, String tableName,String condition){
		Connection conn = dbo.getConnection();


		try {
			//LogWriter.getDBLogger().info(this.userName + " is loading package-package connection data...");
			String sql = null;
             
			if(condition.equalsIgnoreCase("null") ||condition.equalsIgnoreCase(""))
				condition = null;
			sql = " DELETE FROM " +tableName + ((condition == null)?"":(" WHERE "+ condition));
			//System.out.println("Delete SQL: " +sql);
			Statement st = conn.createStatement();
			conn.setAutoCommit(false);
			int ret = st.executeUpdate(sql);
			//conn.close();
			conn.commit();
			st.close();
			if (ret >= 0){
				return (new JResult(Definitions.DB_STR_OK, "Success."));
			}
			return (new JResult(Definitions.DB_STR_FAILED,"Dữ liệu hiện tại không tồn tại."));
		} catch (SQLException e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
			return (new JResult(Definitions.DB_STR_FAILED, e.getMessage()));
		} catch (Exception e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			e.printStackTrace();
			return (new JResult(Definitions.DB_STR_FAILED, e.getMessage()));
		}
	}
    public int checkDataExists(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		Connection conn = dbo.getConnection();
		String fieldName    = request.getParameter("fieldName");
		String condition    = request.getParameter("condition");
		String tableName    = request.getParameter("tableName");
		System.out.println("condition=" + condition);
		try {
			//LogWriter.getDBLogger().info(this.userName + " is loading package-package connection data...");
			String sql = null;
             
			if(condition.equalsIgnoreCase("null") ||condition.equalsIgnoreCase(""))
				condition = null;
			sql = " SELECT "+ fieldName + " FROM " +tableName + ((condition == null)?"":(" WHERE "+ condition));
			System.out.println("checkDataExists sql="+ sql);
			Statement st = conn.createStatement();
			conn.setAutoCommit(false);
			ResultSet rs = st.executeQuery(sql);
			int count = 0;
			while (rs.next()){		
					count++;
			}
			System.out.println("count="+count);
			if (count>0){ 
				st.close();
				return(count);
			}
				
		 return 0;
		} catch (SQLException e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
			return -1;
		} catch (Exception e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			e.printStackTrace();
			return -1;
		}
	}
    public String checkDotThientai(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
  		Connection conn = dbo.getConnection();
  		//String fieldName    = request.getParameter("fieldName");
  		String condition    = "";//request.getParameter("condition");
  		String thientaiID    = request.getParameter("thientai_id");
  		String tinhID    = request.getParameter("tinh_id");
  		String sti    = request.getParameter("sti");
  		String eti    = request.getParameter("eti");
  		String dot_id = request.getParameter("dot_id");
  		String tableName ="tbl_dot_thientai";
  		int startDayInt    = -1;
  		int endDayInt   = -1;
  		
  		if (dot_id==null)
  		System.out.println("dot_id :"+dot_id);
  		System.out.println("endDay :"+request.getParameter("endDay"));
  		try {
  			 startDayInt    = Integer.parseInt(request.getParameter("startDay"));
  			if (request.getParameter("endDay").equalsIgnoreCase(""))
  				endDayInt = 0;
  			else
  			endDayInt   = Integer.parseInt(request.getParameter("endDay"));
  			//LogWriter.getDBLogger().info(this.userName + " is loading package-package connection data...");
  			String sql = null;

  			/*condition = "dot_id= (SELECT MAX(dot_id) FROM "+tableName+ 
  					" WHERE dot_loaithientai="+thientaiID + 
  					" AND dot_tinh_id="+tinhID+")";*/
  			condition = " dot_loaithientai="+thientaiID + 
  					    " AND dot_tinh_id="+tinhID+
  					    " AND dot_ngaybatdau >="+ sti +
  					    " AND dot_ngaybatdau <=" +eti+
  					    ((dot_id !=null)?(" AND dot_id<>"+dot_id):"")
  					   
  					    ;
  			
  			sql = " SELECT "+ "dot_ten,dot_ngaybatdau,dot_ngayketthuc" + " FROM " +tableName + " WHERE " + condition;
  			
  			System.out.println("sql="+ sql);
  			Statement st = conn.createStatement();
  			conn.setAutoCommit(false);
  			ResultSet rs = st.executeQuery(sql);
  			int count = 0;
  			String msgwarning="";
  			ErrorNotifier errorNotifier = new ErrorNotifier();
  			while (rs.next()){
  				int last_ngaybatdau =  rs.getInt("dot_ngaybatdau");
  				int last_ngayketthuc =  rs.getInt("dot_ngayketthuc");
  				
  				System.out.println("last_ngayketthuc="+last_ngayketthuc);
  				
  				if (last_ngaybatdau == startDayInt && endDayInt ==last_ngayketthuc){
  			 		 rs.close();
  			  		 st.close();
  					return (new JResult(Definitions.DB_STR_FAILED,"Đợt thiên tai này đã được tạo")).create(); 
  				}
		
  				if (last_ngayketthuc <=0){ //neu dot cuoi cung ko nhap ngay ket thuc
  					if (startDayInt < rs.getInt("dot_ngaybatdau")){
  						//valid: nhung canh bao ngay bat dau cua dot moi < ngay bat dau cua dot cu
  						String warning=  "Đợt thiên tai: "+ rs.getString("dot_ten") +"("+Utils.convertInt2DateString(last_ngaybatdau)
  								+ " đến ?"+")" +" chưa nhập ngày kết thúc!";
  						errorNotifier.add(warning);
  						
  						//return (new JResult(Definitions.DB_STR_OK,warning)).create(); 	 	
  					} else {
  						//valid: nhung thong bao phai nhap ngay ket thuc cua dot do thoa man < ngay bat dau cua dot vua nhap
  						String warning=  "Đợt thiên tai: "+ rs.getString("dot_ten") +"("+Utils.convertInt2DateString(last_ngaybatdau)
  								+ " đến " +"?"+ ")" +" chưa nhập ngày kết thúc!";
  						//return (new JResult(Definitions.DB_STR_OK,warning)).create(); 
  						errorNotifier.add(warning);
  					}
  				} else {//neu dot nhap cuoi cung co ngay ket thuc
  					if (startDayInt >last_ngayketthuc) {//valid
  						//return (new JResult(Definitions.DB_STR_OK, "")).create(); 	
  					} else {//valid: Bạn dang nhap dot trung thoi gian voi dot
  						String warning=  "Đợt thiên tai bạn nhập có thể trùng với: "+ rs.getString("dot_ten") +"("+Utils.convertInt2DateString(last_ngaybatdau)
  								+ " đến "+ Utils.convertInt2DateString(last_ngayketthuc)+")";
  						//return (new JResult(Definitions.DB_STR_OK,warning)).create(); 	
  						errorNotifier.add(warning);
  					}
  				}
  			
  				 
  				 
  			}
  		 rs.close();
  		 st.close();
  		 if (errorNotifier.hasErrors())return (new JResult(Definitions.DB_STR_OK,errorNotifier.getErrorMessages("Dữ liệu có thể không hợp lệ. Hãy kiểm tra lại:"))).create(); 	
  		 return (new JResult(Definitions.DB_STR_OK, "")).create(); 		
  		} catch (SQLException e) {
  			//LogWriter.getDBLogger().error(
  			//		"Get package-package connection failed. Exception: " + e.getMessage());
  			//throw e;
  			try {
  				conn.rollback();
  			} catch (SQLException e1) {
  				// TODO Auto-generated catch block
  				e1.printStackTrace();
  			}
  			e.printStackTrace();
  			return (new JResult(Definitions.DB_STR_FAILED, "")).create(); 	
  		} catch (Exception e) {
  			//LogWriter.getDBLogger().error(
  			//		"Get package-package connection failed. Exception: " + e.getMessage());
  			//throw e;
  			e.printStackTrace();
  			return (new JResult(Definitions.DB_STR_FAILED, "")).create(); 	
  		}
  	}
    
    public String checkDataRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		Connection conn = dbo.getConnection();
		String listruongID = request.getParameter("listruongID");;
		String fieldName    = request.getParameter("fieldName");
		String condition    = request.getParameter("condition");
		String tableName    = request.getParameter("tableName");
		String lstRuongErrors = "";
		try {
			//LogWriter.getDBLogger().info(this.userName + " is loading package-package connection data...");
			String sql = null;
            String[] listID=listruongID.split(Definitions.SQL_ID_LIST_SEP);
            int i;
            Statement st = conn.createStatement();
			conn.setAutoCommit(false);
			
            for(i=0; i<listID.length;i++) {
            	if(condition.equalsIgnoreCase("null") ||condition.equalsIgnoreCase(""))
    				condition = null;
    			sql = " SELECT "+ fieldName + " FROM " +tableName + ((condition == null)?"":(" WHERE "+ condition + listID[i]));
    			System.out.println("sql="+ sql);
    			ResultSet rs = st.executeQuery(sql);    			
    			int count = 0;
    			
    			while (rs.next()){		
   						count++;
    			}    			
    			System.out.println("count="+count);
    				if (count>0){
    					lstRuongErrors += listID[i];
    					lstRuongErrors += Definitions.SQL_ID_LIST_SEP;
    					
    				}
    				System.out.println("lstRuongErrors="+lstRuongErrors);
    			rs.close();
    					
            }
          
			
            st.close();
            return lstRuongErrors;
		} catch (SQLException e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
			return Definitions.DB_STR_FAILED;
		} catch (Exception e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			e.printStackTrace();
			return Definitions.DB_STR_FAILED;
		}
	}
    public String checkDataDientich(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		Connection conn = dbo.getConnection();
		String listruongID = request.getParameter("listruongID");
		//String fieldName    = request.getParameter("fieldName");
		String condition    = request.getParameter("condition");
		//String tableName    = request.getParameter("tableName");
		float dientich = 0;
		System.out.println("listruongID="+listruongID);
		try {
			//LogWriter.getDBLogger().info(this.userName + " is loading package-package connection data...");
			String sql = null;
            String[] listID=listruongID.split(Definitions.SQL_ID_LIST_SEP);
            int i;
            Statement st = conn.createStatement();
			conn.setAutoCommit(false);		
            for(i=0; i<listID.length;i++) {
            	if(condition.equalsIgnoreCase("null") ||condition.equalsIgnoreCase(""))
    			condition = null;
    			sql = //" SELECT shape_area  FROM tbl_canhdong_region "  + ((condition == null)?"":(" WHERE "+ condition + listID[i]));
    			
    			" SELECT sum(tbl_ruong_region.shape_area) as dientich FROM tbl_ruong_region "+  ((condition == null)?"":(" WHERE "+ condition + listID[i]));
    			System.out.println("sql="+ sql); 
    			ResultSet rs = st.executeQuery(sql);   
    			int count = 0;
    			
    			while (rs.next()){		
   						count++;
   						dientich += (rs.getFloat("dientich")/(float)1);		
    			}    			
    			
    			System.out.println("dientich="+dientich);
    			rs.close();
    					
            }	
            
            st.close();
            return String.valueOf(dientich);
		} catch (SQLException e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
			return String.valueOf(-1);
		} catch (Exception e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			e.printStackTrace();
			return String.valueOf(-1);
		}
	}
    public String checkCount(DBOperation dbo, HttpServletRequest request){
		Connection conn = dbo.getConnection();
		String fieldName    = (String) request.getAttribute("fieldName");
		String condition    = (String) request.getAttribute("condition");
		String tableName    = (String) request.getAttribute("tableName");
		try {
			//LogWriter.getDBLogger().info(this.userName + " is loading package-package connection data...");
			String sql = null;
           			
			if (condition != null){
				if (condition.equalsIgnoreCase(""))
					condition = null;
			}
			sql = " SELECT count("+ fieldName + ") AS count FROM " +tableName + ((condition == null)?"":(" WHERE "+ condition));
			//System.out.println("sql checkCount="+ sql);
			Statement st = conn.createStatement();
			conn.setAutoCommit(false);
			ResultSet rs = st.executeQuery(sql);
			int max = 0;
			while (rs.next()){		
					max = rs.getInt("count");
			}
				st.close();
				return String.valueOf(max);
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			return String.valueOf(-1);
		} catch (Exception e) {
			e.printStackTrace();
			return String.valueOf(-1);
		}
	}
    public String checkMAX(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		Connection conn = dbo.getConnection();
		String fieldName    = request.getParameter("fieldName");
		String condition    = request.getParameter("condition");
		String tableName    = request.getParameter("tableName");
		try {
			//LogWriter.getDBLogger().info(this.userName + " is loading package-package connection data...");
			String sql = null;
           			
			if(condition.equalsIgnoreCase("null") ||condition.equalsIgnoreCase(""))
				condition = null;
			sql = " SELECT MAX("+ fieldName + ") AS max FROM " +tableName + ((condition == null)?"":(" WHERE "+ condition));
			System.out.println("checkMAX sql="+ sql);
			Statement st = conn.createStatement();
			conn.setAutoCommit(false);
			ResultSet rs = st.executeQuery(sql);
			int max = 0;
			while (rs.next()){		
					max = rs.getInt("max");
			}
				st.close();
				return String.valueOf(max);
		} catch (SQLException e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
			return String.valueOf(-1);
		} catch (Exception e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			e.printStackTrace();
			return String.valueOf(-1);
		}
	}
    public int checkGiongLuaGieocayXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		Connection conn = dbo.getConnection();
		String xaid    = request.getParameter("id");
		String vuluaid    = request.getParameter("vulua_id");
		String giongluaid    = request.getParameter("gionglua_id");
		String time_str1    = request.getParameter("time_int1");
		String time_str2    = request.getParameter("time_int2");
		try {
			//LogWriter.getDBLogger().info(this.userName + " is loading package-package connection data...");
			String sql = null;
			sql = 
			
			"  SELECT pb_lua_giong as gionglua_xa,"+
			"	TBL_GL_CD_TMP.ttgc_cd_gionglua_id as gionglua_cd,"+
			"   TBL_GL_R_TMP.ttgc_gionglua_id as gionglua_ruong"+
			" FROM ("+
			" SELECT tbl_ttgc_xa.pb_lua_giong,tbl_ttgc_xa.pb_lua_vu, count(*)"+
			" FROM tbl_ttgc_xa"+
			" WHERE tbl_ttgc_xa.pb_lua_xa ="+xaid+
			" AND tbl_ttgc_xa.pb_lua_ngaybatdau >="+time_str1+
			" AND tbl_ttgc_xa.pb_lua_ngaybatdau <= "+time_str2+
			" AND tbl_ttgc_xa.pb_lua_vu ="+vuluaid+
			" AND tbl_ttgc_xa.pb_lua_giong ="+giongluaid+
			" GROUP BY tbl_ttgc_xa.pb_lua_giong,tbl_ttgc_xa.pb_lua_vu HAVING count(*) >=1) AS TBL_GL_XA_TMP"+
			" FULL JOIN"+
			"        ( SELECT tbl_ttgc_canhdong.ttgc_cd_gionglua_id,"+
			"        		 tbl_ttgc_canhdong.ttgc_cd_vulua,count(*)"+
			"          FROM   tbl_ttgc_canhdong"+
			"          WHERE  tbl_ttgc_canhdong.ttgc_cd_vulua ="+vuluaid+
			"          AND    tbl_ttgc_canhdong.ttgc_cd_ngaygieocay>= "+time_str1+
			"          AND    tbl_ttgc_canhdong.ttgc_cd_ngaygieocay<="+time_str2+
			"          AND    tbl_ttgc_canhdong.ttgc_cd_gionglua_id = "+giongluaid+
			"          AND    tbl_ttgc_canhdong.ttgc_cd_canhdong_id IN"+
			"              (SELECT canhdong_id FROM tbl_canhdong_region WHERE xa_id = "+xaid+")"+
			"          GROUP BY tbl_ttgc_canhdong.ttgc_cd_gionglua_id, tbl_ttgc_canhdong.ttgc_cd_vulua HAVING count(*) >=1"+
			"        ) AS TBL_GL_CD_TMP"+
			" ON TBL_GL_CD_TMP.ttgc_cd_vulua = TBL_GL_XA_TMP.pb_lua_vu"+
			" FULL JOIN"+
			"      (SELECT tbl_ttgc_ruong_tmp.ttgc_gionglua_id,"+
			"               tbl_ttgc_ruong_tmp.ttgc_vulua,"+
			"        count(*)"+
			"       FROM tbl_ttgc_ruong_tmp"+
			"       WHERE tbl_ttgc_ruong_tmp.ttgc_ngaybatdau>="+time_str1+
			"       AND   tbl_ttgc_ruong_tmp.ttgc_ngaybatdau<="+time_str2+
			"       AND   tbl_ttgc_ruong_tmp.ttgc_vulua = "+vuluaid+
			"       AND tbl_ttgc_ruong_tmp.ttgc_gionglua_id = "+giongluaid+
			"       AND tbl_ttgc_ruong_tmp.ttgc_ruong_id IN"+
			"            (SELECT ruong_id FROM tbl_ruong_region WHERE xa_id = "+xaid+")"+
			"       GROUP BY tbl_ttgc_ruong_tmp.ttgc_gionglua_id, tbl_ttgc_ruong_tmp.ttgc_vulua HAVING count(*) >=1 ) AS TBL_GL_R_TMP"+
			" ON TBL_GL_R_TMP.ttgc_vulua = TBL_GL_XA_TMP.pb_lua_vu";
			
				
			System.out.println("sql check xa="+ sql);
			Statement st = conn.createStatement();
			conn.setAutoCommit(true);
			ResultSet rs = st.executeQuery(sql);
			int hasGL = 0;
			while (rs.next()){		
					int gl_xa = rs.getInt("gionglua_xa");
					int gl_cd = rs.getInt("gionglua_cd");
					int gl_ruong = rs.getInt("gionglua_ruong");
					//System.out.println(gl_xa);System.out.println(gl_cd);System.out.println(gl_ruong);
					if (gl_xa != 0 || gl_cd != 0||gl_ruong != 0){
						hasGL=1;
					}
			}
			st.close();
			return hasGL;//String.valueOf(max);
		} catch (SQLException e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
			return -1;
		} catch (Exception e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			e.printStackTrace();
			return -1;
		}
	}
  
    public int checkGiongLuaGieocayCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		Connection conn = dbo.getConnection();
		String canhdongid    = request.getParameter("id");
		String vuluaid    = request.getParameter("vulua_id");
		String giongluaid    = request.getParameter("gionglua_id");
		String time_str1    = request.getParameter("time_int1");
		String time_str2    = request.getParameter("time_int2");
		try {
			//LogWriter.getDBLogger().info(this.userName + " is loading package-package connection data...");
			String sql = null;
			sql = 
			
			" SELECT ttgc_cd_gionglua_id as gionglua_cd,"+
			"         TBL_GL_R_TMP.ttgc_gionglua_id as gionglua_ruong"+
			" FROM "+
			"        ( SELECT tbl_ttgc_canhdong.ttgc_cd_gionglua_id,"+
			"        		 tbl_ttgc_canhdong.ttgc_cd_vulua,count(*)"+
			"          FROM   tbl_ttgc_canhdong"+
			"          WHERE  tbl_ttgc_canhdong.ttgc_cd_vulua ="+vuluaid+
			"          AND    tbl_ttgc_canhdong.ttgc_cd_ngaygieocay>= "+time_str1+
			"          AND    tbl_ttgc_canhdong.ttgc_cd_ngaygieocay<= "+time_str2+
			"          AND    tbl_ttgc_canhdong.ttgc_cd_gionglua_id = "+giongluaid+
			"          AND    tbl_ttgc_canhdong.ttgc_cd_canhdong_id = "+canhdongid+
			"          GROUP BY tbl_ttgc_canhdong.ttgc_cd_gionglua_id, tbl_ttgc_canhdong.ttgc_cd_vulua HAVING count(*) >=1"+
			"        ) AS TBL_GL_CD_TMP"+
			" FULL JOIN"+
			"      (SELECT tbl_ttgc_ruong_tmp.ttgc_gionglua_id,"+
			"               tbl_ttgc_ruong_tmp.ttgc_vulua,"+
			"        count(*)"+
			"       FROM tbl_ttgc_ruong_tmp"+
			"       WHERE tbl_ttgc_ruong_tmp.ttgc_ngaybatdau >="+time_str1+
			"       AND   tbl_ttgc_ruong_tmp.ttgc_ngaybatdau <="+time_str2+
			"       AND   tbl_ttgc_ruong_tmp.ttgc_vulua      = "+vuluaid+
			"       AND tbl_ttgc_ruong_tmp.ttgc_gionglua_id = "+giongluaid+
			"       AND tbl_ttgc_ruong_tmp.ttgc_ruong_id IN"+
			"            (SELECT ruong_id FROM tbl_ruong_region WHERE canhdong_id = "+canhdongid+")"+
			"       GROUP BY tbl_ttgc_ruong_tmp.ttgc_gionglua_id, tbl_ttgc_ruong_tmp.ttgc_vulua HAVING count(*) >=1 ) AS TBL_GL_R_TMP"+
			" ON TBL_GL_R_TMP.ttgc_vulua = TBL_GL_CD_TMP.ttgc_cd_vulua";
			
				
			System.out.println("sql check canhdong="+ sql);
			Statement st = conn.createStatement();
			conn.setAutoCommit(true);
			ResultSet rs = st.executeQuery(sql);
			int hasGL = 0;
			while (rs.next()){		
					int gl_cd = rs.getInt("gionglua_cd");
					int gl_ruong = rs.getInt("gionglua_ruong");
					//System.out.println(gl_xa);System.out.println(gl_cd);System.out.println(gl_ruong);
					if (gl_cd != 0||gl_ruong != 0){
						hasGL=1;
					}
			}
			System.out.println("hasGL="+hasGL);
			st.close();
			return hasGL;//String.valueOf(max);
		} catch (SQLException e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
			return -1;
		} catch (Exception e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			e.printStackTrace();
			return -1;
		}
	}



    public String getPhuongphapGieocay2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
    	ArrayList<ObjectKV> lstOKV = new ArrayList<ObjectKV>();
    	if (topSymbol != null && !"null".equalsIgnoreCase(topSymbol)){
	        lstOKV.add(new ObjectKV(String.valueOf(-1), topSymbol, true));
		}
    	lstOKV.add(new ObjectKV("Gieo sạ", "Gieo sạ"));
    	lstOKV.add(new ObjectKV("Cấy thẳng", "Cấy thẳng"));
    	lstOKV.add(new ObjectKV("Lúa chét", "Lúa chét"));
		lstOKV.get(0).setSelected(true);
		return dbo.genJSONCombobox(lstOKV);
    	

    }
    
    public String getDientichGieocayXa(DBOperation dbo, String id, String vulua_id, String gionglua,String time_int1, String time_int2){
    	
    	//get dien tich gieo cay ruong
    	String sql=""; 
    	Connection conn = dbo.getConnection();
    	ResultSet rs;
 		Statement st;
 		try{
 		st= conn.createStatement();
 		if(gionglua!=null){
 			if(gionglua.equalsIgnoreCase("null"))
 				gionglua=null;
 		}
		
    	sql =
    	      "   SELECT "+
    	    "		SUM(TBL_RUONG_TMP.shape_area) as dien_tich"+
    	    "	 FROM "+
    	    "	 tbl_ttgc_ruong_tmp"+
    	    "	 INNER JOIN (" +
    	    "     SELECT tbl_ruong_region.shape_area, tbl_ruong_region.ruong_id FROM tbl_ruong_region where tbl_ruong_region.xa_id ="+id+
    	    ")   AS TBL_RUONG_TMP"+
    	    "	 ON  TBL_RUONG_TMP.ruong_id = tbl_ttgc_ruong_tmp.ttgc_ruong_id"+
    	    "	 WHERE "+
    	    "	  tbl_ttgc_ruong_tmp.ttgc_vulua ="+vulua_id+
    	    "	 AND"+
    	    "	  tbl_ttgc_ruong_tmp.ttgc_ngaybatdau >="+time_int1+
    	    "	 AND "+
    	    "	  tbl_ttgc_ruong_tmp.ttgc_ngaybatdau <="+time_int2+
    	    (gionglua==null?"":(" AND  tbl_ttgc_ruong_tmp.ttgc_gionglua_id ="+gionglua));
    	System.out.println("sql = " + sql);
    /*	" SELECT "+
    	"	SUM(tbl_ruong_region.shape_area) as dien_tich"+
    	" FROM"+
    	"  tbl_ruong_region"+
    	"  INNER JOIN tbl_ttgc_ruong_tmp ON (tbl_ruong_region.ruong_id = tbl_ttgc_ruong_tmp.ttgc_ruong_id)"+
    	" WHERE"+
    	"  tbl_ruong_region.xa_id ="+ xa_id  +
    	" AND "+
    	"  tbl_ttgc_ruong_tmp.ttgc_vulua ="+vulua_id +
    	" AND "+
    	"  tbl_ttgc_ruong_tmp.ttgc_ngaybatdau >="+ time_int1+
    	" AND "+
    	"  tbl_ttgc_ruong_tmp.ttgc_ngaybatdau <="+ time_int2+
    	" GROUP BY tbl_ruong_region.xa_id";
    */	
		rs = st.executeQuery(sql);
		float dt_gieocay_ruong = 0;
		while(rs.next()){
			dt_gieocay_ruong = rs.getFloat("dien_tich")/10000;
			System.out.println("dt_gieocay_ruong = " + dt_gieocay_ruong);
		}
		rs.close();
		//get dien tich canh dong
		sql =
		"	SELECT SUM(tbl_ttgc_canhdong.ttgc_cd_dientich) AS dien_tich"+
		"	 FROM "+
		"	 tbl_ttgc_canhdong"+

		"	 WHERE"+
		"			  tbl_ttgc_canhdong.ttgc_cd_canhdong_id IN "+
		"(SELECT tbl_canhdong_region.canhdong_id FROM tbl_canhdong_region WHERE tbl_canhdong_region.xa_id ="+id+ ")"+
		"		AND	  tbl_ttgc_canhdong.ttgc_cd_vulua ="+vulua_id+
		"			 AND "+
		"			  tbl_ttgc_canhdong.ttgc_cd_ngaygieocay >="+time_int1+
		"			 AND "+
		"			  tbl_ttgc_canhdong.ttgc_cd_ngaygieocay <="+time_int2+
		(gionglua==null?"":(" AND  tbl_ttgc_canhdong.ttgc_cd_gionglua_id ="+gionglua));
		System.out.println("sql = " + sql);
		rs = st.executeQuery(sql);
		float dt_gieocay_canhdong = 0;
		while(rs.next()){
			dt_gieocay_canhdong = rs.getFloat("dien_tich");
			System.out.println("dt_gieocay_canhdong = " + dt_gieocay_canhdong);
		}
		rs.close();
		 
		//get dien tich xa
		sql =
		"          SELECT       "+       
		"		  SUM(tbl_ttgc_xa.pb_lua_dt) AS dien_tich"+
		"		 FROM"+
		"		  tbl_ttgc_xa"+
		"		 WHERE"+
		"		  tbl_ttgc_xa.pb_lua_xa ="+id+
		"		 AND "+
		"		 tbl_ttgc_xa.pb_lua_vu="+vulua_id+
		"		 AND "+
		"		  tbl_ttgc_xa.pb_lua_ngaybatdau >="+time_int1+
		"		 AND "+
		"		  tbl_ttgc_xa.pb_lua_ngaybatdau <="+time_int2+
		(gionglua==null?"":(" AND  tbl_ttgc_xa.pb_lua_giong ="+gionglua));
		System.out.println("sql = " + sql);
		rs = st.executeQuery(sql);
		float dt_gieocay_xa = 0;
		while(rs.next()){
			dt_gieocay_xa = rs.getFloat("dien_tich");
			System.out.println("dt_gieocay_xa = " + dt_gieocay_xa);
		}
		rs.close();
		
		float total_dientich_gieocay = dt_gieocay_xa + dt_gieocay_canhdong +dt_gieocay_ruong;
		return (new JResult(Definitions.DB_STR_OK, total_dientich_gieocay)).create(); 
 		}catch(SQLException e){
 			e.printStackTrace();
 			return (new JResult(Definitions.DB_STR_FAILED,"execute: " +sql +" "+e.getMessage())).createString();
 		}
    	
    }
 public String getDientichGieocayCanhdong(DBOperation dbo, String id, String vulua_id, String gionglua,String time_int1, String time_int2){
    	
    	//get dien tich gieo cay ruong
    	String sql=""; 
    	Connection conn = dbo.getConnection();
    	ResultSet rs;
 		Statement st;
 		try{
 		st= conn.createStatement();
 		if(gionglua!=null){
 			if(gionglua.equalsIgnoreCase("null"))
 				gionglua=null;
 		}

	
		//get dien tich canh dong
		sql =
		"	SELECT SUM(tbl_ttgc_canhdong.ttgc_cd_dientich) AS dien_tich"+
		"	 FROM "+
		"	 tbl_ttgc_canhdong"+
		"	 WHERE"+
		"			 tbl_ttgc_canhdong.ttgc_cd_canhdong_id ="+id+
		"		AND	  tbl_ttgc_canhdong.ttgc_cd_vulua ="+vulua_id+
		"			 AND "+
		"			  tbl_ttgc_canhdong.ttgc_cd_ngaygieocay >="+time_int1+
		"			 AND "+
		"			  tbl_ttgc_canhdong.ttgc_cd_ngaygieocay <="+time_int2+
		(gionglua==null?"":(" AND  tbl_ttgc_canhdong.ttgc_cd_gionglua_id ="+gionglua));
		System.out.println("sql = " + sql);
		rs = st.executeQuery(sql);
		float dt_gieocay_canhdong = 0;
		while(rs.next()){
			dt_gieocay_canhdong = rs.getFloat("dien_tich");
			System.out.println("dt_gieocay_canhdong = " + dt_gieocay_canhdong);
		}
		rs.close();	
		float total_dientich_gieocay = dt_gieocay_canhdong ;
		return (new JResult(Definitions.DB_STR_OK, total_dientich_gieocay)).create(); 
 		}catch(SQLException e){
 			e.printStackTrace();
 			return (new JResult(Definitions.DB_STR_FAILED,"execute: " +sql +" "+e.getMessage())).createString();
 		}
    	
    }
 
 
 public String getVanBanPhanLoai2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
 	return getData2Combobox(
 						dbo,//DBOperation
 						"tbl_phanloai_vanban",//table name
 						"id_phanloai", //id field,
 						"loai_vanbanphaply",//name field,
 						condition,//condition,
 						topSymbol,//topSymbol,
 						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
 						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
 						retType,
 						" order by id_phanloai"//type returned
 						);
 }
 
 public String getTinTucPhanLoai2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 	return getData2Combobox(
	 						dbo,//DBOperation
	 						"tbl_phanloai_tintuc",//table name
	 						"id_phanloai_tintuc", //id field,
	 						"ten_phanloai",//name field,
	 						condition,//condition,
	 						topSymbol,//topSymbol,
	 						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
	 						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
	 						retType,
	 						" order by id_phanloai_tintuc"//type returned
	 						);
	 }
 public String getToChuc2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 	return getData2Combobox(
	 						dbo,//DBOperation
	 						"tbl_tochuc",//table name
	 						"id_tochuc", //id field,
	 						"tentc",//name field,
	 						condition,//condition,
	 						topSymbol,//topSymbol,
	 						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
	 						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
	 						retType,
	 						" order by tentc"//type returned
	 						);
	 }
 
 public String getNoiDungThuyetMinhNhom2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox(
			 dbo,//DBOperation
			 "tbl_noidung_cv",//table name
			 "id_noidung", //id field,
			 "ten_noidung",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by ten_noidung"//type returned
			 );
 }
 
 public String getTOCHUCDeTaiToChuc2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 	return getData2Combobox_NoiChuoiName(
	 						dbo,//DBOperation
	 						" tbl_tochuc a  "
	 						+ " inner join tbl_detai_tochuc b "
	 						+ " on a.id_tochuc = b.id_tochuc",//table name
	 						"a.id_tochuc", //id field,
	 						"tentc",//name field,
	 						condition,//condition,
	 						topSymbol,//topSymbol,
	 						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
	 						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
	 						retType,
	 						" order by tentc",//type returned,
	 						"id_tochuc", //sql text id
	 						"tentc" //sql text name
	 						);
	 }
 
 public String getTHUYETMINHDeTaiToChuc2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox_NoiChuoiName(
			 dbo,//DBOperation
			 " tbl_thuyetminh_detai_duan a  "
			 + " inner join tbl_detai_tochuc b "
			 + " on a.id_thuyetminh_detai_duan = b.id_thuyetminhdetai",//table name
			 "a.id_thuyetminh_detai_duan", //id field,
			 "masodt",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by masodt",//type returned,
			 "id_thuyetminh_detai_duan", //sql text id
			 "masodt" //sql text name
			 );
 }
 
 public String getDETAIDeTaiToChuc2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox_NoiChuoiName(
			 dbo,//DBOperation
			 " tbl_detai_duan a  "
			 + " inner join tbl_detai_tochuc b "
			 + " on a.id_detai = b.id_detai",//table name
			 "a.id_detai", //id field,
			 "tendt",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by tendt",//type returned,
			 "id_detai", //sql text id
			 "tendt" //sql text name
			 );
 }
 
 public String getNhomDeTaiDuAn2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 	return getData2Combobox(
	 						dbo,//DBOperation
	 						"tbl_phanloai_detai_duan",//table name
	 						"id_phannhom_detai", //id field,
	 						"ten_phannhom_detai",//name field,
	 						condition,//condition,
	 						topSymbol,//topSymbol,
	 						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
	 						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
	 						retType,
	 						" order by ten_phannhom_detai"//type returned
	 						);
	 }
 public String getDeTaiDuAn2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 	return getData2Combobox(
	 						dbo,//DBOperation
	 						"tbl_detai_duan",//table name
	 						"id_detai", //id field,
	 						"tendt",//name field,
	 						condition,//condition,
	 						topSymbol,//topSymbol,
	 						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
	 						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
	 						retType,
	 						" order by tendt"//type returned
	 						);
	 }
 
 public String getThuyetMinhDeTai2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 	return getData2Combobox(
	 						dbo,//DBOperation
	 						"tbl_thuyetminh_detai_duan",//table name
	 						"id_thuyetminh_detai_duan", //id field,
	 						"masodt",//name field,
	 						condition,//condition,
	 						topSymbol,//topSymbol,
	 						prefix_to_id, //chèn thêm prefix_to_id vào trước id value
	 						prefix_to_name, //chèn thêm prefix_to_name vào trước name value
	 						retType,
	 						" order by masodt"//type returned
	 						);
	 }
 
 public String getTieuChiNTMCha2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox(
			 dbo,//DBOperation
			 "tbl_tieuchi_xaydung_ntm",//table name
			 "id_tieuchi", //id field,
			 "ten_tieuchi",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by ten_tieuchi"//type returned
			 );
 }
 
 public String getKhuVuc2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox(
			 dbo,//DBOperation
			 "tbl_phanloai_khuvuc",//table name
			 "id_khuvuc", //id field,
			 "ten_khuvuc",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by ten_khuvuc"//type returned
			 );
 }
 
 public String getTieuChiCon2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox(
			 dbo,//DBOperation
			 "tbl_tieuchi_xaydung_ntm",//table name
			 "id_tieuchi", //id field,
			 "ten_tieuchi",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by ten_tieuchi"//type returned
			 );
 }
 
 public String getXaDiem2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox(
			 dbo,//DBOperation
			 "tbl_xadiem",//table name
			 "id_xadiem", //id field,
			 "ten_xadiem",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by ten_xadiem"//type returned
			 );
 }
 
 public String getNhanSu2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox(
			 dbo,//DBOperation
			 "tbl_nhansu",//table name
			 "id_nhansu", //id field,
			 "hoten",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by hoten"//type returned
			 );
 }
 
 public String getVaiTro2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox(
			 dbo,//DBOperation
			 "tbl_vaitro",//table name
			 "id_vaitro", //id field,
			 "ten_vaitro",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by ten_vaitro"//type returned
			 );
 }
 
 public String getChuyenGia2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox_NoiChuoiName(
			 dbo,//DBOperation
			 "tbl_chuyengia",//table name
			 "id_chuyengia", //id field,
			 "(hoten || ' - ' || donvictac) as hoten",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by hoten",//type returned
			 "id_chuyengia",
			 "hoten"
			 );
 }
 
 public String getPhanLoaiKq2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox(
			 dbo,//DBOperation
			 "tbl_phanloai_kq",//table name
			 "id_phanloai", //id field,
			 "ten_phanloai",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by ten_phanloai"//type returned
			 );
 }
 
 public String getPhanLoaiPhieu2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox(
			 dbo,//DBOperation
			 "tbl_phanloai_phieu",//table name
			 "id_phanloaiphieu", //id field,
			 "ten_phanloai_phieu",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by ten_phanloai_phieu"//type returned
			 );
 }
 
 public String getKienNghi2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox(
			 dbo,//DBOperation
			 "tbl_kiennghi",//table name
			 "id_kiennghi", //id field,
			 "tenkiennghi",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by tenkiennghi"//type returned
			 );
 }
 
 public String getPhanLoaiThanhVien2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox(
			 dbo,//DBOperation
			 "tbl_phanloai_thanhvien",//table name
			 "id_phanloai_thanhvien", //id field,
			 "mota_thanhvien",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by mota_thanhvien"//type returned
			 );
 }
 
 public String getPhanLoaiSanPham2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox(
			 dbo,//DBOperation
			 "tbl_phanloai_sp",//table name
			 "id_phanloai_sp", //id field,
			 "ten_phanloai_sp",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by ten_phanloai_sp"//type returned
			 );
 }
 
 public String getGiaiDoan2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox(
			 dbo,//DBOperation
			 "tbl_giaidoan",//table name
			 "id_giaidoan", //id field,
			 "tengiaidoan",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by tengiaidoan"//type returned
			 );
 }
 
 public String getFolderHinhAnhDeTai2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox(
			 dbo,//DBOperation
			 "tbl_picture_folder",//table name
			 "id_folder", //id field,
			 "foldername",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by foldername"//type returned
			 );
 }
 
 public String getTienDoCapKinhPhi2Cbb(DBOperation dbo,String condition, int retType, String topSymbol,String prefix_to_id, String prefix_to_name){
	 return getData2Combobox(
			 dbo,//DBOperation
			 "tbl_tiendo_capkinhphi",//table name
			 "id_tiendo_capkinhphi", //id field,
			 "ghichu",//name field,
			 condition,//condition,
			 topSymbol,//topSymbol,
			 prefix_to_id, //chèn thêm prefix_to_id vào trước id value
			 prefix_to_name, //chèn thêm prefix_to_name vào trước name value
			 retType,
			 " order by id_tiendo_capkinhphi"//type returned
			 );
 }
 

}
