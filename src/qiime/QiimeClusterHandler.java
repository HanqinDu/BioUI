package qiime;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class QiimeClusterHandler extends TaskHandler{
	
	private String p_perc_identity = "0.97";

	public QiimeClusterHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}
	
	@Override
	protected void onReceive(Part part) throws IOException {
		switch(part.getName()){
			case "task":
				taskName = loadTaskName(part, 32, "task");

				setUploadFilePath(Config.UPLOAD_DIR + File.separator + taskName);
				setWorkDirectory(getUploadFilePath());

				if(!Files.isDirectory(Paths.get(getUploadFilePath()))){
					setInvalidInput("task " + taskName + "not exist");
				}

				if(!(new File(getUploadFilePath() + File.separator + "import" + File.separator + "rawdata.qza").exists())){
					setInvalidInput("please import data first:");
					setInvalidInput(hyperlink("http://" + Config.SERVER_IP + ":" + Config.SERVER_PORT + "/BioUI/qiime_import.jsp", 
						"http://" + Config.SERVER_IP + ":" + Config.SERVER_PORT + "/BioUI/qiime_import.jsp"));
					break;
				}

				if(!(new File(getUploadFilePath() + File.separator + "quality_control" + File.separator + "treated_rep_seqs.qza").exists())){
					setInvalidInput("please run quality control before inferring tree:");
					setInvalidInput(hyperlink("http://" + Config.SERVER_IP + ":" + Config.SERVER_PORT + "/BioUI/QiimeQueryListener?step=quality_control&taskname=" + taskName, 
						"http://" + Config.SERVER_IP + ":" + Config.SERVER_PORT + "/BioUI/QiimeQueryListener?step=quality_control&taskname=" + taskName));
				}

				break;
			case "p-perc-identity":
				p_perc_identity = loadFloat(part, 0, 1, "0.97"); break;
			case "email":
				setEmail(loadAny(part, 50, "")); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + " with value: " + loadAny(part, 50, "") + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}


	@Override
	protected boolean onValidateInput(){

		if(getEmail().isEmpty()){
			setErrorReport("email cannot be empty for time-consuming task");
			return(false);
		}

		return(true);
	}
	
	@Override
	protected void onSetCommand() throws IOException {
		
		String[] command1 = {"sh", Config.QIIME_CLUSTER_SH, p_perc_identity};
		String[] command2 = {"mkdir", "-p", Config.RESULT_DIR + File.separator + taskName};
		String[] command3 = {"cp", "cluster/OTU_table.qzv", "cluster/OTU_rep_seqs.qzv", "log_error.txt", "log.txt", Config.RESULT_DIR + File.separator + taskName};

		setCommand(command1);
		setCommand(command2, false);
		setCommand(command3, false);
		
		setResultMessage("");
		setResultMessage((hyperlink("OTU_table.qzv", Config.RESULT_URL + File.separator + taskName + File.separator +  "OTU_table.qzv")));
		setResultMessage((hyperlink("OTU_rep_seqs.qzv", Config.RESULT_URL + File.separator + taskName + File.separator +  "OTU_rep_seqs.qzv")));
		setResultMessage("");
		setResultMessage((hyperlink("log_error.txt", Config.RESULT_URL + File.separator + taskName + File.separator +  "log_error.txt")));
		setResultMessage((hyperlink("log.txt", Config.RESULT_URL + File.separator + taskName + File.separator +  "log.txt")));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("The qzv file can be visualize through qiime2 viewer: https://view.qiime2.org/");
		setResultMessage("");
		setResultMessage("Next step:");
		setResultMessage(
			"<ul>" +  
			"<li>import data</li>" +
			"<li>quality control</li>" +
			"<li><strong>cluster OTUs</strong></li>" +
			"<li><a href=\"http://" + Config.SERVER_IP + ":" + Config.SERVER_PORT + "/BioUI/QiimeQueryListener?step=phylogeny&taskname=" + taskName + "\">phylogenic analysis</a></li>" +
			"<li>diversity analyisis</li>" +
			"<li><a href=\"http://" + Config.SERVER_IP + ":" + Config.SERVER_PORT + "/BioUI/QiimeQueryListener?step=taxonomy&taskname=" + taskName + "\">taxonomy analysis</a></li>" +
			"</ul>"
		);
		
		setProgram("QIIME2 Clustering OTUs");
		
	}
}
