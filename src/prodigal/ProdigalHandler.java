package prodigal;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class ProdigalHandler extends TaskHandler{
	
	private String procedure = "single";
	private ArrayList<String> input1 = new ArrayList<String>();

	public ProdigalHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}
	
	@Override
	protected void onReceive(Part part) throws IOException {
		switch(part.getName()){
			case "task":
				taskName = loadTaskName(part, 32, "task");
				taskName = autoTaskFolder(taskName);
				
				setUploadFilePath(getUploadFilePath() + File.separator + "input");
				new File(getUploadFilePath()).mkdir();
				
				break;
			case "email":
				setEmail(loadAny(part, 50, "")); break;
			case "procedure":
				procedure = loadString(part, Arrays.asList("single", "meta"), "single"); break;
			case "input1":
				input1.add(loadFile(part)); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}

	@Override
	protected void onSetCommand() throws IOException {
		ArrayListToFile(input1, getWorkDirectory() + File.separator + "query_list.txt");
		
		String[] command1 = {"sh", Config.PRODIGAL_SH, getWorkDirectory() + File.separator + "query_list.txt", procedure};
		String[] command2 = {"tar", "-cf", Config.RESULT_DIR + File.separator + taskName + ".tar", "output", "log.txt", "log_error.txt"};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage(hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + ".tar"));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("Prodigal");
		
	}
}
