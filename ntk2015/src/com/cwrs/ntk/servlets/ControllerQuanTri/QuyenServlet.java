package com.cwrs.ntk.servlets.ControllerQuanTri;

import com.cwrs.ntk.common.Definitions;
import com.cwrs.ntk.common.JResult;
import com.cwrs.ntk.servlets.dao.DBOperation;
import com.cwrs.ntk.servlets.dao.DlgOperation;
import com.cwrs.ntk.servlets.dao.DlgQuyen;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;

/**
 * Created by VN on 3/25/2015.
 */
@WebServlet("/QuyenServlet")
public class QuyenServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public QuyenServlet() {
        super();
    }

    @Resource(name = "jdbc/ntm")
    private DataSource ds;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequests(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequests(request,response);
    }

    protected void processRequests(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        String codeRequest = request.getParameter("action");
        System.out.println("--- Code Request: ---" + codeRequest);
        if (codeRequest==null ||"null".equalsIgnoreCase(codeRequest))return;
        PrintWriter writeResponse = response.getWriter();
        DBOperation dbo = new DBOperation();
        Connection conn = null;
        try {
            conn = ds.getConnection();
            dbo.setConnection(conn);
            switch(Integer.parseInt(codeRequest)) {
                case Definitions.ACT_DB_CHECK_DATA_EXISTS: checkDataExists(dbo,request,writeResponse); break;
                case Definitions.ACT_DB_MAX_DATA: checkMAX(dbo, request, writeResponse ); break;

                /* Danh sach phan quyen*/
                case Definitions.ACT_GET_DATA_TO_FORM_SHOW_DANHSACHQUYEN: getDatatoDanhSachPhanQuyenForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_DANHSACHQUYEN: getDatatoEditDanhSachPhanQuyenForm(dbo,request,response,writeResponse); break;
                case Definitions.ACT_GET_LIST_DANHSACHQUYEN_TO_CHECKBOX: getListQuyen2ComboHtml(dbo, request, writeResponse);break;
                
                //Insert/Update to Database
                case Definitions.ACT_DB_INSERT_UPDATE_MULTI_OBJECT: execInsertUpdatedMultiRecords2DBByClient(dbo, request, writeResponse);break;

                case Definitions.ACT_DB_DELETE_OBJECT : deleteRecord(dbo, request, writeResponse); break;
            }
        } catch (SQLException e) {
            System.out.println( "QuyenServlet SQLException: " + e.toString());
        } finally {
            if (conn != null) {
                dbo.closeConnection();
            }

        }
    }

    public void getDatatoDanhSachPhanQuyenForm(DBOperation dbo, HttpServletRequest request, HttpServletResponse response, PrintWriter writeResponse){
//        System.out.println("page=" + request.getParameter("page"));
//        System.out.println("rows=" + request.getParameter("rows"));
//        System.out.println("total=" + request.getParameter("total"));
//        System.out.println("records=" + request.getParameter("records"));

        int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgQuyen dlgquyen = new DlgQuyen();
        String s = (String)dlgquyen.getDatatoDanhSachPhanQuyenForm(dbo, total, records, limit, offset, condition, true);
//        System.err.println("Json response: " + s );
        writeResponse.print(s);
    }

    public void getDatatoEditDanhSachPhanQuyenForm (DBOperation dbo, HttpServletRequest request, HttpServletResponse response, PrintWriter writeResponse){
        DlgQuyen dlgquyen = new DlgQuyen();
        writeResponse.print(dlgquyen.getDatatoEditDanhSachPhanQuyenForm(dbo,request.getParameter("condition")));
    }

    public void checkDataExists(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
        DlgOperation dop = new DlgOperation();
        writeResponse.print(dop.checkDataExists(dbo,request,writeResponse));
    }

    public void checkMAX(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
        DlgOperation dop = new DlgOperation();
        writeResponse.print(dop.checkMAX(dbo,request,writeResponse));

    }
    public void getListQuyen2ComboHtml(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgQuyen dlgquyen = new DlgQuyen();
		String s = (String)dlgquyen.getListQuyen2ComboHtml(dbo, null, true);
		writeResponse.print(s);
	}
    

    public void  execInsertUpdatedMultiRecords2DBByClient(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
       // System.out.println("execInsertUpdatedMultiRecords2DBByClient...");
		try {
			String ret = dbo.execInsertUpdatedMultiRecords2DBByClient(
					/*single/multiple SQL query */request.getParameter("sqlquery")
			        ,/*condition */request.getParameter("condition")
			        ,/*values */request.getParameter("values")
			        ,/*sql type order in query */request.getParameter("sqlTypeOrder")
			        ,/*ids */request.getParameter("ids")
			);
			writeResponse.print(ret);
		} catch (ParseException e) {
			e.printStackTrace();
		}
    }

    public void deleteRecord(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
        String condition = request.getParameter("condition");
        System.out.println(condition);
        String tableName = request.getParameter("tableName");
        DlgOperation dop = new DlgOperation();
        JResult jro = dop.deleteObject(dbo, tableName, condition);
        writeResponse.print(jro.toString());
    }
}