package orthoANIu;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import bi.service.orthoani.main.main;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.RunTerminal;
import com.BioUI.servlet.TaskHandler;
import com.BioUI.servlet.TaskMonitor;


public class OrthoANIuHandler extends TaskHandler{

	private String format = "list";
	private String threads = "56";
	
	public OrthoANIuHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}
	
	@Override
	protected void onReceive(Part part) throws IOException {
		// TODO Auto-generated method stub

		switch(part.getName()){
			case "task":
				taskName = loadAny(part, 32, "task");
				taskName = autoTaskFolder(taskName);
				
				setUploadFilePath(getUploadFilePath() + File.separator + "input");
				new File(getUploadFilePath()).mkdir();
				break;
			case "email":
				setEmail(loadAny(part, 50, "")); break;
			case "format":
				format = loadString(part, Arrays.asList("list", "matrix", "json"), "list"); break;
			case "threads":
				threads = loadInt(part, 1, 56, "56"); break;
			case "input1":
				loadFile(part);break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}
	
	@Override
	protected void onSetCommand() throws IOException {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	protected void onExecute() throws ServletException, IOException{
		final String[] command = {"-fd", getUploadFilePath(), "-o", Config.RESULT_DIR + File.separator + taskName + "_ANI.out",
				"-fmt", format, "-n", threads, "-u", Config.USEARCH_PATH};
		
		String message = "task <b>" + taskName + " </b>complete: " 
				+ hyperlink("ANI.out", Config.RESULT_URL + File.separator + taskName + "_ANI.out");
		
		TaskMonitor.post(taskName, "OrthoANIu");
		
		if(getEmail().isEmpty()){
			try {
				main.main(command);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			TaskMonitor.post(taskName, "");
			
			request.setAttribute("message", message);
	        listener.getServletContext().getRequestDispatcher("/response.jsp").forward(request, response);
		}else{
			final RunTerminal runner = new RunTerminal(){
				@Override
				public void run() {
					try {
						main.main(command);
						TaskMonitor.post(taskName, "");
						this.sendEmailNotification();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			};
			
			runner.setWorkPath(getWorkDirectory());
			
			runner.setEmail(getEmail());
			runner.appendEmailContent(message);
			runner.setTaskName(taskName);
			
			
			Thread t = new Thread(runner);
			t.start();
			
			request.setAttribute("message", "Upload complete. Your task ID is <b>" + taskName + "</b>, you will receive an email when the task is done");
	        listener.getServletContext().getRequestDispatcher("/response.jsp").forward(request, response);
	        
		}
	}
}
