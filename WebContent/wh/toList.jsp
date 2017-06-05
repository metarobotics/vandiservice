
<%@ page contentType="text/html;charset=euc_kr" %>
<% request.setCharacterEncoding("euc-kr"); %>


<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>

<jsp:include page = "top.jsp"/>
<jsp:useBean id="dao" class="wh.OrderTDAO"/>

<%	
	//int total = dao.countOrderT();

	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;
	int whNo =  (Integer)session.getAttribute("whNo");
	
	ArrayList<OrderT> alist = null;
	if(authLvl.equals("S")) // super
		alist = dao.getOrderTList();
	else
		alist = dao.getOrderTList(whNo);
	
	int total = alist.size();
	int size2 = total;
	
	final int ROWSIZE = 10;
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
		end = total;
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
	   <div class="table-title"><h1>T.O.(Transfer order) 목록</h1></div>
	   <!-- 
<table>
	<tr height="20"></tr>
	<tr>
		<td class="td_railway_h0">T.O.(Transfer order)</td>
	</tr>
	<tr height="20"></tr>
</table>
 -->
<table width="600">
<tr>
<td>
<h2>주문관련 주의사항</h2>
주문후에 본사에 연락을 하고, 견적서를 요청하시면 됩니다.
<br>
입금계좌 : 농협 301-0212-5189-11 예금주: 메타로보틱스 주식회사
</td>
</tr>
<tr height="30"/>
</table>

<table width="600" border="1">
<tr class="header">
	<th width="15%" class="text-center">주문번호</th>
	<th width="15%" class="text-center">주문일자</th>
	<th width="20%" class="text-center">출고지</th>
	<th width="20%" class="text-center">배송지</th>
	<th width="20%" class="text-center">합계금액</th>
	<th width="10%" class="text-center">상태</th>
</tr>
<tbody class="table-hover">
<%
	if(total==0) {
%>
		<tr class="row">
	 	   <td colspan="6" class="cell-c">등록된 내역이 없습니다.</td>
		</tr>
	 <%
	 	} else {
	 		for(int i=ROWSIZE*(pg-1); i<end;i++){
				OrderT orderT = alist.get(i);
%>

	<tr class="row">
	<td class="cell-c"><a href="toDtl.jsp?mode=R&orderNo=<%=orderT.getOrderNo()%>&pg=<%=pg%>"><%= MrUtil.getTOrderNoStr(orderT.getOrderNo()) %></a></td>
	<td class="cell-c"><%=orderT.getOrderDt()%></td>
	<td class="cell-c"><%=orderT.getSrcWhNm()%></td>
	<td class="cell-c"><%=orderT.getDestWhNm()%></td>
	<td class="cell-r"><%=MrUtil.FormatCurrentDisplay(orderT.getTotalAmt()) %></td>
	<td class="cell-c"><%=orderT.getStatusNm()%></td>
	</tr>

<%

	}}

%>

</tbody>
</table>

<br>
<table cellpadding="0" cellspacing="0" border="0">
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
	<tr height="10"></tr>
	<tr>
   		<td align="center"><input type=button class="dtlBtn" value="등록" OnClick="window.location='toDtl.jsp?mode=C&pg=<%=pg%>'"></td>
  </tr>
</table>

</center>
</body>
</html>