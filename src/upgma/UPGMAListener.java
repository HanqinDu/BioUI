package upgma;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UPGMAListener")
@MultipartConfig(fileSizeThreshold=1024*1024*100, 	// 100 MB 
                 maxFileSize=1024*1024*500,      	// 200 MB
                 maxRequestSize=21474836480L)  // 20 G
public class UPGMAListener extends HttpServlet{

	private static final long serialVersionUID = 3935313182686624985L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		UPGMAHandler handler = new UPGMAHandler(request, response, this);
		handler.run();
	}
}
