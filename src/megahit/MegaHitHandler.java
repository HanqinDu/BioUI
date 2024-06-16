package megahit;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class MegaHitHandler extends TaskHandler{
	
	private String threads = "60";
	private String parameters = "";
	private String kmer_min = "21";
	private String kmer_max = "141";
	private String kmer_step = "12";

	private String input = "";
	private String input_1 = "";
	private String input_2 = "";
	private String input_12 = "";
	private String input_r = "";

	private String fileNameTemp = "";

	public MegaHitHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
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
				threads = loadInt(part, 1, 60, "60"); break;
			case "kmer-min":
				kmer_min = loadInt(part, 1, 255, "21"); break;
			case "kmer-max":
				kmer_max = loadInt(part, 1, 255, "141"); break;
			case "kmer-step":
				kmer_step = loadInt(part, 1, 28, "12"); break;
			case "parameters":
				parameters = loadAny(part, 32, ""); break;
			case "input-1":
				fileNameTemp = loadFile(part, getUploadFilePath(), true);
				if(fileNameTemp.isEmpty()){break;}
				if(input_1.isEmpty()){input_1 = fileNameTemp;}
				else{input_1 = input_1 + "," + fileNameTemp;}
				break;
			case "input-2":
				fileNameTemp = loadFile(part, getUploadFilePath(), true);
				if(fileNameTemp.isEmpty()){break;}
				if(input_2.isEmpty()){input_2 = fileNameTemp;}
				else{input_2 = input_2 + "," + fileNameTemp;}
				break;
			case "input--12":
				fileNameTemp = loadFile(part, getUploadFilePath(), true);
				if(fileNameTemp.isEmpty()){break;}
				if(input_12.isEmpty()){input_12 = fileNameTemp;}
				else{input_12 = input_12 + "," + fileNameTemp;}
				break;
			case "input-r":
				fileNameTemp = loadFile(part, getUploadFilePath(), true);
				if(fileNameTemp.isEmpty()){break;}
				if(input_r.isEmpty()){input_r = fileNameTemp;}
				else{input_r = input_r + "," + fileNameTemp;}
				break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}
	
	@Override
	protected boolean onValidateInput(){
		if(getEmail().isEmpty()){
			setErrorReport("email cannot be empty for time-consuming task");
			return false;
		}

		if(input_1.isEmpty() & input_2.isEmpty() & input_12.isEmpty() & input_r.isEmpty()){
			setErrorReport("at least one input file is required");
			return false;
		}

		return true;
	}
	
	@Override
	protected void onSetCommand() throws IOException {

		if(!input_1.isEmpty()){input = input + " -1 " + input_1;}
		if(!input_2.isEmpty()){input = input + " -2 " + input_2;}
		if(!input_12.isEmpty()){input = input + " --12 " + input_12;}
		if(!input_r.isEmpty()){input = input + " -r " + input_r;}
		
		String[] command1 = {"sh", Config.MEGAHIT_SH, threads, kmer_min, kmer_max, kmer_step, parameters, input};
		String[] command2 = {"cp", "output/final.contigs.fa", Config.RESULT_DIR + File.separator + taskName + "_final.contigs.fa"};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage((hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + "_final.contigs.fa")));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("megahit");
		
	}
}
