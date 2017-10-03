<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="mrDao" class="wh.MrDAO"/>
<jsp:include page = "top.jsp"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Vandi Service</title>
<link rel="stylesheet" href="../css/mr.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>


<%
	String mode = request.getParameter("mode"); // C/R
	String pg = ""; //request.getParameter("pg");
	
	String writeMode;
	if(mode.equals("C"))
		writeMode = "C";
	else // R
		writeMode = "U";
	
	int orderNo = 0;

	//out.print("."+mode+".");
	
	Company company = null;
	
	if(mode.equals("R"))
	{
		int companyNo = 1; //Integer.parseInt(request.getParameter("companyNo"));
	
		company = mrDao.getCompanyInfo(companyNo);
	}

%>

<script type="text/javascript">

	var mode = '<%= mode %>';
	//alert(mode);
/*
	function chkValid() {
		
		//alert(document.getElementById("companyNo").value);
		
		if(isNull(document.getElementById("companyNm")))
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
				//moveTo('companyDelete.jsp?companyNo=<%= company.getCompanyNo() %>');	
			<% } else { %>
			<% } %>   		
		}
	}
	*/
</script>
</head>

<body>
<center>

	<% if(mode.equals("R")) { %>   
   		<div class="table-title"><h1>Company 상세</h1></div>
	<% } else { %>
   		<div class="table-title"><h1>Company 등록</h1></div>
	<% } %>   		
   	
 		<form name="form1" method="post" action="companyWrite_action.jsp?mode=<%= writeMode %>" onsubmit="return chkValid();">


		<table border=1 class='table-fill'>
    		<tr>
				<td width="30%" class="cell-hd">companyNo</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text size=10 disabled value='' >
					<input type=hidden name=companyNo id=companyNo value='' >
	<% } else { %>
					<input type=text size=10 disabled value='<%= MrUtil.getClientNoStr(company.getCompanyNo()) %>' >
					<input type=hidden name=companyNo id=companyNo value='<%= company.getCompanyNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">companyId</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=companyId id=companyId size=20 value='' >
	<% } else { %>
					<input type=text name=companyId id=companyId size=20 value='<%= company.getCompanyId() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">companyNm</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=companyNm id=companyNm size=20 value='' >
	<% } else { %>
					<input type=text name=companyNm id=companyNm size=20 value='<%= company.getCompanyNm() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">ceoNm</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=ceoNm id=ceoNm size=20 value='' >
	<% } else { %>
					<input type=text name=ceoNm id=ceoNm size=20 value='<%= company.getCeoNm() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">phoneNo</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=phoneNo id=phoneNo size=20 value='' >
	<% } else { %>
					<input type=text name=phoneNo id=phoneNo size=20 value='<%= company.getPhoneNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">mobileNo</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=mobileNo id=mobileNo size=20 value='' placeholder="ex)나주">
	<% } else { %>
					<input type=text name=mobileNo id=mobileNo size=20 value='<%= company.getMobileNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td class="cell-hd">faxNo</td>
				<td class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=faxNo id=faxNo size=20 value='' >
	<% } else { %>
					<input type=text name=faxNo id=faxNo size=20 value='<%= company.getFaxNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td class="cell-hd">email</td>
				<td class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=email id=email size=20 value='' >
	<% } else { %>
					<input type=text name=email id=email size=20 value='<%= company.getEmail() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td class="cell-hd">addr</td>
				<td class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=addr id=addr size=20 value='' >
	<% } else { %>
					<input type=text name=addr id=addr size=20 value='<%= company.getAddr() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td class="cell-hd">acntBankNm</td>
				<td class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=acntBankNm id=acntBankNm size=20 value='' >
	<% } else { %>
					<input type=text name=acntBankNm id=acntBankNm size=20 value='<%= company.getAcntBankNm() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td class="cell-hd">acntNo</td>
				<td class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=acntNo id=acntNo size=20 value='' >
	<% } else { %>
					<input type=text name=acntNo id=acntNo size=20 value='<%= company.getAcntNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td class="cell-hd">acntUserNm</td>
				<td class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=acntUserNm id=acntUserNm size=20 value='' >
	<% } else { %>
					<input type=text name=acntUserNm id=acntUserNm size=20 value='<%= company.getAcntUserNm() %>' >
	<% } %>   		
				</td>
			</tr>
 
			
			
			
			<!-- 
    		<tr>
				<td width="30%" class="cell-hd">등록자</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=insertUserId id=insertUserId size=20 disabled value='<%= (String)session.getAttribute("userId") %>' >
	<% } else { %>
					<input type=text name=insertUserId id=insertUserId size=20 disabled value='<%= company.getInsertUserId() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">등록일시</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=insertDatetime id=insertDatetime size=20 disabled value='javascript:today();' >
	<% } else { %>
					<input type=text name=insertDatetime id=insertDatetime size=20 disabled value='<%= company.getInsertDatetime() %>' >
	<% } %>   		
				</td>
			</tr>
			 -->
		</table>
		
		<table>
    		<tr height="40" valign="bottom">
     			<td colspan="2">
     				<div align="center">
     				<% if(mode.equals("C")) { %>
     					<!--<input type="submit" class="myButton" value="등록">&nbsp;-->
     				<% }else{ %>
     					<!--  <input type="submit" class="myButton" value="수정">&nbsp;-->
     					<!--  <input type="button" class="myButton" value="삭제" onclick="confirmDelete();">&nbsp;-->
     				<% } %>
         				<!--  <input type="button" class="myButton" value="목록" onclick="moveTo('companyList.jsp?pg=<%=pg %>');">-->
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