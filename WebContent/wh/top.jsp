<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String session_id=null;
session_id = (String)session.getAttribute("session_id");

String userId =  (String)session.getAttribute("userId");

%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Vandi service</title>
	<link rel="stylesheet" href="css/vandiservice.css">
</head>
<body>
<center>
	<table border="0">
		<tr style="border-bottom: 1px solid #AAAAAA" height="20">
			<td class="cell-l"># <a href="toList.jsp" target="main">Transfer Order</a></td>
			<td class="cell-l"># <a href="soList.jsp" target="main">Sales Order</a></td>
			<td class="cell-l"># <a href="clientList.jsp" target="main">Client</a></td>
			
			<td class="cell-r" valign="bottom" align="right">
			
				<% if(userId != null) { %> 
				
					<%= userId %>~ :)<a target="center" href="../logout.jsp">logout</a>
				
				<% } %>
			</td>
		</tr>
	</table>
   <p>
  </p>
</center>
</body>
</html>