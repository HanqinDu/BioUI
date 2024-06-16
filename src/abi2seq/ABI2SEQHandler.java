package abi2seq;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class ABI2SEQHandler extends TaskHandler{
	
	private String separate_pattern = "";
	private String trim_left  = "";
	private String trim_right = "";

	public ABI2SEQHandler(HttpServletRequest request, HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}
	
	@Override
	protected void onReceive(Part part) throws IOException {
		switch(part.getName()){
			case "task":
				taskName = loadTaskName(part, 32, "task");
				taskName = autoTaskFolder(taskName);

				setUploadFilePath(getUploadFilePath() + File.separator + "abi");
				new File(getUploadFilePath()).mkdir();

				break;
			case "separate_pattern":
				separate_pattern = loadAny(part, 25, ""); break;
			case "trim_left":
				trim_left  = loadInt(part, 0, 100000, ""); break;
			case "trim_right":
				trim_right = loadInt(part, 0, 100000, ""); break;
			case "input1":
				loadFile(part, getUploadFilePath(), true); break;
			default:
				System.out.println("unknown input:" + part.getName());
		}
	}

	@Override
	protected boolean onValidateInput(){
		if(separate_pattern.isEmpty()){
			setErrorReport("please specify a seperate pattern for pair detection");
			return false;
		}

		return true;
	}
	
	@Override
	protected void onSetCommand() throws IOException {
		
		String[] command1 = {"sh", Config.ABI2SEQ_SH, Config.ABI2FASTQ_PY, Config.TRIM_FASTQ_R, Config.USEARCH_PATH, separate_pattern, trim_left, trim_right};
		String[] command2 = {"tar", "-cf", Config.RESULT_DIR + File.separator + taskName + ".tar", "."};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage(hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + ".tar"));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("abi2seq");
		
	}
}
