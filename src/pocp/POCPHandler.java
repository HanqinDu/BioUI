package pocp;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class POCPHandler extends TaskHandler{
	
	private String threads = "56";

	private ArrayList<String> input1 = new ArrayList<String>();

	public POCPHandler(HttpServletRequest request,
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
			case "threads":
				threads = loadInt(part, 1, 56, "56"); break;
			case "input1":
				input1.add(loadFile(part)); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}

	@Override
	protected boolean onValidateInput(){
		boolean valid = true;

		for(String filename: input1){
			if(filename.replaceAll("\\.[_a-zA-Z]*$", "").length() > 42){
				setErrorReport("the filename <b>" + filename.replaceAll("\\.[_a-zA-Z]*$", "") + "</b> exceed the length limit of 42.");
				valid = false;
			}
        }

		return valid;
	}

	@Override
	protected void onSetCommand() throws IOException {

		String[] command1 = {"sh", Config.POCP_SH, getWorkDirectory(), Config.ADDID_PATH, Config.POCP_PATH, threads};
		String[] command2 = {"cp", "POCP.csv", Config.RESULT_DIR + File.separator + taskName + "_POCP.csv"};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage("<br>");
		setResultMessage(hyperlink("POCP.csv", Config.RESULT_URL + File.separator + taskName + "_POCP.csv"));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.RESULT_DIR + File.separator + "POCP.csv");
		
		setProgram("POCP");
	}
}
