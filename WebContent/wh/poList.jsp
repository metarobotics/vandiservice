
<%@ page contentType="text/html;charset=euc_kr" %>
<% request.setCharacterEncoding("euc-kr"); %>


<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>

<jsp:include page = "top.jsp"/>
<jsp:useBean id="dao" class="wh.OrderPDAO"/>

<%	
	//int total = dao.countOrderP();

	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;
	int whNo =  (Integer)session.getAttribute("whNo");
	
	ArrayList<OrderP> alist = null;
	if(authLvl.equals("S")) // super
		alist = dao.getOrderPList();
	else
		alist = dao.getOrderPList(whNo);
	
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
	   <div class="table-title"><h1>���Ÿ��</h1></div>

<table width="600" border="1">
<tr class="header">
	<th width="18%" class="text-center">�ֹ���ȣ</th>
	<th width="18%" class="text-center">�ֹ�����</th>
	<th width="20%" class="text-center">���񽺼���</th>
	<th width="17%" class="text-center">�հ�ݾ�</th>
	<th width="15%" class="text-center">����</th>
	<th width="12%" class="text-center">�԰�ó��</th>
</tr>
<tbody class="table-hover">
<%
	if(total==0) {
%>
		<tr class="row">
	 	   <td colspan="6" class="cell-c">��ϵ� ������ �����ϴ�.</td>
		</tr>
	 <%
	 	} else {
	 		for(int i=ROWSIZE*(pg-1); i<end;i++){
				OrderP orderP = alist.get(i);
%>

	<tr class="row">
	<td class="cell-c"><a href="poDtl.jsp?mode=R&orderNo=<%=orderP.getOrderNo()%>&pg=<%=pg%>"><%= MrUtil.getPOrderNoStr(orderP.getOrderNo()) %></a></td>
	<td class="cell-c"><%=orderP.getOrderDt()%></td>
	<td class="cell-c"><%=orderP.getWhNm()%></td>
	<td class="cell-r"><%=MrUtil.FormatCurrentDisplay(orderP.getTotalAmt(), orderP.getCurCd()) %></td>
	<td class="cell-c"><%=orderP.getStatusNm()%></td>
	<td class="cell-c"><% if(!orderP.getStatusCd().equals("10")) {%>
						<a href="poRcvList.jsp?mode=R&orderNo=<%=orderP.getOrderNo()%>&pg=<%=pg%>"><%= orderP.getRcvCnt() %>��</a>
						<% } else {%>
						<% }%>
	</td>
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
			[<a href="poList.jsp?pg=1">����</a>]
			[<a href="poList.jsp?pg=<%=startPage-1%>">��</a>]
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
			[<a href="poList.jsp?pg=<%=endPage+1%>">��</a>]
			[<a href="poList.jsp?pg=<%=allPage%>">����</a>]
		<%
			}
		%>
		</td>
		</tr>
	<tr height="10"></tr>
	<tr>
   		<td align="center"><input type=button class="dtlBtn" value="���" OnClick="window.location='poDtl.jsp?mode=C&pg=<%=pg%>'"></td>
  </tr>
</table>

</center>
</body>
</html>