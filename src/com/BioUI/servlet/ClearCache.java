package com.BioUI.servlet;

public class ClearCache implements Runnable{

	@Override
	public void run() {
		
		String[] command1 = {"sh", Config.CLEAR_SH, Config.UPLOAD_DIR, Config.CACHE_LIFE};
		String[] command2 = {"sh", Config.CLEAR_SH, Config.RESULT_DIR, Config.CACHE_LIFE};
		String[] command3 = {"sh", Config.RELOG_SH, Config.LOG_PATH};
		
		System.out.println("clearning cache");
		
		try{
			ProcessBuilder pb1 = new ProcessBuilder(command1);
			pb1.start();
			
			ProcessBuilder pb2 = new ProcessBuilder(command2);
			pb2.start();
			
			ProcessBuilder pb3 = new ProcessBuilder(command3);
			pb3.start();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
