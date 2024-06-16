package antismash;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class AntiSmashHandler extends TaskHandler{
	
	private String cpus = "32";
	private String taxon = "bacteria";
	private String gene_predict = "Prodigal";

	public AntiSmashHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}
	
	@Override
	protected void onReceive(Part part) throws IOException {
		// TODO Auto-generated method stub
		switch(part.getName()){
			case "task":
				taskName = loadAny(part, 16, "task");
				taskName = autoTaskFolder(taskName);

				setUploadFilePath(getUploadFilePath() + File.separator + "input");
				new File(getUploadFilePath()).mkdir();

				break;
			case "email":
				setEmail(loadAny(part, 50, "")); break;
			case "cpus":
				cpus = loadInt(part, 1, 32, "32"); break;
			case "taxon":
				taxon = loadString(part, Arrays.asList("bacteria", "fungi"), ""); break;
			case "gene_predict":
				gene_predict = loadString(part, Arrays.asList("prodigal", "glimmerhmm"), "prodigal"); break;
			case "input1":
				loadFile(part); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}

	@Override
	protected boolean onValidateInput(){
		if(taxon.isEmpty()){
			setErrorReport("you must specify a taxon");
			return false;
		}

		return true;
	}
	
	@Override
	protected void onSetCommand() throws IOException {
		
		String[] command1 = {"sh", Config.ANTISMASH_SCRIPT, taskName, Config.ANTISMASH_IMAGE_ID, Config.ANTISMASH_DOCKER, getWorkDirectory(), cpus, taxon, gene_predict};
		String[] command2 = {"tar", "-cf", Config.RESULT_DIR + File.separator + taskName + ".tar", "output", "log.txt", "log_error.txt"};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage((hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + ".tar")));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("antismash");
		
	}
}
