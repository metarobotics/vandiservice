<%@ page language="java" contentType="text/html;charset=euc_kr" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
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
	int centerNo=0;
	String productSerialNo="";
	String statusCd = "";
	int subtotal=0;
	int tax=0;
	int totalAmt=0;
	String insertUserId = "";

	ArrayList<OrderItem> orderItemList = null;
	
	if(mode.equals("R"))
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


	// mode C/R

	ArrayList<Wh> whList = mrDao.getWhList();
	int whLength = whList.size();

	ArrayList<ProductEach> productEachList = productEachDao.getProductEachList();
	int productEachLength = productEachList.size();

	ArrayList<Item> itemList = itemDao.getItemList();
	int itemLength = itemList.size();
	
	String orderStr;
	
	
%>

<script type="text/javascript">

	var mode = '<%= mode %>';
	//alert(mode);
	

	function soWriteCheck() {
		
		
		if(isNull(document.getElementById("center")))
		{
			alert('Service Center를 선택하세요.');
			return false;
		}
		else if(isNull(document.getElementById("productEach")))
		{
			alert('제품을 선택하세요.');
			return false;
		}
		else if(document.getElementById("tdSubtotal").innerHTML  == "" || document.getElementById("tdSubtotal").innerHTML  == 0)
		{
			alert("아이템 입력 내역이 없습니다.");
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
								
				
					// 수량 setting
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
				
				String strTotalSum = MrUtil.FormatCurrent(totalSum);
				String strTotalTax = MrUtil.FormatCurrent((int)(totalSum*0.1));
				String strTotalPrice = MrUtil.FormatCurrent((int)(totalSum*1.1));
%>

				document.getElementById("tdSubtotal").innerHTML = '<%=strTotalSum%>';
				document.getElementById("tdTax").innerHTML = '<%=strTotalTax%>';
				document.getElementById("tdTotalAmt").innerHTML = '<%=strTotalPrice%>';
				
				document.getElementById("subtotal").value = '<%=strTotalSum%>';
				document.getElementById("tax").value = '<%=strTotalTax%>';
				document.getElementById("totalAmt").value = '<%=strTotalPrice%>';
<%				
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
	    var subSumList = document.getElementsByName("txtSubSum");
	    
	    var tot = idList.length;
	    
	    for (i = 0; i < tot; i++) {
	    	
	    	if(!isNull(cntList[i]) && cntList[i].value != 0)
	    	{
	    		if(str == "")
	    			str = idList[i].value + ":" +  cntList[i].value + ":" +  priceList[i].value;
	    		else
	    			str = str + "/" + idList[i].value + ":" +  cntList[i].value + ":" +  priceList[i].value; // seperator | 는 사용하면 안됨. 변형되는지 split이 안돼 
	    		subtotal = subtotal + parseInt(subSumList[i].value);
	    	}
	    }
/*
		document.getElementById("tdSubtotal").innerHTML = subtotal;
		document.getElementById("tdTax").innerHTML = parseInt(subtotal * 0.1);
		document.getElementById("tdTotalAmt").innerHTML = parseInt(subtotal * 1.1);
		
		document.getElementById("subtotal").value = subtotal;
		document.getElementById("tax").value = parseInt(subtotal * 0.1);
		document.getElementById("totalAmt").value = parseInt(subtotal * 1.1);
*/
		document.getElementById("orderStr").value = str;
	}
	

	function confirmDelete() {
		
		if(confirm('삭제하시겠습니까?'))
		{
			<% if(mode.equals("R")) { %>   
				moveTo('soDelete.jsp?orderNo=<%=orderNo%>');
			<% } else { %>
			<% } %>   		
		}
	}
	
</script>
</head>


<body class="A4">

<center>
  
   
	<% if(mode.equals("R")) { %>   
   		<div class="table-title"><h1>Sales Order #<%= orderNo %></h1></div>
	<% } else { %>
   		<div class="table-title"><h1>New sales order</h1></div>
	<% } %>   		
   	

		<form name="form1" method="post" action="soWrite_action.jsp?mode=<%= writeMode %>" onsubmit="return soWriteCheck();">


		<table width="500">
    		<tr class="row_bottom_only">
				<td width="100" class="cell-hd">주문번호</td>
					<td width="100" class="cell-l">
 
 <% if(mode.equals("C")) { %>   
					<input type=text size=10 disabled value='' style="border: 0px; text-align: left;" >
					<input type=hidden name=orderNo id=orderNo >
	<% } else { %>
					<input type=text size=10 disabled value='<%= MrUtil.getTOrderNoStr(orderNo) %>'  style="border: 0px; text-align: left;" >
					<input type=hidden name=orderNo id=orderNo value='<%= orderNo %>' >
	<% } %>
 
					</td>
					<td width="100" class="cell-l"/>
					<td width="100" class="cell-l"/>
			</tr>
    		<tr class="row_bottom_only">
				<td width="100" class="cell-hd">주문일자</td>
				<td width="100" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=date name=orderDt id=orderDt size=10 value='<%= MrUtil.getDateStr() %>' >
	<% } else { %>
					<input type=date name=orderDt id=orderDt size=10 value='<%= orderDt %>' >
	<% } %>   		
				</td>
				<td width="100"  class="cell-r">Service Center</td>
     			<td width="100"  class="cell-l">
     				<select name=center id=center>
	     				<option value=''>선택</option>
		   				<%
					 		for(int i=0; i<whLength;i++){
								Wh wh = whList.get(i);
		     			%>
		      			    <option value=<%= wh.getWhNo() %>><%= wh.getWhNm() %></option>
		     			<%
		     				}
		     			%>
     				</select>
     			</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="100" class="cell-hd">작성자</td>
				<td width="100" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=userId id=userId size=10 disabled value='<%= (String)session.getAttribute("userId") %>' >
	<% } else { %>
					<input type=text name=userId id=userId size=10 disabled value='<%= insertUserId %>' >
	<% } %>   		
				</td>
				<td width="100" class="cell-r">Product</td>
     			<td width="100" class="cell-l">
     				<select id=productEach name=productEach>
	     				<option value=''>선택</option>
		   				<%
					 		for(int i=0; i<productEachLength;i++){
					 			ProductEach productEach = productEachList.get(i);
		     			%>
		      			    <option value=<%= productEach.getSerialNo() %>><%= productEach.getSerialNo() %></option>
		     			<%
		     				}
		     			%>
     				</select>
     			</td>
			</tr>
    		<tr height="20"/>
     		</table>

			<table id="order_item_table" border=0>
				<thead>
					<tr>
						<th width="100mm">Description</th>
						<th width="20mm" class="cell-r">수량</th>
						<th width="20mm" class="cell-r">부품단가</th>
						<th width="20mm" class="cell-r">정비시간</th>
						<th width="20mm" class="cell-r">부품비</th>
						<th width="20mm" class="cell-r">합계</th>
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
								<%=item.getItemNmKor()%>
						</td>
						<td class="cell-r"><input type="text" name="txtCnt"
							style="text-align: right" onchange="setSelectResult();"
							onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" />
						</td>
						<td class="cell-r"><input type="text" name="txtPrice"
							style="border: 0px; text-align: right;" value='<%= MrUtil.FormatCurrent(item.getPriceCenter()) %>'
							disabled />
						</td>
						<td class="cell-r"><input type="text" name="txtServiceTime"
							style="border: 0px; text-align: right;" value='<%=item.getServiceHour()%>'
							disabled />
						</td>
						<td class="cell-r"><input type="text" name="txtItemSum"
							style="border: 0px; text-align: right;" value='<%=0%>'
							disabled />
						</td>
						<td class="cell-r"><input type="text" name="txtSubSum"
							style="border: 0px; text-align: right;" value='<%=0%>'
							disabled />
						</td>
					</tr>

					<%
						}
					%>

				</tbody>
			</table>

			<table width="200" height="50" border="0">
			<tr>
				<td align="right" width="100">subtotal :</td>
				<td id="tdSubtotal" align="right"></td>
			</tr>
			<tr>
				<td align="right">tax :</td>
				<td id="tdTax" align="right"></td>
			</tr>
			<tr>
				<td align="right">total price :</td>
				<td id="tdTotalAmt" align="right"></td>
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
     					<input type="submit" class="myButton" value="등록">&nbsp;
     				<% }else{ %>
     					<input type="submit" class="myButton" value="수정">&nbsp;
     					<input type="button" class="myButton" value="삭제" onclick="confirmDelete();">&nbsp;
     				<% } %>
         				<input type="button" class="myButton" value="목록" onclick="moveTo('soList.jsp?pg=<%=pg %>');">
         			</div>
     			</td>
    		</tr>
		</table>    		 
	</form> 
<script>
	setPage();
	setSelectResult();
</script>

</center>
</body>


</html>