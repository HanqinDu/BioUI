package com.BioUI.servlet;

import java.util.Arrays;

public class Command {
	private String[] command;
	private boolean logging = true;
	
	Command(String[] command, Boolean logging){
		this.setCommand(command);
		this.setLogging(logging); 
	}

	public boolean isLogging() {
		return logging;
	}

	public void setLogging(boolean logging) {
		this.logging = logging;
	}

	public String[] getCommand() {
		return command;
	}

	public void setCommand(String[] command) {
		this.command = command;
	}
	
	public String toString(){
		return(Arrays.asList(this.command).toString());
	}
}