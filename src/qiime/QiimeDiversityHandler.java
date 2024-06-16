package qiime;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class QiimeDiversityHandler extends TaskHandler{
	
	private String sampling_depth = "";
	private String p_method = "permanova";
	private String pairwise = "";
	private String p_permutations = "";
	private String m_metadata_column = "";

	public QiimeDiversityHandler(HttpServletRequest request,
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

				if(!(new File(getUploadFilePath() + File.separator + "phylogeny" + File.separator + "alpha-rarefaction.qzv").exists())){
					setInvalidInput("please infer a phylogeny tree before carrying out diversity analysis:");
					setInvalidInput(hyperlink("http://" + Config.SERVER_IP + ":" + Config.SERVER_PORT + "/BioUI/QiimeQueryListener?step=phylogeny&taskname=" + taskName, 
						"http://" + Config.SERVER_IP + ":" + Config.SERVER_PORT + "/BioUI/QiimeQueryListener?step=phylogeny&taskname=" + taskName));
				}

				break;
			case "sampling-depth":
				sampling_depth = loadInt(part, 0, 100000000, ""); break;
			case "p-method":
				p_method = loadString(part, Arrays.asList("permanova", "anosim", "permdisp"), "permanova"); break;
			case "pairwise":
				pairwise = loadStringReplace(part, Arrays.asList("pairwise", ""), Arrays.asList("--p-pairwise", ""), ""); break;
			case "p-permutations":
				p_permutations = loadInt(part, 0, 100000000, ""); break;
			case "m-metadata-column":
				m_metadata_column = loadAny(part, 100, ""); break;
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

		if(sampling_depth.isEmpty()){
			setErrorReport("sampling depth for diversity inference cannot be empty");
			return(false);
		}

		if(m_metadata_column.isEmpty()){
			setErrorReport("please provide column name of metadata that used for grouping sample");
			return(false);
		}

		return(true);
	}
	
	@Override
	protected void onSetCommand() throws IOException {

		String[] m_metadata_column_list = m_metadata_column.split(" ");
		ArrayListToFile(new ArrayList<>(Arrays.asList(m_metadata_column_list)), getUploadFilePath() + File.separator + "groupby.txt");
		
		String[] command1 = {"sh", Config.QIIME_DIVERSITY_SH, sampling_depth,
			pairwise + " " + addFlag(p_method, "--p-method") + addFlag(p_permutations, "--p-permutations")};
		String[] command2 = {"mkdir", "-p", Config.RESULT_DIR + File.separator + taskName};

		ArrayList<String> command3_temp = new ArrayList<String>(
			Arrays.asList(
				"tar", "-cf",
				Config.RESULT_DIR + File.separator + taskName + File.separator + "diversity.tar",
				"log_error.txt", "log.txt",
				"diversity/faith_pd_group_significance.qzv", "diversity/evenness_group_significance.qzv", "diversity/shannon_group_significance.qzv",
				"diversity/weighted_unifrac_emperor.qzv", "diversity/unweighted_unifrac_emperor.qzv",
				"diversity/bray_curtis_emperor.qzv", "diversity/jaccard_emperor.qzv"));
		for (String column : m_metadata_column_list) {  
            command3_temp.add("diversity/unweighted_unifrac_" + column + "_significance.qzv");
        }

		String[] command3 = command3_temp.toArray(new String[command3_temp.size()]);
		
		setCommand(command1);
		setCommand(command2, false);
		setCommand(command3, false);
		
		setResultMessage("");
		setResultMessage((hyperlink("diversity.tar", Config.RESULT_URL + File.separator + taskName + File.separator +  "diversity.tar")));
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
			"<li>phylogenic analysis</li>" +
			"<li><strong>diversity analysis</strong></li>" +
			"<li><a href=\"http://" + Config.SERVER_IP + ":" + Config.SERVER_PORT + "/BioUI/QiimeQueryListener?step=taxonomy&taskname=" + taskName + "\">taxonomy analysis</a></li>" +
			"</ul>"
		);
		
		setProgram("QIIME2 Diversity Analysis");
		
	}
}
