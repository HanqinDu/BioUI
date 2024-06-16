package spades;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class SPAdesHandler extends TaskHandler{
	
	private String cpu = "56";
	private String itype = "--sc";
	private String pipemode = "";
	private String careful = "";
	private String covcut = "off";
	private String phredoff = "auto-detect";
	private String kmer = "auto";

	private String input = "";
	private String fileNameTemp = "";

	public SPAdesHandler(HttpServletRequest request,
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
				break;
			case "email":
				setEmail(loadAny(part, 50, "")); break;
			case "cpu":
				cpu = loadInt(part, 1, 56, "56"); break;
			case "itype":
				itype = loadStringReplace(part, 
				Arrays.asList("MDA (single-cell) data", "metagenomic data", "RNA-Seq data", "viral RNA-Seq data",
				"isolate mode", "IonTorrent data", "biosyntheticSPAdes", "coronaSPAdes", "plasmid detection",
				"plasmid detection (meta)", "virus detection (meta)"),
				Arrays.asList("--sc", "--meta", "--rna", "--rnaviral", "--isolate", "--iontorrent", "--bio", "--corona",
				"--plasmid", "--metaplasmid", "--metaviral"), "--sc");
				break;
			case "pipemode":
				pipemode = loadStringReplace(part, 
				Arrays.asList("both", "error-correction", "assembler"), 
				Arrays.asList("", "--only-error-correction", "--only-assembler"), "");
				break;
			case "careful":
				careful = loadCheckReplace(part, "yes", "--careful", ""); break;
			case "covcut":
				covcut = loadAny(part, 10, ""); 
				if(!covcut.equals("off") & !covcut.equals("auto")){
					covcut = loadFloat(part, 0, 1000000, "");
				}
				if(!covcut.isEmpty()){
					covcut = "--cov-cutoff " + covcut;
				}
				
				break;
			case "phredoff":
				phredoff = loadStringReplace(part, 
				Arrays.asList("auto-detect", "33", "64"), 
				Arrays.asList("", "--phred-offset 33", "--phred-offset 64"), "");
				break;
			case "kmer":
				kmer = loadAny(part, 32, "auto");
				kmer = "-k " + kmer;
			case "input--12":
				fileNameTemp = loadFile(part, getUploadFilePath(), true);
				if(!fileNameTemp.isEmpty()){input = input + " --12 " + fileNameTemp;}
				break;
			case "input-1":
				fileNameTemp = loadFile(part, getUploadFilePath(), true);
				if(!fileNameTemp.isEmpty()){input = input + " -1 " + fileNameTemp;}
				break;
			case "input-2":
				fileNameTemp = loadFile(part, getUploadFilePath(), true);
				if(!fileNameTemp.isEmpty()){input = input + " -2 " + fileNameTemp;}
				break;
			case "input-s":
				fileNameTemp = loadFile(part, getUploadFilePath(), true);
				if(!fileNameTemp.isEmpty()){input = input + " -s " + fileNameTemp;}
				break;
			case "input--merged":
				fileNameTemp = loadFile(part, getUploadFilePath(), true);
				if(!fileNameTemp.isEmpty()){input = input + " --merged " + fileNameTemp;}
				break;
			case "input--sanger":
				fileNameTemp = loadFile(part, getUploadFilePath(), true);
				if(!fileNameTemp.isEmpty()){input = input + " --sanger " + fileNameTemp;}
				break;
			case "input--pacbio":
				fileNameTemp = loadFile(part, getUploadFilePath(), true);
				if(!fileNameTemp.isEmpty()){input = input + " --pacbio " + fileNameTemp;}
				break;
			case "input--nanopore":
				fileNameTemp = loadFile(part, getUploadFilePath(), true);
				if(!fileNameTemp.isEmpty()){input = input + " --nanopore " + fileNameTemp;}
				break;
			case "input--trusted-contigs":
				fileNameTemp = loadFile(part, getUploadFilePath(), true);
				if(!fileNameTemp.isEmpty()){input = input + " --trusted-contigs " + fileNameTemp;}
				break;
			case "input--untrusted-contigs":
				fileNameTemp = loadFile(part, getUploadFilePath(), true);
				if(!fileNameTemp.isEmpty()){input = input + " --untrusted-contigs " + fileNameTemp;}
				break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}
	
	@Override
	protected boolean onValidateInput(){
		if(getEmail().isEmpty()){
			setErrorReport("email cannot be empty for time-consuming task");
			return false;
		}

		if(itype.equals("--isolate") & careful.equals("--careful")){
			setErrorReport("isolate cannot be used with careful mode");
			return false;
		}

		if(itype.equals("--meta") | itype.equals("--rnaviral") | itype.equals("--bio") |
			itype.equals("--corona") | itype.equals("--metaplasmid") | itype.equals("--metaviral")){
			if(!covcut.equals("off") | !careful.isEmpty()){
				if(!covcut.isEmpty()){
					setErrorReport("you cannot specify <b>careful</b> or <b>cov-cutoff</b> in metagenomic mode!");
					return false;
				}
			}
		}
		
		if(input.isEmpty()){
			setErrorReport("at least one input file is required");
			return false;
		}

		return true;
	}


	@Override
	protected void onSetCommand() throws IOException {
		
		String[] command1 = {"sh", Config.SPADES_SH, cpu, covcut + " " + phredoff + " " + itype + " " + pipemode + " " + input + " " + careful + " " + kmer, Config.SPADES_INFO_C, Config.SPADES_PLOT_R};
		String[] command2 = {"tar", "-cf", Config.RESULT_DIR + File.separator + taskName + ".tar", "output", "log.txt", "log_error.txt"};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage((hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + ".tar")));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("SPAdes");
		
	}
}
