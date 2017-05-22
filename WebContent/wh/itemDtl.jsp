<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="dao" class="wh.ItemDAO"/>

<%
request.setCharacterEncoding("UTF-8");

String mode = request.getParameter("mode");
String pg = request.getParameter("pg");

	Item item = null;

	int itemNo = 0;
	String itemId = "";
	String itemNm = ""; 
	String itemNmKor = "";

	if(mode.equals("R"))
	{
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		
		item = dao.getItemInfo(idx);
	
		if(item != null)
		{
			itemNo = item.getItemNo();
			itemId = item.getItemId();
			itemNm = item.getItemNm();
			itemNmKor = item.getItemNmKor();
		}
	}
	
%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="../css/mr.css">
<script type="text/javascript" src="../js/mr.js"></script>
</head>
<body translate="no" >

	<% if(mode.equals("R")) { %>   
   		<div class="table-title"><h1>Item 상세</h1></div>
	<% } else { %>
   		<div class="table-title"><h1>Item 등록</h1></div>
	<% } %>   		
	
	<table class="table-fill" border="1">
		<tr>
			<td width="30%" class="cell-hd">품목번호</td>
			<td width="70%" class="cell-l"><%=itemNo%></td>
		</tr>
		<tr>
			<td class="cell-hd">품목ID</td>
			<td class="cell-l"><%=itemId%></td>
		</tr>
		<tr>
			<td class="cell-hd">품목명</td>
			<td class="cell-l"><%=itemNm%></td>
		</tr>
		<tr>
			<td class="cell-hd">품목 한글명</td>
			<td class="cell-l"><%=itemNmKor%></td>
		</tr>
	</table>
<br>
<table class="table-fill" width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr>
	<td align="center">
         		<input type="button" class="myButton" value="목록" onclick="moveTo('itemList.jsp?pg=<%=pg %>');">
	
	</td>
	</tr>
</table>

</body>
</html>