package linkshare;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.BioUI.servlet.TaskHandler;


public class LinkShareHandler extends TaskHandler{

	private ArrayList<String> selectLinks = new ArrayList<String>();
	private String text = "";
	private String uploader = "anonymous";
	private String url = "";
	
	public LinkShareHandler(HttpServletRequest request,
			HttpServletResponse response, HttpServlet listener) {
		super(request, response, listener);
	}
	
	@Override
	protected void onReceive(Part part) throws IOException {
		switch(part.getName()){
			case "selected_link":
				
				selectLinks.add(loadAny(part, 128, "", true));

				break;
			case "text":
				text = loadAny(part, 128, ""); break;
			case "url":
				url = loadAny(part, 512, ""); break;
			case "uploader":
				uploader = loadAny(part, 64, "anonymous"); break;
			default:
				System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "unknown input:" + part.getName() + "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}
	}
	
	@Override
	protected void onSetCommand() throws IOException {
		setResultMessage("");

		if(!text.isEmpty()){
			setResultMessage(ShareLinkManager.edit(true, uploader, text, url));
		}

		for(String selectLink:selectLinks){
			setResultMessage(ShareLinkManager.edit(false, "", selectLink, ""));
		}
		
		setProgram("Share Link Editor");
	}
}
