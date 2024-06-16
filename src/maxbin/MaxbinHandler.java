package maxbin;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.Config;
import com.BioUI.servlet.TaskHandler;


public class MaxbinHandler extends TaskHandler{
	
	private String threads = "56";
	private String min_contig_length = "1000";
	private String max_iteration = "50";
	private String prob_threshold = "0.9";
	private String markerset = "107";

	private String contig = "";
	private String reads  = "";

	private String read_temp = "";
	private int read_num = 0;
	
	public MaxbinHandler(HttpServletRequest request,
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
			case "threads":
				threads = loadInt(part, 1, 56, "56"); break;
			case "min_contig_length":
				min_contig_length = loadInt(part, 0, 100000, "1000"); break;
			case "max_iteration":
				max_iteration = loadInt(part, 0, 5000, "50"); break;
			case "prob_threshold":
				prob_threshold = loadFloat(part, (float) 0.1, 1, "0.9"); break;
			case "markerset":
				markerset = loadString(part, Arrays.asList("107", "40"), "107"); break;
			case "contig":
				contig = loadFile(part); break;
			case "reads":
				read_temp = loadFile(part);

				if(read_temp.endsWith(".gz")){
					read_temp = read_temp.substring(0, read_temp.length()-3);
				}

				if(read_num == 0){
					read_num = 1;
					reads = "-reads " + read_temp;
				}else{
					read_num = read_num + 1;
					reads = "-reads" + read_num + " " + read_temp;
				}

				break;
			
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}
	
	@Override
	protected void onSetCommand() throws IOException {
		
		String[] command1 = {"sh", Config.MAXBIN_SH, threads, contig, min_contig_length,
		max_iteration, prob_threshold, markerset, reads};
		String[] command2 = {"tar", "-cf", Config.RESULT_DIR + File.separator + taskName + ".tar", "output", "log.txt", "log_error.txt"};
		
		setCommand(command1);
		setCommand(command2, false);
		
		setResultMessage((hyperlink("result.tar", Config.RESULT_URL + File.separator + taskName + ".tar")));
		setResultMessage("");
		setResultMessage("Right click the link and select \"save link as\" to download the result");
		setResultMessage("");
		setResultMessage("you may also find your result on the server: " + Config.UPLOAD_DIR + File.separator + taskName);
		
		setProgram("maxbin2");
	}
}
