<%@ page language="java" contentType="text/html;charset=EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import="java.sql.*"%><!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="java.util.*"%>
<%@ page import="wh.*"%>
<jsp:useBean id="mrDao" class="wh.MrDAO" />
<jsp:useBean id="itemDao" class="wh.ItemDAO" />
<jsp:useBean id="orderPDao" class="wh.OrderPDAO" />

<%
String mode = request.getParameter("mode");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�԰�ó��</title>
<link rel="stylesheet" href="../css/vandiservice.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>

<%
	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;
	int userWhNo =  (Integer)session.getAttribute("whNo");
	String userWhNm =  (String)session.getAttribute("whNm");
	if(userWhNm == null){
		out.print("userWhNm null");
		return;
	}
	String userWhId =  (String)session.getAttribute("whId");

	//out.print("[ "+userWhId+" ]");

	String writeMode;
	if (mode.equals("C"))
		writeMode = "C";
	else // R
		writeMode = "U";

	int orderNo = 0;
	int rcvSeq = 0;
	
	String orderDt = "";
	String rcvDt = "";
	int whNo = 0;
	String whNm = "";
	String statusCd = "";
	//int subtotal = 0;
	//int tax = 0;
	float totalAmt = 0;
	String insertUserId = "";

	//ArrayList<OrderPItem> orderPItemList = null;
	ArrayList<Item> itemList = null;
	OrderPRcv orderPRcv = null;
	//ArrayList<OrderPRcvItem> orderPRcvItemList = null;
	
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
		
		//orderPItemList = orderPDao.getOrderPItemList(orderNo);
		
	}

	if(mode.equals("R")){
		rcvSeq = Integer.parseInt(request.getParameter("rcvSeq"));
		orderPRcv = orderPDao.getOrderPRcvInfo(orderNo, rcvSeq);
		rcvDt = orderPRcv.getRcvDt();
		itemList = itemDao.getOrderPItemList(orderNo, rcvSeq);
//		orderPRcvItemList = orderPDao.getOrderPRcvItemList(orderNo, rcvSeq);
	}
	else //U
	{
		itemList = itemDao.getOrderPItemList(orderNo);
	}
	
	if(itemList == null)
	{
		out.print("itemList null");
		return;
	}
	
	int itemLength = itemList.size();

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
			
<%
			if (itemList != null) {
				int size = itemList.size();
				Item item = null;

				for (int j = 0; j < size; j++) {
					item = itemList.get(j);
					int itemId = item.getItemNo();
					int orderPItemCnt = item.getOrderItemCnt();
					int itemRcvCnt = item.getItemNewRcvCnt();
%>
			
					// ���� setting
					var idList = document.getElementsByName("selItem");
					var cntList = document.getElementsByName("txtCnt");
					var rcvCntList = document.getElementsByName("txtRcvCnt");
					var trList = document.getElementsByName("trItem");
					
					var tot = idList.length;
					
					for (i = 0; i < tot; i++) {
						
						if(idList[i].value == '<%=itemId%>')
						{
						
							cntList[i].value = '<%=orderPItemCnt%>';
							rcvCntList[i].value = '<%=itemRcvCnt%>';
						}
					}		
<%
				}//for
			}//if orderPItemList
%>
		
			
		}//if(mode == "R")

	}//setPage
	         
	function setSelectResultRcv()
	{

		var str = "";
		var cnt = 0;
	    
	    var idList = document.getElementsByName("selItem");
	    var cntList = document.getElementsByName("txtRcvCnt");
	    
	    var tot = idList.length;
	    
	    var tmpCurCd = "";
	    
	    for (i = 0; i < tot; i++) {
	    	
	    	if(!isNull(cntList[i]) && cntList[i].value != 0)
	    	{
		    	// �԰�ó�� ���� setting
	    		if(str == "")
	    			str = idList[i].value + ":" +  cntList[i].value;
	    		else
	    			str = str + "/" + idList[i].value + ":" +  cntList[i].value; // seperator | �� ����ϸ� �ȵ�. �����Ǵ��� split�� �ȵ� 
	    	}
	    }
	    
		document.getElementById("rcvStr").value = str;

	}
	

	function poRcvCheck() {
		
		if(document.getElementById("rcvStr").value == '')
		{
			alert("�԰�ǰ�� �Է³����� �����ϴ�.");
			return false;
		}
		
		var msg = "";
		var mode = '<%=mode%>';
		if(mode == "C")
			msg = "�԰�ó�� �Ͻðڽ��ϱ�?";
		else // "R"
			msg = "�԰����� �����Ͻðڽ��ϱ�?";
		
		if(confirm(msg))
			{
			//alert(document.getElementById("orderNo").value);
			return true;
			}
		else
			return false;
	}


	function confirmDelete() {
		if(confirm('�԰����� �����Ͻðڽ��ϱ�?'))
		{
			moveTo('poRcvWrite.jsp?mode=D&orderNo=<%=orderNo%>&rcvSeq=<%=rcvSeq%>');
		}
	}
	
	
</script>
</head>

