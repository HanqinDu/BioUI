package signStat;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SignStatListener")
@MultipartConfig(fileSizeThreshold=1024*1024*100, 	// 100 MB 
                 maxFileSize=1024*1024*500,      	// 500 MB
                 maxRequestSize=21474836480L)  // 10000 MB
public class SignStatListener extends HttpServlet{

	private static final long serialVersionUID = 3895229288113895685L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		SignStatHandler handler = new SignStatHandler(request, response, this);
		handler.run();
	}
}
