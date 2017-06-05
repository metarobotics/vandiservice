<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
 
<jsp:include page = "top.jsp"/>
<jsp:useBean id="itemDao" class="wh.ItemDAO"/>

<%	
	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;

	int total = itemDao.countItem();

	if(session.getAttribute("whNo") == null || (Integer)session.getAttribute("whNo") == -1){
		return;
	}
	
	int whNo = (Integer)session.getAttribute("whNo");
	
	ArrayList<Item> alist = null;
	alist = itemDao.getItemList(whNo);
	
	int size = alist.size();
	int size2 = size;
	
	final int ROWSIZE = 1000;
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
	
	allPage = (int)Math.ceil(total/(double)ROWSIZE);
	
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

<body translate="no" >
<center>
	   <div class="table-title"><h1>자재목록 20170529</h1></div>

<table width="540" cellpadding="0" cellspacing="0" border="0">
<tr>
	<td class="cell-r">total : <%= size %></td>
</tr>
</table>

<table border="1">
<tr>
	<th class="text-center">Part no.</th>
	<th class="text-center">Description</th>
	<th class="text-center">Center Price</th>
	<th class="text-center">List price</th>
	<th class="text-center">Service hour</th>
	<th class="text-center">Item Count</th>
</tr>
<tbody class="table-hover">
<%
	if(total==0) {
%>
		<tr class="row">
	 	   <td colspan="4" class="cell-c">등록된 내역이 없습니다.</td>
		</tr>
	 <%
	 	} else {
	 		for(int i=ROWSIZE*(pg-1); i<end;i++){
				Item item = alist.get(i);	
	//			indent = item.getIndent();
				/*int itemNo = item.getItemNo();
				String itemNm = item.getItemNm();
				String regUserId = item.getInsertUserId();
				String regDt = item.getInsertDatetime.toString();*/
%>



<tr class="row">
<td class="cell-c"><%=item.getItemId()%></td>
<td class="cell-l"><a href="itemDtl.jsp?mode=R&idx=<%=item.getItemNo()%>&pg=<%=pg%>"><%=item.getItemNm()%></td>
<td class="cell-r"><%=item.getPriceCenterStr()%></td>
<td class="cell-r"><%=item.getPriceClientStr()%></td>
<td class="cell-c"><%=item.getServiceHour()%></td>
<td class="cell-c"><%=item.getItemCnt()%></td>

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
			[<a href="itemList.jsp?pg=1">◀◀</a>]
			[<a href="itemList.jsp?pg=<%=startPage-1%>">◀</a>]
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
					[<a href="itemList.jsp?pg=<%=i %>"><%=i %></a>]
		<%
				}
			}
		%>
		
		<%
			if(endPage<allPage){
		%>
			[<a href="itemList.jsp?pg=<%=endPage+1%>">▶</a>]
			[<a href="itemList.jsp?pg=<%=allPage%>">▶▶</a>]
		<%
			}
		%>
		</td>
		</tr>
	<!-- <tr align="right">
   		<td ><input type=button class="myButton" value="등록" OnClick="window.location='itemDtl.jsp?mode=C&pg=<%=pg%>'"></td>
  </tr> -->

</tbody>
</table>
</center>
</body>
</html>

<jsp:include page = "/bottom.jsp"/>
