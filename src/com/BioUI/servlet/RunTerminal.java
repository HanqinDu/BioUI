package com.BioUI.servlet;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.concurrent.TimeUnit;


public class RunTerminal implements Runnable{
	
	private java.util.logging.Logger logger =  java.util.logging.Logger.getLogger(this.getClass().getName());
	
	private ArrayList<Command> commands = new ArrayList<Command>();
	
	private String wd;
	private String content = "<!DOCTYPE html>";
	private String email = "";
	private String taskName = "";
	private String logDirectory = "";
	
//	public void addCommand(String[] command, Boolean logging){
//		commands.add(new Command(command, logging));
//	}
	
	public void addCommand(Command input){
		commands.add(input);
	}
	
	public void setWorkPath(String path){
		wd = path;
	}
	
	public void setEmail(String email){
		this.email = email;
	}
	
	public void appendEmailContent(String line){
		content = content + line + "<br>";
	}
	
	public void setTaskName(String taskName){
		this.taskName = taskName;
	}
	
	public void setLogDirectory(String logDirectory) {
		this.logDirectory = logDirectory;
	}

	
	protected void sendEmailNotification() throws IOException, InterruptedException{
		String[] command2 = {"sh", Config.MAIL_SH, email, "Task Complete: " + taskName, content};
		ProcessBuilder pb2 = new ProcessBuilder(command2);
		
		int exitCode;
		
		Process pc2 = pb2.start();
		exitCode = pc2.waitFor();
		
		TaskMonitor.post(taskName, "");
		
		for(int i = -1; i < Config.EMAIL_RESEND_TIMES | i < 0; i++){
			if(exitCode != 0){
				logger.info(taskName + ": send notification to " + email + " failed with attempt " 
						+ (i+2) + " :" + StreamToString(pc2.getErrorStream()) );
				
				TimeUnit.SECONDS.sleep(Config.EMAIL_RESEND_DELAY);
				pc2 = pb2.start();
				exitCode = pc2.waitFor();
			}else{
				logger.info(taskName + ": send notification to " + email + " success");
				break;
			}
		}
	}
	
	
	private String StreamToString(InputStream inputstream) {
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
	

	@SuppressWarnings("unused")
	private void StreamToFile(InputStream inputstream, String path) throws IOException{
    	FileWriter writer = new FileWriter(path); 

    	BufferedReader reader = new BufferedReader(new InputStreamReader(inputstream));
		StringBuilder builder = new StringBuilder();

		String line = null;
		String lineSeparator = System.getProperty("line.separator");

		while ( (line = reader.readLine()) != null) {
			builder.append(line);
			builder.append(lineSeparator);
		}
		
		writer.write(builder.toString());
		writer.close();
    }

	
	@Override
	public void run() {
		
		if(logDirectory.isEmpty()){logDirectory = wd;}
		
		int exitValue = 0;
		
		try {
			ProcessBuilder pb = new ProcessBuilder();
			pb.directory(new File(wd));
			for(Command command:commands){
				logger.info(taskName + ": " + wd + ": Command: " + Arrays.asList(command).toString());
				
				pb.command(command.getCommand());
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
			}

			System.out.println();
			logger.info("======================================== " + taskName + " completed: " + exitValue + " ========================================");
			System.out.println();
			
			if(!email.isEmpty()){sendEmailNotification();}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
