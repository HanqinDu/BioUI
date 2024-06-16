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


public class QiimeQualityControlPairHandler extends TaskHandler{
	
	private String method = "";
	private String pooling_method = "";
	private String p_chimera_method = "";
	private String p_trunc_len_f = "0";
	private String p_trunc_len_r = "0";
	private String p_trim_left_f = "0";
	private String p_trim_left_r = "0";
	private String p_trunc_q = "";
	private String p_min_overlap = "";
	private String parameters = "";
	
	private String p_trim_length = "-1";
	private String p_left_trim_len = "";
	private String p_mean_error = "";
	private String p_indel_prob = "";
	private String p_indel_max = "";
	private String p_min_reads = "";
	private String p_min_size = "";
	
	

	public QiimeQualityControlPairHandler(HttpServletRequest request,
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

				break;

			case "method":
				method = loadString(part, Arrays.asList("dada2", "deblur"), ""); break;

			case "p-pooling-method":
				pooling_method = loadString(part, Arrays.asList("pseudo", "independent"), ""); break;
			case "p-chimera-method":
				p_chimera_method = loadString(part, Arrays.asList("none", "pooled", "consensus"), ""); break;
			case "p-trunc-len-f":
				p_trunc_len_f = loadInt(part, 0, 1000000, "0"); break;
			case "p-trunc-len-r":
				p_trunc_len_r = loadInt(part, 0, 1000000, "0"); break;
			case "p-trim-left-f":
				p_trim_left_f = loadInt(part, 0, 1000000, "0"); break;
			case "p-trim-left-r":
				p_trim_left_r = loadInt(part, 0, 1000000, "0"); break;
			case "p-trunc-q":
				p_trunc_q = loadInt(part, 0, 1000000, ""); break;
			case "p-min-overlap":
				p_min_overlap = loadInt(part, 4, 1000000, ""); break;

			case "p-trim-length":
				p_trim_length = loadInt(part, -1, 1000000, "-1"); break;
			case "p-left-trim-len":
				p_left_trim_len = loadInt(part, 0, 1000000, ""); break;
			case "p-mean-error":
				p_mean_error = loadFloat(part, 0, 1, ""); break;
			case "p-indel-prob":
				p_indel_prob = loadFloat(part, 0, 1, ""); break;
			case "p-indel-max":
				p_indel_max = loadInt(part, 0, 1000000, ""); break;
			case "p-min-reads":
				p_min_reads = loadInt(part, 0, 1000000, ""); break;
			case "p-min-size":
				p_min_size = loadInt(part, 0, 1000000, ""); break;

			case "parameters":
				parameters = loadAny(part, 100, ""); break;

			case "email":
				setEmail(loadAny(part, 50, "")); break;

			
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}


	@Override
	protected boolean onValidateInput(){
		boolean flag = true;

		if(method.isEmpty()){
			setErrorReport("the method field cannot be empty");
			flag = false;
		}

		if(method.equals("dada2")){
			if(p_trunc_len_f.isEmpty()){
				setErrorReport("forward read truncate position (3') cannot be empty");
				flag = false;
			}

			if(p_trunc_len_r.isEmpty()){
				setErrorReport("reverse read truncate position (3') cannot be empty");
				flag = false;
			}
		}

		if(method.equals("deblur")){
			if(p_trim_length.isEmpty()){
				setErrorReport("Sequence trim length cannot be empty");
				flag = false;
			}
		}

		if(getEmail().isEmpty()){
			setErrorReport("email cannot be empty for time-consuming task");
			flag = false;
		}

		return flag;
	}
	
	@Override
	protected void onSetCommand() throws IOException {

		String combineParameters = "";

		if(method.equals("dada2")){
			combineParameters = addFlag(pooling_method, "--p-pooling-method") + 
				addFlag(p_trunc_len_f, "--p-trunc-len-f") + addFlag(p_trunc_len_r, "--p-trunc-len-r") +
				addFlag(p_trim_left_f, "--p-trim-left-f") + addFlag(p_trim_left_r, "--p-trim-left-r") +
				addFlag(p_trunc_q, "--p-trunc-q") + addFlag(p_min_overlap, "--p-min-overlap") +
				addFlag(p_chimera_method, "--p-chimera-method") + parameters;
				
			combineParameters = "dada2 denoise-paired --p-n-threads 0 --i-demultiplexed-seqs import/rawdata.qza --o-table quality_control/treated_table.qza --o-representative-sequences quality_control/treated_rep_seqs.qza --o-denoising-stats quality_control/treated_stats.qza " + combineParameters;
		}

		if(method.equals("deblur")){
			combineParameters = addFlag(p_trim_length, "--p-trim-length") +
				addFlag(p_left_trim_len, "--p-left-trim-len") + addFlag(p_mean_error, "--p-mean-error") +
				addFlag(p_indel_prob, "--p-indel-prob") + addFlag(p_indel_max, "--p-indel-max") +
				addFlag(p_min_reads, "--p-min-reads") + addFlag(p_min_size, "--p-min-size") + 
				parameters;

			combineParameters = "deblur denoise-16S --i-demultiplexed-seqs import/rawdata.qza --o-table quality_control/treated_table.qza --o-representative-sequences quality_control/treated_rep_seqs.qza --o-stats quality_control/treated_stats.qza " + combineParameters;
		}
		
		String[] command1 = {"sh", Config.QIIME_QC_PAIR_SH, combineParameters};
		String[] command2 = {"mkdir", "-p", Config.RESULT_DIR + File.separator + taskName};
		String[] command3 = {"cp", "quality_control/treated_stats.qzv", "quality_control/treated_rep_seqs.qzv", "quality_control/treated_table.qzv", "quality_control/sample_metadata.tsv", "log_error.txt", "log.txt", Config.RESULT_DIR + File.separator + taskName};

		setCommand(command1);
		setCommand(command2, false);
		setCommand(command3, false);
		
		setResultMessage("");
		setResultMessage((hyperlink("treated_stats.qzv", Config.RESULT_URL + File.separator + taskName + File.separator +  "treated_stats.qzv")));
		setResultMessage((hyperlink("treated_rep_seqs.qzv", Config.RESULT_URL + File.separator + taskName + File.separator +  "treated_rep_seqs.qzv")));
		setResultMessage((hyperlink("treated_table.qzv", Config.RESULT_URL + File.separator + taskName + File.separator +  "treated_table.qzv")));
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
			"<li>import data</li>" +
			"<li><strong>quality control</strong></li>" +
			"<li><a href=\"http://" + Config.SERVER_IP + ":" + Config.SERVER_PORT + "/BioUI/QiimeQueryListener?step=cluster&taskname=" + taskName + "\">cluster OTUs</a></li>" +
			"<li><a href=\"http://" + Config.SERVER_IP + ":" + Config.SERVER_PORT + "/BioUI/QiimeQueryListener?step=phylogeny&taskname=" + taskName + "\">phylogenic analysis</a></li>" +
			"<li>diversity analyisis</li>" +
			"<li><a href=\"http://" + Config.SERVER_IP + ":" + Config.SERVER_PORT + "/BioUI/QiimeQueryListener?step=taxonomy&taskname=" + taskName + "\">taxonomy analysis</a></li>" +
			"</ul>"
		);
				
		setProgram("QIIME2 quality control");
		
	}
}
