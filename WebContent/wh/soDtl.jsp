<%@ page language="java" contentType="text/html;charset=euc_kr" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%@ page import = "java.sql.*" %>
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
 
<jsp:useBean id="mrDao" class="wh.MrDAO"/>
<jsp:useBean id="productEachDao" class="wh.ProductEachDAO"/>
<jsp:useBean id="itemDao" class="wh.ItemDAO"/>
<jsp:useBean id="orderSDao" class="wh.OrderSDAO"/>
<jsp:include page = "/loginChk.jsp"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Service sheet</title>
<link rel="stylesheet" href="../css/vandiservice.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="../js/chkValid.js"></script>
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

	String mode = request.getParameter("mode");
	String pg = request.getParameter("pg");
	
	//out.print("."+mode+".");
	
	String writeMode;
	if(mode.equals("C"))
		writeMode = "C";
	else // R
		writeMode = "U";
	
	int orderNo = 0;
	String orderDt = "";
	int centerNo=0;
	String centerName = "";
	String productSerialNo="";
	String statusCd = "";
	int subtotal=0;
	int tax=0;
	int totalAmt=0;
	String insertUserId = "";

	ArrayList<OrderItem> orderItemList = null;
	
	if(mode.equals("R") || mode.equals("V"))
	{
		orderNo = Integer.parseInt(request.getParameter("orderNo"));
	
		OrderS orderS = null;
	
		orderS = orderSDao.getOrderSInfo(orderNo);
	
		if(orderS != null)
		{
			//out.print("orderS not null");
			
			orderDt = orderS.getOrderDt();
			centerNo = orderS.getCenterNo();
			productSerialNo = orderS.getProductSerialNo();
			statusCd = orderS.getStatusCd();
			subtotal = orderS.getSubtotal();
			tax = orderS.getTax();
			totalAmt = orderS.getTotalAmt();
			insertUserId = orderS.getInsertUserId();
		}
	
		orderItemList = orderSDao.getOrderItemList(orderNo);
		
		int size = orderItemList.size();
	}


	// mode C/R/V

	ArrayList<Wh> whList = mrDao.getWhList();
	int whLength = whList.size();
	
	for(int i=0; i<whLength;i++){
		Wh wh = whList.get(i);
		if(wh.getWhNo() == centerNo)
		{
			centerName = wh.getWhNm();
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
		
		
		if(isNull(document.getElementById("center")))
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
		
		return true;
	}

	function setPage()
	{
		if(mode == "R")
		{
		
			//document.getElementById("userId").value = '<%= insertUserId %>';
			
			document.getElementById("center").value = '<%= centerNo %>';
			//document.getElementById("center").disabled = true;
			
			document.getElementById("productEach").value = '<%= productSerialNo %>';
			//document.getElementById("client").disabled = true;
			
			document.getElementById("tdSubtotal").innerHTML = '<%= subtotal %>';
			document.getElementById("tdTax").innerHTML = '<%= tax %>';
			document.getElementById("tdTotalAmt").innerHTML = '<%= totalAmt %>';
<%			
			if(orderItemList != null){
				
				int totalSum = 0;
				
				int size = orderItemList.size();
				OrderItem orderItem = null;
				
				for(int j=0; j<size; j++)
				{
					orderItem = orderItemList.get(j);
					int itemId = orderItem.getItemNo();
					int itemCnt = orderItem.getItemCnt();
					int itemSum = orderItem.getItemCnt() * orderItem.getItemPrice();
//out.print(itemId + ":" + itemCnt);				
%>
								
				
					// ���� setting
					var idList = document.getElementsByName("selItem");
					var priceList = document.getElementsByName("txtPrice");
					var cntList = document.getElementsByName("txtCnt");
					var serviceTimeList = document.getElementsByName("txtServiceTime");
					var itemSumList = document.getElementsByName("txtItemSum");
					var subSumList = document.getElementsByName("txtSubSum");
					
					var tot = idList.length;
					
					for (i = 0; i < tot; i++) {
						
						if(idList[i].value == '<%= itemId %>')
						{
							<%
							
							float serviceTime = 0;
							for (int i = 0; i < itemLength; i++) {
								Item item = itemList.get(i);
								if(item.getItemNo() == itemId)
								{
									serviceTime = item.getServiceHour();
									break;
								}
							}
							
							int itemSubSum = (int)(orderItem.getItemCnt() * (orderItem.getItemPrice() + serviceTime *34700));
							totalSum += itemSubSum;
							%>
							
							cntList[i].value = '<%=itemCnt%>';
							itemSumList[i].value = '<%= MrUtil.FormatCurrent(itemSum) %>';
							subSumList[i].value = '<%= MrUtil.FormatCurrent(itemSubSum) %>';

						}
					}					
<%
				}
			}
%>
		}//if(mode == "R")
	}//setPage

	
	function setSelectResult()
	{
		var str = "";
		var cnt = 0;
		var subtotal = 0;
	    
	    var idList = document.getElementsByName("selItem");
	    var priceList = document.getElementsByName("txtPrice");
	    var cntList = document.getElementsByName("txtCnt");
	    
	    var serviceTimeList = document.getElementsByName("txtServiceTime");
		var itemSumList = document.getElementsByName("txtItemSum");
		var subSumList = document.getElementsByName("txtSubSum");
	    
	    var tot = idList.length;
	    
	    for (i = 0; i < tot; i++) {
	    	
	    	if(!isNull(cntList[i]) && cntList[i].value != 0)
	    	{
	    		if(str == "")
	    			str = idList[i].value + ":" +  cntList[i].value + ":" +  priceList[i].value;
	    		else
	    			str = str + "/" + idList[i].value + ":" +  cntList[i].value + ":" +  priceList[i].value; // seperator | �� ����ϸ� �ȵ�. �����Ǵ��� split�� �ȵ� 
	    			
	    		var price = parseInt(priceList[i].value);
	    		
	    		var cnt = parseInt(cntList[i].value);
	    		var serviceTime = parseFloat(serviceTimeList[i].value);
	    		
	    		
	    		itemSumList[i].value = price*cnt;
				subSumList[i].value = (price + 34700*serviceTime)*cnt;
				
				subtotal = subtotal + (price + 34700*serviceTime)*cnt;
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
				moveTo('soDelete.jsp?orderNo=<%=orderNo%>');
			<% } else { %>
			<% } %>   		
		}
	}
	
</script>
</head>


<body>
<center>

	<!-- TITLE -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->
	
	<% if(mode.equals("R") || mode.equals("V")) { %>
		<div><h4>Smart robots for agriculture</h4></div>
   		<div class="table-title"><h1>VANDI SERVICE</h1></div>
	<% } else { %>
   		<div class="table-title"><h1>New quotation</h1></div>
	<% } %>

	<!-- FORM -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

		<form name="form1" method="post" action="soWrite_action.jsp?mode=<%= writeMode %>" onsubmit="return soWriteCheck();">

	<!-- ORDER INFO -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

		<table>
    		<tr class="row_bottom_only">
				<td width="100" class="cell-hd">������ȣ : </td>
					<td width="100" class="cell-l">
 
 	<% if(mode.equals("C")) { %>
					<input type=text size=10 disabled value='' style="border: 0px; text-align: left;" >
					<input type=hidden name=orderNo id=orderNo >
	<% } else if(mode.equals("R")) { %>
					<input type=text size=10 disabled value='<%= MrUtil.getTOrderNoStr(orderNo) %>'  style="border: 0px; text-align: left;" >
					<input type=hidden name=orderNo id=orderNo value='<%= orderNo %>' >
	<% } else if(mode.equals("V")) { %><%= MrUtil.getTOrderNoStr(orderNo) %>
	<% } %>
 
					</td>
					<td width="100" class="cell-l"/>
					<td width="100" class="cell-l"/>
			</tr>
    		<tr class="row_bottom_only">
				<td width="100" class="cell-hd">�ۼ����� : </td>
				<td width="100" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=date name=orderDt id=orderDt size=10 value='<%= MrUtil.getDateStr() %>' >
	<% } else if(mode.equals("R")) { %>
					<input type=date name=orderDt id=orderDt size=10 value='<%= orderDt %>' >
	<% } else if(mode.equals("V")) { %><%= orderDt %>
	<% } %>   		
				</td>
				<td width="100"  class="cell-r">�� �� �� : </td>
     			<td width="100"  class="cell-l">
     <% if(mode.equals("V")) { %><%= centerName %>
     				
     <% } else { %>
     				<select name=center id=center>
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
				<td width="100" class="cell-hd">�� �� �� : </td>
				<td width="100" class="cell-l">
	<% if(mode.equals("C")) { %>
					<input type=text name=userId id=userId size=10 disabled value='<%= (String)session.getAttribute("userId") %>' >
	<% } else { %>
					<%= insertUserId %>
	<% } %>
				</td>
				<td width="100" class="cell-r">��ǰ��ȣ : </td>
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
		<table border="0">
			<tr><td><textarea rows="3" cols="80" name="tacontents">�԰�/���� ���� Ư�̻����� �Է��մϴ�.</textarea></td></tr>
			<tr height="15"/>
		</table>


	<!-- ORDER ITEM -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

			<% int nTotalAmount = 0; %>
			<table id="order_item_table" border=0>
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
							int nOrderItemCnt = 0;
							if(mode.equals("V")){
								for(int j = 0; j < orderItemList.size(); j++)
								{
									OrderItem oItem = orderItemList.get(j); 
									if(item.getItemNo() == oItem.getItemNo())
										nOrderItemCnt = oItem.getItemCnt();
								}
								
								if(nOrderItemCnt == 0)
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
						<td width="10%" class="cell-c"><%=nOrderItemCnt%></td>
						<td width="15%" class="cell-r"><%= MrUtil.FormatCurrentDisplay(item.getPriceCenter()) %></td>
						<td width="15%" class="cell-c"><%=item.getServiceHour()%></td>
						<td width="20%" class="cell-r"><%= MrUtil.FormatCurrentDisplay((int)(item.getPriceCenter()*nOrderItemCnt)) %></td>
						<td width="20%" class="cell-r"><%= MrUtil.FormatCurrentDisplay((int)(item.getPriceCenter() + item.getServiceHour()*34700)*nOrderItemCnt) %></td>
						<% nTotalAmount += (int)(item.getPriceCenter() + item.getServiceHour()*34700)*nOrderItemCnt; %>
			<% } else { %>
						<td width="10%" class="cell-r">
							<input type="text" name="txtCnt" size=3
							style="text-align: right"
							onchange="setSelectResult();"
							onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" />
						</td>
						<td width="10%" class="cell-r">
						<input type="text" name="txtPrice" size=8
							style="border: 0px; text-align: right;" value='<%= MrUtil.FormatCurrent(item.getPriceCenter()) %>'
							disabled />
						</td>
						<td width="10%" class="cell-r">
						<input type="text" name="txtServiceTime" size=4
							style="border: 0px; text-align: right;" value='<%=item.getServiceHour()%>'
							disabled />
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
			<% } %>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>

	<!-- TOTAL AMOUNT -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

<% if(mode.equals("V")) { %>
		<table border="0">
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
		
		<table border = "1">
			<tr height="30"/>
			<tr class="row_top_only">
				<td align="center">
				���� ������ Ȯ���մϴ�
				<br>
				2017��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��
				<br>
				�� �� ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(����)
				</td>
			</tr>
			<tr>
				<td align="left">
				1. ���α��� : ���� ����
				<br>
				2. �Աݰ��� : ���񽺼��ͺ� Ȯ�� ���
				</td>
			</tr>
			<tr class="row_bottom_only">
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
     				<% }else if(mode.equals("P")){ %>
     					<input type="button" class="dtlBtn" value="����" onclick="moveTo('soList.jsp?mode=R&orderNo=<%=orderNo%>');">&nbsp;
     				<% }else if(mode.equals("R")){ %>
     					<input type="submit" class="dtlBtn" value="���� �Ϸ�" onclick="moveTo('soList.jsp?mode=R&orderNo=<%=orderNo%>');">&nbsp;
     					<input type="button" class="dtlBtn" value="Print" onclick="moveTo('soDtl.jsp?mode=V&orderNo=<%=orderNo%>');">&nbsp;
     					<input type="button" class="dtlBtn" value="����" onclick="confirmDelete();">&nbsp;
     				<% }else if(mode.equals("V")){ %>
     					
     				<% }else{ %>
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

</center>
</body>

<footer>
	<center>
		<h2>metaRobotics, Inc.</h3>
	</center>
</footer>

</html>