<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import="java.sql.*" %> <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="vendorDao" class="wh.VendorDAO"/>

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

Vendor vendor = null;

if(mode.equals("C") || mode.equals("U")) 
{
	int vendorNo = 0;
	if(mode.equals("C")) 
	{
		vendorNo = vendorDao.getNextVendorNo();
	}
	else //U
	{
		vendorNo = Integer.parseInt(request.getParameter("vendorNo"));
	}
	
	String vendorNm = request.getParameter("vendorNm").toString();
	String phoneNo = request.getParameter("phoneNo").toString();
	String mobileNo = request.getParameter("mobileNo").toString();
	String faxNo = request.getParameter("faxNo").toString();
	String chargeEmpNm = request.getParameter("chargeEmpNm").toString();
	String email = request.getParameter("email").toString();
	String countryCd = request.getParameter("countryCd").toString();
	String addr = request.getParameter("addr").toString();
	//String note = request.getParameter("note").toString();
	
	vendor = new Vendor(vendorNo, vendorNm, phoneNo, mobileNo, faxNo, chargeEmpNm, email, countryCd, addr, null, userId, userId);
	
	if(mode.equals("C"))
	{
		vendorDao.insertVendor(vendor); 
	} 
	else
	{
		vendorDao.modifyVendor(vendor); 
	}
}
else //D
{
	int vendorNo = Integer.parseInt(request.getParameter("vendorNo"));
	
	vendorDao.deleteVendor(vendorNo); 
}
%>
<script>
	alert("<%= modeStr %>되었습니다.");
	document.location.href="vendorList.jsp";
</script>