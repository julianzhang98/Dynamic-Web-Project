package servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import parsing.Parser;
/**
 * Servlet implementation class Servlet
 */
@WebServlet("/Servlet")
@MultipartConfig
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		// get the input file and put it into a buffered reader
		Part inputFile = request.getPart("myfile");
		String style = request.getParameter("style");
		InputStream is = inputFile.getInputStream();
		InputStreamReader isr = new InputStreamReader(is);
		BufferedReader br = new BufferedReader(isr);
		
		// parse the file with Parser.java after instantiating a Parser object
		Parser p = new Parser(br);
		
		// Instantiate an HttpSession, set timeout period to 1 minute and put in the datacontainer
		HttpSession session = request.getSession(true);
		session.setMaxInactiveInterval(500);
		session.setAttribute("data", p.getData());
		session.setAttribute("style", style);
		
		// redirect to page home.jsp - home page for course website
		response.sendRedirect("home.jsp");
	}

}
