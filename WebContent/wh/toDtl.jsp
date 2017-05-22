<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>

<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
 
<jsp:useBean id="mrDao" class="wh.MrDAO"/>
<jsp:useBean id="itemDao" class="wh.ItemDAO"/>
<jsp:useBean id="orderTDao" class="wh.OrderTDAO"/>
<jsp:include page = "/loginChk.jsp"/>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/mr.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="../js/chkValid.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>


<%

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
	int srcWhNo=0;
	int destWhNo=0;
	String statusCd = "";
	int subtotal=0;
	int tax=0;
	int totalAmt=0;
	String insertUserId = "";

	ArrayList<OrderItem> orderItemList = null;
	
	if(mode.equals("R"))
	{
		orderNo = Integer.parseInt(request.getParameter("orderNo"));
	
		OrderT orderT = null;
	
		orderT = orderTDao.getOrderTInfo(orderNo);
	
		if(orderT != null)
		{
			//out.print("orderT not null");
			
			orderDt = orderT.getOrderDt();
			srcWhNo = orderT.getSrcWhNo();
			destWhNo = orderT.getDestWhNo();
			statusCd = orderT.getStatusCd();
			subtotal = orderT.getSubtotal();
			tax = orderT.getTax();
			totalAmt = orderT.getTotalAmt();
			insertUserId = orderT.getInsertUserId();
		}
		
		orderItemList = orderTDao.getOrderItemList(orderNo);
//		int size = orderItemList.size();		
	}


	// mode C/R

	ArrayList<Wh> whlist = mrDao.getWhList();
	int whLength = whlist.size();

	ArrayList<Item> itemlist = itemDao.getItemList();
	int itemLength = itemlist.size();
	
	String orderStr;
	
	
%>

