package com.cwrs.ntk.servlets.ControllerQuanTri;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.cwrs.ntk.common.Definitions;
import com.cwrs.ntk.libraries.UnicodeToNosign;


@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UploadServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String codeRequest = request.getParameter("action");
	    System.out.println("--- Code Request: ---" + codeRequest);
	    if (codeRequest==null ||"null".equalsIgnoreCase(codeRequest))return;
	    
	    switch(Integer.parseInt(codeRequest)) {
	    	case Definitions.CODE_UPLOAD: uploadImage(request,response); break;
	    	case Definitions.CODE_DELETE: deleteImage(request,response); break;
	    	default:System.err.println("UNKNOW ACTION");  	break;
	    }
	}
	
	private void deleteImage(HttpServletRequest request,
			HttpServletResponse response) {
		String path = getServletContext().getRealPath(request.getParameter("deleteFile"));
		File file = new File(path);
        if (file.exists()) {
            file.delete(); 
        }
	}

	public void uploadImage(HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		String tenFoder = request.getParameter("folder");
		
		Calendar cal = Calendar.getInstance();
		int month = cal.get(Calendar.MONTH) + 1;
		int year = cal.get(Calendar.YEAR);
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		int minute = cal.get(Calendar.MINUTE);
		int second = cal.get(Calendar.SECOND);
		String path = getServletContext().getRealPath("uploads/");
		path += "/" + tenFoder + "/" + year + "/" + month + "/" ;

		File f_year = new File(path);
		if (!f_year.exists()) {
			f_year.mkdirs();
		}
		String tenHinh =  UnicodeToNosign.toUrlFriendly(request.getParameter("uploadfile"));
		
		InputStream filecontent = request.getInputStream();
		OutputStream out = new FileOutputStream(new File(path + hour + minute + second + tenHinh));
		String linkHinh = "uploads/" + tenFoder + "/" + year + "/" + month + "/" + hour + minute + second + tenHinh; 
		int read = 0;
		final byte[] bytes = new byte[1024];
		while ((read = filecontent.read(bytes)) != -1) {
			out.write(bytes, 0, read);
		}
		if (out != null) {
			out.close();
		}
		if (filecontent != null) {
			filecontent.close();
		}

		PrintWriter writeResponse = response.getWriter();
		JSONObject json = new JSONObject(); 
		
		json.put("success", true);
		json.put("link_image", linkHinh);
	 
		//System.out.println(json);
		writeResponse.print(json.toJSONString());
	}
}
