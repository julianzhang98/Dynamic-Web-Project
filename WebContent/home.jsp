

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>

<%@ page import="objects.*" %>
<%@ page import="parsing.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 
//check for timeout and if not, load all the data needed
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

//meetings sorted into a map, key is the meeting type, value is a list of all meetings of that type	
Map<String, List<Meeting>> sortedMeetings = course.getSortedMeetings();
//staff sorted into a map, key is the staff type, value is a list of all staff members of that type
Map<String, List<StaffMember>> sortedStaff = course.getSortedStaff();
//map from staff member ID to staff member object
Map<Integer, StaffMember> staffMap = course.getMappedStaff();


Map<String, Map<String, StaffMember>> staffByDay = course.getStaffByDay();
// change school and department url???
		
%>



<html>
  <head>
  	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    
    <title><%= school.getName() + ": " + department.getPrefix() + " " + course.getNumber() + " " + course.getTerm() + " " + course.getYear() %></title>
  	<link type="text/css" rel="stylesheet" href="<%= style %>.css" />
	<script>
		
		function clearall() {
			document.getElementById("searchtext").value = "";
			clearsearch();
			return false;
		}
	
		function clearsearch() {
			
			var list = document.getElementsByClassName("staff");
			for (var i = 0; i < list.length; i++) {
				list[i].style="background-color: ";
			}
		}
		function searchstaff() {
			
			clearsearch();
			
			var xhttp = new XMLHttpRequest();
			xhttp.open("GET", "searchstaff.jsp?search=" + document.myform.search.value, false);
			xhttp.send();
			
			/*
			if (xhttp.responseText.trim().length == 0) {
				document.getElementById("formerror").innerHTML = xhttp.responseText;
				return false;
			}
			*/
			
			var ids = xhttp.responseText.trim().split(",");
			
			/*
			if (ids[0] == "0") {
				document.getElementById("formerror").innerHTML = "No Results Found";
				return false;
			}
			*/
			var list = document.getElementsByClassName("staff");
			
			
			//document.getElementById("formerror").innerHTML = ids.length-1;

			for (var i = 0; i < list.length; i++) {
				
				
				
				var name = list[i].attributes["name"].value;
				
				for (var j = 0; j < ids.length - 1; j++) {
					if (name == ids[j]) {
						list[i].style="background-color: #00FFFF";
					}
				}
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
          <font size="+1"><a class="menu" href="http://cs.usc.edu"><%= department.getPrefix() + " Department" %></a></font><br /><br />
          <font size="+1"><%= department.getPrefix() + " " + course.getNumber() + " Home" %></font><br /><br />
          <font size="+1"><a class="menu" href="<%= course.getSyllabus().getUrl() %>">Syllabus</a></font><br /><br />
          <font size="+1"><a class="menu" href="lectures.jsp">Lectures</a></font><br /><br />
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
        
        <!-- SEARCH BAR -->
          
          
        <form id="myform" name="myform">
        	<!-- must return search() otherwise it will refresh the page -->
			<div id="formerror"></div>
			<input type="text" name="search" id="searchtext"/>
			<button name="submit" onclick="return searchstaff();">Search Staff</button>
			<button name="reset" onclick="return clearall();">Clear Search</button>
		</form>
         
          
          <p><hr size="4" /></p>
          
          <p><font size="-1">
            <table class="content" border="1">
              <tr class="header">
                <th align="center">Picture</th>
                <th align="center">Professor</th>
                <th align="center">Office</th>
                <th align="center">Phone</th>
                <th align="center">Email</th>
                <th align="center">Office Hours</th>
              </tr>
				<%             
				List<StaffMember> instructors = sortedStaff.get("instructor");
				              
				for (int i = 0; i < instructors.size(); i++) {
					StaffMember instructor = instructors.get(i);
					List<TimePeriod> oh = instructor.getOH();
				%>
              <tr>
                <td class="staff" name="<%= instructor.getID() %>"> 
                	<img width="100" height="100" src="<%= instructor.getImage() %>" />
                </td>
                <td name="<%= instructor.getID() %>">
                	<font class="staff" name="<%= instructor.getID() %>" size="-1"><%= instructor.getName().getFirstName() + " " + instructor.getName().getLastName() %></font>
                </td>
                
                <td><font size="-1"><%= instructor.getOffice() %></font></td>
                <td><font size="-1"><%= instructor.getPhone() %></font></td>
                <td><font size="-1"><%= instructor.getEmail() %></font></td>
                <td><font size="-1">
					<%
					for (int j = 0; j < oh.size(); j++) {
						if (j != 0) {
					%>
						<hr />
					<%
						}
					%>
			
                  	<%= oh.get(j).toString() %>

					<%
							}
					%>
                </font></td>
              </tr>
				<% 
					} 
				%>
            </table>
            <br />
          <p><hr size="4" /></p>
          <b><font size="+1">Lecture Schedule</font></b>
          <table class="content" border="2" cellpadding="5" width="600">
            <tr class="header">
              <th align="center">Sect. No.</th><th align="center">Day &amp; Time</th><th align="center">Room</th><th>Lecture Assistant</th>
            </tr>
            <%
            List<Meeting> lec_meetings = sortedMeetings.get("lecture");
            for (int i = 0; i < lec_meetings.size(); i++) { 
            	Meeting meeting = lec_meetings.get(i);
            	List<TimePeriod> meeting_times = meeting.getMeetingPeriods();
            	List<StaffMemberID> assistants = meeting.getAssistants();
            %>
            <tr>
              <td align="center"><font size="-1"><%= meeting.getSection() %></font></td>
              <td align="center"><font size="-1">
            	<%
              	for (int j = 0; j < meeting_times.size(); j++) {
              		
              		if (j != 0) {
    			%>
    					<br />
    			<%
    				}
    			%>
				<%= meeting_times.get(j).toString() %>  
				<%
              	}
				%>            		              	             
             
              </font></td>
              <td align="center"><font size="-1"><%= meeting.getRoom() %></font></td>
              <td align="center"><font size="-1">
              
              
              	<table border="0">
              	<%
              	for (int j = 0; j < assistants.size(); j++) {
              		StaffMember assistant = staffMap.get( assistants.get(j).getID() );
              		
              	%>
              	<!-- TEST -->
              	
              	  <td class="staff" name="<%= assistant.getID() %>">
              		
              		<font size="-1"><img src="<%= assistant.getImage() %>"><br />
              		<a href="mailto:<%= assistant.getEmail() %>"><%= assistant.getName().getFirstName() + " " + assistant.getName().getLastName() %></a></font>
              	
              	  </td>
              	<%
              	}
              	%>
              	</table>
              	
              </td>
            </tr>
            <%
            }
            %>
            
          </table>
          <p><hr size="4" /></p>
          <b><font size="+1">Lab Schedule</font></b>
          <table class="content" border="2" cellpadding="5" width="600">
            <tr class="header">
              <th align="center">Sect. No.</th><th align="center">Day &amp; Time</th><th align="center">Room</th><th align="center">Lab Assistants</th>
            </tr>
            <%
            List<Meeting> lab_meetings = sortedMeetings.get("lab");
            for (int i = 0; i < lab_meetings.size(); i++) { 
            	Meeting meeting = lab_meetings.get(i);
            	List<TimePeriod> meeting_times = meeting.getMeetingPeriods();
            	List<StaffMemberID> assistants = meeting.getAssistants();
            %>
            <tr>
              <td align="center"><font size="-1"><%= meeting.getSection() %></font></td>
              <td align="center"><font size="-1">
              	
            	<%
              	for (int j = 0; j < meeting_times.size(); j++) {
              		
              		if (j != 0) {
    			%>
    					<br />
    			<%
    				}
    			%>
				<%= meeting_times.get(j).getDay() %> <br /> <%= meeting_times.get(j).getTime() %>  
				<%
              	}
				%>            		              	             
             
              </font></td>
              <td align="center"><font size="-1"><%= meeting.getRoom() %></font></td>
              <td align="center"><font size="-1">
              	
              	
              	<table border="0">
                	<tr>
                    
                  
              
              	<%
              	for (int j = 0; j < assistants.size(); j++) {
              		StaffMember assistant = staffMap.get( assistants.get(j).getID() );
              		
              	%>
              		
              			<td align="center" class="staff" name="<%= assistant.getID() %>">
              			 
              			  <img src=<%= assistant.getImage() %>><br />
              			  <a href="<%= assistant.getEmail() %>"><%= assistant.getName().getFirstName() + " " + assistant.getName().getLastName() %></a></font>
              			  
              			</td>
              		
              	<%
              	}
              	%>
              	
              		</tr>
              	</table>
              </td>
            </tr>
            <%
            }
            %>
            
          </table>
          <br /><hr size="4" /><br />
          <b><font size="+1">Office Hours</font></b> - All staff office hours are held in the SAL Open Lab.  Instructor office hours are listed above.<br />
            <table class="content" border="1">
              <tr class="header">
                <th></th>
                <th>10:00a.m.-12:00p.m.</th>
                <th>12:00p.m.-2:00p.m.</th>
                <th>2:00p.m.-4:00p.m.</th>
                <th>4:00p.m.-6:00p.m.</th>
                <th>6:00p.m.-8:00p.m.</th>
              </tr>
              
              
              
              <%
              for (int i = 0; i < 6; i++) {
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
            	Map<String, StaffMember> staffByTime = staffByDay.get(day);
              %>
              
              
              <tr>
              	<th class="header"><%= day %></th>
              	
              	
              	<%
              	for (int j = 0; j < 5; j++) {
              		String timeslot = "";
              		if (j == 0) {
              			timeslot = "10:00a.m. - 12:00p.m.";
              		} else if (j == 1) {
              			timeslot = "12:00p.m. - 2:00p.m.";
              		} else if (j == 2) {
              			timeslot = "2:00p.m. - 4:00p.m.";
              		} else if (j == 3) {
              			timeslot = "4:00p.m. - 6:00p.m.";
              		} else if (j == 4) {
              			timeslot = "6:00p.m. - 8:00p.m.";
              		}
              		
              		StaffMember this_staff = staffByTime.get(timeslot);
              	%>
              	
              	
              	<% if (this_staff == null) { %>
              		
              		<td><table border="0"><tr><td></td></tr><tr><td><font size="-1"><br />&nbsp;</font></td></tr></table></td>
                	
              	
              	<% } else { %>
              		
              		
              			<td class="staff" name="<%= this_staff.getID() %>">
              			  <table border="0">
              			  	<tr>
              			  	  <td>
              			  		
              					<img src="<%= this_staff.getImage() %>" />
              			  
              				  </td>
              				</tr>
              				<tr>
              				  <td>
              			  		
              					<font size="-1"><a href="mailto:<%= this_staff.getEmail() %>"><%= this_staff.getName().getFirstName() + " " + this_staff.getName().getLastName() %></a><br />&nbsp;</font>
              			  
              				  </td>
              				</tr>
              			  </table>
              			</td>
                	                	
              	<%
              		}
              	}
              	%>
              
              
              </tr>
              
              <%
              }
              %>
			</table> 
			
			<br /><hr size="4"><br />
            <b><font size="+1">Teaching Staff</font></b><br />
            <table class="content" border="1">
              <tr class="header">
                <th align="center">Picture</th>
                <th align="center">Name</th>
                <th align="center">Email</th>
              </tr>
            <%
            List<StaffMember> tas = sortedStaff.get("ta");
            
            for (int i = 0; i < tas.size(); i++) {
            	
            	StaffMember ta = tas.get(i);
            %>
            	<tr class="staff" name="<%= ta.getID() %>">
            	
            		<td class="staff" name="<%= ta.getID() %>"><img src="<%= ta.getImage() %>" /></td>
            		<td><font size="-1"><%= ta.getName().getFirstName() + " " + ta.getName().getLastName() %></font></td>
            	  
            		<td><font size="-1"><a href="mailto:<%= ta.getEmail() %>"><%= ta.getEmail() %></a></font></td>
            	</tr>
            <%
            }
            %>
           
            </table>
          </font></p>
          <br /><br />
			
                           
        </td>
        
        <td class="menu" width="10">
        
        </td>
      </tr>
    </table>
  </body>
</html>

