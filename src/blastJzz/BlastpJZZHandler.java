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


public class BlastpJZZHandler extends TaskHandler{
	
	private String threads = "56";
	private String mode = "blastp";
	private String evalue = "";
	private String matrix = "";
	private String word_size = "";
	private String no_greedy = "";
	private String ungapped = "";
	private String gapopen = "";
	private String gapextend = "";
	private String outfmt = "0";
	private String targetdb = "";

	private String dbFilePathTemp = "";

	private ArrayList<String> input1 = new ArrayList<String>();
	private ArrayList<String> input2 = new ArrayList<String>();

	public BlastpJZZHandler(HttpServletRequest request,
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
				mode = loadString(part, Arrays.asList("blastp", "blastp-fast", "blastp-short"), "blastp");
				break;
			case "evalue":
				evalue = loadDefaultFloat(part, 0, 1000, "-evalue"); break;
			case "matrix":
				matrix = loadStringReplace(part, 
				Arrays.asList("default", "BLOSUM62", "BLOSUM45", "BLOSUM50", "BLOSUM80", "BLOSUM90",
				"PAM250", "PAM70", "PAM30"),
				Arrays.asList("", "-matrix BLOSUM62", "-matrix BLOSUM45", "-matrix BLOSUM50", "-matrix BLOSUM80",
				"-matrix BLOSUM90", "-matrix PAM250", "-matrix PAM70", "-matrix PAM30"),"");
				break;
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
			case "targetdb":
				targetdb = loadStringReplace(part,
				Arrays.asList("JZZ database", "green lab marker", "custom database"),
				Arrays.asList(Config.JZZPDB_PATH, Config.GREENLAB_PATH, "dbtemp/dbtemp"),
				Config.JZZPDB_PATH);
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

		// construct custom blast database
		if(input2.size() != 0){
			String[] command0 = {"sh", Config.BLASTPDB_SH};
			setCommand(command0, false);
		}

		// blast
		String[] command1 = {"sh", Config.BLASTPJZZ_SH, "query_list.txt", targetdb, threads, mode, outfmt,
			evalue + " " + matrix + " " + word_size + " " + no_greedy + " " + ungapped + " " +
			gapopen + " " + gapextend};
			
		setCommand(command1);

		// add header to csv output
		if(outfmt.equals("10 delim=, qseqid sseqid pident qcovhsp length qstart qend sstart send evalue bitscore qseq sseq")){
			String[] commandCsvHeader = {"sh", Config.ADDCSVHEAD_SH};
			setCommand(commandCsvHeader, false);
		}

		// add type if green lab
		if(targetdb.equals(Config.GREENLAB_PATH)){
			String[] commandAddGreenType = {"sh", Config.ADDTYPE_SH, Config.ADDTYPE_R, getWorkDirectory(), Config.GREENLAB_MAP};
			setCommand(commandAddGreenType, true);
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
		
		setProgram("blastp");
		
	}
}
