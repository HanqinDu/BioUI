package tools;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SplitterListener")
@MultipartConfig(fileSizeThreshold=1024*1024*100, 	// 100 MB 
                 maxFileSize=1024*1024*500,      	// 200 MB
                 maxRequestSize=21474836480L)  // 500 MB
public class SplitterListener extends HttpServlet{

	private static final long serialVersionUID = 4348674788145791175L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		SplitterHandler handler = new SplitterHandler(request, response, this);
		handler.run();
	}
}
