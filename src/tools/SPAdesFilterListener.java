package tools;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SPAdesFilterListener")
@MultipartConfig(fileSizeThreshold=1024*1024*100, 	// 100 MB 
                 maxFileSize=1024*1024*500,      	// 200 MB
                 maxRequestSize=21474836480L)  // 500 MB
public class SPAdesFilterListener extends HttpServlet{

	private static final long serialVersionUID = 6691019288141953485L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		SPAdesFilterHandler handler = new SPAdesFilterHandler(request, response, this);
		handler.run();
	}
}
