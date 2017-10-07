<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import="java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="mrDao" class="wh.MrDAO"/>
<jsp:useBean id="itemDao" class="wh.ItemDAO"/>
<jsp:useBean id="stockDao" class="wh.ItemStockHistDAO"/>
<jsp:include page = "top.jsp"/>

<%	
	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;
//	if(authLvl.equals("S") || authLvl.equals("A")) // 등록,수정 권한자

	ArrayList<Item> itemList = itemDao.getItemList();
	int itemLength = itemList.size();
	ArrayList<Wh> whList = mrDao.getWhList();
	int whLength = whList.size();
	
	/*
	String strParamWhNo = request.getParameter("whNo");
	int intParamWhNo = -1;
	if(strParamWhNo != null && !strParamWhNo.equals("")){
		intParamWhNo = Integer.parseInt(strParamWhNo);
	}*/
	int intParamWhNo = 0;
	
	String strParamItemNo = request.getParameter("itemNo");
	int intParamItemNo = -1;
	if(strParamItemNo != null && !strParamItemNo.equals("")){
		intParamItemNo = Integer.parseInt(strParamItemNo);
	}
	
	String strFromDt = request.getParameter("fromDt");
	String strToDt = request.getParameter("toDt");
	String dealType = request.getParameter("dealType");
	//if(dealType == null) dealType = "";
	
	ArrayList<ItemStockHist> alist = null; 
	alist = stockDao.getItemStockHistList(intParamWhNo, intParamItemNo, strFromDt, strToDt, dealType);
	int histSize = alist.size();
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
<script> 	
	function setPage()
	{
		<% if(intParamWhNo != -1){ %>
			document.getElementById("whNo").value = '<%= intParamWhNo %>';
		<% } %>
		<% if(intParamItemNo != -1){ %>
			document.getElementById("itemNo").value = '<%= intParamItemNo %>';
	 	<% } %>
	}
</script>			
</head>

<body>
	<!-- FORM -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

		<form name="form1" method="post" action="stockHist.jsp">

<center>
   <div class="table-title"><h1>자재 재고 이력</h1></div>

<table border="0" style="width:700;">
<tr>
	<td width="20%" class="cell-l" style="display:none;">센터 
		<select id=whNo name=whNo><-- style="width:60px" -->
				<option value=''>전체</option>
			<%
				for(int i=0; i<whLength; i++){
					Wh wh = whList.get(i);
					
					if(intParamWhNo != 0 && intParamWhNo == wh.getWhNo()) {					
 			%>
  				    	<option value=<%= wh.getWhNo() %> selected><%= wh.getWhNm() %></option>
			<% 		} else { %>  				    
  				    	<option value=<%= wh.getWhNo() %>><%= wh.getWhNm() %></option>
 			<%
					}
				}
 			%>
		</select>
	</td>
	<td width="30%" class="cell-l">자재
		<select id=itemNo name=itemNo style="width:150px">
				<option value=''>전체</option>
			<%
				for(int i=0; i<itemLength; i++){
					Item item = itemList.get(i);
					
					if(intParamWhNo != 0 && intParamWhNo == item.getItemNo()) {					
 			%>
  				    	<option value=<%= item.getItemNo() %> selected><%= item.getItemNm() %></option>
			<% 		} else { %>  				    
  				    	<option value=<%= item.getItemNo() %>><%= item.getItemNm() %></option>
 			<%
					}
				}
 			%>
		</select>
	</td>
	<td width="46%" class="cell-l">기간 
		<input type=date name=fromDt id=fromDt size=10 value='<%= MrUtil.getDateStr() %>' style="width:125;">
		 ~ <input type=date name=toDt id=toDt size=10 value='<%= MrUtil.getDateStr() %>' style="width:125;">
	</td>		
	<td class="cell-l">구분
		<select id=dealType name=dealType>
				<option value=''>전체</option>
				
 			<%		if(dealType == null || dealType.equals("")) { %>
  				    	<option value="01">입고</option>
  				    	<option value="02">출고</option>
			<%		} else if(dealType.equals("01")) { %>
  				    	<option value="01" selected>입고</option>
  				    	<option value="02">출고</option>
			<% 		} else if(dealType.equals("02")) { %>  				    
  				    	<option value="01">입고</option>
  				    	<option value="02" selected>출고</option>
 			<%		}  %>
				
		</select>
	</td>	
	<td class="cell-r"><input type="submit" class="btnSearch" value="조회"></td>
