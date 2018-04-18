package com.cwrs.ntk.servlets.Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.cwrs.ntk.models.TblPhanloaiDetaiDuanEntity;
import com.cwrs.ntk.models.TblTintucEntity;
import com.cwrs.ntk.servlets.dao.DBOperation;
import com.cwrs.ntk.servlets.dao.DlgMain;
import com.cwrs.ntk.servlets.dao.DlgPhanLoaiTinTuc;
import com.cwrs.ntk.servlets.dao.DlgPhanLoaiVanBan;
import com.cwrs.ntk.servlets.dao.DlgTinTucHoatDong;

/**
 * Created by VN on 3/6/2015.
 */
@WebServlet("/WelcomeServlet")
public class WelcomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Resource(name = "jdbc/ntm")
    private DataSource ds;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	processRequest(request, response);
    }
    
    @SuppressWarnings("unchecked")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	 response.setContentType("text/html; charset=UTF-8");
         request.setCharacterEncoding("UTF-8");
         response.setCharacterEncoding("UTF-8");
         DBOperation dbo = new DBOperation();
         Connection conn = null;
         try {
             conn = ds.getConnection();
             dbo.setConnection(conn);
             DlgPhanLoaiVanBan dlgPhanLoaiVanBan = new DlgPhanLoaiVanBan();
             DlgTinTucHoatDong dlgTinTucHoatDong = new DlgTinTucHoatDong();
             DlgPhanLoaiTinTuc dlgPhanLoaiTinTuc = new DlgPhanLoaiTinTuc();
             DlgMain dlgMain = new DlgMain();

             request.setAttribute("Object_PhanloaiVB",dlgPhanLoaiVanBan.getDatatoDs_PhanLoaiVanBanHome(dbo,null,false));  

             ArrayList<Object> Object_PhanloaiTT=  (ArrayList<Object>) dlgPhanLoaiTinTuc.getDatatoDs_PhanTinTucHome(dbo, null, false);
             request.setAttribute("Object_PhanloaiTT",Object_PhanloaiTT);
             
             String chuoi_jsp ="";
			
             String[] values = new String[] { 
             		TblPhanloaiDetaiDuanEntity.PHANLOAI_DETAI_DUAN_ID, 
             		TblPhanloaiDetaiDuanEntity.PHANLOAI_DETAI_DUAN_TEN,
             };
             request.setAttribute("Object_PhanloaiNhomDeTai", dlgMain.getRetrieveDataFromDatabase_Home(dbo, null, false, values, TblPhanloaiDetaiDuanEntity.PHANLOAI_DETAI_DUAN_TBL, TblPhanloaiDetaiDuanEntity.PHANLOAI_DETAI_DUAN_TEN));
             
             values = new String[]{
            		 "id_picture",
            		 "pathfile",
            		 "tenanh",
            		 "id_folder"
             };
             request.setAttribute("Object_Video", dlgMain.getRetrieveDataFromDatabase_Home(dbo, "type_media = 0", false, values, "tbl_picture_detai", "tenanh limit 8"));
             
             values = new String[]{
            		 "id_picture",
            		 "pathfile",
            		 "id_folder"
             };
             request.setAttribute("Object_Picture", dlgMain.getRetrieveDataFromDatabase_Home(dbo, "type_media = 1", false, values, "tbl_picture_detai", "id_picture limit 5"));
             
             values = new String[]{
            		 "id_baiviet", "tentieude","tomtatnoidung"
             };
             request.setAttribute("Object_GioiThieu_NTM", dlgMain.getRetrieveDataFromDatabase_Home(dbo, "tinhtrang is true", false, values, "tbl_baiviet", "id_baiviet limit 5"));
             
             values = new String[]{
            		 "id_baiviet", "tentieude","tomtatnoidung"
             };
             request.setAttribute("Object_GioiThieu_DTDA", dlgMain.getRetrieveDataFromDatabase_Home(dbo, "tinhtrang is true", false, values, "tbl_baiviet_detai", "id_baiviet limit 5"));
             
             String string_object="",string_id_phanloai="",string_TinChinh="";
             for(int i = 0; i < Object_PhanloaiTT.size(); i++ ){
            	 string_object = Object_PhanloaiTT.get(i).toString();
            	 string_TinChinh = string_object.substring(string_object.indexOf('=')+1, string_object.indexOf(','));
            	 string_id_phanloai =  string_object.substring(string_object.lastIndexOf('=')  + 1, string_object.lastIndexOf('}'));
            	 
            	 ArrayList<TblTintucEntity> object_TTHD = dlgTinTucHoatDong.getDatato_TinTucHoatDongHome(dbo, "id_phanloai_tintuc="+ string_id_phanloai, false);
            	 chuoi_jsp= chuoi_jsp +"<div class='box-c'>";
            	 chuoi_jsp= chuoi_jsp +"<div class='box-news'>";
            	 chuoi_jsp= chuoi_jsp +"<div class='box-title'>";
            	 chuoi_jsp= chuoi_jsp +"<a href='"+request.getContextPath()+"/ChuyenTrang?XemTT="+string_id_phanloai+"&action=108&page=1'>";
            	 chuoi_jsp= chuoi_jsp +"<span style='text-transform: uppercase; color: #E70404;'>";
            	 chuoi_jsp= chuoi_jsp +"		<b>"+ string_TinChinh + "</b>";
            	 chuoi_jsp= chuoi_jsp +"	</span>";
            	 chuoi_jsp= chuoi_jsp +"		</a>";
            	 chuoi_jsp= chuoi_jsp +"	</div>";
            	 
            	 for(int j = 0; j < object_TTHD.size(); j++){
            		 if(j == 0){
            		 chuoi_jsp= chuoi_jsp +"		<div class='box-content'>";
            		 chuoi_jsp= chuoi_jsp +"			<div class='first'>";
            		 
            		 if(!object_TTHD.get(j).getDuongdantintuc().equals("") ){
            		 chuoi_jsp= chuoi_jsp +"				<a href='"+request.getContextPath()+"/ChuyenTrang?action=109&sotintuc="+object_TTHD.get(j).getIdTintuc()+"'>"
            		 + "<img alt=''height='226' src='"+request.getContextPath()+"/"+object_TTHD.get(j).getDuongdantintuc()+"' width='300'></a>";
            		 }
            		 
            		 chuoi_jsp= chuoi_jsp +"				<p class='title'>";
            		 chuoi_jsp= chuoi_jsp +"					<a href='"+request.getContextPath()+"/ChuyenTrang?action=109&sotintuc="+object_TTHD.get(j).getIdTintuc()+"'>";
            		 chuoi_jsp= chuoi_jsp +"						"+ object_TTHD.get(j).getTieude() +"</a>";
            		 chuoi_jsp= chuoi_jsp +"				</p>";
            		 chuoi_jsp= chuoi_jsp +"				<div style='text-align: justify'>";
            		 chuoi_jsp= chuoi_jsp +"					<b";
            		 chuoi_jsp= chuoi_jsp +"						style='font-family: Verdana,Arial,sans-serif; font-size: 10pt;'><span";
            		 chuoi_jsp= chuoi_jsp +"						style='color: black'>";
            		 chuoi_jsp= chuoi_jsp +"							"+ object_TTHD.get(j).getTomtat() + "</span></b>";
            		 chuoi_jsp= chuoi_jsp +"				</div>";
            		 chuoi_jsp= chuoi_jsp +"				<div style='text-align: justify'>";
            		 chuoi_jsp= chuoi_jsp +"					<span class='ms-rteFontSize-3'> </span>";
            		 chuoi_jsp= chuoi_jsp +"				</div>";
            		 chuoi_jsp= chuoi_jsp +"			</div>";
            		 chuoi_jsp= chuoi_jsp +"<ul>";
            		 }else{
                    	 chuoi_jsp= chuoi_jsp +"		<li><a";
                    	 chuoi_jsp= chuoi_jsp +"		href='"+request.getContextPath()+"/ChuyenTrang?action=109&sotintuc="+object_TTHD.get(j).getIdTintuc()+"'>  ";
                    	 chuoi_jsp= chuoi_jsp  + object_TTHD.get(j).getTieude() +  "</a></li>";
            		 }
            	 }
            	 chuoi_jsp= chuoi_jsp +"							</ul>";
            	 chuoi_jsp= chuoi_jsp +"	</div>";
            	 chuoi_jsp= chuoi_jsp +"	</div>"; 
            	 chuoi_jsp= chuoi_jsp +"	</div>";
            	 
            	 request.setAttribute("ArrayList_TinMoi", dlgTinTucHoatDong.getData_TinMoiHome(dbo,6,0,null,false));
            	 
             }
             request.setAttribute("Object_TinTucHoatDong",chuoi_jsp.toString());
             request.getRequestDispatcher("index.jsp").forward(request, response);
         
         } catch (SQLException e) {
             System.out.println( "WelcomeServlet SQLException: " + e.toString());
         } finally {
             if (conn != null) {
            	 //System.out.println("dong");
                 dbo.closeConnection();
             }
         }
    }
}
