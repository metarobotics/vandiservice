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
	
	OrderP orderP = null; 
	
	if (mode.equals("R") || mode.equals("V")) {
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
			
			itemlist = itemDao.getItemList(whNo);
		}

		//		int size = orderItemList.size();		
	}
	else // mode C
	{
		whNo = userWhNo;
		whNm = userWhNm;
		itemlist = itemDao.getItemList(whNo);
	}

	if(itemlist == null)
		return;
	int itemLength = itemlist.size();
	

	ArrayList<Wh> whlist = mrDao.getWhList();
	int whLength = whlist.size();

	String orderStr;
%>

<script type="text/javascript">

	var mode = '<%=mode%>';
	var curCd = "";
	
	//alert(mode);

	function poWriteCheck() {
		
		if(isNull(document.getElementById("whNo")))
		{
			alert('������� �����ϼ���.');
			return false;
		}
		else if(document.getElementById("tdTotalAmt").innerHTML  == "" || document.getElementById("tdTotalAmt").innerHTML  == 0)
		{
			alert("ǰ�� �Է� ������ �����ϴ�.");
			return false;
		}
		
		document.getElementById('whNo').disabled='';
		
		return true;
	}


	function setPage()
	{
		if(mode == "R")
		{
		
			//document.getElementById("userId").value = '<%=insertUserId%>';
			
			document.getElementById("whNo").value = '<%=whNo%>';
			//document.getElementById("destWh").disabled = true;
			
			//document.getElementById("tdSubtotal").innerHTML = '';
			//document.getElementById("tdTax").innerHTML = '';
			document.getElementById("tdTotalAmt").innerHTML = '<%=totalAmt%>';
			//document.getElementById("tdTotalAmtP").innerHTML = '<%=totalAmt%>';
			
<%
			if (orderItemList != null) {
				int size = orderItemList.size();
				OrderItem orderItem = null;

				for (int j = 0; j < size; j++) {
					orderItem = orderItemList.get(j);
					int itemId = orderItem.getItemNo();
					int itemCnt = orderItem.getItemCnt();
%>
			
					// ���� setting
					var idList = document.getElementsByName("selItem");
					var priceList = document.getElementsByName("txtPrice");
					var cntList = document.getElementsByName("txtCnt");
					var trList = document.getElementsByName("trItem");
					
					var tot = idList.length;
					
					for (i = 0; i < tot; i++) {
						
						if(idList[i].value == '<%=itemId%>')
						{
						
							cntList[i].value = '<%=itemCnt%>';
						}
					}		
<%
				}//for
			}//if orderItemList
%>
			
/*
			var tbl = document.getElementById("order_item_table");
			var numRows = tbl.rows.length;
			
			for (var i = 1; i < numRows; i++) {
			    var ID = tbl.rows[i].id;
			    if(ID != "order_item_info")
			    	continue;
			    
			    alert(tbl.rows[i].find("input"));
			    
			    tbl.rows[i].find("input").each(function(){
			    	alert(this.value);
			    })
			
			    var cells = tbl.rows[i].find("input");
			    
			    alert(cells[0].innerHTML);
			    
			    if(cells[2].value == 0)
			    	tbl.rows[i].style.display = none;
			    else
			    	tbl.rows[i].style.display = visible;
			}
*/
			
		}//if(mode == "R")
		else { //"C"
			document.getElementById("whNo").value = '<%= userWhNo %>'; // ����� wh
		}	
		
		if('<%= authLvl %>' == 'S')
		{
			document.getElementById('whNo').disabled='';
		}
		/*else{
			alert('2');
			document.getElementById('destWh').setAttribute('disabled');
		}*/
	}//setPage
	
	
	function setSelectResult()
	{
		var str = "";
		var cnt = 0;
	    var subtotal = 0;
	    
	    var idList = document.getElementsByName("selItem");
	    var priceList = document.getElementsByName("txtPrice");
	    var curCdList = document.getElementsByName("txtCurCd");
	    var cntList = document.getElementsByName("txtCnt");
	    
	    var tot = idList.length;
	    
	    backOrderFg = false;
	    var tmpCurCd = "";
	    
	    for (i = 0; i < tot; i++) {
	    	
	    	if(!isNull(cntList[i]) && cntList[i].value != 0)
	    	{
	    		// ȭ�� ���ϼ� üũ 
		    	if(tmpCurCd == '') {
		    		tmpCurCd = curCdList[i].value;
		    		curCd = tmpCurCd;
		    	} else if(tmpCurCd != curCdList[i].value) {
		    		alert("���� ȭ�� ǰ�� �ֹ� �����մϴ�.");
		    		subtotal = 0;
		    		curCd = "";
		    		break;
		    	}
	    		
		    	// �ֹ����� setting
	    		if(str == "")
	    			str = idList[i].value + ":" +  cntList[i].value + ":" +  priceList[i].value;
	    		else
	    			str = str + "/" + idList[i].value + ":" +  cntList[i].value + ":" +  priceList[i].value; // seperator | �� ����ϸ� �ȵ�. �����Ǵ��� split�� �ȵ� 
	    		subtotal = subtotal + parseInt(priceList[i].value) * parseInt(cntList[i].value);
	    	}
	    }
	    
		//document.getElementById("tdSubtotal").innerHTML = subtotal;
		//document.getElementById("tdTax").innerHTML = parseInt(subtotal * 0.1);
		document.getElementById("tdTotalAmt").innerHTML = subtotal + " " + curCd; //parseInt(subtotal * 1.1);
		
		//document.getElementById("subtotal").value = subtotal;
		//document.getElementById("tax").value = parseInt(subtotal * 0.1);
		document.getElementById("totalAmt").value = subtotal; //parseInt(subtotal * 1.1);
		
		document.getElementById("curCd").value = curCd; //parseInt(subtotal * 1.1);

		document.getElementById("orderStr").value = str;
	}
	

	function confirmDelete() {
		if(confirm('�����Ͻðڽ��ϱ�?'))
		{
			moveTo('poWrite.jsp?mode=D&orderNo=<%=orderNo%>');
		}
	}
	
	// �ۼ��Ϸ�
	function confirmAccept() {
		if(confirm('�ۼ��Ϸ� �Ŀ��� ����/������ �Ұ����մϴ�. ó���Ͻðڽ��ϱ�?'))
		{
			moveTo('poWrite.jsp?mode=A&orderNo=<%=orderNo%>');
		}
	}
		
	// �԰�ó��
	function confirmGetItem() {
		if(confirm('�԰�ó�� �Ͻðڽ��ϱ�?'))
		{
			moveTo('poWrite.jsp?mode=G&orderNo=<%=orderNo%>');
		}
	}
		
	// �԰�Ϸ�
	function confirmFinish() {
		if(confirm('�Ϸ�ó�� �Ͻðڽ��ϱ�?'))
		{
			moveTo('poWrite.jsp?mode=F&orderNo=<%=orderNo%>');
		}
	}
		
	function printWindow() {
		
	    var printContents = document.getElementById("printArea").innerHTML;
	    var originalContents = document.body.innerHTML;
	     
	   	document.body.innerHTML = printContents;
	    window.print();
	    document.body.innerHTML = originalContents;
	}
			
