package tools;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ConcatorListener")
@MultipartConfig(fileSizeThreshold=1024*1024*100, 	// 100 MB 
                 maxFileSize=1024*1024*500,      	// 200 MB
                 maxRequestSize=21474836480L)  // 500 MB
public class ConcatorListener extends HttpServlet{

	private static final long serialVersionUID = 6698629288145791175L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		ConcatorHandler handler = new ConcatorHandler(request, response, this);
		handler.run();
	}
}
