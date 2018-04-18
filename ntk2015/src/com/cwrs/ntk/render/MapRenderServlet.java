package com.cwrs.dbscl.render;

import java.awt.Color;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.Hashtable;
import java.util.Random;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.json.simple.JSONObject;

import com.cwrs.dbscl.common.Config;
import com.cwrs.dbscl.common.Definitions;
import com.cwrs.dbscl.common.HTRange;
import com.cwrs.dbscl.common.TblHuyen;
import com.cwrs.dbscl.common.TblTinh;
import com.cwrs.dbscl.common.TblXa;
import com.cwrs.dbscl.common.Utils;
import com.cwrs.dbscl.dataobject.TblGiongLua;
import com.cwrs.dbscl.dataobject.TblRuongGieocay;
import com.cwrs.dbscl.dataobject.TblRuongThientai;
import com.cwrs.dbscl.dataobject.TblTraLua;
import com.cwrs.ntk.servlets.dao.xxx.DBOperation;
import com.cwrs.dbscl.servlets.dao.DBPoolServlet;

/**
 * Servlet implementation class MapRenderServlet
 */
@WebServlet("/MapRenderServlet") 
public class MapRenderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MapRenderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//Set unicode for response data
		response.setContentType("text/html; charset=utf-8");
		Connection conn = null;
	    Statement stmt = null;
	    ResultSet rset = null;
	    //PrintWriter out = response.getWriter();
	    try { 
	      	 DataSource ds = DBPoolServlet.getDatasource();
	    	 conn = ds.getConnection();
	         System.out.println("connection pool: =" +conn.hashCode());
	         DBOperation  dbo = new DBOperation();
	         dbo.setConnection(conn);
	    	 processRequest(dbo, request, response);
	    	 dbo.closeConnection();
        } catch (Exception ex) {
	         ex.printStackTrace();
	      } finally { 
	          if (rset != null) {
	              try {
	                  rset.close();
	              } catch (SQLException ex) {
	                  ex.printStackTrace();
	              }
	              rset = null;
	          }
	          if (stmt != null) {
	              try {
	                  stmt.close();
	              } catch (SQLException ex) {
	                  ex.printStackTrace();
	              }
	              stmt = null;
	          }
	          if (conn != null) {
	              try {
	                  conn.close();
	              } catch (SQLException ex) {
	                  ex.printStackTrace();
	              }
	              conn = null;
	          }
	      }
	}
	protected void  getInfoOfAreaClicked(DBOperation dbo, HttpServletRequest request, HttpServletResponse response){
		String posWKT = request.getParameter("position");
		String tableName = request.getParameter("table");
		String idName = request.getParameter("id");
		String s = (String)getInfoOfArea(dbo, posWKT, tableName, idName, /*retTypeIsJSON*/ true);

		try {
			response.getWriter().print(s);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
	}
	
	private Object getInfoOfArea(DBOperation dbo, String postWKT, String tableName, String idName, boolean retTypeIsJSON){
		Hashtable<String ,String > htb = new Hashtable<String, String>();
		Connection conn = dbo.getConnection();
		ResultSet rs = null;
		Statement st = null;
		try {

			st = conn.createStatement();
			String query = "";
			if (tableName.equalsIgnoreCase("tbl_xa_region")){//tim theo xa
				query = "SELECT tbl_xa_region.tinh_id, tbl_tinh_region.ten_tinh, tbl_xa_region.huyen_id, tbl_huyen_region.ten_huyen, tbl_xa_region.xa_id, tbl_xa_region.ten_xa" +
						" "+ " FROM " + tableName+
						" INNER JOIN tbl_huyen_region ON tbl_huyen_region.huyen_id=tbl_xa_region.huyen_id "+
						" INNER JOIN tbl_tinh_region ON tbl_tinh_region.tinh_id= tbl_xa_region.tinh_id " +
						" WHERE ST_Intersects(tbl_xa_region.the_geom , ST_GeomFromText('"+postWKT+"',4756)) = 't'";
				System.out.println("query = "+query);
				rs = st.executeQuery(query);
				String xa_ten,huyen_ten,tinh_ten;
				int xa_id,huyen_id,tinh_id;
				 
				while (rs.next()) {
									
					xa_id = rs.getInt("xa_id");
					xa_ten = rs.getString("ten_xa");
					htb.put("xa_ten", xa_ten);
					htb.put("xa_id", String.valueOf(xa_id));
					System.out.println("xa_id= "+xa_id);
					System.out.println("xa_ten= "+xa_ten);
					
					huyen_id = rs.getInt("huyen_id");
					huyen_ten = rs.getString("ten_huyen");
					htb.put("huyen_ten", huyen_ten);
					htb.put("huyen_id", String.valueOf(huyen_id));
					
					tinh_id = rs.getInt("tinh_id");
					tinh_ten = rs.getString("ten_tinh");
					htb.put("tinh_ten", tinh_ten);
					htb.put("tinh_id", String.valueOf(tinh_id));
					
					
				}
				
				
			}else
			
			if (tableName.equalsIgnoreCase("tbl_huyen_region")){//tim theo xa
				query = "SELECT tbl_huyen_region.tinh_id, tbl_tinh_region.ten_tinh, tbl_huyen_region.huyen_id, tbl_huyen_region.ten_huyen "+ " FROM " + tableName+
						" INNER JOIN tbl_tinh_region ON tbl_tinh_region.tinh_id= tbl_huyen_region.tinh_id " +
						" WHERE ST_Intersects(tbl_huyen_region.the_geom , ST_GeomFromText('"+postWKT+"',4756)) = 't'";
				
				rs = st.executeQuery(query);
				String huyen_ten,tinh_ten;
				int huyen_id,tinh_id;
				while (rs.next()) {

					htb.put("xa_ten", "");
					htb.put("xa_id", String.valueOf(-1));
					
					huyen_id = rs.getInt("huyen_id");
					huyen_ten = rs.getString("ten_huyen");
					htb.put("huyen_ten", huyen_ten);
					htb.put("huyen_id", String.valueOf(huyen_id));
					
					tinh_id = rs.getInt("tinh_id");
					tinh_ten = rs.getString("ten_tinh");
					htb.put("tinh_ten", tinh_ten);
					htb.put("tinh_id", String.valueOf(tinh_id));
					
					System.out.println("xa_id =" +htb.get("xa_id")+","+"huyen_id =" +htb.get("huyen_id")+","+"tinh_id =" +htb.get("tinh_id"));
				}
				
				
			}else
			if (tableName.equalsIgnoreCase("tbl_tinh_region")){//tim theo tinh
				query = "SELECT tbl_tinh_region.tinh_id,tbl_tinh_region.ten_tinh  "+ " FROM " + tableName+
						" WHERE ST_Intersects(tbl_tinh_region.the_geom , ST_GeomFromText('"+postWKT+"',4756)) = 't'";
				
				rs = st.executeQuery(query);
				String tinh_ten;
				int tinh_id;
				while (rs.next()) {

					htb.put("xa_ten", "");
					htb.put("xa_id", String.valueOf(-1));
					htb.put("huyen_ten", "");
					htb.put("huyen_id", String.valueOf(-1));
					
					tinh_id = rs.getInt("tinh_id");
					tinh_ten = rs.getString("ten_tinh");
					htb.put("tinh_ten", tinh_ten);
					htb.put("tinh_id", String.valueOf(tinh_id));
					
					
				}
			
				
			}
			
			//conn.close();
			st.close();
			rs.close();
			
			if (retTypeIsJSON){
				ArrayList<Object> lst = new ArrayList<Object>();
				JSONObject json = new JSONObject();
				lst.add(htb);
				json.put("rows", lst);
			   return json.toJSONString();
			} else {
				return htb;
			}

		} catch (SQLException e) {
		try {
		
			st.close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		e.printStackTrace();
		return null;
	 } catch (Exception e) {
		e.printStackTrace();
		return null;
	 }
	}
	@SuppressWarnings({ "deprecation", "unused" })
	protected void processRequest(DBOperation dbo, HttpServletRequest request, HttpServletResponse response){
		try {
			String codeREQ = request.getParameter("action");
			System.out.println("Report servlet action =" +codeREQ);
			switch(Integer.parseInt(codeREQ))
			{
				case Definitions.ACT_RENDER_MAP_CCGL: genMapServerMapFile_CCGL(dbo, request, response);break;
				case Definitions.ACT_RENDER_MAP_HTL: genMapServerMapFile_HTL(dbo, request, response);break;
				case Definitions.ACT_RENDER_MAP_DICHHAI: genMapServerMapFile_DH(dbo, request, response);break;
				case Definitions.ACT_RENDER_MAP_THIENTAI: genMapServerMapFile_TT(dbo, request, response);break;
				case Definitions.ACT_RENDER_MAP_NANGSUAT: genMapServerMapFile_NS(dbo, request, response);break;
				case Definitions.ACT_RENDER_MAP_NUOC: genMapServerMapFile_Nuoc(dbo, request, response);break;
				case Definitions.ACT_RENDER_MAP_VIENTHAM: genMapServerMapFile_Vientham(dbo, request, response);break;
				case Definitions.ACT_RENDER_MAP_DUBAO: genMapServerMapFile_DuBao(dbo, request, response);break;

				default:break;
			}
		//	writeResponse.println("Create Report is Done !");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static String getURLWithContextPath(HttpServletRequest request)
	{
	   return request.getScheme() + "://" + request.getServerName() + ":"+ request.getServerPort() + request.getContextPath();
	}
	public void genMapServerMapFile_CCGL(DBOperation dbo, HttpServletRequest request, HttpServletResponse response){
		
		String retData = "";
		try {
			ServletConfig config = getServletConfig(); 
			String confFile = config.getServletContext().getRealPath(request.getServletPath())+"/../dbscl.conf";
			
				 
			if (Config.loadFile(confFile) == null){
				System.err.println("Can not load dbscl.conf!");
			}
			
			System.err.println(Config.getParamConfig("mapserver_path"));
			String path_to_file = Config.getParamConfig("mapserver_path");
			String mapFile = createMapFileCCGL(path_to_file, dbo, request, response);

			retData = mapFile;
			response.getWriter().print(retData);
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void genMapServerMapFile_HTL(DBOperation dbo, HttpServletRequest request, HttpServletResponse response){
		
		String retData = "";
		try {
			ServletConfig config = getServletConfig(); 
			String confFile = config.getServletContext().getRealPath(request.getServletPath())+"/../dbscl.conf";
			//Config configure = new Config();
				 
			if (Config.loadFile(confFile) == null){
				System.err.println("Can not load dbscl.conf!");
			}
			
			System.err.println(Config.getParamConfig("mapserver_path"));
			String path_to_file = Config.getParamConfig("mapserver_path");
			String mapFile = createMapFileHTL(path_to_file, dbo, request, response);
			retData = mapFile;
			response.getWriter().print(retData);
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void genMapServerMapFile_DH(DBOperation dbo, HttpServletRequest request, HttpServletResponse response){
		
		String retData = "";
		try {
			ServletConfig config = getServletConfig(); 
			String confFile = config.getServletContext().getRealPath(request.getServletPath())+"/../dbscl.conf";
			//Config configure = new Config();
				 
			if (Config.loadFile(confFile) == null){
				System.err.println("Can not load dbscl.conf!");
			}
			
			System.err.println(Config.getParamConfig("mapserver_path"));
			String path_to_file = Config.getParamConfig("mapserver_path");
			String mapFile = createMapFileDichhai(path_to_file, dbo, request, response);

			retData = mapFile;
			response.getWriter().print(retData);
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}	
	public void genMapServerMapFile_TT(DBOperation dbo, HttpServletRequest request, HttpServletResponse response){
		
		String retData = "";
		try {
			ServletConfig config = getServletConfig(); 
			String confFile = config.getServletContext().getRealPath(request.getServletPath())+"/../dbscl.conf";
			//Config configure = new Config();
				 
			if (Config.loadFile(confFile) == null){
				System.err.println("Can not load dbscl.conf!");
			}
			
			System.err.println(Config.getParamConfig("mapserver_path"));
			String path_to_file = Config.getParamConfig("mapserver_path");
			String mapFile = createMapFileThientai(path_to_file, dbo, request, response);

			retData = mapFile;
			response.getWriter().print(retData);
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}		
	public void genMapServerMapFile_NS(DBOperation dbo, HttpServletRequest request, HttpServletResponse response){
		
		String retData = "";
		try {
			ServletConfig config = getServletConfig(); 
			String confFile = config.getServletContext().getRealPath(request.getServletPath())+"/../dbscl.conf";
			//Config configure = new Config();
				 
			if (Config.loadFile(confFile) == null){
				System.err.println("Can not load dbscl.conf!");
			}	
			System.err.println(Config.getParamConfig("mapserver_path"));
			String path_to_file = Config.getParamConfig("mapserver_path");
			String mapFile = createMapFileNangsuat(path_to_file, dbo, request, response);

			retData = mapFile;
			response.getWriter().print(retData);
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void genMapServerMapFile_Nuoc(DBOperation dbo, HttpServletRequest request, HttpServletResponse response){
		
		String retData = "";
		try {
			ServletConfig config = getServletConfig(); 
			String confFile = config.getServletContext().getRealPath(request.getServletPath())+"/../dbscl.conf";
			//Config configure = new Config();
				 
			if (Config.loadFile(confFile) == null){
				System.err.println("Can not load dbscl.conf!");
			}	
			System.err.println(Config.getParamConfig("mapserver_path"));
			String path_to_file = Config.getParamConfig("mapserver_path");
			String mapFile = createMapFileNguonNuoc(path_to_file, dbo, request, response);

			retData = mapFile;
			response.getWriter().print(retData);
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void genMapServerMapFile_Vientham(DBOperation dbo, HttpServletRequest request, HttpServletResponse response){
		
		String retData = "";
		try {
			ServletConfig config = getServletConfig(); 
			String confFile = config.getServletContext().getRealPath(request.getServletPath())+"/../dbscl.conf";
			//Config configure = new Config();
				 
			if (Config.loadFile(confFile) == null){
				System.err.println("Can not load dbscl.conf!");
			}	
			System.err.println(Config.getParamConfig("mapserver_path"));
			String path_to_file = Config.getParamConfig("mapserver_path");
			String mapFile = createMapFileVientham(path_to_file, dbo, request, response);

			retData = mapFile;
			response.getWriter().print(retData);
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void genMapServerMapFile_DuBao(DBOperation dbo, HttpServletRequest request, HttpServletResponse response){
		
		String retData = "";
		try {
			ServletConfig config = getServletConfig(); 
			String confFile = config.getServletContext().getRealPath(request.getServletPath())+"/../dbscl.conf";
			//Config configure = new Config();
				 
			if (Config.loadFile(confFile) == null){
				System.err.println("Can not load dbscl.conf!");
			}	
			System.err.println(Config.getParamConfig("mapserver_path"));
			String path_to_file = Config.getParamConfig("mapserver_path");
			String mapFile = createMapFileDuBao(path_to_file, dbo, request, response);

			retData = mapFile;
			response.getWriter().print(retData);
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public String createMapFileCCGL(String path_to_file, DBOperation dbo, HttpServletRequest request, HttpServletResponse response){
		
		 HttpSession session = request.getSession();
		 String sessionID = session.getId();
		Connection conn = dbo.getConnection();
		String retData = "";
		String time1 = request.getParameter("time_int1");
		String time2 = request.getParameter("time_int2");
		String vuluaid = request.getParameter("vuluaid");
		System.out.println("time: "+time1+"-"+time2);
		//String vulua =  Utils.getVuluaByTime(time);
		
		String posWKT = request.getParameter("position");
		String tableName = request.getParameter("table");
		String idName = request.getParameter("id");
		Hashtable<String ,String > htb = (Hashtable<String ,String >)getInfoOfArea(dbo, posWKT, tableName, idName, /*retTypeIsJSON*/ false);
		String condition = "1=1";
		String uid_file = "";
		if (!htb.get(TblXa.XA_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblXa.XA_ID);
			condition = "tbl_ruong_region.xa_id= " + htb.get(TblXa.XA_ID);
			
		} else if (!htb.get(TblHuyen.HUYEN_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblHuyen.HUYEN_ID);
			condition = "tbl_ruong_region.huyen_id= " + htb.get(TblHuyen.HUYEN_ID);
		} else if (!htb.get(TblTinh.TINH_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblTinh.TINH_ID);
			condition = "tbl_ruong_region.tinh_id= " + htb.get(TblTinh.TINH_ID);
		}
		System.out.println("condition ="+condition);
		String mapFile = "hientrang_ccgl_" + uid_file + "_" +sessionID+ ".map";
		String filename = path_to_file + Utils.FILE_SEPARATOR + mapFile;
		try {
			
			/**List giống lúa và tạo color tương ứng-> save to map file*/
			String sql=
					" select TBL_TMP_RUONG.lua_ten,TBL_TMP_RUONG.ttgc_gionglua_id_mp  ,  SUM(TBL_TMP_RUONG.dien_tich) as dien_tich"+
					" from  (select SUM(TBL_ID_RUONG.shape_area) AS dien_tich,        "+
				    "          tbl_lua.lua_ten,        "+
				    "          tbl_ttgc_ruong_mp.ttgc_gionglua_id_mp,     "+   
				    "         tbl_ttgc_ruong_mp.ttgc_ngaygieocay_mp as ngaybatdau "+       
				    "    from tbl_ttgc_ruong_mp        "+
				    "    inner join tbl_lua on tbl_ttgc_ruong_mp.ttgc_gionglua_id_mp=tbl_lua.lua_id    "+    
				    "    inner join"+      
				    "              (select tbl_ruong_region.ruong_id, tbl_ruong_region.shape_area"+
				    "               from tbl_ruong_region where "+ condition +") as TBL_ID_RUONG   "+     
				    "    on tbl_ttgc_ruong_mp.ttgc_ruong_id_mp =TBL_ID_RUONG.ruong_id   "+     
				    "    where tbl_ttgc_ruong_mp.ttgc_ngaygieocay_mp >="+ time1 + " AND " +  "tbl_ttgc_ruong_mp.ttgc_ngaygieocay_mp <="+time2+ " AND ttgc_vulua_mp="+vuluaid+    
				    "    GROUP BY  tbl_lua.lua_ten, tbl_ttgc_ruong_mp.ttgc_gionglua_id_mp, tbl_ttgc_ruong_mp.ttgc_ngaygieocay_mp ) AS TBL_TMP_RUONG "+ 
				    "      group by TBL_TMP_RUONG.lua_ten,TBL_TMP_RUONG.ttgc_gionglua_id_mp having count(*)>=1 "+
				    "  ORDER BY dien_tich DESC";

					
			/*" select TBL_TMP_RUONG.lua_ten,TBL_TMP_RUONG.ttgc_gionglua_id_mp "+
			" from "+
			" (select TBL_ID_RUONG.ruong_id, "+
			"       tbl_lua.lua_ten, "+
			"       tbl_ttgc_ruong_mp.ttgc_gionglua_id_mp, "+
			"       tbl_ttgc_ruong_mp.ttgc_ngaygieocay_mp as ngaybatdau "+
			"       from tbl_ttgc_ruong_mp "+
			"       inner join tbl_lua on tbl_ttgc_ruong_mp.ttgc_gionglua_id_mp=tbl_lua.lua_id "+
			"       inner join "+
			"       (select tbl_ruong_region.ruong_id from tbl_ruong_region where "+ condition +") as TBL_ID_RUONG "+
			"       on tbl_ttgc_ruong_mp.ttgc_ruong_id_mp =TBL_ID_RUONG.ruong_id "+
			"       where  tbl_ttgc_ruong_mp.ttgc_ngaygieocay_mp <="+time+
			"       ) AS TBL_TMP_RUONG "+ //"       and tbl_ttgc_ruong_tmp.ttgc_vulua = '"+vulua+"') AS TBL_TMP_RUONG "+
			"group by TBL_TMP_RUONG.lua_ten,TBL_TMP_RUONG.ttgc_gionglua_id_mp having count(*)>=1";
			*/System.out.println("sql_1 ="+sql);
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			
			
			
            ArrayList<String> expressions =  new  ArrayList<String>();
            Hashtable<Object,Object> mapco = new  Hashtable<Object,Object>();
            
            ArrayList<Color> lstColorsDefault =  new  ArrayList<Color>();
          

            lstColorsDefault.add(Utils.Hex2RGB("#00ff00"));//0-255-0
           lstColorsDefault.add(Utils.Hex2RGB("#ffff00"));//255-255-0
            lstColorsDefault.add(Utils.Hex2RGB("#00ffff"));//0-255-255
            lstColorsDefault.add(Utils.Hex2RGB("#ff00ff"));//255-0-255
            lstColorsDefault.add(Utils.Hex2RGB("#0000ff"));//0-0-255
            lstColorsDefault.add(Utils.Hex2RGB("#800000"));//128-0-0
            lstColorsDefault.add(Utils.Hex2RGB("#0080ff"));//0-128-255
            lstColorsDefault.add(Utils.Hex2RGB("#ff8040"));//255-128-40
            lstColorsDefault.add(Utils.Hex2RGB("#400080"));//64-00-128
           /* lstColorsDefault.add(Utils.Hex2RGB("#A04040"));//160-64-64
            
            lstColorsDefault.add(Utils.Hex2RGB("#C04000"));//192-64-0
            lstColorsDefault.add(Utils.Hex2RGB("#C00020"));//192-0-32
            */
            lstColorsDefault.add(Utils.Hex2RGB("#20C040"));//32-192-64
            lstColorsDefault.add(Utils.Hex2RGB("#2040C0"));//32-64-192
            lstColorsDefault.add(Utils.Hex2RGB("#a240a2"));//162-64-162
            
          //  lstColorsDefault.add(Utils.Hex2RGB("#C040C0"));//other
            
            
            
            int i=0;
            ArrayList lstColorSegments =  new  ArrayList();
            String lstGLIDs="0,";
            int nGL=0;
			while (rs.next()){
				nGL++;
				String lua_ten = rs.getString("lua_ten");
				if(lua_ten.equalsIgnoreCase("Giống khác"))
					continue;
				
				int lua_id = rs.getInt("ttgc_gionglua_id_mp");
				lstGLIDs+=(lua_id+",");
				String expression = "[ttgc_gionglua_id_mp] eq "+ lua_id;
				Color c = lstColorsDefault.get(i);

				lstColorSegments.add(new ColorItem(lua_ten,c));
				String expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
			    expressions.add(expclass);
		 
			  i++;
			  if (i ==lstColorsDefault.size()) break;
			}
			rs.close();
			st.close();
			if (lstGLIDs.endsWith(","))
				lstGLIDs=lstGLIDs.substring(0, lstGLIDs.length()-1);
			
			if (i < nGL){
			String expression_others="!([ttgc_gionglua_id_mp] IN \""+lstGLIDs+"\")";
			Color colorOther =new Color(128,128,128);
			lstColorSegments.add(new ColorItem("Giống khác",colorOther));
			String expclass = MapFileTemplate.genStyleExpressionClass(expression_others, null, colorOther, new Color(0,0,0));
		    expressions.add(expclass);
			}
			
			/* tìm được list ruộng và giống lúa tương ứng với điều kiện ngày bắt đầu gieo cấy < ngay yêu cầu lập bản đồ hiện trạng => ruong_id, lua_ten, ngaybatdau*/
			sql =
			" select TBL_TMP_RUONG.gid,TBL_TMP_RUONG.the_geom,TBL_TMP_RUONG.ruong_id,TBL_TMP_RUONG.ttgc_gionglua_id_mp, TBL_TMP_RUONG.lua_ten "+
			" from "+ 
			
			" (select TBL_ID_RUONG.ruong_id,"+
			"       TBL_ID_RUONG.gid,"+
			"       TBL_ID_RUONG.the_geom,"+
			"       tbl_lua.lua_ten,"+
			"       tbl_ttgc_ruong_mp.ttgc_gionglua_id_mp,"+
			"       tbl_ttgc_ruong_mp.ttgc_ngaygieocay_mp as ngaybatdau "+
			"       FROM tbl_ttgc_ruong_mp "+
			"       INNER JOIN tbl_lua on tbl_ttgc_ruong_mp.ttgc_gionglua_id_mp=tbl_lua.lua_id "+
			"       INNER JOIN "+
			"       (SELECT tbl_ruong_region.ruong_id,tbl_ruong_region.gid,tbl_ruong_region.the_geom from tbl_ruong_region where "+ condition +") as TBL_ID_RUONG "+
			"       ON tbl_ttgc_ruong_mp.ttgc_ruong_id_mp =TBL_ID_RUONG.ruong_id "+
		    "    where tbl_ttgc_ruong_mp.ttgc_ngaygieocay_mp >="+ time1 + " AND " +  "tbl_ttgc_ruong_mp.ttgc_ngaygieocay_mp <="+time2+  " AND ttgc_vulua_mp="+vuluaid+       
			//"       AND tbl_ttgc_ruong_tmp.ttgc_vulua = '"+vulua+"' ) AS TBL_TMP_RUONG "+
			"       ) AS TBL_TMP_RUONG "+
			" GROUP BY TBL_TMP_RUONG.ruong_id,TBL_TMP_RUONG.ttgc_gionglua_id_mp, TBL_TMP_RUONG.lua_ten,TBL_TMP_RUONG.gid,TBL_TMP_RUONG.the_geom ";	
			System.out.println("sql_1 ="+sql);
			String data = "\"the_geom from " + "(" +sql + ") AS " + "tbl_ccgl_" + uid_file + "  USING UNIQUE gid USING SRID=4756"+"\"";
			MapFileTemplate.createMapFile(filename, data, expressions);
			
			/**Send data back to client mapfile+div_color*/
			String divHtml = MapFileTemplate.createDivChugiaiHientrang(230,550, new Color(255,255,255), new Color(255,255,255), lstColorSegments,30,15,"");
			JSONObject json = new JSONObject();
			ArrayList<Object> lst = new ArrayList<Object>();
			Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
			htbl.put("map_file", mapFile);
			htbl.put("div", divHtml);
			lst.add(htbl);
			json.put("data", lst);

			return json.toJSONString();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	
	public String createMapFileHTL(String path_to_file, DBOperation dbo, HttpServletRequest request, HttpServletResponse response){
		
		HttpSession session = request.getSession();
		String sessionID = session.getId();
		Connection conn = dbo.getConnection();
		String retData = "";
		String time_int1 = request.getParameter("time_int1");
		String time_int2 = request.getParameter("time_int2");
		String time = request.getParameter("time");
		String vulua =  Utils.getVuluaByTime(time);
		
		String posWKT = request.getParameter("position");
		String tableName = request.getParameter("table");
		String idName = request.getParameter("id");
		Hashtable<String ,String > htb = (Hashtable<String ,String >)getInfoOfArea(dbo, posWKT, tableName, idName, /*retTypeIsJSON*/ false);
		String condition = "1=1";
		String uid_file = "";
		if (!htb.get(TblXa.XA_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblXa.XA_ID);
			condition = "tbl_ruong_region.xa_id= " + htb.get(TblXa.XA_ID);
			
		} else if (!htb.get(TblHuyen.HUYEN_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblHuyen.HUYEN_ID);
			condition = "tbl_ruong_region.huyen_id= " + htb.get(TblHuyen.HUYEN_ID);
		} else if (!htb.get(TblTinh.TINH_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblTinh.TINH_ID);
			condition = "tbl_ruong_region.tinh_id= " + htb.get(TblTinh.TINH_ID);
		}
		System.out.println("condition ="+condition);
		String mapFile = "hientrang_htl_" + uid_file + "_" +sessionID+ ".map";
		String filename = path_to_file + Utils.FILE_SEPARATOR + mapFile;
		try {
			
			/**List giống lúa và tạo color tương ứng-> save to map file*/
			String sql;
			/*String sql=
					
			"		 SELECT   " +
		    "           TBL_RUONG_HIENTRANG.rht_hientrang_id_mp,"+
		    "           TBL_RUONG_HIENTRANG.hientrang_ten "+
		    "   FROM "+
		    "         (select tbl_ruong_hientrang_mp.rht_hientrang_id_mp,"+
		    "                max(tbl_ruong_hientrang_mp.rht_ngaydieutra_mp) as ngaydieutra,"+
		    "                tbl_hientrang.hientrang_ten,"+
		    "                TBL_RUONG_TMP.ruong_id,"+
		    "                TBL_RUONG_TMP.the_geom"+
		    "         from tbl_ruong_hientrang_mp "+
		    "         inner join tbl_hientrang on tbl_ruong_hientrang_mp.rht_hientrang_id_mp=tbl_hientrang.hientrang_id "+
		    "         inner join "+
		    "                      (select tbl_ruong_region.ruong_id,tbl_ruong_region.the_geom from tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP "+
		    "          on tbl_ruong_hientrang_mp.rht_ruong_id_mp=TBL_RUONG_TMP.ruong_id "+
		    "          WHERE       tbl_ruong_hientrang_mp.rht_ngaydieutra_mp >= "+time_int1+ 
		    "          AND       tbl_ruong_hientrang_mp.rht_ngaydieutra_mp <= "+time_int2+
		    "        group by  tbl_ruong_hientrang_mp.rht_hientrang_id_mp,tbl_hientrang.hientrang_ten, TBL_RUONG_TMP.ruong_id,TBL_RUONG_TMP.the_geom) as TBL_RUONG_HIENTRANG "+
		    " GROUP BY TBL_RUONG_HIENTRANG.rht_hientrang_id_mp, TBL_RUONG_HIENTRANG.hientrang_ten HAVING count(*)>=1";
			
			System.out.println("sql="+sql);
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			
			
			
            ArrayList<String> expressions =  new  ArrayList<String>();
            Hashtable<Object,Object> mapco = new  Hashtable<Object,Object>();
			while (rs.next()) {
				String hientrang_ten = rs.getString("hientrang_ten");
				int hientrang_id = rs.getInt("rht_hientrang_id_mp");
				String expression = "[rht_hientrang_id_mp] eq "+ hientrang_id;
				Random r = new Random();
				Color c = Color.getHSBColor(r.nextFloat(),//random hue, color
				                1.0f,//full saturation, 1.0 for 'colorful' colors, 0.0 for grey
				                1.0f //1.0 for bright, 0.0 for black
				                );
				mapco.put(hientrang_ten, c);
				String expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));

				expressions.add(expclass);
			}
			rs.close();*/
			/*
			 * 	    $('#color_htl_rattot').css({background:"rgb(40, 196, 153)"});
	    $('#color_htl_tot').css({background:"rgb(45, 196, 40)"});
	    $('#color_htl_kha').css({background:"rgb(157, 196, 40)"});
	    $('#color_htl_tb').css({background:"rgb(194, 160, 41)"});
	    $('#color_htl_yeu').css({background:"rgb(194, 81, 43)"});
	    $('#color_htl_kem').css({background:"rgb(200, 20, 20)"});
			 */
		            ArrayList<String> expressions =  new  ArrayList<String>();
		            //Hashtable<Object,Object> mapco = new  Hashtable<Object,Object>();
		            ArrayList lstColorSegments =  new  ArrayList();
					
						String hientrang_ten = "Tốt";Color c = new Color(45, 196, 40);
						String expression = "[rht_hientrang_id_mp] eq "+ 1;
						
						lstColorSegments.add(new ColorItem(hientrang_ten,c));
						String expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
					    expressions.add(expclass);
					    
						hientrang_ten = "Khá";	c = new Color(157, 196, 40);
						expression = "[rht_hientrang_id_mp] eq "+ 2;
						lstColorSegments.add(new ColorItem(hientrang_ten,c));
						expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
					    expressions.add(expclass);
					    
						hientrang_ten = "Trung bình";	c = new Color(194, 160, 41);
						expression = "[rht_hientrang_id_mp] eq "+ 3;
						lstColorSegments.add(new ColorItem(hientrang_ten,c));
						expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
					    expressions.add(expclass);
					    
						hientrang_ten = "Kém";c = new Color(194, 81, 4);	
						expression = "[rht_hientrang_id_mp] eq "+ 4;
						lstColorSegments.add(new ColorItem(hientrang_ten,c));
						expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
					    expressions.add(expclass);
					    
						hientrang_ten = "Mất trắng";c = new Color(128,128,128);	
						expression = "[rht_hientrang_id_mp] eq "+ 5;
						lstColorSegments.add(new ColorItem(hientrang_ten,c));
						expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
					    expressions.add(expclass);
					
			/* tìm được list ruộng và giống lúa tương ứng với điều kiện ngày bắt đầu gieo cấy < ngay yêu cầu lập bản đồ hiện trạng => ruong_id, lua_ten, ngaybatdau*/
			sql =
					     /*   " SELECT   " +
						    "                tbl_ruong_hientrang_mp.rht_hientrang_id_mp,"+
						    "                max(tbl_ruong_hientrang_mp.rht_ngaydieutra_mp) as ngaydieutra,"+
						    "                tbl_hientrang.hientrang_ten,"+
						    "                TBL_RUONG_TMP.ruong_id,"+
						    "                TBL_RUONG_TMP.the_geom,"+
						    "                TBL_RUONG_TMP.gid"+
						    "         from tbl_ruong_hientrang_mp "+
						    "         inner join tbl_hientrang on tbl_ruong_hientrang_mp.rht_hientrang_id_mp=tbl_hientrang.hientrang_id "+
						    "         inner join "+
						    "                      (select tbl_ruong_region.ruong_id,tbl_ruong_region.gid ,tbl_ruong_region.the_geom from tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP "+
						    "          on tbl_ruong_hientrang_mp.rht_ruong_id_mp=TBL_RUONG_TMP.ruong_id "+
						    "          WHERE       tbl_ruong_hientrang_mp.rht_ngaydieutra_mp >= "+time_int1+ 
						    "          AND       tbl_ruong_hientrang_mp.rht_ngaydieutra_mp <= "+time_int2+ 
						    "        group by  tbl_ruong_hientrang_mp.rht_hientrang_id_mp,tbl_hientrang.hientrang_ten, TBL_RUONG_TMP.ruong_id,TBL_RUONG_TMP.the_geom,TBL_RUONG_TMP.gid";
						 */
					 " SELECT       "+           
					 " tbl_ruong_hientrang_mp.rht_hientrang_id_mp,  "+              
					 " TBL_DATE_RUONG_TMP.ngaydieutra as ngaydieutra, "+              
					 " tbl_hientrang.hientrang_ten, "+               
					 " TBL_DATE_RUONG_TMP.ruong_id,   "+             
					 " TBL_DATE_RUONG_TMP.the_geom,   "+             
					 " TBL_DATE_RUONG_TMP.gid       "+ 
					 " FROM tbl_ruong_hientrang_mp  "+
					 " INNER JOIN tbl_hientrang ON tbl_hientrang.hientrang_id = tbl_ruong_hientrang_mp.rht_hientrang_id_mp "+
					 " INNER JOIN "+
				     " ( SELECT MAX(tbl_ruong_hientrang_mp.rht_ngaydieutra_mp) AS ngaydieutra, "+
					 "       TBL_RUONG_TMP.ruong_id,"+
					 "       TBL_RUONG_TMP.gid, "+
					 "       TBL_RUONG_TMP.the_geom "+
					 " FROM tbl_ruong_hientrang_mp  "+
					 " INNER JOIN           "+            
					 "         (select tbl_ruong_region.ruong_id,tbl_ruong_region.gid ,tbl_ruong_region.the_geom  "+
					 "          from tbl_ruong_region "+
					 "          where "+ condition +")as TBL_RUONG_TMP       "+   
					 "  ON tbl_ruong_hientrang_mp.rht_ruong_id_mp=TBL_RUONG_TMP.ruong_id"+  
					 "  WHERE       tbl_ruong_hientrang_mp.rht_ngaydieutra_mp >= "+time_int1+          
					 " AND       tbl_ruong_hientrang_mp.rht_ngaydieutra_mp <= "+time_int2+ 
					 " GROUP BY    TBL_RUONG_TMP.ruong_id,TBL_RUONG_TMP.gid, TBL_RUONG_TMP.the_geom ) AS TBL_DATE_RUONG_TMP"+
					 " ON TBL_DATE_RUONG_TMP.ruong_id = tbl_ruong_hientrang_mp.rht_ruong_id_mp"+
					 " WHERE tbl_ruong_hientrang_mp.rht_ngaydieutra_mp = TBL_DATE_RUONG_TMP.ngaydieutra";
						   System.out.println("sql_hientranglua"+ sql);
		    String data = "\"the_geom from " + "(" +sql + ") AS " + "tbl_htl_" + uid_file + "  USING UNIQUE gid USING SRID=4756"+"\"";
			MapFileTemplate.createMapFile(filename, data, expressions);
			/**Send data back to client mapfile+div_color*/
			String divHtml = MapFileTemplate.createDivChugiaiHientrang(230,550, new Color(255,255,255), new Color(255,255,255), lstColorSegments);
			JSONObject json = new JSONObject();
			ArrayList<Object> lst = new ArrayList<Object>();
			Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
			htbl.put("map_file", mapFile);
			htbl.put("div", divHtml);
			lst.add(htbl);
			json.put("data", lst);

			return json.toJSONString();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
	
	public String createMapFileDichhai(String path_to_file, DBOperation dbo, HttpServletRequest request, HttpServletResponse response){
		 HttpSession session = request.getSession();
		 String sessionID = session.getId();
		Connection conn = dbo.getConnection();
		String retData = "";
		String time = request.getParameter("time");
		String vulua =  Utils.getVuluaByTime(time);
		
		String posWKT = request.getParameter("position");
		String tableName = request.getParameter("table");
		String idName = request.getParameter("id");
		int sau_id = Integer.parseInt(request.getParameter("sau_id"));
		int benh_id = Integer.parseInt(request.getParameter("benh_id"));
		//System.out.println("sau_id:"+request.getParameter("sau_id"));
		//System.out.println("benh_id:"+request.getParameter("benh_id"));
		
		Hashtable<String ,String > htb = (Hashtable<String ,String >)getInfoOfArea(dbo, posWKT, tableName, idName, /*retTypeIsJSON*/ false);
		String condition = "1=1";
		String uid_file = "";
		if (!htb.get(TblXa.XA_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblXa.XA_ID);
			condition = "tbl_ruong_region.xa_id= " + htb.get(TblXa.XA_ID);
			
		} else if (!htb.get(TblHuyen.HUYEN_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblHuyen.HUYEN_ID);
			condition = "tbl_ruong_region.huyen_id= " + htb.get(TblHuyen.HUYEN_ID);
		} else if (!htb.get(TblTinh.TINH_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblTinh.TINH_ID);
			condition = "tbl_ruong_region.tinh_id= " + htb.get(TblTinh.TINH_ID);
		}
		System.out.println("condition ="+condition);
		String mapFile = "hientrang_dh_" + uid_file + "_" +sessionID+ ".map";
		String filename = path_to_file + Utils.FILE_SEPARATOR + mapFile;
		try {
			
			/**List giống lúa và tạo color tương ứng-> save to map file*/
			String sql="";
			/*		
		   "    SELECT   " +
		   "            TBL_RUONG_DICHHAI.rdtn_mucdonhiem_mp " +
		   "    FROM " +
		   "          (select tbl_ruong_dientichnhiem_mp.rdtn_mucdonhiem_mp, " +
		   "                 max(tbl_ruong_dientichnhiem_mp.rdtn_ngaydieutra_mp) as ngaydieutra, " +
		   "                  TBL_RUONG_TMP.ruong_id, " +
		   "                 TBL_RUONG_TMP.the_geom " +
		   "          from tbl_ruong_dientichnhiem_mp " +
		   "          inner join " +           
		   "                              ( select tbl_ruong_region.ruong_id,tbl_ruong_region.the_geom from tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP " +
		   "           on tbl_ruong_dientichnhiem_mp.rdtn_ruong_id_mp=TBL_RUONG_TMP.ruong_id " +
		   "           where tbl_ruong_dientichnhiem_mp.rdtn_ngaydieutra_mp<= "+time+
		         ((sau_id == -1||benh_id == -1)?"":(" AND " + (sau_id != 0?(" tbl_ruong_dientichnhiem_mp.rdtn_sauhai_id_mp="+sau_id+" AND tbl_ruong_dientichnhiem_mp.rdtn_benhhai_id_mp=0"):(" tbl_ruong_dientichnhiem_mp.rdtn_sauhai_id_mp=0 and tbl_ruong_dientichnhiem_mp.rdtn_benhhai_id_mp="+benh_id)))) +		  
		   //"                           and tbl_ttgc_ruong_tmp.ttgc_vulua='"+vulua+"'"+
		   "           group by TBL_RUONG_TMP.ruong_id,TBL_RUONG_TMP.the_geom,tbl_ruong_dientichnhiem_mp.rdtn_mucdonhiem_mp ) as TBL_RUONG_DICHHAI " +		
		   "  GROUP BY     TBL_RUONG_DICHHAI.rdtn_mucdonhiem_mp HAVING count(*)>=1	 ";		
		 
			System.out.println("sQL = " +sql);
		   Statement st = conn.createStatement();
		   ResultSet rs = st.executeQuery(sql);
			*/
			
			
            /*ArrayList<String> expressions =  new  ArrayList<String>();
            Hashtable<Object,Object> mapco = new  Hashtable<Object,Object>();
			while (rs.next()) {
				
				int mucdonhiem_id = rs.getInt("rdtn_mucdonhiem_mp");
				String mucdonhiem_ten = "";
				if (mucdonhiem_id == 0){
					mucdonhiem_ten = "Tiền nhiễm";
				}
				if (mucdonhiem_id == 1){
					mucdonhiem_ten = "Nhiễm nhẹ";
				}
				if (mucdonhiem_id == 2){
					mucdonhiem_ten = "Nhiễm trung bình";
				}
				if (mucdonhiem_id == 3){
					mucdonhiem_ten = "Nhiễm nặng";
				}
				if (mucdonhiem_id == 4){
					mucdonhiem_ten = "Mất trắng";
				}
				if (mucdonhiem_id == 5){
					mucdonhiem_ten = "Nhiễm (đã phòng trừ)";
				}
				String expression = "[rdtn_mucdonhiem_mp] eq "+ mucdonhiem_id;
				Random r = new Random();
				Color c = Color.getHSBColor(r.nextFloat(),//random hue, color
				                1.0f,//full saturation, 1.0 for 'colorful' colors, 0.0 for grey
				                1.0f //1.0 for bright, 0.0 for black
				                );
				mapco.put(mucdonhiem_ten, c);
				String expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
                System.out.println("CSS color:"+ c.toString());
                System.out.println("MAPFILE color:"+ expclass);
				expressions.add(expclass);
			}*/
		   
           ArrayList<String> expressions =  new  ArrayList<String>();
           //Hashtable<Object,Object> mapco = new  Hashtable<Object,Object>();
           ArrayList lstColorSegments =  new  ArrayList();
           String expclass ;
			
				String hientrang_ten = "Tiền nhiễm";Color c = new Color(45, 196, 40);
				String expression = "[rdtn_mucdonhiem_mp] eq "+ 0;
				
				lstColorSegments.add(new ColorItem(hientrang_ten,c));
				expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
			    expressions.add(expclass);
			    
				hientrang_ten = "Nhiễm nhẹ";	c = new Color(157, 196, 40);
				expression = "[rdtn_mucdonhiem_mp] eq "+ 1;
				lstColorSegments.add(new ColorItem(hientrang_ten,c));
				expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
			    expressions.add(expclass);
			    
				hientrang_ten = "Nhiễm trung bình";	c = new Color(194, 160, 41);
				expression = "[rdtn_mucdonhiem_mp] eq "+ 2;
				lstColorSegments.add(new ColorItem(hientrang_ten,c));
				expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
			    expressions.add(expclass);
			    
				hientrang_ten = "Nhiễm nặng";c = new Color(194, 81, 4);	
				expression = "[rdtn_mucdonhiem_mp] eq "+ 3;
				lstColorSegments.add(new ColorItem(hientrang_ten,c));
				expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
			    expressions.add(expclass);
			    
				hientrang_ten = "Mất trắng";c = new Color(128,128,128);	
				expression = "[rdtn_mucdonhiem_mp] eq "+ 4;
				lstColorSegments.add(new ColorItem(hientrang_ten,c));
				expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
			    expressions.add(expclass);
			    
				hientrang_ten = "Nhiễm (đã phòng trừ)";c = new Color(0,0,200);	
				expression = "[rdtn_mucdonhiem_mp] eq "+ 5;
				lstColorSegments.add(new ColorItem(hientrang_ten,c));
				expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
			    expressions.add(expclass);
			
			
			/* tìm được list ruộng và giống lúa tương ứng với điều kiện ngày bắt đầu gieo cấy < ngay yêu cầu lập bản đồ hiện trạng => ruong_id, lua_ten, ngaybatdau*/
		    sql =
					
							   "  select tbl_ruong_dientichnhiem_mp.rdtn_mucdonhiem_mp, " +
							   "     max(tbl_ruong_dientichnhiem_mp.rdtn_ngaydieutra_mp) as ngaydieutra, " +
							   "     TBL_RUONG_TMP.ruong_id, " +
							   "     TBL_RUONG_TMP.the_geom, " +
							   "     TBL_RUONG_TMP.gid " +
							   "      from tbl_ruong_dientichnhiem_mp " +
							   "        inner join " +           
							   "                 ( select tbl_ruong_region.ruong_id,tbl_ruong_region.gid,tbl_ruong_region.the_geom from tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP " +
							   "         on tbl_ruong_dientichnhiem_mp.rdtn_ruong_id_mp=TBL_RUONG_TMP.ruong_id " +
							   "         where " +
							   //"tbl_ruong_dientichnhiem_mp.rdtn_ngaydieutra_mp= "+
							   " tbl_ruong_dientichnhiem_mp.rdtn_ngaydieutra_mp <="+ time+
							   " AND tbl_ruong_dientichnhiem_mp.rdtn_ngaydieutra_mp >="+ (Integer.parseInt(time)-7)+
							  
							 /*" (SELECT max(tbl_ruong_dientichnhiem_mp.rdtn_ngaydieutra_mp) as max_ngaydieutra "+
							   " FROM tbl_ruong_dientichnhiem_mp "+
							   " WHERE tbl_ruong_dientichnhiem_mp.rdtn_ruong_id_mp IN (SELECT ruong_id FROM tbl_ruong_region WHERE "+condition+")"+
							   " AND tbl_ruong_dientichnhiem_mp.rdtn_ngaydieutra_mp <="+ time+
							   " AND tbl_ruong_dientichnhiem_mp.rdtn_ngaydieutra_mp >="+ (Integer.parseInt(time)-7) +")"+*/							  							   
							         ((sau_id == -1||benh_id == -1)?"":(" AND " + (sau_id > 0?("tbl_ruong_dientichnhiem_mp.rdtn_sauhai_id_mp="+sau_id+" AND tbl_ruong_dientichnhiem_mp.rdtn_benhhai_id_mp=0"):("tbl_ruong_dientichnhiem_mp.rdtn_sauhai_id_mp=0 and tbl_ruong_dientichnhiem_mp.rdtn_benhhai_id_mp="+benh_id)))) +		  
							   //"                           and tbl_ttgc_ruong_tmp.ttgc_vulua='"+vulua+"'"+
							   "           group by TBL_RUONG_TMP.gid, TBL_RUONG_TMP.gid,TBL_RUONG_TMP.ruong_id,TBL_RUONG_TMP.the_geom,tbl_ruong_dientichnhiem_mp.rdtn_mucdonhiem_mp";		
								
		    System.out.println("sql="+sql);
		    String data = "\"the_geom from " + "(" +sql + ") AS " + "tbl_dh_" + uid_file + "  USING UNIQUE gid USING SRID=4756"+"\"";
			MapFileTemplate.createMapFile(filename, data, expressions);
			/**Send data back to client mapfile+div_color*/
			String divHtml = MapFileTemplate.createDivChugiaiHientrang(230,550, new Color(255,255,255), new Color(255,255,255), lstColorSegments);
			JSONObject json = new JSONObject();
			ArrayList<Object> lst = new ArrayList<Object>();
			Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
			htbl.put("map_file", mapFile);
			htbl.put("div", divHtml);
			lst.add(htbl);
			json.put("data", lst);

			return json.toJSONString();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
	public String createMapFileThientai(String path_to_file, DBOperation dbo, HttpServletRequest request, HttpServletResponse response){
		 HttpSession session = request.getSession();
		 String sessionID = session.getId();
		Connection conn = dbo.getConnection();
		String retData = "";
	//	String dot = request.getParameter("dot");
		String time = request.getParameter("time");
		int dot =  Integer.parseInt(request.getParameter("dot"));
		System.out.println("dot" + dot);
		int option = Integer.parseInt(request.getParameter("option"));
		
		String vulua =  Utils.getVuluaByTime(time);
		
		String posWKT = request.getParameter("position");
		String tableName = request.getParameter("table");
		String idName = request.getParameter("id");

		//System.out.println("sau_id:"+request.getParameter("sau_id"));
		int  thientai_id = Integer.parseInt(request.getParameter("thientai_id"));
		//System.out.println("benh_id:"+request.getParameter("benh_id"));
		
		Hashtable<String ,String > htb = (Hashtable<String ,String >)getInfoOfArea(dbo, posWKT, tableName, idName, /*retTypeIsJSON*/ false);
		String condition = "1=1";
		/*tbl_ruong_thientai_mp.rtt_ngaydieutra_mp<= "+time+
 ((thientai_id == -1?"":("AND tbl_ruong_thientai_mp.rtt_thientai_id_mp=" + thientai_id))) + */
		 String condition_tt = null;
         if (option == Definitions.RENDER_TTTT_OPTION_DOT){
        	 condition_tt = " tbl_ruong_thientai_mp.rtt_dot_mp ="+ dot+
        	 ((thientai_id == -1?"":(" AND tbl_ruong_thientai_mp.rtt_thientai_id_mp=" + thientai_id))) ;
         } else if (option == Definitions.RENDER_TTTT_OPTION_NGAY){
        	 condition_tt =  "tbl_ruong_thientai_mp.rtt_ngaydieutra_mp = " +time+
        			 ((thientai_id == -1?"":(" AND tbl_ruong_thientai_mp.rtt_thientai_id_mp=" + thientai_id))) ;
  	          
         } 
         
		String uid_file = "";
		if (!htb.get(TblXa.XA_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblXa.XA_ID);
			condition = "tbl_ruong_region.xa_id= " + htb.get(TblXa.XA_ID);
			
		} else if (!htb.get(TblHuyen.HUYEN_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblHuyen.HUYEN_ID);
			condition = "tbl_ruong_region.huyen_id= " + htb.get(TblHuyen.HUYEN_ID);
		} else if (!htb.get(TblTinh.TINH_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblTinh.TINH_ID);
			condition = "tbl_ruong_region.tinh_id= " + htb.get(TblTinh.TINH_ID);
		}
		System.out.println("condition ="+condition);
		String mapFile = "hientrang_tt_" + uid_file + "_" +sessionID+ ".map";
		String filename = path_to_file + Utils.FILE_SEPARATOR + mapFile;
		try {
			
			/**List giống lúa và tạo color tương ứng-> save to map file*/
			String sql=
					
					
    " SELECT "+  
    "        TBL_RUONG_THIENTAI.capdo_ten,"+
    "        TBL_RUONG_THIENTAI.rtt_mucdo_id_mp "+
    " FROM   "+
    "        (SELECT  tbl_ruong_thientai_mp.rtt_mucdo_id_mp,"+
    "                 tbl_capdo_thientai.capdo_ten,"+
    "                 max(tbl_ruong_thientai_mp.rtt_ngaydieutra_mp) as ngaydieutra, "+
    "                 TBL_RUONG_TMP.ruong_id"+
    "         FROM tbl_ruong_thientai_mp "+
    "         INNER JOIN tbl_capdo_thientai on tbl_ruong_thientai_mp.rtt_mucdo_id_mp=tbl_capdo_thientai.capdo_id"+
    "         INNER JOIN "+
    "                   (select tbl_ruong_region.ruong_id FROM tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP"+ 
    "                    on tbl_ruong_thientai_mp.rtt_ruong_id_mp=TBL_RUONG_TMP.ruong_id	"+	    
  
    "                      WHERE " +condition_tt+

    "         GROUP BY  tbl_ruong_thientai_mp.rtt_mucdo_id_mp, tbl_capdo_thientai.capdo_ten,TBL_RUONG_TMP.ruong_id) as TBL_RUONG_THIENTAI "+
    "  GROUP BY TBL_RUONG_THIENTAI.rtt_mucdo_id_mp, TBL_RUONG_THIENTAI.capdo_ten HAVING count(*) >=1";

		 
			System.out.println("sQL_reder_thientai = " +sql);
		   Statement st = conn.createStatement();
		   ResultSet rs = st.executeQuery(sql);
			
			
			
            ArrayList<String> expressions =  new  ArrayList<String>();
            Hashtable<Object,Object> mapco = new  Hashtable<Object,Object>();
			while (rs.next()) {
				String capdo_ten = rs.getString("capdo_ten");
				int mucdo_id = rs.getInt("rtt_mucdo_id_mp");
				String expression = "[rtt_mucdo_id_mp] eq "+ mucdo_id;
				Random r = new Random();
				Color c = Color.getHSBColor(r.nextFloat(),//random hue, color
				                1.0f,//full saturation, 1.0 for 'colorful' colors, 0.0 for grey
				                1.0f //1.0 for bright, 0.0 for black
				                );
				mapco.put(capdo_ten, c);
				String expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));

				expressions.add(expclass);
			}
			rs.close();
			st.close();
			/* tìm được list ruộng và giống lúa tương ứng với điều kiện ngày bắt đầu gieo cấy < ngay yêu cầu lập bản đồ hiện trạng => ruong_id, lua_ten, ngaybatdau*/
		/*CREATE TABLE tbl_ruong_thientai_mp
(
  rtt_thientai_id_mp integer,
  rtt_ngaydieutra_mp integer,
  rtt_gdst_id_mp integer,
  rtt_ruong_id_mp integer,
  rtt_mucdo_id_mp integer,
  rtt_vulua_mp integer,
  rtt_id_mp bigserial NOT NULL, */
			sql =
					"		 SELECT " +
				    "    tbl_ruong_thientai_mp.rtt_mucdo_id_mp, " +
	                "      	   tbl_capdo_thientai.capdo_ten,  " +
               	    "      max(tbl_ruong_thientai_mp.rtt_ngaydieutra_mp) as ngaydieutra,  " +
       	            "      TBL_RUONG_TMP.ruong_id,  " +
	                "      TBL_RUONG_TMP.gid,  " +
	                "      TBL_RUONG_TMP.the_geom " +
	                " FROM tbl_ruong_thientai_mp  " +
	                " INNER JOIN tbl_capdo_thientai on tbl_ruong_thientai_mp.rtt_mucdo_id_mp=tbl_capdo_thientai.capdo_id " +
	                " INNER JOIN " +
	                "         (SELECT tbl_ruong_region.ruong_id,tbl_ruong_region.gid,tbl_ruong_region.the_geom from tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP " +
	                "   ON tbl_ruong_thientai_mp.rtt_ruong_id_mp=TBL_RUONG_TMP.ruong_id  " +
	                "                      WHERE " +condition_tt+	            
                    "   GROUP BY tbl_ruong_thientai_mp.rtt_mucdo_id_mp, tbl_capdo_thientai.capdo_ten,TBL_RUONG_TMP.ruong_id,TBL_RUONG_TMP.gid,TBL_RUONG_TMP.the_geom " ;
	    
			System.out.println("sQL_reder_thientai1 = " +sql);
		    String data = "\"the_geom from " + "(" +sql + ") AS " + "tbl_tt_" + uid_file + "  USING UNIQUE gid USING SRID=4756"+"\"";
			MapFileTemplate.createMapFile(filename, data, expressions);
			/**Send data back to client mapfile+div_color*/
			String divHtml = MapFileTemplate.createDivChugiaiHientrang(230,550, new Color(255,255,255), new Color(255,255,255), mapco);
			JSONObject json = new JSONObject();
			ArrayList<Object> lst = new ArrayList<Object>();
			Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
			htbl.put("map_file", mapFile);
			htbl.put("div", divHtml);
			lst.add(htbl);
			json.put("data", lst);

			return json.toJSONString();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
public String createMapFileNangsuat(String path_to_file, DBOperation dbo, HttpServletRequest request, HttpServletResponse response){		
		
	 HttpSession session = request.getSession();
	 String sessionID = session.getId();
	Connection conn = dbo.getConnection();
		String retData = "";
		String time = request.getParameter("time");
		String vulua =  Utils.getVuluaByTime(time);		
		String posWKT = request.getParameter("position");
		String tableName = request.getParameter("table");
		String idName = request.getParameter("id");
		Hashtable<String ,String > htb = (Hashtable<String ,String >)getInfoOfArea(dbo, posWKT, tableName, idName, /*retTypeIsJSON*/ false);
		String condition = "1=1";
		String uid_file = "";
		if (!htb.get(TblXa.XA_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblXa.XA_ID);
			condition = "tbl_ruong_region.xa_id= " + htb.get(TblXa.XA_ID);			
		} else if (!htb.get(TblHuyen.HUYEN_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblHuyen.HUYEN_ID);
			condition = "tbl_ruong_region.huyen_id= " + htb.get(TblHuyen.HUYEN_ID);
		} else if (!htb.get(TblTinh.TINH_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblTinh.TINH_ID);
			condition = "tbl_ruong_region.tinh_id= " + htb.get(TblTinh.TINH_ID);
		}
		System.out.println("condition ="+condition);
		String mapFile = "hientrang_ns_" + uid_file + "_" +sessionID+ ".map";
		String filename = path_to_file + Utils.FILE_SEPARATOR + mapFile;
		try {			
			/**List giống lúa và tạo color tương ứng-> save to map file*/
			String sql=
					" SELECT" +					
		            "    RUONG_NANGSUAT_TMP.rns_nangsuat_mp " +
		            " FROM " +
		            "    (SELECT tbl_ruong_nangsuat_mp.rns_nangsuat_mp, " +
		            "            max(tbl_ruong_nangsuat_mp.rns_ngaydieutra_mp) as ngaydieutra, " +
		            "           TBL_RUONG_TMP.ruong_id, " +
		            "            TBL_RUONG_TMP.the_geom" +
		            "     FROM tbl_ruong_nangsuat_mp " +
		            "     INNER JOIN 		" +                       
		            "               (SELECT tbl_ruong_region.ruong_id,tbl_ruong_region.the_geom FROM tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP" +
		            "     ON tbl_ruong_nangsuat_mp.rns_ruong_id_mp=TBL_RUONG_TMP.ruong_id 	" +                       
		            "     WHERE        tbl_ruong_nangsuat_mp.rns_ngaydieutra_mp <="+time+
                    "     GROUP BY  tbl_ruong_nangsuat_mp.rns_nangsuat_mp, TBL_RUONG_TMP.ruong_id,TBL_RUONG_TMP.the_geom  )AS RUONG_NANGSUAT_TMP" +
		            "  GROUP BY RUONG_NANGSUAT_TMP.rns_nangsuat_mp HAVING count(*)>=1	" ;
		    System.out.println("sql_hientrang_ns"+sql);
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);			
            ArrayList<String> expressions =  new  ArrayList<String>();
            ArrayList lstColorSegments =  new  ArrayList();
            float max=0;
            float min=1000000;
            int n=3;
			while (rs.next()) {
				
				float rns_nangsuat = rs.getFloat("rns_nangsuat_mp");
				if (rns_nangsuat > 15) continue;
				if(rns_nangsuat<min)
				{
					min=rns_nangsuat;
				}
				if(rns_nangsuat>max){
					max=rns_nangsuat;
				}
			}
			rs.close();
			st.close();
			if (min==1000000){
				n=0;
			}
			
			ArrayList arrayColors=new ArrayList();
			arrayColors.add(Utils.Hex2RGB("#00ff00"));//0-255-0
			arrayColors.add(Utils.Hex2RGB("#ffff00"));//255-255-0
			arrayColors.add(Utils.Hex2RGB("#00ffff"));//0-255-255
			arrayColors.add(Utils.Hex2RGB("#ff00ff"));//255-0-255
			arrayColors.add(Utils.Hex2RGB("#0000ff"));//0-0-255
			
			arrayColors.add(Utils.Hex2RGB("#800000"));//128-0-0
			arrayColors.add(Utils.Hex2RGB("#0080ff"));//0-128-255
			arrayColors.add(Utils.Hex2RGB("#ff8040"));//255-128-40
			arrayColors.add(Utils.Hex2RGB("#400080"));//64-00-128
			arrayColors.add(Utils.Hex2RGB("#A04040"));//160-64-64

			{
				max+=1.0f;
				min-=1.0f;
				float nangsuat_tb=(max-min)/n;
				for (int i=1;i<=n;i++){
					float a = min + (i-1)*nangsuat_tb;
					float b = a + nangsuat_tb;
					DecimalFormat df = new DecimalFormat("#.##");
					
				String expression = "([rns_nangsuat_mp] > "+ df.format(a) + ") AND ([rns_nangsuat_mp] <" +df.format(b) +")";
				Random r = new Random();
				Color c = (Color)arrayColors.get(i-1);
				System.out.println(String.valueOf(df.format(a))+ " - " + String.valueOf(df.format(b)) + " (tấn/ha)");
				ColorItem colorItem = new ColorItem();
				colorItem.name =String.valueOf(df.format(a))+ " - " + String.valueOf(df.format(b)) + " (tấn/ha)";
				colorItem.color = c;
				lstColorSegments.add(colorItem);
				String expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
				expressions.add(expclass);
				}
			}
			System.out.println("min ="+min);
			System.out.println("max ="+max);
			/* tìm được list ruộng và giống lúa tương ứng với điều kiện ngày bắt đầu gieo cấy < ngay yêu cầu lập bản đồ hiện trạng => ruong_id, lua_ten, ngaybatdau*/
			sql =
					
				"	 SELECT tbl_ruong_nangsuat_mp.rns_nangsuat_mp, " +
	            "           max(tbl_ruong_nangsuat_mp.rns_ngaydieutra_mp) as ngaydieutra, " +
	            "           TBL_RUONG_TMP.ruong_id, " +
	            "           TBL_RUONG_TMP.the_geom," +
                "           TBL_RUONG_TMP.gid" +
	            "   FROM tbl_ruong_nangsuat_mp " +
	            "   INNER JOIN 		   " +                    
	            "              (SELECT tbl_ruong_region.ruong_id,tbl_ruong_region.gid, tbl_ruong_region.the_geom FROM tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP" +
	            "   ON tbl_ruong_nangsuat_mp.rns_ruong_id_mp=TBL_RUONG_TMP.ruong_id 	" +                       
	            "   WHERE        tbl_ruong_nangsuat_mp.rns_ngaydieutra_mp <= "+time+
                "   GROUP BY  TBL_RUONG_TMP.gid, tbl_ruong_nangsuat_mp.rns_nangsuat_mp, TBL_RUONG_TMP.ruong_id,TBL_RUONG_TMP.the_geom  " ;
			 System.out.println("sql_hientrang_ns"+sql);
	
           String data = "\"the_geom from " + "(" +sql + ") AS " + "tbl_ns_" + uid_file + "  USING UNIQUE gid USING SRID=4756"+"\"";
			MapFileTemplate.createMapFile(filename, data, expressions);
			/**Send data back to client mapfile+div_color*/
			String divHtml = MapFileTemplate.createDivChugiaiHientrang(230,550, new Color(255,255,255), new Color(255,255,255), lstColorSegments);
			JSONObject json = new JSONObject();
			ArrayList<Object> lst = new ArrayList<Object>();
			Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
			htbl.put("map_file", mapFile);
			htbl.put("div", divHtml);
			lst.add(htbl);
			json.put("data", lst);

			return json.toJSONString();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
/*[BEGIN] render nguồn nước : Nước trời; Nước tưới; Thủy triều*/
public String createMapFileNguonNuoc(String path_to_file, DBOperation dbo, HttpServletRequest request, HttpServletResponse response){		
	Connection conn = dbo.getConnection();
	 HttpSession session = request.getSession();
	 String sessionID = session.getId();
	String retData = "";
	String time = request.getParameter("time");
	String vulua =  Utils.getVuluaByTime(time);		
	String posWKT = request.getParameter("position");
	String tableName = request.getParameter("table");
	String idName = request.getParameter("id");
	Hashtable<String ,String > htb = (Hashtable<String ,String >)getInfoOfArea(dbo, posWKT, tableName, idName, /*retTypeIsJSON*/ false);
	String condition = "1=1";
	String uid_file = "";
	if (!htb.get(TblXa.XA_ID).equalsIgnoreCase("-1")){
		uid_file = htb.get(TblXa.XA_ID);
		condition = "tbl_ruong_region.xa_id= " + htb.get(TblXa.XA_ID);			
	} else if (!htb.get(TblHuyen.HUYEN_ID).equalsIgnoreCase("-1")){
		uid_file = htb.get(TblHuyen.HUYEN_ID);
		condition = "tbl_ruong_region.huyen_id= " + htb.get(TblHuyen.HUYEN_ID);
	} else if (!htb.get(TblTinh.TINH_ID).equalsIgnoreCase("-1")){
		uid_file = htb.get(TblTinh.TINH_ID);
		condition = "tbl_ruong_region.tinh_id= " + htb.get(TblTinh.TINH_ID);
	}
	System.out.println("condition ="+condition);
	String mapFile = "hientrang_nuoc_" + "_" +sessionID+ ".map";
	String filename = path_to_file + Utils.FILE_SEPARATOR + mapFile;
	try {			
		/**List giống lúa và tạo color tương ứng-> save to map file*/
		String sql=
		
	    " SELECT ruong_nuoc  FROM tbl_ruong_region where "+ condition +
	  "  GROUP BY ruong_nuoc  HAVING count(*)>=1	" ;
	
        Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery(sql);		
		
		System.out.println( " sql="+ sql);
        
        ArrayList<String> expressions =  new  ArrayList<String>();
        //Hashtable<Object,Object> mapco = new  Hashtable<Object,Object>();
        ArrayList lstColorSegments =  new  ArrayList();
		
			String ruongnuoc_ten = "Nước tưới";Color c = new Color(22, 62, 255);
			String expression = "[ruong_nuoc] eq "+ 0;
			
			lstColorSegments.add(new ColorItem(ruongnuoc_ten,c));
			String expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
		    expressions.add(expclass);
		    
		    ruongnuoc_ten = "Nước trời";	c = new Color(22, 242, 254);
			expression = "[ruong_nuoc] eq "+ 1;
			lstColorSegments.add(new ColorItem(ruongnuoc_ten,c));
			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
		    expressions.add(expclass);
		    
		    ruongnuoc_ten = "Nước thủy triều";	c = new Color(52, 224, 90);
			expression = "[ruong_nuoc] eq "+ 2;
			lstColorSegments.add(new ColorItem(ruongnuoc_ten,c));
			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
		    expressions.add(expclass);
		    

		    
       /* int i=0;
		while (rs.next()) {
			i++;
			System.out.println(i);
			int ruongnuoc_id = rs.getInt("ruong_nuoc");
			String expression = "[ruong_nuoc] eq "+ ruongnuoc_id;
			System.out.println("expression="+expression);
			Random r = new Random();
			Color c = Color.getHSBColor(r.nextFloat(),//random hue, color
			                1.0f,//full saturation, 1.0 for 'colorful' colors, 0.0 for grey
			                1.0f //1.0 for bright, 0.0 for black
			                );
			String ruongnuoc_ten ="Chưa xác định";
			if (ruongnuoc_id == 0)ruongnuoc_ten= "Nước tưới";
			if (ruongnuoc_id == 1)ruongnuoc_ten= "Nước trời";
			if (ruongnuoc_id == 2)ruongnuoc_ten= "Nước thủy triều";
			
			mapco.put(ruongnuoc_ten, c);
			
			String expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
			expressions.add(expclass);
		}*/

		/* tìm được list ruộng và nguồn nước tương ứng với điều kiện ngày bắt đầu gieo cấy < ngay yêu cầu lập bản đồ hiện trạng => ruong_id, lua_ten, ngaybatdau*/
		sql =
			"	 SELECT        tbl_ruong_region.ruong_id, " +
			"	               tbl_ruong_region.the_geom, " +
			"	               tbl_ruong_region.gid, " +
			"	               tbl_ruong_region.ruong_nuoc " +
			"	FROM tbl_ruong_region where "+ condition ;
			           
	    String data = "\"the_geom from " + "(" +sql + ") AS " + "tbl_nguonnuoc_" + uid_file + "  USING UNIQUE gid USING SRID=4756"+"\"";
		MapFileTemplate.createMapFile(filename, data, expressions);
		/**Send data back to client mapfile+div_color*/
		String divHtml = MapFileTemplate.createDivChugiaiHientrang(230,550, new Color(255,255,255), new Color(255,255,255), lstColorSegments);
		JSONObject json = new JSONObject();
		ArrayList<Object> lst = new ArrayList<Object>();
		Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
		htbl.put("map_file", mapFile);
		htbl.put("div", divHtml);
		lst.add(htbl);
		json.put("data", lst);

		return json.toJSONString();
		
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return "";
}
private String createMapFileVientham_NDVI(String path_to_file, DBOperation dbo, HttpServletRequest request, HttpServletResponse response){		
	
	 HttpSession session = request.getSession();
	 String sessionID = session.getId();
	 Connection conn = dbo.getConnection();
		String retData = "";

		String posWKT = request.getParameter("position");
		String tableName = request.getParameter("table");
		String idName = request.getParameter("id");
		String strYear = request.getParameter("year");
		String strDayOfYear = request.getParameter("doy");
		int mapType = Integer.parseInt(request.getParameter("opts_map_type"));
		int vulua = Integer.parseInt(request.getParameter("vulua"));
		String lanhtho_id = "-1";
		
		
		System.out.println("[IN]: year ="+strYear+", day_of_year:"+strDayOfYear);
		
		Hashtable<String ,String > htb = (Hashtable<String ,String >)getInfoOfArea(dbo, posWKT, tableName, idName, /*retTypeIsJSON*/ false);
		String condition = "1=1";
		String uid_file = "";
		if (!htb.get(TblXa.XA_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblXa.XA_ID);
			condition = "tbl_ruong_region.xa_id= " + htb.get(TblXa.XA_ID);	
			lanhtho_id = htb.get(TblXa.XA_ID);
		} else if (!htb.get(TblHuyen.HUYEN_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblHuyen.HUYEN_ID);
			condition = "tbl_ruong_region.huyen_id= " + htb.get(TblHuyen.HUYEN_ID);
			lanhtho_id = htb.get(TblHuyen.HUYEN_ID);
		} else if (!htb.get(TblTinh.TINH_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblTinh.TINH_ID);
			condition = "tbl_ruong_region.tinh_id= " + htb.get(TblTinh.TINH_ID);
			lanhtho_id = htb.get(TblTinh.TINH_ID);
		}
		System.out.println("condition ="+condition);
		String mapFile = "vientham_ndvi_" + uid_file + "_" +sessionID+ ".map";
		String filename = path_to_file + Utils.FILE_SEPARATOR + mapFile;
		try {			
			
			String tableVienthamName = "tbl_ndvi_ruonglua_" + htb.get(TblTinh.TINH_ID);
			String sql= " select * from "+ tableVienthamName + " where 1 = 0 ";
		    System.out.println("sql_vientham:"+sql);
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);	
			ResultSetMetaData rsmd = rs.getMetaData();
			ArrayList<Integer> lstTimes = new ArrayList<Integer>();
			for (int i = 1 ; i < rsmd.getColumnCount()+1; i++){
				String colName = rsmd.getColumnName(i);
				if (colName.startsWith("n20")){ //assume that start with n20xxyyy
					String sYear = colName.substring(1, 5);
					String sDayOfYear = colName.substring(5, 8);
					//System.out.println("sYear = "+ sYear +", sDayOfYear:" +sDayOfYear);
					
					if (sYear.equalsIgnoreCase(strYear)){
						lstTimes.add(Integer.parseInt(sDayOfYear));
					}
				}
				
				
			}
			//System.out.println(""+);
			String columnNameRequired = null;
			String strDayOfYearFound = "";
			if (lstTimes.size() > 0){
				Integer intDayOfYear = Integer.parseInt(strDayOfYear);
				lstTimes.add(intDayOfYear);
				//sort tang dan
				Collections.sort(lstTimes);
				for (int i = lstTimes.size()-1; i > 0; i--){
					if (lstTimes.get(i) == intDayOfYear){
						if ((i-1) >= 0){
							Integer doyFound = lstTimes.get(i-1);
							System.out.println("doyFound="+doyFound);
							strDayOfYearFound = "" +doyFound;
							if (doyFound < 100 && doyFound > 9) {
								strDayOfYearFound = "0" + doyFound;
							} else if (doyFound < 10 && doyFound >= 0) {
								strDayOfYearFound = "00" + doyFound;
							} 
							columnNameRequired = "n" + strYear + strDayOfYearFound;
						} else {//Thoi gian chọn ko nằm trong khoảng thời gian giải đoán ảnh
							System.out.println("Thoi gian chọn ko nằm trong khoảng thời gian giải đoán ảnh");
							return null;
						}
					}
				}
				
			} else {//Thoi gian chọn ko nằm trong khoảng thời gian giải đoán ảnh
				System.out.println("Thoi gian chọn ko nằm trong khoảng thời gian giải đoán ảnh. lstTimes.size = 0");
				return null;
			}
			
			rs.close();
			st.close();
			//Tinh tong dien tich ruong co ndvi > 0 
			String dtSQL;
			dtSQL = " SELECT SUM(shape_area) as dien_tich FROM " +tableVienthamName+
					" INNER JOIN tbl_ruong_region ON "+tableVienthamName+".ruong_id = tbl_ruong_region.ruong_id "+
					" WHERE "+columnNameRequired+" > 0 AND "+ condition;
			st = conn.createStatement();
			rs = st.executeQuery(dtSQL);
			float dientich = 0.0f;
			while(rs.next())
			{
				dientich = rs.getFloat("dien_tich")/10000;
			}
			DecimalFormat df0 = new DecimalFormat("#.##");
			String info_dientich = "<b> Diện tích trồng lúa: "+df0.format(dientich)+ " ha</b>";
			rs.close();
			
			
			
			//Tinh dd/MM/yyyy cua ngay chup
			int intNgayChup = (Utils.convertDateStringToInt("01/01/"+strYear) + Integer.parseInt(strDayOfYearFound));
			Date dateNgayChup = Utils.convertInt2Date(intNgayChup);
			String strDateNgayChup = Utils.convertInt2DateString(intNgayChup);
			Calendar cal = Calendar.getInstance();
			cal.setTime(dateNgayChup);
			int d = cal.get(Calendar.DAY_OF_MONTH);
			int m = cal.get(Calendar.MONTH)+1;
			int y = cal.get(Calendar.YEAR);
			if(Integer.parseInt(strYear) != y){
				System.err.println("warning!? year[client send]"+ strYear +" not equal year[extract from ngaychup]" + y);
			}
			System.out.println("Ngay chup: "+strDateNgayChup +", "+d +"/"+m+"/"+y);
			//Tinh tong dien tich lua trong vu
			DecimalFormat _df = new DecimalFormat("#.##");
			float tongdt_vu = 0.0f;
			String strTongDTVu = "0.0";
			try{
				rs = st.executeQuery("SELECT tongdientichluatrongvu as tongdt FROM tongdientichluatrongvu("+vulua+","+y+","+lanhtho_id+")");	
				while(rs.next()){
					 tongdt_vu = rs.getFloat("tongdt");
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
			strTongDTVu = _df.format(tongdt_vu);
			
			st.close();
			
			
			
			 System.out.println("columnNameRequired:"+columnNameRequired);
           ArrayList<String> expressions =  new  ArrayList<String>();
           ArrayList lstColorSegments =  new  ArrayList();
           float max=1;
           float min=0;
           int n=5;
		  if (min==1000000){
				n=0;
			}
			
			//ArrayList arrayColors=new ArrayList();
		
			float hue = 0.313725f; //hue
			float saturation = 0.941176f; //saturation
			float lumination= 0.941176f; //lumination
			//1.0 <-> ndvi min
			

			{
				//max+=0.01f;
				//min-=0.01f;
				float ndvi_tb=(max-min)/n;
				for (int i=1;i<=n;i++){
					float a = min + (i-1)*ndvi_tb;
					float b = a + ndvi_tb;
					DecimalFormat df = new DecimalFormat("#.##");
					
				String expression = "(["+columnNameRequired+"] >= "+ df.format(a) + ") AND (["+columnNameRequired+"] <" +df.format(b) +")";
				Color c = Utils.HSL2RGB(hue, saturation, lumination);
				lumination-= (1.0f/n);
				
				System.out.println(String.valueOf(df.format(a))+ " - " + String.valueOf(df.format(b)) + " ");
				ColorItem colorItem = new ColorItem();
				colorItem.name =String.valueOf(df.format(a))+ " - " + String.valueOf(df.format(b)) + " ";
				colorItem.color = c;
				lstColorSegments.add(colorItem);
				String expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderNDVI);
				expressions.add(expclass);
				}
			}
			System.out.println("min ="+min);
			System.out.println("max ="+max);
			/* tìm được list ruộng và giống lúa tương ứng với điều kiện ngày bắt đầu gieo cấy < ngay yêu cầu lập bản đồ hiện trạng => ruong_id, lua_ten, ngaybatdau*/
			sql =
					
				"	 SELECT " +tableVienthamName+"."+columnNameRequired+", " +
	            "           TBL_RUONG_TMP.ruong_id, " +
	            "           TBL_RUONG_TMP.the_geom," +
               "           TBL_RUONG_TMP.gid" +
	            "   FROM " + tableVienthamName +
	            "   INNER JOIN 		   " +                    
	            "              (SELECT tbl_ruong_region.ruong_id,tbl_ruong_region.gid, tbl_ruong_region.the_geom FROM tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP" +
	            "   ON "+tableVienthamName+".ruong_id=TBL_RUONG_TMP.ruong_id 	" +                       
	            "   GROUP BY  TBL_RUONG_TMP.gid, "+tableVienthamName+"."+columnNameRequired+", TBL_RUONG_TMP.ruong_id,TBL_RUONG_TMP.the_geom  " ;
			 System.out.println("sql_vientham_ndvi:"+sql);
	
            String data = "\"the_geom from " + "(" +sql + ") AS " + "tbl_vt_" + uid_file + "  USING UNIQUE gid USING SRID=4756"+"\"";
			MapFileTemplate.createMapFile(filename, data, expressions);
			/**Send data back to client mapfile+div_color*/
			String divHtml = MapFileTemplate.createDivChugiaiHientrangWithNote(230,550, new Color(255,255,255), new Color(255,255,255), lstColorSegments,info_dientich);
			JSONObject json = new JSONObject();
			ArrayList<Object> lst = new ArrayList<Object>();
			Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
			htbl.put("map_file", mapFile);
			htbl.put("div", divHtml);
			System.out.println("strDayOfYearFound========"+strDayOfYearFound);
			htbl.put("real_doy", Integer.parseInt(strDayOfYearFound));
			htbl.put("dt_by_gdst", "");
			htbl.put("dt_vulua", strTongDTVu);

			
			lst.add(htbl);
			json.put("data", lst);
			
			String out =  json.toJSONString();
			System.out.println("OUTPUT: "+out);
			return out;
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
private String createMapFileVientham_GDST(String path_to_file, DBOperation dbo, HttpServletRequest request, HttpServletResponse response){		
	
	 HttpSession session = request.getSession();
	 String sessionID = session.getId();
	 Connection conn = dbo.getConnection();
		String retData = "";

		String posWKT = request.getParameter("position");
		String tableName = request.getParameter("table");
		String idName = request.getParameter("id");
		String strYear = request.getParameter("year");
		String strDayOfYear = request.getParameter("doy");
		int mapType = Integer.parseInt(request.getParameter("opts_map_type"));
		int vulua = Integer.parseInt(request.getParameter("vulua"));
		String lanhtho_id = "-1";
		
		
		System.out.println("[IN]: year ="+strYear+", day_of_year:"+strDayOfYear);
		
		Hashtable<String ,String > htb = (Hashtable<String ,String >)getInfoOfArea(dbo, posWKT, tableName, idName, /*retTypeIsJSON*/ false);
		String condition = "1=1";
		String uid_file = "";
		if (!htb.get(TblXa.XA_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblXa.XA_ID);
			condition = "tbl_ruong_region.xa_id= " + htb.get(TblXa.XA_ID);	
			lanhtho_id = htb.get(TblXa.XA_ID);
		} else if (!htb.get(TblHuyen.HUYEN_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblHuyen.HUYEN_ID);
			condition = "tbl_ruong_region.huyen_id= " + htb.get(TblHuyen.HUYEN_ID);
			lanhtho_id = htb.get(TblHuyen.HUYEN_ID);
		} else if (!htb.get(TblTinh.TINH_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblTinh.TINH_ID);
			condition = "tbl_ruong_region.tinh_id= " + htb.get(TblTinh.TINH_ID);
			lanhtho_id = htb.get(TblTinh.TINH_ID);
		}
		System.out.println("condition ="+condition);
		String mapFile = "vientham_gdst_" + uid_file + "_" +sessionID+ ".map";
		String filename = path_to_file + Utils.FILE_SEPARATOR + mapFile;
		try {			
			
			String tableVienthamName = "tbl_ndvi_ruonglua_" + htb.get(TblTinh.TINH_ID);
			String sql= " select * from "+ tableVienthamName + " where 1 = 0 ";
		    System.out.println("sql_vientham:"+sql);
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);	
			ResultSetMetaData rsmd = rs.getMetaData();
			ArrayList<Integer> lstTimes = new ArrayList<Integer>();
			for (int i = 1 ; i < rsmd.getColumnCount()+1; i++){
				String colName = rsmd.getColumnName(i);
				if (colName.startsWith("n20")){ //assume that start with n20xxyyy
					String sYear = colName.substring(1, 5);
					String sDayOfYear = colName.substring(5, 8);
					//System.out.println("sYear = "+ sYear +", sDayOfYear:" +sDayOfYear);
					
					if (sYear.equalsIgnoreCase(strYear)){
						lstTimes.add(Integer.parseInt(sDayOfYear));
					}
				}
				
				
			}
			//System.out.println(""+);
			String columnNameRequired = null;
			String strDayOfYearFound = "";
			if (lstTimes.size() > 0){
				Integer intDayOfYear = Integer.parseInt(strDayOfYear);
				lstTimes.add(intDayOfYear);
				//sort tang dan
				Collections.sort(lstTimes);
				for (int i = lstTimes.size()-1; i > 0; i--){
					if (lstTimes.get(i) == intDayOfYear){
						if ((i-1) >= 0){
							Integer doyFound = lstTimes.get(i-1);
							System.out.println("doyFound="+doyFound);
							strDayOfYearFound = "" +doyFound;
							if (doyFound < 100 && doyFound > 9) {
								strDayOfYearFound = "0" + doyFound;
							} else if (doyFound < 10 && doyFound >= 0) {
								strDayOfYearFound = "00" + doyFound;
							} 
							columnNameRequired = "n" + strYear + strDayOfYearFound;
						} else {//Thoi gian chọn ko nằm trong khoảng thời gian giải đoán ảnh
							System.out.println("Thoi gian chọn ko nằm trong khoảng thời gian giải đoán ảnh");
							return "";
						}
					}
				}
				
			} else {//Thoi gian chọn ko nằm trong khoảng thời gian giải đoán ảnh
				System.out.println("Thoi gian chọn ko nằm trong khoảng thời gian giải đoán ảnh. lstTimes.size = 0");
				return "";
			}
			rs.close();
			//st.close();
			
			//Tinh dd/MM/yyyy cua ngay chup
			int intNgayChup = (Utils.convertDateStringToInt("01/01/"+strYear) + Integer.parseInt(strDayOfYearFound));
			Date dateNgayChup = Utils.convertInt2Date(intNgayChup);
			String strDateNgayChup = Utils.convertInt2DateString(intNgayChup);
			Calendar cal = Calendar.getInstance();
			cal.setTime(dateNgayChup);
			int d = cal.get(Calendar.DAY_OF_MONTH);
			int m = cal.get(Calendar.MONTH)+1;
			int y = cal.get(Calendar.YEAR);
			if(Integer.parseInt(strYear) != y){
				System.err.println("warning!? year[client send]"+ strYear +" not equal year[extract from ngaychup]" + y);
			}
			System.out.println("Ngay chup: "+strDateNgayChup +", "+d +"/"+m+"/"+y);
			
				
		    System.out.println("columnNameRequired:"+columnNameRequired);
            ArrayList<String> expressions =  new  ArrayList<String>();
    		
   			String ruongnuoc_ten = "Mạ";Color c = new Color(177, 255, 177);
   			String expression = "[gdst] eq "+ 1;
   			String expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
   		    expressions.add(expclass);
   		    
   		    ruongnuoc_ten = "Đẻ nhánh";	c = new Color(118, 205, 118);
   			expression = "[gdst] eq "+ 2;
   			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
   		    expressions.add(expclass);
   		    
   		    ruongnuoc_ten = "Làm đòng";	c = new Color(59, 155, 59);
   			expression = "[gdst] eq "+ 3;
   			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
   		    expressions.add(expclass);
   		    
   		    ruongnuoc_ten = "Trổ";	c = new Color(0,104,0);
   			expression = "[gdst] eq "+ 4;
   			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
   		    expressions.add(expclass);
   		    
   		    ruongnuoc_ten = "Ngậm sữa";	c = new Color(189, 255,0);
   			expression = "[gdst] eq "+ 5;
   			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
   		    expressions.add(expclass);
   		    
   		    ruongnuoc_ten = "Chín";	c = new Color(255,255,0);
   			expression = "[gdst] eq "+ 6;
   			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
   		    expressions.add(expclass);
   		    
 	
			/*Tinh dien tich theo gdst */
			String sql_dt =
					
					"	SELECT table1.f2 as gdst, SUM(TBL_RUONG_TMP.shape_area) as dien_tich"+ 
		            "   FROM giaidoansinhtruonglua("+d+", "+m+", "+y+","+ lanhtho_id+") AS table1" +
		            "   INNER JOIN 	(SELECT tbl_ruong_region.ruong_id,tbl_ruong_region.shape_area FROM tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP" +
		            "   ON table1.f1=TBL_RUONG_TMP.ruong_id 	" +  
		            "   WHERE table1.f2 > 0"+
		            "   GROUP BY  table1.f2  " +
		            "   ORDER BY table1.f2 ASC";
				 System.out.println("sql_vientham_gdst_dt:"+sql_dt);
				 
			//st = conn.createStatement();
			rs = st.executeQuery(sql_dt);	
			ArrayList lstGdstDT = new ArrayList();
			for (int i = 0; i < 6; i++) {
				lstGdstDT.add("0");
			}
			DecimalFormat df = new DecimalFormat("#.##");
			while(rs.next()){
				int gdst = rs.getInt("gdst");
				float dt = rs.getFloat("dien_tich")/10000;
				lstGdstDT.set(gdst - 1, df.format(dt));
				System.out.println("-gdst:" +gdst);
				System.out.println("-dt:" +dt);
			}
			String strListDTByGdst = Utils.join(lstGdstDT,",");	 
			System.out.println("Dien tich theo gdst: "+ strListDTByGdst);
			rs.close();
			//Tinh tong dien tich lua trong vu
			float tongdt_vu = 0.0f;
			String strTongDTVu = "0.0";
			try{
				rs = st.executeQuery("SELECT tongdientichluatrongvu as tongdt FROM tongdientichluatrongvu("+vulua+","+y+","+lanhtho_id+")");	
				while(rs.next()){
					 tongdt_vu = rs.getFloat("tongdt");
				}
			}catch(SQLException e){}
			strTongDTVu = df.format(tongdt_vu);
			st.close();
			
			//Tao map file
			sql =
					
				"	 SELECT table1.f1 as ruong_id,table1.f2 as gdst,"+ 
	            "           TBL_RUONG_TMP.the_geom," +
                "           TBL_RUONG_TMP.gid" +
	            "   FROM giaidoansinhtruonglua("+d+", "+m+", "+y+","+ lanhtho_id+") AS table1" +
	            "   INNER JOIN 		   " +                    
	            "              (SELECT tbl_ruong_region.ruong_id,tbl_ruong_region.gid, tbl_ruong_region.the_geom FROM tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP" +
	            "   ON table1.f1=TBL_RUONG_TMP.ruong_id 	" +  
	            " WHERE table1.f2 > 0"+
	            "   GROUP BY  TBL_RUONG_TMP.gid, table1.f1, table1.f2,TBL_RUONG_TMP.the_geom  " ;
			 System.out.println("sql_vientham_gdst:"+sql);
			 
			 
	
           String data = "\"the_geom from " + "(" +sql + ") AS " + "tbl_vt_" + uid_file + "  USING UNIQUE gid USING SRID=4756"+"\"";
			MapFileTemplate.createMapFile(filename, data, expressions);
			/**Send data back to client mapfile+div_color*/
			//String divHtml = MapFileTemplate.createDivChugiaiHientrangWithNote(230,550, new Color(255,255,255), new Color(255,255,255), lstColorSegments,info_dientich);
			JSONObject json = new JSONObject();
			ArrayList<Object> lst = new ArrayList<Object>();
			Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
			htbl.put("map_file", mapFile);
			//htbl.put("div", divHtml);
			System.out.println("strDayOfYearFound========"+strDayOfYearFound);
			htbl.put("real_doy", Integer.parseInt(strDayOfYearFound));
			htbl.put("dt_by_gdst", strListDTByGdst);//12,54.22,151
			htbl.put("dt_vulua", strTongDTVu);
			
			lst.add(htbl);
			json.put("data", lst);
			String out =  json.toJSONString();
			System.out.println("OUTPUT: "+out);
			return out;
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
private String createMapFileVientham_CoLuaHayKo(String path_to_file, DBOperation dbo, HttpServletRequest request, HttpServletResponse response){		
	
	 HttpSession session = request.getSession();
	 String sessionID = session.getId();
	 Connection conn = dbo.getConnection();
		String retData = "";

		String posWKT = request.getParameter("position");
		String tableName = request.getParameter("table");
		String idName = request.getParameter("id");
		String strYear = request.getParameter("year");
		int intYear = Integer.parseInt(strYear);
		int vulua = Integer.parseInt(request.getParameter("vulua"));
		String lanhtho_id = "-1";
		System.out.println(intYear);
		
		Hashtable<String ,String > htb = (Hashtable<String ,String >)getInfoOfArea(dbo, posWKT, tableName, idName, /*retTypeIsJSON*/ false);
		String condition = "1=1";
		String uid_file = "";
		if (!htb.get(TblXa.XA_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblXa.XA_ID);
			condition = "tbl_ruong_region.xa_id= " + htb.get(TblXa.XA_ID);	
			lanhtho_id = htb.get(TblXa.XA_ID);
		} else if (!htb.get(TblHuyen.HUYEN_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblHuyen.HUYEN_ID);
			condition = "tbl_ruong_region.huyen_id= " + htb.get(TblHuyen.HUYEN_ID);
			lanhtho_id = htb.get(TblHuyen.HUYEN_ID);
		} else if (!htb.get(TblTinh.TINH_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblTinh.TINH_ID);
			condition = "tbl_ruong_region.tinh_id= " + htb.get(TblTinh.TINH_ID);
			lanhtho_id = htb.get(TblTinh.TINH_ID);
		}
		System.out.println("condition ="+condition);
		String mapFile = "vientham_colua_" + uid_file + "_" +sessionID+ ".map";
		String filename = path_to_file + Utils.FILE_SEPARATOR + mapFile;
		try {			
			
			
			Statement st = conn.createStatement();
			ResultSet rs = null;
			
			
		  ArrayList<String> expressions =  new  ArrayList<String>();
   		
  			String ruongnuoc_ten = "Có lúa";Color c = new Color(123,221,34);
  			String expression = "[co_lua] eq "+ 1;
  			String expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
  		    expressions.add(expclass);
  		    
  		    ruongnuoc_ten = "Không có lúa";	c = new Color(255, 255, 255);
  			expression = "[co_lua] eq "+ 0;
  			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
  		    expressions.add(expclass);
  		    
  		
			/*Tinh dien tich theo gdst */
			String sql_dt =
					
					"	SELECT table1.f2 as co_lua, SUM(TBL_RUONG_TMP.shape_area) as dien_tich"+ 
		            "   FROM dientichluatrongvu("+vulua+", "+(vulua==1?(intYear+1):intYear)+", "+ lanhtho_id+") AS table1" +
		            "   INNER JOIN 	(SELECT tbl_ruong_region.ruong_id,tbl_ruong_region.shape_area FROM tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP" +
		            "   ON table1.f1=TBL_RUONG_TMP.ruong_id 	" +  
		            "   GROUP BY  table1.f2  " +
		            "   ORDER BY table1.f2 ASC";
				 System.out.println("sql_vientham_colua_dt:"+sql_dt);
				 
			//st = conn.createStatement();
			rs = st.executeQuery(sql_dt);	
			ArrayList lstGdstDT = new ArrayList();
			for (int i = 0; i < 2; i++) {
				lstGdstDT.add("0");
			}
			DecimalFormat df = new DecimalFormat("#.##");
			while(rs.next()){
				int co_lua = rs.getInt("co_lua");
				float dt = rs.getFloat("dien_tich")/10000;
				lstGdstDT.set(co_lua , df.format(dt));
				System.out.println("-colua:" +co_lua);
				System.out.println("-dt:" +dt);
			}
			String strListDTByCoLua= Utils.join(lstGdstDT,",");	 
			System.out.println("Dien tich theo gdst: "+ strListDTByCoLua);
			rs.close();
			
			//Tao map file
			String sql =
					
				"	 SELECT table1.f1 as ruong_id,table1.f2 as co_lua,"+ 
	            "           TBL_RUONG_TMP.the_geom," +
               "           TBL_RUONG_TMP.gid" +
	            "   FROM dientichluatrongvu("+vulua+", "+(vulua==1?(intYear+1):intYear)+", "+ lanhtho_id+") AS table1" +
	            "   INNER JOIN 		   " +                    
	            "              (SELECT tbl_ruong_region.ruong_id,tbl_ruong_region.gid, tbl_ruong_region.the_geom FROM tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP" +
	            "   ON table1.f1=TBL_RUONG_TMP.ruong_id 	" +  
	            " WHERE table1.f2 > 0"+
	            "   GROUP BY  TBL_RUONG_TMP.gid, table1.f1, table1.f2,TBL_RUONG_TMP.the_geom  " ;
			 System.out.println("sql_vientham_colua:"+sql);
			 
			 
	
          String data = "\"the_geom from " + "(" +sql + ") AS " + "tbl_vt_" + uid_file + "  USING UNIQUE gid USING SRID=4756"+"\"";
			MapFileTemplate.createMapFile(filename, data, expressions);
			/**Send data back to client mapfile+div_color*/
			//String divHtml = MapFileTemplate.createDivChugiaiHientrangWithNote(230,550, new Color(255,255,255), new Color(255,255,255), lstColorSegments,info_dientich);
			JSONObject json = new JSONObject();
			ArrayList<Object> lst = new ArrayList<Object>();
			Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
			htbl.put("map_file", mapFile);
			//htbl.put("div", divHtml);
;
			htbl.put("dt_by_colua", strListDTByCoLua);//12,54.22,151
						
			lst.add(htbl);
			json.put("data", lst);
			String out =  json.toJSONString();
			System.out.println("OUTPUT: "+out);
			return out;
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
private String createMapFileVientham_TinhDTCacVu(String path_to_file, DBOperation dbo, HttpServletRequest request, HttpServletResponse response){		
	
	 HttpSession session = request.getSession();
	 String sessionID = session.getId();
	 Connection conn = dbo.getConnection();
		String retData = "";

		String posWKT = request.getParameter("position");
		String tableName = request.getParameter("table");
		String idName = request.getParameter("id");
		String strYear = request.getParameter("year");

		String lanhtho_id = "-1";

		
		Hashtable<String ,String > htb = (Hashtable<String ,String >)getInfoOfArea(dbo, posWKT, tableName, idName, /*retTypeIsJSON*/ false);
		String condition = "1=1";
		String uid_file = "";
		if (!htb.get(TblXa.XA_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblXa.XA_ID);
			condition = "tbl_ruong_region.xa_id= " + htb.get(TblXa.XA_ID);	
			lanhtho_id = htb.get(TblXa.XA_ID);
		} else if (!htb.get(TblHuyen.HUYEN_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblHuyen.HUYEN_ID);
			condition = "tbl_ruong_region.huyen_id= " + htb.get(TblHuyen.HUYEN_ID);
			lanhtho_id = htb.get(TblHuyen.HUYEN_ID);
		} else if (!htb.get(TblTinh.TINH_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblTinh.TINH_ID);
			condition = "tbl_ruong_region.tinh_id= " + htb.get(TblTinh.TINH_ID);
			lanhtho_id = htb.get(TblTinh.TINH_ID);
		}
		System.out.println("condition ="+condition);
		String mapFile = "vientham_colua_" + uid_file + "_" +sessionID+ ".map";
		String filename = path_to_file + Utils.FILE_SEPARATOR + mapFile;
		try {			
			
			
			Statement st = conn.createStatement();
			ResultSet rs = null;
			
			
		  
			/*Tinh dien tich theo gdst */
			String sql_dt =
					
					"	SELECT * FROM dientichluacanam("+strYear+", "+ lanhtho_id+")" ;
		    System.out.println("sql_vientham_tongdt_vunam:"+sql_dt);

			rs = st.executeQuery(sql_dt);	
			
			ArrayList lstDTCacvu = new ArrayList();
			DecimalFormat df = new DecimalFormat("#.##");
			while(rs.next()){
		
				lstDTCacvu.add(df.format( rs.getFloat("f1")));
				lstDTCacvu.add(df.format( rs.getFloat("f2")));
				lstDTCacvu.add(df.format( rs.getFloat("f3")));
				lstDTCacvu.add(df.format( rs.getFloat("f4")));
			
			}
			String lst_str_dt= Utils.join(lstDTCacvu,",");	 
			
			
			rs.close();
			
		  /**Send data back to client mapfile+div_color*/
			JSONObject json = new JSONObject();
			ArrayList<Object> lst = new ArrayList<Object>();
			Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
;
			htbl.put("lst_str_dt", lst_str_dt);//12,54.22,151
						
			lst.add(htbl);
			json.put("data", lst);
			String out =  json.toJSONString();
			System.out.println("OUTPUT: "+out);
			return out;
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
public String createMapFileVientham(String path_to_file, DBOperation dbo, HttpServletRequest request, HttpServletResponse response){		
	 int mapType = Integer.parseInt(request.getParameter("opts_map_type"));
	 int vulua = Integer.parseInt(request.getParameter("vulua"));
	 if(mapType == 1){
		 return createMapFileVientham_NDVI(path_to_file, dbo, request, response);
	 } else if(mapType == 2){
		 return createMapFileVientham_GDST(path_to_file, dbo, request, response);
	 } else if(mapType == 3){
		 return createMapFileVientham_CoLuaHayKo(path_to_file, dbo, request, response);
	 } else if(mapType == 4){// chỉ hiện thị diện tích
		 return createMapFileVientham_TinhDTCacVu(path_to_file, dbo, request, response);
	 }
	 return "";
}

private String createMapFileDuBao_ChatLuongDat(String path_to_file, DBOperation dbo, HttpServletRequest request, HttpServletResponse response){		
		
		System.out.println("createMapFileDuBao_ChatLuongDat...");
		 HttpSession session = request.getSession();
		 String sessionID = session.getId();
		 Connection conn = dbo.getConnection();
			String retData = "";

			String posWKT = request.getParameter("position");
			String tableName = request.getParameter("table");
			String idName = request.getParameter("id");
			String strYear = request.getParameter("year");
			String strMonth = request.getParameter("month");
			String strDay = request.getParameter("day");

			int mapType = Integer.parseInt(request.getParameter("opts_map_type"));
			String lanhtho_id = "-1";
			
		
			Hashtable<String ,String > htb = (Hashtable<String ,String >)getInfoOfArea(dbo, posWKT, tableName, idName, /*retTypeIsJSON*/ false);
			String condition = "1=1";
			String uid_file = "";
			if (!htb.get(TblXa.XA_ID).equalsIgnoreCase("-1")){
				uid_file = htb.get(TblXa.XA_ID);
				condition = "tbl_ruong_region.xa_id= " + htb.get(TblXa.XA_ID);	
				lanhtho_id = htb.get(TblXa.XA_ID);
			} else if (!htb.get(TblHuyen.HUYEN_ID).equalsIgnoreCase("-1")){
				uid_file = htb.get(TblHuyen.HUYEN_ID);
				condition = "tbl_ruong_region.huyen_id= " + htb.get(TblHuyen.HUYEN_ID);
				lanhtho_id = htb.get(TblHuyen.HUYEN_ID);
			} else if (!htb.get(TblTinh.TINH_ID).equalsIgnoreCase("-1")){
				uid_file = htb.get(TblTinh.TINH_ID);
				condition = "tbl_ruong_region.tinh_id= " + htb.get(TblTinh.TINH_ID);
				lanhtho_id = htb.get(TblTinh.TINH_ID);
			}
			System.out.println("condition ="+condition);
			String mapFile = "dubao_vt_cld_" + uid_file + "_" +sessionID+ ".map";
			String filename = path_to_file + Utils.FILE_SEPARATOR + mapFile;
			try {			
				Statement st = conn.createStatement();
				ResultSet rs = null;	
					
	            ArrayList<String> expressions =  new  ArrayList<String>();
	    		int nCapdo  =10;
	   			String capdo_ten = "10";Color c = new Color(0, 64, 0);
	   			String expression = "([capdo] >=" + 90 + ") AND ([capdo] <=" + 200 +")";
				
	   			String expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
	   		    expressions.add(expclass);
	   		    
	   		    capdo_ten = "9";	c = new Color(0, 128, 0);
	   			expression = "([capdo] >=" + 80 + ") AND ([capdo] <" + 90 +")";
	   			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
	   		    expressions.add(expclass);
	   		    
	   		    capdo_ten = "8";	c = new Color(0, 187, 0);
	   			expression = "([capdo] >=" + 70 + ") AND ([capdo] <" + 80 +")";
	   			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
	   		    expressions.add(expclass);
	   		    
	   		    capdo_ten = "7";	c = new Color(0,230,0);
	   			expression = "([capdo] >=" + 60 + ") AND ([capdo] <" + 70 +")";
	   			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
	   		    expressions.add(expclass);
	   		    
	   		    capdo_ten = "6";	c = new Color(0, 255,0);
	   			expression = "([capdo] >=" + 50 + ") AND ([capdo] <" + 60 +")";
	   			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
	   		    expressions.add(expclass);
	   		    
	   		    capdo_ten = "5";	c = new Color(123,221,34);
	   			expression = "([capdo] >=" + 40 + ") AND ([capdo] <" + 50 +")";
	   			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
	   		    expressions.add(expclass);
	   		    
	   		    capdo_ten = "4";	c = new Color(199,228,27);
	   			expression = "([capdo] >=" + 30 + ") AND ([capdo] <" + 40 +")";
	   			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
	   		    expressions.add(expclass);
	   		    
	   		    capdo_ten = "3";	c = new Color(234,191,21);
	   			expression = "([capdo] >=" + 20 + ") AND ([capdo] <" + 30 +")";
	   			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
	   		    expressions.add(expclass);
	   		    
	   		    capdo_ten = "2";	c = new Color(243,163,12);
	   			expression = "([capdo] >=" + 10 + ") AND ([capdo] <" + 20 +")";
	   			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
	   		    expressions.add(expclass);
	   		    
	   		    capdo_ten = "1";	c = new Color(250,109,15);
	   			expression = "([capdo] >" + 00 + ") AND ([capdo] <" + 10 +")";
	   			expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, Config.colorBorderRenderGDST);
	   		    expressions.add(expclass);
	   		    
	   		   

	   		    
	 	
				
				String sql_dt =
						
						"	SELECT table1.f2 as capdo, SUM(TBL_RUONG_TMP.shape_area) as dien_tich"+ 
			            "   FROM lapbandodattheonangsuat("+lanhtho_id+") AS table1" +
			            "   INNER JOIN 	(SELECT tbl_ruong_region.ruong_id,tbl_ruong_region.shape_area FROM tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP" +
			            "   ON table1.f1=TBL_RUONG_TMP.ruong_id 	" +  
			            "   WHERE table1.f2 > 0"+
			            "   GROUP BY  table1.f2  " +
			            "   ORDER BY table1.f2 DESC";
					 System.out.println("sql_dubao_chatluongdat:"+sql_dt);
					 
				//st = conn.createStatement();
				rs = st.executeQuery(sql_dt);	
				ArrayList<Float> lstChatLuongDatDT = new ArrayList<Float>();
				ArrayList<String> lstStringDT = new ArrayList<String>();
				for (int i = 0; i < nCapdo; i++) {
					lstChatLuongDatDT.add(0.0f);
					lstStringDT.add("0");
					
				}
				DecimalFormat df = new DecimalFormat("#.##");
				float total_dt_by_cld =0.0f;
				while(rs.next()){
					int capdo = (rs.getInt("capdo")+(nCapdo-1))/nCapdo;
					float dt = rs.getFloat("dien_tich")/10000;
					total_dt_by_cld+=dt;
					if(capdo < 1)capdo = 1;
					int idxCapdo = capdo - 1;
					if(idxCapdo >= nCapdo) idxCapdo = nCapdo - 1;
					
					float vlast=lstChatLuongDatDT.get(idxCapdo);
					vlast+=dt;
					lstChatLuongDatDT.set(idxCapdo, vlast);//because thu tu cap do == thu tu element in array
					System.out.println("-capdo:" +capdo);
					System.out.println("-dt:" +dt);
				}
				
				
				for(int i =0 ;i < lstChatLuongDatDT.size(); i++)
				{
					Float f = lstChatLuongDatDT.get(i);
					lstStringDT.set(i, df.format(f));
		
				}
				
				String strListDTByCapdo = Utils.join(lstStringDT,",");	 
				System.out.println("Dien tich theo capdo(Tong:"+total_dt_by_cld+" ): "+ strListDTByCapdo);
				rs.close();
				
				//Tao map file
				String sql =
						
					"	 SELECT table1.f1 as ruong_id,table1.f2 as capdo,"+ 
		            "           TBL_RUONG_TMP.the_geom," +
	                "           TBL_RUONG_TMP.gid" +
		            "   FROM lapbandodattheonangsuat("+lanhtho_id+") AS table1" +
		            "   INNER JOIN 		   " +                    
		            "              (SELECT tbl_ruong_region.ruong_id,tbl_ruong_region.gid, tbl_ruong_region.the_geom FROM tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP" +
		            "   ON table1.f1=TBL_RUONG_TMP.ruong_id 	" +  
		            " WHERE table1.f2 > 0"+
		            "   GROUP BY  TBL_RUONG_TMP.gid, table1.f1, table1.f2,TBL_RUONG_TMP.the_geom  " ;
				 System.out.println("MAP_sql_dubao_vt_chatluongdat:"+sql);
				 
				 
		
	           String data = "\"the_geom from " + "(" +sql + ") AS " + "tbl_dubao_vt_cld" + uid_file + "  USING UNIQUE gid USING SRID=4756"+"\"";
				MapFileTemplate.createMapFile(filename, data, expressions);
				/**Send data back to client mapfile+div_color*/
				//String divHtml = MapFileTemplate.createDivChugiaiHientrangWithNote(230,550, new Color(255,255,255), new Color(255,255,255), lstColorSegments,info_dientich);
				JSONObject json = new JSONObject();
				ArrayList<Object> lst = new ArrayList<Object>();
				Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
				htbl.put("map_file", mapFile);
				//htbl.put("div", divHtml);
	
				htbl.put("dt_by_capdo", strListDTByCapdo);//12,54.22,151
				
				
				lst.add(htbl);
				json.put("data", lst);
				String out =  json.toJSONString();
				System.out.println("OUTPUT: "+out);
				return out;
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "";
}

private String createMapFileDuBao_NangSuat(String path_to_file, DBOperation dbo, HttpServletRequest request, HttpServletResponse response){		
	
	 HttpSession session = request.getSession();
	 String sessionID = session.getId();
	 Connection conn = dbo.getConnection();
		String retData = "";

		String posWKT = request.getParameter("position");
		String tableName = request.getParameter("table");
		String idName = request.getParameter("id");
		String strYear = request.getParameter("year");
		String strMonth = request.getParameter("month");
		String strDay = request.getParameter("day");
		
		int mapType = Integer.parseInt(request.getParameter("opts_map_type"));
	
		String lanhtho_id = "-1";
		
		
		System.out.println(strDay+"/"+strMonth+"/"+strYear);
		
		Hashtable<String ,String > htb = (Hashtable<String ,String >)getInfoOfArea(dbo, posWKT, tableName, idName, /*retTypeIsJSON*/ false);
		String condition = "1=1";
		String uid_file = "";
		if (!htb.get(TblXa.XA_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblXa.XA_ID);
			condition = "tbl_ruong_region.xa_id= " + htb.get(TblXa.XA_ID);	
			lanhtho_id = htb.get(TblXa.XA_ID);
		} else if (!htb.get(TblHuyen.HUYEN_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblHuyen.HUYEN_ID);
			condition = "tbl_ruong_region.huyen_id= " + htb.get(TblHuyen.HUYEN_ID);
			lanhtho_id = htb.get(TblHuyen.HUYEN_ID);
		} else if (!htb.get(TblTinh.TINH_ID).equalsIgnoreCase("-1")){
			uid_file = htb.get(TblTinh.TINH_ID);
			condition = "tbl_ruong_region.tinh_id= " + htb.get(TblTinh.TINH_ID);
			lanhtho_id = htb.get(TblTinh.TINH_ID);
		}
		System.out.println("condition ="+condition);
		String mapFile = "dubao_vt_ns" + uid_file + "_" +sessionID+ ".map";
		String filename = path_to_file + Utils.FILE_SEPARATOR + mapFile;
		try {			
			
			Statement st = conn.createStatement();
			ResultSet rs = null;
			
			
			
	          ArrayList<String> expressions =  new  ArrayList<String>();
	          ArrayList lstColorSegments =  new  ArrayList();
	          float max=100;
	          float min=0;
	          int n=5;
		
			ArrayList<HTRange> lstHTRange=new ArrayList<HTRange>();
			
			lstHTRange.add(new HTRange(0,0,0,new Color(250,109,15),0)); //0-10
			lstHTRange.add(new HTRange(0,0,0,new Color(243,163,12),0)); 
			lstHTRange.add(new HTRange(0,0,0,new Color(234,191,21),0)); 
			lstHTRange.add(new HTRange(0,0,0,new Color(199,228,27),0)); 
			lstHTRange.add(new HTRange(0,0,0,new Color(123,221,34),0)); 
			lstHTRange.add(new HTRange(0,0,0,new Color(0, 255, 0),0)); 
			lstHTRange.add(new HTRange(0,0,0,new Color(0, 230, 0),0)); 
			lstHTRange.add(new HTRange(0,0,0,new Color(0, 187, 0), 0));
			lstHTRange.add(new HTRange(0,0,0,new Color(0, 128, 0),0)); 
			lstHTRange.add(new HTRange(0,0,0,new Color(0, 64, 0), 0)); //90-100
			
			{
				max=100;
				min=0;
				n = 10;
				float nangsuat_tb=(max-min)/n;
				for (int i=0;i < n;i++)
				{
					float a = min + (i)*nangsuat_tb;
					float b = a + nangsuat_tb;
					DecimalFormat df = new DecimalFormat("#.##");
					lstHTRange.get(i).min = a;
					lstHTRange.get(i).max = b;
					String expression = "";
					String ex_max = "=";
			
					String operator_for_max = "";
					//if(i==n-1)operator_for_max = "=";
					if(i==n-1) expression = "([db_vt_ns] >=" + df.format(a) + ") AND ([db_vt_ns] <="  + df.format(b)+")";
					else  expression = "([db_vt_ns] >" + df.format(a) + ") AND ([db_vt_ns] <="  + df.format(b)+")";
					
					 
					Random r = new Random();
					Color c = (Color)lstHTRange.get(i).color;
					
					//System.out.println(String.valueOf(df.format(a))+ " - " + String.valueOf(df.format(b)) + " (tấn/ha)");
					//ColorItem colorItem = new ColorItem();
					//colorItem.name =String.valueOf(df.format(a))+ " - " + String.valueOf(df.format(b)) + " (tấn/ha)";
					//colorItem.color = c;
					//lstColorSegments.add(colorItem);
					String expclass = MapFileTemplate.genStyleExpressionClass(expression, null, c, new Color(0,0,0));
					expressions.add(expclass);
				}
			}
			
			
			
			String sql_dt =
					
					"	SELECT table1.f2 as nangsuat, SUM(TBL_RUONG_TMP.shape_area) as dien_tich"+ 
		            "   FROM lapbandonangsuatchovulua("+strDay+","+strMonth+","+strYear+","+lanhtho_id+") AS table1" +
		            "   INNER JOIN 	(SELECT tbl_ruong_region.ruong_id,tbl_ruong_region.shape_area FROM tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP" +
		            "   ON table1.f1=TBL_RUONG_TMP.ruong_id 	" +  
		            "   WHERE table1.f2 > 0"+
		            "   GROUP BY  table1.f2  " +
		            "   ORDER BY table1.f2 ASC";
				 System.out.println("sql_dubao_nangsuat:"+sql_dt);
				 
			//st = conn.createStatement();
			rs = st.executeQuery(sql_dt);	

			DecimalFormat df = new DecimalFormat("#.##");
			float total_dt_by_ns = 0.0f;
			while(rs.next()){
				float nangsuat = (float)rs.getInt("nangsuat");
				float dt = rs.getFloat("dien_tich")/10000;
				total_dt_by_ns += dt;
				
				for(int i =0 ;i < lstHTRange.size(); i++)
				{
					HTRange range = lstHTRange.get(i);
					if(i==lstHTRange.size()-1){
						if(nangsuat >= range.min && nangsuat <= range.max)
						{
						range.value += dt;
						break;
						}
					} else {
						if(nangsuat >= range.min && nangsuat < range.max)
						{
						range.value += dt;
						break;
						}
					}
				}
			}
			
			ArrayList lstNangSuatDT = new ArrayList();
			for (int i = 0; i < 10; i++) {
				lstNangSuatDT.add("0");
			}
			float total_dt_by_ns_aftergroup =0.0f;
			for(int i =0 ;i < lstHTRange.size(); i++)
			{
				HTRange range = lstHTRange.get(i);
				range.value_s = df.format(range.value);
				total_dt_by_ns_aftergroup+=range.value;
				lstNangSuatDT.set(i, range.value_s);
	
			}
					
			//System.out.println("-capdo:" +capdo);
			//System.out.println("-dt:" +dt);
			String strListDTByNS = Utils.join(lstNangSuatDT,",");	 
			System.out.println("Dien tich theo nangsuat(Tong:"+total_dt_by_ns+ ", after group:"+ total_dt_by_ns_aftergroup+" ): "+ strListDTByNS);
			
			rs.close();
			
			//======================================================
			
			
			
		
			


			//Tao map file
			String sql =
					 
				"	 SELECT table1.f1 as ruong_id,table1.f2 as db_vt_ns,"+ 
	            "           TBL_RUONG_TMP.the_geom," +
                "           TBL_RUONG_TMP.gid " +
	            "  "+
                " 	FROM lapbandonangsuatchovulua("+strDay+","+strMonth+","+strYear+","+lanhtho_id+") AS table1" +
	            "   INNER JOIN 		   " +                    
	            "              (SELECT tbl_ruong_region.ruong_id,tbl_ruong_region.gid, tbl_ruong_region.the_geom FROM tbl_ruong_region where "+ condition +") as TBL_RUONG_TMP" +
	            "   ON table1.f1=TBL_RUONG_TMP.ruong_id 	" +  
	            " WHERE table1.f2 > 0"+
	            "   GROUP BY  TBL_RUONG_TMP.gid, table1.f1, table1.f2,TBL_RUONG_TMP.the_geom  " ;
			 System.out.println("MAP_sql_dubao_vt_chatluongdat:"+sql);

	
           String data = "\"the_geom from " + "(" +sql + ") AS " + "tbl_dubao_vt_ns" + uid_file + "  USING UNIQUE gid USING SRID=4756"+"\"";
			MapFileTemplate.createMapFile(filename, data, expressions);
			/**Send data back to client mapfile+div_color*/
			//String divHtml = MapFileTemplate.createDivChugiaiHientrangWithNote(230,550, new Color(255,255,255), new Color(255,255,255), lstColorSegments,info_dientich);
			JSONObject json = new JSONObject();
			ArrayList<Object> lst = new ArrayList<Object>();
			Hashtable<Object, Object> htbl = new Hashtable<Object, Object>();
			htbl.put("map_file", mapFile);
			//htbl.put("div", divHtml);

			htbl.put("dt_by_ns", strListDTByNS);


			
			lst.add(htbl);
			json.put("data", lst);
			
			String out =  json.toJSONString();
			System.out.println("OUTPUT: "+out);
			return out;
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
public String createMapFileDuBao(String path_to_file, DBOperation dbo, HttpServletRequest request, HttpServletResponse response){		
	 int mapType = Integer.parseInt(request.getParameter("opts_map_type"));
	 if(mapType == 1){
		 return createMapFileDuBao_ChatLuongDat(path_to_file, dbo, request, response);
	 } else if(mapType == 2){
		 return createMapFileDuBao_NangSuat(path_to_file, dbo, request, response);
	 } else if(mapType == -1){
		 return createMapFileDuBao_ChatLuongDat(path_to_file, dbo, request, response);
	 }
	 return "";
}


}//END CLASS
