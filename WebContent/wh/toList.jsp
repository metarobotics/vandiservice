<%@ page language="java" contentType="text/html;charset=EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="mrDao" class="wh.MrDAO" />
<jsp:useBean id="dao" class="wh.OrderTDAO"/>

<jsp:include page = "top.jsp"/>

<%	
	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;
	int whNo =  (Integer)session.getAttribute("whNo");
	
	String strParamWhNo = request.getParameter("whNo");
	int intParamWhNo = 0;
	if(strParamWhNo != null){
		intParamWhNo = Integer.parseInt(strParamWhNo);
	}
//System.out.println(strParamWhNo + " " + intParamWhNo);

	ArrayList<OrderT> alist = null;
	
	ArrayList<Wh> whlist = mrDao.getWhList("CTR");
	int whLength = whlist.size();
	
	boolean isSuper = false;
	if(authLvl.equals("S"))
	{
		isSuper = true;
	}
	
	if(isSuper)
	{
		if(intParamWhNo == 0)
		{
			alist = dao.getOrderTList();
		}
		else
		{
			alist = dao.getOrderTList(intParamWhNo);
		}
	}
	else
	{
		alist = dao.getOrderTList(whNo);
	}
	
	int size = alist.size();
	int size2 = size;
	
	final int ROWSIZE = 50;
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
</head>

<body>
<center>
<div class="table-title"><h1>T.O.(Transfer order) ���</h1></div>
<table>
<tr>
<td>
<h2>�ֹ����� ���ǻ���</h2>
�ֹ��Ŀ� ���翡 ������ �ϰ�, �������� ��û�Ͻø� �˴ϴ�.
<br>
�Աݰ��� : ���� 301-0212-5189-11 ������: ��Ÿ�κ�ƽ�� �ֽ�ȸ��
</td>
</tr>
<tr height="30"/>
</table>

<table>
<tr>
<% if(isSuper) { %>
	<td width="50%" class="cell-l">���񽺼��� &nbsp;
							<select name=srcWh id=srcWh onchange="onChangeCenter()">
								<option value=''>��ü</option>
								<%
									for (int i = 0; i < whLength; i++) {
										Wh wh = whlist.get(i);
										
										if(intParamWhNo != 0 && intParamWhNo == wh.getWhNo()) {					
					 			%>
											<option value=<%=wh.getWhNo()%> selected><%=wh.getWhNm()%></option>
								<% 		} else { %>  				    
											<option value=<%=wh.getWhNo()%>><%=wh.getWhNm()%></option>
								<%
										}
									}
					 			%>
						</select>
	</td>
<% } %>
	<td class="cell-r">total : <%= size %></td>
</tr>
<tr height="10"></tr>
</table>

<table width="600" border="1">
<tr class="header">
	<th width="15%" class="text-center">�ֹ���ȣ</th>
	<th width="15%" class="text-center">�ֹ�����</th>
	<th width="20%" class="text-center">�����</th>
	<th width="20%" class="text-center">�����</th>
	<th width="20%" class="text-center">�հ�ݾ�</th>
	<th width="10%" class="text-center">����</th>
</tr>
<tbody class="table-hover">
<%
	if(size==0) {
%>
		<tr class="row">
	 	   <td colspan="6" class="cell-c">��ϵ� ������ �����ϴ�.</td>
		</tr>
	 <%
	 	} else {
	 		for(int i=ROWSIZE*(pg-1); i<end;i++){
				OrderT orderT = alist.get(i);
				//System.out.println(orderT.getStatusNm());
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
			[<a href="toList.jsp?pg=1">����</a>]
			[<a href="toList.jsp?pg=<%=startPage-1%>">��</a>]
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
			[<a href="toList.jsp?pg=<%=endPage+1%>">��</a>]
			[<a href="toList.jsp?pg=<%=allPage%>">����</a>]
		<%
			}
		%>
		</td>
		</tr>
	<tr height="10"></tr>
	<tr>
   		<td align="center"><input type=button class="dtlBtn" value="���" OnClick="window.location='toDtl.jsp?version=1&mode=C&pg=<%=pg%>'"></td>
  </tr>
</table>

</center>

<script>
function onChangeCenter() {
	var x = document.getElementById("srcWh").value;
	if(x > 0)
	{
		window.location='toList.jsp?whNo='+ x;
	}
	else
	{
		window.location='toList.jsp';
	}
		
}

</script>

</body>
</html>