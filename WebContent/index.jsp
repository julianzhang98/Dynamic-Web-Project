<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>CSCI 201L Assignment 2</title>
		
		<script>
		
			function validate() {
				
				var valid = true;
				document.getElementById("file_error").innerHTML = "";
				
				if(document.getElementById("myfile").value == ""){
					document.getElementById("file_error").innerHTML = "<strong><font color=\"red\">Please select a file.</font></strong>";
					valid = false;
			    }
				return valid;
			}
		
		</script>
	</head>
	<body>
		<h1>Please choose a JSON file</h1>
		<form name="fileform" method="post" action="Servlet" enctype="multipart/form-data" onsubmit="return validate()">
			<input name="myfile" id="myfile" type="file" accept=".json"><br>
			<input type="submit" name="submit" value="Submit"><br>
			<input type="radio" name="style" value="style1" checked="checked"> Design 1<br>
			<input type="radio" name="style" value="style2"> Design 2<br>
			<span id="file_error"></span>
		</form>
	</body>
</html>