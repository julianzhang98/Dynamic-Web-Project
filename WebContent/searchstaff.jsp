<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@ page import="objects.*" %>
<%@ page import="parsing.*" %>
<%@ page import="java.util.*" %>

<%@ page import="java.io.*" %>

<%
//check for timeout and if not, load all the data needed
session = request.getSession(false);

DataContainer data = (DataContainer) session.getAttribute("data");

if(data == null) {
    response.sendRedirect("/Assignment3/index.jsp");
    return;
}

Course course = data.getSchools().get(0).getDepartments().get(0).getCourses().get(0);		
List<StaffMember> staffMembers = course.getStaffMembers();

String search = request.getParameter("search");

//System.out.println(search);

PrintWriter pw = response.getWriter();


if (search == null || search.length() == 0) {
	pw.print("");
} else {

	for (int i = 0; i < staffMembers.size(); i++) {
		StaffMember staff = staffMembers.get(i);
	
		String fname = staff.getName().getFirstName();
		String lname = staff.getName().getLastName();
	
		if (search.equalsIgnoreCase(fname) || search.equalsIgnoreCase(lname) || search.equalsIgnoreCase(fname + " " + lname)) {

			
			pw.print(staff.getID().toString()+",");

			
		}
	}
	
}
pw.flush();


%>