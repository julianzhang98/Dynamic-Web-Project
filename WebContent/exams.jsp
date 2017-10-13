<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
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

List<Exam> exams = course.getExams();


// change school and department url???
		
%>

<html>
  <head>
    <title><%= school.getName() + ": " + department.getPrefix() + " " + course.getNumber() + " " + course.getTerm() + " " + course.getYear() %></title>
  	<link rel="stylesheet" type="text/css" href="<%= style %>.css">
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
          <font size="+1"><a class="menu" href="assignments.jsp">Assignments</a></font><br /><br />
          <font size="+1">Previous Exams</font><br /><br />
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

          <table border="2" cellpadding="5" width="590">
            <tr>
              <th align="center">Semester</th><th align="center">Written Exam #1</th><th align="center">Programming Exam #1</th><th>Written Exam #2</th><th>Programming Exam #2</th>
            </tr>
            
            
            <%    
            for (int i = 0; i < exams.size(); i++) {
            	Exam exam = exams.get(i);
            	List<Test> tests = exam.getTests();
            	
            %>
            
            <tr>
              <td align="center"><%= exam.getSemester() + " " + exam.getYear() %></td>
              
            	<%              	
              	for (int j = 0; j < 4; j++) {
                    String exam_name = "";
                    if (j == 0) {
                  		exam_name = "Written Exam #1";
                    } else if (j == 1) {
                  		exam_name = "Programming Exam #1";
                    } else if (j == 2) {
                  		exam_name = "Written Exam #2";
              	  	} else if (j == 3) {
                  		exam_name = "Programming Exam #2";
                    }           
                    
                    int test_index = -1;
                    for (int k = 0; k < tests.size(); k++) {
                    	Test test = tests.get(k);
                    	
                    	
                    	if (test.getTitle().equals(exam_name)) {
                    		test_index = k;
                    		break;
                    	}
                    }
                    
                    if (test_index == -1) {
                %>
                		<td></td>
                <%
                    } else {
                    	Test test = tests.get(test_index);
              			List<File> test_files = test.getFiles();
              	%>
              			<td align="center">
	              		<%
	              		for (int k = 0; k < test_files.size(); k++) {
	              			File test_file_k = test_files.get(k);
	              			if (k != 0) {
	            		%>
	            				<hr />
	            		<%
	              			}
	            		%>
	            			<a href="<%= test_file_k.getUrl() %>"><%= test_file_k.getTitle() %> </a>
	            		<%
	            		}
	            		%>
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
        </td>
        <td class="menu" width="10">
        
        </td>
      </tr>
    </table>
  </body>
</html>
