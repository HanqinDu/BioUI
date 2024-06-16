package eggnogMapper;

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


public class EggnogMapperHandler extends TaskHandler{
	
	private String cpu = "56";
	private String itype = "CDS";
	private String method = "diamond";
	private String sensmode = "default";
	private String matrix = "BLOSUM62";
	private String target_orthologs = "one2one";
	private String genepred = "prodigal";
	private String cus_para = "";
	
	private ArrayList<String> input1 = new ArrayList<String>();

	public EggnogMapperHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}
	
	@Override
	protected void onReceive(Part part) throws IOException {
		// TODO Auto-generated method stub
		switch(part.getName()){
			case "task":
				taskName = loadAny(part, 32, "task");
				taskName = autoTaskFolder(taskName);
								
				setUploadFilePath(getUploadFilePath() + File.separator + "input");
				new File(getUploadFilePath()).mkdir();
				break;
			case "email":
				setEmail(loadAny(part, 50, "")); break;
			case "cpu":
				cpu = loadInt(part, 1, 56, "56"); break;
			case "itype":
				itype = loadString(part, Arrays.asList("CDS", "proteins", "genome", "metagenome"), "CDS"); break;
			case "method":
				method = loadString(part, Arrays.asList("diamond", "mmseqs", "hmmer_bacteria"), "diamond"); 
				if(method.equals("hmmer_bacteria")){method = "hmmer -d 2";}; break;
			case "genepred":
				genepred = loadString(part, Arrays.asList("prodigal", "search"), "prodigal"); break;
			case "sensmode":
				sensmode = loadString(part, Arrays.asList("default", "fast", "mid-sensitive", "sensitive",
						"more-sensitive", "very-sensitive", "ultra-sensitive"), "default"); break;
			case "matrix":
				matrix = loadString(part, Arrays.asList("BLOSUM62", "BLOSUM90", "BLOSUM80", "BLOSUM50",
						"BLOSUM45", "PAM250", "PAM70", "PAM30"), "BLOSUM62"); break;
			case "target_orthologs":
				target_orthologs = loadString(part, Arrays.asList("one2one", "many2one", "one2many", "many2many", "all"), "one2one"); break;
			case "input1":
				input1.add(loadFile(part)); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}
	
	@Override
	protected boolean onValidateInput(){

		if(itype.equals("CDS") || itype.equals("proteins")){
			genepred = "search";
		}

		if(getEmail().isEmpty()){
			setErrorReport("email cannot be empty for time-consuming task");
			return false;
		}else if(method.equals("hmmer -d 2") & genepred.equals("prodigal")){
			setErrorReport("<b>hmmer</b> mode is not compatible with gene prediction: <b>search</b>.");
			return false;
		}else if((itype.equals("CDS") | itype.equals("proteins")) & genepred.equals("prodigal")){
			setErrorReport("<b>prodigal</b> prediction is only available for genome or metagenome input.");
			return false;
		}else if((itype.equals("genome") | itype.equals("metagenome")) & genepred.equals("search")){
			setErrorReport("<b>search</b> over <b>genome</b> without prediction could be extremely time comsuming and is currently not avalible through this website.");
			return false;
		}else{
			return true;
		}
	}
	
	@Override
	protected void onSetCommand() throws IOException {
		ArrayListToFile(input1, getWorkDirectory() + File.separator + "query_list.txt");

		if(!method.equals("diamond")){
			sensmode = "";
			matrix = "";
		}

		String params = addFlag(cpu, "--cpu") + addFlag(itype, "--itype") + addFlag(method, "-m") + addFlag(sensmode, "--sensmode") +
			addFlag(matrix, "--matrix") + addFlag(target_orthologs, "--target_orthologs") + addFlag(genepred, "--genepred") + cus_para;
		
		
		String[] command1 = {"sh", Config.EMAPPER_SH, "query_list.txt", params};
		String[] command2 = {"tar", "-cf", Config.RESULT_DIR + File.separator + taskName + ".tar", "output", "log.txt", "log_error.txt"};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage((hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + ".tar")));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("eggnog-mapper");
		
	}
}
