
package com.journaldev.servlet;
 
import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
 
@WebServlet("/FileUploadServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*100, 	// 100 MB 
                 maxFileSize=1024*1024*500,      	// 500 MB
                 maxRequestSize=1024*1024*1000)   	// 1000 MB
public class FileUploadServlet extends HttpServlet {
 
    private static final long serialVersionUID = 205242440643911308L;
	
    /**
     * Directory where uploaded files will be saved, its relative to
     * the web application directory.
     */
    //private static final String UPLOAD_DIR = "uploads";
    private static final String UPLOAD_DIR = "E:\\temp";
    
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        // gets absolute path of the web application
        //String applicationPath = request.getServletContext().getRealPath("");
        // constructs path of the directory to save uploaded file
        //String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
        String uploadFilePath = UPLOAD_DIR;
         
        // creates the save directory if it does not exists
        File fileSaveDir = new File(uploadFilePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }
        
		//Get all the parts from request and write it to the file on server
        
        ArrayList<String> input1 = new ArrayList<String>();
        ArrayList<String> input2 = new ArrayList<String>();
        
        String fileName = null;File f = null;
		for (Part part : request.getParts()) {
			if (part.getName().equals("task")) {
				String taskName = StreamToString(part.getInputStream());
				uploadFilePath = uploadFilePath + "/" + taskName;
				fileSaveDir = new File(uploadFilePath);
		        if (!fileSaveDir.exists()) {
		            fileSaveDir.mkdirs();
		        }
			}else {
				fileName = getFileName(part);
				f = new File(fileName);
				part.write(uploadFilePath + File.separator + f.getName());
				
				if(part.getName().equals("input1")) {
					input1.add(f.getName());
				}else {
					input2.add(f.getName());
				}
			}
		}
		
		ArrayListToFile(input1, uploadFilePath + "/query_list.txt");
		ArrayListToFile(input2, uploadFilePath + "/reference_list.txt");
		
//		String command = "/bin/bash -c " 
//				+ "/home/dell/FastANI1.1/fastANI --ql " 
//				+ uploadFilePath + "/query_list.txt --rl " 
//				+ uploadFilePath + "/reference_list.txt -o " 
//				+ uploadFilePath + "/ANI.out -t 8";
		
//		Runtime.getRuntime().exec(command);
		
 
//        request.setAttribute("message", fileName + " File uploaded successfully!");
//        getServletContext().getRequestDispatcher("/response.jsp").forward(
//                request, response);
    }
 
    /**
     * Utility method to get file name from HTTP header content-disposition
     */
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        System.out.println("content-disposition header= "+contentDisp);
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length()-1);
            }
        }
        return "";
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
    
    private void ArrayListToFile(ArrayList<String> list, String path) throws IOException {
    	FileWriter writer = new FileWriter(path); 
    	for(String str: list) {
    	  writer.write(str + System.lineSeparator());
    	}
    	writer.close();
    }
    
}
