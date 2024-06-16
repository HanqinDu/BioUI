package tRNAscanSE;

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


public class tRNAscanSEHandler extends TaskHandler{
	
	private String kingdom = "-B";
	private String otherRNA = "";
	private String mitochondrialRNA = "";
	private String primary = "";
	
	private ArrayList<String> input1 = new ArrayList<String>();

	public tRNAscanSEHandler(HttpServletRequest request,
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
				
				setUploadFilePath(getUploadFilePath() + File.separator + "input");
				new File(getUploadFilePath()).mkdir();
				
				break;
			case "email":
				setEmail(loadAny(part, 50, "")); break;
			case "kingdom":
				kingdom = loadStringReplace(part,
					Arrays.asList("All", "Bacterial", "Eukaryotic", "Archaeal", "Other"),
					Arrays.asList("-G", "-B", "-E", "-A", "-O"), "-G");
				break;
			case "mitochondrialRNA":
				mitochondrialRNA = loadString(part, Arrays.asList("no", "mammal", "vert"), "no");
				switch(mitochondrialRNA){
					case "no":
						mitochondrialRNA = ""; break;
					case "mammal":
						mitochondrialRNA = "-M mammal"; break;
					case "vert":
						mitochondrialRNA = "-M vert";
				}
				break;
			case "primary":
				primary = loadString(part, Arrays.asList("no", "yes"), "no");
				switch(primary){
					case "no":
						primary = ""; break;
					case "yes":
						primary = "-H";
				}
				break;
			case "input1":
				input1.add(loadFile(part)); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}

	@Override
	protected boolean onValidateInput(){
		if(!mitochondrialRNA.isEmpty() & !primary.isEmpty()){
			setErrorReport("<b>search for mitochondrial tRNAs</b> is conflict to <b>show both primary and secondary structure</b>");
			setErrorReport("Please ensure at least one of them is set to <b>no</b>");
			return(false);
		}else{
			return(true);
		}
	}
	
	@Override
	protected void onSetCommand() throws IOException {
		ArrayListToFile(input1, getWorkDirectory() + File.separator + "query_list.txt");
		
		String[] command1 = {"sh", Config.tRNAscanSE_SH, "query_list.txt",
			kingdom, otherRNA, mitochondrialRNA, primary};
		String[] command2 = {"tar", "-cf", Config.RESULT_DIR + File.separator + taskName + ".tar", "output", "log.txt", "log_error.txt"};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage(hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + ".tar"));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("tRNAscan-SE");
		
	}
}
