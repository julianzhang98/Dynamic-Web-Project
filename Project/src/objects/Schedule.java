package objects;

import java.util.ArrayList;
import java.util.List;

public class Schedule {
	List<Textbook> textbooks;
	List<Week> weeks;
	
	// constructor to initialize dynamically allocated lists
	public Schedule(){
		textbooks = new ArrayList<>();
		weeks = new ArrayList<>();
	}
	
	// getters
	public List<Textbook> getTextbooks(){
		return textbooks;
	}
	
	public List<Week> getWeeks(){
		return weeks;
	}

}
