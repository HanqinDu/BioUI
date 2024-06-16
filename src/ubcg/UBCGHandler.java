package ubcg;

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


public class UBCGHandler extends TaskHandler{
	
	private String taskDirectory = "/home";

	private String alignment = "nt";
	private String threads = "56";
	
	private ArrayList<String> input1 = new ArrayList<String>();

	public UBCGHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}
	
	@Override
	protected void onReceive(Part part) throws IOException {
		// TODO Auto-generated method stub
		switch(part.getName()){
			case "task":
				taskName = loadTaskName(part, 32, "task");
				taskName = autoTaskFolder(taskName);
				
				taskDirectory = getUploadFilePath();
				
				setUploadFilePath(getUploadFilePath() + File.separator + "input");
				new File(getUploadFilePath()).mkdir();
				
				break;
			case "email":
				setEmail(loadAny(part, 50, "")); break;
			case "alignment":
				alignment = loadString(part, Arrays.asList("nucleotide", "amino_acid", "codon_based", "codon12"), "nucleotide");
				switch(alignment){
					case "nucleotide":
						alignment = "nt"; break;
					case "amino_acid":
						alignment = "aa"; break;
					case "codon":
						alignment = "codon"; break;
					case "codon12":
						alignment = "codon12";
				}
				break;
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

		setWorkDirectory(Config.UBCG_PATH);
		setLogDirectory(taskDirectory);
		
		ArrayListToFile(input1, taskDirectory + File.separator + "query_list.txt");
		
		String[] command1 = {"sh", Config.UBCG_SH, taskDirectory + File.separator + "query_list.txt", taskDirectory, threads, alignment};
		String[] command2 = {"sh", Config.UBCGPLOT_SH, taskDirectory};
		String[] command3 = {"tar", "-cf", taskDirectory + File.separator + taskName + ".tar", 
				taskDirectory + File.separator + "output",
				taskDirectory + File.separator + "log.txt",
				taskDirectory + File.separator + "log_error.txt",
				taskDirectory + File.separator + "Rplot"};
		String[] command4 = {"mv", taskDirectory + File.separator + taskName + ".tar", Config.RESULT_DIR};
		
		setCommand(command1);
		setCommand(command2, false);
		setCommand(command3, false);
		setCommand(command4, false);
		
		setResultMessage(hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + ".tar"));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("UBCG");
		
	}
}
