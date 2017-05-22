
<%@ page contentType="text/html;charset=euc_kr" %>
<% request.setCharacterEncoding("euc-kr"); %>


<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="dao" class="wh.ProductEachDAO"/>

<%	
	ArrayList<ProductEach> alist = dao.getProductEachList();
	int productEachListSize = alist.size();
	
	int size = alist.size();
	int size2 = size;
	
	final int ROWSIZE = 100;
	final int BLOCK = 5;
	int indent = 0;

	int pg = 1;
	
	if(request.getParameter("pg")!=null) {
		pg = Integer.parseInt(request.getParameter("pg"));
	}
	
	int end = (pg*ROWSIZE);
	
	int allPage = 0;

	int startPage = ((pg-1)/BLOCK*BLOCK)+1;
	int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK;
	
	allPage = (int)Math.ceil(productEachListSize/(double)ROWSIZE);
	
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
 	<link rel="stylesheet" href="../css/mr.css">
</head>

<body translate="no" >
   <div class="table-title"><h1>Product 생산 목록</h1></div>

<table class="table-fill" width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td class="cell-r">total : <%= size %></td></tr></table>
<table class="table-fill" border="1">
<tr class="header">
	<th width="15%" class="text-center">productNo</th>
	<th width="15%" class="text-center">serialNo</th>
	<th width="10%" class="text-center">prodDt</th>
	<th width="10%" class="text-center">certDt</th>
	<th width="20%" class="text-center">registerNo</th>
	<th width="10%" class="text-center">clientNo</th>
	<th width="20%" class="text-center">clientNm</th>
</tr>
<tbody class="table-hover">
<%
	if(productEachListSize==0) {
%>
		<tr class="row">
	 	   <td colspan="7" class="cell-c">등록된 내역이 없습니다.</td>
		</tr>
	 <%
	 	} else {
	 		for(int i=ROWSIZE*(pg-1); i<end;i++){
	 			ProductEach productEach = alist.get(i);
	//			indent = item.getIndent();
				/*int itemNo = item.getItemNo();
				String itemNm = item.getItemNm();
				String regUserId = item.getInsertUserId();
				String regDt = item.getInsertDatetime.toString();*/
%>

<tr class="row">
<td class="cell-c"><%=productEach.getProductNo()%></td>
<td class="cell-c"><a href="productEachDtl.jsp?mode=R&productNo=<%=productEach.getProductNo()%>&serialNo=<%=productEach.getSerialNo()%>&pg=<%=pg%>"><%= productEach.getSerialNo() %></a></td>
<td class="cell-c"><%=productEach.getProdDt()%></td>
<td class="cell-c"><%=productEach.getCertDt()%></td>
<td class="cell-c"><%=productEach.getRegisterNo()%></td>
<td class="cell-c"><%=productEach.getClientNo()%></td>
<td class="cell-c"><%=productEach.getClientNm()%></td>
</tr>

<%

	}}

%>

</table>
<br>
<table class="table-fill2" width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr>
	<td align="center">
		<%
			if(pg>BLOCK) {
		%>
			[<a href="toList.jsp?pg=1">◀◀</a>]
			[<a href="toList.jsp?pg=<%=startPage-1%>">◀</a>]
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
					[<a href="toList.jsp?pg=<%=i %>"><%=i %></a>]
		<%
				}
			}
		%>
		
		<%
			if(endPage<allPage){
		%>
			[<a href="toList.jsp?pg=<%=endPage+1%>">▶</a>]
			[<a href="toList.jsp?pg=<%=allPage%>">▶▶</a>]
		<%
			}
		%>
		</td>
		</tr>
	<tr align="right">
   		<td ><input type=button class="myButton" value="등록" OnClick="window.location='productEachDtl.jsp?mode=C&pg=<%=pg%>'"></td>
  </tr>


</tbody>
</table>

</body>
</html>