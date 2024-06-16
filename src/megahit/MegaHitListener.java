package megahit;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MegaHitListener")
@MultipartConfig(fileSizeThreshold=1024*1024*1024*1, 	// 1 GB
                 maxFileSize=1024*1024*1024*5,      	// 5 GB
                 maxRequestSize=21474836480L)  // 10 GB
public class MegaHitListener extends HttpServlet{

	private static final long serialVersionUID = 5933312432464265685L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		MegaHitHandler handler = new MegaHitHandler(request, response, this);
		handler.run();
	}

}
