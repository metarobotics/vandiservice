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
			alert("�н����尡 ����Ǿ����ϴ�.");
			window.close(); // �н����� ���� â�� �ݰ� �ٽ� �α���
		</script>

<% 

	}
	else
	{
		
	%>	
		<script>
			alert("���� �н����尡 ���� �ʽ��ϴ�.");
			window.history.back();
		</script>
	
	<% } %>
	 
</body>
</html>
