package tANI;

import java.io.File;
import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class TANIHandler extends TaskHandler{
	
	private String ID = "0.7";
	private String CV = "0.7";
	private String BT = "100";
	private String evalue = "0.0001";

	public TANIHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}
	
	@Override
	protected void onReceive(Part part) throws IOException {
		switch(part.getName()){
			case "task":
				taskName = loadTaskName(part, 32, "task");
				taskName = autoTaskFolder(taskName);
				break;
			case "email":
				setEmail(loadAny(part, 50, "")); break;
			case "identity_cutoff":
				ID = loadFloat(part, 0, 1, "0.7"); break;
			case "coverage_cutoff":
				CV = loadFloat(part, 0, 1, "0.7"); break;
			case "bootstraps":
				BT = loadInt(part, 1, 10000, "100"); break;
			case "evalue":
				evalue = loadFloat(part, 0, 100, "0.0001"); break;
			case "input1":
				loadFile(part); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}

	@Override
	protected void onSetCommand() throws IOException {

		String[] command1 = {"sh", Config.TANI_SH, Config.TANI_PERL, Config.TANITREE_R, ID, CV, BT, evalue};
		String[] command2 = {"tar", "-cf", Config.RESULT_DIR + File.separator + taskName + ".tar", "Outputs", "log.txt", "log_error.txt"};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage(hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + ".tar"));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.RESULT_DIR + File.separator + taskName + "_ANI.out");
		
		setProgram("tANI");
	}
}
