package objects;

import java.util.ArrayList;
import java.util.List;

public class Exam {
	private String semester;
	private Integer year;
	private List<Test> tests;
	
	// constructor to initialize dynamically allocated lists
	public Exam(){
		tests = new ArrayList<>();
	}
	
	// getters
	public String getSemester(){
		return semester;
	}
	
	public Integer getYear(){
		return year;
	}
	
	public List<Test> getTests(){
		return tests;
	}
	
}
