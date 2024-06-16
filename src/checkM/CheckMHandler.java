package checkM;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class CheckMHandler extends TaskHandler{
	
	private String threads = "56";
	private String outputFilePathTemp = "";
	private String dataType = "genome";
	private String e_value = "0.0000000001";
	private String aai_strain = "0.9";
	private String length = "0.7";
	

	public CheckMHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}
	

	@Override
	protected void onReceive(Part part) throws IOException {
		switch(part.getName()){
			case "task":
				taskName = loadTaskName(part, 32, "task");
				taskName = autoTaskFolder(taskName);
								
				outputFilePathTemp = getUploadFilePath() + File.separator + "output";
				new File(outputFilePathTemp).mkdir();
				
				setUploadFilePath(getUploadFilePath() + File.separator + "bin");
				new File(getUploadFilePath()).mkdir();
				break;
			case "email":
				setEmail(loadAny(part, 50, "")); break;
			case "datatype":
				dataType = loadString(part, Arrays.asList("genome", "protein"), "genome"); break;
			case "threads":
				threads = loadInt(part, 1, 56, "56"); break;
			case "e_value":
				e_value = loadFloat(part, 0, 1000, "0.0000000001"); break;
			case "aai_strain":
				aai_strain = loadFloat(part, 0, 1, "0.9"); break;
			case "length":
				length = loadFloat(part, 0, 1, "0.7"); break;
			case "input1":
				loadFile(part); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}
	
	@Override
	protected boolean onValidateInput(){
		if(getEmail().isEmpty()){
			setErrorReport("email cannot be empty for time-consuming task");
			return false;
		}else{
			return true;
		}
	}
	
	@Override
	protected void onSetCommand() throws IOException {

		String params = addFlag(threads, "-t") + addFlag(e_value, "--e_value") + addFlag(aai_strain, "--aai_strain") + addFlag(length, "--length");

		String[] command1;
		if(dataType.equals("protein")){
			command1 = new String[]{"sh", Config.CHECKMLG_SH, params, Config.CHECKM_OUT};
		}else{
			command1 = new String[]{"sh", Config.CHECKML_SH, params, Config.CHECKM_OUT};
		}
		
		String[] command2 = {"tar", "-cf", Config.RESULT_DIR + File.separator + taskName + ".tar", "output", "log.txt", "log_error.txt"};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage(hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + ".tar"));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("CheckM");
		
	}
}