</script>
</head>

<body>
<div id="printArea">
	<center>

	<!-- TITLE -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->
	   	<% if(mode.equals("V")) { %>
	   		<div class="table-title"><h1>���ſ�û��</h1></div>
	   	<% } else { %>
	   		<div class="table-title"><h1>��������</h1></div>
	   	<% } %>

	<!-- FORM -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

		<form name="form_order" method="post"
			action="poWrite.jsp?mode=<%=writeMode%>"
			onsubmit="return poWriteCheck();">

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
					<input type=text size=10 disabled value='<%= MrUtil.getTOrderNoStr(orderNo) %>'  style="border: 0px; text-align: left;" >
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

	<!-- ORDER ITEM -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

			<% float nTotalAmount = 0; %>
			<table id="order_item_table" border=0 width=600>
				<thead>
					<tr>
						<% if(mode.equals("V")) { %>
						<th width="70%" nowrap>ǰ��</th>
						<th width="10%" class="cell-r">�ǸŰ���</th>
						<th width="10%" class="cell-r">����</th>
						<th width="10%" class="cell-r">���� ���</th>
						<% } else {%>
						<th width="60%" nowrap>ǰ��</th>
						<th width="10%" class="cell-r">�ǸŰ���</th>
						<th width="10%" class="cell-c">ȭ��</th>
						<th width="10%" class="cell-r">����</th>
						<th width="10%" class="cell-r">���� ���</th>
						<% } %>
					</tr>
				</thead>
				<tbody id="p_item">

				<%
					for (int i = 0; i < itemLength; i++) {
						Item item = itemlist.get(i);
						
						// View Only
						//////////////////////////////////////////////////////////////////////////
						int nOrderItemCnt = 0;
						if(mode.equals("V")) 
						{
							for(int j = 0; j < orderItemList.size(); j++)
							{
								OrderItem oItem = orderItemList.get(j); 
								if(item.getItemNo() == oItem.getItemNo()){
									nOrderItemCnt = oItem.getItemCnt();
								}
							}
							
							if(nOrderItemCnt == 0)
								continue;
						}
						//////////////////////////////////////////////////////////////////////////							
				%>

						<tr id="order_item_info">
							<td><input type=hidden name="selItem" value=<%=item.getItemNo()%>>
							<!-- <select name="selItem" disabled>
									<option value=<%=item.getItemNo()%>> </option></select>-->
									[<%=item.getItemId()%>]&nbsp;<%=item.getItemNm()%>
							</td>
							
							<% if(mode.equals("V")) { %>
							
								<td class="cell-r"><%= MrUtil.FormatCurrentDisplay(item.getPrice(), item.getCurCd()) %></td>
								<td class="cell-r"><%=nOrderItemCnt%></td>
								<td class="cell-r"><%= item.getItemCnt() %></td>
								<% nTotalAmount += (float)(item.getPrice())*nOrderItemCnt; %>
	
							<% } else { %>
							
								<td class="cell-r"><input type="text" name="txtPrice" size=6
									style="border: 0px; text-align: right;" value='<%=item.getPrice()%>'
									disabled /></td>
								<td class="cell-c"><input type="text" name="txtCurCd" size=6
									style="border: 0px; text-align: center;" value='<%=item.getCurCd()%>'
									disabled /></td>
								<td class="cell-r"><input type="text" name="txtCnt" size=4
									style="text-align: right" onchange="setSelectResult();"
									onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" />
								</td>
								<td class="cell-r"><input type="text" name="itemCnt" size=4
									style="border: 0px; text-align: right;" value='<%=item.getItemCnt()%>'
									disabled /></td>
									
							<% } //if(!mode.equals("V")) %>
									
						</tr>
				<%
					} //for (int i = 0; i < itemLength; i++) {
				%>

				</tbody>
			</table>
			
	<!-- TOTAL AMOUNT -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

