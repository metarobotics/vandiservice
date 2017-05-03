<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
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
<title>자재 상세</title>
<link rel="stylesheet" href="../css/mr.css">
</head>
<body translate="no" >
<div class="table-title">
<h3>자재 정보</h3>
</div>

<table class="table-fill" border="1">
	<tr>
		<td width="50%" class="cell-hd">품목번호</td>
		<td width="50%" class="cell-c"><%=item.getItemNo()%></td>
	</tr>
	<tr>
		<td class="cell-hd">품목명</td>
		<td class="cell-c"><%=item.getItemNm()%></td>
	</tr>
	<tr>
		<td class="cell-hd">등록자</td>
		<td class="cell-c"><%=item.getInsertUserNo()%></td>
	</tr>
	<tr>
		<td class="cell-hd">등록일시</td>
		<td class="cell-c"><%=item.getInsertDatetime()%></td>
	</tr>
</table>
<br>
<table class="table-fill" width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr>
	<td align="center"><a href="itemList.jsp?pg=<%=pg %>">목록</a>
	</td>
	</tr>
</table>

</body>
</html>