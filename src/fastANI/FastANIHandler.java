package fastANI;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class FastANIHandler extends TaskHandler{
	
	private String threads     = "56";
	private String kmer        = "";
	private String minFraction = "";
	private String fragLen     = "";
	
	private ArrayList<String> input1 = new ArrayList<String>();

	public FastANIHandler(HttpServletRequest request,
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
			case "fragLen":
				fragLen = loadInt(part,200,10000000,""); break;
			case "kmer":
				kmer = loadInt(part,5,16,""); break;
			case "minFraction":
				minFraction = loadFloat(part, 0, 1, ""); break;
			case "email":
				setEmail(loadAny(part, 50, "")); break;
			case "threads":
				threads = loadInt(part, 1, 56, "56"); break;
			case "input1":
				input1.add(loadFile(part, getUploadFilePath())); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}

	@Override
	protected void onSetCommand() throws IOException {
		ArrayListToFile(input1, getUploadFilePath() + File.separator + "query_list.txt");
		ArrayListToFile(input1, getUploadFilePath() + File.separator + "reference_list.txt");

		String[] command = {"sh", Config.FASTANI_SH, "query_list.txt", "reference_list.txt",
				Config.RESULT_DIR + File.separator + taskName + "_ANI.out", addFlag(threads, "-t") +
				addFlag(kmer, "-k") + addFlag(minFraction, "--minFraction") + addFlag(fragLen, "--fragLen")};
		
		setCommand(command);
		
		setResultMessage("<br>");
		setResultMessage(hyperlink("ANI.out", Config.RESULT_URL + File.separator + taskName + "_ANI.out"));
		setResultMessage(hyperlink("ANI.out.matrix", Config.RESULT_URL + File.separator + taskName + "_ANI.out.matrix"));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.RESULT_DIR + File.separator + taskName + "_ANI.out");
		
		setProgram("fastANI");
	}
}
