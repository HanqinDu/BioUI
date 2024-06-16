package prokka;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProkkaListener")
@MultipartConfig(fileSizeThreshold=1024*1024*100, 	// 100 MB 
                 maxFileSize=1024*1024*500,      	// 500 MB
                 maxRequestSize=21474836480L)  // 10000 MB
public class ProkkaListener extends HttpServlet{

	private static final long serialVersionUID = 3777113379526612216L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		ProkkaHandler handler = new ProkkaHandler(request, response, this);
		handler.run();
	}

}
