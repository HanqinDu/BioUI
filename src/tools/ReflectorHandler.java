package tools;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class ReflectorHandler extends TaskHandler{

	private String input1 = "";

	public ReflectorHandler(HttpServletRequest request,
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
			case "input1":
				input1 = loadFile(part); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}

	@Override
	protected void onSetCommand() throws IOException {
		
		String[] command1 = {"sh", Config.REFLECT_SH, getUploadFilePath(), input1};
		String[] command2 = {"cp", "reflect_" + input1, Config.RESULT_DIR + File.separator + taskName + ".csv"};
		
		setCommand(command1);
		setCommand(command2, false);

		setResultMessage(hyperlink("result.csv", Config.RESULT_URL + File.separator + taskName + ".csv"));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.RESULT_DIR + File.separator + "concated.fasta");
		
		setProgram("reflector");
	}
}
