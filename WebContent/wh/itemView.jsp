<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");
int idx = Integer.parseInt(request.getParameter("idx"));
String pg = request.getParameter("pg");
%>

<jsp:useBean id="dao" class="wh.ItemDAO"/>

<%	
	Item item = dao.getItemInfo(idx);
%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>���� ��</title>
<link rel="stylesheet" href="../css/mr.css">
</head>
<body translate="no" >
<div class="table-title">
<h3>���� ����</h3>
</div>

<table class="table-fill" border="1">
	<tr>
		<td width="50%" class="cell-hd">ǰ���ȣ</td>
		<td width="50%" class="cell-c"><%=item.getItemNo()%></td>
	</tr>
	<tr>
		<td class="cell-hd">ǰ���</td>
		<td class="cell-c"><%=item.getItemNm()%></td>
	</tr>
	<tr>
		<td class="cell-hd">�����</td>
		<td class="cell-c"><%=item.getInsertUserNo()%></td>
	</tr>
	<tr>
		<td class="cell-hd">����Ͻ�</td>
		<td class="cell-c"><%=item.getInsertDatetime()%></td>
	</tr>
</table>
<br>
<table class="table-fill" width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr>
	<td align="center"><a href="itemList.jsp?pg=<%=pg %>">���</a>
	</td>
	</tr>
</table>

</body>
</html>