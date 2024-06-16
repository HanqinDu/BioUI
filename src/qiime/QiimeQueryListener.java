package qiime;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.BioUI.servlet.Config;

@WebServlet("/QiimeQueryListener")
public class QiimeQueryListener extends HttpServlet{
	private static final long serialVersionUID = 3913524288143990000L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException{ 
		// format: step=quality_control&taskname=task_3
		
		String step = request.getParameter("step");
		String taskname = request.getParameter("taskname");

		if(taskname.isEmpty() || step.isEmpty()){
			request.setAttribute("message", "<font color=\"#DF1C44\">invalid query format</font>");
			this.getServletContext().getRequestDispatcher("/response.jsp").forward(request, response);
			return;
		}

		if(!Files.isDirectory(Paths.get(Config.UPLOAD_DIR + File.separator + taskname))){
			request.setAttribute("message", "<font color=\"#DF1C44\">task folder cannot be found</font>");
			this.getServletContext().getRequestDispatcher("/response.jsp").forward(request, response);
			return;
		}

		switch(step){
			case "quality_control":
				if(new File(Config.UPLOAD_DIR + File.separator + taskname + File.separator + "single.flag").exists()){
					request.setAttribute("taskname", taskname);
					this.getServletContext().getRequestDispatcher("/qiime_quality_control_single.jsp").forward(request, response);
				}else{
					request.setAttribute("taskname", taskname);
					this.getServletContext().getRequestDispatcher("/qiime_quality_control_pair.jsp").forward(request, response);
				}
				break;
			case "cluster":
				request.setAttribute("taskname", taskname);
				this.getServletContext().getRequestDispatcher("/qiime_cluster.jsp").forward(request, response);
				break;
			case "phylogeny":
				request.setAttribute("taskname", taskname);
				this.getServletContext().getRequestDispatcher("/qiime_phylogeny.jsp").forward(request, response);
				break;
			case "diversity":
				request.setAttribute("taskname", taskname);
				this.getServletContext().getRequestDispatcher("/qiime_diversity.jsp").forward(request, response);
				break;
			case "taxonomy":
				request.setAttribute("taskname", taskname);
				this.getServletContext().getRequestDispatcher("/qiime_taxonomy.jsp").forward(request, response);
				break;
			default:
				request.setAttribute("message", "<font color=\"#DF1C44\">unknow step: " + step + "</font>");
				this.getServletContext().getRequestDispatcher("/response.jsp").forward(request, response);
		}
	}
}