<script type="text/javascript">

	var mode = '<%= mode %>';
	//alert(mode);
	

	function toWriteCheck() {
		
		
		if(isNull(document.getElementById("srcWh")))
		{
			alert('src ������');
			return false;
		}
		else if(isNull(document.getElementById("destWh")))
		{
			alert('dest ������');
			return false;
		}
		else if(document.getElementById("srcWh").value == document.getElementById("destWh").value)
		{
			alert("Sourceâ��� Destinationâ��� ���� �� �����ϴ�.");
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
			
			document.getElementById("srcWh").value = '<%= srcWhNo %>';
			//document.getElementById("srcWh").disabled = true;
			
			document.getElementById("destWh").value = '<%= destWhNo %>';
			//document.getElementById("destWh").disabled = true;
			
			document.getElementById("tdSubtotal").innerHTML = '<%= subtotal %>';
			document.getElementById("tdTax").innerHTML = '<%= tax %>';
			document.getElementById("tdTotalAmt").innerHTML = '<%= totalAmt %>';
			
<%			
			if(orderItemList != null){
				int size = orderItemList.size();
				OrderItem orderItem = null;
				
				for(int j=0; j<size; j++)
				{
					orderItem = orderItemList.get(j);
					int itemId = orderItem.getItemNo();
					int itemCnt = orderItem.getItemCnt();
//out.print(itemId + ":" + itemCnt);				
%>
								
				
					// ���� setting
					var idList = document.getElementsByName("selItem");
					var priceList = document.getElementsByName("txtPrice");
					var cntList = document.getElementsByName("txtCnt");
					
					var tot = idList.length;
					
					for (i = 0; i < tot; i++) {
						
						if(idList[i].value == '<%= itemId %>')
						{
							cntList[i].value = '<%=itemCnt%>';
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
	    
	    var tot = idList.length;
	    
	    for (i = 0; i < tot; i++) {
	    	
	    	if(!isNull(cntList[i]) && cntList[i].value != 0)
	    	{
	    		if(str == "")
	    			str = idList[i].value + ":" +  cntList[i].value + ":" +  priceList[i].value;
	    		else
	    			str = str + "/" + idList[i].value + ":" +  cntList[i].value + ":" +  priceList[i].value; // seperator | �� ����ϸ� �ȵ�. �����Ǵ��� split�� �ȵ� 
	    		subtotal = subtotal + parseInt(priceList[i].value) * parseInt(cntList[i].value);
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
				moveTo('toDelete.jsp?orderNo=<%=orderNo%>');
			<% } else { %>
			<% } %>   		
		}
	}
	
</script>
</head>

<body>
<center>

  
   
	<% if(mode.equals("R")) { %>   
   		<div class="table-title"><h1>Transfer Order ��</h1></div>
	<% } else { %>
   		<div class="table-title"><h1>Transfer Order ���</h1></div>
	<% } %>   		
   	

		<form name="form1" method="post" action="toWrite_action.jsp?mode=<%= writeMode %>" onsubmit="return toWriteCheck();">


		<table border=1 class='table-fill'>
    		<tr>
				<td width="30%" class="cell-hd">�ֹ���ȣ</td>
				<td width="70%" class="cell-l">
				
	<% if(mode.equals("C")) { %>   
					<input type=text size=10 disabled value='' >
					<input type=hidden name=orderNo id=orderNo >
	<% } else { %>
					<input type=text size=10 disabled value='<%= MrUtil.getTOrderNoStr(orderNo) %>' >
					<input type=hidden name=orderNo id=orderNo value='<%= orderNo %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">�ֹ�����</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=date name=orderDt id=orderDt size=10 value='<%= MrUtil.getDateStr() %>' >
	<% } else { %>
					<input type=date name=orderDt id=orderDt size=10 value='<%= orderDt %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">�ۼ���</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=userId id=userId size=10 disabled value='<%= (String)session.getAttribute("userId") %>' >
	<% } else { %>
					<input type=text name=userId id=userId size=10 disabled value='<%= insertUserId %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
     			<td class="cell-hd">Source Warehouse</td>
     			<td class="cell-l">
     				<select name=srcWh id=srcWh>
	     				<option value=''>����</option>
		   				<%
					 		for(int i=0; i<whLength;i++){
								Wh wh = whlist.get(i);
		     			%>
		      			    <option value=<%= wh.getWhNo() %>><%= wh.getWhNm() %></option>
		     			<%
		     				}
		     			%>
     				</select>
     			</td>
    		</tr>
    		<tr>
     			<td class="cell-hd">Destination Warehouse</td>
     			<td class="cell-l">
     				<select id=destWh name=destWh>
	     				<option value=''>����</option>
		   				<%
					 		for(int i=0; i<whLength;i++){
								Wh wh = whlist.get(i);
		     			%>
		      			    <option value=<%= wh.getWhNo() %>><%= wh.getWhNm() %></option>
		     			<%
		     				}
		     			%>
     				</select>
     			</td>
     		</tr>
    		<tr>
     			<td class="cell-hd">Item</td>
     			<td class="cell-l">
						<!-- <h3 align="left">
						    <a href="#" id="addItem">Add Item</a>
						</h3>-->
						<table class="dynatable" width="600" border=0>
						    <thead>
						        <tr>
						            <th width="400">Item</th>
						            <th width="100">����</th>
						            <th width="100">����</th>
						        </tr>
						    </thead>
						    <tbody id="p_item">
						    
							   				<%
										 		for(int i=0; i<itemLength;i++){
													Item item = itemlist.get(i);
							     			%>
						    
						        <tr>
						            <td>
					     				<select style="width:400;" name="selItem" disabled><!-- onChange="javascript:setItemPrice(this)" -->
							      			    <option value=<%= item.getItemNo() %>>[<%= item.getItemId() %>] <%= item.getItemNm() %></option>
					     				</select>
						            </td>
					  	            <td>
						                <input type="text" name="txtPrice" style="text-align:right" value='<%= item.getPriceCenter() %>' disabled />
						            </td>
						            <td>
						                <input type="text" name="txtCnt" style="text-align:right" onchange="setSelectResult();" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" />
						            </td>
						        </tr>

							     			<%
							     				}
							     			%>
						        
						    </tbody>
						</table>
						<table width="200" height="50" border="0">
							<tr><td align="right" width="100">subtotal : </td><td id="tdSubtotal" align="right"></td></tr>
							<tr><td align="right" >tax : </td><td id="tdTax" align="right"></td></tr>
							<tr><td align="right" >total price : </td><td id="tdTotalAmt" align="right"></td></tr>
						</table>
     			</td>
    		</tr>
		</table>
		<input type="hidden" id="subtotal" name="subtotal"/>
		<input type="hidden" id="tax" name="tax"/>
		<input type="hidden" id="totalAmt" name="totalAmt"/>
		<input type="hidden" id="orderStr" name="orderStr"/>
		<table>
    		<tr height="40" valign="bottom">
     			<td colspan="2">
     				<div align="center">
     				<% if(mode.equals("C")) { %>
     					<input type="submit" class="myButton" value="���">&nbsp;
     				<% }else{ %>
     					<input type="submit" class="myButton" value="����">&nbsp;
     					<input type="button" class="myButton" value="����" onclick="confirmDelete();">&nbsp;
     				<% } %>
         				<input type="button" class="myButton" value="���" onclick="moveTo('toList.jsp?pg=<%=pg %>');">
         			</div>
     			</td>
    		</tr>
		</table>    		 
	</form> 
</center>
<script>
	setPage();
	setSelectResult();
</script>
</body>
</html>