<body>
	<center>

	<!-- TITLE -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->
   		<div class="table-title"><h1>�԰�ó��</h1></div>
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
					<input type=hidden name=orderNo id=orderNo value='<%= orderNo %>' >
					<input type=hidden name=rcvSeq id=rcvSeq >
	<% } else if(mode.equals("R")) { %>
					<input type=text size=10 disabled value='<%= MrUtil.getPOrderNoStr(orderNo) %>'  style="border: 0px; text-align: left;" >
					<input type=hidden name=orderNo id=orderNo value='<%= orderNo %>' >
					<input type=hidden name=rcvSeq id=rcvSeq value='<%= rcvSeq %>' >
	<% } %>
 
					</td>
					<td width="35%" class="cell-l"/>
					<td width="15%" class="cell-l"/>
				</tr>
				<tr class="row_bottom_only">
					<td width="15%" class="cell-hd">�԰�����</td>
					<td width="35%" class="cell-l">
					
					
	<% if(mode.equals("C")) { %>   
					<input type=date name=rcvDt id=rcvDt size=10 value='<%= MrUtil.getDateStr() %>' >
	<% } else if(mode.equals("R")) { %>
					<input type=date name=rcvDt id=rcvDt size=10 value='<%= rcvDt %>' >
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
					
					<td width="35%" class="cell-r"></td>
					<td width="15%" class="cell-l">
						</td>

				</tr>
				
				<tr height="20" />
			</table>

	<!-- NOTE -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->
		<h3>Note</h3>
		<table border="0" width=600>
			
	   	<% if(mode.equals("C")) { %>
			<tr><td align="center"><textarea rows="3" cols="95" name="note" placeholder="�԰� ���� Ư�̻����� �Է��մϴ�."></textarea></td></tr>
	   	<% } else if(mode.equals("R")) { %>
			<tr><td align="center"><textarea rows="3" cols="95" name="note"><%= orderPRcv.getNote() %></textarea></td></tr>
	   	<% } %>
			        
			<tr height="15"/>
		</table>


	<!-- ORDER ITEM -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

			<% float nTotalAmount = 0; %>
			<table id="order_item_table" border=0 width=600>
				<thead>
					<tr>
						<th width="50%" nowrap>ǰ��</th>
						<th width="10%" class="cell-r">�������</th>
						<th width="10%" class="cell-r">�ֹ�����</th>
						<th width="10%" class="cell-r">�԰�</th>
						<th width="10%" class="cell-r">���԰�</th>
						<th width="10%" class="cell-r">�԰�ó��</th>
					</tr>
				</thead>
				<tbody id="p_item">

				<%
					for (int i = 0; i < itemLength; i++) {
						Item item = itemList.get(i);
						
				%>

						<tr id="order_item_info">
							<td><input type=hidden name="selItem" value=<%=item.getItemNo()%>>
							<!-- <select name="selItem" disabled>
									<option value=<%=item.getItemNo()%>> </option></select>-->
									[<%=item.getItemId()%>]&nbsp;<%=item.getItemNm()%>
							</td>
							
							
								<td class="cell-r"><input type="text" name="itemCnt" size=3
									style="border: 0px; text-align: right;" value='<%=item.getWhItemCnt()%>'
									disabled /></td>
								<td class="cell-r"><input type="text" name="txtCnt" size=3
									style="text-align: right" readonly value='<%=item.getOrderItemCnt()%>' />
								</td>

								<td class="cell-r"><input type="text" name="itemRcvCnt" size=3
									style="border: 0px; text-align: right;" value='<%=item.getItemRcvCnt()%>'
									disabled /></td>
								<td class="cell-r"><input type="text" name="itemNoRcvCnt" size=3
									style="border: 0px; text-align: right;" value='<%=item.getItemNoRcvCnt()%>'
									disabled /></td>
									
								<td class="cell-r"><input type="text" name="txtRcvCnt" size=3
									style="text-align: right" onchange="setSelectResultRcv();"
									onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" />
								</td>

									
						</tr>
				<%
					} //for (int i = 0; i < itemLength; i++) {
				%>

				</tbody>
			</table>
			
			<input type="hidden" id="rcvStr" name="rcvStr" />
			
			<br>
			<table>
				<tr height="40" valign="bottom">
					<td colspan="2">
						<div align="center">
						
	     				<% if(mode.equals("C")) { %>
	     					<input type="submit" class="dtlBtn" value="���">&nbsp;
	     				<% }else if(mode.equals("R") && (authLvl.equals("S") || authLvl.equals("A"))) { %>
	     					<input type="submit" class="dtlBtn" value="����">&nbsp;
	     					<input type="button" class="dtlBtn" value="����" onclick="confirmDelete();">&nbsp; 
	     				<% } %>
	     					<input type="button" class="dtlBtn" value="�ݱ�" onclick="window.close();">&nbsp; 
	
						</div>
					</td>
				</tr>
			</table>
		</form>
	</center>
	<script>
		setPage();
		setSelectResultRcv();
	</script>
	
</body>
</html>