</tr>
<tr height="10">
	<td colspan="5" class="cell-r">total : <%= size %></td>
</tr>	
</table>

<table border="1" style="width:700;">
	<tr class="header">
		<th width="13%" class="text-center">센터</th>
		<th width="18%" class="text-center">자재</th>
		<th width="22%" class="text-center">일시</th>
		<th width="7%" class="text-center">구분</th>
		<th width="10%" class="text-center">주문번호</th>
		<th width="10%" class="text-center">이전재고</th>
		<th width="10%" class="text-center">처리갯수</th>
		<th width="10%" class="text-center">잔여재고</th>
	</tr>
	<tbody class="table-hover">
	
	<%
		if(size==0) {
	%>
			<tr class="row">
		 	   <td colspan="8" class="cell-c">등록된 내역이 없습니다.</td>
			</tr>
	<%
	 	} else {
	 		for(int i=ROWSIZE*(pg-1); i<end;i++){
	 			ItemStockHist itemStockHist = alist.get(i);
	//			indent = item.getIndent();
				/*int itemNo = item.getItemNo();
				String itemNm = item.getItemNm();
				String regUserId = item.getInsertUserId();
				String regDt = item.getInsertDatetime.toString();*/
	%>
	
			<tr class="row">
				<td class="cell-c"><%=itemStockHist.getWhNm()%></td>
				<td class="cell-c"><%=itemStockHist.getItemNm()%></td>
				<td class="cell-c"><%=itemStockHist.getInsertDatetime()%></td>
				<td class="cell-c"><%=itemStockHist.getDealTypeStr()%></td>
		<%	if(itemStockHist.getOrderType().equals("P")) { %>
				<td class="cell-c"><a href="poDtl.jsp?mode=R&orderNo=<%=itemStockHist.getOrderNo()%>"><%=itemStockHist.getOrderNoStr()%></a></td>
		<% } else if(itemStockHist.getOrderType().equals("T")) { %>
				<td class="cell-c"><a href="toDtl.jsp?mode=R&orderNo=<%=itemStockHist.getOrderNo()%>"><%=itemStockHist.getOrderNoStr()%></a></td>
		<% } %>
				<td class="cell-c"><%=itemStockHist.getBeforeCnt()%></td>
				<td class="cell-c"><%=itemStockHist.getDealCnt()%></td>
				<td class="cell-c"><%=itemStockHist.getAfterCnt()%></td>
			</tr>

	<%
			}
		}
	%>

</tbody>
</table>
<table cellpadding="0" cellspacing="0" border="0">
	<tr height="10"/>
	<tr>
		<td align="center">
			<%
				if(pg>BLOCK) {
			%>
				[<a href="stockHist.jsp?pg=1">◀◀</a>]
				[<a href="stockHist.jsp?pg=<%=startPage-1%>">◀</a>]
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
						[<a href="stockHist.jsp?pg=<%=i %>"><%=i %></a>]
			<%
					}
				}
			%>
			
			<%
				if(endPage<allPage){
			%>
				[<a href="stockHist.jsp?pg=<%=endPage+1%>">▶</a>]
				[<a href="stockHist.jsp?pg=<%=allPage%>">▶▶</a>]
			<%
				}
			%>
		</td>
	</tr>
</table>
</center>
</form>
<script>
	setPage();
</script>
</body>
</html>