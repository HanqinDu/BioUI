package pocp;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/POCPListener")
@MultipartConfig(fileSizeThreshold=1024*1024*100, 	// 100 MB 
                 maxFileSize=1024*1024*500,      	// 200 MB
                 maxRequestSize=21474836480L)  // 500 MB
public class POCPListener extends HttpServlet{

	private static final long serialVersionUID = 4939179288145995675L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		POCPHandler handler = new POCPHandler(request, response, this);
		handler.run();
	}
}
