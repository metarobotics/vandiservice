<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
 
<jsp:include page = "/loginChk.jsp"/>
<jsp:useBean id="dao" class="wh.ItemDAO"/>

<%	
	int total = dao.countItem();
	ArrayList<Item> alist = dao.getItemList();
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
 	<link rel="stylesheet" href="../css/mr.css">
	<!--  <script type="text/javascript" src="../js/mr.js"></script>--> 
</head>

<body translate="no" >

   <div class="table-title"><h1>Item 목록</h1></div>

<table class="table-fill" width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td class="cell-r">total : <%= size %></td></tr></table>
<table class="table-fill" border="1">
<tr class="header">
	<th class="text-center">itemNo</th>
	<th class="text-center">itemId</th>
	<th class="text-center">itemNm</th>
	<th class="text-center">itemNmKor</th>
	
	<th class="text-center">sku</th>
	<th class="text-center">vendorId</th>
	<th class="text-center">price</th>
	<th class="text-center">curCd</th>
	<th class="text-center">priceMeta</th>
	<th class="text-center">priceFactory</th>
	<th class="text-center">priceCenter</th>
	<th class="text-center">priceClient</th>
	<th class="text-center">serviceHour</th>
	<th class="text-center">moqVendor</th>
	<th class="text-center">moqCenter</th>
	<th class="text-center">requiredStockCnt</th>
	<th class="text-center">defectStockCnt</th>
	<th class="text-center">linkItem</th>
	<th class="text-center">linkInvoice</th>
	<th class="text-center">note</th>
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
<td class="cell-c"><%=item.getItemNo()%></td>
<td class="cell-c"><%=item.getItemId()%></td>
<td class="cell-l"><a href="itemDtl.jsp?mode=R&idx=<%=item.getItemNo()%>&pg=<%=pg%>"><%=item.getItemNm()%></td>
<td class="cell-l"><%=item.getItemNmKor()%></td>

<td class="cell-l"><%=item.getSku()%></td>
<td class="cell-l"><%=item.getVendorId()%></td>
<td class="cell-l"><%=item.getPrice()%></td>
<td class="cell-l"><%=item.getCurCd()%></td>
<td class="cell-l"><%=item.getPriceMeta()%></td>
<td class="cell-l"><%=item.getPriceFactory()%></td>
<td class="cell-l"><%=item.getPriceCenter()%></td>
<td class="cell-l"><%=item.getPriceClient()%></td>
<td class="cell-l"><%=item.getServiceHour()%></td>
<td class="cell-l"><%=item.getMoqVendor()%></td>
<td class="cell-l"><%=item.getMoqCenter()%></td>
<td class="cell-l"><%=item.getRequiredStockCnt()%></td>
<td class="cell-l"><%=item.getDefectStockCnt()%></td>
<td class="cell-l"><%=item.getLinkItem()%></td>
<td class="cell-l"><%=item.getLinkInvoice()%></td>
<td class="cell-l"><%=item.getNote()%></td>

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
<br>
# moq : minimum order quantity 판매,포장 단위
</body>
</html>

