<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="productEachDao" class="wh.ProductEachDAO"/>
<jsp:useBean id="clientDao" class="wh.ClientDAO"/>
<jsp:useBean id="mrDao" class="wh.MrDAO"/>
 
<jsp:include page = "top.jsp"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/vandiservice.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>

<%
	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;
	//if(authLvl.equals("S") || authLvl.equals("A")) // 등록,수정 권한자

	String mode = request.getParameter("mode"); // C/R
	String pg = request.getParameter("pg");
	
	String writeMode;
	if(mode.equals("C"))
		writeMode = "C";
	else // R
		writeMode = "U";
	
	int orderNo = 0;

	//out.print("."+mode+".");

	ArrayList<Product> productList = mrDao.getProductList();
	ArrayList<Client> clientList = clientDao.getClientList();
	int clientLength = clientList.size();
	int productLength = productList.size();
	
	ProductEach productEach = null;
	int productEachNo = 0;
	int productNo = 0;
	int clientNo = 0;
	
	if(mode.equals("R"))
	{
		productEachNo = Integer.parseInt(request.getParameter("productEachNo"));
		
		productEach = productEachDao.getProductEachInfo(productEachNo);
		productNo = productEach.getProductNo();
		clientNo = productEach.getClientNo();
	}
	
%>

<script type="text/javascript">

	var mode = '<%= mode %>';
	//alert(mode);

	function chkValid() {
				
		if(isNull(document.getElementById("productNo")))
		{
			alert('모델명을 선택하세요.');
			return false;
		}
		else if(isNull(document.getElementById("serialNo")))
		{
			alert('제품번호를 입력하세요.');
			return false;
		}
		else if(isNull(document.getElementById("clientNo")))
		{
			alert('고객을 선택하세요.');
			return false;
		}
		
		return true;
	}

	function confirmDelete() {
		
		if(confirm('삭제하시겠습니까?'))
		{
			<% if(mode.equals("R")) { %>   
				moveTo('productEachWrite.jsp?mode=D&productEachNo=<%= productEach.getProductEachNo() %>');	
			<% } else { %>
			<% } %>   		
		}
	}
	
	function setPage()
	{
		if(mode == "R")
		{
			document.getElementById("productNo").value = '<%= productNo %>';
			document.getElementById("clientNo").value = '<%= clientNo %>';
		}
	}//setPage
	
</script>
</head>

<body>
<center>

   		<div class="table-title"><h1>제품정보</h1></div>

		<form name="form1" method="post" action="productEachWrite.jsp?mode=<%= writeMode %>" onsubmit="return chkValid();">



		<table width = "300">
     				
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r" style="margin-left: 2px">모델명</td>
				<td width="60%" class="cell-l">
     				<select id=productNo name=productNo>
	     				<option value=''>선택</option>
		   				<%
					 		for(int i=0; i<productLength; i++){
								Product product = productList.get(i);
		     			%>
		      			    <option value=<%= product.getProductNo() %>><%= product.getProductNmEng() %></option>
		     			<%
		     				}
		     			%>
     				</select>
				</td>
			</tr>
			
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">제품일련번호</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=serialNo id=serialNo size=15 value='' >
	<% } else { %>
					<input type=text name=serialNo id=serialNo size=15 value='<%= productEach.getSerialNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">제작일자</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=date name=prodDt id=prodDt size=15 value='' >
	<% } else { %>
					<input type=date name=prodDt id=prodDt size=15 value='<%= productEach.getProdDt() %>' >
	<% } %>   		
				</td>
			</tr>
			
		
			
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">인증 검사일자</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=date name=certDt id=certDt size=20 value='' >
	<% } else { %>
					<input type=date name=certDt id=certDt size=20 value='<%= productEach.getCertDt() %>' >
	<% } %>   		
				</td>
			</tr>
			
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">항공청 등록번호</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=registerNo id=registerNo size=20 value='' >
	<% } else { %>
					<input type=text name=registerNo id=registerNo size=20 value='<%= productEach.getRegisterNo() %>' >
	<% } %>   		
				</td>
			</tr>
			
    		<tr class="row_bottom_only">
     			<td class="cell-r">고객명</td>
     			<td class="cell-l">
     				<select id=clientNo name=clientNo>
	     				<option value="0">없음</option>
		   				<%
					 		for(int i=0; i<clientLength; i++){
								Client client = clientList.get(i);
		     			%>
		      			    <option value=<%= client.getClientNo() %>><%= client.getClientNm() %></option>
		     			<%
		     				}
		     			%>
     				</select>
     			</td>
     		</tr>
			<tr height="30"/></tr>
		</table>
		<table>
    		<tr height="40" valign="bottom">
     			<td colspan="2">
     				<div align="center">
     				<% if(mode.equals("C")) { %>
     					<input type="submit" class="dtlBtn" value="등록">&nbsp;
     				<% }else if(mode.equals("R") && (authLvl.equals("S") || authLvl.equals("A"))) { %>
     					<input type="submit" class="dtlBtn" value="수정">&nbsp;
     					<!-- <input type="button" class="dtlBtn" value="삭제" onclick="confirmDelete();">&nbsp; -->
     				<% } %>
         				<input type="button" class="dtlBtn" value="목록" onclick="moveTo('productEachList.jsp?pg=<%=pg %>');">
         			</div>
     			</td>
    		</tr>
		</table>
		<input type=hidden name=productEachNo id=productEachNo value='<%= productEachNo %>' >    		 
	</form> 
</center>
<script>
	setPage();
</script>
</body>
</html>

