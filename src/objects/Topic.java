package objects;

import java.util.ArrayList;
import java.util.List;

public class Topic {
	private String number;
	private String title;
	private String url;
	private String chapter;
	private List<Program> programs;
	
	// constructor to initialize dynamically allocated lists
	public Topic(){
		programs = new ArrayList<>();
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
	
	public String getChapter(){
		return chapter;
	}
	
	public List<Program> getPrograms(){
		return programs;
	}
	
}
