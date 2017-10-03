<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="dao" class="wh.ProductEachDAO"/>

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
out.println(mode);

//session 
String userId = (String)session.getAttribute("userId");


ProductEach productEach;

if(mode.equals("C") || mode.equals("U")) 
{
	int productEachNo = 0;
	if(mode.equals("C")) 
	{
		productEachNo = dao.getNextProductEachNo();
	}
	else //U
	{
		productEachNo = Integer.parseInt(request.getParameter("productEachNo"));
	}

	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String serialNo = request.getParameter("serialNo").toString();
	String prodDt = request.getParameter("prodDt").toString();
	String certDt = request.getParameter("certDt").toString();
	String registerNo = request.getParameter("registerNo").toString();
	int clientNo = Integer.parseInt(request.getParameter("clientNo"));
	
	productEach = new ProductEach(productEachNo, productNo, serialNo, prodDt, certDt, registerNo, clientNo, userId, null, userId, null);
	
	if(mode.equals("C"))
	{
		dao.insertProductEach(productEach); 
	} 
	else if(mode.equals("U")) 
	{
		//out.println(productEach.getProductNo());
		//out.println(productEach.getSerialNo());
			
		dao.modifyProductEach(productEach); 
	}
}
else //D
{
	int productEachNo = Integer.parseInt(request.getParameter("productEachNo"));
	
	dao.deleteProductEach(productEachNo); 
}

%>
<script>
	alert("<%= modeStr %>되었습니다.");
	document.location.href="productEachList.jsp";
</script>