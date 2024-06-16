package prokka;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class ProkkaHandler extends TaskHandler{
	
	private String threads = "56";
	private String centre = "gene";
	private String kingdom = "Bacteria";
	private String evalue = "";
	private String coverage = "";
	private String addgenes = "";
	private String addmrna = "";
	private String cdsrnaolap = "";
	private String parameters = "";
	
	public ProkkaHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}

	private String loadDefaultFloat(Part part, float min, float max, String flag) throws IOException{
		String output;
		output = loadAny(part, 15, "");
		if(output.equals("default") | output.isEmpty()){
			return("");
		}else{
			return(flag + " " + loadFloat(part, min, max, ""));
		}
	}

	private String loadON(Part part, String flag) throws IOException{
		String input;
		input = loadAny(part, 8, "");
		if(input.equals("ON")){
			return flag;
		}
		return "";
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
			case "threads":
				threads = loadInt(part, 1, 56, "56"); break;
			case "centre":
				centre = loadAny(part, 10, "gene"); break;
			case "kingdom":
				kingdom = loadString(part, Arrays.asList("Archaea", "Bacteria", "Mitochondria", "Viruses"), "Bacteria"); break;
			case "evalue":
				evalue = loadDefaultFloat(part, 0, 1000, "--evalue"); break;
			case "coverage":
				coverage = loadDefaultFloat(part, 0, 100, "--coverage"); break;
			case "addgenes":
				addgenes = loadON(part, "--addgenes"); break;
			case "addmrna":
				addmrna = loadON(part, "--addmrna"); break;
			case "cdsrnaolap":
				cdsrnaolap = loadON(part, "--cdsrnaolap"); break;
			case "parameters":
				parameters = loadAny(part, 32, ""); break;
			case "input1":
				loadFile(part, getUploadFilePath()); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}
	

	@Override
	protected void onSetCommand() throws IOException {
		
		String[] command1 = {"sh", Config.PROKKA_SH, threads, kingdom, "--centre " + centre + " " + evalue + " " + coverage + " " + addgenes + " " + addmrna + " " + cdsrnaolap + " " + parameters};
		String[] command2 = {"tar", "-cf", Config.RESULT_DIR + File.separator + taskName + ".tar", "output", "log.txt", "log_error.txt"};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage((hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + ".tar")));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("Prokka");
	}
}