<% if(mode.equals("V")) { %>
		<table border="0" width=600>
			<tr height="30"/>
			<tr class="row_top_only">
				<td align="right" width="100">�հ� : </td>
				<td id="tdTotalAmtP" align="right"><%= MrUtil.FormatCurrentDisplay(nTotalAmount,orderP.getCurCd()) %></td>
			</tr>
<!--  			<tr class="row_top_only">
				<td align="right">�ΰ���ġ�� :</td>
				<td id="tdTax" align="right"><%= MrUtil.FormatCurrentDisplay((int)(nTotalAmount*0.1)) %></td>
			</tr>
			<tr class="row_top_only">
				<td align="right">�Ѿ� :</td>
				<td id="tdTotalAmt" align="right"><%= MrUtil.FormatCurrentDisplay((int)(nTotalAmount*1.1)) %></td>
			</tr>-->
			<tr height="30"/>
		</table>
		<!-- 
		<table border="1" width=600 style="border-color: #C1C3D1;">
			<tr height="30"/>
			<tr class="row_normal">
				<td align="center">
				���� ������ Ȯ���մϴ�
				<br>
				2017��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��
				<br>
				�� �� ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(����)
				</td>
			</tr>
			<tr class="row_normal">
				<td align="left">
				1. ���α��� : ���� ����
				<br>
				2. �Աݰ��� : ���񽺼��ͺ� Ȯ�� ���
				</td>
			</tr>
			<tr class="row_normal">
				<td align="left">
				1. ���� ������ �߸����� ���������Ϸκ��� 30�� �̳� �߻��ϴ� ���� ���ؼ��� ��������/���� �մϴ�.
				<br>
				2. �� �������� 2�θ� �ۼ�, ���� �Ƿ��ڿ��� 1�θ� �����ϰ�, ���񽺼��ʹ� 1�θ� 1�Ⱓ �����մϴ�.
				<br>
				3. ������ �ѱ������Ͼ��ȸ���� ��ǥ�ϴ� ��ޱ����(�������) �ӱ��� �������� �����մϴ�. (34,700��) 
				</td>
			</tr>
		</table>
		 -->
<% } else { %>
			
			<table width="200" height="50" border="0">
				<!--<tr>
					<td align="right" width="100">subtotal :</td>
					<td id="tdSubtotal" align="right"></td>
				</tr>
				 <tr>
					<td align="right">tax :</td>
					<td id="tdTax" align="right"></td>
				</tr> -->
				<tr>
					<td align="right" width="100">total price :</td>
					<td id="tdTotalAmt" align="right"></td>
				</tr>
			</table>
<% } %>

