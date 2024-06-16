package gtdbtk;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GTDBTKListener")
@MultipartConfig(fileSizeThreshold=1024*1024*100, 	// 100 MB 
                 maxFileSize=1024*1024*500,      	// 500 MB
                 maxRequestSize=21474836480L)  // 10000 MB
public class GTDBTKListener extends HttpServlet{

	private static final long serialVersionUID = 3925524288143997685L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		GTDBTKHandler handler = new GTDBTKHandler(request, response, this);
		handler.run();
	}
}
