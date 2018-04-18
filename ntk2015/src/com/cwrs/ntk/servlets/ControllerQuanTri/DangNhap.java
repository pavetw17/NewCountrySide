package com.cwrs.ntk.servlets.ControllerQuanTri;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.cwrs.ntk.models.TblTaikhoanEntity;
import com.cwrs.ntk.servlets.dao.DBOperation;
import com.cwrs.ntk.servlets.dao.DlgTaiKhoan;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by VN on 3/1/2015.
 */
@WebServlet ("/DangNhap")
public class DangNhap extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Resource(name = "jdbc/ntm")
    private DataSource ds;
	
	protected void xuly(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        DBOperation dbo = new DBOperation();
        Connection conn = null;
        try {
            conn = ds.getConnection();
            dbo.setConnection(conn);
            
            String codeRequest = request.getParameter("action");
            switch(Integer.parseInt(codeRequest)){
            	case 1: {
		            PrintWriter writeResponse = response.getWriter();
		            DlgTaiKhoan dlgTaiKhoan = new DlgTaiKhoan();
		            TblTaikhoanEntity tblTaikhoan = dlgTaiKhoan.dangNhap(dbo, username, password);
		            if(tblTaikhoan != null){
		            	 HttpSession session = request.getSession();
		            	 session.setAttribute("tblTaikhoan",tblTaikhoan);
		            	 writeResponse.print(request.getContextPath()+"/quantri/trangAdmin.jsp");
		            }else{
		            	 writeResponse.print(0);
		            }
		            break;
            	}
            	case 2:{
            		request.getSession().invalidate();
            	    response.sendRedirect(request.getContextPath());
            	    break;
            	}
            		
            }
            
        }catch (SQLException e) {
            System.out.println( "DangNhap SQLException: " + e.toString());
        } finally {
            if (conn != null) {
            	//System.out.println("dong");
                dbo.closeConnection();
            }
        }   
 
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       xuly(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        xuly(request,response);
    }
}
