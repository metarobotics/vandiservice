<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<jsp:include page = "/loginChk.jsp"/>

<%
String session_id = (String)session.getAttribute("session_id");
String userId =  (String)session.getAttribute("userId");
if(userId == null)
	return;
String userNm =  (String)session.getAttribute("userNm");
String authLvl =  (String)session.getAttribute("authLvl");
int whNo =  (Integer)session.getAttribute("whNo");
String whId =  (String)session.getAttribute("whId");
String whNm =  (String)session.getAttribute("whNm");

%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Vandi Service</title>
	<link rel="stylesheet" href="../css/vandiservice.css">
</head>
<body>
<center>
	
	<div><h4>Smart robots for agriculture</h4></div>
   	<div class="vandi_title_style">VANDI SERVICE</div>
   	<div class="vandi_servicecenter_style"><%=whNm%></div>
   	
   	<table border="0">
   	<tr class="row_bottom_only">
   		<td class="cell-l">
	   		<ul>
	   		
<% if(!whId.equals("mr") && !authLvl.equals("A")) { // center %>
			  <li><a href="toList.jsp">자재구매요청</a></li>
			  <li><a href="soList.jsp">견적서</a></li>
			  <li><a href="productList.jsp">출고관리</a></li> 
			  <li><a href="clientList.jsp">고객관리</a></li>
<% } %>			  

<% if(whId.equals("mr")) { %>
			  <li><a href="toList.jsp">자재구매요청</a></li>
			  <li><a href="soList.jsp">견적서</a></li>
			  <li><a href="itemList.jsp">자재정보</a></li>
			  <li><a href="poList.jsp">자재구매</a></li>
			  <li><a href="productList.jsp">출고관리</a></li> 
			  <li><a href="clientList.jsp">고객관리</a></li>
			  <li><a href="vendorList.jsp">벤더관리</a></li>
			  <li><a href="stockHist.jsp">입출고이력</a></li> 
<% } %>			  
<% //if(authLvl.equals("S")) 
	if(userId.equals("bona"))
{ %>
			  <li><a href="companyDtl.jsp?mode=R">회사정보</a></li> 
<% } %>			  
			</ul>
   		</td>
   		
   		<td class="cell-r">
				<% if(userNm != null) { %> 
				
					<%= userNm %>&nbsp님&nbsp&nbsp&nbsp&nbsp<a target="center" href="../logout.jsp">로그아웃</a>
					<!-- <br><% out.print(userId + "/" + userNm + "/" + authLvl + "/" + whNm); %> -->
					
				<% } %>
		</td>
   	</tr>
   	</table>

	<table border="0" width="100%">
		<tr class="row_bottom_only"><td></td></tr>
   		<tr class="row_bottom_only"><td></td></tr>
   	</table>

   <p>
  </p>
</center>
</body>
</html>