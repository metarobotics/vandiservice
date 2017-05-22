<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>

<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
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
<link rel="stylesheet" href="../css/mr.css">
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
			alert('������ �Է��ϼ���.');
			return false;
		}
		*/		
		return true;
	}

	function confirmDelete() {
		
		if(confirm('�����Ͻðڽ��ϱ�?'))
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
   		<div class="table-title"><h1>Product ����ǰ ��</h1></div>
	<% } else { %>
   		<div class="table-title"><h1>Product ����ǰ ���</h1></div>
	<% } %>   		
   	

		<form name="form1" method="post" action="productEachWrite_action.jsp?mode=<%= writeMode %>" onsubmit="return chkValid();">



		<table border=1 class='table-fill'>
    		<tr>
				<td width="30%" class="cell-hd">productNo</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text size=10 disabled value='<%= productNo %>' >
					<input type=hidden name=productNo id=productNo value='<%= productNo %>' >
	<% } else { %>
					<input type=text size=10 disabled value='<%= productEach.getProductNo() %>' >
					<input type=hidden name=productNo id=productNo value='<%= productEach.getProductNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">serialNo</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=serialNo id=serialNo size=20 value='' >
	<% } else { %>
					<input type=text name=serialNo id=serialNo size=20 readonly value='<%= productEach.getSerialNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">prodDt</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=date name=prodDt id=prodDt size=20 value='' >
	<% } else { %>
					<input type=date name=prodDt id=prodDt size=20 value='<%= productEach.getProdDt() %>' >
	<% } %>   		
				</td>
			</tr>
			
		
			
    		<tr>
				<td width="30%" class="cell-hd">certDt</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=date name=certDt id=certDt size=20 value='' >
	<% } else { %>
					<input type=date name=certDt id=certDt size=20 value='<%= productEach.getCertDt() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">registerNo</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=registerNo id=registerNo size=20 value='' >
	<% } else { %>
					<input type=text name=registerNo id=registerNo size=20 value='<%= productEach.getRegisterNo() %>' >
	<% } %>   		
				</td>
			</tr>
			
    		<tr>
     			<td class="cell-hd">Client</td>
     			<td class="cell-l">
     				<select id=clientNo name=clientNo>
	     				<option value=''>����</option>
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

		</table>
		<table>
    		<tr height="40" valign="bottom">
     			<td colspan="2">
     				<div align="center">
     				<% if(mode.equals("C")) { %>
     					<input type="submit" class="myButton" value="���">&nbsp;
     				<% }else{ %>
     					<input type="submit" class="myButton" value="����">&nbsp;
     					<input type="button" class="myButton" value="����" onclick="confirmDelete();">&nbsp;
     				<% } %>
         				<input type="button" class="myButton" value="���" onclick="moveTo('productEachList.jsp?pg=<%=pg %>');">
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