<!--  		<input type="hidden" id="subtotal" name="subtotal" /> 
			<input type="hidden" id="tax" name="tax" />-->	 
			<input type="hidden" id="totalAmt" name="totalAmt" /> 
			<input type="hidden" id="curCd" name="curCd" /> 
			<input type="hidden" id="orderStr" name="orderStr" />
			
			<table>
				<tr height="40" valign="bottom">
					<td colspan="2">
						<div align="center">
							<% if (mode.equals("C")) { %>
									<input type="submit" class="dtlBtn" value="���">&nbsp;
							<% } %> 
							<% if (mode.equals("R") && orderP.getStatusCd().equals("10")){ // �ۼ����� => ���� ���� ���� %>
									<input type="submit" class="dtlBtn" value="����">&nbsp;
									<input type="button" class="dtlBtn" value="����" onclick="confirmDelete();">&nbsp;
		     				<% } %>
		     				<% if(mode.equals("R")){ %>
		     					<input type="button" class="dtlBtn" value="Print" onclick="window.open('poDtl.jsp?mode=V&orderNo=<%=orderNo%>');">&nbsp;
							<% } %> 
							<% if (mode.equals("R") && orderP.getStatusCd().equals("10") && userWhId.equals("mr")) { // �ۼ����̰�  MR ������ ��� �ۼ��Ϸ� ���� %>
									<input type="button" class="dtlBtn" value="�ۼ��Ϸ�" onclick="confirmAccept();">&nbsp;
							<% } %> 
							<% if (mode.equals("R") && orderP.getStatusCd().equals("20") && userWhId.equals("mr")) { // �ۼ��Ϸ��̰�  MR ������ ��� �԰�ó�� ���� %>
									<input type="button" class="dtlBtn" value="�԰�ó��" onclick="confirmGetItem();">&nbsp;
							<% } %> 
							<% if (mode.equals("R") && orderP.getStatusCd().equals("30") && userWhId.equals("mr")) { // �԰�ó���̰�  MR ������ ��� �԰�Ϸ� ó�� ���� %>
									<input type="button" class="dtlBtn" value="�԰�Ϸ�" onclick="confirmFinish();">&nbsp;
							<% } %> 
							
		     				<% if(!mode.equals("V")){ %>
									<input type="button" class="dtlBtn" value="���" onclick="moveTo('poList.jsp?pg=<%=pg%>');">
		     				<% } %>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</center>
	<script>
	<% if(!mode.equals("V")) { %>
		setPage();
		setSelectResult();
	<% } %>
	</script>
<% if(mode.equals("V")) { %>
<footer>
	<center>
		<h2>metaRobotics, Inc.</h3>
	</center>
</footer>
<% } %>
</div>
<% if(mode.equals("V")) { %>
	<center>
		<br>
		<input type="button" class="dtlBtn" value="Print" onclick="printWindow();">
	</center>
<% } %>
	
</body>
</html>