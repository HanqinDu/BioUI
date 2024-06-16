package comparem;

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


public class CompareMHandler extends TaskHandler{
	
	private String cpus = "56";
	private String itype = "";
	private String evalue = "";
	private String per_identity = "";
	private String per_aln_len = "";

	private ArrayList<String> input1 = new ArrayList<String>();

	public CompareMHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}

	private String loadFlagFloat(Part part, float min, float max, String flag) throws IOException{
		String output;
		output = loadAny(part, 8, "");
		if(!output.isEmpty()){
			output = loadFloat(part, min, max, "");
			output = flag + " " + output;
		}
		return output;
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
			case "cpus":
				cpus = loadInt(part, 1, 56, "56"); break;
			case "itype":
				itype = loadStringReplace(part, 
				Arrays.asList("genome", "protein"),
				Arrays.asList("", "--proteins"), "");
				break;
			case "evalue":
				evalue = loadFlagFloat(part, 0, 1000, "--evalue"); break;
			case "per_identity":
				per_identity = loadFlagFloat(part, 0, 1000, "--per_identity"); break;
			case "per_aln_len":
				per_aln_len = loadFlagFloat(part, 0, 1000, "--per_aln_len"); break;
			case "input1":
				input1.add(loadFile(part)); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}
	
	@Override
	protected void onSetCommand() throws IOException {
		ArrayListToFile(input1, getWorkDirectory() + File.separator + "query_genome.txt");

		String extension = "fna";
		if(!itype.isEmpty()){extension = "faa";}
		
		String[] command1 = {"sh", Config.COMPAREM_SH, cpus, itype + " " + evalue + " " + per_identity + " " + per_aln_len, extension};
		String[] command2 = {"tar", "-cf", Config.RESULT_DIR + File.separator + taskName + ".tar", "output/aai", "log.txt", "log_error.txt"};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage((hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + ".tar")));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("compareM");
	}
}
