<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import="java.sql.*" %> <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="clientDao" class="wh.ClientDAO"/>

<%
response.setContentType("text/html;charset=EUC-KR");

//parameter
String mode = request.getParameter("mode");
String modeStr;
if(mode.equals("C")) 
{
	modeStr = "등록";
}
else if(mode.equals("U")) 
{
	modeStr = "수정";
}
else //D 
{
	modeStr = "삭제";
}
//out.println(mode);

//session 
String userId = (String)session.getAttribute("userId");

Client client = null;

if(mode.equals("C") || mode.equals("U")) 
{
	int clientNo = 0;
	if(mode.equals("C")) 
	{
		clientNo = clientDao.getNextClientNo();
	}
	else //U
	{
		clientNo = Integer.parseInt(request.getParameter("clientNo"));
	}
	
	String clientNm = request.getParameter("clientNm").toString();
	String phoneNo = request.getParameter("phoneNo").toString();
	String mobileNo = request.getParameter("mobileNo").toString();
	String email = request.getParameter("email").toString();
	String location = request.getParameter("location").toString();
	String addr = request.getParameter("addr").toString();
	//String note = request.getParameter("note").toString();
	
	client = new Client(clientNo, clientNm, phoneNo, mobileNo, email, location, addr, null, userId, userId);
	
	if(mode.equals("C"))
	{
		clientDao.insertClient(client); 
	} 
	else
	{
		clientDao.modifyClient(client); 
	}
}
else //D
{
	int clientNo = Integer.parseInt(request.getParameter("clientNo"));
	
	clientDao.deleteClient(clientNo); 
}
%>
<script>
	alert("<%= modeStr %>되었습니다.");
	document.location.href="clientList.jsp";
</script>