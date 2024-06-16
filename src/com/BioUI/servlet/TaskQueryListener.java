package com.BioUI.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import linkshare.ShareLinkManager;

@WebServlet("/TaskQueryListener")
public class TaskQueryListener extends HttpServlet{
	private static final long serialVersionUID = 3913524288143995685L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException{ 
		new GetTaskStat(this, request, response).run();
	}
}


class GetTaskStat implements Runnable{
	private HttpServlet listener; 
	private HttpServletRequest request; 
	private HttpServletResponse response;
	
	GetTaskStat(HttpServlet listener, HttpServletRequest request, HttpServletResponse response){
		this.listener = listener;
		this.request = request;
		this.response = response;
	}
	
	private String StreamToString(InputStream inputstream) {
		InputStreamReader isReader = new InputStreamReader(inputstream);
		BufferedReader reader = new BufferedReader(isReader);
		StringBuffer sb = new StringBuffer();
		String str;
		try {
			int count = 0;

			while((str = reader.readLine())!= null){
				if(count >= 2 & count < 4){
					sb.append("<tr><td>");
					sb.append(str);
					sb.append("</td></tr>");
				}
				count = count + 1;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return(sb.toString());
    }
	

	@Override
	public void run() {

		try {
			String[] command = {"sh", Config.CPUSTAT_SH};
			ProcessBuilder pb = new ProcessBuilder(command);
			
			Process pc = pb.start();
			pc.waitFor();
			
			String message = "";
			message = message + "<table>" + StreamToString(pc.getInputStream()) + "</table>";
			
			request.setAttribute("message", message + "<br>" + "<p>" + TaskMonitor.getTaskAsString() + "</p>");

			request.setAttribute("shareLink", ShareLinkManager.getShareLink(false));
						
			listener.getServletContext().getRequestDispatcher("/index2.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}