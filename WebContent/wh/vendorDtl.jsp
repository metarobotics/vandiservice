<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import="java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<%@ page import="common.*" %>
<jsp:useBean id="vendorDao" class="wh.VendorDAO"/>
<jsp:useBean id="commonDao" class="common.CommonDAO"/>
<jsp:include page = "top.jsp"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Vandi Service</title>
<link rel="stylesheet" href="../css/vandiservice.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>

<%
	String userId =  (String)session.getAttribute("userId");

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
	
	//out.print("."+mode+".");

	ArrayList<Code> countryList = commonDao.getCodeList("01"); //국적 
	int countryLength = countryList.size();
//System.out.println(countryLength);

	Vendor vendor = null;
	
	String countryCd = null;
	
	if(mode.equals("R"))
	{
		int vendorNo = Integer.parseInt(request.getParameter("vendorNo"));
	
		vendor = vendorDao.getVendorInfo(vendorNo);
		
		countryCd = vendor.getCountryCd();
	}

%>

<script type="text/javascript">

	var mode = '<%= mode %>';
	//alert(mode);

	function chkValid() {
		
		//alert(document.getElementById("vendorNo").value);
		
		if(document.getElementById("vendorNm").value == '')
		{
			alert('벤더명을 입력하세요.');
			return false;
		}
		
		return true;
	}

	function confirmDelete() {
		
		if(confirm('삭제하시겠습니까?'))
		{
			<% if(mode.equals("R")) { %>   
				moveTo('vendorWrite.jsp?mode=D&vendorNo=<%= vendor.getVendorNo() %>');	
			<% } else { %>
			<% } %>
		}
	}
	
	function setPage()
	{
		if(mode == "R")
		{
			document.getElementById("countryCd").value = '<%= countryCd %>';
		}//if(mode == "R")
	}//setPage
		
</script>
</head>

<body>
<center>

	<% if(mode.equals("R")) { %>   
   		<div class="table-title"><h1>벤더정보</h1></div>
	<% } else { %>
   		<div class="table-title"><h1>벤더등록</h1></div>
	<% } %>   		
	
	<form name="form1" method="post" action="vendorWrite.jsp?mode=<%= writeMode %>" onsubmit="return chkValid();">


		<table>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">벤더번호</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text size=10 disabled value='' >
					<input type=hidden name=vendorNo id=vendorNo value='' >
	<% } else { %>
					<input type=text size=10 disabled value='<%= MrUtil.getVendorNoStr(vendor.getVendorNo()) %>' >
					<input type=hidden name=vendorNo id=vendorNo value='<%= vendor.getVendorNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">벤더명</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=vendorNm id=vendorNm size=20 value='' >
	<% } else { %>
					<input type=text name=vendorNm id=vendorNm size=20 value='<%= vendor.getVendorNm() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">전화번호</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=phoneNo id=phoneNo size=20 value='' >
	<% } else { %>
					<input type=text name=phoneNo id=phoneNo size=20 value='<%= vendor.getPhoneNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">휴대폰번호</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=mobileNo id=mobileNo size=20 value='' >
	<% } else { %>
					<input type=text name=mobileNo id=mobileNo size=20 value='<%= vendor.getMobileNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">FAX번호</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=faxNo id=faxNo size=20 value='' >
	<% } else { %>
					<input type=text name=faxNo id=faxNo size=20 value='<%= vendor.getFaxNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">담당자 이름</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=chargeEmpNm id=chargeEmpNm size=20 value='' >
	<% } else { %>
					<input type=text name=chargeEmpNm id=chargeEmpNm size=20 value='<%= vendor.getChargeEmpNm() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">이메일</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=email id=email size=20 value='' >
	<% } else { %>
					<input type=text name=email id=email size=20 value='<%= vendor.getEmail() %>' >
	<% } %>   		
				</td>
			</tr>
			
    		<tr class="row_bottom_only">
     			<td class="cell-r">국적</td>
     			<td class="cell-l">
     				<select id=countryCd name=countryCd>
	     				<option value="0">선택</option>
		   				<%
					 		for(int i=0; i<countryLength; i++){
								Code code = countryList.get(i);
		     			%>
		      			    <option value=<%= code.getCd() %>><%= code.getCdNm() %></option>
		     			<%
		     				}
		     			%>
     				</select>
     			</td>
     		</tr>
     		
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">주소</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=addr id=addr size=20 value='' >
	<% } else { %>
					<input type=text name=addr id=addr size=20 value='<%= vendor.getAddr() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">등록자</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=insertUserId id=insertUserId size=20 disabled value='<%= (String)session.getAttribute("userId") %>' >
	<% } else { %>
					<input type=text name=insertUserId id=insertUserId size=20 disabled value='<%= vendor.getInsertUserId() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">등록일시</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=insertDatetime id=insertDatetime size=20 disabled value='javascript:today();' >
	<% } else { %>
					<input type=text name=insertDatetime id=insertDatetime size=20 disabled value='<%= vendor.getInsertDatetime() %>' >
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
	     				<% if(userId.equals("bona")) { %>
     						<input type="button" class="dtlBtn" value="삭제" onclick="confirmDelete();">&nbsp;
	     				<% } %>
     				<% } %>
         				<input type="button" class="dtlBtn" value="목록" onclick="moveTo('vendorList.jsp?pg=<%=pg %>');">
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