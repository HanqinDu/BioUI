package spades;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SPAdesListener")
@MultipartConfig(fileSizeThreshold=1024*1024*1024, 	// 1000 MB 
                 maxFileSize=1024*1024*1024*5,      // 5000 MB
                 maxRequestSize=21474836480L)  // 10000 MB
public class SPAdesListener extends HttpServlet{

	private static final long serialVersionUID = 3935528339526635685L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		SPAdesHandler handler = new SPAdesHandler(request, response, this);
		handler.run();
	}

}
