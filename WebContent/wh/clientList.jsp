<%@ page contentType="text/html;charset=euc_kr" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>

<jsp:include page = "top.jsp"/>

<jsp:useBean id="dao" class="wh.ClientDAO"/>

<%	
	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;
	//if(authLvl.equals("S") || authLvl.equals("A")) // ���,���� ������

	//int total = dao.countClient();
	ArrayList<Client> alist = dao.getClientList();
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

<body translate="no" >
<center>
   <div class="table-title"><h1>�����</h1></div>

<table border="1" width="600">
<tr>
	<th width="15%" class="text-center">����ȣ</th>
	<th width="15%" class="text-center">����</th>
	<th width="50%" class="text-center">������</th>
	<th width="20%" class="text-center">�ŷ��Ǽ�</th>
</tr>
<%
	if(total==0) {
%>
		<tr class="row">
	 	   <td colspan="6" class="cell-c">��ϵ� ������ �����ϴ�.</td>
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
<td class="cell-c"><%=client.getDealCnt()%>��</td>
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
			[<a href="clientList.jsp?pg=1">����</a>]
			[<a href="clientList.jsp?pg=<%=startPage-1%>">��</a>]
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
			[<a href="clientList.jsp?pg=<%=endPage+1%>">��</a>]
			[<a href="clientList.jsp?pg=<%=allPage%>">����</a>]
		<%
			}
		%>
		</td>
		</tr>
		<tr height="10"/>
	<tr align="center">
	
		<%
		if(authLvl.equals("S") || authLvl.equals("A")) { // ���,���� ������
		%>
	   		<td ><input type=button class="myButton" value="���" OnClick="window.location='clientDtl.jsp?mode=C&pg=<%=pg%>'"></td>
	   	<%} else { %>
	   	<%} %>
	   		
  </tr>


</tbody>
</table>

</center>
</body>
</html>