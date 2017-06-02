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
<jsp:useBean id="mRdao" class="wh.MrDAO"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
</head>
<body>

<%	
	User user = dao.getUserInfo(id, pwd);

	if(user != null)
	{
		session.setAttribute("userId",id);
		session.setAttribute("userNo",user.getUserNo());
		session.setAttribute("userName",user.getUserNm());
		session.setAttribute("centerName","Not defined");
		
		ArrayList<Wh> wareHouses = mRdao.getWhList();
		for(int i = 0; i < wareHouses.size(); i++)
		{
			Wh wh = wareHouses.get(i);
			if(user.getUserWhNo() == wh.getWhNo())
			{
				System.out.print("[D] WhName:" + wh.getWhNm() + " WhNo:" + user.getUserWhNo());
				session.setAttribute("centerName",wh.getWhNm());
				break;
			}
		}
		
		session.setMaxInactiveInterval(60 * 60);

 		out.print("Welcome " + id + " !!  ^^");
%>

<!--  <META http-equiv="refresh" content="1; url=./wh/itemList.jsp"> -->

<script>
	//alert("hi");
	//alert(window.frames["center"].location);
	//alert(parent.document.getElementById("center").src);// works. loginForm.jsp
	//alert(document.getElementById("center").src);//error
	//window.frames["center"].location.href = "./wh/itemList.jsp";// error
	//parent.top.location.reload();
	//parent.top.location.refresh();
	//parent.document.getElementById("center").src = "./wh/itemList.jsp";
	parent.document.location.href="index2.jsp";
</script>

<% 

}
else
{
	
%>	
	Login failed !! 
	<br>
	<br>
	<a href="loginForm.jsp">Go back to Login Page</a>

<% } %>
 
</body>
</html>
