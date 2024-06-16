package abi2seq;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ABI2SEQListener")
@MultipartConfig(fileSizeThreshold=1024*1024*100, 	// 100 MB 
                 maxFileSize=1024*1024*500,      	// 200 MB
                 maxRequestSize=21474836480L)  // 20 G
public class ABI2SEQListener extends HttpServlet{

	private static final long serialVersionUID = 3035813182689154412L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		ABI2SEQHandler handler = new ABI2SEQHandler(request, response, this);
		handler.run();
	}
}
