<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String session_id=null;
session_id = (String)session.getAttribute("session_id");
String userId =  (String)session.getAttribute("userId");
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
	<link rel="stylesheet" href="css/mr.css">
</head>
<body>

<%
session.invalidate();
%>

	<script>
		alert("Bye " + "<%= userId %>" +" !");
		parent.document.location.href="index.jsp";
	</script>
	


<!-- 
	<table border="0" width="100%" height="100">
		<tr>
			<td align="center" valign="middle">
  				Bye <%= userId %>!
				<br><br>
				<a href="login.jsp">Go back to Login Page</a>
			</td>
		</tr>
	</table>

 -->
	
</body>
</html>