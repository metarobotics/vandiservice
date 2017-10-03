<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="mrDao" class="wh.MrDAO"/>
<jsp:useBean id="productEachDao" class="wh.ProductEachDAO"/>
<jsp:useBean id="itemDao" class="wh.ItemDAO"/>
<jsp:useBean id="orderSDao" class="wh.OrderSDAO"/>
 
<% 
String mode = request.getParameter("mode");

if(!mode.equals("V")) { %>
<jsp:include page = "top.jsp"/>
<% } %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Service sheet</title>
<link rel="stylesheet" href="../css/vandiservice.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>

<script>
function printContent(el){
var restorepage = $('body').html();
var printcontent = $('#' + el).clone();
$('body').empty().html(printcontent);
window.print();
$('body').html(restorepage);
}
</script>

<%
	// write mode
	// C : Create
	// R : Repair
	// P : Paper
	// V : View

	//String mode = request.getParameter("mode");
	String pg = request.getParameter("pg");
	
	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;

	//out.print("."+mode+".");
	
	String writeMode;
	if(mode.equals("C"))
		writeMode = "C";
	else // R
		writeMode = "U";
	
	int orderNo = 0;
	String orderDt = "";
	int whNo=0;
	String whNm = "";
	String productSerialNo="";
	String statusCd = "";
	int subtotal=0;
	int tax=0;
	int totalAmt=0;
	String insertUserId = "";

	ArrayList<OrderSItem> orderSItemList = null;
	
	OrderS orderS = null;
	
	if(mode.equals("R") || mode.equals("V"))
	{
		orderNo = Integer.parseInt(request.getParameter("orderNo"));
	
		orderS = orderSDao.getOrderSInfo(orderNo);
	
		if(orderS != null)
		{
			//out.print("orderS not null");
			
			orderDt = orderS.getOrderDt();
			whNo = orderS.getWhNo();
			productSerialNo = orderS.getProductSerialNo();
			statusCd = orderS.getStatusCd();
			subtotal = orderS.getSubtotal();
			tax = orderS.getTax();
			totalAmt = orderS.getTotalAmt();
			insertUserId = orderS.getInsertUserId();
		}
	
		orderSItemList = orderSDao.getOrderSItemList(orderNo);
		
		int size = orderSItemList.size();
	}


	// mode C/R/V

	ArrayList<Wh> whList = mrDao.getWhList();
	int whLength = whList.size();
	
	for(int i=0; i<whLength;i++){
		Wh wh = whList.get(i);
		if(wh.getWhNo() == whNo)
		{
			whNm = wh.getWhNm();
			break;
		}
	}

	ArrayList<ProductEach> productEachList = productEachDao.getProductEachList();
	int productEachLength = productEachList.size();
	
	ArrayList<Item> itemList = itemDao.getItemList();
	int itemLength = itemList.size();
	
	String orderStr;
	
	
%>

