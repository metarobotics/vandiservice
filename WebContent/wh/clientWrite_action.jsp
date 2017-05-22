<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="clientDao" class="wh.ClientDAO"/>

<%
// request 
request.setCharacterEncoding("EUC-KR");
response.setContentType("text/html;charset=EUC-KR");

//parameter
String mode = request.getParameter("mode");
String modeStr;
if(mode.equals("C")) 
{
	modeStr = "���";
}
else //U
{
	modeStr = "����";
}

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
String note = request.getParameter("note").toString();

// session 
String userId = (String)session.getAttribute("userId");

Client client = new Client(clientNo, clientNm, phoneNo, mobileNo, email, location, addr, note, userId, userId);

if(mode.equals("C"))
{
	clientDao.insertClient(client); 
} 
else
{
	clientDao.modifyClient(client); 
}

%>
<script>
	alert("<%= modeStr %>�Ǿ����ϴ�.");
	document.location.href="clientList.jsp";
</script>