package qiime;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/QiimeQualityControlPairListener")
@MultipartConfig(fileSizeThreshold=1024*1024*100, 	// 100 MB 
                 maxFileSize=1024*1024*500,      	// 500 MB
                 maxRequestSize=21474836480L)  // 10000 MB
public class QiimeQualityControlPairListener extends HttpServlet{

	private static final long serialVersionUID = 3935524245616762222L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		QiimeQualityControlPairHandler handler = new QiimeQualityControlPairHandler(request, response, this);
		handler.run();
	}
}
