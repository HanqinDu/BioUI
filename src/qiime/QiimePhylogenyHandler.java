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


public class QiimePhylogenyHandler extends TaskHandler{
	
	private String tree_inferring = "fasttree";
	private String parttree = "";
	private String p_max_gap_frequency = "1.0";
	private String p_min_conservation = "0.4";
	private String p_substitution_model = "";
	private String p_max_depth = "";
	private String p_n_threads = "";

	public QiimePhylogenyHandler(HttpServletRequest request,
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
				}

				break;
			case "p-max-gap-frequency":
				p_max_gap_frequency = loadFloat(part, 0, 1, ""); break;
			case "p-min-conservation":
				p_min_conservation = loadFloat(part, 0, 1, ""); break;
			case "tree_inferring":
				tree_inferring = loadString(part, Arrays.asList("fasttree", "iqtree", "raxml"), "fasttree"); break;
			case "parttree":
				parttree = loadStringReplace(part, Arrays.asList("parttree", ""), Arrays.asList("--p-parttree", ""), ""); break;
			case "p-substitution-model":
				p_substitution_model = loadString(part, Arrays.asList("GTRGAMMA", "GTRGAMMAI", "GTRCAT"), ""); break;
			case "p-max-depth":
				p_max_depth = loadInt(part, 100, 100000000, ""); break;
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

		if(p_max_depth.isEmpty()){
			setErrorReport("max sampling depth for alpha rarefaction cannot be empty");
			return(false);
		}

		return(true);
	}
	
	@Override
	protected void onSetCommand() throws IOException {

		if(tree_inferring.equals("iqtree")){
			parttree = "";
			p_n_threads = "--p-n-threads 0";
		}

		if(!tree_inferring.equals("raxml")){
			p_substitution_model = "";
			p_n_threads = "--p-n-threads all";
		}

		if(tree_inferring.equals("fasttree")){
			p_n_threads = "--p-n-threads auto";
		}
		
		String[] command1 = {"sh", Config.QIIME_PHYLOGENY_SH, tree_inferring, parttree + " " + 
			addFlag(p_max_gap_frequency, "--p-mask-max-gap-frequency") + 
			addFlag(p_min_conservation, "--p-mask-min-conservation") + 
			addFlag(p_substitution_model, "--p-substitution-model") + 
			p_n_threads,
			p_max_depth};
		String[] command2 = {"mkdir", "-p", Config.RESULT_DIR + File.separator + taskName};
		String[] command3 = {"cp", "phylogeny/alpha-rarefaction.qzv", "log_error.txt", "log.txt", Config.RESULT_DIR + File.separator + taskName};

		setCommand(command1);
		setCommand(command2, false);
		setCommand(command3, false);
		
		setResultMessage("");
		setResultMessage((hyperlink("alpha-rarefaction.qzv", Config.RESULT_URL + File.separator + taskName + File.separator +  "alpha-rarefaction.qzv")));
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
			"<li>cluster OTUs</li>" +
			"<li><strong>phylogenic analysis</strong></li>" +
			"<li><a href=\"http://" + Config.SERVER_IP + ":" + Config.SERVER_PORT + "/BioUI/QiimeQueryListener?step=diversity&taskname=" + taskName + "\">diversity analyisis</a></li>" +
			"<li><a href=\"http://" + Config.SERVER_IP + ":" + Config.SERVER_PORT + "/BioUI/QiimeQueryListener?step=taxonomy&taskname=" + taskName + "\">taxonomy analysis</a></li>" +
			"</ul>"
		);

		setProgram("QIIME2 Phylogenetic Tree Inferring");
		
	}
}
