<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="clientDao" class="wh.ClientDAO"/>

<%
	int clientNo = Integer.parseInt(request.getParameter("clientNo"));

	clientDao.deleteClient(clientNo);
	
%>
<script>
	alert("�����Ǿ����ϴ�.");
	document.location.href="clientList.jsp";
</script>