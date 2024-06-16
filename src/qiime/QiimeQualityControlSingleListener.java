package qiime;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/QiimeQualityControlSingleListener")
@MultipartConfig(fileSizeThreshold=1024*1024, 	// 1 MB 
                 maxFileSize=5*1024*1024,      	// 5 MB
                 maxRequestSize=5*1024*1024)  // 5 MB
public class QiimeQualityControlSingleListener extends HttpServlet{

	private static final long serialVersionUID = 3935724345616769853L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		QiimeQualityControlSingleHandler handler = new QiimeQualityControlSingleHandler(request, response, this);
		handler.run();
	}
}
