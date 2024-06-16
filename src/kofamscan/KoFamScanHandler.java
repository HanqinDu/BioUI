package kofamscan;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class KoFamScanHandler extends TaskHandler{
	
	private String threads = "56";
	private String parameters = "";
	private String outfmt = "detail";
	private String evalue = "";
	private String threshold = "";

	private String input1 = "";

	public KoFamScanHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}

	private String loadDefaultFloat(Part part, float min, float max, String flag) throws IOException{
		String output;
		output = loadAny(part, 8, "");
		if(output.equals("default") | output.isEmpty()){
			output = "";
		}else{
			output = loadFloat(part, min, max, "");
			output = flag + " " + output;
		}
		return output;
	}
	
	@Override
	protected void onReceive(Part part) throws IOException {
		// TODO Auto-generated method stub
		switch(part.getName()){
			case "task":
				taskName = loadAny(part, 32, "task");
				taskName = autoTaskFolder(taskName);
				setWorkDirectory(getUploadFilePath());
				break;
			case "email":
				setEmail(loadAny(part, 50, "")); break;
			case "threads":
				threads = loadInt(part, 1, 56, "56"); break;
			case "evalue":
				evalue = loadDefaultFloat(part, 0, 1000, "-E"); break;
			case "threshold":
				threshold = loadDefaultFloat(part, 0, 1000, "-T"); break;
			case "outfmt":
				outfmt = loadString(part, Arrays.asList("detail", "detail-tsv", "mapper", "mapper-one-line"), "detail"); break;
			case "parameters":
				parameters = loadAny(part, 32, ""); break;
			case "input1":
				input1 = loadFile(part);break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}
	
	@Override
	protected void onSetCommand() throws IOException {

		evalue = addFlag(evalue, "-E");
		threshold = addFlag(threshold, "-T");
		
		String[] command1 = {"sh", Config.KOFAMSCAN_SH, Config.KOFAMHMM_PATH, Config.KOLIST_PATH, threads, outfmt,
		evalue + " " + threshold + " " + parameters, input1};
		String[] command2 = {"tar", "-cf", Config.RESULT_DIR + File.separator + taskName + ".tar", "output", "log.txt", "log_error.txt"};

		setCommand(command1);
		setCommand(command2, false);

		setResultMessage((hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + ".tar")));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("KoFamScan");
		
	}
}
