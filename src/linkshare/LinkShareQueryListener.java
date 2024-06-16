package linkshare;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LinkShareQueryListener")
public class LinkShareQueryListener extends HttpServlet{
	private static final long serialVersionUID = 3913504280043953628L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException{ 
		new GetShareLink(this, request, response).run();
	}
}


class GetShareLink implements Runnable{
	private HttpServlet listener; 
	private HttpServletRequest request; 
	private HttpServletResponse response;
	
	GetShareLink(HttpServlet listener, HttpServletRequest request, HttpServletResponse response){
		this.listener = listener;
		this.request = request;
		this.response = response;
	}

	@Override
	public void run() {

		try {
			request.setAttribute("shareLink", ShareLinkManager.getShareLink(true));
			listener.getServletContext().getRequestDispatcher("/link_share_edit.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}