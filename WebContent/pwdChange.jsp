<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>        
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>

<%
//request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String oldPwd = request.getParameter("oldPwd");
String newPwd = request.getParameter("newPwd");

%>

<jsp:useBean id="userDao" class="wh.UserDAO"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%	
	User user = userDao.getUserInfo(id, oldPwd);

	if(user != null)
	{
		userDao.modifyUserPwd(user, newPwd);
%>

		<script>
			alert("패스워드가 변경되었습니다.");
			window.close(); // 패스워드 변경 창을 닫고 다시 로그인
		</script>

<% 

	}
	else
	{
		
	%>	
		<script>
			alert("기존 패스워드가 맞지 않습니다.");
			window.history.back();
		</script>
	
	<% } %>
	 
</body>
</html>
