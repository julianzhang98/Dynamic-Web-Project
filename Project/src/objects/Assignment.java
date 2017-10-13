package objects;

import java.util.ArrayList;
import java.util.List;


public class Assignment {
	
	private String number;
	private String assignedDate;
	private String dueDate;
	private String title;
	private String url;
	private String gradePercentage;
	private List<File> files;
	private List<Deliverable> deliverables;
	private List<File> gradingCriteriaFiles;
	private List<File> solutionFiles;
	
	private List<Deliverable> deliverablesSortedByDueDate;
	private List<Deliverable> deliverablesSortedByTitle;
	private List<Deliverable> deliverablesSortedByGradePercentage;
	private List<Deliverable> deliverablesReversedDueDate;
	private List<Deliverable> deliverablesReversedTitle;
	private List<Deliverable> deliverablesReversedGradePercentage;
	
	
	// constructor to initialize dynamically allocated lists
	public Assignment(){
		files = new ArrayList<>();
		deliverables = new ArrayList<>();
		gradingCriteriaFiles = new ArrayList<>();
		solutionFiles = new ArrayList<>();
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
	
	public String getAssignedDateInDateForm() {
		String [] strings = assignedDate.split("-");
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
	
	public List<Deliverable> getDeliverables(){
		return deliverables;
	}
	
	public List<File> getGradingCriteriaFiles(){
		return gradingCriteriaFiles;
	}
	
	public List<File> getSolutionFiles(){
		return solutionFiles;
	}
	
	public List<Deliverable> sortDeliverablesByDueDate(boolean reverse) {
		
		if (deliverablesSortedByDueDate == null) {
			
			deliverablesSortedByDueDate = new ArrayList<>();
			deliverablesReversedDueDate = new ArrayList<>();
			
			for (int i = 0; i < deliverables.size(); i++) {
				deliverablesSortedByDueDate.add(deliverables.get(i));
				deliverablesReversedDueDate.add(deliverables.get(i));
			}
			
			// sort
			deliverablesSortedByDueDate.sort((a,b)->a.getDueDateInDateForm().compareTo(b.getDueDateInDateForm()));
			deliverablesReversedDueDate.sort((a,b)->b.getDueDateInDateForm().compareTo(a.getDueDateInDateForm()));
			
			
		}
		
		if (reverse) return deliverablesReversedDueDate;
		return deliverablesSortedByDueDate;
	}
	public List<Deliverable> sortDeliverablesByTitle(boolean reverse) {
		
		if (deliverablesSortedByTitle == null) {
			deliverablesSortedByTitle = new ArrayList<>();
			deliverablesReversedTitle = new ArrayList<>();
				
			for (int i = 0; i < deliverables.size(); i++) {
				
				deliverablesSortedByTitle.add(deliverables.get(i));
				deliverablesReversedTitle.add(deliverables.get(i));
				
			}
			
			// sort
			deliverablesSortedByTitle.sort((a,b)->a.getTitle().compareTo(b.getTitle()));
			deliverablesReversedTitle.sort((a,b)->b.getTitle().compareTo(a.getTitle()));
			
			
		}
		
		if (reverse) return deliverablesReversedTitle;
		return deliverablesSortedByTitle;
		
	}
	
	public List<Deliverable> sortDeliverablesByGradePercentage(boolean reverse) {
		
		if (deliverablesSortedByGradePercentage == null) {
			deliverablesSortedByGradePercentage = new ArrayList<>();
			deliverablesReversedGradePercentage = new ArrayList<>();
			
			for (int i = 0; i < deliverables.size(); i++) {
				deliverablesSortedByGradePercentage.add(deliverables.get(i));
				deliverablesReversedGradePercentage.add(deliverables.get(i));
			}
			
			// sort
			deliverablesSortedByGradePercentage.sort((a,b)->a.getPaddedGradePercentage().compareTo(b.getPaddedGradePercentage()));
			deliverablesReversedGradePercentage.sort((a,b)->b.getPaddedGradePercentage().compareTo(a.getPaddedGradePercentage()));
			
			
		}
		
		if (reverse) return deliverablesReversedGradePercentage;
		return deliverablesSortedByGradePercentage;
	}
	
	
}
