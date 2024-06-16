package linkshare;

import java.util.ArrayList;
import java.io.FileOutputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;

import com.BioUI.servlet.Config;

public class ShareLinkManager {
	
	public synchronized static String edit(Boolean add, String uploader, String text, String url){

		ArrayList<ShareLink> links;
		links = readFile();

		ShareLink target = new ShareLink(uploader, text, url);

		if(add){
			if(links.contains(target)){
				return("duplicate link name, please alter the link name and try again");
			}else{
				links.add(target);
				writeFile(links);
				return("<b>link added:</b>" + target.toString());
			}
		}else{
			if(links.contains(target)){
				links.remove(target);
				writeFile(links);
				return("<b>link reomved:</b>" + target.toString());
			}else{
				return("error: link not found");
			}
		}
	}
	
	public static String getShareLink(Boolean addCheckbox){
		String output = "";
		ArrayList<ShareLink> links = readFile();

		if(addCheckbox){
			for(ShareLink link:links){
				output = output + "&emsp;" + link.getCheckbox() + link.toString() + "<br>";
			}
		}else{
			for(ShareLink link:links){
				output = output + link.toString() + "<br>";
			}
		}
		
		return(output);
	}

	private static void writeFile(ArrayList<ShareLink> content){
		try {
            FileOutputStream fos = new FileOutputStream(Config.SHARELINK_PATH);
            ObjectOutputStream oos = new ObjectOutputStream(fos);
            oos.writeObject(content);
            oos.close();
            fos.close();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
	}

	@SuppressWarnings("unchecked")
	private static ArrayList<ShareLink> readFile() {

        ArrayList<ShareLink> result = new ArrayList<ShareLink>();
        
		try {
            FileInputStream fis = new FileInputStream(Config.SHARELINK_PATH);
            ObjectInputStream ois = new ObjectInputStream(fis);
 
            result = (ArrayList<ShareLink>) ois.readObject();
 
            ois.close();
            fis.close();
        } catch (IOException ioe) {
            ioe.printStackTrace();
            System.out.println("ShareLink file not found: create an empty one");
            writeFile(new ArrayList<ShareLink>());
            return new ArrayList<ShareLink>();
        } catch (ClassNotFoundException c) {
            System.out.println("Class not found");
            c.printStackTrace();
            return null;
        }

        return result;
    }
	
}

class ShareLink implements Serializable{

	private static final long serialVersionUID = 1L;

	private String uploader;
	private String text;
	private String url;
	
	ShareLink(String uploader, String text, String url){
		this.uploader = uploader;
		this.text = text;
		this.url = url;
	}

	public String getCheckbox(){
		// <input type="checkbox" onchange="expandParams(this)">
		return("<input type=\"checkbox\" name=\"selected_link\" value=\"" + this.text + "\">");
	}
	
	@Override
	public boolean equals(Object obj){
		if(obj == null)
			return false;
		if(obj instanceof ShareLink){
			ShareLink ShareLinkObj = (ShareLink)obj;
			if(this.text.equals(ShareLinkObj.text)){
				return true;
			}
		}
		return false;
	}
	
	@Override
	public String toString(){
		return(uploader + ": <a href=\"" + url + "\" target=\"_blank\">" + text + "</a>");
	}
}