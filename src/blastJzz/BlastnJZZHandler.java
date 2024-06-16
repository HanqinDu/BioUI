package blastJzz;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class BlastnJZZHandler extends TaskHandler{
	
	private String threads = "56";
	private String mode = "blastn";
	private String evalue = "";
	private String perc_identity = "";
	private String word_size = "";
	private String no_greedy = "";
	private String ungapped = "";
	private String gapopen = "";
	private String gapextend = "";
	private String reward = "";
	private String penalty = "";
	private String outfmt = "0";

	private String dbFilePathTemp = "";

	private ArrayList<String> input1 = new ArrayList<String>();
	private ArrayList<String> input2 = new ArrayList<String>();

	public BlastnJZZHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}

	private String loadDefaultInt(Part part, int min, int max, String flag) throws IOException{
		String output;
		output = loadAny(part, 8, "");
		if(output.equals("default") | output.isEmpty()){
			output = "";
		}else{
			output = loadInt(part, min, max, "");
			output = flag + " " + output;
		}
		return output;
	}

	private String loadDefaultFloat(Part part, float min, float max, String flag) throws IOException{
		String output;
		output = loadAny(part, 8, "");
		if(output.equals("default") | output.isEmpty()){
			output = "";
		}else{
			output = loadFloat(part, min, max, "");
			output = flag + " " + output;
		}
		return output;
	}
	
	@Override
	protected void onReceive(Part part) throws IOException {
		// TODO Auto-generated method stub
		switch(part.getName()){
			case "task":
				taskName = loadAny(part, 32, "task");
				taskName = autoTaskFolder(taskName);

				dbFilePathTemp = getUploadFilePath() + File.separator + "dbseq";
				new File(dbFilePathTemp).mkdir();

				break;
			case "email":
				setEmail(loadAny(part, 50, "")); break;
			case "threads":
				threads = loadInt(part, 1, 56, "56"); break;
			case "mode":
				mode = loadString(part, Arrays.asList("blastn", "blastn-short", "megablast", "dc-megablast"), "blastn");
				break;
			case "evalue":
				evalue = loadDefaultFloat(part, 0, 1000, "-evalue"); break;
			case "perc_identity":
				perc_identity = loadDefaultFloat(part, 0, 100, "-perc_identity"); break;
			case "word_size":
				word_size = loadDefaultInt(part, 0, 1000, "-word_size"); break;
			case "no_greedy":
				no_greedy = loadCheckReplace(part, "yes", "-no_greedy", ""); break;
			case "ungapped":
				ungapped = loadCheckReplace(part, "yes", "-ungapped", ""); break;
			case "gapopen":
				gapopen = loadDefaultInt(part, 0, 100, "-gapopen"); break;
			case "gapextend":
				gapextend = loadDefaultInt(part, 0, 100, "-gapextend"); break;
			case "reward":
				reward = loadDefaultInt(part, 1, 100, "-reward"); break;
			case "penalty":
				penalty = loadDefaultInt(part, -100, -1, "-penalty"); break;
			case "outfmt":
				outfmt = loadStringReplace(part, 
				Arrays.asList("pairwise", "query-anchored with id", "query-anchored", "flat query-anchored (id)",
				"flat query-anchored", "XML Blast output", "tabular", "tabular (comment lines)", "Text ASN.1",
				"Binary ASN.1", "CSV", "BLAST archive format", "Seqalign (JSON)",
				"Multiple-file BLAST JSON", "Multiple-file BLAST XML2", "Single-file BLAST JSON",
				"Single-file BLAST XML2", "SAM", "Organism Report"),
				Arrays.asList("0", "1", "2", "3", "4", "5",
				"6 qseqid sseqid pident qcovhsp length qstart qend sstart send evalue bitscore qseq sseq",
				"7 qseqid sseqid pident qcovhsp length qstart qend sstart send evalue bitscore qseq sseq",
				"8", "9", 
				"10 delim=, qseqid sseqid pident qcovhsp length qstart qend sstart send evalue bitscore qseq sseq",
				"11", "12", "13", "14", "15", "16", "17", "18"),
				"10 delim=, qseqid sseqid pident qcovhsp length qstart qend sstart send evalue bitscore qseq sseq");
				break;
			case "input1":
				input1.add(loadFile(part)); break;
			case "input2":
				input2.add(loadFile(part, dbFilePathTemp, true)); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}
	
	@Override
	protected boolean onValidateInput(){
		boolean valid = true;

		for(String filename: input1){
			if(filename.replaceAll("\\.[_a-zA-Z]*$", "").length() > 42){
				setErrorReport("the filename <b>" + filename.replaceAll("\\.[_a-zA-Z]*$", "") + "</b> exceed the length limit of 42.");
				valid = false;
			}
        }
		
		for(String filename: input2){
			if(filename.replaceAll("\\.[_a-zA-Z]*$", "").length() > 42){
				setErrorReport("the filename <b>" + filename.replaceAll("\\.[_a-zA-Z]*$", "") + "</b> exceed the length limit of 42.");
				valid = false;
			}
        }

		return valid;
	}

	@Override
	protected void onSetCommand() throws IOException {
		ArrayListToFile(input1, getUploadFilePath() + "/query_list.txt");
		if(input2.get(0).length() == 0){
			String[] command1 = {"sh", Config.BLASTNJZZ_SH, "query_list.txt", Config.JZZNDB_PATH, threads, mode, outfmt,
				evalue + " " + perc_identity + " " + word_size + " " + no_greedy + " " + ungapped + " " +
				gapopen + " " + gapextend + " " + reward + " " + penalty};
			setCommand(command1);
		}else{
			String[] command0 = {"sh", Config.BLASTNDB_SH};
			String[] command1 = {"sh", Config.BLASTNJZZ_SH, "query_list.txt", "dbtemp/dbtemp", threads, mode, outfmt,
				evalue + " " + perc_identity + " " + word_size + " " + no_greedy + " " + ungapped + " " +
				gapopen + " " + gapextend + " " + reward + " " + penalty};
			
			setCommand(command0, false);
			setCommand(command1);
		}

		if(outfmt.equals("10 delim=, qseqid sseqid pident qcovhsp length qstart qend sstart send evalue bitscore qseq sseq")){
			String[] commandCsvHeader = {"sh", Config.ADDCSVHEAD_SH};
			setCommand(commandCsvHeader, false);
		}
		
		String[] command2 = {"tar", "-c", "-f", taskName + ".tar", "output", "log.txt", "log_error.txt"};
		String[] command3 = {"mv", taskName + ".tar", Config.RESULT_DIR};
		
		
		setCommand(command2, false);
		setCommand(command3, false);
		
		setResultMessage((hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + ".tar")));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("blastn-jzz");
		
	}
}
