<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="objects.*" %>
<%@ page import="parsing.*" %>
<%@ page import="java.util.*" %>



<% 
session = request.getSession();
DataContainer data = (DataContainer) session.getAttribute("data");

if(data == null) {
    response.sendRedirect("/Assignment3/index.jsp");
    return;
}

School school = data.getSchools().get(0);
Department department = school.getDepartments().get(0);
Course course = department.getCourses().get(0);

List<Assignment> assignments;

String sort_a = request.getParameter("sort_a");
String sort_d = request.getParameter("sort_d");
String order_a = request.getParameter("order_a");
String order_d = request.getParameter("order_d");

boolean reverse = false;
if (order_a.equals("descending")) {
	reverse = true;
}
if (sort_a.equals("duedate")) {
	assignments = course.sortAssignmentsByDueDate(reverse);
} else if (sort_a.equals("assdate")) {
	assignments = course.sortAssignmentsByAssignedDate(reverse);
} else if (sort_a.equals("grade")) {
	assignments = course.sortAssignmentsByGradePercentage(reverse);
} else {
	assignments = new ArrayList<>(); // just to appease the compiler
}

/*
if (order_a.equals("descending")) {
	Collections.reverse(assignments);
}
*/
%>

<tr>
<th align="center">Homework #</th><th align="center">Assigned</th><th align="center" width="40">Due</th><th>Assignment</th><th>% Grade</th><th>Grading Criteria</th><th>Solution</th>
</tr>
 
 
<% 
for (int i = 0; i < assignments.size(); i++) {
 	Assignment assignment = assignments.get(i);
 	List<File> files = assignment.getFiles();
 	List<Deliverable> deliverables;// = assignment.getDeliverables();
 	
 	boolean reverse_deliverables = false;
 	if (order_d.equals("descending")) {
 		reverse_deliverables = true;
 	}
 	if (sort_d.equals("duedate")) {
 		deliverables = assignment.sortDeliverablesByDueDate(reverse_deliverables);
 	} else if (sort_d.equals("title")) {
 		deliverables = assignment.sortDeliverablesByTitle(reverse_deliverables);
 	} else if (sort_d.equals("grade")) {
 		deliverables = assignment.sortDeliverablesByGradePercentage(reverse_deliverables);
 	} else {
 		System.out.println("here");
 		deliverables = new ArrayList<>(); // just to appease the compiler
 	}
%>
 
 
	<tr>
		<td align="center"><%= assignment.getNumber() %></td>
		<td align="center"><%= assignment.getAssignedDate() %></td>
	<%
	if (deliverables.size() == 0) {
		List<File> gradingCriteriaFiles = assignment.getGradingCriteriaFiles();
		List<File> solutionFiles = assignment.getSolutionFiles();
	%>
		<td align="center"><%= assignment.getDueDate() %></td>
		<td align="center">
		<%
		if (assignment.getTitle() != null) {
		%>
			<a href="<%= assignment.getUrl() %>"><%= assignment.getTitle() %></a><hr />
		<%
		}
		%>

		<%
		for (int j = 0; j < files.size(); j++) {
			File file = files.get(j);
			if (j != 0) {
			%>
				<hr />
			<%
			}
			%>
			<a href="<%= file.getUrl() %>"><%= file.getTitle() %></a>
			 	
		<%
		}
		%>
	
		</td>
		<td align="center"><%= assignment.getGradePercentage() %></td>
	
		<td align="center">
	
		<%
		for (int j = 0; j < gradingCriteriaFiles.size(); j++) {
			File gcf = gradingCriteriaFiles.get(j);
		%>
			<% 
			if (j != 0) { %><br><% } 
			%>
			<a href="<%= gcf.getUrl() %>"><%= gcf.getTitle() %></a>
		<%
		}
		%>
		</td>
		
		<td align="center">
		<%
		for (int j = 0; j < solutionFiles.size(); j++) {
			File sf = solutionFiles.get(j);
		%>
			<% 
			if (j != 0) { %><br><% }
			%>
			<a href="<%= sf.getUrl() %>"><%= sf.getTitle() %></a>
		<%
		}
		%>
		</td>
	<%
	} else {
	%>
		<td align="center" colspan="3">
			<table border="1" cellpadding="5">
				<tr>
					<td colspan="3" align="center">

					<% 
					if (assignment.getTitle() != null ) {
					%>
						<a href="<%= assignment.getUrl() %>"><%= assignment.getTitle() %></a><hr />
					<%
					}
					for (int j = 0; j < files.size(); j++) {
						File file = files.get(j);
						if (j != 0) {
					%>
							<hr />
						<%
						}
						%>
						<a href="<%= file.getUrl() %>"><%= file.getTitle() %></a>
						 	
					<%
					}
					%>
	
	 
					</td>
				</tr>
				<%
				for (int j = 0; j < deliverables.size(); j++) {
					Deliverable deliverable = deliverables.get(j);
					List<File> deliverable_files = deliverable.getFiles();
				%>
				  <tr>
					<td><%= deliverable.getDueDate() %></td>
					<td><%= deliverable.getTitle() %>
					<%
					for (int k = 0; k < deliverable_files.size(); k++) {
					 	File d_file = deliverable_files.get(k);
					%>
						<hr />
						<a href="<%= d_file.getUrl() %>"><%= d_file.getTitle() %></a>
				
					<%
					}
					%>
					</td>	
					<td><%= deliverable.getGradePercentage() %></td>
				  </tr>
		
				<%
				}
				%>
			</table>
		</td>
	<%
	}
	%>
	</tr>
			
<%
}
%>
				