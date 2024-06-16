package qiime;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class QiimeTaxonomyHandler extends TaskHandler{
	
	private String classifier = "";
	private String p_confidence = "";

	public QiimeTaxonomyHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}

	public String addFlag(String value, String flag){
		if (value.isEmpty()){
			return("");
		}else{
			return(flag + " " + value + " ");
		}
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
					break;
				}

				break;
			case "classifier":
				classifier = loadStringReplace(part,
					Arrays.asList("Silva_138_full_length", "Silva_138_515F_806R", "Greengenes_138_full_length", "Greengenes_138_515F_806R"),
					Arrays.asList(Config.QIIME_CLAS_SI_FULL, Config.QIIME_CLAS_SI_CURT, Config.QIIME_CLAS_GG_FULL, Config.QIIME_CLAS_GG_CURT), ""); 
				break;
			case "p-confidence":
				p_confidence = loadFloat(part, 0, 1, ""); break;
			case "email":
				setEmail(loadAny(part, 50, "")); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + " with value: " + loadAny(part, 50, "") + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}


	@Override
	protected boolean onValidateInput(){

		if(classifier.isEmpty()){
			setErrorReport("please select a pretrained classifier");
			return(false);
		}

		return(true);
	}
	
	@Override
	protected void onSetCommand() throws IOException {

		String[] command1 = {"sh", Config.QIIME_TAXONOMY_SH, addFlag(classifier, "--i-classifier") + addFlag(p_confidence, "--p-confidence")};
		String[] command2 = {"mkdir", "-p", Config.RESULT_DIR + File.separator + taskName};
		String[] command3 = {"cp", "log_error.txt", "log.txt", "taxonomy/taxa-bar-plots.qzv", "taxonomy/taxonomy.qzv", Config.RESULT_DIR + File.separator + taskName};
		
		setCommand(command1);
		setCommand(command2, false);
		setCommand(command3, false);
		
		setResultMessage("");
		setResultMessage((hyperlink("taxa-bar-plots.qzv", Config.RESULT_URL + File.separator + taskName + File.separator +  "taxa-bar-plots.qzv")));
		setResultMessage((hyperlink("taxonomy.qzv", Config.RESULT_URL + File.separator + taskName + File.separator +  "taxonomy.qzv")));
		setResultMessage("");
		setResultMessage((hyperlink("log_error.txt", Config.RESULT_URL + File.separator + taskName + File.separator +  "log_error.txt")));
		setResultMessage((hyperlink("log.txt", Config.RESULT_URL + File.separator + taskName + File.separator +  "log.txt")));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("The qzv file can be visualize through qiime2 viewer: https://view.qiime2.org/");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("QIIME2 Taxonomy Assigning");
		
	}
}
