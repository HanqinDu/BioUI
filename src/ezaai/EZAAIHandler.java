package ezaai;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class EZAAIHandler extends TaskHandler{
	
	private String threads = "56";

	private ArrayList<String> input1 = new ArrayList<String>();
	private ArrayList<String> input2 = new ArrayList<String>();
	private ArrayList<String> input3 = new ArrayList<String>();

	public EZAAIHandler(HttpServletRequest request,
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
				input1.add(loadFile(part, getUploadFilePath(), true)); break;
			case "input2":
				input2.add(loadFile(part, getUploadFilePath(), true)); break;
			case "input3":
				input3.add(loadFile(part, getUploadFilePath(), true)); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}

	@Override
	protected boolean onValidateInput(){
		if(input1.get(0).length() == 0 & input2.get(0).length() == 0 & input3.get(0).length() == 0){
			setErrorReport("please upload at least one file");
			return false;
		}

		return true;
	}
	
	@Override
	protected void onSetCommand() throws IOException {
		ArrayListToFile(input1, getWorkDirectory() + File.separator + "query_genome.txt");
		ArrayListToFile(input2, getWorkDirectory() + File.separator + "query_CDS.txt");
		ArrayListToFile(input3, getWorkDirectory() + File.separator + "query_protein.txt");
		
		String[] command1 = {"sh", Config.EZAAI_SH, Config.EZAAI_PATH, "query_genome.txt", "query_CDS.txt", "query_protein.txt", taskName, threads};
		String[] command2 = {"cp", taskName + "_AAI.txt", taskName + "_cluster.txt", Config.RESULT_DIR};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage((hyperlink("AAI.txt", Config.RESULT_URL + File.separator + taskName + "_AAI.txt")));
		setResultMessage((hyperlink("cluster.txt", Config.RESULT_URL + File.separator + taskName + "_cluster.txt")));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("EzAAI");
		
	}
}
