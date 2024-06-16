package mafft;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class MafftHandler extends TaskHandler{
	
	private String threads = "56";
	private String algorithm = "--localpair --maxiterate ";
	private String maxiterate = "2";
	private String input = "";

	public MafftHandler(HttpServletRequest request,
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
				threads = loadInt(part, 1, 56, "56"); break;
			case "algorithm":
				algorithm = loadStringReplace(part, 
				Arrays.asList("Auto", "FFT-NS-1", "FFT-NS-2", "FFT-NS-i", "E-INS-i", "L-INS-i", "G-INS-i", "Q-INS-i", "X-INS-i"),
				Arrays.asList("mafft --auto", "mafft --retree 1", "mafft --retree 2", "mafft --maxiterate ",
				"mafft --genafpair --maxiterate ", "mafft --localpair --maxiterate ", "mafft --globalpair --maxiterate ", "mafft-qinsi", "mafft-xinsi"),
				"mafft --auto");
				break;
			case "maxiterate":
				maxiterate = loadInt(part, 0, 2000, "2");break;
			case "input1":
				input = loadFile(part); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}
	
	@Override
	protected void onSetCommand() throws IOException {
		if(algorithm.contains("maxiterate")){
			algorithm = algorithm + maxiterate;
		}
		
		String[] command1 = {"sh", Config.MAFFT_SH, input, threads, algorithm};
		String[] command2 = {"tar", "-cf", Config.RESULT_DIR + File.separator + taskName + ".tar", "output", "log.txt", "log_error.txt"};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage((hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + ".tar")));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("mafft");
		
	}
}
