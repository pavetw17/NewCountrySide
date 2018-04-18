package com.cwrs.ntk.servlets.dao.xxx;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.cwrs.ntk.servlets.dao.xxx.old.DBOperation;
import com.cwrs.ntk.servlets.dao.xxx.old.DlgOperation;
import com.cwrs.ntk.servlets.dao.xxx.old.MainWebGUI;
import org.json.simple.JSONObject;

import com.cwrs.ntk.common.Definitions;
import com.cwrs.ntk.common.old.JResult;
import com.cwrs.ntk.common.old.LogWriter;
import com.cwrs.ntk.common.Utils;
import com.cwrs.ntk.distributor.PhanboCanhdongServlet;
import com.cwrs.ntk.docconverter.ConversionThreadManager;
import com.cwrs.ntk.vientham.VienthamOperation;

/**
 * Servlet implementation class DBPoolServlet
 */
@WebServlet("/DBPoolServlet")
public class DBPoolServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	String encoding = "";
	int activeCount;
	boolean bInitLogWriter = false;
	ServletConfig m_config;
	
	InitialContext ctx = null;
	static DataSource ds = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DBPoolServlet() {
        super();

        // TODO Auto-generated constructor stub
    }
    public void init() throws ServletException {
        ServletConfig config = getServletConfig();
  				System.out.println("init config=" +config);

    }
	/**
	 * @see Servlet#init(ServletConfig)
	 */

	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		System.err.println("init DBPoolServlet...");
		m_config = config;
		//	System.out.println("init config=" +config);
		  activeCount = 0;
	        System.out.println("Create new DBPoolServlet instance");
	        try {
	        // TODO Auto-generated constructor stub
	        // Create a JNDI Initial context to be able to lookup the DataSource

	        ctx = new InitialContext();
	        // Lookup the DataSource, which will be backed by a pool
	        // that the application server provides.
	        ds = (DataSource)ctx.lookup(Definitions.DB_URL_DATASOURCE);
	        } catch (NamingException ex) {
	        	ex.printStackTrace();
	        }
	       // (new Thread(new ConversionThreadManager())).start();
	}
    public static DataSource getDatasource(){
    	System.out.println("getDatasource: Hey, you are get me!");
    	if (ds == null){
    		System.out.println("But, I'm not available now..Trying creating new!");

	        try {
	        // TODO Auto-generated constructor stub
	        // Create a JNDI Initial context to be able to lookup the DataSource
	        // Lookup the DataSource, which will be backed by a pool
	        // that the application server provides.
	        ds = (DataSource)(new InitialContext()).lookup(Definitions.DB_URL_DATASOURCE);
	        } catch (NamingException ex) {
	        	ex.printStackTrace();
	        }
	        if (ds != null){
	        	  System.out.println("-->OK!");
	        }
    	}
    	return ds;
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		  initLogWriter(request);
		  response.setContentType("text/html; charset=utf-8");
		  PrintWriter writeResponse = response.getWriter();
	      Connection conn = null;
	      try {
			conn = ds.getConnection();
	         System.out.println("connection pool: =" +conn.hashCode());
	         DBOperation dbo = new DBOperation();
	         dbo.setConnection(conn);
	         processRequest(dbo, request, response);
	         dbo.closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	public void initLogWriter(HttpServletRequest request){
		if(!bInitLogWriter){
			String confFile = m_config.getServletContext().getRealPath(request.getServletPath())+"/../log4j.properties";
			LogWriter.loadConfigureFile(confFile);
			bInitLogWriter = true;
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		initLogWriter(request);


		//Set unicode for response data
		response.setContentType("text/html; charset=utf-8");
		//request.setCharacterEncoding("UTF-8");
		  Connection conn = null;
	      Statement stmt = null;
	      ResultSet rset = null;


	    //    ServletConfig config = getServletConfig();

	   //     encoding = config.getInitParameter("PARAMETER_ENCODING");
	      System.out.println("doPost,encode = " +encoding);
	      PrintWriter out = response.getWriter();
	      try {
	     	 /*if (ctx == null){
	    		 ctx = new InitialContext();
	    	 }*/

	        // System.out.println( ds.toString());
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
	protected void getCurrentTime(DBOperation dbo, HttpServletRequest request, PrintWriter response){
		System.out.println("Get current time...");
		JSONObject jso = Utils.getCurrentTime();
		response.print(jso.toJSONString());
	}
	protected void processRequest(DBOperation dbo, HttpServletRequest request, HttpServletResponse response){
		 try {

			 System.out.println("request0: " + request.getQueryString());
			// System.out.println(Utils.convertInt2DateString(15349));
			 HttpSession session = request.getSession();
			 String sessionID = session.getId();
			 activeCount++;
			 System.out.println("activeCount0 =" + activeCount + "(sessionID = " + sessionID +")");
			PrintWriter writeResponse = response.getWriter();
			String codeREQ = request.getParameter("action");
			System.out.println("action =" +codeREQ);
			if (codeREQ==null ||"null".equalsIgnoreCase(codeREQ))return;
			switch(Integer.parseInt(codeREQ)){
		    case 11111:
		    {
		    	//String s =
		    	//	"{\"total\":1,\"rows\":[{\"name\":\"id\",\"values\":\"text\",\"editor\":{\"type\":\"combobox\",\"options\":{\"valueField\":\"id\",\"textField\":\"text\",\"url\":\"DBPoolServlet?action=10&type=0&topsymbol=*\",\"required\":\"true\"}}}]}";

		    	getData2ShowThongtinGieocayRuongOnPropertyGrid(dbo, request, writeResponse);
		    	//writeResponse.print(s);
		    }
		    	;break;
		    	case Definitions.ACT_GET_CURRENT_TIME: getCurrentTime(dbo, request, writeResponse);break;

			    case Definitions.ACT_SIGNIN: login(dbo, request, writeResponse);break;

			    /**Combobox ACT_GET_SAUBENH_TO_CBB*/
			    case Definitions.ACT_GET_SAUHAI_TO_CBB  : getSauhai2Cbb(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_TINH_TO_CBB    : getTinh2Cbb(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_HUYEN_TO_CBB   : getHuyen2Cbb(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_XA_TO_CBB      : getXa2Cbb(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_TRALUA_TO_CBB  : getTralua2Cbb(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_VULUA_TO_CBB  : getVulua2Cbb(dbo, request, writeResponse);break;
				case Definitions.ACT_GET_GIONGLUA_TO_CBB: getGionglua2Cbb(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_THIENTAI_TO_CBB: getThientai2Cbb(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_THIENDICH_TO_CBB: getThiendich2Cbb(dbo, request, writeResponse);break;
				case Definitions.ACT_GET_GDST_LUA_TO_CBB: getGDSTLua2Cbb(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_TUOI_SAUHAI_TO_CBB: getTuoiSau2Cbb(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_BENHHAI_TO_CBB    : getBenhhai2Cbb(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_HIENTRANG_TO_CBB  : getHientrang2Cbb(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_MUCDOTHIENTAI_TO_CBB: getMucdoTheoLoaiThientai2Cbb(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_LOAIPHAN_TO_CBB: getLoaiPhan2Cbb(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_CACHBONPHAN_TO_CBB: getCachBonPhan2Cbb(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_HUONGGIO_TO_CBB: getHuongGio2Cbb(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_TENTHUOC_TO_CBB: getTenThuoc2Cbb(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DOTTHIENTAI_TO_CBB: getDotThienTai2Cbb(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_PPGC_TO_CBB: getPhuongphapGieocay2Cbb(dbo, request, writeResponse); break;
				case Definitions.ACT_GET_DOT_THIENTAI_TO_CBB  : getDotThientai3Cbb(dbo, request, writeResponse); break;
				case Definitions.ACT_GET_VIENTHAM_TO_CBB: getVientham2Cbb(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_LIST_RUONGID_SAME_CANHDONG:getListRuongIDSameCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_CANHDONG_FOR_XA:getDataCanhdongForXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_LOAILUA_TO_CBB  : getLoailua2Cbb(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_LOAIBANDO_TO_CBB: getLoaiBando2Cbb(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_BOUND_OF_AREA:getBBoxOfArea(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_GEOMETRY_OF_AREA:getGeometryOfTinhHuyenXa(dbo, request, writeResponse); break;

			    //Insert/Update to Database
			    case Definitions.ACT_DB_INSERT_UPDATE_MULTI_OBJECT: execInsertUpdatedMultiRecords2DBByClient(dbo, request, writeResponse);break;

			    case Definitions.ACT_DB_INSERT_THONGTIN_GIEOCAY: insertThongtinGieocay2DB(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_GEOMETRY_BY_INTERSECTION: getGeometryByIntersection(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_ID_GEOMETRY_BY_INTERSECTION: getIDByIntersection(dbo, request, writeResponse); break;

			    case Definitions.ACT_PRECACHE_GEOMETRY: getPreCachedGeometry(dbo, request, writeResponse); break;
			    case Definitions.ACT_DB_DELETE_OBJECT : deleteRecord(dbo, request, writeResponse); break;
			    case Definitions.ACT_DB_CHECK_DATA_EXISTS : checkDataExists(dbo, request, writeResponse); break;
			    case Definitions.ACT_DB_MAX_DATA : checkMAX(dbo, request, writeResponse); break;
			    case Definitions.ACT_DB_CHECK_RUONG : checkDataRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_DB_DIENTICH : checkDataDientich(dbo, request, writeResponse); break;
			    case Definitions.ACT_DB_CHECK_DOTTHIENTAI_EXISTS : checkDotThientai(dbo, request, writeResponse); break;
			    /*huyentn
				     *   case Definitions.ACT_DB_CHECK_DATA_EXISTS : checkDataExists(dbo, request, writeResponse); break;*Dieu tra theo ruong ACT_GET_DATA_TO_EDIT_NUOC_RUONG*/
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTGC_RUONG: getData2EditThongtinGieocayRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTSH_RUONG: getData2EditThongtinSauhaiRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTBH_RUONG: getData2EditThongtinBenhhaiRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_HTL_RUONG: getData2EditHientrangLuaRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTTT_RUONG: getData2EditThongtinThientaiRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTTT: getData2ShowThongtinThitruong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTTT: getData2EditThongtinThitruong(dbo, request, writeResponse); break;

			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTGC_RUONG: getData2ShowThongtinGieocayRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTSH_RUONG: getData2ShowThongtinSauhaiRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTBH_RUONG: getData2ShowThongtinBenhhaiRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_HTL_RUONG: getData2ShowHientrangLuaRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTTT_RUONG: getData2ShowThongtinThientaiRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTNS_RUONG: getData2EditThongtinNangsuatRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTNS_RUONG: getData2ShowThongtinNangsuatRuong(dbo, request, writeResponse); break;

			    case Definitions.ACT_GET_DATA_TO_EDIT_TLB_RUONG: getData2EditTyleBenhRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TLB_RUONG: getData2ShowTyleBenhRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_DTN_RUONG: getData2EditDientichnhiemRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_DTN_RUONG: getData2ShowDientichnhiemRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_NUOC_RUONG: getData2EditNuocRuong(dbo, request, writeResponse); break;
			////1/12/2011
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTKS_RUONG: getData2EditThongtinKysinhRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTKS_RUONG: getData2ShowThongtinKysinhRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTTD_RUONG: getData2EditThongtinThiendichRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTTD_RUONG: getData2ShowThongtinThiendichRuong(dbo, request, writeResponse); break;
			    /**Dieu tra theo canh dong
	 */
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTGC_CANHDONG: getData2EditThongtinGieocayCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTSH_CANHDONG: getData2EditThongtinSauhaiCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTBH_CANHDONG: getData2EditThongtinBenhhaiCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTTT_CANHDONG: getData2EditThongtinThientaiCanhdong(dbo, request, writeResponse); break;
			    // Thời tiết tuấn
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTT_HUYEN: getData2EditThoitiettuan(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTT_HUYEN: getData2ShowThoitiettuan(dbo, request, writeResponse); break;

			    //  = 1004;   case Definitions.ACT_GET_DATA_TO_EDIT_HTL_CANHDONG: getData2EditHientrangLuaCanhdong(dbo, request, writeResponse); break;

			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTSH_CANHDONG: getData2ShowThongtinSauhaiCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTBH_CANHDONG: getData2ShowThongtinBenhhaiCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTGC_CANHDONG: getData2ShowThongtinGieocayCanhdong(dbo, request, writeResponse); break;

			    case Definitions.ACT_GET_DATA_TO_FORM_ADD_HTL_CANHDONG:getData2AddHientrangLuaCanhdongInline(dbo, request, writeResponse); break;

			    case Definitions.ACT_GET_DATA_TO_FORM_ADD_TTTT_CANHDONG: getData2AddThongtinThientaiCanhdongInline(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTTT_CANHDONG: getData2ShowThongtinThientaiCanhdong(dbo, request, writeResponse); break;

			    case Definitions.ACT_GET_DATA_TO_FORM_ADD_DTN_CANHDONG: getData2AddThongtinDientichNhiemCanhdongInline(dbo, request, writeResponse); break;


			    case Definitions.ACT_GET_DATA_TO_EDIT_MDS_RUONG: getData2EditMatdoSauhaiRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_MDS_RUONG: getData2ShowMatdoSauhaiRuong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_MDS_CANHDONG: getData2EditMatdoSauhaiCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_MDS_CANHDONG: getData2ShowMatdoSauhaiCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTNS_CANHDONG: getData2EditThongtinNangsuatCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTNS_CANHDONG: getData2ShowThongtinNangsuatCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_TLB_CANHDONG: getData2EditTyleBenhCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TLB_CANHDONG: getData2ShowTyleBenhCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_DTN_CANHDONG: getData2EditDientichnhiemCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_DTN_CANHDONG: getData2ShowDientichnhiemCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_HTL_CANHDONG: getData2EditHientrangLuaCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_HTL_CANHDONG: getData2ShowHientrangLuaCanhdong(dbo, request, writeResponse); break;
			  //  case Definitions.ACT_GET_DATA_TO_FORM_SHOW_BAOCAO_GIONGLUA: getData2ShowBaocaoCocauGionglua(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTKS_CANHDONG: getData2EditThongtinKysinhCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTKS_CANHDONG: getData2ShowThongtinKysinhCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTTD_CANHDONG: getData2EditThongtinThiendichCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTTD_CANHDONG: getData2ShowThongtinThiendichCanhdong(dbo, request, writeResponse); break;
			    /* // var ACT_GET_DATA_TO_FORM_SHOW_TTKS_CANHDONG = 1026;
			    var ACT_GET_DATA_TO_EDIT_TTKS_CANHDONG = 1027;
			    var ACT_GET_DATA_TO_FORM_SHOW_TTKS_RUONG = 1028;
			    var ACT_GET_DATA_TO_EDIT_TTKS_RUONG = 1029;
			    var ACT_GET_DATA_TO_FORM_SHOW_TTTD_CANHDONG = 1030;
			    var ACT_GET_DATA_TO_EDIT_TTTD_CANHDONG = 1031;
			    var ACT_GET_DATA_TO_FORM_SHOW_TTTD_RUONG = 1032;
			    var ACT_GET_DATA_TO_EDIT_TTTD_RUONG = 1033;
			    */
			    //Các action của Tùng
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_HTL_XA: getData2HienTrangLuaXaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_THIENTAI_XA: getData2ThienTaiXaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_KQTHUHOACH_XA: getData2KQThuHoachXaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_KQTHUHOACH_PHAPLY_XA: getData2KQThuHoachXaPhapLyForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_SINHTHAI_XA: getData2SinhthaiXaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TTGIEOCAY_XA: getData2ThongTinGieoCayXaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_MATDOSAU_XA: getData2MatDoSauXaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TYLEBENH_XA: getData2TyLeBenhXaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_DTNHIEM_XA: getData2DienTichNhiemXaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_BAYDEN_XA: getData2BayDenXaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_KYSINH_XA: getData2KySinhXaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_BATMOIANTHIT_XA: getData2BatMoiAnThitXaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_PHUNTHUOC_XA: getData2PhunThuocXaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_BONPHAN_XA: getData2BonPhanXaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_THOITIETTINH_XA: getData2ThoiTietTinhXaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_DUBAOTHOITIETTINH_XA: getData2DuBaoThoiTietTinhXaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_THOITIETHUYEN_XA: getData2ThoiTietHuyenXaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_SOLIEUTHIENDICH: getData2SoLieuThienDichForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_SOLIEUVISINHVAT: getData2SoLieuViSinhVatForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_SOLIEUPHANBON: getData2SoLieuPhanBonForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_SOLIEUTHUOCBVTV: getData2SoLieuThuocBVTVForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_SOLIEUHIENTUONGGAYHAI: getData2SoLieuHienTuongGayHaiForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_SOLIEUGIONGLUA: getData2SoLieuGiongLuaForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_SOLIEUDICHBENH: getData2SoLieuDichBenhForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_SOLIEUSAUHAI: getData2SoLieuSauHaiForm(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_FORM_SHOW_DOTTHIENTAI: getData2SoLieuDotThienTaiForm(dbo, request, writeResponse); break;

			    case Definitions.ACT_GET_LIST_HIENTUONGGAYHAI_TO_CHECKBOX: getListHienTuongGayHai2ComboHtml(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_LIST_KHANGSAU_TO_CHECKBOX: getListKhangSau2ComboHtml(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_LIST_KHANGBENH_TO_CHECKBOX: getListKhangBenh2ComboHtml(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_LIST_THIENDICH_TO_CHECHBOX: getListThienDich2ComboHtml(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_LIST_THUOC_TO_CHECKBOX: getListThuoc2ComboHtml(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_LIST_VISINHVAT_TO_CHECHBOX: getListViSinhVat2ComboHtml(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_HTL_XA: getData2EditHienTrangLuaXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_KQTH_XA: getData2EditKetQuaThuHoachXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_KQTH_PHAPLY_XA: getData2EditKetQuaThuHoachPhapLyXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_SINHTHAI_XA: getData2EditSinhThaiXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_THIENTAI_XA: getData2EditThienTaiXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_TTGIEOCAY_XA: getData2EditThongTinGieoCayXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_MATDOSAU_XA: getData2EditMatDoSauXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_TYLEBENH_XA: getData2EditTyLeBenhXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_DTNHIEM_XA: getData2EditDienTichNhiemXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_BAYDEN_XA: getData2EditBayDenXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_KYSINH_XA: getData2EditKySinhXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_BATMOIANTHIT_XA: getData2EditBatMoiAnThitXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_PHUNTHUOC_XA: getData2EditPhunThuocXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_BONPHAN_XA: getData2EditBonPhanXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_THOITIETTINH_XA: getData2EditThoiTietTinhXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_DUBAOTHOITIETTINH_XA: getData2EditDuBaoThoiTietTinhXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_THOITIETHUYEN_XA: getData2EditThoiTietHuyenXa(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_SOLIEUTHIENDICH: getData2EditSoLieuThienDich(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_SOLIEUVISINHVAT: getData2EditSoLieuViSinhVat(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_SOLIEUPHANBON: getData2EditSoLieuPhanBon(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_SOLIEUTHUOCBVTV: getData2EditSoLieuThuocBVTV(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_SOLIEUHIENTUONGGAYHAI: getData2EditSoLieuHienTuongGayHai(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_SOLIEUGIONGLUA: getData2EditSoLieuGiongLua(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_SOLIEUDICHBENH: getData2EditSoLieuDichBenh(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_SOLIEUSAUHAI: getData2EditSoLieuSauHai(dbo, request, writeResponse); break;
			    case Definitions.ACT_GET_DATA_TO_EDIT_DOTTHIENTAI: getData2EditSoLieuDotThienTai(dbo, request, writeResponse); break;

			    case Definitions.ACT_UPDATE_EDITING_CANHDONG: updateEditingCanhdong(dbo, request, writeResponse); break;
			    case Definitions.ACT_EXEC_SQL_FROM_CLIENT: execSQLByClient(dbo, request, writeResponse); break;
			    case Definitions.ACT_DB_GET_DATA_DYNAMIC:getDataDynamic(dbo, request, writeResponse); break;
			    case Definitions.ACT_DB_UPDATE_DATAGRID:execUpdateDataGrid(dbo, request, writeResponse);break;

			    case Definitions.ACT_DB_GET_DIENTICH_GIEOCAY:getDientichGieocay(dbo, request, writeResponse);break;

			    case Definitions.ACT_GET_DATA_TO_VIENTHAM_IMAGE:getVienthamImageInfo(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_LIST_XAID_SAME_SINHTHAI:getListXaIDHasSameSinhthai(dbo, request, writeResponse);break;

			    case Definitions.ACT_CHECK_GIONGLUA_GIEOCAY:checkGiongluaGieocay(dbo, request, writeResponse);break;
			    case Definitions.ACT_GET_DATA_USERLIST:getData2EditUser(dbo, request, writeResponse);break;

			    case Definitions.TEST:{
			    	MainWebGUI m = new MainWebGUI();
			    	m.TEST(dbo,writeResponse);
			    	break;
			    	}
			    default:System.err.println("UNKNOW ACTION");
			    	break;

			}


		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	protected void updateCanhdongIDforTblRuongRegion(DBOperation dbo, HttpServletRequest request, PrintWriter response){
		Statement st=null;
		Connection conn = dbo.getConnection();
		String finalSQL = "";
		try {
			//LogWriter.getDBLogger().info(this.userName + " is loading package-package connection data...");
			String sql = null;
			ResultSet rs = null;
			conn.setAutoCommit(false);

			System.out.println("Starting re-update canhdong...");
			sql = //" SELECT user_xa,user_quyen,user_ten FROM tbl_user WHERE user_account ='" + request.getParameter("username") + "' AND user_password='" + request.getParameter("password") + "'";
		   " SELECT canhdong_id, ruong_id FROM tbl_canhdong_region";
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			// Add objects contained in the result set into one

			int nerrors =1;
			Hashtable map = new Hashtable();
			while (rs.next()){
					int canhdong_id    =  rs.getInt("canhdong_id");
					String ruong_id = rs.getString("ruong_id");
					if (ruong_id==null ||ruong_id.equalsIgnoreCase("null")){
						System.err.println(nerrors+".ruong_id = "+ruong_id +",canhdong_id="+canhdong_id);
						nerrors++;
						continue;
					}

					if (ruong_id.endsWith(",")) ruong_id = ruong_id.substring(0,ruong_id.length()-1);
					ruong_id=ruong_id.trim();
					if(ruong_id.equalsIgnoreCase("")) continue;
					map.put(canhdong_id, ruong_id);
			}



			rs.close();
			System.out.println("Updating, please wait...");
			Enumeration ek = map.keys();
			Enumeration ev = map.elements();
			int n =1;
			while(ek.hasMoreElements()){
				int canhdongid = (Integer)ek.nextElement();
				String ruongids= (String)ev.nextElement();
			    finalSQL = "UPDATE tbl_ruong_region SET canhdong_id="+canhdongid +" WHERE ruong_id IN (" +ruongids+");";
				if (n%1000==0){
					System.out.println(n+"."+finalSQL);
				}
				n++;
				int ret = st.executeUpdate(finalSQL);
				if (ret <=0){
					System.out.println("Some record not updated!");
				}
			}

			conn.commit();
			st.close();

			System.out.println("DONE!");


		} catch (SQLException e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			try {
				System.err.println("Rolling back...");
				System.err.println("Error SQL :"+finalSQL);
				conn.rollback();
				st.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			e.printStackTrace();
			//response.print(new JResult(Definitions.DB_STR_FAILED, e));
		} catch (Exception e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			e.printStackTrace();
			//response.print(new JResult(Definitions.DB_STR_FAILED, e));
		}
		return;
	}

	protected void reDistributeAllTTGC(DBOperation dbo){
		Connection conn = dbo.getConnection();
		Statement st = null;
		String sql ="";
		ResultSet rs = null;

		String vulua = "1";
		String eti = "15520";//"15705" ->31/12/2012, 15340 -> 01/01/2012
		String sti = "15250";//"15250" ->01/10/2011


		 vulua = "2";
		 sti = "15340";//"15705" ->31/12/2012, 15340 -> 01/01/2012
		 eti = "15705";

		try {
			st = conn.createStatement();
			conn.setAutoCommit(false);
			PhanboCanhdongServlet pb = new PhanboCanhdongServlet();
			sql =
			"		select ttgc_cd_canhdong_id, tbl_canhdong_region.xa_id as xa_id "+
			"		from tbl_ttgc_canhdong"+
			"		inner join tbl_canhdong_region on tbl_canhdong_region.canhdong_id=tbl_ttgc_canhdong.ttgc_cd_canhdong_id"+
			"		where ttgc_cd_vulua="+vulua+
			"		and ttgc_cd_ngaygieocay >="+sti+
			"		and ttgc_cd_ngaygieocay <="+eti+
			"		group by ttgc_cd_canhdong_id, tbl_canhdong_region.xa_id";

			rs = st.executeQuery(sql);

			while(rs.next()){
				String canhdong_id = String.valueOf(rs.getInt("ttgc_cd_canhdong_id"));
				String xa_id = String.valueOf(rs.getInt("xa_id"));
				String condition
				  = " ttgc_cd_vulua="+vulua+
						" AND " +
						" ttgc_cd_canhdong_id="+canhdong_id+
						" AND "+
						" ttgc_cd_ngaygieocay >="+sti + " AND ttgc_cd_ngaygieocay<="+eti;

				pb.phanboCanhdongTTGC(dbo, xa_id,  canhdong_id, vulua,  sti, eti, condition);

			}
			rs.close();
			sql=
			" select pb_lua_xa as xa_id from tbl_ttgc_xa"+
			" where pb_lua_vu="+vulua+
			" and pb_lua_ngaybatdau >="+sti+
			" and pb_lua_ngaybatdau <= "+eti+
			" group by pb_lua_xa ";
			rs = st.executeQuery(sql);

			while(rs.next()){

				String xa_id = String.valueOf(rs.getInt("xa_id"));
				String condition
				 = " pb_lua_vu="+vulua+
				" AND " +
				" pb_lua_xa="+xa_id+
				" AND "+
				" pb_lua_ngaybatdau >="+sti+ " AND pb_lua_ngaybatdau<="+eti;

				pb.phanboXaTTGC(dbo, xa_id,  vulua,  sti, eti, condition);

			}
			rs.close();
			st.close();
			conn.commit();

		} catch (SQLException e) {
			try {
				System.out.println("Rolling back...");
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	protected void reDistributeAllNS(DBOperation dbo,String vulua, String sti,String eti){
		Connection conn = dbo.getConnection();
		Statement st = null;
		String sql ="";
		ResultSet rs = null;


		try {
			st = conn.createStatement();
			conn.setAutoCommit(false);
			PhanboCanhdongServlet pb = new PhanboCanhdongServlet();
			sql =
			"		select dns_canhdong_id, tbl_canhdong_region.xa_id as xa_id "+
			"		from tbl_dong_nangsuat"+
			"		inner join tbl_canhdong_region on tbl_canhdong_region.canhdong_id=tbl_dong_nangsuat.dns_canhdong_id"+
			"		where dns_vulua="+vulua+
			"		and dns_ngaydieutra >="+sti+
			"		and dns_ngaydieutra <="+eti+
			"		group by dns_canhdong_id, tbl_canhdong_region.xa_id";

			rs = st.executeQuery(sql);

			while(rs.next()){
				String canhdong_id = String.valueOf(rs.getInt("dns_canhdong_id"));
				String xa_id = String.valueOf(rs.getInt("xa_id"));
				String condition
				  = " dns_vulua="+vulua+
						" AND " +
						" dns_canhdong_id="+canhdong_id+
						" AND "+
						" dns_ngaydieutra >="+sti + " AND dns_ngaydieutra<="+eti;

				pb.phanboCanhdongNS(dbo, xa_id,  canhdong_id, vulua,  sti, eti, condition);

			}
			rs.close();
			sql=
			" select xa_id from tbl_xa_nangsuat"+
			" where vu_lua="+vulua+
			" and xa_nangsuat_ngaydieutra >="+sti+
			" and xa_nangsuat_ngaydieutra <= "+eti+
			" group by xa_id ";
			rs = st.executeQuery(sql);

			while(rs.next()){

				String xa_id = String.valueOf(rs.getInt("xa_id"));
				String condition
				 = " vu_lua="+vulua+
				" AND " +
				" xa_id="+xa_id+
				" AND "+
				" xa_nangsuat_ngaydieutra >="+sti+ " AND xa_nangsuat_ngaydieutra<="+eti;

				pb.phanboXaNS(dbo, xa_id,  vulua,  sti, eti, condition);

			}
			rs.close();
			st.close();

		} catch (SQLException e) {
			try {
				System.out.println("Rolling back...");
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	protected void reDistributeAllHTL(DBOperation dbo,String vulua, String sti,String eti){
		Connection conn = dbo.getConnection();
		Statement st = null;
		String sql ="";
		ResultSet rs = null;

		try {
			st = conn.createStatement();
			conn.setAutoCommit(false);
			PhanboCanhdongServlet pb = new PhanboCanhdongServlet();
			sql =
			"		select dht_canhdong_id, tbl_canhdong_region.xa_id as xa_id "+
			"		from tbl_dong_ht_lua"+
			"		inner join tbl_canhdong_region on tbl_canhdong_region.canhdong_id=tbl_dong_ht_lua.dht_canhdong_id"+
			"		where dht_vulua="+vulua+
			"		and dht_ngaydieutra >="+sti+
			"		and dht_ngaydieutra <="+eti+
			"		group by dht_canhdong_id, tbl_canhdong_region.xa_id";

			rs = st.executeQuery(sql);

			while(rs.next()){
				String canhdong_id = String.valueOf(rs.getInt("dht_canhdong_id"));
				String xa_id = String.valueOf(rs.getInt("xa_id"));
				String condition
				  = " dht_vulua="+vulua+
						" AND " +
						" dht_canhdong_id="+canhdong_id+
						" AND "+
						" dht_ngaydieutra >="+sti + " AND dht_ngaydieutra<="+eti;

				pb.phanboCanhdongHTL(dbo, xa_id,  canhdong_id, vulua,  sti, eti, condition);

			}
			rs.close();
			sql=
			" select lua_group_xa as xa_id from tbl_lua_group"+
			" where lua_group_vulua_id="+vulua+
			" and lua_group_ngaydieutra >="+sti+
			" and lua_group_ngaydieutra <= "+eti+
			" group by lua_group_xa ";
			rs = st.executeQuery(sql);

			while(rs.next()){

				String xa_id = String.valueOf(rs.getInt("xa_id"));
				String condition
				 = " lua_group_vulua_id="+vulua+
				" AND " +
				" lua_group_xa="+xa_id+
				" AND "+
				" lua_group_ngaydieutra >="+sti+ " AND lua_group_ngaydieutra<="+eti;

				pb.phanboXaHTL(dbo, xa_id,  vulua,  sti, eti, condition);

			}
			rs.close();
			st.close();
			conn.commit();

		} catch (SQLException e) {
			try {
				System.out.println("Rolling back...");
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	protected void reDistributeAllTTTT(DBOperation dbo){
		Connection conn = dbo.getConnection();
		Statement st = null;
		String sql ="";
		ResultSet rs = null;

		String vulua = "1";
		String eti = "15705";
		String sti = "15279";//convertInt2DateString(15279); 01/01/2012 - 61 ngay
		try {
			st = conn.createStatement();
			conn.setAutoCommit(false);
			PhanboCanhdongServlet pb = new PhanboCanhdongServlet();
		/*	sql =
			"		select dht_canhdong_id, tbl_canhdong_region.xa_id as xa_id "+
			"		from tbl_dong_ht_lua"+
			"		inner join tbl_canhdong_region on tbl_canhdong_region.canhdong_id=tbl_dong_ht_lua.dht_canhdong_id"+
			"		where dht_vulua="+vulua+
			"		and dht_ngaydieutra >="+sti+
			"		and dht_ngaydieutra <="+eti+
			"		group by dht_canhdong_id, tbl_canhdong_region.xa_id";

			rs = st.executeQuery(sql);

			while(rs.next()){
				String canhdong_id = String.valueOf(rs.getInt("dht_canhdong_id"));
				String xa_id = String.valueOf(rs.getInt("xa_id"));
				String condition
				  = " dht_vulua="+vulua+
						" AND " +
						" dht_canhdong_id="+canhdong_id+
						" AND "+
						" dht_ngaydieutra >="+sti + " AND dht_ngaydieutra<="+eti;

				pb.phanboCanhdongTTTT(dbo, xa_id,  canhdong_id, vulua,  sti, eti, condition);

			}
			rs.close();*/
			sql=
			" select ht_thientai_xa as xa_id from tbl_ht_thientai"+
			" where "+//lua_group_vulua_id="+vulua+
			" ht_thientai_ngaydieutra >="+sti+
			" and ht_thientai_ngaydieutra <= "+eti+
			" group by ht_thientai_xa ";
			rs = st.executeQuery(sql);

			while(rs.next()){

				String xa_id = String.valueOf(rs.getInt("xa_id"));
				String condition
				 = //" lua_group_vulua_id="+vulua+
				//" AND " +
				" ht_thientai_xa="+xa_id+
				" AND "+
				" ht_thientai_ngaydieutra >="+sti+ " AND ht_thientai_ngaydieutra<="+eti;

				pb.phanboXaTTTT(dbo, xa_id,  vulua,  sti, eti, condition);

			}
			rs.close();
			st.close();

		} catch (SQLException e) {
			try {
				System.out.println("Rolling back...");
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	protected void reDistributeAllDTN(DBOperation dbo,String vulua, String sti,String eti){
		Connection conn = dbo.getConnection();
		Statement st = null;
		String sql ="";
		ResultSet rs = null;

		try {
			st = conn.createStatement();
			conn.setAutoCommit(false);
			PhanboCanhdongServlet pb = new PhanboCanhdongServlet();
			sql =
			"		select ddtn_canhdong_id, tbl_canhdong_region.xa_id as xa_id "+
			"		from tbl_dong_dientichnhiem"+
			"		inner join tbl_canhdong_region on tbl_canhdong_region.canhdong_id=tbl_dong_dientichnhiem.ddtn_canhdong_id"+
			"		where ddtn_vulua="+vulua+
			"		and ddtn_ngaydieutra >="+sti+
			"		and ddtn_ngaydieutra <="+eti+
			"		group by ddtn_canhdong_id, tbl_canhdong_region.xa_id";

			rs = st.executeQuery(sql);

			while(rs.next()){
				String canhdong_id = String.valueOf(rs.getInt("ddtn_canhdong_id"));
				String xa_id = String.valueOf(rs.getInt("xa_id"));
				String condition
				  = " ddtn_vulua="+vulua+
						" AND " +
						" ddtn_canhdong_id="+canhdong_id+
						" AND "+
						" ddtn_ngaydieutra >="+sti + " AND ddtn_ngaydieutra<="+eti;

				pb.phanboCanhdongDTN(dbo, xa_id,  canhdong_id, vulua,  sti, eti, condition);

			}
			rs.close();
			sql=
			" select ht_lua_xa as xa_id from tbl_ht_lua"+
			" where ht_lua_vulua="+vulua+
			" and ht_lua_tg >="+sti+
			" and ht_lua_tg <= "+eti+
			" group by ht_lua_xa ";
			rs = st.executeQuery(sql);

			while(rs.next()){

				String xa_id = String.valueOf(rs.getInt("xa_id"));
				String condition
				 = " ht_lua_vulua="+vulua+
				" AND " +
				" ht_lua_xa="+xa_id+
				" AND "+
				" ht_lua_tg >="+sti+ " AND ht_lua_tg<="+eti;

				pb.phanboXaDTN(dbo, xa_id,  vulua,  sti, eti, condition);

			}
			rs.close();
			st.close();
			conn.commit();

		} catch (SQLException e) {
			try {
				System.out.println("Rolling back...");
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	protected void recalc_shapeare(DBOperation dbo)
	{
		System.out.println("recalcing shape are for tbl_ruong_region...");
		Connection conn = dbo.getConnection();
		Statement st = null;
		String sql ="";
		ResultSet rs = null;

		try {
			st = conn.createStatement();
			conn.setAutoCommit(false);

			sql = "select ruong_id, ST_Area(the_geom) as dien_tich from tbl_ruong_region where shape_area is NULL";
			rs = st.executeQuery(sql);
			  Hashtable<Integer, Float> map = new  Hashtable<Integer, Float>();
			while(rs.next()){
				int ruongid= rs.getInt("ruong_id");
				float dt = rs.getFloat("dien_tich");
				map.put(ruongid, dt);


			}
			System.out.println("Total row: " + map.size());

			rs.close();


			 Enumeration<Float> enumV = map.elements();
			 Enumeration<Integer> enumK = map.keys();
				while (enumK.hasMoreElements()) {

					//System.out.println(enumK.nextElement() + ":" + enumV.nextElement());
					sql = "update tbl_ruong_region set shape_area="+enumV.nextElement() +" WHERE ruong_id="+enumK.nextElement();
					 st.executeUpdate(sql);
				}
			/*for(int i = 0 ;i < map.size(); i++)
			{
				sql = "update tbl_ruong_region set shape_area="+map
			}*/
				st.close();
			conn.commit();
			System.out.println("....OK!");
		} catch (SQLException e) {
			try {
				System.out.println("Rolling back...");
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	protected void adminAction(DBOperation dbo){

		/*
		 * String sti = "15250";
		 * String eti = "15520";//"15705" ->31/12/2012, 15340 -> 01/01/2012
		//"15250" ->01/10/2011


		 vulua = "2";
		 sti = "15340";//"15705" ->31/12/2012, 15340 -> 01/01/2012
		 eti = "15705";	*/
		//reDistributeAllTTGC(dbo);


		//reDistributeAllHTL(dbo,"1","15250","15520");
		//reDistributeAllHTL(dbo,"2","15340","15705");

		//reDistributeAllDTN(dbo,"1","15250","15520");
		//reDistributeAllDTN(dbo,"2","15340","15705");


		//reDistributeAllNS(dbo,"1","15250","15520");
		//reDistributeAllNS(dbo,"2","15340","15705");


		//reDistributeAllTTTT(dbo);

		//recalc shape are
		recalc_shapeare(dbo);
	}
	protected String login(DBOperation dbo, HttpServletRequest request, PrintWriter response){

		//updateCanhdongIDforTblRuongRegion(dbo,request,response);
		System.err.println("login...");
		Connection conn = dbo.getConnection();
		try {
			//LogWriter.getDBLogger().info(this.userName + " is loading package-package connection data...");
			String sql = null;
			ResultSet rs = null;

			sql = //" SELECT user_xa,user_quyen,user_ten FROM tbl_user WHERE user_account ='" + request.getParameter("username") + "' AND user_password='" + request.getParameter("password") + "'";
		   " select "+
		   " tbl_user.user_viewvt_tinh,"+
		   " tbl_user.user_viewvt_huyen,"+
		   " tbl_user.user_viewvt_xa,"+
		   " tbl_user.user_viewvt_dbscl,"+
		   " tbl_user.user_id,"+
		   " tbl_user.user_xa,"+
		   " tbl_user.user_quyen,"+
		   " tbl_user.user_ten,"+
		   " tbl_xa_region.xa_id,"+
		   " tbl_xa_region.ten_xa,"+
		   " tbl_xa_region.huyen_id AS xa_huyenid,"+
		   " tbl_xa_region.tinh_id AS xa_tinhid,"+
		   " tbl_huyen_region.huyen_id,"+
		   " tbl_huyen_region.tinh_id AS huyen_tinhid,"+
		   " tbl_huyen_region.ten_huyen,"+
		   " tbl_tinh_region.tinh_id,"+
		   " tbl_tinh_region.ten_tinh"+
		   " From tbl_user"+
		   " LEFT JOIN  tbl_xa_region on tbl_xa_region.xa_id=tbl_user.user_xa"+
		   " LEFT JOIN  tbl_huyen_region on tbl_huyen_region.huyen_id=tbl_user.user_xa"+
		   " LEFT JOIN  tbl_tinh_region on tbl_tinh_region.tinh_id=tbl_user.user_xa"+
		   " WHERE user_account ='" + request.getParameter("username") + "' AND user_password='" + request.getParameter("password") + "'";
			Statement st = conn.createStatement();
			rs = st.executeQuery(sql);
			// Add objects contained in the result set into one
			JSONObject json = null;
			json = new JSONObject();
			json.put("user_id", "-1");
			json.put("user_viewvt_dbscl", "0");
			json.put("user_viewvt_tinh", "0");
			json.put("user_viewvt_huyen", "0");
			json.put("user_viewvt_xa", "0");
			json.put("user_diaphuong_id", "-1");
			json.put("role","-1");
			json.put("ten", "");
			json.put("xa_id", -1);
			json.put("huyen_id", -1);
			json.put("tinh_id", -1);
			int user_id = -1;
			int role=-1;
			while (rs.next())
			{
					user_id = rs.getInt("user_id");
					int lanhtho_id = rs.getInt("user_xa");
					String username = rs.getString("user_ten");
					role =rs.getInt("user_quyen");

					int xa_huyenid   =  rs.getInt("xa_huyenid");
					int xa_tinhid    =  rs.getInt("xa_tinhid");
					int huyen_tinhid = rs.getInt("huyen_tinhid");

					int xa_id    =  rs.getInt("xa_id");
					int huyen_id =  rs.getInt("huyen_id");
					int tinh_id  = rs.getInt("tinh_id");


					//System.out.println("xa_huyenid:"+xa_huyenid+",xa_tinhid:"+xa_tinhid+", huyen_tinhid:"+huyen_tinhid);
					//System.out.println("xa_id:"+xa_id+",huyen_id:"+huyen_id+", tinh_id:"+tinh_id);
					json.put("user_viewvt_tinh", rs.getInt("user_viewvt_tinh"));
					json.put("user_viewvt_huyen", rs.getInt("user_viewvt_huyen"));
					json.put("user_viewvt_xa", rs.getInt("user_viewvt_xa"));
					json.put("user_viewvt_dbscl", rs.getInt("user_viewvt_dbscl"));

					json.put("user_id", user_id);
					json.put("ten", username);
					json.put("role",role);
					json.put("xa_id",xa_id);
					json.put("huyen_id",huyen_id+xa_huyenid);
					json.put("tinh_id",tinh_id+huyen_tinhid+xa_tinhid);
					System.out.println("xa_id:"+xa_id+",huyen_id:"+(huyen_id+xa_huyenid)+", tinh_id:"+(tinh_id+huyen_tinhid+xa_tinhid));

			}
			st.close();
			rs.close();
			if (user_id != -1)
				response.print(new JResult(Definitions.DB_STR_OK, json.toJSONString()));
			else
				response.print(new JResult(Definitions.DB_STR_FAILED, json.toJSONString()));

			if (role == 999){
				//
				System.out.println("Run action by admin...");
				adminAction(dbo);
			}

			return Definitions.DB_STR_OK;
		} catch (SQLException e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			e.printStackTrace();
			response.print(new JResult(Definitions.DB_STR_FAILED, e));
			return Definitions.DB_STR_FAILED;
		} catch (Exception e) {
			//LogWriter.getDBLogger().error(
			//		"Get package-package connection failed. Exception: " + e.getMessage());
			//throw e;
			e.printStackTrace();
			response.print(new JResult(Definitions.DB_STR_FAILED, e));
			return Definitions.DB_STR_FAILED;
		}
	}

	//FUNCTIONS PROCESSING DATA
	public void getSauhai2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		System.out.println("getSauhai2Cbb...");
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		System.out.println("prefix_to_name="+prefix_to_name);
		System.out.println("prefix_to_id="+prefix_to_id);
		String s = dop.getSauhai2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		System.out.println("data: "+ s);
		writeResponse.print(s);
	}
	public void getTinh2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		System.err.println("topsymbol="+topsymbol);
		String s = dop.getTinh2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	public void getHuyen2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol =request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getHuyen2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	public void getXa2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getXa2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	public void getListRuongIDSameCanhdong(DBOperation dbo,  HttpServletRequest request, PrintWriter writeResponse){
		  MainWebGUI maiWebGUI = new MainWebGUI();
		  String lstID = maiWebGUI.getListIDRuongCungCanhDongOnMap(dbo, Float.parseFloat(request.getParameter("x")), Float.parseFloat(request.getParameter("y")));
		  writeResponse.print(lstID);
		 //	System.out.println(obj.toString());
	 }
	public void getDataCanhdongForXa(DBOperation dbo,  HttpServletRequest request, PrintWriter writeResponse){
		  MainWebGUI maiWebGUI = new MainWebGUI();
		  String data = maiWebGUI.getDataCanhdongForXa(dbo
				  , Integer.parseInt(request.getParameter("xa_id"))
				  , Boolean.parseBoolean(request.getParameter("hasGeometry")));
		  writeResponse.print(data);
		 //	System.out.println(obj.toString());
	 }

	public void getBBoxOfArea(DBOperation dbo,  HttpServletRequest request, PrintWriter writeResponse){

	 	MainWebGUI maiWebGUI = new MainWebGUI();
		String strBoundingBox = maiWebGUI.getBoundingBox(dbo, Integer.parseInt(request.getParameter("tinh_id"))
											, Integer.parseInt(request.getParameter("huyen_id"))
											, Integer.parseInt(request.getParameter("xa_id")));
		writeResponse.print(strBoundingBox);

	}
	public void getGeometryOfTinhHuyenXa(DBOperation dbo,  HttpServletRequest request, PrintWriter writeResponse){

	 	MainWebGUI maiWebGUI = new MainWebGUI();
		String strGeometry = maiWebGUI.getGeometryOfTinhHuyenXa(dbo, Integer.parseInt(request.getParameter("tinh_id"))
											, Integer.parseInt(request.getParameter("huyen_id"))
											, Integer.parseInt(request.getParameter("xa_id"))
											,Integer.parseInt(request.getParameter("type")));//Well-known Text or WKB
		writeResponse.print(strGeometry);

	}

	public void getGionglua2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		System.out.println("prefix_to_id ="+prefix_to_id);
		String s = dop.getGionglua2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getTralua2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getTralua2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	public void getVulua2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getVulua2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}
	public void getLoailua2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getLoailua2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}
	public void getListHienTuongGayHai2ComboHtml(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgDieutraXa dlgTTGC = new DlgDieutraXa();
		String s = (String)dlgTTGC.getListHienTuongGayHai2ComboHtml(dbo, null, true);
		writeResponse.print(s);
	}
	public void getListKhangSau2ComboHtml(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgDieutraXa dlgTTGC = new DlgDieutraXa();
		String s = (String)dlgTTGC.getListKhangSau2ComboHtml(dbo, null, true);
		writeResponse.print(s);
	}
	public void getListKhangBenh2ComboHtml(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgDieutraXa dlgTTGC = new DlgDieutraXa();
		String s = (String)dlgTTGC.getListKhangBenh2ComboHtml(dbo, null, true);
		writeResponse.print(s);
	}
	public void getListThienDich2ComboHtml(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgDieutraXa dlgTTGC = new DlgDieutraXa();
		String s = (String)dlgTTGC.getListThienDich2ComboHtml(dbo, null, true);
		writeResponse.print(s);
	}
	public void getListThuoc2ComboHtml(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgDieutraXa dlgTTGC = new DlgDieutraXa();
		String s = (String)dlgTTGC.getListThuoc2ComboHtml(dbo, null, true);
		writeResponse.print(s);
	}
	public void getListViSinhVat2ComboHtml(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgDieutraXa dlgTTGC = new DlgDieutraXa();
		String s = (String)dlgTTGC.getListViSinhVat2ComboHtml(dbo, null, true);
		writeResponse.print(s);
	}
	public void  insertThongtinGieocay2DB(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		System.out.println("insertThongtinGieocay2DB...");
		/*DlgThongtinGieocayRM dlgTTGC = new DlgThongtinGieocayRM();
		int ret = dlgTTGC.insertThongtinGieocay2DB(dbo, request.getParameter("object"), null);
		writeResponse.print("ret");
		*/
	}
	public void  insertObject2DB(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		System.out.println("insertObject2DB...");
	//	int ret = dbo.insertObject2DB(/*single/multiple SQL query */request.getParameter("sqlquery"),/*isReturnID */Boolean.parseBoolean(request.getParameter("hasReturnID")), /*id name will returned*/request.getParameter("id"));
	//	writeResponse.print(String.valueOf(ret));
	}

	public void  execInsertUpdatedMultiRecords2DBByClient(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		System.out.println("execInsertUpdatedMultiRecords2DBByClient...");
		String ret = dbo.execInsertUpdatedMultiRecords2DBByClient(
				/*single/multiple SQL query */request.getParameter("sqlquery")
				,/*condition */request.getParameter("condition")
				,/*values */request.getParameter("values")
				,/*sql type order in query */request.getParameter("sqlTypeOrder")
				,/*ids */request.getParameter("ids")
				);
		writeResponse.print(ret);
	}

	public void getThientai2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getThientai2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	public void getThiendich2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getThiendich2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}



	public void getData2ShowThongtinGieocayRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraRuong dtr = new DlgDieutraRuong();
		String s = (String)dtr.getData2ShowThongtinGieocayRuong(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);

	}
	public void getData2ShowThongtinThitruong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraHuyen dth = new DlgDieutraHuyen();
		String s = (String)dth.getData2ShowThongtinThitruong(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);

	}
	public void getData2ShowThongtinGieocayRuongOnPropertyGrid(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		int  page = 1;
		int  rows = 1;

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraRuong dtr = new DlgDieutraRuong();
		String s = (String)dtr.getData2ShowThongtinGieocayRuongOnPropertyGrid(dbo, -1, -1, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);

	}
	public void getData2ShowHientrangLuaRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraRuong dtr = new DlgDieutraRuong();
		String s = (String)dtr.getData2ShowHientrangLuaRuong(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);

	}
	public void getData2ShowThongtinSauhaiRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraRuong dtr = new DlgDieutraRuong();
		String s = (String)dtr.getData2ShowThongtinSauhai(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}
	public void getData2ShowThongtinThientaiRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraRuong dtr = new DlgDieutraRuong();
		String s = (String)dtr.getData2ShowThongtinThientaiRuong(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2ShowThongtinSauhaiCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
		String s = (String)dtcd.getData2ShowThongtinSauhaiCanhdong(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}
	public void getData2ShowThongtinBenhhaiCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total   = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page    = Integer.parseInt(request.getParameter("page"));
		int  rows    = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
		String s = (String)dtcd.getData2ShowThongtinBenhhaiCanhdong(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}
	public void getData2ShowThongtinGieocayCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse)
			throws SQLException {
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));
		//if ("null".equalsIgnoreCase(request.getParameter("records"))) total = -1;

		int  total = -1;//Integer.parseInt(request.getParameter("total"));
		int  records = -1;//Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
		String s = (String)dtcd.getData2ShowThongtinGieocayCanhdongInline(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);

	}
	public void getData2ShowThongtinThientaiCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
		String s = (String)dtcd.getData2ShowThongtinThientaiCanhdong(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);

	}
	//inline
	public void getData2AddThongtinThientaiCanhdongInline(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = -1;//Integer.parseInt(request.getParameter("total"));
		int  records = -1;// Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
		String s = (String)dtcd.getData2AddThongtinThientaiCanhdongInline(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);

	}
	public void getData2AddThongtinDientichNhiemCanhdongInline(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = -1;//Integer.parseInt(request.getParameter("total"));
		int  records = -1;// Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
		String s = (String)dtcd.getData2AddThongtinDientichNhiemCanhdongInline(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);

	}

	public void getData2AddHientrangLuaCanhdongInline(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = -1;//Integer.parseInt(request.getParameter("total"));
		int  records = -1;// Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
		String s = (String)dtcd.getData2AddHientrangLuaCanhdongInline(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);

	}




	public void getData2ShowThongtinBenhhaiRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraRuong dtr = new DlgDieutraRuong();
		String s = (String)dtr.getData2ShowThongtinBenhhaiRuong(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}


	public void getGeometryByIntersection(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		String geomWKT = request.getParameter("geomWKT");
		int type = Integer.parseInt(request.getParameter("type"));
		String idName = request.getParameter("id");
		String tableName = request.getParameter("table");
		String fidExcepted = request.getParameter("fidExcepted");
		MainWebGUI m =  new MainWebGUI();
		writeResponse.print(m.getGeometryByIntersection(dbo,geomWKT, type, idName, tableName,fidExcepted));


	}
	public void getIDByIntersection(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		String geomWKT = request.getParameter("geomWKT");
		String idName = request.getParameter("id");
		String name = request.getParameter("name");
		String tableName = request.getParameter("table");
		MainWebGUI m =  new MainWebGUI();
		writeResponse.print(m.getIDByIntersection(dbo,geomWKT, idName, name, tableName));


	}



	public void getPreCachedGeometry(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		int type = Integer.parseInt(request.getParameter("type"));
		String idName = request.getParameter("id");
		String tableName = request.getParameter("table");
		String condition = request.getParameter("condition");

		String fidExcepted = request.getParameter("fidExcepted");
		MainWebGUI m =  new MainWebGUI();
		writeResponse.print(m.getPreCachedGeometry(dbo,condition, type, idName, tableName,fidExcepted));


	}

	public int getData2EditThongtinGieocayRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraRuong dtr = new DlgDieutraRuong();
		writeResponse.print(dtr.getData2EditThongtinGieocayRuong(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}
	/* */
	public int getData2EditThongtinGieocayCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
		writeResponse.print(dtcd.getData2EditThongtinGieocayCanhdong(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}
	public int getData2EditHientrangLuaRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraRuong m = new DlgDieutraRuong();
		writeResponse.print(m.getData2EditHientrangLuaRuong(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}
///[BEGIN]///
public int getData2EditThongtinThitruong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraHuyen dth = new DlgDieutraHuyen();
		writeResponse.print(dth.getData2EditThongtinThitruong(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}
public int getData2EditThoitiettuan(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

	DlgDieutraHuyen dth = new DlgDieutraHuyen();
	writeResponse.print(dth.getData2EditThoitiettuan(dbo, request.getParameter("condition")));
	return Definitions.DB_INT_OK;
}
public void getData2ShowThoitiettuan(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
	System.out.println("page=" + request.getParameter("page"));
	System.out.println("rows=" + request.getParameter("rows"));
	System.out.println("total=" + request.getParameter("total"));
	System.out.println("records=" + request.getParameter("records"));

	int  total = Integer.parseInt(request.getParameter("total"));
	int  records = Integer.parseInt(request.getParameter("records"));
	int  page = Integer.parseInt(request.getParameter("page"));
	int  rows = Integer.parseInt(request.getParameter("rows"));

	String  condition = request.getParameter("condition");
	int limit = rows;
	int offset = (page - 1)*rows;

	DlgDieutraHuyen dth = new DlgDieutraHuyen();
	String s = (String)dth.getData2ShowThoitiettuan(dbo, total, records, limit, offset, condition, true);
	System.err.println(s);
	writeResponse.print(s);

}
/////////[BEGIN mật độ sâu]/////////////
public int getData2EditMatdoSauhaiRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

	DlgDieutraRuong dtr = new DlgDieutraRuong();
	writeResponse.print(dtr.getData2EditMatdoSauhaiRuong(dbo, request.getParameter("condition")));
	return Definitions.DB_INT_OK;
}
public int getData2EditMatdoSauhaiCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

	DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
	writeResponse.print(dtcd.getData2EditMatdoSauhaiCanhdong(dbo, request.getParameter("condition")));
	return Definitions.DB_INT_OK;
}

public void getData2ShowMatdoSauhaiCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
	System.out.println("page=" + request.getParameter("page"));
	System.out.println("rows=" + request.getParameter("rows"));
	System.out.println("total=" + request.getParameter("total"));
	System.out.println("records=" + request.getParameter("records"));

	int  total   = Integer.parseInt(request.getParameter("total"));
	int  records = Integer.parseInt(request.getParameter("records"));
	int  page    = Integer.parseInt(request.getParameter("page"));
	int  rows    = Integer.parseInt(request.getParameter("rows"));

	String  condition = request.getParameter("condition");
	int limit = rows;
	int offset = (page - 1)*rows;

	DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
	String s = (String)dtcd.getData2ShowMatdoSauhaiCanhdong(dbo, total, records, limit, offset, condition, true);
	System.err.println(s);
	writeResponse.print(s);
}
public void getData2ShowMatdoSauhaiRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
	System.out.println("page=" + request.getParameter("page"));
	System.out.println("rows=" + request.getParameter("rows"));
	System.out.println("total=" + request.getParameter("total"));
	System.out.println("records=" + request.getParameter("records"));

	int  total   = Integer.parseInt(request.getParameter("total"));
	int  records = Integer.parseInt(request.getParameter("records"));
	int  page    = Integer.parseInt(request.getParameter("page"));
	int  rows    = Integer.parseInt(request.getParameter("rows"));

	String  condition = request.getParameter("condition");
	int limit = rows;
	int offset = (page - 1)*rows;

	DlgDieutraRuong dtr = new DlgDieutraRuong();
	String s = (String)dtr.getData2ShowMatdoSauhaiRuong(dbo, total, records, limit, offset, condition, true);
	System.err.println(s);
	writeResponse.print(s);
}
//////[END mật độ sâu]////
	public int getData2EditThongtinThientaiRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraRuong m = new DlgDieutraRuong();
		writeResponse.print(m.getData2EditThongtinThientaiRuong(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditThongtinSauhaiRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraRuong dtr = new DlgDieutraRuong();
		writeResponse.print(dtr.getData2EditThongtinSauhaiRuong(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}
	public int getData2EditThongtinSauhaiCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
		writeResponse.print(dtcd.getData2EditThongtinSauhaiCanhdong(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}
	public int getData2EditThongtinBenhhaiRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraRuong dtr = new DlgDieutraRuong();
		writeResponse.print(dtr.getData2EditThongtinBenhhaiRuong(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}
	public int getData2EditThongtinBenhhaiCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
		writeResponse.print(dtcd.getData2EditThongtinBenhhaiCanhdong(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}
	public int getData2EditThongtinThientaiCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
		writeResponse.print(dtcd.getData2EditThongtinThientaiCanhdong(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}


	public void getTuoiSau2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){

		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getTuoiSau2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);

	}

	public void getBenhhai2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol =request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getBenhhai2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}
	public void getHientrang2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol =request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getHientrang2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}
	public void getDotThientai3Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol =request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getDotThientai3Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	public void getVientham2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol =request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getVientham2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}
	public void getLoaiBando2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol =request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getLoaiBando2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}
	public void getGDSTLua2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getGDSTLua2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	public void getMucdoTheoLoaiThientai2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getMucdoTheoLoaiThientai2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	public void getCachBonPhan2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getCachBonPhan2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	public void getHuongGio2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getHuongGio2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	public void getTenThuoc2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getTenThuoc2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	public void getDotThienTai2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getDotThienTai2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	public void getPhuongphapGieocay2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getPhuongphapGieocay2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		System.err.println(s);
		writeResponse.print(s);
	}


	public void getLoaiPhan2Cbb(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getLoaiPhan2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	public void deleteRecord(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){

		String condition = request.getParameter("condition");
		String tableName = request.getParameter("tableName");
		DlgOperation dop = new DlgOperation();
		JResult jro = dop.deleteObject(dbo, tableName, condition);
		writeResponse.print(jro.toString());
	}
	public void checkDataExists(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		writeResponse.print(dop.checkDataExists(dbo,request,writeResponse));

		//return Definitions.DB_STR_OK;
		//String s = dop.checkDataExists(dbo, request, writeResponse);
		//writeResponse.print(s);
	}
	public void checkDotThientai(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		writeResponse.print(dop.checkDotThientai(dbo,request,writeResponse));

		//return Definitions.DB_STR_OK;
		//String s = dop.checkDataExists(dbo, request, writeResponse);
		//writeResponse.print(s);
	}

	public void checkDataRuong(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		writeResponse.print(dop.checkDataRuong(dbo,request,writeResponse));

		//return Definitions.DB_STR_OK;
		//String s = dop.checkDataExists(dbo, request, writeResponse);
		//writeResponse.print(s);
	}
	public void checkDataDientich(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		writeResponse.print(dop.checkDataDientich(dbo,request,writeResponse));

		//return Definitions.DB_STR_OK;
		//String s = dop.checkDataExists(dbo, request, writeResponse);
		//writeResponse.print(s);
	}
	public void checkMAX(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgOperation dop = new DlgOperation();
		writeResponse.print(dop.checkMAX(dbo,request,writeResponse));

	}
//public int getData2EditThongtinBenhhaiRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

	//	DlgDieutraRuong dtr = new DlgDieutraRuong();
	//	writeResponse.print(dtr.getData2EditThongtinBenhhaiRuong(dbo, request.getParameter("condition")));
	//	return Definitions.DB_INT_OK;
	//}
	// Gọi hàm của Tùng
	public void getData2HienTrangLuaXaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_lua_group.lua_group_xa = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgHTL = new DlgDieutraXa();
		String s = (String)dlgHTL.getData2HienTrangLuaXaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2ThienTaiXaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_ht_thientai.ht_thientai_xa = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgTHIENTAI = new DlgDieutraXa();
		String s = (String)dlgTHIENTAI.getData2ThienTaiXaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2KQThuHoachXaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_xa_nangsuat.xa_id = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgKQTHUHOACH = new DlgDieutraXa();
		String s = (String)dlgKQTHUHOACH.getData2KQThuHoachXaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2KQThuHoachXaPhapLyForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_solieu_thongke.tinh_id = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgKQTHUHOACH = new DlgDieutraXa();
		String s = (String)dlgKQTHUHOACH.getData2KQThuHoachXaPhapLyForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2SinhthaiXaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_xa_region.huyen_id = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgSINHTHAI = new DlgDieutraXa();
		String s = (String)dlgSINHTHAI.getData2SinhthaiXaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2ThongTinGieoCayXaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_ttgc_xa.pb_lua_xa = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgTTGIEOCAY = new DlgDieutraXa();
		String s = (String)dlgTTGIEOCAY.getData2ThongTinGieoCayXaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2TyLeBenhXaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_ht_benh.ht_benh_xa = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgTYLEBENH = new DlgDieutraXa();
		String s = (String)dlgTYLEBENH.getData2TyLeBenhXaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2DienTichNhiemXaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_ht_lua.ht_lua_xa = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgDTNHIEM = new DlgDieutraXa();
		String s = (String)dlgDTNHIEM.getData2DienTichNhiemXaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2BayDenXaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_bayden.bayden_xa = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgBAYDEN = new DlgDieutraXa();
		String s = (String)dlgBAYDEN.getData2BayDenXaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2KySinhXaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_ht_kysinh.ht_kysinh_xa = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgKYSINH = new DlgDieutraXa();
		String s = (String)dlgKYSINH.getData2KySinhXaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2BatMoiAnThitXaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_ht_thiendich.ht_thiendich_xa = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgBATMOIANTHIT = new DlgDieutraXa();
		String s = (String)dlgBATMOIANTHIT.getData2BatMoiAnThitXaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2PhunThuocXaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_phunthuoc.phunthuoc_xa = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgPHUNTHUOC = new DlgDieutraXa();
		String s = (String)dlgPHUNTHUOC.getData2PhunThuocXaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2BonPhanXaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_ht_bonphan.ht_bonphan_xa = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgBONPHAN = new DlgDieutraXa();
		String s = (String)dlgBONPHAN.getData2BonPhanXaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2DuBaoThoiTietTinhXaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_thoitiet_dubao.thoitiet_dubao_tinh = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgDUBAOTHOITIETTINH = new DlgDieutraXa();
		String s = (String)dlgDUBAOTHOITIETTINH.getData2DuBaoThoiTietTinhXaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2ThoiTietHuyenXaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_thoitiet_huyen.thoitiet_huyen_ten = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgDUBAOTHOITIETHUYEN = new DlgDieutraXa();
		String s = (String)dlgDUBAOTHOITIETHUYEN.getData2ThoiTietHuyenXaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2SoLieuThienDichForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraXa dlgSOLIEUTHIENDICH = new DlgDieutraXa();
		String s = (String)dlgSOLIEUTHIENDICH.getData2SoLieuThienDichForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2SoLieuViSinhVatForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraXa dlgSOLIEUVISINHVAT = new DlgDieutraXa();
		String s = (String)dlgSOLIEUVISINHVAT.getData2SoLieuViSinhVatForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2SoLieuPhanBonForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraXa dlgSOLIEUPHANBON = new DlgDieutraXa();
		String s = (String)dlgSOLIEUPHANBON.getData2SoLieuPhanBonForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2SoLieuThuocBVTVForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraXa dlgSOLIEUTHUOCBVTV = new DlgDieutraXa();
		String s = (String)dlgSOLIEUTHUOCBVTV.getData2SoLieuThuocBVTVForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2SoLieuHienTuongGayHaiForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraXa dlgSOLIEUHTGH = new DlgDieutraXa();
		String s = (String)dlgSOLIEUHTGH.getData2SoLieuHienTuongGayHaiForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2SoLieuDichBenhForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraXa dlgSOLIEUDICHBENH = new DlgDieutraXa();
		String s = (String)dlgSOLIEUDICHBENH.getData2SoLieuDichBenhForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2SoLieuSauHaiForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraXa dlgSOLIEUSAUHAI = new DlgDieutraXa();
		String s = (String)dlgSOLIEUSAUHAI.getData2SoLieuSauHaiForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2SoLieuDotThienTaiForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraXa dlgDOTTHIENTAI = new DlgDieutraXa();
		String s = (String)dlgDOTTHIENTAI.getData2SoLieuDotThienTaiForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2SoLieuGiongLuaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));

		String  condition = request.getParameter("condition");
		int limit = rows;
		int offset = (page - 1)*rows;

		DlgDieutraXa dlgSOLIEUGIONGLUA = new DlgDieutraXa();
		String s = (String)dlgSOLIEUGIONGLUA.getData2SoLieuGiongLuaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2ThoiTietTinhXaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_thoitiet.thoitiet_tinh = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgTHOITIETTINH = new DlgDieutraXa();
		String s = (String)dlgTHOITIETTINH.getData2ThoiTietTinhXaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public void getData2MatDoSauXaForm(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
		System.out.println("page=" + request.getParameter("page"));
		System.out.println("rows=" + request.getParameter("rows"));
		System.out.println("total=" + request.getParameter("total"));
		System.out.println("records=" + request.getParameter("records"));

		int  total = Integer.parseInt(request.getParameter("total"));
		int  records = Integer.parseInt(request.getParameter("records"));
		int  page = Integer.parseInt(request.getParameter("page"));
		int  rows = Integer.parseInt(request.getParameter("rows"));
		int limit = rows;
		int offset = (page - 1)*rows;
		String condition;
		if (request.getParameter("condition")== null)
		{ condition = "tbl_ht_sau.ht_sau_xa = "+Integer.parseInt(request.getParameter("id"));}
		else { condition = request.getParameter("condition"); }

		DlgDieutraXa dlgMATDOSAU = new DlgDieutraXa();
		String s = (String)dlgMATDOSAU.getData2MatDoSauXaForm(dbo, total, records, limit, offset, condition, true);
		System.err.println(s);
		writeResponse.print(s);
	}

	public int getData2EditHienTrangLuaXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditHienTrangLuaXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditKetQuaThuHoachXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditKetQuaThuHoachXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}


	public int getData2EditKetQuaThuHoachPhapLyXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditKetQuaThuHoachPhapLyXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditSinhThaiXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditSinhThaiXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditThienTaiXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditThienTaiXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditThongTinGieoCayXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditThongTinGieoCayXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditMatDoSauXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditMatDoSauXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditTyLeBenhXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditTyLeBenhXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditDienTichNhiemXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditDienTichNhiemXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditBayDenXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditBayDenXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditKySinhXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditKySinhXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditBatMoiAnThitXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditBatMoiAnThitXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditPhunThuocXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditPhunThuocXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditBonPhanXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditBonPhanXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditThoiTietTinhXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditThoiTietTinhXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditDuBaoThoiTietTinhXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditDuBaoThoiTietTinhXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditThoiTietHuyenXa(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditThoiTietHuyenXa(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditSoLieuThienDich(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditSoLieuThienDich(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditSoLieuViSinhVat(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditSoLieuViSinhVat(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditSoLieuPhanBon(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditSoLieuPhanBon(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditSoLieuThuocBVTV(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditSoLieuThuocBVTV(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditSoLieuHienTuongGayHai(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditSoLieuHienTuongGayHai(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditSoLieuGiongLua(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditSoLieuGiongLua(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditSoLieuDichBenh(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditSoLieuDichBenh(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditSoLieuSauHai(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditSoLieuSauHai(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}

	public int getData2EditSoLieuDotThienTai(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraXa m = new DlgDieutraXa();
		writeResponse.print(m.getData2EditSoLieuDotThienTai(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}
	//[BEGIN] THÔNG TIN NĂNG SUẤT ///////
public int getData2EditThongtinNangsuatRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

		DlgDieutraRuong m = new DlgDieutraRuong();
		writeResponse.print(m.getData2EditThongtinNangsuatRuong(dbo, request.getParameter("condition")));
		return Definitions.DB_INT_OK;
	}
public void getData2ShowThongtinNangsuatRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
	System.out.println("page=" + request.getParameter("page"));
	System.out.println("rows=" + request.getParameter("rows"));
	System.out.println("total=" + request.getParameter("total"));
	System.out.println("records=" + request.getParameter("records"));

	int  total = Integer.parseInt(request.getParameter("total"));
	int  records = Integer.parseInt(request.getParameter("records"));
	int  page = Integer.parseInt(request.getParameter("page"));
	int  rows = Integer.parseInt(request.getParameter("rows"));

	String  condition = request.getParameter("condition");
	int limit = rows;
	int offset = (page - 1)*rows;

	DlgDieutraRuong dtr = new DlgDieutraRuong();
	String s = (String)dtr.getData2ShowThongtinNangsuatRuong(dbo, total, records, limit, offset, condition, true);
	System.err.println(s);
	writeResponse.print(s);
}

/// Cánh đồng
public void getData2ShowThongtinNangsuatCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
	System.out.println("page=" + request.getParameter("page"));
	System.out.println("rows=" + request.getParameter("rows"));
	System.out.println("total=" + request.getParameter("total"));
	System.out.println("records=" + request.getParameter("records"));

	int  total   = Integer.parseInt(request.getParameter("total"));
	int  records = Integer.parseInt(request.getParameter("records"));
	int  page    = Integer.parseInt(request.getParameter("page"));
	int  rows    = Integer.parseInt(request.getParameter("rows"));

	String  condition = request.getParameter("condition");
	int limit = rows;
	int offset = (page - 1)*rows;

	DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
	String s = (String)dtcd.getData2ShowThongtinNangsuatCanhdong(dbo, total, records, limit, offset, condition, true);
	System.err.println(s);
	writeResponse.print(s);
}

public int getData2EditThongtinNangsuatCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

	DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
	writeResponse.print(dtcd.getData2EditThongtinNangsuatCanhdong(dbo, request.getParameter("condition")));
	return Definitions.DB_INT_OK;
}
/////////[END] THÔNG TIN NĂNG SUẤT ///////
/////////[BEGIN] THÔNG TIN TY LỆ BỆNH ///////
public void getData2ShowTyleBenhCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
	System.out.println("page=" + request.getParameter("page"));
	System.out.println("rows=" + request.getParameter("rows"));
	System.out.println("total=" + request.getParameter("total"));
	System.out.println("records=" + request.getParameter("records"));

	int  total   = Integer.parseInt(request.getParameter("total"));
	int  records = Integer.parseInt(request.getParameter("records"));
	int  page    = Integer.parseInt(request.getParameter("page"));
	int  rows    = Integer.parseInt(request.getParameter("rows"));

	String  condition = request.getParameter("condition");
	int limit = rows;
	int offset = (page - 1)*rows;

	DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
	String s = (String)dtcd.getData2ShowTyleBenhCanhdong(dbo, total, records, limit, offset, condition, true);
	System.err.println(s);
	writeResponse.print(s);
}

public int getData2EditTyleBenhCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

	DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
	writeResponse.print(dtcd.getData2EditTyleBenhCanhdong(dbo, request.getParameter("condition")));
	return Definitions.DB_INT_OK;
}

public int getData2EditTyleBenhRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

	DlgDieutraRuong m = new DlgDieutraRuong();
	writeResponse.print(m.getData2EditTyleBenhRuong(dbo, request.getParameter("condition")));
	return Definitions.DB_INT_OK;
}
public int getData2EditThongtinKysinhRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

	DlgDieutraRuong m = new DlgDieutraRuong();
	writeResponse.print(m.getData2EditThongtinKysinhRuong(dbo, request.getParameter("condition")));
	return Definitions.DB_INT_OK;
}
public int getData2EditThongtinThiendichRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

	DlgDieutraRuong m = new DlgDieutraRuong();
	writeResponse.print(m.getData2EditThongtinThiendichRuong(dbo, request.getParameter("condition")));
	return Definitions.DB_INT_OK;
}
public void getData2ShowTyleBenhRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
System.out.println("page=" + request.getParameter("page"));
System.out.println("rows=" + request.getParameter("rows"));
System.out.println("total=" + request.getParameter("total"));
System.out.println("records=" + request.getParameter("records"));

int  total = Integer.parseInt(request.getParameter("total"));
int  records = Integer.parseInt(request.getParameter("records"));
int  page = Integer.parseInt(request.getParameter("page"));
int  rows = Integer.parseInt(request.getParameter("rows"));

String  condition = request.getParameter("condition");
int limit = rows;
int offset = (page - 1)*rows;

DlgDieutraRuong dtr = new DlgDieutraRuong();
String s = (String)dtr.getData2ShowTyleBenhRuong(dbo, total, records, limit, offset, condition, true);
System.err.println(s);
writeResponse.print(s);
}

/////////[END] THÔNG TIN TY LỆ BỆNH ///////
/////////[BEGIN] THÔNG TIN TY LỆ BỆNH + THIÊN ĐỊCH///////
public void getData2ShowThongtinKysinhRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
System.out.println("page=" + request.getParameter("page"));
System.out.println("rows=" + request.getParameter("rows"));
System.out.println("total=" + request.getParameter("total"));
System.out.println("records=" + request.getParameter("records"));

int  total = Integer.parseInt(request.getParameter("total"));
int  records = Integer.parseInt(request.getParameter("records"));
int  page = Integer.parseInt(request.getParameter("page"));
int  rows = Integer.parseInt(request.getParameter("rows"));

String  condition = request.getParameter("condition");
int limit = rows;
int offset = (page - 1)*rows;

DlgDieutraRuong dtr = new DlgDieutraRuong();
String s = (String)dtr.getData2ShowThongtinKysinhRuong(dbo, total, records, limit, offset, condition, true);
System.err.println(s);
writeResponse.print(s);
}
public void getData2ShowThongtinThiendichRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
System.out.println("page=" + request.getParameter("page"));
System.out.println("rows=" + request.getParameter("rows"));
System.out.println("total=" + request.getParameter("total"));
System.out.println("records=" + request.getParameter("records"));

int  total = Integer.parseInt(request.getParameter("total"));
int  records = Integer.parseInt(request.getParameter("records"));
int  page = Integer.parseInt(request.getParameter("page"));
int  rows = Integer.parseInt(request.getParameter("rows"));

String  condition = request.getParameter("condition");
int limit = rows;
int offset = (page - 1)*rows;

DlgDieutraRuong dtr = new DlgDieutraRuong();
String s = (String)dtr.getData2ShowThongtinThiendichRuong(dbo, total, records, limit, offset, condition, true);
System.err.println(s);
writeResponse.print(s);
}
/////////[BEGIN] THÔNG TIN DIỆN TÍCH NHIỄM ///////
public void getData2ShowDientichnhiemCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
System.out.println("page=" + request.getParameter("page"));
System.out.println("rows=" + request.getParameter("rows"));
System.out.println("total=" + request.getParameter("total"));
System.out.println("records=" + request.getParameter("records"));

int  total   = Integer.parseInt(request.getParameter("total"));
int  records = Integer.parseInt(request.getParameter("records"));
int  page    = Integer.parseInt(request.getParameter("page"));
int  rows    = Integer.parseInt(request.getParameter("rows"));

String  condition = request.getParameter("condition");
int limit = rows;
int offset = (page - 1)*rows;

DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
String s = (String)dtcd.getData2ShowDientichnhiemCanhdong(dbo, total, records, limit, offset, condition, true);
System.err.println(s);
writeResponse.print(s);
}
public void getData2ShowHientrangLuaCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
System.out.println("page=" + request.getParameter("page"));
System.out.println("rows=" + request.getParameter("rows"));
System.out.println("total=" + request.getParameter("total"));
System.out.println("records=" + request.getParameter("records"));

int  total   = Integer.parseInt(request.getParameter("total"));
int  records = Integer.parseInt(request.getParameter("records"));
int  page    = Integer.parseInt(request.getParameter("page"));
int  rows    = Integer.parseInt(request.getParameter("rows"));

String  condition = request.getParameter("condition");
int limit = rows;
int offset = (page - 1)*rows;

DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
String s = (String)dtcd.getData2ShowHientrangLuaCanhdong(dbo, total, records, limit, offset, condition, true);
System.err.println(s);
writeResponse.print(s);
}
public void getData2ShowThongtinKysinhCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
System.out.println("page=" + request.getParameter("page"));
System.out.println("rows=" + request.getParameter("rows"));
System.out.println("total=" + request.getParameter("total"));
System.out.println("records=" + request.getParameter("records"));

int  total   = Integer.parseInt(request.getParameter("total"));
int  records = Integer.parseInt(request.getParameter("records"));
int  page    = Integer.parseInt(request.getParameter("page"));
int  rows    = Integer.parseInt(request.getParameter("rows"));

String  condition = request.getParameter("condition");
int limit = rows;
int offset = (page - 1)*rows;

DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
String s = (String)dtcd.getData2ShowThongtinKysinhCanhdong(dbo, total, records, limit, offset, condition, true);
System.err.println(s);
writeResponse.print(s);
}
public void getData2ShowThongtinThiendichCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
System.out.println("page=" + request.getParameter("page"));
System.out.println("rows=" + request.getParameter("rows"));
System.out.println("total=" + request.getParameter("total"));
System.out.println("records=" + request.getParameter("records"));

int  total   = Integer.parseInt(request.getParameter("total"));
int  records = Integer.parseInt(request.getParameter("records"));
int  page    = Integer.parseInt(request.getParameter("page"));
int  rows    = Integer.parseInt(request.getParameter("rows"));

String  condition = request.getParameter("condition");
int limit = rows;
int offset = (page - 1)*rows;

DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
String s = (String)dtcd.getData2ShowThongtinThiendichCanhdong(dbo, total, records, limit, offset, condition, true);
System.err.println(s);
writeResponse.print(s);
}
public int getData2EditDientichnhiemCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
writeResponse.print(dtcd.getData2EditDientichnhiemCanhdong(dbo, request.getParameter("condition")));
return Definitions.DB_INT_OK;
}
public int getData2EditHientrangLuaCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
writeResponse.print(dtcd.getData2EditHientrangLuaCanhdong(dbo, request.getParameter("condition")));
return Definitions.DB_INT_OK;
}

public int getData2EditThongtinKysinhCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
writeResponse.print(dtcd.getData2EditThongtinKysinhCanhdong(dbo, request.getParameter("condition")));
return Definitions.DB_INT_OK;
}
public int getData2EditThongtinThiendichCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
writeResponse.print(dtcd.getData2EditThongtinThiendichCanhdong(dbo, request.getParameter("condition")));
return Definitions.DB_INT_OK;
}
public int getData2EditDientichnhiemRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

DlgDieutraRuong m = new DlgDieutraRuong();
writeResponse.print(m.getData2EditDientichnhiemRuong(dbo, request.getParameter("condition")));
return Definitions.DB_INT_OK;
}
public void getData2ShowDientichnhiemRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
System.out.println("page=" + request.getParameter("page"));
System.out.println("rows=" + request.getParameter("rows"));
System.out.println("total=" + request.getParameter("total"));
System.out.println("records=" + request.getParameter("records"));

int  total = Integer.parseInt(request.getParameter("total"));
int  records = Integer.parseInt(request.getParameter("records"));
int  page = Integer.parseInt(request.getParameter("page"));
int  rows = Integer.parseInt(request.getParameter("rows"));

String  condition = request.getParameter("condition");
int limit = rows;
int offset = (page - 1)*rows;

DlgDieutraRuong dtr = new DlgDieutraRuong();
String s = (String)dtr.getData2ShowDientichnhiemRuong(dbo, total, records, limit, offset, condition, true);
System.err.println(s);
writeResponse.print(s);
}
public int getData2EditNuocRuong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){

	DlgDieutraRuong m = new DlgDieutraRuong();
	writeResponse.print(m.getData2EditNuocRuong(dbo, request.getParameter("condition")));
	return Definitions.DB_INT_OK;
}
/////////[END] THÔNG TIN TY LỆ BỆNH ///////

//EDiting canh dong
public int updateEditingCanhdong(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
	DlgDieutraCanhdong m = new DlgDieutraCanhdong();
	String tableName = request.getParameter("tablename");
	String lstIDs = request.getParameter("ids");
	String lstValues = request.getParameter("values");
	String tinh_id = request.getParameter("tinh_id");
	String huyen_id = request.getParameter("huyen_id");
	String xa_id = request.getParameter("xa_id");

	writeResponse.print(m.updateEditingCanhdong(dbo, tableName, lstValues, lstIDs,tinh_id,huyen_id,xa_id ));
	return Definitions.DB_INT_OK;
}



public int execSQLByClient(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
	String sql = request.getParameter("sqlquery");
	String async = request.getParameter("async");
	System.out.println("async =" + async);
	if ("true".equalsIgnoreCase(async)){
		writeResponse.print(dbo.asyncExecSQLByClient(sql).getCode());
	} else {
		writeResponse.print(dbo.syncExecSQLByClient(sql).getCode());
	}
	return Definitions.DB_INT_OK;
}
public int getDataDynamic(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
	String sql = request.getParameter("sqlquery");
	String async = request.getParameter("async");
	System.out.println("async =" + async);
	if (async.equalsIgnoreCase("true")){
		writeResponse.print(dbo.getDataDynamic(sql));
	} else {
		writeResponse.print(dbo.getDataDynamic(sql));
	}
	return Definitions.DB_INT_OK;
}
public int execUpdateDataGrid(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
	String tablename = request.getParameter("tablename");

	String insertFields = request.getParameter("insertFields");
	String insertValues = request.getParameter("insertValues");

	String updateFields = request.getParameter("updateFields");
	String updateValues = request.getParameter("updateValues");
	String returnid = request.getParameter("returnid");
	System.out.println("insertFields =" + insertFields);
	System.out.println("insertValues =" + insertValues);
	System.out.println("updateFields = " +updateFields);
	System.out.println("updateValues =" + updateValues);

	writeResponse.print(dbo.execUpdateDataGrid(tablename,insertFields,insertValues,updateFields,updateValues,returnid));
	return Definitions.DB_INT_OK;
}
public void getDientichGieocay(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
	DlgOperation dop = new DlgOperation();
	String id = request.getParameter("id");
	String vulua_id = request.getParameter("vulua_id");
	String gionglua_id = request.getParameter("gionglua_id");
	String time_int1 = request.getParameter("time_int1");
	String time_int2 =  request.getParameter("time_int2");
	int checkType=Integer.parseInt(request.getParameter("check_type"));
	String ret=null;
	if(checkType==Definitions.CHECK_XA)
		ret= dop.getDientichGieocayXa(dbo, id, vulua_id, gionglua_id,time_int1, time_int2);
	else if(checkType==Definitions.CHECK_CANHDONG)
		ret= dop.getDientichGieocayCanhdong(dbo, id, vulua_id, gionglua_id,time_int1, time_int2);

	writeResponse.print(ret);

}
public void getVienthamImageInfo(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
	VienthamOperation vop = new VienthamOperation();

	String imageid = request.getParameter("imageid");
	String condition= request.getParameter("condition");
	String s = vop.getVienthamImageInfo(dbo, imageid,condition);
	writeResponse.print(s);

}
public void getListXaIDHasSameSinhthai(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
	DlgDieutraXa dtrx = new DlgDieutraXa();

	String xaid = request.getParameter("xa_id");
	String huyenid= request.getParameter("huyen_id");
	String sinhthai_field_name= request.getParameter("sinhthai_field_name");
	String s = dtrx.getListXaIDHasSameSinhthai(dbo, sinhthai_field_name,xaid,huyenid);
	writeResponse.print(s);

}
public void checkGiongluaGieocay(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
	DlgOperation dlgo = new DlgOperation();
	int checkType=Integer.parseInt(request.getParameter("check_type"));
	int ret=0;
	if(checkType==Definitions.CHECK_XA)
		ret= dlgo.checkGiongLuaGieocayXa(dbo, request,writeResponse);
	else if(checkType==Definitions.CHECK_CANHDONG)
		ret= dlgo.checkGiongLuaGieocayCanhdong(dbo, request,writeResponse);

	writeResponse.print(ret);

}
public void getData2EditUser(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
	System.out.println("page=" + request.getParameter("page"));
	System.out.println("rows=" + request.getParameter("rows"));
	System.out.println("total=" + request.getParameter("total"));
	System.out.println("records=" + request.getParameter("records"));
	//if ("null".equalsIgnoreCase(request.getParameter("records"))) total = -1;

	int  total = -1;//Integer.parseInt(request.getParameter("total"));
	int  records = -1;//Integer.parseInt(request.getParameter("records"));
	int  page = Integer.parseInt(request.getParameter("page"));
	int  rows = Integer.parseInt(request.getParameter("rows"));

	String  condition = request.getParameter("condition");
	int limit = rows;
	int offset = (page - 1)*rows;
	try{
	DlgDieutraCanhdong dtcd = new DlgDieutraCanhdong();
	String s = (String)dtcd.getData2EditUser(dbo, total, records, limit, offset, condition, true);
	System.err.println(s);
	writeResponse.print(s);
	}catch(SQLException e){}

}




}
