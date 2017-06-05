
<%@ page contentType="text/html;charset=euc_kr" %>
<% request.setCharacterEncoding("euc-kr"); %>


<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>

<jsp:include page = "top.jsp"/>

<jsp:useBean id="dao" class="wh.OrderSDAO"/>

<%	
	//int total = dao.countOrderS();

	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;
	
	int whNo =  (Integer)session.getAttribute("whNo");

	ArrayList<OrderS> alist = null;
	if(authLvl.equals("S")) // super
		alist = dao.getOrderSList();
	else
		alist = dao.getOrderSList(whNo);
	
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
	   <div class="table-title"><h1>���������</h1></div>
<table border="1">
<tr class="header">
	<th width="10%" class="text-center">������</th>
	<th width="14%" class="text-center">��¥</th>
	<th width="16%" class="text-center">���񽺼���</th>
	<th width="16%" class="text-center">��ǰ��ȣ</th>
	<th width="14%" class="text-center">����</th>
	<th width="10%" class="text-center">�հ�ݾ�</th>
	<th width="10%" class="text-center">����</th>
</tr>
<tbody class="table-hover">
<%
	if(total==0) {
%>
		<tr class="row">
	 	   <td colspan="8" class="cell-c">��ϵ� ������ �����ϴ�.</td>
		</tr>
	 <%
	 	} else {
	 		for(int i=ROWSIZE*(pg-1); i<end;i++){
				OrderS orderS = alist.get(i);
				System.out.println(orderS.getTotalAmt());
	//			indent = item.getIndent();
				/*int itemNo = item.getItemNo();
				String itemNm = item.getItemNm();
				String regUserId = item.getInsertUserId();
				String regDt = item.getInsertDatetime.toString();*/
%>

<tr class="row">
<td class="cell-c"><a href="soDtl.jsp?mode=R&orderNo=<%=orderS.getOrderNo()%>&pg=<%=pg%>"><%= MrUtil.getSOrderNoStr(orderS.getOrderNo()) %></a></td>
<td class="cell-c"><%=orderS.getOrderDt()%></td>
<td class="cell-c"><%=orderS.getCenterNm()%></td>
<td class="cell-c"><%=orderS.getProductSerialNo()%></td>
<td class="cell-c"><%=orderS.getClientNm()%></td>
<td class="cell-r"><%=MrUtil.FormatCurrentDisplay(orderS.getTotalAmt()) %></td>
<td class="cell-c"><%=orderS.getStatusNm()%></td>
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
			[<a href="toList.jsp?pg=1">����</a>]
			[<a href="toList.jsp?pg=<%=startPage-1%>">��</a>]
		<%
			}
		%>
		
		<%
			for(int i=startPage; i<= endPage; i++){
				if(i==pg){
		%>
					<h3>pages [<%=i %>]</h3>
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
			[<a href="toList.jsp?pg=<%=endPage+1%>">��</a>]
			[<a href="toList.jsp?pg=<%=allPage%>">����</a>]
		<%
			}
		%>
		</td>
		</tr>
	<tr height="20"/>
	<tr>
   		<td class="cell-c"><input type=button class="myButton" value="���" OnClick="window.location='soDtl.jsp?mode=C&pg=<%=pg%>'"></td>
	</tr>


</tbody>
</table>

</center>
</body>
</html>