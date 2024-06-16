package tools;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class SPAdesFilterHandler extends TaskHandler{

	public SPAdesFilterHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}

	String inputFile;
	String covcut = "0";
	String lencut = "0";
	
	@Override
	protected void onReceive(Part part) throws IOException {
		switch(part.getName()){
			case "task":
				taskName = loadTaskName(part, 32, "task");
				taskName = autoTaskFolder(taskName);
				break;
			case "covcut":
				covcut = loadFloat(part, (float) 0, 1000000, "0"); break;
			case "lencut":
				lencut = loadFloat(part, (float) 0, 1000000, "0"); break;
			case "input1":
				inputFile = loadFile(part); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}

	@Override
	protected void onSetCommand() throws IOException {

		String[] command1 = {Config.SPADES_FILTER, inputFile, "filtered_" + inputFile, covcut, lencut};
		String[] command2 = {"cp", "filtered_" + inputFile, Config.RESULT_DIR + File.separator + taskName + "_" + inputFile};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage(hyperlink("filtered_" + inputFile, Config.RESULT_URL + File.separator + taskName + "_" + inputFile));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		
		setProgram("SPAdes contig filter");
	}
}
