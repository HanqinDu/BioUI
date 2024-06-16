package upgma;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class UPGMAHandler extends TaskHandler{
	
	private String path      = "";
	private String algorithm = "upgma";
	private String itype     = "similarity";
	private String vline     = "none";

	public UPGMAHandler(HttpServletRequest request,
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
			case "algorithm":
				algorithm = loadString(part, Arrays.asList("upgma", "wpgma"), "upgma"); 
				break;
			case "itype":
				itype = loadString(part, Arrays.asList("distance", "similarity"), "similarity"); 
				break;
			case "vline":
				vline = loadAny(part, 10000, "none"); break;
			case "input1":
				path = loadFile(part); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}
	
	@Override
	protected void onSetCommand() throws IOException {
		
		String[] command1 = {"sh", Config.UPGMA_SH, path, algorithm, itype, vline, taskName};
		String[] command2 = {"cp", taskName + "_tree.phy", taskName + "_tree.svg", Config.RESULT_DIR};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage("");
		setResultMessage((hyperlink("tree.phy", Config.RESULT_URL + File.separator + taskName + "_tree.phy")));
		setResultMessage((hyperlink("tree.svg", Config.RESULT_URL + File.separator + taskName + "_tree.svg")));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("UPGMA");
	}
}
