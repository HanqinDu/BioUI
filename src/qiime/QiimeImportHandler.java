package qiime;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class QiimeImportHandler extends TaskHandler{
	
	private String type = "SampleData[PairedEndSequencesWithQuality]";
	private String format = "PairedEndFastqManifestPhred33V2";
	private String pathInput = "";
	

	public QiimeImportHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}
	
	@Override
	protected void onReceive(Part part) throws IOException {
		switch(part.getName()){
			case "task":
				taskName = loadTaskName(part, 32, "task");
				taskName = autoTaskFolder(taskName);
				
				pathInput = getUploadFilePath() + File.separator + "input";
				new File(pathInput).mkdir();

				break;
			case "email":
				setEmail(loadAny(part, 50, "")); break;
			case "type":
				type = loadString(part, Arrays.asList("SampleData[PairedEndSequencesWithQuality]", "SampleData[SequencesWithQuality]"), "SampleData[PairedEndSequencesWithQuality]");
				break;
			case "format":
				format = loadString(part, Arrays.asList("SingleEndFastqManifestPhred33V2", "SingleEndFastqManifestPhred64V2",
					"PairedEndFastqManifestPhred33V2", "PairedEndFastqManifestPhred64V2", "SingleEndFastqManifestPhred33",
					"SingleEndFastqManifestPhred64", "PairedEndFastqManifestPhred33", "PairedEndFastqManifestPhred64"), 
					"PairedEndFastqManifestPhred33V2"); 
				break;
			case "input":
				loadFile(part, getUploadFilePath() + File.separator + "input"); break;
			case "manifest":
				loadFile(part, getUploadFilePath(), false, "manifest.tsv"); break;
			case "metadata":
				loadFile(part, getUploadFilePath(), false, "metadata.tsv"); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}


	protected boolean onValidateInput(){
		if(type.equals("SampleData[SequencesWithQuality]")){
			File file = new File(getUploadFilePath() + File.separator + "single.flag");
   			try {
				file.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return true;
	}
	
	@Override
	protected void onSetCommand() throws IOException {
		
		String[] command1 = {"sh", Config.QIIME_IMPORT_SH, Config.QIIME_IMPORT_R, getUploadFilePath(), type, format};
		String[] command2 = {"mkdir", Config.RESULT_DIR + File.separator + taskName};
		String[] command3 = {"cp", "import/rawdata.qzv", "log_error.txt", "log.txt", Config.RESULT_DIR + File.separator + taskName};
		
		setCommand(command1);
		setCommand(command2, false);
		setCommand(command3, false);
		
		setResultMessage((hyperlink("rawdata.qzv", Config.RESULT_URL + File.separator + taskName + File.separator + "rawdata.qzv")));
		setResultMessage((hyperlink("log.txt", Config.RESULT_URL + File.separator + taskName + File.separator + "log.txt")));
		setResultMessage((hyperlink("log_error.txt", Config.RESULT_URL + File.separator + taskName + File.separator + "log_error.txt")));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("The qzv file can be visualize through qiime2 viewer: https://view.qiime2.org/");
		setResultMessage("");
		setResultMessage("Next step:");
		setResultMessage(
			"<ul>" +  
			"<li><strong>import data</strong></li>" +
			"<li><a href=\"http://" + Config.SERVER_IP + ":" + Config.SERVER_PORT + "/BioUI/QiimeQueryListener?step=quality_control&taskname=" + taskName + "\">quality control</a></li>" +
			"<li>cluster OTUs</li>" +
			"<li>phylogenic analysis</li>" +
			"<li>diversity analyisis</li>" +
			"<li>taxonomy analyisis</li>" +
			"</ul>"
		);

		setProgram("QIIME2 import");
		
	}
}
