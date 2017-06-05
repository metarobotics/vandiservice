<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>

<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
 
<jsp:include page = "top.jsp"/>

<jsp:useBean id="clientDao" class="wh.ClientDAO"/>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Vandi clients</title>
<link rel="stylesheet" href="../css/vandiservice.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="../js/chkValid.js"></script>
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
			alert('고객명을 입력하세요.');
			return false;
		}
		
		return true;
	}

	function confirmDelete() {
		
		if(confirm('삭제하시겠습니까?'))
		{
			<% if(mode.equals("R")) { %>   
				moveTo('clientWrite_action.jsp?mode=D&clientNo=<%= client.getClientNo() %>');	
			<% } else { %>
			<% } %>
		}
	}
	
</script>
</head>

<body>
<center>

   		<div class="table-title"><h1>고객정보</h1></div>

		<form name="form1" method="post" action="clientWrite_action.jsp?mode=<%= writeMode %>" onsubmit="return chkValid();">


		<table>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">고객번호</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text size=10 disabled value='' >
					<input type=hidden name=clientNo id=clientNo value='' >
	<% } else { %>
					<input type=text size=10 disabled value='<%= MrUtil.getClientNoStr(client.getClientNo()) %>' >
					<input type=hidden name=clientNo id=clientNo value='<%= client.getClientNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">고객명</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=clientNm id=clientNm size=20 value='' >
	<% } else { %>
					<input type=text name=clientNm id=clientNm size=20 value='<%= client.getClientNm() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">전화번호</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=phoneNo id=phoneNo size=20 value='' >
	<% } else { %>
					<input type=text name=phoneNo id=phoneNo size=20 value='<%= client.getPhoneNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">휴대폰번호</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=mobileNo id=mobileNo size=20 value='' >
	<% } else { %>
					<input type=text name=mobileNo id=mobileNo size=20 value='<%= client.getMobileNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">이메일</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=email id=email size=20 value='' >
	<% } else { %>
					<input type=text name=email id=email size=20 value='<%= client.getEmail() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">거주지</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=location id=location size=20 value='' placeholder="ex)나주">
	<% } else { %>
					<input type=text name=location id=location size=20 value='<%= client.getLocation() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">주소</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=addr id=addr size=20 value='' >
	<% } else { %>
					<input type=text name=addr id=addr size=20 value='<%= client.getAddr() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">등록자</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=insertUserId id=insertUserId size=20 disabled value='<%= (String)session.getAttribute("userId") %>' >
	<% } else { %>
					<input type=text name=insertUserId id=insertUserId size=20 disabled value='<%= client.getInsertUserId() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">등록일시</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=insertDatetime id=insertDatetime size=20 disabled value='javascript:today();' >
	<% } else { %>
					<input type=text name=insertDatetime id=insertDatetime size=20 disabled value='<%= client.getInsertDatetime() %>' >
	<% } %>   		
				</td>
			</tr>
			<tr height="20"/>
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
         				<input type="button" class="dtlBtn" value="목록" onclick="moveTo('clientList.jsp?pg=<%=pg %>');">
         			</div>
     			</td>
    		</tr>
		</table>    		 
	</form> 
</center>
</body>
</html>