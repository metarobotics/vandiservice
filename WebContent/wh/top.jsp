<%
String session_id=null;
session_id = (String)session.getAttribute("session_id");

String userId =  (String)session.getAttribute("userId");
String userName =  (String)session.getAttribute("userName");
String centerName =  (String)session.getAttribute("centerName");


%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Vandi service</title>
	<link rel="stylesheet" href="../css/vandiservice.css">
</head>
<body>
<center>
	
	<div><h4>Smart robots for agriculture</h4></div>
   	<div class="table-title"><h1>VANDI SERVICE</h1></div>
   	
   	<table border="0">
   	<tr class="row_bottom_only">
   		<td class="cell-l">
   		
   		<ul>
		  <li><a href="toList.jsp">자재구매요청</a></li>
		  <li><a href="soList.jsp">견적서</a></li>
		  <li><a href="productEachList.jsp">제품관리</a></li>
		  <li><a href="clientList.jsp">고객관리</a></li>
		</ul>
   		
   		</td>
   		
   		<td class="cell-r">
				<% if(userName != null) { %> 
				
					[<%=centerName%>]&nbsp<%= userName %>&nbsp&nbsp&nbsp&nbsp<a target="center" href="../logout.jsp">로그아웃</a>
				
				<% } %>
		</td>
   	</tr>
   	<tr class="row_bottom_only"></tr>
   	</table>

   <p>
  </p>
</center>
</body>
</html>