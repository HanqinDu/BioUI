package com.BioUI.servlet;
 
import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

public abstract class TaskHandler implements Runnable {

	private java.util.logging.Logger logger =  java.util.logging.Logger.getLogger(this.getClass().getName());

	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected HttpServlet listener;

	protected String taskName = "";
	private String email = "";
	private String program = "unknown";
 	
	private String uploadFilePath = Config.UPLOAD_DIR;
	private String workDirectory = "/";
	
	private String errorReport = "";
	private boolean validInput = true;
	
	private String resultMessage = "";
	private String logDirectory = "";

	private ArrayList<Command> commands = new ArrayList<Command>();
    
    public TaskHandler(HttpServletRequest request, HttpServletResponse response, HttpServlet listener){
    	this.request = request;
    	this.response = response;
    	this.listener = listener;
    }




	/*
	onReceive -> onValidateInput -> onSetCommand -> onExcute
	*/
    
    @Override
    public void run(){
        
    	try {
			
			for (Part part : request.getParts()) {
				onReceive(part);

				if(!validInput){
					logger.info("======================================== " + taskName + " terminate due to invalid input: " + " ========================================");
					request.setAttribute("message", errorReport);
					listener.getServletContext().getRequestDispatcher("/response.jsp").forward(request, response);
					return;
				}
			}
			
			if(!onValidateInput()){
				logger.info("======================================== " + taskName + " terminate due to invalid input: " + " ========================================");
				request.setAttribute("message", errorReport);
				listener.getServletContext().getRequestDispatcher("/response.jsp").forward(request, response);
				return;
			}
			
			onSetCommand();
			
			onExecute();
			
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
    	
    }
    
    abstract protected void onReceive(Part part) throws IOException;

	protected boolean onValidateInput(){
		return(true);
	}
    
    abstract protected void onSetCommand() throws IOException;
    
    protected void onExecute() throws ServletException, IOException{
    	
    	int exitValue = 0;
    	
		// add to taskMonitor
    	TaskMonitor.post(taskName, program);
    	
		// excute commands
    	if(email.isEmpty()){
			for(Command command : commands){

				logger.info(taskName + ": " + workDirectory + ": Command: " + Arrays.asList(command).toString());
				
				try {
					exitValue = exec(command, workDirectory);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			// remove from taskMonitor
			TaskMonitor.post(taskName, "");

			// logging
			System.out.println();
			logger.info("======================================== " + taskName + " completed: " + exitValue + " ========================================");
			System.out.println();
			
			// respond
			request.setAttribute("message", "task <b>" + taskName + " </b>complete: " + resultMessage);
	        listener.getServletContext().getRequestDispatcher("/response.jsp").forward(request, response);

		}else{
			
			// init runner
			RunTerminal runner = new RunTerminal();
			
			for(Command command : commands){
				runner.addCommand(command);
			}
			
			runner.setWorkPath(workDirectory);
			runner.setLogDirectory(logDirectory);
			runner.setEmail(email);
			runner.appendEmailContent(resultMessage);
			
			runner.setTaskName(taskName);
			
			// start runner
			Thread t = new Thread(runner);
			t.start();
			
			// respond
			request.setAttribute("message", "Upload complete. Your task ID is <b>" + taskName + "</b>, you will receive an email when the task is done");
	        listener.getServletContext().getRequestDispatcher("/response.jsp").forward(request, response);
		}
    }


	protected Integer exec(Command command, String directory) throws InterruptedException, IOException{
    	
		int exitValue = 0;
		
    	if(logDirectory.isEmpty()){logDirectory = workDirectory;}
    	
    	ProcessBuilder pb = new ProcessBuilder(command.getCommand());
		pb.directory(new File(directory));
		
		final Process pc = pb.start();
		
		if(command.isLogging()){
			new Thread() {
				@Override
				public void run() {
					BufferedReader in = new BufferedReader(new InputStreamReader(pc.getInputStream()));
					String line = null;

					try {
						FileWriter writer = new FileWriter(logDirectory + File.separator + "log.txt", true);
						while ((line = in.readLine()) != null) {
							writer.write(line + System.lineSeparator());
						}
						writer.close();
						in.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}.start();
					
			new Thread() {
				@Override
				public void run() {
					BufferedReader in = new BufferedReader(new InputStreamReader(pc.getErrorStream()));
					String line = null;

					try {
						FileWriter writer = new FileWriter(logDirectory + File.separator + "log_error.txt", true);
						while ((line = in.readLine()) != null) {
							writer.write(line + System.lineSeparator());
						}
						writer.close();
						in.close();
					} catch (IOException e) {	
						e.printStackTrace();
					}
				}
			}.start();
		}

		exitValue += pc.waitFor();
		pc.waitFor(1000, TimeUnit.MILLISECONDS);
		
		return exitValue;
    }






	/*
	Setter and Getter
	*/

    protected void setUploadFilePath(String uploadFilePath){
    	this.uploadFilePath = uploadFilePath;
    }
    
    protected String getUploadFilePath(){
    	return(this.uploadFilePath);
    }
    
    protected String getEmail() {
		return email;
	}

	protected void setEmail(String email) {
		this.email = email;
	}

	protected void setProgram(String program) {
		this.program = program;
	}
    
    protected String getWorkDirectory() {
		return workDirectory;
	}

	protected void setWorkDirectory(String workDirectory) {
		this.workDirectory = workDirectory;
	}
    
    protected void setResultMessage(String input){
    	resultMessage = resultMessage + input + "<br>" ;
    }
    
    protected void setCommand(String[] input, Boolean logging){
    	commands.add(new Command(input, logging));
    }
    
    protected void setCommand(String[] input){
    	commands.add(new Command(input, true));
    }
    
    protected void setLogDirectory(String logDirectory) {
		this.logDirectory = logDirectory;
	}

	protected void setErrorReport(String input){
		this.errorReport = this.errorReport + "<font color=\"#DF1C44\">" + input + "</font>" + "<br>";
	}

	protected void setInvalidInput(String input){
		validInput = false;
		setErrorReport(input);
	}
    
    
    




	/*
	HELP FUNCTIONS
	*/

	protected String autoTaskFolder(String input){
    	input = input.replaceAll(" ", "_");
		uploadFilePath = uploadFilePath + File.separator + input;
		
		if(!Files.isDirectory(Paths.get(uploadFilePath))){
			File fileSaveDir = new File(uploadFilePath);
			fileSaveDir.mkdir();
			
			System.out.println();
			logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + input + " created <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
			System.out.println();

			this.workDirectory = uploadFilePath;
			
			return(input);
		}else{
			int seq = 2;
			while(Files.isDirectory(Paths.get(uploadFilePath + "_" + seq))){
				seq++;
			}
			uploadFilePath = uploadFilePath + "_" + seq;
			
			File fileSaveDir = new File(uploadFilePath);
			fileSaveDir.mkdir();
			
			System.out.println();
			logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + input + "_" + seq + " created <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
			System.out.println();

			this.workDirectory = uploadFilePath;
			
			return(input + "_" + seq);
		}
    }
    
    protected String StreamToString(InputStream inputstream) {
		InputStreamReader isReader = new InputStreamReader(inputstream);
		BufferedReader reader = new BufferedReader(isReader);
		StringBuffer sb = new StringBuffer();
		String str;
		try {
			while((str = reader.readLine())!= null){
				sb.append(str);
				}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return(sb.toString());
    }


    protected void ArrayListToFile(ArrayList<String> list, String path) throws IOException {
    	FileWriter writer = new FileWriter(path); 
    	for(String str: list) {
    	  writer.write(str + System.lineSeparator());
    	}
    	writer.close();
    }

    
    protected String hyperlink(String text, String url){
    	return hyperlink(text, url, true);
	}
    
    protected String hyperlink(String text, String url, Boolean http){
    	// logger.info(taskName + ": HyperLink: <a href=\"" + url + "\">" + text + "</a>");
    	if(http){
    		return("<a href=\"http://" + url + "\">" + text + "</a>");
    	}else{
    		return("<a href=\"" + url + "\">" + text + "</a>");
    	}
	}
    
    protected String loadString(Part part, List<String> checkList, String defaultValue) throws IOException{
    	String input = StreamToString(part.getInputStream());
    	if(input.isEmpty()){
    		return defaultValue;
    	}
    	else if(checkList.contains(input)){
    		return input;
    	}else{
    		validInput = false;
			setErrorReport("<b>" + input + "</b> is not a valid input for <b>" + part.getName() + 
    				"</b>, the input should be one of the list: " + checkList.toString());
    	}
    	
		return defaultValue;
    }

	protected String loadStringReplace(Part part, List<String> checkList, List<String> replaceList, String defaultValue) throws IOException{
		String input = StreamToString(part.getInputStream());

		if(checkList.size() != replaceList.size()){
			validInput = false;
			setErrorReport("<b>" + input + "</b> loader was not set properly");
			return defaultValue;
		}

		if(input.isEmpty()){
    		return defaultValue;
    	}

		int index = checkList.indexOf(input);
    	if(index >= 0){
    		return replaceList.get(index);
    	}else{
    		validInput = false;
			setErrorReport("<b>" + input + "</b> is not a valid input for <b>" + part.getName() + 
    				"</b>, the input should be one of the list: " + checkList.toString());
    	}

		return defaultValue;
		
	}

	protected String loadCheckReplace(Part part, String check, String replaceValue, String defaultValue) throws IOException{
    	String input = StreamToString(part.getInputStream());
		if(input.equals(check)){
			return(replaceValue);
		}
		return(defaultValue);
    }
    

	protected String loadAny(Part part, int lengthLimit, String defaultValue) throws IOException{
    	return(loadAny(part, lengthLimit, defaultValue, false));
    }
    
    protected String loadAny(Part part, int lengthLimit, String defaultValue, boolean noEmpty) throws IOException{
    	String input = StreamToString(part.getInputStream());
    	if(input.isEmpty()){
    		if(noEmpty){
    			validInput = false;
				setErrorReport("<b>" + input + "</b> cannot be empty");
    		}
    		return defaultValue;
    	}
    	
    	if(input.length() > lengthLimit){
    		validInput = false;
			setErrorReport("<b>" + input + "</b> is not a valid input for <b>" + part.getName() + 
    				"</b>, the input should be less than <b>" + lengthLimit + "</b> characters");
    	}
    	
		return input;
    }

    
    protected String loadTaskName(Part part, int lengthLimit, String defaultValue) throws IOException{
    	String input = StreamToString(part.getInputStream());
    	if(input.isEmpty()){
    		return defaultValue;
    	}
    	if(input.length() > lengthLimit){
    		validInput = false;
			setErrorReport("<b>" + input + "</b> is not a valid input for <b>" + part.getName() + 
    				"</b>, the input should be less than " + lengthLimit + " characters}");
    		return("invalid_task");
    	}
    	if(input.contains("\\")|input.contains("/")|input.contains(":")|input.contains("*")|input.contains("?")|
    			input.contains("\"")|input.contains("<")|input.contains(">")|input.contains("|")){
    		validInput = false;
			setErrorReport("<b>" + input + "</b> is not a valid input for <b>" + part.getName() + 
    				"</b>, A task name cannot contain any of the following characters");
			setErrorReport("    \\ / : * ? \" < > |");
    		return("invalid_task");
    	}
    	
		return input;
    }
    
    
    protected String loadInt(Part part, int min, int max, String defaultValue) throws IOException{
    	String input = StreamToString(part.getInputStream());
    	if(input.isEmpty()){
    		return defaultValue;
    	}
    	
    	int value;
    	
		try{
			value = Integer.parseInt(input);
		}catch(NumberFormatException e){
			validInput = false;
			setErrorReport("<b>" + input + "</b> cannot be parsed to integer, please check your input");
    		return defaultValue;
		}
    	
    	if(value < min){
    		validInput = false;
			setErrorReport("<b>" + input + "</b> is not a valid input for <b>" + part.getName() + 
    				"</b>, the input should be an integer larger or equal to " + min);
    		return defaultValue;
    	}
		
    	if(value > max){
    		validInput = false;
			setErrorReport("<b>" + input + "</b> is not a valid input for <b>" + part.getName() + 
    				"</b>, the input should be an integer smaller or equal to " + max);
    		return defaultValue;
    	}
    	
		return input;
    }

	protected String loadFloat(Part part, float min, float max, String defaultValue) throws IOException{
    	String input = StreamToString(part.getInputStream());
    	if(input.isEmpty()){
    		return defaultValue;
    	}
    	
    	float value;
    	
		try{
			value = Float.parseFloat(input);
		}catch(NumberFormatException e){
			validInput = false;
			setErrorReport("<b>" + input + "</b> cannot be parsed to float, please check your input");
    		return defaultValue;
		}
    	
    	if(value < min){
    		validInput = false;
			setErrorReport("<b>" + input + "</b> is not a valid input for <b>" + part.getName() + 
    				"</b>, the input should be an integer larger or equal to " + min);
    		return defaultValue;
    	}
		
    	if(value > max){
    		validInput = false;
			setErrorReport("<b>" + input + "</b> is not a valid input for <b>" + part.getName() + 
    				"</b>, the input should be an integer smaller or equal to " + max);
    		return defaultValue;
    	}
    	
		return input;
    }

	
	protected String loadFile(Part part){
		return(loadFile(part, getUploadFilePath(), false, ""));
    }

	protected String loadFile(Part part, String path){
		return(loadFile(part, path, false, ""));
    }

	protected String loadFile(Part part, String path, boolean allowEmpty){
		return(loadFile(part, path, allowEmpty, ""));
	}

	protected String loadFile(Part part, String path, boolean allowEmpty, String newName){
		if(taskName.isEmpty()){
    		validInput = false;
			setErrorReport("Error: file transfter before the specification of task name");
    		return("");
    	}

    	String fileName = getFileName(part);
		if(!newName.isEmpty()){fileName = newName;}

    	fileName = fileName.replaceAll(" ", "_");
		File f = new File(fileName);
		
		try {
			part.write(path + File.separator + f.getName());
		} catch (IOException e) {
			if(!allowEmpty){
				setErrorReport("please upload at least one file for " + part.getName());
				validInput = false;
				return("emptyFile");
			}else{
				return("");
			}
		}
		
		System.out.println(taskName + ": File uploaded: " + fileName);
		
		return(f.getName());
	}

    protected String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length()-1);
            }
        }
        return "";
    }


	protected String addFlag(String value, String flag){
		if (value.isEmpty()){
			return("");
		}else{
			return(flag + " " + value + " ");
		}
	}
    
}