package signStat;

import java.io.File;
import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class SignStatHandler extends TaskHandler{
	
	private String first_day  = "";
	private String last_day   = "";
	private String staff      = "staffs.csv";
	private String rule       = "rule.csv";
	private String rule_extra = "";

	public SignStatHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}
	
	@Override
	protected void onReceive(Part part) throws IOException {
		switch(part.getName()){
			case "task":
				taskName = loadTaskName(part, 32, "task");
				taskName = autoTaskFolder(taskName);

				new File(getUploadFilePath() + File.separator + "csv").mkdir();

				break;
			case "first_day":
				first_day = loadAny(part, 10, ""); break;
			case "last_day":
				last_day = loadAny(part, 10, ""); break;
			case "staff":
				staff = loadFile(part, getUploadFilePath()); break;
			case "rule":
				rule = loadFile(part, getUploadFilePath()); break;
			case "rule_extra":
				rule_extra = loadFile(part, getUploadFilePath(), true); break;
			case "csv":
				loadFile(part, getUploadFilePath() + File.separator + "csv"); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}

	@Override
	protected boolean onValidateInput(){
		boolean valid = true;

		if(first_day.length() != 10){
			setErrorReport("the format of the first day should be yyyy-mm-dd");
			valid = false;
		}

		if(last_day.length() != 10){
			setErrorReport("the format of the last day should be yyyy-mm-dd");
			valid = false;
		}

		return valid;
	}

	@Override
	protected void onSetCommand() throws IOException {

		String[] command1 = {"sh", Config.SIGNSTAT_SH, Config.SIGNSTAT_R, staff, rule, first_day, last_day, rule_extra};
		String[] command2 = {"cp", "summary.csv", Config.RESULT_DIR + File.separator + taskName + "_summary.csv"};
		String[] command3 = {"cp", "log_error.txt", Config.RESULT_DIR + File.separator + taskName + "_log_error.txt"};
		
		setCommand(command1);
		setCommand(command2);
		setCommand(command3);
		
		setResultMessage("<br>");
		setResultMessage(hyperlink("summary.csv", Config.RESULT_URL + File.separator + taskName + "_summary.csv"));
		setResultMessage(hyperlink("log_error.txt", Config.RESULT_URL + File.separator + taskName + "_log_error.txt"));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.RESULT_DIR + File.separator + taskName + "_summary.csv");
		
		setProgram("signStat");
	}
}
