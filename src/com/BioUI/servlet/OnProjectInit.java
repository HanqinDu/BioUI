package com.BioUI.servlet;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

// this class should be registered in web.xml as:
//<listener>
//	<listener-class>com.BioUI.servlet.OnProjectInit</listener-class>
//</listener>
public class OnProjectInit implements ServletContextListener{
	
	private ScheduledExecutorService scheduler;
	
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		scheduler.shutdown();
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		System.out.println("initing");
		scheduler = Executors.newScheduledThreadPool(1);
		scheduler.scheduleAtFixedRate(new ClearCache(), 0, Config.CLEAR_PERI, TimeUnit.MINUTES);
		
	}

}
