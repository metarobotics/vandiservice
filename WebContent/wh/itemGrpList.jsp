<%@ page contentType="text/html;charset=euc_kr" %>
<% request.setCharacterEncoding("euc-kr"); %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="mrDao" class="wh.MrDAO"/>

<%	
	int total = mrDao.countItemGrp();
	ArrayList<ItemGrp> alist = mrDao.getItemGrpList();
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
</head>

<body translate="no" >
   <div class="table-title"><h1>물품 분류 목록</h1></div>

<table class="table-fill" width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td class="cell-r">total : <%= size %></td></tr></table>
<table class="table-fill" border="1">
<tr class="header">
	<th width="10%" class="text-center">itemGrpId</th>
	<th width="10%" class="text-center">grp1</th>
	<th width="10%" class="text-center">grp2</th>
	<th width="10%" class="text-center">grp3</th>
	<th width="15%" class="text-center">grp1Nm</th>
	<th width="15%" class="text-center">grp2Nm</th>
	<th width="15%" class="text-center">grp3Nm</th>
	<th width="15%" class="text-center">memo</th>
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
	 			ItemGrp itemGrp = alist.get(i);
	//			indent = item.getIndent();
				/*int itemNo = item.getItemNo();
				String itemNm = item.getItemNm();
				String regUserId = item.getInsertUserId();
				String regDt = item.getInsertDatetime.toString();*/
%>

<tr class="row">
<td class="cell-c"><%= itemGrp.getItemGrpId()%></td>
<td class="cell-c"><%= MrUtil.getNoStr2(itemGrp.getGrp1Cd())%></td>
<td class="cell-c"><%= MrUtil.getNoStr2(itemGrp.getGrp2Cd())%></td>
<td class="cell-c"><%= MrUtil.getNoStr2(itemGrp.getGrp3Cd())%></td>
<td class="cell-c"><%= itemGrp.getGrp1Nm()%></td>
<td class="cell-c"><%= itemGrp.getGrp2Nm()%></td>
<td class="cell-c"><%= itemGrp.getGrp3Nm()%></td>
<td class="cell-c"><%= itemGrp.getNote()%></td>
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
	<!-- <tr align="right">
   		<td ><input type=button class="myButton" value="등록" OnClick="window.location='clientDtl.jsp?mode=C&pg=<%=pg%>'"></td>
  </tr> -->


</tbody>
</table>

</body>
</html>