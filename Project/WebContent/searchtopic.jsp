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

List<Week> weeks = data.getSchools().get(0).getDepartments().get(0).getCourses().get(0).getSchedule().getWeeks();		
List<Topic> topics = new ArrayList<>();

for (int i = 0; i < weeks.size(); i++) {
	  Week week = weeks.get(i);
	  List<Lecture> lectures = week.getLectures();
	  for (int j = 0; j < lectures.size(); j++) {
		  List<Topic> lecture_topics = lectures.get(j).getTopics();
		  topics.addAll(lecture_topics);		  
	  }
}



String search = request.getParameter("search");

//System.out.println(search);

PrintWriter pw = response.getWriter();


if (search == null || search.length() == 0) {
	pw.print("");
} else {
	
	
	
	for (int i = 0; i < topics.size(); i++) {
		Topic topic = topics.get(i);
	
		String title = topic.getTitle().toLowerCase();
	
		if (title.contains(search.toLowerCase())) {
			
			pw.print(title + ",");

			
		}
	}
	
}
pw.flush();


%>




