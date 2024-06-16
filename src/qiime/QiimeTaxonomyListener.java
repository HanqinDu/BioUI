package qiime;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/QiimeTaxonomyListener")
@MultipartConfig(fileSizeThreshold=1024*1024, 	// 1 MB 
                 maxFileSize=5*1024*1024,      	// 5 MB
                 maxRequestSize=5*1024*1024)  // 5 MB
public class QiimeTaxonomyListener extends HttpServlet{

	private static final long serialVersionUID = 3935524245616768888L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		QiimeTaxonomyHandler handler = new QiimeTaxonomyHandler(request, response, this);
		handler.run();
	}
}
