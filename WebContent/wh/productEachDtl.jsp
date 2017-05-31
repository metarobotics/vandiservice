<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>

<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
 
<jsp:useBean id="productEachDao" class="wh.ProductEachDAO"/>
<jsp:useBean id="clientDao" class="wh.ClientDAO"/>
<jsp:include page = "/loginChk.jsp"/>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/vandiservice.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="../js/chkValid.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>


<%

	String mode = request.getParameter("mode"); // C/R
	String pg = request.getParameter("pg");
	
	String writeMode;
	if(mode.equals("C"))
		writeMode = "C";
	else // R
		writeMode = "U";
	
	int orderNo = 0;

	//out.print("."+mode+".");
	
	ProductEach productEach = null;
	int productNo = 0;
	int clientNo = 0;
	
	if(mode.equals("R"))
	{
		productNo = Integer.parseInt(request.getParameter("productNo"));
		String serialNo = request.getParameter("serialNo").toString();
	
		productEach = productEachDao.getProductEachInfo(productNo, serialNo);
		clientNo = productEach.getClientNo();
	}
	else
	{
		productNo = 1;
	}
	
	ArrayList<Client> clientList = clientDao.getClientList();
	int clientLength = clientList.size();
	
%>

<script type="text/javascript">

	var mode = '<%= mode %>';
	//alert(mode);

	function chkValid() {
		/*		
		//alert(document.getElementById("clientId").value);
		
		if(isNull(document.getElementById("productEachNm")))
		{
			alert('고객명을 입력하세요.');
			return false;
		}
		*/		
		return true;
	}

	function confirmDelete() {
		
		if(confirm('삭제하시겠습니까?'))
		{
			<% if(mode.equals("R")) { %>   
				moveTo('productEachWrite_action.jsp?mode=D&productNo=<%= productEach.getProductNo() %>&serialNo=<%= productEach.getSerialNo() %>');	
			<% } else { %>
			<% } %>   		
		}
	}
	
	function setPage()
	{
		if(mode == "R")
		{
			document.getElementById("clientNo").value = '<%= clientNo %>';
			//document.getElementById("clientNo").disabled = true;
		}
	}//setPage
	
</script>
</head>

<body>
<center>

	<% if(mode.equals("R")) { %>   
   		<div class="table-title"><h1>Product information</h1></div>
	<% } else { %>
   		<div class="table-title"><h1>Product registration</h1></div>
	<% } %>   		
   	

		<form name="form1" method="post" action="productEachWrite_action.jsp?mode=<%= writeMode %>" onsubmit="return chkValid();">



		<table width = "300">
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r" style="margin-left: 2px">제품명</td>
				<td width="60%" class="cell-l">VANDI-A1
	<% if(mode.equals("C")) { %>   
					<input type=hidden name=productNo id=productNo value='<%= productNo %>' >
	<% } else { %>
					<input type=hidden name=productNo id=productNo value='<%= productEach.getProductNo() %>' >
	<% } %>   		
				</td>
			</tr>
			
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">일련번호</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=serialNo id=serialNo size=15 value='' >
	<% } else { %>
					<input type=text name=serialNo id=serialNo size=15 readonly value='<%= productEach.getSerialNo() %>' >
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
				<td width="40%" class="cell-r">인증검사일</td>
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
     			<td class="cell-r">Client</td>
     			<td class="cell-l">
     				<select id=clientNo name=clientNo>
	     				<option value=''>선택</option>
		   				<%
					 		for(int i=0; i<clientLength;i++){
								Client client = clientList.get(i);
		     			%>
		      			    <option value=<%= client.getClientNo() %>><%= client.getClientNm() %></option>
		     			<%
		     				}
		     			%>
     				</select>
     			</td>
     		</tr>
			<tr height="30"/>
		</table>
		<table>
    		<tr height="40" valign="bottom">
     			<td colspan="2">
     				<div align="center">
     				<% if(mode.equals("C")) { %>
     					<input type="submit" class="dtlBtn" value="등록">&nbsp;
     				<% }else{ %>
     					<input type="submit" class="dtlBtn" value="수정">&nbsp;
     					<input type="button" class="dtlBtn" value="삭제" onclick="confirmDelete();">&nbsp;
     				<% } %>
         				<input type="button" class="dtlBtn" value="목록" onclick="moveTo('productEachList.jsp?pg=<%=pg %>');">
         			</div>
     			</td>
    		</tr>
		</table>    		 
	</form> 
</center>
<script>
	setPage();
</script>
</body>
</html>