package maxbin;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MaxbinListener")
@MultipartConfig(fileSizeThreshold=1024*1024*1024, 	// 1000 MB
                 maxFileSize=10737418240L,      // 10000 MB
                 maxRequestSize=21474836480L  // 20000 MB
)

public class MaxbinListener extends HttpServlet{

	private static final long serialVersionUID = 4761129379278611111L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		MaxbinHandler handler = new MaxbinHandler(request, response, this);
		handler.run();
	}

}
