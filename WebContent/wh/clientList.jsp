<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import="java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="dao" class="wh.ClientDAO"/>
<jsp:include page = "top.jsp"/>

<%	
	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;
	//if(authLvl.equals("S") || authLvl.equals("A")) // 등록,수정 권한자

	ArrayList<Client> alist = dao.getClientList();
	
	int size = alist.size();
	int size2 = size;
	
	final int ROWSIZE = 20;
	final int BLOCK = 10;
	int indent = 0;

	int pg = 1;
	
	if(request.getParameter("pg")!=null) {
		pg = Integer.parseInt(request.getParameter("pg"));
	}
	
	int end = (pg*ROWSIZE);
	
	int allPage = 0;

	int startPage = ((pg-1)/BLOCK*BLOCK)+1;
	int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK;
	
	allPage = (int)Math.ceil(size/(double)ROWSIZE);
	
	if(endPage > allPage) {
		endPage = allPage;
	}
	
	size2 -=end;
	if(size2 < 0) {
		end = size;
	}
	
%>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
 	<link rel="stylesheet" href="../css/vandiservice.css">
</head>

<body>
<center>
   <div class="table-title"><h1>고객목록</h1></div>

<table cellpadding="0" cellspacing="0" border="0">
<tr>
	<td class="cell-r">total : <%= size %></td>
</tr>
</table>

<table border="1">
	<tr class="header">
		<th width="15%" class="text-center">고객번호</th>
		<th width="30%" class="text-center">고객명</th>
		<th width="35%" class="text-center">거주지</th>
		<th width="20%" class="text-center">거래건수</th>
	</tr>
	
	<%
		if(size==0) {
	%>
			<tr class="row">
		 	   <td colspan="4" class="cell-c">등록된 내역이 없습니다.</td>
			</tr>
		 <%
		 	} else {
		 		for(int i=ROWSIZE*(pg-1); i<end;i++){
					Client client = alist.get(i);
		//			indent = item.getIndent();
					/*int itemNo = item.getItemNo();
					String itemNm = item.getItemNm();
					String regUserId = item.getInsertUserId();
					String regDt = item.getInsertDatetime.toString();*/
	%>
	
	<tr class="row">
		<td class="cell-c"><a href="clientDtl.jsp?mode=R&clientNo=<%=client.getClientNo()%>&pg=<%=pg%>"><%= MrUtil.getClientNoStr(client.getClientNo()) %></a></td>
		<td class="cell-c"><%=client.getClientNm()%></td>
		<td class="cell-c"><%=client.getLocation()%></td>
		<td class="cell-c"><%=client.getDealCnt()%>건</td>
	</tr>

<%

	}}

%>

</table>
<table cellpadding="0" cellspacing="0" border="0">
	<tr height="10"/>
  	<tr>
		<td align="center">
			<%
				if(pg>BLOCK) {
			%>
				[<a href="clientList.jsp?pg=1">◀◀</a>]
				[<a href="clientList.jsp?pg=<%=startPage-1%>">◀</a>]
			<%
				}
			%>
			
			<%
				for(int i=startPage; i<= endPage; i++){
					if(i==pg){
			%>
						<u><b>[<%=i %>]</b></u>
			<%
					}else{
			%>
						[<a href="clientList.jsp?pg=<%=i %>"><%=i %></a>]
			<%
					}
				}
			%>
			
			<%
				if(endPage<allPage){
			%>
				[<a href="clientList.jsp?pg=<%=endPage+1%>">▶</a>]
				[<a href="clientList.jsp?pg=<%=allPage%>">▶▶</a>]
			<%
				}
			%>
		</td>
	</tr>
	<tr height="10"></tr>
	<tr>
		<%
		if(authLvl.equals("S") || authLvl.equals("A")) { // 등록,수정 권한자
		%>
	   		<td align="center"><input type=button class="myButton" value="등록" OnClick="window.location='clientDtl.jsp?mode=C&pg=<%=pg%>'"></td>
	   	<%} else { %>
	   	<%} %>
  	</tr>
</table>
</center>
</body>
</html>