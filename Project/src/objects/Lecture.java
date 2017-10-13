package objects;

import java.util.ArrayList;
import java.util.List;

public class Lecture {
	private String number;
	private String date;
	private String day;
	private List<Topic> topics;
	
	// constructor to initialize dynamically allocated lists
	public Lecture(){
		topics = new ArrayList<>();
	}
	
	// getters
	public String getNumber(){
		return number;
	}
	
	public String getDate(){
		return date;
	}
	
	public String getDay(){
		return day;
	}
	
	public List<Topic> getTopics(){
		return topics;
	}
}
