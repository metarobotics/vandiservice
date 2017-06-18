<%@ page language="java" contentType="text/html;charset=EUC-KR"%>
<%
	request.setCharacterEncoding("EUC-KR");
%>

<%@ page import="java.sql.*"%>
<!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="wh.*"%>
<%@ page import="java.util.*"%>

<% 

String mode = request.getParameter("mode");

if(!mode.equals("V")) { %>
<jsp:include page = "top.jsp"/>
<% } %>


<jsp:useBean id="mrDao" class="wh.MrDAO" />
<jsp:useBean id="itemDao" class="wh.ItemDAO" />
<jsp:useBean id="orderPDao" class="wh.OrderPDAO" />




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Transfer Order</title>
<link rel="stylesheet" href="../css/vandiservice.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="../js/chkValid.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>


<%
	String pg = request.getParameter("pg");

	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;
	int userWhNo =  (Integer)session.getAttribute("whNo");
	String userWhNm =  (String)session.getAttribute("whNm");
	if(userWhNm == null)
		return;
	String userWhId =  (String)session.getAttribute("whId");

	//out.print("[ "+userWhId+" ]");

	String writeMode;
	if (mode.equals("C"))
		writeMode = "C";
	else // R
		writeMode = "U";

	int orderNo = 0;
	String orderDt = "";
	int whNo = 0;
	String whNm = "";
	String statusCd = "";
	//int subtotal = 0;
	//int tax = 0;
	float totalAmt = 0;
	String insertUserId = "";

	ArrayList<OrderItem> orderItemList = null;
	ArrayList<Item> itemlist = null;
	ArrayList<OrderPRcv> orderPRcvList = null;
	ArrayList<OrderPRcvItem> orderPRcvItemList = null;
	
	OrderP orderP = null; 
	
	orderNo = Integer.parseInt(request.getParameter("orderNo"));

	orderP = orderPDao.getOrderPInfo(orderNo);

	if (orderP != null) {
		//out.print("orderP not null");

		orderDt = orderP.getOrderDt();
		whNo = orderP.getWhNo();
		whNm = orderP.getWhNm();
		statusCd = orderP.getStatusCd();
		//subtotal = orderP.getSubtotal();
		//tax = orderP.getTax();
		totalAmt = orderP.getTotalAmt();
		insertUserId = orderP.getInsertUserId();
		
		orderItemList = orderPDao.getOrderItemList(orderNo);
		
		if(orderP.getStatusCd().equals("10")) //�ۼ���
			itemlist = itemDao.getItemList(whNo);
		else
			itemlist = itemDao.getOrderPItemList(orderNo);
	}

	if(itemlist == null)
		return;
	int itemLength = itemlist.size();
	
	orderPRcvList = orderPDao.getOrderPRcvList(orderNo);
	//orderPRcvItemList = orderPDao.getOrderPRcvItemList(orderNo);

	ArrayList<Wh> whlist = mrDao.getWhList();
	int whLength = whlist.size();

	String orderStr;
%>

<script type="text/javascript">

	var mode = '<%=mode%>';
	var curCd = "";
	
	//alert(mode);

	function setPage()
	{
		if(mode == "R")
		{
		
			//document.getElementById("userId").value = '<%=insertUserId%>';
			
			document.getElementById("whNo").value = '<%=whNo%>';
			
		}//if(mode == "R")
		
		if('<%= authLvl %>' == 'S')
		{
			document.getElementById('whNo').disabled='';
		}
	}//setPage
	
	function reload()
	{
		document.location.href='poRcvList.jsp?mode=R&orderNo=<%=orderNo%>&pg=<%=pg%>';
	}
	
	// �԰�Ϸ�
	function confirmFinish() {
		if(confirm('�Ϸ�ó�� �Ͻðڽ��ϱ�?'))
		{
			moveTo('poWrite.jsp?mode=F&orderNo=<%=orderNo%>');
		}
	}
	
	
</script>
</head>

