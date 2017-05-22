<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="orderSDao" class="wh.OrderSDAO"/>

<%
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));

	orderSDao.deleteOrderS(orderNo);
	orderSDao.deleteOrderItem(orderNo);
	
%>
<script>
	alert("삭제되었습니다.");
	document.location.href="soList.jsp";
</script>