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
	<title>Insert title here</title>
	<link rel="stylesheet" href="css/vandiservice.css">
</head>
<body>
	<table border="0" width="100%">
		<tr>
			<td class="td_railway_h0">Vandi Service</td>
			<td># <a href="toList.jsp" target="main">Transfer Order</a></td>
			<td># <a href="soList.jsp" target="main">Sales Order</a></td>
			<td># <a href="clientList.jsp" target="main">Client</a></td>
			
			<td class="td_railway_13" valign="bottom" align="right">
			
				<% if(userId != null) { %> 
				
					Welcome <%= userId %>~ :) 
					<br>
					<a target="center" href="../logout.jsp">logout</a>
				
				<% } %>

			</td>
		</tr>
	</table>
   <p>
  </p>
</body>
</html>