<body>
	<center>

	<!-- TITLE -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->
   		<div class="table-title"><h1>�԰�ó�����</h1></div>
	<!-- FORM -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

		<form name="form_order" method="post"
			action="poRcvWrite.jsp?mode=<%=writeMode%>"
			onsubmit="return poRcvCheck();">

	<!-- ORDER INFO -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

			<table width="600">
				<tr class="row_bottom_only">
					<td width="15%" class="cell-hd">�ֹ���ȣ</td>
					<td width="35%" class="cell-l">
 
 	<% if(mode.equals("C")) { %>   
					<input type=text size=10 disabled value='' style="border: 0px; text-align: left;" >
					<input type=hidden name=orderNo id=orderNo >
	<% } else if(mode.equals("R")) { %>
					<input type=text size=10 disabled value='<%= MrUtil.getPOrderNoStr(orderNo) %>'  style="border: 0px; text-align: left;" >
					<input type=hidden name=orderNo id=orderNo value='<%= orderNo %>' >
	<% } else if(mode.equals("V")) { %><%= MrUtil.getPOrderNoStr(orderNo) %>
	<% } %>
 
					</td>
					<td width="35%" class="cell-l"/>
					<td width="15%" class="cell-l"/>
				</tr>
				<tr class="row_bottom_only">
					<td width="15%" class="cell-hd">�ֹ�����</td>
					<td width="35%" class="cell-l">
					
					
	<% if(mode.equals("C")) { %>   
					<input type=date name=orderDt id=orderDt size=10 value='<%= MrUtil.getDateStr() %>' >
	<% } else if(mode.equals("R")) { %>
					<input type=date name=orderDt id=orderDt size=10 value='<%= orderDt %>' >
	<% } else if(mode.equals("V")) { %><%= orderDt %>
	<% } %>   		

					</td>
					
					<td width="35%" class="cell-r"></td>
					<td width="15%" class="cell-l">
						</td>
					
				</tr>
				<tr class="row_bottom_only">
					<td width="15%" class="cell-hd">�ۼ���</td>
					<td width="35%" class="cell-l">
						<% if (mode.equals("C")) { %> <%=(String) session.getAttribute("userId")%> 
						<% } else { %> <%=insertUserId%> 
						<% }%>
					</td>
					
					<td width="35%" class="cell-r">���͸�</td>
					<td width="15%" class="cell-l">
					
     <% if(mode.equals("V")) { %><%= whNm %>
     				
     <% } else { %>
					
						<select id=whNo name=whNo disabled>
							<option value=''>����</option>
							<%
								for (int i = 0; i < whLength; i++) {
									Wh wh = whlist.get(i);
							%>
							<option value=<%=wh.getWhNo()%>><%=wh.getWhNm()%></option>
							<%
								}
							%>
						</select>
     <% } %>
					</td>
	
				</tr>
				
				<tr height="20" />
			</table>


	<!-- RCV LIST -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

		<table width="600" border="1">
		<tr class="header">
			<th width="20%" class="text-center">SEQ</th>
			<th width="20%" class="text-center">�԰�����</th>
			<th width="60%" class="text-center">Note</th>
		</tr>
		<tbody class="table-hover">
		<%
			if(orderPRcvList.size()==0) {
		%>
				<tr class="row">
			 	   <td colspan="6" class="cell-c">�԰�ó�� ������ �����ϴ�.</td>
				</tr>
		
	 <%
	 	} else {
	 		for(int i=0; i<orderPRcvList.size();i++){
				OrderPRcv rcvInfo = orderPRcvList.get(i);
%>
		
			<tr class="row">
				<td class="cell-c"><%=rcvInfo.getRcvSeq()%></td>
				<td class="cell-c"><u><font color="blue"><a style="cursor:hand" onclick="window.open('poRcvDtl.jsp?mode=R&orderNo=<%=orderP.getOrderNo()%>&rcvSeq=<%=rcvInfo.getRcvSeq()%>');"><%= rcvInfo.getRcvDt() %></a></font></u></td>
				<td class="cell-l"><%=rcvInfo.getNote()%></td>
			</tr>
		
<%

	}}

%>
		</tbody>
		</table>

		<br>
			<table>
				<tr height="40" valign="bottom">
					<td colspan="2">
						<div align="center">
							<% if (mode.equals("R") && orderP.getStatusCd().equals("20") && userWhId.equals("mr")) { // �ۼ��Ϸ��̰�  MR ������ ��� �԰�ó�� ���� %>
									<input type="button" class="dtlBtn" value="�԰���" onclick="window.open('poRcvDtl.jsp?mode=C&orderNo=<%=orderNo%>');">&nbsp;
							<% } %> 
							<% if (mode.equals("R") && orderP.getStatusCd().equals("30") && userWhId.equals("mr")) { // �԰�ó���̰�  MR ������ ��� �԰�Ϸ� ó�� ���� %>
									<input type="button" class="dtlBtn" value="�԰�Ϸ�" onclick="confirmFinish();">&nbsp;
							<% } %> 
							
									<input type="button" class="dtlBtn" value="���Ÿ��" onclick="moveTo('poList.jsp?pg=<%=pg%>');">
						</div>
					</td>
				</tr>
			</table>
		</form>
	</center>
	<script>
		setPage();
	</script>
	
</body>
</html>