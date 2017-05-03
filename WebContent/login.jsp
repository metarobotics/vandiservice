<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>        
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");
%>

<jsp:useBean id="dao" class="wh.UserDAO"/>

<%	
	User user = dao.getUserInfo(id, pwd);
	if(user != null)
	{
		session.setAttribute("userId",id);
 		out.print("Welcome " + id + " !!  ^^");
%>
<META http-equiv="refresh" content="1; url=./wh/itemList.jsp">
<% 
}
else
{
out.print("Login failed. " + id + " !! ");
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
</body>
</html>