package quast;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class QuastHandler extends TaskHandler{
	
	private String threads = "56";
	private String min_contigs = "";
	private String parameters = "";
	private String file_contig = "";
	private String file_optional = "";
	
	public QuastHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}

	private String loadOptionalFile(Part part, String flag) throws IOException{
		String fileNameTemp;
		fileNameTemp = loadFile(part, getUploadFilePath(), true);
		if(!fileNameTemp.isEmpty()){
			return(flag + " " + fileNameTemp);
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
				break;
			case "email":
				setEmail(loadAny(part, 50, "")); break;
			case "threads":
				threads = loadInt(part, 1, 56, "56"); break;
			case "min_contigs":
				min_contigs = loadInt(part, 0, 99999999, "");
				if(!min_contigs.isEmpty()){min_contigs = "-m " + min_contigs;}
				break;
			case "parameters":
				parameters = loadAny(part, 32, ""); break;
			case "input-contig":
				file_contig = file_contig + " " + loadFile(part, getUploadFilePath()); break;
			case "input-r":
				file_optional = file_optional + " " + loadOptionalFile(part, "-r"); break;
			case "input-g":
				file_optional = file_optional + " " + loadOptionalFile(part, "-g"); break;
			case "input--pe1":
				file_optional = file_optional + " " + loadOptionalFile(part, "--pe1"); break;
			case "input--pe2":
				file_optional = file_optional + " " + loadOptionalFile(part, "--pe2"); break;
			case "input--pe12":
				file_optional = file_optional + " " + loadOptionalFile(part, "--pe12"); break;
			case "input--mp1":
				file_optional = file_optional + " " + loadOptionalFile(part, "--mp1"); break;
			case "input--mp2":
				file_optional = file_optional + " " + loadOptionalFile(part, "--mp2"); break;
			case "input--mp12":
				file_optional = file_optional + " " + loadOptionalFile(part, "--mp12"); break;
			case "input--single":
				file_optional = file_optional + " " + loadOptionalFile(part, "--single"); break;
			case "input--pacbio":
				file_optional = file_optional + " " + loadOptionalFile(part, "--pacbio"); break;
			case "input--nanopore":
				file_optional = file_optional + " " + loadOptionalFile(part, "--nanopore"); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}
	
	@Override
	protected void onSetCommand() throws IOException {
		
		String[] command1 = {"sh", Config.QUAST_SH, threads, min_contigs + " " + 	parameters + " " + file_optional, file_contig};
		String[] command2 = {"tar", "-c", "-f", Config.RESULT_DIR + File.separator + taskName + ".tar", "output", "log.txt", "log_error.txt"};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage((hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + ".tar")));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("QUAST");
	}
}
