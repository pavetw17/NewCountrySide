package com.cwrs.ntk.servlets.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.cwrs.ntk.common.Definitions;
import com.cwrs.ntk.common.Utils;
import com.cwrs.ntk.models.TblPhanloaiDetaiDuanEntity;
import com.cwrs.ntk.models.TblYkienchidaoEntity;
import com.cwrs.ntk.servlets.dao.DBOperation;
import com.cwrs.ntk.servlets.dao.DlgMain;
import com.cwrs.ntk.servlets.dao.DlgOperation;
import com.cwrs.ntk.servlets.dao.DlgPhanLoaiTinTuc;
import com.cwrs.ntk.servlets.dao.DlgPhanLoaiVanBan;
import com.cwrs.ntk.servlets.dao.DlgTinTucHoatDong;
import com.cwrs.ntk.servlets.dao.DlgVanBanPhapLy;

/**
 * Created by VN on 1/8/2015.
 */
@WebServlet("/ChuyenTrang")
public class ChuyenTrang extends HttpServlet {

	@Resource(name = "jdbc/ntm")
	private DataSource ds;

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}
	
	private void loadMenu(DBOperation dbo, HttpServletRequest request){
		DlgPhanLoaiVanBan dlgPhanLoaiVanBan = new DlgPhanLoaiVanBan();
		request.setAttribute("Object_PhanloaiVB", dlgPhanLoaiVanBan.getDatatoDs_PhanLoaiVanBanHome(dbo, null, false));
		
		DlgPhanLoaiTinTuc dlgPhanLoaiTinTuc = new DlgPhanLoaiTinTuc();
        request.setAttribute("Object_PhanloaiTT",dlgPhanLoaiTinTuc.getDatatoDs_PhanTinTucHome(dbo, null, false));
        
        DlgTinTucHoatDong dlgTinTucHoatDong = new DlgTinTucHoatDong();
        request.setAttribute("ArrayList_TinMoi", dlgTinTucHoatDong.getData_TinMoiHome(dbo,6,0,null,false));
        
        DlgMain dlgMain = new DlgMain();
        /*Show classification project on menu left*/
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
         
    }
	
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String codeRequest = request.getParameter("action");
		if (!Utils.checkInteger(codeRequest)) 	codeRequest = "0";
		DBOperation dbo = new DBOperation();
		Connection conn = null;
		try {
			conn = ds.getConnection();
			dbo.setConnection(conn);
			String[] values ;
			String so_id;
			String condition = null, tukhoa="";
			String link_page = "";
			switch (Integer.parseInt(codeRequest)) {
			
			case Definitions.TRANG_VIDEO:{
				DlgMain dlgMainVideo = new DlgMain();
				values = new String[] { "id_folder",	"foldername" };
				request.setAttribute("thumuc_center", dlgMainVideo.getRetrieveDataFromDatabase_Home(dbo, "  type_media = 0 ", false, values, "tbl_picture_folder", "foldername"));
			
				values = new String[] {  "id_picture", "pathfile", "tenanh", "id_folder"  };
				request.setAttribute("video_NTM", dlgMainVideo.getRetrieveDataFromDatabase_Home(dbo, "  type_media = 0 ", false, values, "tbl_picture", "id_picture limit 10"));
				request.setAttribute("video_KQNC", dlgMainVideo.getRetrieveDataFromDatabase_Home(dbo, "  type_media = 0 ", false, values, "tbl_picture_detai", "id_picture limit 10"));

				request.setAttribute("page", Definitions.TRANG_VIDEO);
				request.getRequestDispatcher("chuyentrang.jsp").forward(request, response);
				break;
			}
			case Definitions.COUNT_TRANG_VIDEO:{
				DlgMain dlgMainCountVideo = new DlgMain();
				String thumucVideo = request.getParameter("thumuc");
				String chudeVideo = request.getParameter("chude");
				PrintWriter writeResponseCount = response.getWriter();
				values = new String[] { "count(id_picture)" };
				if(chudeVideo.equals("1")){  //NTM
					writeResponseCount.print(dlgMainCountVideo.getRetrieveDataFromDatabase_Home(dbo, "id_folder =" + thumucVideo + " and  type_media = 0 ", true, values, "tbl_picture", null ));
				}else{ //KQ_NCDT
					writeResponseCount.print(dlgMainCountVideo.getRetrieveDataFromDatabase_Home(dbo, "id_folder =" + thumucVideo + " and  type_media = 0 ", true, values, "tbl_picture_detai", null ));
				}
				break;
			}
			case Definitions.LIST_TRANG_VIDEO:{
				DlgMain dlgMainViewVideo = new DlgMain();
				String xem_thumucVideo = request.getParameter("thumuc");
				String pageVideo = request.getParameter("page");
				String xem_chudeVideo = request.getParameter("chude");
				String so_itemsVideo = request.getParameter("so_items");
				values = new String[] { "id_picture", "pathfile", "tenanh", "id_folder"   };
				PrintWriter writeResponseXemVideo = response.getWriter();
				if(xem_chudeVideo.equals("1")){  //NTM
					writeResponseXemVideo.print(dlgMainViewVideo.getRetrieveDataFromDatabase_Home(dbo, "id_folder =" + xem_thumucVideo + " and  type_media = 0 ", true, values, "tbl_picture", "id_picture limit " + so_itemsVideo +" offset "+ (Integer.parseInt(pageVideo) *  Integer.parseInt(so_itemsVideo)) ));
				}else{ //KQ_NCDT
					writeResponseXemVideo.print(dlgMainViewVideo.getRetrieveDataFromDatabase_Home(dbo, "id_folder =" + xem_thumucVideo + " and  type_media = 0 ", true, values, "tbl_picture_detai", "id_picture limit " + so_itemsVideo +" offset "+ (Integer.parseInt(pageVideo) *  Integer.parseInt(so_itemsVideo)) ));
				}
				break;
			}
			case Definitions.XEM_VIDEO:{
				DlgMain dlgMain = new DlgMain();
				String chude = request.getParameter("chude");
				String so_idVideo = request.getParameter("so_id");
				values = new String[] { "id_picture", "pathfile", "tenanh", "id_folder"   };
				PrintWriter writeResponse = response.getWriter();
				if(chude.equals("1")){  //NTM
					writeResponse.print(dlgMain.getDatatoEdit_Home(dbo, "id_picture =" + so_idVideo + " and  type_media = 0 ", values, "tbl_picture", true ));
				}else{
					writeResponse.print(dlgMain.getDatatoEdit_Home(dbo, "id_picture =" + so_idVideo + " and  type_media = 0 ", values, "tbl_picture_detai", true ));
				}
				break;
			}
			case Definitions.TRANG_ANH:{
				DlgMain dlgMainPicture = new DlgMain();
				values = new String[] { "id_folder",	"foldername" };
				request.setAttribute("thumuc_center", dlgMainPicture.getRetrieveDataFromDatabase_Home(dbo, "  type_media = 1 ", false, values, "tbl_picture_folder", "foldername"));

				values = new String[] {  "pathfile"  };
				request.setAttribute("anh_NTM", dlgMainPicture.getRetrieveDataFromDatabase_Home(dbo, "  type_media = 1 ", false, values, "tbl_picture", "id_picture limit 14"));
				request.setAttribute("anh_KQNC", dlgMainPicture.getRetrieveDataFromDatabase_Home(dbo, "  type_media = 1 ", false, values, "tbl_picture_detai", "id_picture limit 14"));

				request.setAttribute("page", Definitions.TRANG_ANH);
				request.getRequestDispatcher("chuyentrang.jsp").forward(request, response);
				break;
			}
			case Definitions.COUNT_TRANG_ANH:{
				DlgMain dlgMainCount = new DlgMain();
				String thumuc = request.getParameter("thumuc");
				String chude = request.getParameter("chude");
				PrintWriter writeResponse = response.getWriter();
				values = new String[] { "count(id_picture)" };
				if(chude.equals("1")){  //NTM
					writeResponse.print(dlgMainCount.getRetrieveDataFromDatabase_Home(dbo, "id_folder =" + thumuc + " and  type_media = 1 ", true, values, "tbl_picture", null ));
				}else{ //KQ_NCDT
					writeResponse.print(dlgMainCount.getRetrieveDataFromDatabase_Home(dbo, "id_folder =" + thumuc + " and  type_media = 1 ", true, values, "tbl_picture_detai", null ));
				}
				break;
			}	
			case Definitions.XEM_TRANG_ANH:{
				DlgMain dlgMainViewPicture = new DlgMain();
				String xem_thumuc = request.getParameter("thumuc");
				String page = request.getParameter("page");
				String xem_chude = request.getParameter("chude");
				String so_items = request.getParameter("so_items");
				values = new String[] {  "pathfile"  };
				PrintWriter writeResponse1 = response.getWriter();
				if(xem_chude.equals("1")){  //NTM
					writeResponse1.print(dlgMainViewPicture.getRetrieveDataFromDatabase_Home(dbo, "id_folder =" + xem_thumuc + " and  type_media = 1 ", true, values, "tbl_picture", "id_picture limit " + so_items +" offset "+ (Integer.parseInt(page) *  Integer.parseInt(so_items)) ));
				}else{ //KQ_NCDT
					writeResponse1.print(dlgMainViewPicture.getRetrieveDataFromDatabase_Home(dbo, "id_folder =" + xem_thumuc + " and  type_media = 1 ", true, values, "tbl_picture_detai", "id_picture limit " + so_items +" offset "+ (Integer.parseInt(page) *  Integer.parseInt(so_items)) ));
				}
				break;
			}	
			
			
			/*Van ban*/
			case Definitions.PAGINATION_VB:{
				loadMenu(dbo, request);
				String formVB = request.getParameter("formVB");
				if (!Utils.checkInteger(formVB) ) {
        			response.sendRedirect("404.jsp");
        			return; 		}
				DlgMain dlgMain = new DlgMain();
				values = new String[] {
						"loai_vanbanphaply"
				};
				request.setAttribute("row_tenthumuc", dlgMain.getRetrieveDataFromDatabase_Home(dbo, "id_phanloai=" + formVB, false, values, "tbl_phanloai_vanban", null));
				
				link_page = "ChuyenTrang?formVB="+formVB+"&action="+ Definitions.PAGINATION_VB+"&page=";
				condition =  "id_phanloai=" + formVB;
				phanTrangVB(dbo,request,response,condition,link_page); break;
			}
         	case Definitions.VIEW_CONTENT_VB: {
        		if (!Utils.checkInteger(request.getParameter("sovanban")) ) {
        			response.sendRedirect("404.jsp");
        			return;    		}
        		loadMenu(dbo, request);
         		xemNoiDungVB(dbo,request,response);  break; 	
         	}
         	case Definitions.SUBJECT_SEARCH_VB: {
         		loadMenu(dbo, request);
         		tukhoa = request.getParameter("tukhoa");
         		condition = "kihieuvanban ilike '%"+tukhoa+"%' or tenvanban ilike '%"+tukhoa+"%'" ;
         		link_page = "ChuyenTrang?tukhoa="+tukhoa+"&action="+ Definitions.SUBJECT_SEARCH_VB+"&page=";
         		phanTrangVB(dbo,request,response,condition,link_page);  break;	
         	}
         	
         	
         	/*Y kien*/
         	case Definitions.PAGINATION_YK: {
  			   loadMenu(dbo, request);
  			   values = new String[] {
  					 TblYkienchidaoEntity.YKIEN_CHIDAO_ID ,
  			         TblYkienchidaoEntity.YKIEN_CHIDAO_TIEUDE ,
  			       "TO_CHAR(TO_TIMESTAMP((" +TblYkienchidaoEntity.YKIEN_CHIDAO_NGAY + "*86400 ) ), 'DD/MM/YYYY') as ngay_chidao_cohieuluc",  
  			         TblYkienchidaoEntity.YKIEN_CHIDAO_SOKIHIEU
  			   };
  			   link_page = "ChuyenTrang?&action="+ Definitions.PAGINATION_YK +"&page=";
  			   phanTrangMain(dbo,request,response,null,link_page,"id_ykienchidao","tbl_ykienchidao",Definitions.PAGINATION_YK,values);break;
         	}
         	case Definitions.VIEW_CONTENT_YK:{
         		so_id = request.getParameter("sovanban");
         		if (!Utils.checkInteger(so_id) ) {response.sendRedirect("404.jsp"); return;	}
         		loadMenu(dbo, request);
         		values = new String[] {
         				  TblYkienchidaoEntity.YKIEN_CHIDAO_TIEUDE ,
         				 "TO_CHAR(TO_TIMESTAMP((" +TblYkienchidaoEntity.YKIEN_CHIDAO_NGAY + "*86400 ) ) , 'DD/MM/YYYY') as ngay_chidao_cohieuluc",  
         			      TblYkienchidaoEntity.YKIEN_CHIDAO_NOIDUNG ,
         			      TblYkienchidaoEntity.YKIEN_CHIDAO_SOKIHIEU ,
         			      TblYkienchidaoEntity.YKIEN_CHIDAO_DUONGDAN
                };
         		condition = " id_ykienchidao = " + so_id ;
         		xemNoiDungMain(dbo,request,response,condition,values,"tbl_ykienchidao",Definitions.VIEW_CONTENT_YK);  break; 
         	}
         	case Definitions.SUBJECT_SEARCH_YK: {
         		loadMenu(dbo, request);
         		tukhoa = request.getParameter("tukhoa");
         		condition = "sokihieu ilike '%"+tukhoa+"%' or tieude ilike '%"+tukhoa+"%'" ;
         		link_page = "ChuyenTrang?tukhoa="+condition+"&action="+ Definitions.SUBJECT_SEARCH_YK +"&page=";
         		values = new String[] {
                 		 TblYkienchidaoEntity.YKIEN_CHIDAO_ID  ,
                 		 TblYkienchidaoEntity.YKIEN_CHIDAO_TIEUDE ,
                 		"TO_CHAR(TO_TIMESTAMP((" +TblYkienchidaoEntity.YKIEN_CHIDAO_NGAY + "*86400 ) ), 'DD/MM/YYYY') as ngay_chidao_cohieuluc",  
                 	     TblYkienchidaoEntity.YKIEN_CHIDAO_SOKIHIEU 
                };
         		phanTrangMain(dbo,request,response,condition,link_page,"id_ykienchidao","tbl_ykienchidao",Definitions.PAGINATION_YK,values); break;
         	}
         	
         	
         	/*Tin tuc*/	
         	case Definitions.PAGINATION_TT:{
         		String XemTT = request.getParameter("XemTT");
         		if (!Utils.checkInteger(XemTT) ) {response.sendRedirect("404.jsp"); return;	}
				loadMenu(dbo, request);
         		link_page = "ChuyenTrang?XemTT="+XemTT+"&action="+ Definitions.PAGINATION_TT +"&page=";
         		condition =  "id_phanloai_tintuc=" + XemTT;
         		phanTrangTT(dbo,request,response,condition,link_page); break;
         	}
         	case Definitions.VIEW_CONTENT_TT: {
        		if (!Utils.checkInteger(request.getParameter("sotintuc")) ) {response.sendRedirect("404.jsp");
        			return;       		}
         		loadMenu(dbo, request);
         		xemNoiDungTT(dbo,request,response);  break; 	
         	}
         	case Definitions.SUBJECT_SEARCH_TT:{
         		loadMenu(dbo, request);
         		tukhoa = request.getParameter("tukhoa");
         		condition = "tieude ilike '%"+tukhoa+"%' or tomtat ilike '%"+tukhoa+"%'" ;
         		link_page = "ChuyenTrang?tukhoa="+tukhoa+"&action="+ Definitions.SUBJECT_SEARCH_TT +"&page=";
         		phanTrangTT(dbo,request,response,condition,link_page); break;
         	}
         	
         	
         	/*De tai*/
         	case Definitions.PAGINATION_DETAI:	{
               String XemDeTai = request.getParameter("XemDeTai");
			   if (!Utils.checkInteger(XemDeTai) ) {	response.sendRedirect("404.jsp");
				   return;   }
			   loadMenu(dbo, request);
			   DlgMain dlgMain = new DlgMain();
			   values = new String[] {
						"ten_phannhom_detai"
				};
			   request.setAttribute("row_tenthumuc", dlgMain.getRetrieveDataFromDatabase_Home(dbo, "id_phannhom_detai=" + XemDeTai, false, values, "tbl_phanloai_detai_duan", null));
			   
			   /*Get project accord to clasification project*/ 
			   values = new String[] {
					   	"id_detai", "tendt", "linhvuckh",
						"tgthuchien", "kinhphi", "id_phannhom_detai_duan"
			   };
			   link_page = "ChuyenTrang?XemDeTai="+XemDeTai+"&action="+ Definitions.PAGINATION_DETAI+"&page=";
			   condition =  "id_phannhom_detai_duan=" + XemDeTai;
			   phanTrangMain(dbo,request,response,condition,link_page,"id_detai","tbl_detai_duan",Definitions.PAGINATION_DETAI,values); break;
         	}
         	case Definitions.VIEW_CONTENT_DETAI: {
         		so_id = request.getParameter("so_id");
        		if (!Utils.checkInteger(so_id) ) {   			response.sendRedirect("404.jsp");
        			return;      		}
         		loadMenu(dbo, request);
         		values = new String[] {
         				"id_detai", "tendt", "linhvuckh",
						"tgthuchien", "kinhphi", "id_phannhom_detai_duan", "ten_phannhom_detai"
                   };
         		condition = " id_detai = " + so_id;
         		xemNoiDungMain(dbo,request,response,condition,values,"tbl_detai_duan a inner join tbl_phanloai_detai_duan b on a.id_phannhom_detai_duan = b.id_phannhom_detai",Definitions.VIEW_CONTENT_DETAI);  break; 
         	}
         	case Definitions.SUBJECT_SEARCH_DETAI:{
         		loadMenu(dbo, request);
         		tukhoa = request.getParameter("tukhoa");
         		condition = "tendt ilike '%"+tukhoa+"%' " ;
         		link_page = "ChuyenTrang?tukhoa="+tukhoa+"&action="+ Definitions.SUBJECT_SEARCH_DETAI +"&page=";
         		values = new String[] {
         				"id_detai", "tendt", "linhvuckh",
						"tgthuchien", "kinhphi", "id_phannhom_detai_duan"
                };
         		phanTrangMain(dbo,request,response,condition,link_page,"id_detai","tbl_detai_duan",Definitions.PAGINATION_DETAI,values); break;
         	}
         	
         	
        	/*Gioi Thieu*/
         	case Definitions.PAGINATION_GIOITHIEU:	{
               String chude = request.getParameter("chude");
			   if (!Utils.checkInteger(chude) ) {	response.sendRedirect("404.jsp");
				   return;   }
			   loadMenu(dbo, request);
			   values = new String[] {
					   	"id_baiviet", "id_xadiem", "tentieude",
						"tomtatnoidung"
			   };
			   
			   link_page = "ChuyenTrang?chude="+chude+"&action="+ Definitions.PAGINATION_GIOITHIEU+"&page=";
			   if(chude.equals("1") ){ //NTM
				//   condition =  "id_phanloai_baiviet=" + ;
				   request.setAttribute("row_tenthumuc","Kết quả xây dựng NTM");
				   request.setAttribute("chude",1);
			   	   phanTrangMain(dbo,request,response,"tinhtrang is true",link_page,"id_baiviet","tbl_baiviet",Definitions.PAGINATION_GIOITHIEU,values); 
			   }else{ //DTDA
				   //   condition =  "id_phanloai_baiviet=" + ;
				   request.setAttribute("row_tenthumuc","Ứng dụng nghiên cứu ĐTDA");
				   request.setAttribute("chude",2);
			   	   phanTrangMain(dbo,request,response,"tinhtrang is true",link_page,"id_baiviet","tbl_baiviet_detai",Definitions.PAGINATION_GIOITHIEU,values); 
			   }
			   break;
			}
         	case Definitions.VIEW_CONTENT_GIOITHIEU: {
         		so_id = request.getParameter("sogioithieu");
         		String chude = request.getParameter("chude");
        		if (!Utils.checkInteger(so_id) || !Utils.checkInteger(chude) ) {   			response.sendRedirect("404.jsp");
        			return;      		}
         		loadMenu(dbo, request);
         		condition = " id_baiviet = " + so_id;
         		if(chude.equals("1") ){ //NTM
         			  request.setAttribute("row_tenthumuc","Kết quả xây dựng NTM");
         			values = new String[] {
         					"ten_xadiem", "tentieude",
         					"tomtatnoidung", "noidungbv", "  TO_CHAR(TO_TIMESTAMP((ngaycongbo*86400 ) ) , 'DD/MM/YYYY') as ngaycongbo","noidung"
         			};
         			request.setAttribute("chude",1);
         			xemNoiDungMain(dbo,request,response,condition,values,"tbl_baiviet a inner join tbl_xadiem b on a.id_xadiem = b.id_xadiem",Definitions.VIEW_CONTENT_GIOITHIEU); 
         		}else{ 
         			values = new String[] {
             				"ten_xadiem","tendt", "masodt",  "tentieude",
    						"tomtatnoidung", "noidungbv", "  TO_CHAR(TO_TIMESTAMP((ngaycongbo*86400 ) ) , 'DD/MM/YYYY') as ngaycongbo","noidung"
                       };
         			 request.setAttribute("row_tenthumuc","Ứng dụng nghiên cứu ĐTDA");
         			request.setAttribute("chude",2);
         			xemNoiDungMain(dbo,request,response,condition,values,"tbl_baiviet_detai a inner join tbl_xadiem b on a.id_xadiem = b.id_xadiem "
         					+ " inner join tbl_detai_duan c on a.id_detai = c.id_detai "
         					+ " inner join tbl_thuyetminh_detai_duan d on a.id_thuyetminhdetai = d.id_thuyetminh_detai_duan ",Definitions.VIEW_CONTENT_GIOITHIEU); 
         		}
         		break; 
         	}
         	case Definitions.SUBJECT_SEARCH_GIOITHIEU:{
         		String chude = request.getParameter("chude");
  			    if (!Utils.checkInteger(chude) ) {	response.sendRedirect("404.jsp");
  				   return;   }
         		loadMenu(dbo, request);
         		tukhoa = request.getParameter("tukhoa");
         		condition = "tentieude ilike '%"+tukhoa+"%' and tinhtrang is true" ;
         		values = new String[] {
  					   	"id_baiviet", "id_xadiem", "tentieude",
  						"tomtatnoidung"
  			   };
         		link_page = "ChuyenTrang?tukhoa="+tukhoa+"&chude="+chude+"&action="+ Definitions.PAGINATION_GIOITHIEU +"&page=";
         		if(chude.equals("1") ){ //NTM
 				   request.setAttribute("row_tenthumuc","Kết quả xây dựng NTM");
 				   request.setAttribute("chude",1);
 			   	   phanTrangMain(dbo,request,response,condition,link_page,"id_baiviet","tbl_baiviet",Definitions.PAGINATION_GIOITHIEU,values); 
 			   }else{ //DTDA
 				   request.setAttribute("chude",2);
 				   request.setAttribute("row_tenthumuc","Ứng dụng nghiên cứu ĐTDA");
 			   	   phanTrangMain(dbo,request,response,condition,link_page,"id_baiviet","tbl_baiviet_detai",Definitions.PAGINATION_GIOITHIEU,values); 
 			   }
 			   break;         	
 			}
         
         	
         		
         	
         	default: response.sendRedirect(request.getContextPath()); break;
			}
			
			
			
			
		} catch (SQLException e) {
			System.out.println("WelcomeServlet SQLException: " + e.toString());
		} finally {
			if (conn != null) {
				dbo.closeConnection();
			}
		}
	}

	private void xemNoiDungMain(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response, String condition, String[] values, String table,int CodeRequest) throws ServletException, IOException {
		DlgMain dlgMain = new DlgMain();
		request.setAttribute("list", dlgMain.getDatatoEdit_Home(dbo, condition , values, table, false));
		request.setAttribute("page", CodeRequest);
		request.getRequestDispatcher("chuyentrang.jsp").forward(request, response);
	}
	
	private void phanTrangMain(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response, String condition, String link_page,
			String id_table,String table_name,int CodeRequest,
			String[] values) throws ServletException, IOException {
		DlgOperation dop = new DlgOperation();
		DlgMain dlgMain = new DlgMain();
		int trang_hientai = 1, tongso_dong = 0, dong_hienthi = 8  ;
		String trang_ht = request.getParameter("page");
		if ( Utils.checkInteger(trang_ht)) {
				trang_hientai = Integer.parseInt(trang_ht);
		}
		if(request.getParameter("soketquatrave") == null){
			request.setAttribute("fieldName", id_table);
			request.setAttribute("condition", condition );
			request.setAttribute("tableName", table_name);
			tongso_dong = Integer.parseInt(dop.checkCount(dbo, request));
		}else{
			tongso_dong = Integer.parseInt(request.getParameter("soketquatrave"));
		}
		int offset = (trang_hientai -1 ) * dong_hienthi;
		if (tongso_dong > 0) {
			int tongso_trang = (int) Math.ceil(tongso_dong * 1.0/ dong_hienthi);
			if (trang_hientai > tongso_trang) {
				trang_hientai = tongso_trang;
			}
			request.setAttribute("link_page", link_page);
			request.setAttribute("list", dlgMain.getRetrieveDataFromDatabase_PaginationHome(dbo, tongso_dong, dong_hienthi, offset, condition, false, values,table_name));
			request.setAttribute("soketquatrave", tongso_dong);
			request.setAttribute("tongso_trang", tongso_trang);
			request.setAttribute("currentPage", trang_hientai);
			request.setAttribute("page", CodeRequest);
			request.getRequestDispatcher("chuyentrang.jsp").forward(request, response);
		}
		else{
			request.setAttribute("page", CodeRequest);
			request.getRequestDispatcher("chuyentrang.jsp").forward(request, response);
		}
	}
	
	private void phanTrangTT(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response, String condition, String link_page) throws ServletException, IOException {
		DlgOperation dop = new DlgOperation();
		DlgTinTucHoatDong dlgTinTucHoatDong = new DlgTinTucHoatDong();
		int trang_hientai = 1, tongso_dong = 0, dong_hienthi = 8  ;
		String trang_ht = request.getParameter("page");
		if ( Utils.checkInteger(trang_ht)) {
				trang_hientai = Integer.parseInt(trang_ht);
		}
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"ten_phanloai"
		};
		request.setAttribute("row_tenthumuc", dlgMain.getRetrieveDataFromDatabase_Home(dbo, "id_phanloai_tintuc=" + request.getParameter("XemTT"), false, values, "tbl_phanloai_tintuc", null));
		
		if(request.getParameter("soketquatrave") == null){
			request.setAttribute("fieldName", "id_tintuc");
			request.setAttribute("condition", condition );
			request.setAttribute("tableName", "tbl_tintuc");
			tongso_dong = Integer.parseInt(dop.checkCount(dbo, request));
		}else{
			tongso_dong = Integer.parseInt(request.getParameter("soketquatrave"));
		}
		int offset = (trang_hientai -1 ) * dong_hienthi;
		if (tongso_dong > 0) {
			int tongso_trang = (int) Math.ceil(tongso_dong * 1.0/ dong_hienthi);
			if (trang_hientai > tongso_trang) {
				trang_hientai = tongso_trang;
			}
			request.setAttribute("link_page", link_page);
			request.setAttribute("list", dlgTinTucHoatDong.getDatato_TinTucHoatDongForm(dbo, tongso_dong, 0, dong_hienthi, offset, condition, false));
			request.setAttribute("soketquatrave", tongso_dong);
			request.setAttribute("tongso_trang", tongso_trang);
			request.setAttribute("currentPage", trang_hientai);
			request.setAttribute("page", "108");
			request.getRequestDispatcher("chuyentrang.jsp").forward(request, response);
		}
		else{
			request.setAttribute("page", "108");
			request.getRequestDispatcher("chuyentrang.jsp").forward(request, response);
		}
	}

	private void xemNoiDungTT(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String sotintuc = request.getParameter("sotintuc");
		DlgTinTucHoatDong dlgTinTucHoatDong = new DlgTinTucHoatDong();
		request.setAttribute("list", dlgTinTucHoatDong.getDatatoEdit_TinTucHoatDongForm(dbo, "id_tintuc="+sotintuc,false));
		//System.out.println(dlgTinTucHoatDong.getDatatoEdit_TinTucHoatDongForm(dbo, "id_tintuc="+sotintuc,false));
		request.setAttribute("page", "109");
		request.getRequestDispatcher("chuyentrang.jsp").forward(request, response);
	}

	private void xemNoiDungVB(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String sovanban = request.getParameter("sovanban");
		DlgVanBanPhapLy dlgVanBanPhapLy = new DlgVanBanPhapLy();
		request.setAttribute("list", dlgVanBanPhapLy.getDatatoEditDs_VanBanPhapLyForm(dbo, "id_vanbanphaply="+sovanban,false));
		request.setAttribute("page", "103");
		request.getRequestDispatcher("chuyentrang.jsp").forward(request, response);
	}

	private void phanTrangVB(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response, String condition, String link_page) throws ServletException, IOException {
		DlgOperation dop = new DlgOperation();
		DlgVanBanPhapLy dlgVanBanPhapLy = new DlgVanBanPhapLy();
		int trang_hientai = 1, tongso_dong = 0, dong_hienthi = 8  ;
		String trang_ht = request.getParameter("page");
		if ( Utils.checkInteger(trang_ht)) {
				trang_hientai = Integer.parseInt(trang_ht);
		}
		if(request.getParameter("soketquatrave") == null){
			request.setAttribute("fieldName", "id_vanbanphaply");
			request.setAttribute("condition", condition );
			request.setAttribute("tableName", "tbl_vanbanphaply");
			tongso_dong = Integer.parseInt(dop.checkCount(dbo, request));
		}else{
			tongso_dong = Integer.parseInt(request.getParameter("soketquatrave"));
		}
		int offset = (trang_hientai -1 ) * dong_hienthi;
		if (tongso_dong > 0) {
			int tongso_trang = (int) Math.ceil(tongso_dong * 1.0/ dong_hienthi);
			if (trang_hientai > tongso_trang) {
				trang_hientai = tongso_trang;
			}
			request.setAttribute("link_page", link_page);
			request.setAttribute("list", dlgVanBanPhapLy.getDatatoDs_VanBanPhapLyForm(dbo, tongso_dong, 0, dong_hienthi, offset, condition, false));
			request.setAttribute("soketquatrave", tongso_dong);
			request.setAttribute("tongso_trang", tongso_trang);
			request.setAttribute("currentPage", trang_hientai);
			request.setAttribute("page", "102");
			request.getRequestDispatcher("chuyentrang.jsp").forward(request, response);
		}
		else{
			request.setAttribute("page", "102");
			request.getRequestDispatcher("chuyentrang.jsp").forward(request, response);
		}
	} 
}
