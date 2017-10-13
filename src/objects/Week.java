package objects;

import java.util.ArrayList;
import java.util.List;

// implements comparable for sorting purposes
public class Week implements Comparable<Week> {
	private Integer week;
	private List<Lab> labs;
	private List<Lecture> lectures;
	
	// constructor to initialize dynamically allocated lists
	public Week(){
		labs = new ArrayList<>();
		lectures = new ArrayList<>();
	}
	
	// comparator function
	public int compareTo(Week other) {
        return week.compareTo(other.week);
    }
	
	// getters
	public Integer getWeek(){
		return week;
	}
	
	public List<Lab> getLabs(){
		return labs;
	}
	
	public List<Lecture> getLectures(){
		return lectures;
	}
	
}
