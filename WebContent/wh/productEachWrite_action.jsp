<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="dao" class="wh.ProductEachDAO"/>

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
else if(mode.equals("U")) 
{
	modeStr = "����";
}
else //D 
{
	modeStr = "����";
}
out.println(mode);

//session 
String userId = (String)session.getAttribute("userId");


ProductEach productEach;

if(mode.equals("C") || mode.equals("U")) 
{
	int productNo;
	
	if(mode.equals("C"))
		productNo = 1; //dao.getNextClientNo();
	else
		productNo = Integer.parseInt(request.getParameter("productNo"));

	String serialNo = request.getParameter("serialNo").toString();
	String prodDt = request.getParameter("prodDt").toString();
	String certDt = request.getParameter("certDt").toString();
	String registerNo = request.getParameter("registerNo").toString();
	int clientNo = Integer.parseInt(request.getParameter("clientNo"));

	
	productEach = new ProductEach(productNo, serialNo, prodDt, certDt, registerNo, clientNo, userId, null, userId, null);
	
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
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String serialNo = request.getParameter("serialNo").toString();
	
	dao.deleteProductEach(productNo, serialNo); 
}

%>
<script>
	alert("<%= modeStr %>�Ǿ����ϴ�.");
	document.location.href="productEachList.jsp";
</script>