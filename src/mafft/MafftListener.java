package mafft;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MafftListener")
@MultipartConfig(fileSizeThreshold=1024*1024*100, 	// 100 MB 
                 maxFileSize=1024*1024*500,      	// 500 MB
                 maxRequestSize=10737418240L)  // 10000 MB
public class MafftListener extends HttpServlet{

	private static final long serialVersionUID = 3935123432226665685L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		MafftHandler handler = new MafftHandler(request, response, this);
		handler.run();
	}

}
