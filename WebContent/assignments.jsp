<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="objects.*" %>
<%@ page import="parsing.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<% 
session = request.getSession();
DataContainer data = (DataContainer) session.getAttribute("data");

if(data == null) {
    response.sendRedirect("/Assignment3/index.jsp");
    return;
}
String style = (String) session.getAttribute("style");
School school = data.getSchools().get(0);
Department department = school.getDepartments().get(0);
Course course = department.getCourses().get(0);

// sorted assignments list by due date with reverse=false
List<Assignment> assignments = course.sortAssignmentsByDueDate(false);


// change school and department url???
		
%>

<html>
  <head>
  	<title><%= school.getName() + ": " + department.getPrefix() + " " + course.getNumber() + " " + course.getTerm() + " " + course.getYear() %></title>
  	<link rel="stylesheet" type="text/css" href="<%= style %>.css">
  	<script>
  	
  		function sorttable() {
  			
  			var xhttp = new XMLHttpRequest();
			xhttp.open("GET", "sortassignments.jsp"
					+ "?sort_a=" + document.myform.sort_a.value
					+ "&order_a=" + document.myform.order_a.value
					+ "&sort_d=" + document.myform.sort_d.value
					+ "&order_d=" + document.myform.order_d.value
					, false);
			xhttp.send();
			
  			document.getElementById("assignments").innerHTML = xhttp.responseText;
  			
  			return false;
  		}
  	
  	</script>
  	
  </head>
  <body text="#333333" bgcolor="#EEEEEE" link="#0000EE" vlink="#551A8B" alink="#336633">
    <table class="main" cellpadding="10" width="800">
      <tr>
        <!-- column for left side of page -->
        <td class="menu" width="180" valign="top" align="right">
          <a href="http://www.usc.edu"><img src="<%= school.getImage() %>" border="0"/></a><br /><br />
          <font size="+1"><a class="menu" href="http://cs.usc.edu">CS Department</a></font><br /><br />
          <font size="+1"><a class="menu" href="home.jsp">CSCI 201L Home</a></font><br /><br />
          <font size="+1"><a class="menu" href="<%= course.getSyllabus().getUrl() %>">Syllabus</a></font><br /><br />
          <font size="+1"><a class="menu" href="lectures.jsp">Lectures</a></font><br /><br />
          <font size="+1">Assignments</font><br /><br />
          <font size="+1"><a class="menu" href="exams.jsp">Previous Exams</a></font><br /><br />
        </td>
        <!-- center column to separate other two columns -->
        <td width="5"><br /></td>
        <!-- large column in center of page with dominant content -->
        <td align="baseline" width="615">
          <br />
          <p>
            <b><font size="+3"><%= department.getPrefix() + " " + course.getNumber() %></font></b><br />
            <b><i><font size="+1"><%= course.getTitle() + " - " + course.getUnits() + " units" %></font></i></b><br />
            <b><i><font size="+1"><%= course.getTerm() + " " + course.getYear() %></font></i></b><br />
          </p>
          <p><hr size="4" /></p>
			
		  
		  
		  <form id="myform" name="myform">
		  
		  	Assignments -- Sort By: 
		  	<input type="radio" name="sort_a" value="duedate" onchange="return sorttable();" checked="checked"> Due Date
		  	<input type="radio" name="sort_a" value="assdate" onchange="return sorttable();"> Assigned Date
		  	<input type="radio" name="sort_a" value="grade" onchange="return sorttable();"> Grade Percentage
		  	<br>
		  	<input type="radio" name="order_a" value="ascending" onchange="return sorttable();" checked="checked"> Ascending Order
		  	<input type="radio" name="order_a" value="descending" onchange="return sorttable();"> Descending Order
		  	
		  	<p><hr size="4" /></p>
		  	
		  	Deliverables -- Sort By: 
		  	<input type="radio" name="sort_d" value="duedate" onchange="return sorttable();" checked="checked"> Due Date
		  	<input type="radio" name="sort_d" value="title" onchange="return sorttable();"> Title
		  	<input type="radio" name="sort_d" value="grade" onchange="return sorttable();"> Grade Percentage
		  	<br>
		  	<input type="radio" name="order_d" value="ascending" onchange="return sorttable();" checked="checked"> Ascending Order
		  	<input type="radio" name="order_d" value="descending" onchange="return sorttable();"> Descending Order
		  
		  
		  </form>
		  
		  	<p><hr size="4" /></p>

          <b>Assignments</b>
          <table id="assignments" border="2" cellpadding="5" width="590">
            <tr>
              <th align="center">Homework #</th><th align="center">Assigned</th><th align="center" width="40">Due</th><th>Assignment</th><th>% Grade</th><th>Grading Criteria</th><th>Solution</th>
            </tr>
            
            
            <%            
            for (int i = 0; i < assignments.size(); i++) {
            	Assignment assignment = assignments.get(i);
            	List<File> files = assignment.getFiles();
            	// get deliverables in sorted order by due date with reverse=false
            	List<Deliverable> deliverables = assignment.sortDeliverablesByDueDate(false);
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
              		<% if (j != 0) { %><br><% } %>
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
              		<% if (j != 0) { %><br><% } %>
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
	                  <td>
	                    	<%= deliverable.getTitle() %>
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
				
	      
	      </table>
	  	</td>
	  	<td class="menu" width="10">
        
        </td>
	  </tr>	
	</table>            
  </body>
</html>             
	                  
	 