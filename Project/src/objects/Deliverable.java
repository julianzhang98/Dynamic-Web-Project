package objects;

import java.util.ArrayList;
import java.util.List;


public class Deliverable { 
	
	private String number;
	private String assignedDate;
	private String dueDate;
	private String title;
	private String url;
	private String gradePercentage;
	private List<File> files;
	
	public Deliverable(){
		super();
		files = new ArrayList<>();
	}

	// getters
	public String getNumber(){
		return number;
	}
	
	public String getAssignedDate(){
		return assignedDate;
	}
	
	public String getDueDate(){
		return dueDate;
	}
	
	public String getDueDateInDateForm() {
		String [] strings = dueDate.split("-");
		for (int i = 0; i < strings.length - 1; i++) {
			if (i == 0 || i == 1) {
				if (strings[i].length() == 1) {
					strings[i] = "0" + strings[i];
				}
			}
		}
		
		return (strings[2] + "-" + strings[0] + "-" + strings[1]);
	}
	
	public Double getPaddedGradePercentage() {
		String [] strings = gradePercentage.split("%");
		double retval = Double.parseDouble(strings[0]);
		Double d = new Double(retval);
		return d;
		
	}
	
	public String getTitle(){
		return title;
	}
	
	public String getUrl(){
		return url;
	}
	
	public String getGradePercentage(){
		return gradePercentage;
	}
	
	public List<File> getFiles(){
		return files;
	}
	
}