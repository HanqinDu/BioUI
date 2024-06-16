package tRNAscanSE;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/tRNAscanSEListener")
@MultipartConfig(fileSizeThreshold=1024*1024*100, 	// 100 MB 
				 maxFileSize=1024*1024*500,      	// 500 MB
				 maxRequestSize=1024*1024*1024*10)  // 10000 MB
public class tRNAscanSEListener extends HttpServlet{

	private static final long serialVersionUID = 3935524555616665685L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		tRNAscanSEHandler handler = new tRNAscanSEHandler(request, response, this);
		handler.run();
	}
}
