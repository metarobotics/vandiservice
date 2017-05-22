<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>

<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
 
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
	
	Client client = null;
	
	if(mode.equals("R"))
	{
		int clientNo = Integer.parseInt(request.getParameter("clientNo"));
	
		client = clientDao.getClientInfo(clientNo);
	}

%>

<script type="text/javascript">

	var mode = '<%= mode %>';
	//alert(mode);

	function chkValid() {
		
		//alert(document.getElementById("clientNo").value);
		
		if(isNull(document.getElementById("clientNm")))
		{
			alert('������ �Է��ϼ���.');
			return false;
		}
		
		return true;
	}

	function confirmDelete() {
		
		if(confirm('�����Ͻðڽ��ϱ�?'))
		{
			<% if(mode.equals("R")) { %>   
				moveTo('clientDelete.jsp?clientNo=<%= client.getClientNo() %>');	
			<% } else { %>
			<% } %>   		
		}
	}
	
</script>
</head>

<body>
<center>

	<% if(mode.equals("R")) { %>   
   		<div class="table-title"><h1>Client ��</h1></div>
	<% } else { %>
   		<div class="table-title"><h1>Client ���</h1></div>
	<% } %>   		
   	

		<form name="form1" method="post" action="clientWrite_action.jsp?mode=<%= writeMode %>" onsubmit="return chkValid();">


		<table border=1 class='table-fill'>
    		<tr>
				<td width="30%" class="cell-hd">����ȣ</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text size=10 disabled value='' >
					<input type=hidden name=clientNo id=clientNo value='' >
	<% } else { %>
					<input type=text size=10 disabled value='<%= MrUtil.getClientNoStr(client.getClientNo()) %>' >
					<input type=hidden name=clientNo id=clientNo value='<%= client.getClientNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">����</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=clientNm id=clientNm size=20 value='' >
	<% } else { %>
					<input type=text name=clientNm id=clientNm size=20 value='<%= client.getClientNm() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">��ȭ��ȣ</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=phoneNo id=phoneNo size=20 value='' >
	<% } else { %>
					<input type=text name=phoneNo id=phoneNo size=20 value='<%= client.getPhoneNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">�ڵ�����ȣ</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=mobileNo id=mobileNo size=20 value='' >
	<% } else { %>
					<input type=text name=mobileNo id=mobileNo size=20 value='<%= client.getMobileNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">�̸���</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=email id=email size=20 value='' >
	<% } else { %>
					<input type=text name=email id=email size=20 value='<%= client.getEmail() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">������</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=location id=location size=20 value='' placeholder="ex)����">
	<% } else { %>
					<input type=text name=location id=location size=20 value='<%= client.getLocation() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">�ּ�</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=addr id=addr size=20 value='' >
	<% } else { %>
					<input type=text name=addr id=addr size=20 value='<%= client.getAddr() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">�޸�</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<textarea name=note id=note cols="95" rows="10"></textarea>
	<% } else { %>
					<textarea name=note id=note cols="100" rows="10" ><%= client.getNote() %></textarea>
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">�����</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=insertUserId id=insertUserId size=20 disabled value='<%= (String)session.getAttribute("userId") %>' >
	<% } else { %>
					<input type=text name=insertUserId id=insertUserId size=20 disabled value='<%= client.getInsertUserId() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">����Ͻ�</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=insertDatetime id=insertDatetime size=20 disabled value='javascript:today();' >
	<% } else { %>
					<input type=text name=insertDatetime id=insertDatetime size=20 disabled value='<%= client.getInsertDatetime() %>' >
	<% } %>   		
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
         				<input type="button" class="myButton" value="���" onclick="moveTo('clientList.jsp?pg=<%=pg %>');">
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