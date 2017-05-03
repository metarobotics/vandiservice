<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>


<jsp:useBean id="dao" class="wh.ItemDAO"/>

<%	
	int total = dao.countItem();
	ArrayList<Item> alist = dao.getItemList();
	int size = alist.size();
	int size2 = size;
	
	final int ROWSIZE = 4;
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
<title>���� ���</title>
<link rel="stylesheet" href="../css/mr.css">
</head>
<body translate="no" >
<div class="table-title">
<h3>���� ���</h3>
</div>

<table class="table-fill" width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td class="cell-r">total : <%= size %></td></tr></table>
<table class="table-fill" border="1">
<tr class="header">
	<th width="10%" class="text-center">ItemNo</th>
	<th width="40%" class="text-center">ǰ���</th>
	<th width="20%" class="text-center">�����</th>
	<th width="30%" class="text-center">����Ͻ�</th>
</tr>
<tbody class="table-hover">
<%
	if(total==0) {
%>
		<tr>
	 	   <td colspan="4" class="text-center">��ϵ� ǰ���� �����ϴ�.</td>
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
<td class="cell-c"><a href="itemView.jsp?idx=<%=item.getItemNo()%>&pg=<%=pg%>"><%=item.getItemNm()%></td>
<td class="cell-c"><%=item.getInsertUserNo()%></td>
<td class="cell-c"><%=item.getInsertDatetime().toString()%></td>
</tr>

<%

	}}

%>

</table>
<br>
<table class="table-fill" width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr>
	<td align="center">
		<%
			if(pg>BLOCK) {
		%>
			[<a href="itemList.jsp?pg=1">����</a>]
			[<a href="itemList.jsp?pg=<%=startPage-1%>">��</a>]
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
			[<a href="itemList.jsp?pg=<%=endPage+1%>">��</a>]
			[<a href="itemList.jsp?pg=<%=allPage%>">����</a>]
		<%
			}
		%>
		</td>
		</tr>
	<tr align="right">
   		<td ><input type=button value="�۾���" OnClick="window.location='write.jsp'"></td>
  </tr>


</tbody>
</table>

</body>
</html>