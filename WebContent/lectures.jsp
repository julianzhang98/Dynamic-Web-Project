<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="objects.*" %>
<%@ page import="parsing.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 
// check for timeout and if not, load all the data needed
session = request.getSession(false);

DataContainer data = (DataContainer) session.getAttribute("data");

if(data == null) {
    response.sendRedirect("/Assignment3/index.jsp");
    return;
}
String style = (String) session.getAttribute("style");
School school = data.getSchools().get(0);
Department department = school.getDepartments().get(0);
Course course = department.getCourses().get(0);
List<Assignment> assignments = course.getAssignments();
List<Exam> exams = course.getExams();


List<Textbook> books = course.getSchedule().getTextbooks();
List<Week> weeks = course.getSchedule().getWeeks();
Collections.sort(weeks);

Map<String, List<Assignment>> assignmentsByDueDate = course.getAssignmentsByDueDate();
Map<String, List<Deliverable>> deliverablesByDueDate = course.getDeliverablesByDueDate();
// change school and department url???
		
%>

<html>
  <head>
    <title><%= school.getName() + ": " + department.getPrefix() + " " + course.getNumber() + " " + course.getTerm() + " " + course.getYear() %></title>
	<link rel="stylesheet" type="text/css" href="<%= style %>.css">
	<script>
	
		function searchtopics() {
			clearsearch();
			
			var xhttp = new XMLHttpRequest();
			xhttp.open("GET", "searchtopic.jsp?search=" + document.myform.search.value, false);
			xhttp.send();
			
			//document.getElementById("formerror").innerHTML = document.myform.search.value;
			
			var topics = xhttp.responseText.split(",");
			
			/*
			if (ids[0] == "0") {
				document.getElementById("formerror").innerHTML = "No Results Found";
				return false;
			}
			*/
			var list = document.getElementsByClassName("topic");
			
			
			//document.getElementById("formerror").innerHTML = ids.length-1;

			for (var i = 0; i < list.length; i++) {
				
				
				
				var name = list[i].attributes["name"].value;
				
				for (var j = 0; j < topics.length - 1; j++) {
					if (name == topics[j]) {
						list[i].style="background-color: #00FFFF";
					}
				}
			}
			
			return false;
		}
		
		function clearsearch() {
			var list = document.getElementsByClassName("topic");
			for (var i = 0; i < list.length; i++) {
				list[i].style="background-color: ";
			}
			
		}
		function clearall() {
			document.getElementById("searchtext").value = "";
			clearsearch();
			
			return false;
		}
		function activate() {
			document.getElementById("searchtext").disabled = false;
			document.getElementById("searchsubmit").disabled = false;
			document.getElementById("searchreset").disabled = false;
		
		}
		
		function deactivate() {
			document.getElementById("searchtext").disabled = true;
			document.getElementById("searchsubmit").disabled = true;
			document.getElementById("searchreset").disabled = true;
		}
	
		function showduedates() {
			showall();
			
			deactivate();
			
			var list = document.getElementsByClassName("lecture");
			for (var i = 0; i < list.length; i++) {
				list[i].style="display:none;";
			}
			return false;
		}
		function showlectures() {
			showall();
			
			activate();
			
			var list = document.getElementsByClassName("duedate");
			for (var i = 0; i < list.length; i++) {
				list[i].style="display:none;";
			}
			return false;
			
		}
		function showall() {
			activate();
			
			var list = document.getElementsByClassName("lecture");
			for (var i = 0; i < list.length; i++) {
				list[i].style="display:";
			}
			
			var list = document.getElementsByClassName("duedate");
			for (var i = 0; i < list.length; i++) {
				list[i].style="display:";
			}
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
          <font size="+1">Lectures</font><br /><br />
          <font size="+1"><a class="menu" href="assignments.jsp">Assignments</a></font><br /><br />
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
            <b>Chapter references are from :<br />
         	<%
          	for (int i = 0; i < books.size(); i++) {
          		 Textbook book = books.get(i);
          	
          	%>
          		
          	<%= book.getAuthor() + ". " %><u><%= book.getTitle()%></u>
          	<%= ", " + book.getPublisher() + ", " + book.getYear() + ". ISBN " + book.getIsbn() %>          		
          		
          	<%
          	}
          	%>
          </b>
          <p><hr size="4" /></p>
          
		  <form id="myform" name="myform">
		  
		  	<!-- style="display:none;"  TO COLLAPSE COLUMNS -->
        	<!-- must return search() otherwise it will refresh the page -->
			<div id="formerror"></div>
			<input type="text" name="search" id="searchtext"/>
			<button name="submit" id="searchsubmit" onclick="return searchtopics();">Search Topics</button>
			<button name="reset" id="searchreset" onclick="return clearall();">Clear Search</button>
			
		 
		    <p><hr size="4" /></p>
		  
			
			<input type="radio" name="shown" value="lectures" onchange="return showlectures();"> Show Lectures
  			<input type="radio" name="shown" value="duedates" onchange="return showduedates();"> Show Due Dates
  			<input type="radio" name="shown" value="all" checked="checked" onchange="return showall()"> Show All
			    
		  </form>
		  
		  <p><hr size="4" /></p>
		  
		  
          <b>Lectures</b>
         
    
          <table border="2" cellpadding="5" width="590">
          	
          
            <tr>
              <th align="center">Week #</th><th class="lecture" align="center">Lab</th><th align="center">Lecture #</th><th align="center">Day</th><th align="center" width="40">Date</th><th align="center">Lecture Topic</th><th align="center">Chapter</th><th>Program</th>
            </tr>
          
          
          <%
          for (int i = 0; i < weeks.size(); i++) {
        	  Week week = weeks.get(i);
        	  List<Lecture> lectures = week.getLectures();
        	  List<Lab> labs = week.getLabs();
          %>
          	
          	  <%
          	  for (int j = 0; j < lectures.size(); j++) {
          		  Lecture lecture = lectures.get(j);
          	  %>
          	  
          	  	<tr>
          	  	  <%
          	  	  if (j == 0) {
          	  		  
          	  		  // find number of rows this shit needs to be
          	  		  int additional_rows = 0;
          	  		  for (int k = 0; k < lectures.size(); k++) {
          	  			  String key = lectures.get(k).getDate();
          	  			  List<Assignment> a_list = assignmentsByDueDate.get(key);
          	  			  List<Deliverable> d_list = deliverablesByDueDate.get(key);
          	  			  if (a_list != null) additional_rows += a_list.size();
          	  			  if (d_list != null) additional_rows += d_list.size();
          	  		  }
          	  	  %>
          	  		<td align="center" rowspan="<%= lectures.size() + additional_rows %>"><%= week.getWeek() %></td>
          	  		<td class="lecture" align="center" rowspan="<%= lectures.size() + additional_rows %>">
		          		<%
		          		for (int k = 0; k < labs.size(); k++) {
		          			Lab lab = labs.get(k);
		          			List<File> lab_files = lab.getFiles();
		          		%>
		          			<%
		          			if (k != 0) {
		          			%>
		          				<hr />
		          			<%
		          			}
		          			%>
		          			
		          			<a href="<%= lab.getUrl() %>"><%= lab.getTitle() %></a>
		          			
		          			
		          			<%
		          			if (lab_files != null) {
		          				for (int l = 0; l < lab_files.size(); l++) {
		          					File file = lab_files.get(l);
		          			%>
		          					<br>
		          					<a href="<%= file.getUrl() %>"><%= file.getTitle() %></a>
		          			<%
		          				}
		          			}
		          			%>
		          			
		          		<%
		          		}
		          		%>
          			</td>
          	  	  <%
          	  	  }
          	  	  %>
          	  	  
          	  	  <!-- FIRST TWO COLUMNS FINISHED -->
          	  	  
          	  	  <td class="lecture" align="center"><%= lecture.getNumber() %></td>
          	  	  <td class="lecture" align="center"><%= lecture.getDay() %></td>
          	  	  <td class="lecture" align="center"><%= lecture.getDate() %></td>
          	  	  
          	  	  <%
          	  	  List<Topic> topics = lecture.getTopics();
          	  	  
          	  	  List<String> chapters = new ArrayList<>();
          	  	  List<File> program_files = new ArrayList<>();
          	  	  
          	  	  for (int k = 0; k < topics.size(); k++) {
          	  		  Topic topic = topics.get(k);
          	  		  List<Program> programs = topic.getPrograms();
          	  		  String chapter = topic.getChapter();
          	  		  
          	  		  if (!chapters.contains(chapter) && chapter != null) chapters.add(chapter);
          	  		  
          	  		            	  		  
          	  		  for (int l = 0; l < programs.size(); l++) {
          	  			  Program program = programs.get(l);
          	  			  List<File> files = program.getFiles();
          	  			  
          	  			  for (int m = 0; m < files.size(); m++) {
          	  				  File file = files.get(m);
          	  				  
          	  				  boolean add = true;
          	  				  for (int n = 0; n < program_files.size(); n++) {
          	  					  File temp = program_files.get(n);
          	  					  if (temp.getTitle().equals(file.getTitle()) && temp.getUrl().equals(file.getUrl())) {
          	  						  add = false;
          	  				  	  }
          	  				  }
          	  				  
          	  				  if (add) {
          	  					  program_files.add(file);
          	  				  }
          	  				  
          	  			  }
          	  		  }
          	  		  
          	  	  }
          	  	  
          	  	  %>
          	  	  
          	  	  <td class="lecture" align="center">
          	  	  
          	  	  <%
          	  	  for (int k = 0; k < topics.size(); k++) {
          	  		  Topic topic = topics.get(k);
          	  	  %>
          	  	  	<%
					if (k != 0) {
					%>
						<hr />
					<%
					}
					%>
									
					<a class="topic" name="<%= topic.getTitle().toLowerCase() %>" href="<%= topic.getUrl() %>"><%= topic.getTitle() %></a>
          	  	  <%
          	  	  }
          	  	  %>
          	  	  
          	  	  </td>
          	  	  <td class="lecture" align="center">
          	  	  <%
          	  	  for (int k = 0; k < chapters.size(); k++) {
          	  		  String chapter = chapters.get(k);
          	  		  
          	  	  %>
          	  	  
          	  	  	<%
          	  	  	if (k != 0) {
          	  	  	%>
          	  	  		,
          	  	  	<%
          	  	  	}
          	  	  	%>
          	  	  	
          	  	  	<%= chapter %>
          	  	  	
          	  	  
          	  	  <%
          	  	  }
          	  	  %>
          	  	  
          	  	  </td>
          	  	  <td class="lecture" align="center">
          	  	  
          	  	  <%
          	  	  for (int k = 0; k < program_files.size(); k++) {
          	  		  File file = program_files.get(k);
          	  	  %>
          	  	  
          	  	  	<%
          	  	  	if (k != 0) {
          	  	  	%>
          	  	  		<br>
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
          	  	List<Assignment> a_list = assignmentsByDueDate.get(lecture.getDate());
          	  	
          	  	if (a_list != null) {
          	  	%>
          	  	  	
          	  	  <%
          	  	  for (int l = 0; l < a_list.size(); l++) {
          	  		Assignment a = a_list.get(l);
          	  	  	
          	  	  %>
          	  	  		
          	  	  	<tr>
          	  	  	  <td class="duedate" align="center"><%= lecture.getNumber() %></td>
          	  	  	  <td class="duedate" align="center"><%= lecture.getDay() %></td>
          	  	  	  <td class="duedate" align="center"><%= lecture.getDate() %></td>
          	  	  	  <td class="duedate" align="right" colspan="3"><font size="+1" color="red"><b>ASSIGNMENT <%= a.getNumber() %> DUE</b></font></td>
          	  	  	</tr>
          	  	  <%
          	  	  }
          	  	  %>
          	  	<%
          	  	}
          	  	%>
          	  	  
          	  	  
          	  	  
          	  	  
          	  	<%
          	  	List<Deliverable> d_list = deliverablesByDueDate.get(lecture.getDate());
          	  	  
          	  	if (d_list != null) {
          	  	%>
          	  	  	
          	  	  <%
          	  	  for (int l = 0; l < d_list.size(); l++) {
          	  	  	Deliverable d = d_list.get(l);
          	  	  	
          	  	  %>
          	  	  		
          	  	  	<tr>
          	  	  	  <td class="duedate" align="center"><%= lecture.getNumber() %></td>
          	  	  	  <td class="duedate" align="center"><%= lecture.getDay() %></td>
          	  	  	  <td class="duedate" align="center"><%= lecture.getDate() %></td>
          	  	  	  <td class="duedate" align="right" colspan="3"><font size="+1" color="red"><b><%= d.getTitle() %> DUE</b></font></td>
          	  	  	</tr>
          	  	  <%
          	  	  }
          	  	  %>
          	  	<%
          	  	}
          	  	%>
          	  	   
          	  	  
          	  	  
          	  	  
          	  	  
 		  	  <%
 		  	  }
 		  	  %>
          	
          	
          	
          	
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