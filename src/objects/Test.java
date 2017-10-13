package objects;

import java.util.ArrayList;
import java.util.List;

public class Test {
	private String title;
	private List<File> files;
	
	// constructor to initialize dynamically allocated lists
	public Test(){
		files = new ArrayList<>();
	}
	
	// getters
	public String getTitle(){
		return title;
	}
	
	public List<File> getFiles(){
		return files;
	}
}
