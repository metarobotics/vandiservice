<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="orderTDao" class="wh.OrderTDAO"/>

<%
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));

	orderTDao.deleteOrderT(orderNo);
	orderTDao.deleteOrderItem(orderNo);
	
%>
<script>
	alert("�����Ǿ����ϴ�.");
	document.location.href="toList.jsp";
</script>