package com.BioUI.servlet;

import java.util.ArrayList;

public class TaskMonitor {
	static ArrayList<Task> tasks = new ArrayList<Task>();
	
	public synchronized static void post(String taskName, String program){
		if(!program.isEmpty()){
			tasks.add(new Task(taskName, program));
		}else{
			tasks.remove(new Task(taskName, program));
		}
	}
	
	public static String getTaskAsString(){
		String output = "";
		for(Task task:tasks){
			output = output + "&emsp;" + task.toString() + "<br>";
		}
		return(output);
	}
}


class Task{
	String taskName;
	String program;
	
	Task(String taskName, String program){
		this.taskName = taskName;
		this.program = program;
	}
	
	@Override
	public boolean equals(Object obj){
		if(obj == null)
			return false;
		if(obj instanceof Task){
			Task taskObj = (Task)obj;
			if(this.taskName.equals(taskObj.taskName)){
				return true;
			}
		}
		return false;
	}
	
	@Override
	public String toString(){
		return("	" + taskName + ":" + program);
	}
}
