package objects;

import java.util.ArrayList;
import java.util.List;

public class Lab {
	private String number;
	private String title;
	private String url;
	private List<File> files;
	
	// constructor to initialize dynamically allocated lists
	public Lab(){
		files = new ArrayList<>();
	}
	
	// getters
	public String getNumber(){
		return number;
	}
	
	public String getTitle(){
		return title;
	}
	
	public String getUrl(){
		return url;
	}
	
	public List<File> getFiles(){
		return files;
	}
}