<script type="text/javascript">

	var mode = '<%= mode %>';

	function soWriteCheck() {
		
		
		if(isNull(document.getElementById("whNo")))
		{
			alert('Service Center�� �����ϼ���.');
			return false;
		}
		else if(isNull(document.getElementById("productEach")))
		{
			alert('��ǰ�� �����ϼ���.');
			return false;
		}
		else if(document.getElementById("tdSubtotal").innerHTML  == "" || document.getElementById("tdSubtotal").innerHTML  == 0)
		{
			alert("������ �Է� ������ �����ϴ�.");
			return false;
		}
		
		document.getElementById('whNo').disabled='';
		
		return true;
	}

	function setPage()
	{
		if(mode == "R")
		{
		
			//document.getElementById("userId").value = '<%= insertUserId %>';
			
			document.getElementById("whNo").value = '<%= whNo %>';
			//document.getElementById("whNo").disabled = true;
			
			document.getElementById("productEach").value = '<%= productSerialNo %>';
			//document.getElementById("client").disabled = true;
			
			document.getElementById("tdSubtotal").innerHTML = '<%= subtotal %>';
			document.getElementById("tdTax").innerHTML = '<%= tax %>';
			document.getElementById("tdTotalAmt").innerHTML = '<%= totalAmt %>';
			
<%			
			if(orderSItemList != null){
				
				float totalSum = 0;
				
				int size = orderSItemList.size();
				OrderSItem orderSItem = null;
				
				for(int j=0; j<size; j++)
				{
					orderSItem = orderSItemList.get(j);
					int itemId = orderSItem.getItemNo();
					int itemCnt = orderSItem.getItemCnt();
					float serviceHour = orderSItem.getServiceHour();
					float itemSum = orderSItem.getItemCnt() * orderSItem.getItemPrice();
					//out.print(itemId + ":" + itemCnt);				
%>
				
					// ���� setting
					var idList = document.getElementsByName("selItem");
					var priceList = document.getElementsByName("txtPrice");
					var cntList = document.getElementsByName("txtCnt");
					var serviceHourList = document.getElementsByName("txtServiceHour");
					var itemSumList = document.getElementsByName("txtItemSum");
					var subSumList = document.getElementsByName("txtSubSum");
					
					var tot = idList.length;
					
					for (i = 0; i < tot; i++) {
						
						if(idList[i].value == '<%= itemId %>')
						{
							<%
							/*
							float serviceHour = 0;
							for (int i = 0; i < itemLength; i++) {
								Item item = itemList.get(i);
								if(item.getItemNo() == itemId)
								{
									serviceHour = item.getServiceHour();
									break;
								}
							}*/
							
							float itemSubSum = (int)(orderSItem.getItemCnt() * (orderSItem.getItemPrice() + orderSItem.getServiceHour() *34700));
							totalSum += itemSubSum;
							%>
							
							cntList[i].value = '<%=itemCnt%>';
							serviceHourList[i].value = '<%=serviceHour%>';
							itemSumList[i].value = '<%= MrUtil.FormatCurrent(itemSum) %>';
							subSumList[i].value = '<%= MrUtil.FormatCurrent(itemSubSum) %>';

						}
					}// for item IdList					
<%
				}//for orderSItemSize
			}//if(orderSItemList != null){
%>
		}//if(mode == "R") 
		else { //"C"
			document.getElementById("whNo").value = '<%= (Integer)session.getAttribute("whNo") %>'; // ����� wh
		}	
		
		if('<%= authLvl %>' == 'S')
		{
			document.getElementById('whNo').disabled='';
		}
	}//setPage

	
	function setSelectResult()
	{
		var str = "";
		var cnt = 0;
		var subtotal = 0;
	    
	    var idList = document.getElementsByName("selItem");
	    var priceList = document.getElementsByName("txtPrice");
	    var cntList = document.getElementsByName("txtCnt");
	    
	    var serviceHourList = document.getElementsByName("txtServiceHour");
		var itemSumList = document.getElementsByName("txtItemSum");
		var subSumList = document.getElementsByName("txtSubSum");
	    
	    var tot = idList.length;
	    
	    for (i = 0; i < tot; i++) {
	    	
	    	if(!isNull(cntList[i]) && cntList[i].value != 0)
	    	{
	    		if(str == "")
	    			str = idList[i].value + ":" +  cntList[i].value + ":" +  priceList[i].value + ":" +  serviceHourList[i].value;
	    		else
	    			str = str + "/" + idList[i].value + ":" +  cntList[i].value + ":" +  priceList[i].value + ":" +  serviceHourList[i].value; // seperator | �� ����ϸ� �ȵ�. �����Ǵ��� split�� �ȵ� 
	    			
	    		var price = parseInt(priceList[i].value);
	    		
	    		var cnt = parseInt(cntList[i].value);
	    		var serviceHour = parseFloat(serviceHourList[i].value);
	    		
	    		
	    		itemSumList[i].value = price*cnt;
				subSumList[i].value = (price + 34700*serviceHour)*cnt;
				
				subtotal = subtotal + (price + 34700*serviceHour)*cnt;
	    	}
	    }

		document.getElementById("tdSubtotal").innerHTML = subtotal;
		document.getElementById("tdTax").innerHTML = parseInt(subtotal * 0.1);
		document.getElementById("tdTotalAmt").innerHTML = parseInt(subtotal * 1.1);
		
		document.getElementById("subtotal").value = subtotal;
		document.getElementById("tax").value = parseInt(subtotal * 0.1);
		document.getElementById("totalAmt").value = parseInt(subtotal * 1.1);
		
		document.getElementById("orderStr").value = str;
	}

	function confirmDelete() {
		
		if(confirm('�����Ͻðڽ��ϱ�?'))
		{
			<% if(mode.equals("R")) { %>   
				moveTo('soWrite.jsp?mode=D&orderNo=<%=orderNo%>');
			<% } else { %>
			<% } %>   		
		}
	}
	
	// Ȯ�� 
	function confirmFinish() {
		
		if(confirm('Ȯ�� �Ŀ��� ����/������ �Ұ����ϸ� ����������� �����մϴ�. Ȯ���Ͻðڽ��ϱ�?'))
		{
			moveTo('soWrite.jsp?mode=F&orderNo=<%=orderNo%>&whNo=<%=whNo%>');
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
	   		<div class="table-title"><h1>������</h1></div>
	   	<% } else { %>
	   		<div class="table-title"><h1>����������</h1></div>
	   	<% } %>

	<!-- FORM -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

		<form name="form1" method="post" action="soWrite.jsp?mode=<%= writeMode %>" onsubmit="return soWriteCheck();">

	<!-- ORDER INFO -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

		<table width=600>
    		<tr class="row_bottom_only">
				<td width="100" class="cell-hd">������ȣ </td>
					<td width="100" class="cell-l">
 
 	<% if(mode.equals("C")) { %>
					<input type=text size=10 disabled value='' style="border: 0px; text-align: left;" >
					<input type=hidden name=orderNo id=orderNo >
	<% } else if(mode.equals("R")) { %>
					<input type=text size=10 disabled value='<%= MrUtil.getSOrderNoStr(orderNo) %>'  style="border: 0px; text-align: left;" >
					<input type=hidden name=orderNo id=orderNo value='<%= orderNo %>' >
	<% } else if(mode.equals("V")) { %><%= MrUtil.getSOrderNoStr(orderNo) %>
	<% } %>
 
					</td>
					<td width="100" class="cell-l"/>
					<td width="100" class="cell-l"/>
			</tr>
    		<tr class="row_bottom_only">
				<td width="100" class="cell-hd">�������� </td>
				<td width="100" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=date name=orderDt id=orderDt size=10 value='<%= MrUtil.getDateStr() %>' >
	<% } else if(mode.equals("R")) { %>
					<input type=date name=orderDt id=orderDt size=10 value='<%= orderDt %>' >
	<% } else if(mode.equals("V")) { %><%= orderDt %>
	<% } %>   		
				</td>
				<td width="100"  class="cell-r">�� �� �� </td>
     			<td width="100"  class="cell-l">
     <% if(mode.equals("V")) { %><%= whNm %>
     				
     <% } else { %>
     				<select name=whNo id=whNo disabled>
	     				<option value=''>����</option>
		   				<%
					 		for(int i=0; i<whLength;i++){
								Wh wh = whList.get(i);
		     			%>
		      			    <option value=<%= wh.getWhNo() %>><%= wh.getWhNm() %></option>
		     			<%
		     				}
		     			%>
     				</select>
     <% } %>
     			</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="100" class="cell-hd">�� �� �� </td>
				<td width="100" class="cell-l">
	<% if(mode.equals("C")) { %>
					<input type=text name=userId id=userId size=10 disabled value='<%= (String)session.getAttribute("userId") %>' >
	<% } else { %>
					<%= insertUserId %>
	<% } %>
				</td>
				<td width="100" class="cell-r">��ǰ�Ϸù�ȣ </td>
     			<td width="100" class="cell-l">
     <% if(mode.equals("V")) { %><%= productSerialNo %>
     <% } else { %>
     				<select id=productEach name=productEach>
     
	     				<option value=''>����</option>
		   				<%
					 		for(int i=0; i<productEachLength;i++){
					 			ProductEach productEach = productEachList.get(i);
		     			%>
		      			    <option value=<%= productEach.getSerialNo() %>><%= productEach.getSerialNo() %></option>
		     			<%
		     				}
		     			%>
     				</select>
     <% } %> 
     			</td>
			</tr>
			<tr height="10"/>
    	</table>

	<!-- NOTE -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->
		<h3>Note</h3>
		<table border="0" width=600>
			
	   	<% if(mode.equals("C")) { %>
			<tr><td><textarea rows="3" cols="80" name="note" placeholder="�԰�/���� ���� Ư�̻����� �Է��մϴ�."></textarea></td></tr>
	   	<% } else if(mode.equals("R")) { %>
			<tr><td><textarea rows="3" cols="80" name="note"><%= orderS.getNote() %></textarea></td></tr>
	   	<% } else if(mode.equals("V")){ %>
			<tr><td><textarea rows="3" cols="96" name="note" style="border: 1px solid #C1C3D1;" readonly><%= orderS.getNote() %></textarea></td></tr>
	   	<% } %>
			        
			<tr height="15"/>
		</table>


	<!-- ORDER ITEM -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

			<% int nTotalAmount = 0; %>
			<table id="order_item_table" border=0 width=600>
				<thead>
					<tr>
						<th width="55%" class="cell-l">���񳻿�</th>
						<th width="5%" class="cell-c">����</th>
						<th width="10%" class="cell-r">��ǰ�ܰ�</th>
						<th width="10%" class="cell-r">����ð�</th>
						<th width="10%" class="cell-r">��ǰ��</th>
						<th width="10%" class="cell-r">�հ�</th>
					</tr>
				</thead>
				<tbody id="p_item">

				<%
					for (int i = 0; i < itemLength; i++) {
						Item item = itemList.get(i);
						
						// View Only
						//////////////////////////////////////////////////////////////////////////
						int nOrderSItemCnt = 0;
						float nOrderServiceHour = 0;
						if(mode.equals("V")){
							for(int j = 0; j < orderSItemList.size(); j++)
							{
								OrderSItem oItem = orderSItemList.get(j); 
								if(item.getItemNo() == oItem.getItemNo()){
									nOrderSItemCnt = oItem.getItemCnt();
									nOrderServiceHour = oItem.getServiceHour();
								}
							}
							
							if(nOrderSItemCnt == 0)
								continue;
						}
						//////////////////////////////////////////////////////////////////////////
				%>

						<tr id="order_item_info">
							<td width="30%"><input type=hidden name="selItem" value=<%=item.getItemNo()%>>
							<!-- <select name="selItem" disabled>
									<option value=<%=item.getItemNo()%>> </option></select>-->
									<%=item.getItemNmKor()%>
							</td>
						
						<% if(mode.equals("V")) { %>
							<td width="10%" class="cell-c"><%=nOrderSItemCnt%></td>
							<td width="15%" class="cell-r"><%= MrUtil.FormatCurrentDisplay(item.getPriceClient()) %></td>
							<td width="15%" class="cell-c"><%= nOrderServiceHour%></td>
							<td width="20%" class="cell-r"><%= item.getPriceClient()*nOrderSItemCnt %></td>
							<td width="20%" class="cell-r"><%= MrUtil.FormatCurrentDisplay((int)(item.getPriceClient()*nOrderSItemCnt + nOrderServiceHour*34700*nOrderSItemCnt)) %></td>
							<% nTotalAmount += (int)(item.getPriceClient()*nOrderSItemCnt + nOrderServiceHour*34700*nOrderSItemCnt); %>
						<% } else { %>
							<td width="10%" class="cell-r">
								<input type="text" name="txtCnt" size=3
								style="text-align: right"
								onchange="setSelectResult();"
								onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;" />
							</td>
							<td width="10%" class="cell-r">
							<input type="text" name="txtPrice" size=8
								style="border: 0px; text-align: right;" value='<%= MrUtil.FormatCurrent(item.getPriceClient()) %>'
								disabled />
							</td>
							<td width="10%" class="cell-r">
								<input type="text" name="txtServiceHour" size=4
								style="text-align: right" value='<%=item.getServiceHour()%>'
								onchange="setSelectResult();"
								onKeypress="if(event.keyCode != 46 && (event.keyCode < 48 || event.keyCode > 57)) event.returnValue = false;" />
							
	<!--							<input type="text" name="txtServiceHour" size=4
									style="border: 0px; text-align: right;" value='<%=item.getServiceHour()%>'
									disabled />  -->
							</td>
							<td width="10%" class="cell-r">
							<input type="text" name="txtItemSum" size=8
								style="border: 0px; text-align: right;" value='<%=0%>'
								disabled />
							</td>
							<td width="10%" class="cell-r">
							<input type="text" name="txtSubSum" size=8
								style="border: 0px; text-align: right;" value='<%=0%>'
								disabled />
							</td>
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
				<td id="tdSubtotal" align="right"><%= MrUtil.FormatCurrentDisplay(nTotalAmount) %></td>
			</tr>
			<tr class="row_top_only">
				<td align="right">�ΰ���ġ�� :</td>
				<td id="tdTax" align="right"><%= MrUtil.FormatCurrentDisplay((int)(nTotalAmount*0.1)) %></td>
			</tr>
			<tr class="row_top_only">
				<td align="right">�Ѿ� :</td>
				<td id="tdTotalAmt" align="right"><%= MrUtil.FormatCurrentDisplay((int)(nTotalAmount*1.1)) %></td>
			</tr>
			<tr height="30"/>
		</table>
		
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
		
<% } else { %>
		<table border="0">
			<tr height="3"/>
			<tr class="row_top_only">
				<td align="right" width="100">�հ� : </td>
				<td id="tdSubtotal" align="right"></td>
			</tr>
			<tr class="row_top_only">
				<td align="right">�ΰ���ġ�� :</td>
				<td id="tdTax" align="right"></td>
			</tr>
			<tr class="row_top_only">
				<td align="right">�Ѿ� :</td>
				<td id="tdTotalAmt" align="right"></td>
			</tr>
		</table>
<% } %>
		

		<input type="hidden" id="subtotal" name="subtotal"/>
		<input type="hidden" id="tax" name="tax"/>
		<input type="hidden" id="totalAmt" name="totalAmt"/>
		<input type="hidden" id="orderStr" name="orderStr"/>
		<table>
    		<tr height="40" valign="bottom">
     			<td colspan="2">
     				<div align="center">
     				<% if(mode.equals("C")) { %>
     					<input type="submit" class="dtlBtn" value="���">&nbsp;
     				<% } %>
     				<% if(mode.equals("P")){ %>
     					<input type="button" class="dtlBtn" value="����" onclick="moveTo('soList.jsp?mode=R&orderNo=<%=orderNo%>');">&nbsp;
     				<% } %>
     				<% if(mode.equals("R") && orderS.getStatusCd().equals("10")){ // �ֹ����� => ���� ���� ���� %>  
     					<input type="submit" class="dtlBtn" value="����" onclick="moveTo('soList.jsp?mode=R&orderNo=<%=orderNo%>');">&nbsp;
     					<input type="button" class="dtlBtn" value="����" onclick="confirmDelete();">&nbsp;
     				<% } %>
     				<% if(mode.equals("R")){ %>
     					<input type="button" class="dtlBtn" value="Print" onclick="window.open('soDtl.jsp?mode=V&orderNo=<%=orderNo%>');">&nbsp;
     				<% } %>
					<% if (mode.equals("R") && orderS.getStatusCd().equals("10")) { // ������ ��� Ȯ�� ����   %>
						<input type="button" class="dtlBtn" value="Ȯ��" onclick="confirmFinish();">&nbsp;
					<% } %>
     				
     				<% if(!mode.equals("V")){ %>
     					<input type="button" class="dtlBtn" value="���" onclick="moveTo('soList.jsp?pg=<%=pg %>');">
     				<% } %>
         				
         			</div>
     			</td>
    		</tr>
		</table>
	</form>
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