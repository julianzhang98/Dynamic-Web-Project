package objects;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class Course {
	private String number;
	private String title;
	private Integer units;
	private String term;
	private Integer year;
	private Syllabus syllabus;
	private Schedule schedule;
	private List<Assignment> assignments;
	private List<Exam> exams;
	private List<StaffMember> staffMembers;
	private List<Meeting> meetings;
	//meetings sorted into a map, key is the meeting type, value is a list of all meetings of that type
	private Map<String, List<Meeting>> sortedMeetings;
	//staff sorted into a map, key is the staff type, value is a list of all staff members of that type
	private Map<String, List<StaffMember>> sortedStaff;
	//map from staff member ID to staff member object
	private Map<Integer, StaffMember> staffMap;
	//2 dimensional "map array" of staff by day and timeslot
	private Map<String, Map<String, StaffMember>> staffByDay;
	//map from due date of assignment to assignment object
	private Map<String, List<Assignment>> assignmentsByDueDate;
	
	private Map<String, List<Deliverable>> deliverablesByDueDate;
	
	private List<Assignment> assignmentsSortedByDueDate;
	private List<Assignment> assignmentsSortedByAssignedDate;
	private List<Assignment> assignmentsSortedByGradePercentage;
	private List<Assignment> assignmentsReversedDueDate;
	private List<Assignment> assignmentsReversedAssignedDate;
	private List<Assignment> assignmentsReversedGradePercentage;
	
	// constructor to initialize dynamically allocated lists
	public Course(){
		staffMembers = new ArrayList<>();
		meetings = new ArrayList<>();
		assignments = new ArrayList<>();
		exams = new ArrayList<>();
	}
	
	// getters
	public String getNumber(){
		return number;
	}
	
	public String getTitle(){
		return title;
	}
	
	public Integer getUnits(){
		return units;
	}
	
	public String getTerm(){
		return term;
	}
	
	public Integer getYear(){
		return year;
	}
	
	public Syllabus getSyllabus(){
		return syllabus;
	}
	
	public Schedule getSchedule(){
		return schedule;
	}
	
	public List<Assignment> getAssignments(){
		return assignments;
	}
	
	public List<Exam> getExams(){
		return exams;
	}
	
	public List<StaffMember> getStaffMembers(){
		return staffMembers;
	}
	
	public List<Meeting> getMeetings(){
		return meetings;
	}
	
	// sorted data structures below
	
	public Map<String, List<Meeting>> getSortedMeetings(){
		if (sortedMeetings == null){
			//group the meetings by their type (by the method getMeetingType)
			sortedMeetings = meetings.stream().collect(Collectors.groupingBy(Meeting::getMeetingType));
		}
		return sortedMeetings;
	}
	
	public Map<String, List<StaffMember>> getSortedStaff(){
		if (sortedStaff == null){
			//group the staffMembers by their type (by the method getJobType)
			sortedStaff = staffMembers.stream().collect(Collectors.groupingBy(StaffMember::getJobType));
		}
		return sortedStaff;
	}
	
	public Map<Integer, StaffMember> getMappedStaff(){
		if (staffMap == null){
			staffMap = new HashMap<>();
			//create a map from the ID number to the StaffMember object
			staffMembers.stream().forEach(staff->{
				staffMap.put(staff.getID(), staff);
			});
		}
		return staffMap;
	}
	
	public Map<String, Map<String, StaffMember>> getStaffByDay() {
		if (staffByDay == null){
			staffByDay = new HashMap<>();
			for (int i = 0; i < 6; i++) {
				Map<String, StaffMember> staff = new HashMap<>();
				
				// chooses the day
				String day = "";
				
				if (i == 0) {
					day = "Monday";
				} else if (i == 1) {
					day = "Tuesday";
				} else if (i == 2) {
					day = "Wednesday";
				} else if (i == 3) {
					day = "Thursday";
				} else if (i == 4) {
					day = "Friday";
				} else if (i == 5) {
					day = "Saturday";
				} 
				// insert 6 empty maps - one for each day
				staffByDay.put(day, staff);
			}
			
			// loop through staff members and insert them into maps based on days of OH
			for (int i = 0; i < staffMembers.size(); i++) {
				StaffMember staff = staffMembers.get(i);
				if (staff.getJobType().equalsIgnoreCase("instructor")) {
					continue;
				}
				List<TimePeriod> officehours = staff.getOH();
				for (int j = 0; j < officehours.size(); j++) {
					TimePeriod oh = officehours.get(j);
					String day = oh.getDay();
					String time = oh.getTime().toString();
					staffByDay.get(day).put(time, staff);
				}
			}
			
		}
		return staffByDay;
	}
	
	public Map<String, List<Assignment>> getAssignmentsByDueDate(){
		
		if (assignmentsByDueDate == null){
			//group the assignments by their type (by the method getDueDate)
			
			//assignmentsByDueDate = assignments.stream().collect(Collectors.groupingBy(Assignment::getDueDate)); // DOESN'T WORK?
			
			// alternate method
			assignmentsByDueDate = new HashMap<String, List<Assignment>>();
			// loop through assignments
			for (int i = 0; i < assignments.size(); i++) {
				Assignment a = assignments.get(i);
				
				// insert it into map
				if (assignmentsByDueDate.containsKey(a.getDueDate())) {
					assignmentsByDueDate.get(a.getDueDate()).add(a);
				} else {
					List<Assignment> temp = new ArrayList<>();
					temp.add(a);
					assignmentsByDueDate.put(a.getDueDate(), temp);
				}
				
			}
		}
		return assignmentsByDueDate;
		/*
		if (assignmentsByDueDate == null) {
			assignmentsByDueDate = new HashMap<>();
			//create a map from the due date to the Assignment object
			assignments.stream().forEach(assignment->{
				assignmentsByDueDate.put(assignment.getDueDate(), assignment);
			});
		}
		return assignmentsByDueDate;
		*/
	}
	
	
	public Map<String, List<Deliverable>> getDeliverablesByDueDate() {
		
		// if deliverablesByDueDate has not been instantiated
		if (deliverablesByDueDate == null) {
			
			deliverablesByDueDate = new HashMap<String, List<Deliverable>>();
			
			// loop through assignments
			for (int i = 0; i < assignments.size(); i++) {
				Assignment a = assignments.get(i);
				
				// find deliverables
				List<Deliverable> d_list = a.getDeliverables();
				if (d_list == null) continue; // if assignment doesn't have deliverables
				
				// loop through deliverables
				for (int j = 0; j < d_list.size(); j++) {
					Deliverable d = d_list.get(j);
					
					// put deliverables into map of deliverable lists based on due date
					if (deliverablesByDueDate.containsKey(d.getDueDate())) {
						deliverablesByDueDate.get(d.getDueDate()).add(d);
					} else {
						List<Deliverable> temp = new ArrayList<>();
						temp.add(d);
						deliverablesByDueDate.put(d.getDueDate(), temp);
					}
				}
				
			}
		}
		
		return deliverablesByDueDate;
	}
	
	
	public List<Assignment> sortAssignmentsByDueDate(boolean reverse) {
		
		if (assignmentsSortedByDueDate == null) {
			
			assignmentsSortedByDueDate = new ArrayList<>();
			assignmentsReversedDueDate = new ArrayList<>();
			
			// stores normal assignments in one array and projects in another
			List<Assignment> projects_with_deliverables = new ArrayList<>();
			
			for (int i = 0; i < assignments.size(); i++) {
				if (assignments.get(i).getDeliverables().size() == 0) {
					assignmentsSortedByDueDate.add(assignments.get(i));
					assignmentsReversedDueDate.add(assignments.get(i));
				} else {
					projects_with_deliverables.add(assignments.get(i));
				}
			}
			
			// sort
			assignmentsSortedByDueDate.sort((a,b)->a.getDueDateInDateForm().compareTo(b.getDueDateInDateForm()));
			assignmentsReversedDueDate.sort((a,b)->b.getDueDateInDateForm().compareTo(a.getDueDateInDateForm()));
			
			//if (reverse) Collections.reverse(assignmentsSortedByDueDate);
			
			assignmentsSortedByDueDate.addAll(projects_with_deliverables);
			assignmentsReversedDueDate.addAll(projects_with_deliverables);
		}
		
		if (reverse) return assignmentsReversedDueDate;
		return assignmentsSortedByDueDate;
	}
	public List<Assignment> sortAssignmentsByAssignedDate(boolean reverse) {
		
		if (assignmentsSortedByAssignedDate == null) {
			assignmentsSortedByAssignedDate = new ArrayList<>();
			assignmentsReversedAssignedDate = new ArrayList<>();
						
			// stores normal assignments in one array and projects in another
			List<Assignment> projects_with_deliverables = new ArrayList<>();
			
			for (int i = 0; i < assignments.size(); i++) {
				if (assignments.get(i).getDeliverables().size() == 0) {
					assignmentsSortedByAssignedDate.add(assignments.get(i));
					assignmentsReversedAssignedDate.add(assignments.get(i));
				} else {
					projects_with_deliverables.add(assignments.get(i));
				}
			}
			
			// sort
			assignmentsSortedByAssignedDate.sort((a,b)->a.getAssignedDateInDateForm().compareTo(b.getAssignedDateInDateForm()));
			assignmentsReversedAssignedDate.sort((a,b)->b.getAssignedDateInDateForm().compareTo(a.getAssignedDateInDateForm()));
			
			//if (reverse) Collections.reverse(assignmentsSortedByAssignedDate);
			
			assignmentsSortedByAssignedDate.addAll(projects_with_deliverables);
			assignmentsReversedAssignedDate.addAll(projects_with_deliverables);
			
		}
		
		if (reverse) return assignmentsReversedAssignedDate;
		return assignmentsSortedByAssignedDate;
		
	}
	
	public List<Assignment> sortAssignmentsByGradePercentage(boolean reverse) {
		
		if (assignmentsSortedByGradePercentage == null) {
			assignmentsSortedByGradePercentage = new ArrayList<>();
			assignmentsReversedGradePercentage = new ArrayList<>();
			
			// stores normal assignments in one array and projects in another
			List<Assignment> projects_with_deliverables = new ArrayList<>();
			
			for (int i = 0; i < assignments.size(); i++) {
				if (assignments.get(i).getDeliverables().size() == 0) {
					assignmentsSortedByGradePercentage.add(assignments.get(i));
					assignmentsReversedGradePercentage.add(assignments.get(i));
				} else {
					projects_with_deliverables.add(assignments.get(i));
				}
			}
			
			// sort
			assignmentsSortedByGradePercentage.sort((a,b)->a.getPaddedGradePercentage().compareTo(b.getPaddedGradePercentage()));
			assignmentsReversedGradePercentage.sort((a,b)->b.getPaddedGradePercentage().compareTo(a.getPaddedGradePercentage()));
			
			//if (reverse) Collections.reverse(assignmentsSortedByGradePercentage);
			
			assignmentsSortedByGradePercentage.addAll(projects_with_deliverables);
			assignmentsReversedGradePercentage.addAll(projects_with_deliverables);
			
		}
		
		if (reverse) return assignmentsReversedGradePercentage;
		return assignmentsSortedByGradePercentage;
	}
	
	
}


